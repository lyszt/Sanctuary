defmodule RyujinCore.Packets.QuickChatSendChatPacketBase do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.QuickChatSendChatPacketBase`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseQuickChatPacket/QuickChatSendChatPacketBase.cs`\n\n\n"
  use RyujinCore.Packet
  defstruct [:id, :guid]
  @type t :: %__MODULE__{id: integer(), guid: term()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end