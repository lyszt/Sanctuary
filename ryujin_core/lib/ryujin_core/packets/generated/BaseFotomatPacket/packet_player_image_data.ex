defmodule RyujinCore.Packets.PacketPlayerImageData do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketPlayerImageData`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseFotomatPacket/PacketPlayerImageData.cs`\n\n**OpCodes**: %{main_opcode: 3}\n"
  use RyujinCore.Packet
  defstruct [:guid, :compressed]
  @type t :: %__MODULE__{guid: term(), compressed: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end