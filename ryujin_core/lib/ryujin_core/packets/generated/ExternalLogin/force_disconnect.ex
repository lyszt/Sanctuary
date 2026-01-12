defmodule RyujinCore.Packets.ForceDisconnect do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.ForceDisconnect`\n\n**Source**: `../legacy/src/Sanctuary.Packet/ExternalLogin/ForceDisconnect.cs`\n\n**OpCodes**: %{main_opcode: 4}\n"
  use RyujinCore.Packet
  defstruct [:reason]
  @type t :: %__MODULE__{reason: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end