defmodule RyujinCore.Packets.FriendOfflinePacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.FriendOfflinePacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseFriendPacket/FriendOfflinePacket.cs`\n\n**OpCodes**: %{main_opcode: 3}\n"
  use RyujinCore.Packet
  defstruct [:guid]
  @type t :: %__MODULE__{guid: term()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end