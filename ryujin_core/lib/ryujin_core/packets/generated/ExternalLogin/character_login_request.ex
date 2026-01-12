defmodule RyujinCore.Packets.CharacterLoginRequest do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CharacterLoginRequest`\n\n**Source**: `../legacy/src/Sanctuary.Packet/ExternalLogin/CharacterLoginRequest.cs`\n\n**OpCodes**: %{main_opcode: 7}\n"
  use RyujinCore.Packet
  defstruct [:entity_key, :server_id]
  @type t :: %__MODULE__{entity_key: term(), server_id: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end