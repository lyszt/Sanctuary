defmodule RyujinCore.Packets.CheckNameResponsePacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CheckNameResponsePacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseNameChangePacket/CheckNameResponsePacket.cs`\n\n**OpCodes**: %{main_opcode: 2}\n"
  use RyujinCore.Packet
  defstruct [:result, :type, :guid]
  @type t :: %__MODULE__{result: term(), type: term(), guid: term()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end