defmodule RyujinCore.Packets.PlayerUpdatePacketCameraUpdate do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PlayerUpdatePacketCameraUpdate`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PlayerUpdatePacketCameraUpdate.cs`\n\n**OpCodes**: %{main_opcode: 126}\n"
  use RyujinCore.Packet
  defstruct [:position, :rotation]
  @type t :: %__MODULE__{position: term(), rotation: term()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end