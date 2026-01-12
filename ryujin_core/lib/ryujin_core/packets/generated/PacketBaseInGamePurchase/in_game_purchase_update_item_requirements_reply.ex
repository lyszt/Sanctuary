defmodule RyujinCore.Packets.InGamePurchaseUpdateItemRequirementsReply do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.InGamePurchaseUpdateItemRequirementsReply`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketBaseInGamePurchase/InGamePurchaseUpdateItemRequirementsReply.cs`\n\n**OpCodes**: %{main_opcode: 39}\n"
  use RyujinCore.Packet
  defstruct [:bundle_id, :can_purchase]
  @type t :: %__MODULE__{bundle_id: integer(), can_purchase: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    <<packet.bundle_id::32-little, packet.can_purchase::32-little>>
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end