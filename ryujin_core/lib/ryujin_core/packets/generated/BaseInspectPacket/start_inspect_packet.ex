defmodule RyujinCore.Packets.StartInspectPacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.StartInspectPacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseInspectPacket/StartInspectPacket.cs`\n\n**OpCodes**: %{main_opcode: 1}\n"
  use RyujinCore.Packet
  defstruct [:guid, :show_pedestal]
  @type t :: %__MODULE__{guid: term(), show_pedestal: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end