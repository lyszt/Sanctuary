defmodule RyujinCore.Packets.FriendOnlinePacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.FriendOnlinePacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseFriendPacket/FriendOnlinePacket.cs`\n\n**OpCodes**: %{main_opcode: 2}\n"
  use RyujinCore.Packet
  defstruct [:guid, :is_local]
  @type t :: %__MODULE__{guid: term(), is_local: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end