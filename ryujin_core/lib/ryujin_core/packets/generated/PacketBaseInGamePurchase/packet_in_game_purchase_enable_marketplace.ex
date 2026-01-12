defmodule RyujinCore.Packets.PacketInGamePurchaseEnableMarketplace do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketInGamePurchaseEnableMarketplace`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketBaseInGamePurchase/PacketInGamePurchaseEnableMarketplace.cs`\n\n**OpCodes**: %{main_opcode: 24}\n"
  use RyujinCore.Packet
  defstruct [:enabled]
  @type t :: %__MODULE__{enabled: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end