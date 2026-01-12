defmodule RyujinCore.Packets.InventoryPacketUseStyleCard do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.InventoryPacketUseStyleCard`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseInventoryPacket/InventoryPacketUseStyleCard.cs`\n\n**OpCodes**: %{main_opcode: 10}\n"
  use RyujinCore.Packet
  defstruct [:item_guid]
  @type t :: %__MODULE__{item_guid: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end