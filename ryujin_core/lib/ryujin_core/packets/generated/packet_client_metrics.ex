defmodule RyujinCore.Packets.PacketClientMetrics do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketClientMetrics`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketClientMetrics.cs`\n\n**OpCodes**: %{main_opcode: 105}\n"
  use RyujinCore.Packet
  defstruct []
  @type t :: %__MODULE__{}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end