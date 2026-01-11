defmodule RyujinCore.Packets.LoginRequest do
  @moduledoc """
  Initial login packet sent by client with username/password credentials.

  Binary format:
  - username_len (uint16-little)
  - username (string)
  - password_len (uint16-little)
  - password (string)
  """
  use RyujinCore.Packet

  defstruct [:username, :password]

  @type t :: %__MODULE__{
    username: String.t(),
    password: String.t()
  }

  @impl true
  def serialize(%__MODULE__{username: username, password: password}) do
    username_bin = RyujinCore.Packet.write_string(username)
    password_bin = RyujinCore.Packet.write_string(password)
    <<username_bin::binary, password_bin::binary>>
  end

  @impl true
  def deserialize(data) do
    with {:ok, username, rest} <- RyujinCore.Packet.read_string(data),
         {:ok, password, rest} <- RyujinCore.Packet.read_string(rest) do
      {:ok, %__MODULE__{username: username, password: password}, rest}
    end
  end
end
