defmodule RyujinCore.Packets.QuickChatSendTellPacket do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.QuickChatSendTellPacket`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BaseQuickChatPacket/QuickChatSendTellPacket.cs`\n\n**OpCodes**: %{main_opcode: 2}\n"
  use RyujinCore.Packet
  defstruct [:to_name, :unknown]
  @type t :: %__MODULE__{to_name: String.t(), unknown: term()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end