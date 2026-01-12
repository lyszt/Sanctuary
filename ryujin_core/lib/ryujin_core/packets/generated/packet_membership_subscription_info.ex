defmodule RyujinCore.Packets.PacketMembershipSubscriptionInfo do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketMembershipSubscriptionInfo`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketMembershipSubscriptionInfo.cs`\n\n**OpCodes**: %{main_opcode: 189}\n"
  use RyujinCore.Packet
  defstruct [:is_member, :unknown]
  @type t :: %__MODULE__{is_member: boolean(), unknown: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end