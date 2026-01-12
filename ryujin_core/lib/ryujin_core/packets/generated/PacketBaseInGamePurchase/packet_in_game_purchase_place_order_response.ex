defmodule RyujinCore.Packets.PacketInGamePurchasePlaceOrderResponse do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketInGamePurchasePlaceOrderResponse`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketBaseInGamePurchase/PacketInGamePurchasePlaceOrderResponse.cs`\n\n**OpCodes**: %{main_opcode: 4}\n"
  use RyujinCore.Packet
  defstruct [:order_tracking_id, :result, :discount, :total]

  @type t :: %__MODULE__{
          order_tracking_id: integer(),
          result: integer(),
          discount: integer(),
          total: integer()
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