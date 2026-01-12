defmodule RyujinCore.Packets.ClientUpdatePacketHitpoints do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.ClientUpdatePacketHitpoints`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseClientUpdatePacket/ClientUpdatePacketHitpoints.cs`\n\n**OpCodes**: %{main_opcode: 1}\n"
  use RyujinCore.Packet
  defstruct [:current_hitpoints, :max_hitpoints]
  @type t :: %__MODULE__{current_hitpoints: integer(), max_hitpoints: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end