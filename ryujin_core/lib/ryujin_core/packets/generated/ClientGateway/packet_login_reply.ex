defmodule RyujinCore.Packets.PacketLoginReply do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketLoginReply`\n\n**Source**: `../legacy/src/Sanctuary.Packet/ClientGateway/PacketLoginReply.cs`\n\n**OpCodes**: %{main_opcode: 2}\n"
  use RyujinCore.Packet
  defstruct [:success]
  @type t :: %__MODULE__{success: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end