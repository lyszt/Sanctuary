defmodule RyujinCore.Packets.CommandPacketInteractRequest do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CommandPacketInteractRequest`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseCommandPacket/CommandPacketInteractRequest.cs`\n\n**OpCodes**: %{main_opcode: 8}\n"
  use RyujinCore.Packet
  defstruct [:guid, :unknown]
  @type t :: %__MODULE__{guid: term(), unknown: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end