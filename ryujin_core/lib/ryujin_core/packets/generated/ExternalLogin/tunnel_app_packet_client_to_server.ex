defmodule RyujinCore.Packets.TunnelAppPacketClientToServer do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.TunnelAppPacketClientToServer`\n\n**Source**: `../legacy/src/Sanctuary.Packet/ExternalLogin/TunnelAppPacketClientToServer.cs`\n\n**OpCodes**: %{main_opcode: 16}\n"
  use RyujinCore.Packet
  defstruct [:server_id]
  @type t :: %__MODULE__{server_id: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end