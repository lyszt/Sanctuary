defmodule RyujinCore.Packets.PacketMountSpawnByItemDefinitionId do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketMountSpawnByItemDefinitionId`\n\n**Source**: `../legacy/src/Sanctuary.Packet/MountBasePacket/PacketMountSpawnByItemDefinitionId.cs`\n\n**OpCodes**: %{main_opcode: 8}\n"
  use RyujinCore.Packet
  defstruct [:item_definition_id, :unknown]
  @type t :: %__MODULE__{item_definition_id: integer(), unknown: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end