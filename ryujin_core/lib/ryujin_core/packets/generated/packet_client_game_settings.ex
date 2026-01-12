defmodule RyujinCore.Packets.PacketClientGameSettings do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketClientGameSettings`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketClientGameSettings.cs`\n\n**OpCodes**: %{main_opcode: 144}\n"
  use RyujinCore.Packet
  defstruct [:unknown, :unknown2, :power_hour_effect_tag, :unknown4]

  @type t :: %__MODULE__{
          unknown: integer(),
          unknown2: integer(),
          power_hour_effect_tag: integer(),
          unknown4: boolean()
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