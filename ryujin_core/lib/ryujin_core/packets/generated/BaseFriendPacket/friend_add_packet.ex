defmodule RyujinCore.Packets.FriendAddPacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.FriendAddPacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseFriendPacket/FriendAddPacket.cs`\n\n**OpCodes**: %{main_opcode: 6}\n"
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