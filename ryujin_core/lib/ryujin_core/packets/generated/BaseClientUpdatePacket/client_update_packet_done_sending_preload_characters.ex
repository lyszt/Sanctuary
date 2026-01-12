defmodule RyujinCore.Packets.ClientUpdatePacketDoneSendingPreloadCharacters do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.ClientUpdatePacketDoneSendingPreloadCharacters`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseClientUpdatePacket/ClientUpdatePacketDoneSendingPreloadCharacters.cs`\n\n**OpCodes**: %{main_opcode: 26}\n"
  use RyujinCore.Packet
  defstruct [:preload]
  @type t :: %__MODULE__{preload: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end