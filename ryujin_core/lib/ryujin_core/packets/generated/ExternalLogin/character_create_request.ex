defmodule RyujinCore.Packets.CharacterCreateRequest do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CharacterCreateRequest`\n\n**Source**: `../legacy/src/Sanctuary.Packet/ExternalLogin/CharacterCreateRequest.cs`\n\n**OpCodes**: %{main_opcode: 5}\n"
  use RyujinCore.Packet
  defstruct [:server_id]
  @type t :: %__MODULE__{server_id: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end