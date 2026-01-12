defmodule RyujinCore.Packets.PlayerUpdatePacketRemovePlayerGracefully do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PlayerUpdatePacketRemovePlayerGracefully`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BasePlayerUpdatePacket/PlayerUpdatePacketRemovePlayerGracefully.cs`\n\n**OpCodes**: %{main_opcode: 1}\n"
  use RyujinCore.Packet
  defstruct [:animate, :delay, :effect_delay, :composite_effect_id, :duration]

  @type t :: %__MODULE__{
          animate: boolean(),
          delay: integer(),
          effect_delay: integer(),
          composite_effect_id: integer(),
          duration: integer()
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