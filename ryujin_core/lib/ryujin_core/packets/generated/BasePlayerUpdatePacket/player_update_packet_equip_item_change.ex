defmodule RyujinCore.Packets.PlayerUpdatePacketEquipItemChange do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PlayerUpdatePacketEquipItemChange`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BasePlayerUpdatePacket/PlayerUpdatePacketEquipItemChange.cs`\n\n**OpCodes**: %{main_opcode: 6}\n"
  use RyujinCore.Packet
  defstruct [:guid, :id, :profile_id, :wield_type]

  @type t :: %__MODULE__{
          guid: term(),
          id: integer(),
          profile_id: integer(),
          wield_type: integer()
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