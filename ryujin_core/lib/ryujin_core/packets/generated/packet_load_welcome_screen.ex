defmodule RyujinCore.Packets.PacketLoadWelcomeScreen do
  @moduledoc "/// This has to be sent to true or the client won't render the rest of the UI. ///\n\n**Auto-generated from C#**: `Sanctuary.Packet.PacketLoadWelcomeScreen`\n\n**Source**: `../legacy/src/Sanctuary.Packet/PacketLoadWelcomeScreen.cs`\n\n**OpCodes**: %{main_opcode: 93}\n"
  use RyujinCore.Packet
  defstruct [:seconds_since_last_login, :starting_sc_wallet_balance]

  @type t :: %__MODULE__{
          seconds_since_last_login: integer(),
          starting_sc_wallet_balance: integer()
        }
  @impl true
  def serialize(%__MODULE__{} = packet) do
    raise "Serialization not yet implemented - refer to C# source"
  end

  @impl true
  def deserialize(data) do
    {:error, :not_implemented}
  end
end