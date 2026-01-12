defmodule RyujinCore.Packets.GatewayCharacterLogout do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.GatewayCharacterLogout`\n\n**Source**: `../legacy/src/Sanctuary.Packet/Custom/GatewayCharacterLogout.cs`\n\n**OpCodes**: %{main_opcode: 103}\n"
  use RyujinCore.Packet
  defstruct [:id]
  @type t :: %__MODULE__{id: term()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end