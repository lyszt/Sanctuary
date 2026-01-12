defmodule RyujinCore.Packets.LoginReply do
  @moduledoc "\n\n**Auto-generated from C#**: `Sanctuary.Packet.LoginReply`\n\n**Source**: `../legacy/src/Sanctuary.Packet/ExternalLogin/LoginReply.cs`\n\n**OpCodes**: %{main_opcode: 2}\n"
  use RyujinCore.Packet
  defstruct [:logged_in, :status, :is_member]
  @type t :: %__MODULE__{logged_in: boolean(), status: integer(), is_member: boolean()}
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end