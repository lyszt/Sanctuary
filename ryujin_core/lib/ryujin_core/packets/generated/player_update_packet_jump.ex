defmodule RyujinCore.Packets.PlayerUpdatePacketJump do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PlayerUpdatePacketJump`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PlayerUpdatePacketJump.cs`\n\n**OpCodes**: %{main_opcode: 164}\n"
  use RyujinCore.Packet
  defstruct [:guid, :position, :rotation, :state, :unknown, :vertical_velocity]

  @type t :: %__MODULE__{
          guid: term(),
          position: term(),
          rotation: term(),
          state: non_neg_integer(),
          unknown: non_neg_integer(),
          vertical_velocity: float()
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