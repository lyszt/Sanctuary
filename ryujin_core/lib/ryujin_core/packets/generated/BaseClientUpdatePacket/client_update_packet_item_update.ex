defmodule RyujinCore.Packets.ClientUpdatePacketItemUpdate do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.ClientUpdatePacketItemUpdate`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseClientUpdatePacket/ClientUpdatePacketItemUpdate.cs`\n\n**OpCodes**: %{main_opcode: 3}\n"
  use RyujinCore.Packet
  defstruct [:item_guid, :count, :consumed_count, :ability_count, :rental_expiration_time]

  @type t :: %__MODULE__{
          item_guid: integer(),
          count: integer(),
          consumed_count: integer(),
          ability_count: integer(),
          rental_expiration_time: term()
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