defmodule RyujinCore.Packets.PacketCheckNameReply do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketCheckNameReply`\n\n**Source**: `../legacy/src/Sanctuary.Packet/ExternalLogin/PacketCheckNameReply.cs`\n\n**OpCodes**: %{main_opcode: 211}\n"
  use RyujinCore.Packet
  defstruct [:result]
  @type t :: %__MODULE__{result: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end