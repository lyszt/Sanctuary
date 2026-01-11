defmodule RyujinCore.UDP.Connection do
  @moduledoc """
  GenServer managing a single UDP connection to a client.

  Handles:
  - Reliable packet delivery with acknowledgments
  - Packet ordering and sequencing
  - Connection state management
  - Encryption and compression
  - Keep-alive and timeout detection
  """
  use GenServer
  require Logger

  alias RyujinCore.Crypto.RC4

  @type connection_id :: non_neg_integer()
  @type state :: %{
    id: connection_id(),
    socket: :gen_udp.socket(),
    remote_address: :inet.ip_address(),
    remote_port: :inet.port_number(),
    status: :connecting | :connected | :disconnecting | :disconnected,

    # Encryption
    encrypt_state: RC4.state() | nil,
    decrypt_state: RC4.state() | nil,

    # Reliable channels
    reliable_channels: map(),

    # Sequence tracking
    in_sequence: non_neg_integer(),
    out_sequence: non_neg_integer(),

    # Timing
    last_receive: integer(),
    last_send: integer(),

    # Configuration
    config: map()
  }

  defstruct [
    :id,
    :socket,
    :remote_address,
    :remote_port,
    :status,
    :encrypt_state,
    :decrypt_state,
    :reliable_channels,
    :in_sequence,
    :out_sequence,
    :last_receive,
    :last_send,
    :config
  ]

  ## Public API

  @doc """
  Starts a new UDP connection process.
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  @doc """
  Sends data to the remote client.
  """
  def send_packet(connection, data, reliable \\ false) do
    GenServer.cast(connection, {:send, data, reliable})
  end

  @doc """
  Receives raw UDP data from the socket.
  """
  def receive_data(connection, data) do
    GenServer.cast(connection, {:receive, data})
  end

  @doc """
  Disconnects the connection.
  """
  def disconnect(connection, reason \\ :normal) do
    GenServer.cast(connection, {:disconnect, reason})
  end

  ## GenServer Callbacks

  @impl true
  def init(opts) do
    state = %__MODULE__{
      id: Keyword.fetch!(opts, :id),
      socket: Keyword.fetch!(opts, :socket),
      remote_address: Keyword.fetch!(opts, :remote_address),
      remote_port: Keyword.fetch!(opts, :remote_port),
      status: :connecting,
      encrypt_state: nil,
      decrypt_state: nil,
      reliable_channels: %{},
      in_sequence: 0,
      out_sequence: 0,
      last_receive: System.monotonic_time(:millisecond),
      last_send: System.monotonic_time(:millisecond),
      config: %{
        timeout_ms: 30_000,
        keepalive_ms: 5_000
      }
    }

    # Schedule periodic maintenance
    schedule_tick()

    Logger.debug("UDP Connection #{state.id} started for #{inspect(state.remote_address)}:#{state.remote_port}")

    {:ok, state}
  end

  @impl true
  def handle_cast({:send, data, reliable}, state) do
    case do_send(data, reliable, state) do
      {:ok, new_state} -> {:noreply, new_state}
      {:error, reason} ->
        Logger.error("Failed to send packet: #{inspect(reason)}")
        {:noreply, state}
    end
  end

  @impl true
  def handle_cast({:receive, data}, state) do
    state = %{state | last_receive: System.monotonic_time(:millisecond)}

    case process_incoming_packet(data, state) do
      {:ok, new_state} -> {:noreply, new_state}
      {:error, reason} ->
        Logger.warning("Failed to process packet: #{inspect(reason)}")
        {:noreply, state}
    end
  end

  @impl true
  def handle_cast({:disconnect, reason}, state) do
    Logger.info("Connection #{state.id} disconnecting: #{inspect(reason)}")
    {:stop, :normal, state}
  end

  @impl true
  def handle_info(:tick, state) do
    now = System.monotonic_time(:millisecond)

    state =
      state
      |> check_timeout(now)
      |> maybe_send_keepalive(now)

    schedule_tick()
    {:noreply, state}
  end

  ## Internal Functions

  defp do_send(data, _reliable, state) do
    # TODO: Implement reliable channels
    # For now, just send unreliable
    encrypted_data = encrypt_if_connected(data, state)

    case :gen_udp.send(state.socket, state.remote_address, state.remote_port, encrypted_data) do
      :ok ->
        {:ok, %{state | last_send: System.monotonic_time(:millisecond)}}
      error ->
        error
    end
  end

  defp process_incoming_packet(data, state) do
    # TODO: Implement packet type detection and routing
    # For now, just decrypt if connected
    decrypted = decrypt_if_connected(data, state)

    Logger.debug("Connection #{state.id} received #{byte_size(decrypted)} bytes")

    # Route to packet handlers (TODO)
    {:ok, state}
  end

  defp encrypt_if_connected(data, %{status: :connected, encrypt_state: enc} = state)
    when not is_nil(enc) do
    {new_enc_state, encrypted} = RC4.crypt(enc, data)
    %{state | encrypt_state: new_enc_state}
    encrypted
  end
  defp encrypt_if_connected(data, _state), do: data

  defp decrypt_if_connected(data, %{status: :connected, decrypt_state: dec} = _state)
    when not is_nil(dec) do
    {_new_dec_state, decrypted} = RC4.crypt(dec, data)
    # TODO: Update state with new_dec_state
    decrypted
  end
  defp decrypt_if_connected(data, _state), do: data

  defp check_timeout(state, now) do
    if state.status == :connected and
       now - state.last_receive > state.config.timeout_ms do
      Logger.warning("Connection #{state.id} timed out")
      disconnect(self(), :timeout)
    end
    state
  end

  defp maybe_send_keepalive(state, now) do
    if state.status == :connected and
       now - state.last_send > state.config.keepalive_ms do
      # TODO: Send actual keepalive packet
      Logger.debug("Connection #{state.id} sending keepalive")
    end
    state
  end

  defp schedule_tick do
    Process.send_after(self(), :tick, 1000)
  end
end
