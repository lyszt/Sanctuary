defmodule RyujinCore.Packets.CharacterLoginReply do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CharacterLoginReply`\n\n**Source**: `../legacy/src/Sanctuary.Packet/ExternalLogin/CharacterLoginReply.cs`\n\n**OpCodes**: %{main_opcode: 8}\n"
  use RyujinCore.Packet
  defstruct [:entity_key, :server_id, :status]
  @type t :: %__MODULE__{entity_key: term(), server_id: integer(), status: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end