defmodule RyujinCore.Packets.EncounterOverworldCombatPacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.EncounterOverworldCombatPacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseEncounterPacket/EncounterOverworldCombatPacket.cs`\n\n**OpCodes**: %{main_opcode: 132}\n"
  use RyujinCore.Packet
  defstruct [:unknown3]
  @type t :: %__MODULE__{unknown3: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end