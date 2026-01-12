defmodule RyujinCore.Packets.PacketInGamePurchaseAccountInfoResponse do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketInGamePurchaseAccountInfoResponse`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketBaseInGamePurchase/PacketInGamePurchaseAccountInfoResponse.cs`\n\n**OpCodes**: %{main_opcode: 26}\n"
  use RyujinCore.Packet
  defstruct [:error_code, :is_parental_password_enabled]
  @type t :: %__MODULE__{error_code: integer(), is_parental_password_enabled: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end