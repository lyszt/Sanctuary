defmodule RyujinCore.Packets.HousingPacketInstanceList do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.HousingPacketInstanceList`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseHousingPacket/HousingPacketInstanceList.cs`\n\n**OpCodes**: %{main_opcode: 39}\n"
  use RyujinCore.Packet
  defstruct [:player_guid]
  @type t :: %__MODULE__{player_guid: term()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end