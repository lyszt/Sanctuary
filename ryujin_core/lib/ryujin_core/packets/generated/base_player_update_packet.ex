defmodule RyujinCore.Packets.BasePlayerUpdatePacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.BasePlayerUpdatePacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BasePlayerUpdatePacket.cs`\n\n**OpCodes**: %{main_opcode: 35}\n"
  use RyujinCore.Packet
  defstruct [:sub_op_code]
  @type t :: %__MODULE__{sub_op_code: term()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end