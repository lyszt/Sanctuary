defmodule RyujinCore.Packets.ChatPacketFromStringId do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.ChatPacketFromStringId`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseChatPacket/ChatPacketFromStringId.cs`\n\n**OpCodes**: %{main_opcode: 4}\n"
  use RyujinCore.Packet

  defstruct [
    :speaker_guid,
    :string_id,
    :is_emote,
    :is_chat_logged,
    :has_color,
    :color_id,
    :owner_guid,
    :target_guid,
    :elapsed_time
  ]

  @type t :: %__MODULE__{
          speaker_guid: term(),
          string_id: integer(),
          is_emote: boolean(),
          is_chat_logged: boolean(),
          has_color: boolean(),
          color_id: integer(),
          owner_guid: term(),
          target_guid: term(),
          elapsed_time: integer()
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