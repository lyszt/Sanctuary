defmodule RyujinCore.Tools.PacketCapture do
  @moduledoc """
  Packet capture and analysis tool for understanding the game protocol.

  This tool allows you to:
  - Intercept all packets between client and server
  - Log packets to file for analysis
  - Replay captured sessions
  - Compare packets between C# and Elixir implementations
  - Export to JSON/PCAP formats

  ## Usage

      # Start capturing all packets
      PacketCapture.start()

      # Capture only specific packet types
      PacketCapture.start(filter: [:login, :chat, :movement])

      # Capture for a specific player
      PacketCapture.start(player: "PlayerName")

      # Stop capturing
      PacketCapture.stop()

      # Export to file
      PacketCapture.export("captures/session_2024-01-11.json")

      # Replay a session
      PacketCapture.replay("captures/session_2024-01-11.json")

  ## Format

  Each captured packet includes:
  - Timestamp (microsecond precision)
  - Direction (client→server or server→client)
  - OpCode/SubOpCode
  - Raw binary data
  - Parsed packet (if parser available)
  - Player context (character ID, username)
  """

  use GenServer
  require Logger

  @type capture_entry :: %{
    timestamp: integer(),
    direction: :inbound | :outbound,
    opcode: non_neg_integer(),
    subopcode: non_neg_integer() | nil,
    raw_data: binary(),
    parsed: term() | nil,
    player_id: String.t() | nil,
    connection_id: non_neg_integer()
  }

  defstruct [
    :enabled,
    :filter,
    :player_filter,
    :start_time,
    :capture_buffer,
    :max_buffer_size,
    :output_file
  ]

  ## Public API

  @doc """
  Starts packet capture.

  Options:
  - `:filter` - List of packet types to capture (default: all)
  - `:player` - Only capture packets for specific player
  - `:output` - Auto-save to file
  - `:buffer_size` - Max packets to keep in memory (default: 10,000)
  """
  def start(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @doc """
  Stops packet capture.
  """
  def stop do
    GenServer.stop(__MODULE__)
  end

  @doc """
  Records a packet (called by Connection/Server modules).
  """
  def record(direction, opcode, subopcode, raw_data, metadata \\ %{}) do
    if Process.whereis(__MODULE__) do
      GenServer.cast(__MODULE__, {:record, direction, opcode, subopcode, raw_data, metadata})
    end
  end

  @doc """
  Exports captured packets to file.
  """
  def export(filename) do
    GenServer.call(__MODULE__, {:export, filename})
  end

  @doc """
  Returns current capture statistics.
  """
  def stats do
    GenServer.call(__MODULE__, :stats)
  end

  @doc """
  Clears capture buffer.
  """
  def clear do
    GenServer.cast(__MODULE__, :clear)
  end

  @doc """
  Replays a captured session from file.
  """
  def replay(filename, opts \\ []) do
    case File.read(filename) do
      {:ok, content} ->
        packets = Jason.decode!(content)
        replay_packets(packets, opts)

      {:error, reason} ->
        {:error, reason}
    end
  end

  ## GenServer Callbacks

  @impl true
  def init(opts) do
    state = %__MODULE__{
      enabled: true,
      filter: Keyword.get(opts, :filter),
      player_filter: Keyword.get(opts, :player),
      start_time: System.monotonic_time(:microsecond),
      capture_buffer: :queue.new(),
      max_buffer_size: Keyword.get(opts, :buffer_size, 10_000),
      output_file: Keyword.get(opts, :output)
    }

    Logger.info("Packet capture started")
    {:ok, state}
  end

  @impl true
  def handle_cast({:record, direction, opcode, subopcode, raw_data, metadata}, state) do
    if should_capture?(state, opcode, metadata) do
      entry = %{
        timestamp: System.monotonic_time(:microsecond) - state.start_time,
        direction: direction,
        opcode: opcode,
        subopcode: subopcode,
        raw_data: Base.encode64(raw_data),
        size: byte_size(raw_data),
        metadata: metadata
      }

      buffer = :queue.in(entry, state.capture_buffer)
      buffer = trim_buffer(buffer, state.max_buffer_size)

      # Auto-save if configured
      state = if state.output_file do
        append_to_file(state.output_file, entry)
        state
      else
        %{state | capture_buffer: buffer}
      end

      {:noreply, state}
    else
      {:noreply, state}
    end
  end

  @impl true
  def handle_cast(:clear, state) do
    Logger.info("Packet capture buffer cleared")
    {:noreply, %{state | capture_buffer: :queue.new()}}
  end

  @impl true
  def handle_call(:stats, _from, state) do
    stats = %{
      enabled: state.enabled,
      capture_count: :queue.len(state.capture_buffer),
      uptime_seconds: (System.monotonic_time(:microsecond) - state.start_time) / 1_000_000,
      filter: state.filter,
      player_filter: state.player_filter
    }

    {:reply, stats, state}
  end

  @impl true
  def handle_call({:export, filename}, _from, state) do
    packets = :queue.to_list(state.capture_buffer)

    case Jason.encode(packets, pretty: true) do
      {:ok, json} ->
        File.write!(filename, json)
        Logger.info("Exported #{length(packets)} packets to #{filename}")
        {:reply, {:ok, filename}, state}

      {:error, reason} ->
        {:reply, {:error, reason}, state}
    end
  end

  ## Private Functions

  defp should_capture?(state, opcode, metadata) do
    state.enabled and
      filter_by_opcode(state.filter, opcode) and
      filter_by_player(state.player_filter, metadata[:player_id])
  end

  defp filter_by_opcode(nil, _opcode), do: true
  defp filter_by_opcode(filter, opcode), do: opcode in filter

  defp filter_by_player(nil, _player_id), do: true
  defp filter_by_player(filter, player_id), do: player_id == filter

  defp trim_buffer(buffer, max_size) do
    if :queue.len(buffer) > max_size do
      {_dropped, new_buffer} = :queue.out(buffer)
      new_buffer
    else
      buffer
    end
  end

  defp append_to_file(filename, entry) do
    # Append to NDJSON format (newline-delimited JSON)
    json = Jason.encode!(entry)
    File.write!(filename, json <> "\n", [:append])
  end

  defp replay_packets(packets, opts) do
    speed = Keyword.get(opts, :speed, 1.0)
    connection = Keyword.get(opts, :connection)

    Logger.info("Replaying #{length(packets)} packets at #{speed}x speed")

    Enum.reduce(packets, 0, fn packet, last_timestamp ->
      # Calculate delay based on timestamp difference
      delay_us = trunc((packet["timestamp"] - last_timestamp) / speed)

      if delay_us > 0 do
        Process.sleep(div(delay_us, 1000))
      end

      # Send packet to connection
      if connection do
        raw_data = Base.decode64!(packet["raw_data"])
        send_packet_to_connection(connection, raw_data, packet["direction"])
      end

      packet["timestamp"]
    end)

    Logger.info("Replay complete")
    :ok
  end

  defp send_packet_to_connection(connection, data, "outbound") do
    # Send to client
    RyujinCore.UDP.Connection.send_packet(connection, data, false)
  end

  defp send_packet_to_connection(connection, data, "inbound") do
    # Process as incoming from client
    RyujinCore.UDP.Connection.receive_data(connection, data)
  end
end
