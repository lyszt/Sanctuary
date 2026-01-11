defmodule RyujinCore.Packets.LoginReply do
  @moduledoc """
  Server response to login request.

  Binary format:
  - result (uint8): 0 = success, 1 = failure
  - session_key (binary, 16 bytes) - only if success
  - error_message_len (uint16-little) - only if failure
  - error_message (string) - only if failure
  """
  use RyujinCore.Packet

  defstruct [:result, :session_key, :error_message]

  @type t :: %__MODULE__{
    result: :success | :failure,
    session_key: binary() | nil,
    error_message: String.t() | nil
  }

  @impl true
  def serialize(%__MODULE__{result: :success, session_key: key})
    when byte_size(key) == 16 do
    <<0::8, key::binary-size(16)>>
  end

  def serialize(%__MODULE__{result: :failure, error_message: msg}) do
    msg_bin = RyujinCore.Packet.write_string(msg)
    <<1::8, msg_bin::binary>>
  end

  @impl true
  def deserialize(<<0::8, key::binary-size(16), rest::binary>>) do
    {:ok, %__MODULE__{result: :success, session_key: key}, rest}
  end

  def deserialize(<<1::8, rest::binary>>) do
    case RyujinCore.Packet.read_string(rest) do
      {:ok, msg, rest} ->
        {:ok, %__MODULE__{result: :failure, error_message: msg}, rest}
      error -> error
    end
  end

  def deserialize(_), do: {:error, :invalid_login_reply}
end
