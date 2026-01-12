defmodule RyujinCore.Packets.CharacterSelectInfoReply do
  @moduledoc """
  

  **Ported from C#**: `Sanctuary.Packet.CharacterSelectInfoReply`

  **Source**: `../legacy/src/Sanctuary.Packet/ExternalLogin/CharacterSelectInfoReply.cs`
  """
  use RyujinCore.Packet

  defstruct []

  @type t :: %__MODULE__{

  }

  @impl true
  def serialize(%__MODULE__{} = packet) do
    # TODO: Implement serialization
    # Refer to C# source for binary format
    raise "serialize/1 not yet implemented for Elixir.Mix.Tasks.Ryujin.Gen.Packet"
  end

  @impl true
  def deserialize(data) do
    # TODO: Implement deserialization
    # Refer to C# source for binary format
    {:error, :not_implemented}
  end
end
