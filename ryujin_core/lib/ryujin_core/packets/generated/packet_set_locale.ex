defmodule RyujinCore.Packets.PacketSetLocale do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketSetLocale`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketSetLocale.cs`\n\n**OpCodes**: %{main_opcode: 88}\n"
  use RyujinCore.Packet
  defstruct []
  @type t :: %__MODULE__{}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end