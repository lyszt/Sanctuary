defmodule RyujinCore.Packets.IgnoreRemovePacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.IgnoreRemovePacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseIgnorePacket/IgnoreRemovePacket.cs`\n\n**OpCodes**: %{main_opcode: 3}\n"
  use RyujinCore.Packet
  defstruct [:guid]
  @type t :: %__MODULE__{guid: term()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end