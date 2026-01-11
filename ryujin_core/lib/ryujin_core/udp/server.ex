defmodule RyujinCore.UDP.Server do
  @moduledoc """
  GenServer managing a UDP socket and routing packets to connections.

  This is the main UDP server that:
  - Listens on a UDP port
  - Creates connection processes for new clients
  - Routes incoming packets to appropriate connections
  - Manages connection registry
  """
  use GenServer
  require Logger

  alias RyujinCore.UDP.Connection

  @type state :: %{
    socket: :gen_udp.socket(),
    port: :inet.port_number(),
    connections: %{client_key() => pid()},
    next_connection_id: non_neg_integer(),
    name: atom()
  }

  @type client_key :: {address :: tuple(), port :: non_neg_integer()}

  defstruct [:socket, :port, :connections, :next_connection_id, :name]

  ## Public API

  @doc """
  Starts a new UDP server.

  Options:
  - `:port` - UDP port to listen on (required)
  - `:name` - Server name for registration (required)
  """
  def start_link(opts) do
    name = Keyword.fetch!(opts, :name)
    GenServer.start_link(__MODULE__, opts, name: name)
  end

  @doc """
  Returns statistics about the server.
  """
  def stats(server) do
    GenServer.call(server, :stats)
  end

  ## GenServer Callbacks

  @impl true
  def init(opts) do
    port = Keyword.fetch!(opts, :port)
    name = Keyword.fetch!(opts, :name)

    # Open UDP socket in passive mode (we'll handle receiving manually)
    socket_opts = [
      :binary,
      active: true,  # Receive messages as Erlang messages
      reuseaddr: true
    ]

    case :gen_udp.open(port, socket_opts) do
      {:ok, socket} ->
        state = %__MODULE__{
          socket: socket,
          port: port,
          connections: %{},
          next_connection_id: 1,
          name: name
        }

        Logger.info("UDP Server #{name} listening on port #{port}")
        {:ok, state}

      {:error, reason} ->
        Logger.error("Failed to open UDP socket on port #{port}: #{inspect(reason)}")
        {:stop, reason}
    end
  end

  @impl true
  def handle_call(:stats, _from, state) do
    stats = %{
      port: state.port,
      connection_count: map_size(state.connections),
      next_id: state.next_connection_id
    }
    {:reply, stats, state}
  end

  @impl true
  def handle_info({:udp, socket, address, port, data}, %{socket: socket} = state) do
    client_key = {address, port}

    state =
      case Map.get(state.connections, client_key) do
        nil ->
          # New connection
          handle_new_connection(client_key, address, port, data, state)

        connection_pid ->
          # Existing connection
          Connection.receive_data(connection_pid, data)
          state
      end

    {:noreply, state}
  end

  @impl true
  def handle_info({:DOWN, _ref, :process, pid, reason}, state) do
    # Connection process died, remove from registry
    Logger.debug("Connection process #{inspect(pid)} died: #{inspect(reason)}")

    connections =
      state.connections
      |> Enum.reject(fn {_key, conn_pid} -> conn_pid == pid end)
      |> Map.new()

    {:noreply, %{state | connections: connections}}
  end

  ## Internal Functions

  defp handle_new_connection(client_key, address, port, data, state) do
    Logger.info("New connection from #{format_address(address)}:#{port}")

    # Start connection process
    conn_opts = [
      id: state.next_connection_id,
      socket: state.socket,
      remote_address: address,
      remote_port: port
    ]

    case Connection.start_link(conn_opts) do
      {:ok, connection_pid} ->
        # Monitor the connection process
        Process.monitor(connection_pid)

        # Send initial data to connection
        Connection.receive_data(connection_pid, data)

        # Update state
        %{state |
          connections: Map.put(state.connections, client_key, connection_pid),
          next_connection_id: state.next_connection_id + 1
        }

      {:error, reason} ->
        Logger.error("Failed to start connection: #{inspect(reason)}")
        state
    end
  end

  defp format_address({a, b, c, d}), do: "#{a}.#{b}.#{c}.#{d}"
  defp format_address(address), do: inspect(address)
end
