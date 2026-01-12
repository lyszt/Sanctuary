defmodule RyujinCore.Packets.PacketInGamePurchaseStoreBundleBase do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketInGamePurchaseStoreBundleBase`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketBaseInGamePurchase/PacketInGamePurchaseStoreBundleBase.cs`\n\n**OpCodes**: %{main_opcode: 5}\n"
  use RyujinCore.Packet
  defstruct [:sub_op_code, :store_id]
  @type t :: %__MODULE__{sub_op_code: integer(), store_id: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end