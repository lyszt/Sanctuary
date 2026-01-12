defmodule Mix.Tasks.Ryujin.Gen.Packet do
  @moduledoc """
  Generates Elixir packet modules from C# packet definitions.

  ## Examples

      # Generate from C# file
      mix ryujin.gen.packet --source legacy/src/Sanctuary.Packet/PacketChat.cs

      # Generate all packets in directory
      mix ryujin.gen.packet --source-dir legacy/src/Sanctuary.Packet

      # Specify output directory
      mix ryujin.gen.packet --source PacketChat.cs --output lib/ryujin_core/packets/custom/
  """

  use Mix.Task

  @shortdoc "Generates Elixir packet modules from C# source"

  @switches [
    source: :string,
    source_dir: :string,
    output: :string,
    dry_run: :boolean
  ]

  @aliases [
    s: :source,
    d: :source_dir,
    o: :output
  ]

  @impl Mix.Task
  def run(args) do
    {opts, _} = OptionParser.parse!(args, strict: @switches, aliases: @aliases)

    cond do
      opts[:source] ->
        generate_from_file(opts[:source], opts[:output], opts[:dry_run])

      opts[:source_dir] ->
        generate_from_directory(opts[:source_dir], opts[:output], opts[:dry_run])

      true ->
        Mix.shell().error("Must specify --source or --source-dir")
        Mix.shell().info("Run `mix help ryujin.gen.packet` for usage")
    end
  end

  defp generate_from_file(source_path, output_dir, dry_run) do
    case File.read(source_path) do
      {:ok, content} ->
        packet_info = parse_csharp_packet(content, source_path)
        elixir_code = generate_elixir_packet(packet_info)

        output_path = output_dir || default_output_path(packet_info)
        write_output(output_path, elixir_code, dry_run)

      {:error, reason} ->
        Mix.shell().error("Failed to read #{source_path}: #{inspect(reason)}")
    end
  end

  defp generate_from_directory(source_dir, output_dir, dry_run) do
    source_dir
    |> Path.join("**/*.cs")
    |> Path.wildcard()
    |> Enum.each(fn file ->
      Mix.shell().info("Processing #{file}...")
      generate_from_file(file, output_dir, dry_run)
    end)
  end

  defp parse_csharp_packet(content, source_path) do
    # Extract class name
    class_name = Regex.run(~r/class\s+(\w+)/, content) |> extract_name()

    # Extract namespace
    namespace = Regex.run(~r/namespace\s+([\w.]+)/, content) |> extract_name()

    # Extract fields
    fields = parse_fields(content)

    # Extract docs
    docs = extract_documentation(content)

    %{
      name: class_name,
      namespace: namespace,
      fields: fields,
      docs: docs,
      source_path: source_path
    }
  end

  defp parse_fields(content) do
    # Match C# property declarations
    ~r/public\s+(\w+(?:<.*?>)?)\s+(\w+)\s*\{\s*get;\s*set;\s*\}/
    |> Regex.scan(content)
    |> Enum.map(fn [_, type, name] ->
      %{
        name: name,
        type: map_csharp_type_to_elixir(type),
        csharp_type: type
      }
    end)
  end

  defp map_csharp_type_to_elixir(csharp_type) do
    case csharp_type do
      "byte" -> :integer
      "short" -> :integer
      "ushort" -> :integer
      "int" -> :integer
      "uint" -> :integer
      "long" -> :integer
      "ulong" -> :integer
      "float" -> :float
      "double" -> :float
      "bool" -> :boolean
      "string" -> :string
      "Guid" -> :binary_id
      "byte[]" -> :binary
      "List<" <> _ -> :list
      "Dictionary<" <> _ -> :map
      _ -> :term
    end
  end

  defp extract_documentation(content) do
    # Extract XML documentation comments
    case Regex.run(~r/\/\/\/\s*<summary>(.*?)<\/summary>/s, content) do
      [_, doc] -> String.trim(doc)
      nil -> ""
    end
  end

  defp extract_name([_, name]), do: name
  defp extract_name(_), do: "Unknown"

  defp generate_elixir_packet(packet_info) do
    """
    defmodule RyujinCore.Packets.#{packet_info.name} do
      @moduledoc \"\"\"
      #{packet_info.docs}

      **Ported from C#**: `#{packet_info.namespace}.#{packet_info.name}`

      **Source**: `#{packet_info.source_path}`
      \"\"\"
      use RyujinCore.Packet

      defstruct [#{generate_struct_fields(packet_info.fields)}]

      @type t :: %__MODULE__{
    #{generate_type_spec(packet_info.fields)}
      }

      @impl true
      def serialize(%__MODULE__{} = packet) do
        # TODO: Implement serialization
        # Refer to C# source for binary format
        raise "serialize/1 not yet implemented for #{__MODULE__}"
      end

      @impl true
      def deserialize(data) do
        # TODO: Implement deserialization
        # Refer to C# source for binary format
        {:error, :not_implemented}
      end
    end
    """
  end

  defp generate_struct_fields(fields) do
    fields
    |> Enum.map(fn field -> ":#{Macro.underscore(field.name)}" end)
    |> Enum.join(", ")
  end

  defp generate_type_spec(fields) do
    fields
    |> Enum.map(fn field ->
      elixir_name = Macro.underscore(field.name)
      elixir_type = type_to_spec(field.type)
      "        #{elixir_name}: #{elixir_type}"
    end)
    |> Enum.join(",\n")
  end

  defp type_to_spec(:integer), do: "non_neg_integer()"
  defp type_to_spec(:float), do: "float()"
  defp type_to_spec(:boolean), do: "boolean()"
  defp type_to_spec(:string), do: "String.t()"
  defp type_to_spec(:binary), do: "binary()"
  defp type_to_spec(:binary_id), do: "binary()"
  defp type_to_spec(:list), do: "list()"
  defp type_to_spec(:map), do: "map()"
  defp type_to_spec(:term), do: "term()"

  defp default_output_path(packet_info) do
    filename =
      packet_info.name
      |> Macro.underscore()
      |> Kernel.<>(".ex")

    Path.join(["lib", "ryujin_core", "packets", "generated", filename])
  end

  defp write_output(output_path, content, dry_run) do
    if dry_run do
      Mix.shell().info("\n--- Generated Code (dry run) ---")
      Mix.shell().info(content)
      Mix.shell().info("--- Would write to: #{output_path} ---\n")
    else
      output_path
      |> Path.dirname()
      |> File.mkdir_p!()

      File.write!(output_path, content)
      Mix.shell().info("Generated #{output_path}")
    end
  end
end
