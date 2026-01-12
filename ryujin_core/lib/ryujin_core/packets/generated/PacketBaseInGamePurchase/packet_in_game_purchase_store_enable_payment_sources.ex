defmodule RyujinCore.Packets.PacketInGamePurchaseStoreEnablePaymentSources do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketInGamePurchaseStoreEnablePaymentSources`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketBaseInGamePurchase/PacketInGamePurchaseStoreEnablePaymentSources.cs`\n\n**OpCodes**: %{main_opcode: 33}\n"
  use RyujinCore.Packet
  defstruct [:sms, :paypal]
  @type t :: %__MODULE__{sms: boolean(), paypal: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end