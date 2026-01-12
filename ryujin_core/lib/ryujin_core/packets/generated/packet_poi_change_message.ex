defmodule RyujinCore.Packets.PacketPOIChangeMessage do
  @moduledoc "Unused\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketPOIChangeMessage`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketPOIChangeMessage.cs`\n\n**OpCodes**: %{main_opcode: 104}\n"
  use RyujinCore.Packet
  defstruct [:zone_id]
  @type t :: %__MODULE__{zone_id: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end