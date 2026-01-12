defmodule RyujinCore.Packets.PlayerUpdatePacketCustomizationChange do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PlayerUpdatePacketCustomizationChange`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BasePlayerUpdatePacket/PlayerUpdatePacketCustomizationChange.cs`\n\n**OpCodes**: %{main_opcode: 39}\n"
  use RyujinCore.Packet
  defstruct [:guid, :preview]
  @type t :: %__MODULE__{guid: term(), preview: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end