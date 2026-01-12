defmodule RyujinCore.Packets.PacketInGamePurchaseCountryCodesResponse do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketInGamePurchaseCountryCodesResponse`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketBaseInGamePurchase/PacketInGamePurchaseCountryCodesResponse.cs`\n\n**OpCodes**: %{main_opcode: 21}\n"
  use RyujinCore.Packet
  defstruct [:error_code]
  @type t :: %__MODULE__{error_code: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end