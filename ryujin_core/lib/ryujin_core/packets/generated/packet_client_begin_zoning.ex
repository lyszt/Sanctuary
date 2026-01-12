defmodule RyujinCore.Packets.PacketClientBeginZoning do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketClientBeginZoning`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketClientBeginZoning.cs`\n\n**OpCodes**: %{main_opcode: 31}\n"
  use RyujinCore.Packet

  defstruct [
    :position,
    :rotation,
    :tutorial,
    :unknown,
    :id,
    :update_radius,
    :geometry_id,
    :override_update_radius,
    :wait_for_zone_ready_packet
  ]

  @type t :: %__MODULE__{
          position: term(),
          rotation: term(),
          tutorial: boolean(),
          unknown: non_neg_integer(),
          id: integer(),
          update_radius: float(),
          geometry_id: integer(),
          override_update_radius: boolean(),
          wait_for_zone_ready_packet: boolean()
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