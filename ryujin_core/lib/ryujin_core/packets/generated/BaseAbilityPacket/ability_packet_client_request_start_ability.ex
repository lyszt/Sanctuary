defmodule RyujinCore.Packets.AbilityPacketClientRequestStartAbility do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.AbilityPacketClientRequestStartAbility`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseAbilityPacket/AbilityPacketClientRequestStartAbility.cs`\n\n**OpCodes**: %{main_opcode: 10}\n"
  use RyujinCore.Packet
  defstruct [:guid, :target, :position]
  @type t :: %__MODULE__{guid: term(), target: integer(), position: term()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end