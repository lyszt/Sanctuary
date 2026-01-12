defmodule RyujinCore.Packets.CharacterCreateReply do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CharacterCreateReply`\n\n**Source**: `../legacy/src/Sanctuary.Packet/ExternalLogin/CharacterCreateReply.cs`\n\n**OpCodes**: %{main_opcode: 6}\n"
  use RyujinCore.Packet
  defstruct [:result, :guid]
  @type t :: %__MODULE__{result: integer(), guid: term()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end