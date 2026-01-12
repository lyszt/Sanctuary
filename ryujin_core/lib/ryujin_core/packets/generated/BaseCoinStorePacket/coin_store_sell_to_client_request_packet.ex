defmodule RyujinCore.Packets.CoinStoreSellToClientRequestPacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CoinStoreSellToClientRequestPacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseCoinStorePacket/CoinStoreSellToClientRequestPacket.cs`\n\n**OpCodes**: %{main_opcode: 4}\n"
  use RyujinCore.Packet
  defstruct [:merchant_guid, :merchant_unknown, :quantity]
  @type t :: %__MODULE__{merchant_guid: term(), merchant_unknown: integer(), quantity: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end