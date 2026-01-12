defmodule RyujinCore.PacketDSL do
  @moduledoc """
  Macro-based DSL for defining packets that look similar to C#.

  This allows you to write packet definitions in a C#-like syntax
  and automatically generates Elixir code with serialization/deserialization.

  ## Example

      defmodule MyPacket do
        use RyujinCore.PacketDSL

        packet do
          field :session_id, :uint32
          field :username, :string
          field :level, :uint16
          field :position, :vector4
          field :items, {:list, :uint32}
        end
      end

  This generates:
  - Struct with all fields
  - `serialize/1` function
  - `deserialize/1` function
  - Type specs
  - Documentation

  ## Supported Types

  - `:uint8`, `:int8` - 8-bit integers
  - `:uint16`, `:int16` - 16-bit integers
  - `:uint32`, `:int32` - 32-bit integers
  - `:uint64`, `:int64` - 64-bit integers
  - `:float32`, `:float64` - Floating point
  - `:boolean` - Boolean (1 byte)
  - `:string` - Length-prefixed string
  - `:binary` - Raw binary data
  - `:guid` - 16-byte GUID
  - `:vector4` - 4 floats (x, y, z, w)
  - `:quaternion` - 4 floats (x, y, z, w)
  - `{:list, type}` - Length-prefixed list
  - `{:array, type, size}` - Fixed-size array
  - `{:optional, type}` - Optional field (nil allowed)
  """

  defmacro __using__(_opts) do
    quote do
      import RyujinCore.PacketDSL
      use RyujinCore.Packet

      Module.register_attribute(__MODULE__, :packet_fields, accumulate: true)
    end
  end

  @doc """
  Define a packet with fields.
  """
  defmacro packet(do: block) do
    quote do
      unquote(block)

      @packet_fields Enum.reverse(@packet_fields)

      # Generate struct
      defstruct Enum.map(@packet_fields, fn {name, _type, _opts} -> name end)

      # Generate type spec
      @type t :: %__MODULE__{
        unquote_splicing(
          Enum.map(@packet_fields, fn {name, type, _opts} ->
            {name, RyujinCore.PacketDSL.type_to_spec(type)}
          end)
        )
      }

      # Generate serialize
      @impl true
      def serialize(%__MODULE__{} = packet) do
        RyujinCore.PacketDSL.generate_serialize(packet, @packet_fields)
      end

      # Generate deserialize
      @impl true
      def deserialize(data) do
        RyujinCore.PacketDSL.generate_deserialize(data, @packet_fields, __MODULE__)
      end
    end
  end

  @doc """
  Define a field in the packet.

  ## Options

  - `:default` - Default value
  - `:when` - Conditional serialization
  - `:doc` - Field documentation
  """
  defmacro field(name, type, opts \\ []) do
    quote do
      @packet_fields {unquote(name), unquote(type), unquote(opts)}
    end
  end

  ## Runtime Functions (called by generated code)

  @doc false
  def type_to_spec(:uint8), do: quote(do: non_neg_integer())
  def type_to_spec(:int8), do: quote(do: integer())
  def type_to_spec(:uint16), do: quote(do: non_neg_integer())
  def type_to_spec(:int16), do: quote(do: integer())
  def type_to_spec(:uint32), do: quote(do: non_neg_integer())
  def type_to_spec(:int32), do: quote(do: integer())
  def type_to_spec(:uint64), do: quote(do: non_neg_integer())
  def type_to_spec(:int64), do: quote(do: integer())
  def type_to_spec(:float32), do: quote(do: float())
  def type_to_spec(:float64), do: quote(do: float())
  def type_to_spec(:boolean), do: quote(do: boolean())
  def type_to_spec(:string), do: quote(do: String.t())
  def type_to_spec(:binary), do: quote(do: binary())
  def type_to_spec(:guid), do: quote(do: binary())
  def type_to_spec(:vector4), do: quote(do: {float(), float(), float(), float()})
  def type_to_spec(:quaternion), do: quote(do: {float(), float(), float(), float()})
  def type_to_spec({:list, _type}), do: quote(do: list())
  def type_to_spec({:optional, type}), do: quote(do: unquote(type_to_spec(type)) | nil)
  def type_to_spec(_), do: quote(do: term())

  @doc false
  def generate_serialize(packet, fields) do
    Enum.reduce(fields, <<>>, fn {name, type, opts}, acc ->
      value = Map.get(packet, name)

      # Check conditional
      if should_serialize?(value, opts) do
        serialized = serialize_field(value, type)
        <<acc::binary, serialized::binary>>
      else
        acc
      end
    end)
  end

  defp should_serialize?(_value, []), do: true
  defp should_serialize?(value, opts) do
    case Keyword.get(opts, :when) do
      nil -> true
      condition_fn -> condition_fn.(value)
    end
  end

  defp serialize_field(value, :uint8), do: <<value::8>>
  defp serialize_field(value, :int8), do: <<value::signed-8>>
  defp serialize_field(value, :uint16), do: <<value::16-little>>
  defp serialize_field(value, :int16), do: <<value::signed-16-little>>
  defp serialize_field(value, :uint32), do: <<value::32-little>>
  defp serialize_field(value, :int32), do: <<value::signed-32-little>>
  defp serialize_field(value, :uint64), do: <<value::64-little>>
  defp serialize_field(value, :int64), do: <<value::signed-64-little>>
  defp serialize_field(value, :float32), do: <<value::float-32-little>>
  defp serialize_field(value, :float64), do: <<value::float-64-little>>
  defp serialize_field(true, :boolean), do: <<1::8>>
  defp serialize_field(false, :boolean), do: <<0::8>>
  defp serialize_field(value, :string), do: RyujinCore.Packet.write_string(value)
  defp serialize_field(value, :binary), do: value
  defp serialize_field(value, :guid), do: value

  defp serialize_field({x, y, z, w}, :vector4) do
    <<x::float-32-little, y::float-32-little, z::float-32-little, w::float-32-little>>
  end

  defp serialize_field({x, y, z, w}, :quaternion) do
    <<x::float-32-little, y::float-32-little, z::float-32-little, w::float-32-little>>
  end

  defp serialize_field(list, {:list, item_type}) when is_list(list) do
    count = length(list)
    items_binary = Enum.reduce(list, <<>>, fn item, acc ->
      item_binary = serialize_field(item, item_type)
      <<acc::binary, item_binary::binary>>
    end)
    <<count::32-little, items_binary::binary>>
  end

  defp serialize_field(nil, {:optional, _type}), do: <<0::8>>
  defp serialize_field(value, {:optional, type}) do
    <<1::8, serialize_field(value, type)::binary>>
  end

  @doc false
  def generate_deserialize(data, fields, module) do
    case deserialize_fields(data, fields, %{}) do
      {:ok, field_map, rest} ->
        struct = struct(module, field_map)
        {:ok, struct, rest}

      error ->
        error
    end
  end

  defp deserialize_fields(data, [], acc), do: {:ok, acc, data}

  defp deserialize_fields(data, [{name, type, _opts} | rest], acc) do
    case deserialize_field(data, type) do
      {:ok, value, remaining} ->
        deserialize_fields(remaining, rest, Map.put(acc, name, value))

      error ->
        error
    end
  end

  defp deserialize_field(<<value::8, rest::binary>>, :uint8), do: {:ok, value, rest}
  defp deserialize_field(<<value::signed-8, rest::binary>>, :int8), do: {:ok, value, rest}
  defp deserialize_field(<<value::16-little, rest::binary>>, :uint16), do: {:ok, value, rest}
  defp deserialize_field(<<value::signed-16-little, rest::binary>>, :int16), do: {:ok, value, rest}
  defp deserialize_field(<<value::32-little, rest::binary>>, :uint32), do: {:ok, value, rest}
  defp deserialize_field(<<value::signed-32-little, rest::binary>>, :int32), do: {:ok, value, rest}
  defp deserialize_field(<<value::64-little, rest::binary>>, :uint64), do: {:ok, value, rest}
  defp deserialize_field(<<value::signed-64-little, rest::binary>>, :int64), do: {:ok, value, rest}
  defp deserialize_field(<<value::float-32-little, rest::binary>>, :float32), do: {:ok, value, rest}
  defp deserialize_field(<<value::float-64-little, rest::binary>>, :float64), do: {:ok, value, rest}

  defp deserialize_field(<<1::8, rest::binary>>, :boolean), do: {:ok, true, rest}
  defp deserialize_field(<<0::8, rest::binary>>, :boolean), do: {:ok, false, rest}

  defp deserialize_field(data, :string) do
    RyujinCore.Packet.read_string(data)
  end

  defp deserialize_field(<<guid::binary-size(16), rest::binary>>, :guid) do
    {:ok, guid, rest}
  end

  defp deserialize_field(<<x::float-32-little, y::float-32-little, z::float-32-little, w::float-32-little, rest::binary>>, :vector4) do
    {:ok, {x, y, z, w}, rest}
  end

  defp deserialize_field(<<x::float-32-little, y::float-32-little, z::float-32-little, w::float-32-little, rest::binary>>, :quaternion) do
    {:ok, {x, y, z, w}, rest}
  end

  defp deserialize_field(<<count::32-little, rest::binary>>, {:list, item_type}) do
    deserialize_list(rest, item_type, count, [])
  end

  defp deserialize_field(<<0::8, rest::binary>>, {:optional, _type}) do
    {:ok, nil, rest}
  end

  defp deserialize_field(<<1::8, rest::binary>>, {:optional, type}) do
    deserialize_field(rest, type)
  end

  defp deserialize_field(_, _), do: {:error, :invalid_packet}

  defp deserialize_list(data, _item_type, 0, acc) do
    {:ok, Enum.reverse(acc), data}
  end

  defp deserialize_list(data, item_type, count, acc) do
    case deserialize_field(data, item_type) do
      {:ok, item, rest} ->
        deserialize_list(rest, item_type, count - 1, [item | acc])

      error ->
        error
    end
  end
end
