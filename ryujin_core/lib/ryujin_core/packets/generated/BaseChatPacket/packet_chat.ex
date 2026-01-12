defmodule RyujinCore.Packets.PacketChat do
  @moduledoc "/// Only needed for <see cref=\"ChatChannel.WorldArea\"/>. ///\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketChat`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseChatPacket/PacketChat.cs`\n\n**OpCodes**: %{main_opcode: 1}\n"
  use RyujinCore.Packet
  defstruct [:channel, :from_guid, :to_guid, :position, :guild_guid, :language_id, :area_name_id]

  @type t :: %__MODULE__{
          channel: term(),
          from_guid: term(),
          to_guid: term(),
          position: term(),
          guild_guid: term(),
          language_id: integer(),
          area_name_id: integer()
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