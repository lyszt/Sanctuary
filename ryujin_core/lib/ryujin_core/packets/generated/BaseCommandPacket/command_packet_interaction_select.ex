defmodule RyujinCore.Packets.CommandPacketInteractionSelect do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CommandPacketInteractionSelect`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseCommandPacket/CommandPacketInteractionSelect.cs`\n\n**OpCodes**: %{main_opcode: 10}\n"
  use RyujinCore.Packet
  defstruct [:guid, :id]
  @type t :: %__MODULE__{guid: term(), id: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end