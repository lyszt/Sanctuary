defmodule RyujinCore.Packets.QuickChatSendChatToChannelPacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.QuickChatSendChatToChannelPacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseQuickChatPacket/QuickChatSendChatToChannelPacket.cs`\n\n**OpCodes**: %{main_opcode: 3}\n"
  use RyujinCore.Packet
  defstruct [:channel, :area_name_id, :guild_guid]
  @type t :: %__MODULE__{channel: term(), area_name_id: integer(), guild_guid: term()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end