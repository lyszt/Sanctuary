defmodule RyujinCore.Packets.PacketSendZoneDetails do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketSendZoneDetails`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketSendZoneDetails.cs`\n\n**OpCodes**: %{main_opcode: 43}\n"
  use RyujinCore.Packet

  defstruct [
    :tutorial,
    :unknown2,
    :is_in_arena,
    :id,
    :geometry_id,
    :is_in_starting_social_zone,
    :unknown6
  ]

  @type t :: %__MODULE__{
          tutorial: boolean(),
          unknown2: boolean(),
          is_in_arena: boolean(),
          id: integer(),
          geometry_id: integer(),
          is_in_starting_social_zone: boolean(),
          unknown6: boolean()
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