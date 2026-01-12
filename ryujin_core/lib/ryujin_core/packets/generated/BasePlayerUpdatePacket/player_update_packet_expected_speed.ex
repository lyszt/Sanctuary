defmodule RyujinCore.Packets.PlayerUpdatePacketExpectedSpeed do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PlayerUpdatePacketExpectedSpeed`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BasePlayerUpdatePacket/PlayerUpdatePacketExpectedSpeed.cs`\n\n**OpCodes**: %{main_opcode: 23}\n"
  use RyujinCore.Packet
  defstruct [:guid, :expected_speed]
  @type t :: %__MODULE__{guid: term(), expected_speed: float()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end