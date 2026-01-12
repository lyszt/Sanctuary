defmodule RyujinCore.Packets.ClientUpdatePacketEquipItem do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.ClientUpdatePacketEquipItem`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseClientUpdatePacket/ClientUpdatePacketEquipItem.cs`\n\n**OpCodes**: %{main_opcode: 5}\n"
  use RyujinCore.Packet
  defstruct [:guid, :profile_id]
  @type t :: %__MODULE__{guid: integer(), profile_id: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end