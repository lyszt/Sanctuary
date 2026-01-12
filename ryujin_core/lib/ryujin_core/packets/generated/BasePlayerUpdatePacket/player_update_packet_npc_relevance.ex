defmodule RyujinCore.Packets.PlayerUpdatePacketNpcRelevance do
  @moduledoc "/// Id from Cursors.txt ///\n\n**Auto-generated from C#**: `Sanctuary.Packet.PlayerUpdatePacketNpcRelevance`\n\n**Source**: `../legacy/src/Sanctuary.Packet/BasePlayerUpdatePacket/PlayerUpdatePacketNpcRelevance.cs`\n\n**OpCodes**: %{main_opcode: 12}\n"
  use RyujinCore.Packet
  defstruct [:guid, :unknown, :cursor_id, :unknown2]

  @type t :: %__MODULE__{
          guid: term(),
          unknown: boolean(),
          cursor_id: non_neg_integer(),
          unknown2: boolean()
        }
  @impl true
  def serialize(%__MODULE__{} = packet) do
    <<packet.guid::32-little, packet.unknown::32-little, packet.cursor_id::32-little,
      packet.unknown2::32-little>>
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end