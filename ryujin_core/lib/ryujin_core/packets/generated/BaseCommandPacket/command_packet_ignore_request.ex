defmodule RyujinCore.Packets.CommandPacketIgnoreRequest do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CommandPacketIgnoreRequest`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseCommandPacket/CommandPacketIgnoreRequest.cs`\n\n**OpCodes**: %{main_opcode: 30}\n"
  use RyujinCore.Packet
  defstruct [:ignore]
  @type t :: %__MODULE__{ignore: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end