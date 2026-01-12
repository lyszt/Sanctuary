defmodule RyujinCore.Packets.InventoryPacketUseStyleCardByItemRecord do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.InventoryPacketUseStyleCardByItemRecord`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseInventoryPacket/InventoryPacketUseStyleCardByItemRecord.cs`\n\n**OpCodes**: %{main_opcode: 12}\n"
  use RyujinCore.Packet
  defstruct [:item_definition_id]
  @type t :: %__MODULE__{item_definition_id: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end