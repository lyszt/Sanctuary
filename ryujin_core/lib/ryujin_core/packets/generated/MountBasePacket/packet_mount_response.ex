defmodule RyujinCore.Packets.PacketMountResponse do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketMountResponse`\n\n**Source**: `../legacy/src/Sanctuary.Packet/MountBasePacket/PacketMountResponse.cs`\n\n**OpCodes**: %{main_opcode: 2}\n"
  use RyujinCore.Packet

  defstruct [
    :rider_guid,
    :mount_guid,
    :seat,
    :queue_position,
    :unknown,
    :composite_effect_id,
    :name_vertical_offset
  ]

  @type t :: %__MODULE__{
          rider_guid: term(),
          mount_guid: term(),
          seat: integer(),
          queue_position: integer(),
          unknown: integer(),
          composite_effect_id: integer(),
          name_vertical_offset: float()
        }
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end