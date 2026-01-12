defmodule RyujinCore.Packets.CheckNamePacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CheckNamePacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseNameChangePacket/CheckNamePacket.cs`\n\n**OpCodes**: %{main_opcode: 1}\n"
  use RyujinCore.Packet
  defstruct [:type, :guid, :token]
  @type t :: %__MODULE__{type: term(), guid: term(), token: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end