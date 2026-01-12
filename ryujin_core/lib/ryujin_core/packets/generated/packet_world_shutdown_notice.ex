defmodule RyujinCore.Packets.PacketWorldShutdownNotice do
  @moduledoc "/// Time remaining in seconds. ///\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketWorldShutdownNotice`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketWorldShutdownNotice.cs`\n\n**OpCodes**: %{main_opcode: 92}\n"
  use RyujinCore.Packet
  defstruct [:time_remaining, :reason_id]
  @type t :: %__MODULE__{time_remaining: integer(), reason_id: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end