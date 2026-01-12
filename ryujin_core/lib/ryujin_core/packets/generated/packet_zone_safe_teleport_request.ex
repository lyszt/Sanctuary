defmodule RyujinCore.Packets.PacketZoneSafeTeleportRequest do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketZoneSafeTeleportRequest`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketZoneSafeTeleportRequest.cs`\n\n**OpCodes**: %{main_opcode: 122}\n"
  use RyujinCore.Packet
  defstruct [:id]
  @type t :: %__MODULE__{id: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end