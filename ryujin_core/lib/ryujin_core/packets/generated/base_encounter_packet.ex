defmodule RyujinCore.Packets.BaseEncounterPacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.BaseEncounterPacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseEncounterPacket.cs`\n\n**OpCodes**: %{main_opcode: 41}\n"
  use RyujinCore.Packet
  defstruct [:sub_op_code, :unknown, :unknown2]
  @type t :: %__MODULE__{sub_op_code: term(), unknown: integer(), unknown2: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end