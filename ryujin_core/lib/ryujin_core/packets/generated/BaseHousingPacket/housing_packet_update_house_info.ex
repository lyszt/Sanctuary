defmodule RyujinCore.Packets.HousingPacketUpdateHouseInfo do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.HousingPacketUpdateHouseInfo`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseHousingPacket/HousingPacketUpdateHouseInfo.cs`\n\n**OpCodes**: %{main_opcode: 44}\n"
  use RyujinCore.Packet

  defstruct [
    :in_edit_mode,
    :is_locked,
    :unknown4,
    :pet_autospawn,
    :unknown2,
    :cur_fixture_count,
    :unknown7,
    :furniture_score
  ]

  @type t :: %__MODULE__{
          in_edit_mode: boolean(),
          is_locked: boolean(),
          unknown4: boolean(),
          pet_autospawn: boolean(),
          unknown2: integer(),
          cur_fixture_count: integer(),
          unknown7: integer(),
          furniture_score: integer()
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