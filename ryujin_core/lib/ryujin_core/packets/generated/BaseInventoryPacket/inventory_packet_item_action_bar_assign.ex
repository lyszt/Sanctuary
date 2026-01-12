defmodule RyujinCore.Packets.InventoryPacketItemActionBarAssign do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.InventoryPacketItemActionBarAssign`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseInventoryPacket/InventoryPacketItemActionBarAssign.cs`\n\n**OpCodes**: %{main_opcode: 6}\n"
  use RyujinCore.Packet
  defstruct [:slot, :guid]
  @type t :: %__MODULE__{slot: integer(), guid: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end