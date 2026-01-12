defmodule RyujinCore.Packets.CoinStoreItemDefinitionsResponsePacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.CoinStoreItemDefinitionsResponsePacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseCoinStorePacket/CoinStoreItemDefinitionsResponsePacket.cs`\n\n**OpCodes**: %{main_opcode: 3}\n"
  use RyujinCore.Packet
  defstruct [:success]
  @type t :: %__MODULE__{success: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end