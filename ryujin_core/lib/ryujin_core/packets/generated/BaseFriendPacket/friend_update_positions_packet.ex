defmodule RyujinCore.Packets.FriendUpdatePositionsPacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.FriendUpdatePositionsPacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseFriendPacket/FriendUpdatePositionsPacket.cs`\n\n**OpCodes**: %{main_opcode: 5}\n"
  use RyujinCore.Packet
  defstruct [:guid, :in_encounter, :location_x, :location_z]

  @type t :: %__MODULE__{
          guid: term(),
          in_encounter: boolean(),
          location_x: float(),
          location_z: float()
        }
  @impl true
  def serialize(%__MODULE__{} = packet) do
    <<packet.guid::32-little, packet.name::32-little, packet.in_encounter::32-little,
      packet.location_x::32-little, packet.location_z::32-little>>
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end