defmodule RyujinCore.Packets.AbilityPacketFailed do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.AbilityPacketFailed`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseAbilityPacket/AbilityPacketFailed.cs`\n\n**OpCodes**: %{main_opcode: 1}\n"
  use RyujinCore.Packet
  defstruct [:string_id]
  @type t :: %__MODULE__{string_id: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end