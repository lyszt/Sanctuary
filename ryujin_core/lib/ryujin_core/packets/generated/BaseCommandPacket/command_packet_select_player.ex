defmodule RyujinCore.Packets.CommandPacketSelectPlayer do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CommandPacketSelectPlayer`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseCommandPacket/CommandPacketSelectPlayer.cs`\n\n**OpCodes**: %{main_opcode: 19}\n"
  use RyujinCore.Packet
  defstruct [:guid, :select_guid]
  @type t :: %__MODULE__{guid: term(), select_guid: term()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end