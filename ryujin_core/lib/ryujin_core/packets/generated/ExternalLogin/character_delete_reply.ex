defmodule RyujinCore.Packets.CharacterDeleteReply do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CharacterDeleteReply`\n\n**Source**: `../legacy/src/Sanctuary.Packet/ExternalLogin/CharacterDeleteReply.cs`\n\n**OpCodes**: %{main_opcode: 10}\n"
  use RyujinCore.Packet
  defstruct [:entity_key, :status]
  @type t :: %__MODULE__{entity_key: term(), status: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end