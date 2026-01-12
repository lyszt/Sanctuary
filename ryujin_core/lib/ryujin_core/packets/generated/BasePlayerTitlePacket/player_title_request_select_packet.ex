defmodule RyujinCore.Packets.PlayerTitleRequestSelectPacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PlayerTitleRequestSelectPacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BasePlayerTitlePacket/PlayerTitleRequestSelectPacket.cs`\n\n**OpCodes**: %{main_opcode: 4}\n"
  use RyujinCore.Packet
  defstruct [:id]
  @type t :: %__MODULE__{id: integer()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end