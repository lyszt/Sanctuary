defmodule RyujinCore.Packets.InventoryPacketEquipByItemRecord do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.InventoryPacketEquipByItemRecord`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseInventoryPacket/InventoryPacketEquipByItemRecord.cs`\n\n**OpCodes**: %{main_opcode: 8}\n"
  use RyujinCore.Packet
  defstruct [:profile_id, :slot]
  @type t :: %__MODULE__{profile_id: integer(), slot: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end