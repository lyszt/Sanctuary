defmodule RyujinCore.Packets.PacketGameTimeSync do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketGameTimeSync`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketGameTimeSync.cs`\n\n**OpCodes**: %{main_opcode: 52}\n"
  use RyujinCore.Packet
  defstruct [:time, :server_rate, :use_client_time]
  @type t :: %__MODULE__{time: term(), server_rate: integer(), use_client_time: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end