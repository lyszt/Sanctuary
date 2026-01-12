defmodule RyujinCore.Packets.PacketInGamePurchaseStoreBundleContentResponse do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketInGamePurchaseStoreBundleContentResponse`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketBaseInGamePurchase/PacketInGamePurchaseStoreBundleContentResponse.cs`\n\n**OpCodes**: %{main_opcode: 28}\n"
  use RyujinCore.Packet
  defstruct [:store_id, :bundle_id]
  @type t :: %__MODULE__{store_id: integer(), bundle_id: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    <<packet.store_id::32-little, packet.bundle_id::32-little>>
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end