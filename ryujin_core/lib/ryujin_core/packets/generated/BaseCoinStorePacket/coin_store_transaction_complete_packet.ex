defmodule RyujinCore.Packets.CoinStoreTransactionCompletePacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CoinStoreTransactionCompletePacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseCoinStorePacket/CoinStoreTransactionCompletePacket.cs`\n\n**OpCodes**: %{main_opcode: 6}\n"
  use RyujinCore.Packet
  defstruct [:result, :item_guid]
  @type t :: %__MODULE__{result: integer(), item_guid: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end