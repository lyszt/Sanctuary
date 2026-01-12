defmodule RyujinCore.Packets.PacketBaseInGamePurchase do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketBaseInGamePurchase`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketBaseInGamePurchase.cs`\n\n**OpCodes**: %{main_opcode: 66}\n"
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