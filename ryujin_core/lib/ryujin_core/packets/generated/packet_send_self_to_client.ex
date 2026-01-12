defmodule RyujinCore.Packets.PacketSendSelfToClient do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketSendSelfToClient`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketSendSelfToClient.cs`\n\n**OpCodes**: %{main_opcode: 12}\n"
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