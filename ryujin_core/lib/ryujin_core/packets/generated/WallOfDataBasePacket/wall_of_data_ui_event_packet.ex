defmodule RyujinCore.Packets.WallOfDataUIEventPacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.WallOfDataUIEventPacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/WallOfDataBasePacket/WallOfDataUIEventPacket.cs`\n\n**OpCodes**: %{main_opcode: 4}\n"
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