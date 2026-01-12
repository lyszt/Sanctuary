defmodule RyujinCore.Packets.NameChangeResponsePacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.NameChangeResponsePacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseNameChangePacket/NameChangeResponsePacket.cs`\n\n**OpCodes**: %{main_opcode: 4}\n"
  use RyujinCore.Packet
  defstruct [:type, :guid, :result]
  @type t :: %__MODULE__{type: term(), guid: term(), result: term()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end