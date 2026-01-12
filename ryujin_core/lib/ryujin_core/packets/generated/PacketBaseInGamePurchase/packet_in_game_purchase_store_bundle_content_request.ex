defmodule RyujinCore.Packets.PacketInGamePurchaseStoreBundleContentRequest do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketInGamePurchaseStoreBundleContentRequest`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketBaseInGamePurchase/PacketInGamePurchaseStoreBundleContentRequest.cs`\n\n**OpCodes**: %{main_opcode: 27}\n"
  use RyujinCore.Packet
  defstruct [:store_id, :bundle_id]
  @type t :: %__MODULE__{store_id: integer(), bundle_id: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end