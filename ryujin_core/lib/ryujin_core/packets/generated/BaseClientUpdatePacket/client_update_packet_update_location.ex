defmodule RyujinCore.Packets.ClientUpdatePacketUpdateLocation do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.ClientUpdatePacketUpdateLocation`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseClientUpdatePacket/ClientUpdatePacketUpdateLocation.cs`\n\n**OpCodes**: %{main_opcode: 12}\n"
  use RyujinCore.Packet
  defstruct [:position, :rotation, :teleport, :unknown]

  @type t :: %__MODULE__{
          position: term(),
          rotation: term(),
          teleport: boolean(),
          unknown: non_neg_integer()
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