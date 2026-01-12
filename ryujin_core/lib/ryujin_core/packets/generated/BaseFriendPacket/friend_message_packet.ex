defmodule RyujinCore.Packets.FriendMessagePacket do
  @moduledoc "/// Used by <see cref=\"FriendMessageType.FriendNameChanged\"/> ///\n\n**Auto-generated from C#**: `Sanctuary.Packet.FriendMessagePacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseFriendPacket/FriendMessagePacket.cs`\n\n**OpCodes**: %{main_opcode: 8}\n"
  use RyujinCore.Packet
  defstruct [:type, :guid]
  @type t :: %__MODULE__{type: term(), guid: term()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end