defmodule RyujinCore.Packets.ClientUpdatePacketMana do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.ClientUpdatePacketMana`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseClientUpdatePacket/ClientUpdatePacketMana.cs`\n\n**OpCodes**: %{main_opcode: 13}\n"
  use RyujinCore.Packet
  defstruct [:current_mana, :max_mana, :show_over_head]
  @type t :: %__MODULE__{current_mana: integer(), max_mana: integer(), show_over_head: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end