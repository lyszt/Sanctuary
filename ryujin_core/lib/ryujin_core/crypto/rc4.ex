defmodule RyujinCore.Crypto.RC4 do
  @moduledoc """
  RC4 stream cipher implementation for packet encryption.

  This is used by the UDP layer for connection-level encryption.
  """

  @type state :: binary()

  @doc """
  Initializes RC4 cipher with given key.
  Returns the initial cipher state.
  """
  @spec init(binary()) :: state()
  def init(key) when is_binary(key) do
    key_length = byte_size(key)

    # Initialize S-box
    s = Enum.to_list(0..255)

    # Key scheduling algorithm (KSA)
    {s, _} = Enum.reduce(0..255, {s, 0}, fn i, {s_acc, j_acc} ->
      key_byte = :binary.at(key, rem(i, key_length))
      j = rem(j_acc + Enum.at(s_acc, i) + key_byte, 256)

      # Swap S[i] and S[j]
      s_new = swap(s_acc, i, j)
      {s_new, j}
    end)

    # Convert to binary for efficiency
    :erlang.list_to_binary(s)
  end

  @doc """
  Encrypts or decrypts data using RC4 (same operation for both).
  Returns {new_state, encrypted_data}.
  """
  @spec crypt(state(), binary()) :: {state(), binary()}
  def crypt(state, data) when is_binary(state) and is_binary(data) do
    s = :erlang.binary_to_list(state)
    data_bytes = :erlang.binary_to_list(data)

    {s_final, _i_final, _j_final, output} =
      Enum.reduce(data_bytes, {s, 0, 0, []}, fn byte, {s_acc, i_acc, j_acc, out_acc} ->
        # Pseudo-random generation algorithm (PRGA)
        i = rem(i_acc + 1, 256)
        j = rem(j_acc + Enum.at(s_acc, i), 256)

        # Swap S[i] and S[j]
        s_new = swap(s_acc, i, j)

        # Generate keystream byte
        k_idx = rem(Enum.at(s_new, i) + Enum.at(s_new, j), 256)
        k = Enum.at(s_new, k_idx)

        # XOR with plaintext/ciphertext
        output_byte = Bitwise.bxor(byte, k)

        {s_new, i, j, [output_byte | out_acc]}
      end)

    new_state = :erlang.list_to_binary(s_final)
    encrypted = :erlang.list_to_binary(Enum.reverse(output))

    {new_state, encrypted}
  end

  # Helper function to swap two elements in a list
  defp swap(list, i, j) when i == j, do: list
  defp swap(list, i, j) do
    val_i = Enum.at(list, i)
    val_j = Enum.at(list, j)

    list
    |> List.replace_at(i, val_j)
    |> List.replace_at(j, val_i)
  end
end
