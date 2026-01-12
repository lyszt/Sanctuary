defmodule RyujinCore.Packets.InventoryPacketPreviewStyleCard do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.InventoryPacketPreviewStyleCard`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseInventoryPacket/InventoryPacketPreviewStyleCard.cs`\n\n**OpCodes**: %{main_opcode: 11}\n"
  use RyujinCore.Packet
  defstruct [:id]
  @type t :: %__MODULE__{id: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end