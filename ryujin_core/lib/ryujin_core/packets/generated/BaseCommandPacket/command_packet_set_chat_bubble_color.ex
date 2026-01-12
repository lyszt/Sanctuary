defmodule RyujinCore.Packets.CommandPacketSetChatBubbleColor do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CommandPacketSetChatBubbleColor`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseCommandPacket/CommandPacketSetChatBubbleColor.cs`\n\n**OpCodes**: %{main_opcode: 18}\n"
  use RyujinCore.Packet

  defstruct [
    :chat_bubble_foreground_color,
    :chat_bubble_background_color,
    :chat_bubble_size,
    :guid
  ]

  @type t :: %__MODULE__{
          chat_bubble_foreground_color: integer(),
          chat_bubble_background_color: integer(),
          chat_bubble_size: integer(),
          guid: term()
        }
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end