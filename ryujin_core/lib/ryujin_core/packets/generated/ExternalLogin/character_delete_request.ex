defmodule RyujinCore.Packets.CharacterDeleteRequest do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CharacterDeleteRequest`\n\n**Source**: `../legacy/src/Sanctuary.Packet/ExternalLogin/CharacterDeleteRequest.cs`\n\n**OpCodes**: %{main_opcode: 9}\n"
  use RyujinCore.Packet
  defstruct [:entity_key]
  @type t :: %__MODULE__{entity_key: term()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end