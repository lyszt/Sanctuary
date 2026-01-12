defmodule RyujinCore.Packets.CommandPacketInteractionList do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CommandPacketInteractionList`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseCommandPacket/CommandPacketInteractionList.cs`\n\n**OpCodes**: %{main_opcode: 9}\n"
  use RyujinCore.Packet
  defstruct [:unknown]
  @type t :: %__MODULE__{unknown: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end