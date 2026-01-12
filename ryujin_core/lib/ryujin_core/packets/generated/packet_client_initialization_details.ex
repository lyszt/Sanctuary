defmodule RyujinCore.Packets.PacketClientInitializationDetails do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketClientInitializationDetails`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketClientInitializationDetails.cs`\n\n**OpCodes**: %{main_opcode: 169}\n"
  use RyujinCore.Packet
  defstruct [:timezone_offset]
  @type t :: %__MODULE__{timezone_offset: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end