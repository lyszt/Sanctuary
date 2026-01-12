defmodule RyujinCore.Packets.PlayerUpdatePacketPlayCompositeEffect do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PlayerUpdatePacketPlayCompositeEffect`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BasePlayerUpdatePacket/PlayerUpdatePacketPlayCompositeEffect.cs`\n\n**OpCodes**: %{main_opcode: 16}\n"
  use RyujinCore.Packet

  defstruct [
    :guid,
    :unknown2,
    :composite_effect_id,
    :unknown4,
    :effect_delay,
    :position,
    :unknown7
  ]

  @type t :: %__MODULE__{
          guid: term(),
          unknown2: term(),
          composite_effect_id: integer(),
          unknown4: integer(),
          effect_delay: integer(),
          position: term(),
          unknown7: boolean()
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