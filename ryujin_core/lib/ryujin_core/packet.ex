defmodule RyujinCore.Packet do
  @moduledoc """
  Behaviour and utilities for binary packet serialization/deserialization.

  This module provides a DSL for defining game protocol packets with automatic
  binary pattern matching for parsing and serialization.

  ## Example

      defmodule MyPacket do
        use RyujinCore.Packet

        defstruct [:field1, :field2]

        @impl true
        def serialize(%__MODULE__{field1: f1, field2: f2}) do
          <<f1::32-little, f2::16-little>>
        end

        @impl true
        def deserialize(<<f1::32-little, f2::16-little, rest::binary>>) do
          {:ok, %__MODULE__{field1: f1, field2: f2}, rest}
        end
      end
  """

  @doc """
  Serializes a packet struct into binary data.
  """
  @callback serialize(packet :: struct()) :: binary()

  @doc """
  Deserializes binary data into a packet struct.
  Returns {:ok, packet, rest} on success, or {:error, reason} on failure.
  """
  @callback deserialize(data :: binary()) ::
    {:ok, struct(), binary()} | {:error, term()}

  @doc false
  defmacro __using__(_opts) do
    quote do
      @behaviour RyujinCore.Packet

      @doc """
      Serializes this packet to binary format.
      """
      def serialize(_packet) do
        raise "serialize/1 not implemented for #{__MODULE__}"
      end

      @doc """
      Deserializes binary data into this packet type.
      """
      def deserialize(_data) do
        {:error, :not_implemented}
      end

      defoverridable serialize: 1, deserialize: 1
    end
  end

  @doc """
  Helper to read a length-prefixed string (uint16 length + string bytes).
  """
  def read_string(<<len::16-little, string::binary-size(len), rest::binary>>) do
    {:ok, string, rest}
  end
  def read_string(_), do: {:error, :invalid_string}

  @doc """
  Helper to write a length-prefixed string.
  """
  def write_string(string) when is_binary(string) do
    len = byte_size(string)
    <<len::16-little, string::binary>>
  end

  @doc """
  Helper to read a length-prefixed list of items.
  """
  def read_list(data, count, parser_fn) do
    read_list_acc(data, count, parser_fn, [])
  end

  defp read_list_acc(rest, 0, _parser_fn, acc) do
    {:ok, Enum.reverse(acc), rest}
  end

  defp read_list_acc(data, count, parser_fn, acc) do
    case parser_fn.(data) do
      {:ok, item, rest} -> read_list_acc(rest, count - 1, parser_fn, [item | acc])
      error -> error
    end
  end

  @doc """
  Reads a uint32 length prefix followed by items.
  """
  def read_length_prefixed_list(<<count::32-little, rest::binary>>, parser_fn) do
    read_list(rest, count, parser_fn)
  end
  def read_length_prefixed_list(_, _), do: {:error, :invalid_list_count}
end
