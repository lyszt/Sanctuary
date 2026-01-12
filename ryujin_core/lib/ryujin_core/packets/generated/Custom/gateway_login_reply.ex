defmodule RyujinCore.Packets.GatewayLoginReply do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.GatewayLoginReply`\n\n**Source**: `../legacy/src/Sanctuary.Packet/Custom/GatewayLoginReply.cs`\n\n**OpCodes**: %{main_opcode: 101}\n"
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