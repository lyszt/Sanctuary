defmodule RyujinCore.Packets.ClientHousingPacketEnterRequest do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.ClientHousingPacketEnterRequest`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseHousingPacket/ClientHousingPacketEnterRequest.cs`\n\n**OpCodes**: %{main_opcode: 19}\n"
  use RyujinCore.Packet
  defstruct [:house_instance_guid, :unknown, :unknown2]
  @type t :: %__MODULE__{house_instance_guid: term(), unknown: integer(), unknown2: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end