defmodule RyujinCore.Packets.ClientHousingPacketSetEditMode do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.ClientHousingPacketSetEditMode`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseHousingPacket/ClientHousingPacketSetEditMode.cs`\n\n**OpCodes**: %{main_opcode: 6}\n"
  use RyujinCore.Packet
  defstruct [:in_edit_mode]
  @type t :: %__MODULE__{in_edit_mode: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end