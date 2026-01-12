defmodule RyujinCore.Packets.PlayerUpdatePacketUpdatePosition do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PlayerUpdatePacketUpdatePosition`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PlayerUpdatePacketUpdatePosition.cs`\n\n**OpCodes**: %{main_opcode: 125}\n"
  use RyujinCore.Packet
  defstruct [:guid, :position, :rotation, :state, :unknown]

  @type t :: %__MODULE__{
          guid: term(),
          position: term(),
          rotation: term(),
          state: non_neg_integer(),
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