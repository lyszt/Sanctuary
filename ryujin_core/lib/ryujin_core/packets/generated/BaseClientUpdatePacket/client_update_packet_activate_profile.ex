defmodule RyujinCore.Packets.ClientUpdatePacketActivateProfile do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.ClientUpdatePacketActivateProfile`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseClientUpdatePacket/ClientUpdatePacketActivateProfile.cs`\n\n**OpCodes**: %{main_opcode: 21}\n"
  use RyujinCore.Packet
  defstruct [:animation, :composite_effect]
  @type t :: %__MODULE__{animation: integer(), composite_effect: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end