defmodule RyujinCore.Packets.CoinStoreBuyFromClientRequestPacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CoinStoreBuyFromClientRequestPacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseCoinStorePacket/CoinStoreBuyFromClientRequestPacket.cs`\n\n**OpCodes**: %{main_opcode: 5}\n"
  use RyujinCore.Packet
  defstruct [:merchant_guid, :item_guid, :quantity]
  @type t :: %__MODULE__{merchant_guid: term(), item_guid: integer(), quantity: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end