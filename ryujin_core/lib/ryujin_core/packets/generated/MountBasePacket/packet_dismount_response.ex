defmodule RyujinCore.Packets.PacketDismountResponse do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketDismountResponse`\n\n**Source**: `../legacy/src/Sanctuary.Packet/MountBasePacket/PacketDismountResponse.cs`\n\n**OpCodes**: %{main_opcode: 4}\n"
  use RyujinCore.Packet
  defstruct [:rider_guid, :composite_effect_id]
  @type t :: %__MODULE__{rider_guid: term(), composite_effect_id: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end