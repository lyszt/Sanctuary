defmodule RyujinCore.Packets.InventoryPacketEquipByGuid do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.InventoryPacketEquipByGuid`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseInventoryPacket/InventoryPacketEquipByGuid.cs`\n\n**OpCodes**: %{main_opcode: 3}\n"
  use RyujinCore.Packet
  defstruct [:guid, :profile_id, :slot]
  @type t :: %__MODULE__{guid: integer(), profile_id: integer(), slot: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end