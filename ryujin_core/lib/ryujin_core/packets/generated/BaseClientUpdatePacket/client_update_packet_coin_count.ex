defmodule RyujinCore.Packets.ClientUpdatePacketCoinCount do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.ClientUpdatePacketCoinCount`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseClientUpdatePacket/ClientUpdatePacketCoinCount.cs`\n\n**OpCodes**: %{main_opcode: 19}\n"
  use RyujinCore.Packet
  defstruct [:coins]
  @type t :: %__MODULE__{coins: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end