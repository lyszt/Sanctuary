defmodule RyujinCore.Packets.CommandPacketConfirmFriendResponse do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CommandPacketConfirmFriendResponse`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseCommandPacket/CommandPacketConfirmFriendResponse.cs`\n\n**OpCodes**: %{main_opcode: 17}\n"
  use RyujinCore.Packet
  defstruct [:guid, :status]
  @type t :: %__MODULE__{guid: term(), status: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end