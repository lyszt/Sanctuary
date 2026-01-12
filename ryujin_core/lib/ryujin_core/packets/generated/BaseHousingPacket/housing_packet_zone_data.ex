defmodule RyujinCore.Packets.HousingPacketZoneData do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.HousingPacketZoneData`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseHousingPacket/HousingPacketZoneData.cs`\n\n**OpCodes**: %{main_opcode: 45}\n"
  use RyujinCore.Packet
  defstruct [:is_preview, :head_size]
  @type t :: %__MODULE__{is_preview: boolean(), head_size: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end