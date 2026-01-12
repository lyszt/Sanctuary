defmodule RyujinCore.Packets.CommandPacketChatChannelOff do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CommandPacketChatChannelOff`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseCommandPacket/CommandPacketChatChannelOff.cs`\n\n**OpCodes**: %{main_opcode: 33}\n"
  use RyujinCore.Packet
  defstruct []
  @type t :: %__MODULE__{}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end