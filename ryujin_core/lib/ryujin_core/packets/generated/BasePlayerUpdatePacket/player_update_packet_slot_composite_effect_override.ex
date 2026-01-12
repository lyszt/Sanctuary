defmodule RyujinCore.Packets.PlayerUpdatePacketSlotCompositeEffectOverride do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PlayerUpdatePacketSlotCompositeEffectOverride`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BasePlayerUpdatePacket/PlayerUpdatePacketSlotCompositeEffectOverride.cs`\n\n**OpCodes**: %{main_opcode: 31}\n"
  use RyujinCore.Packet
  defstruct [:guid, :slot, :composite_effect]
  @type t :: %__MODULE__{guid: term(), slot: integer(), composite_effect: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end