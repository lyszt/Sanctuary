# Ryujin Core - Quick Start Guide

## What We've Built

### ✅ Foundation Complete (Current Status)

**Core Systems**:
- ✅ Packet behavior & DSL (`RyujinCore.Packet`)
- ✅ RC4 encryption (`RyujinCore.Crypto.RC4`)
- ✅ UDP Server GenServer (`RyujinCore.UDP.Server`)
- ✅ UDP Connection GenServer (`RyujinCore.UDP.Connection`)
- ✅ Database schemas (Users, Characters, Items, Mounts, Titles)
- ✅ Ecto contexts (Accounts)
- ✅ Example packets (LoginRequest, LoginReply)

**Developer Tools**:
- ✅ Packet generator (`mix ryujin.gen.packet`)
- ✅ Packet capture/replay (`RyujinCore.Tools.PacketCapture`)
- ✅ Architecture documentation
- ✅ Feature parity roadmap (17-week plan)
- ✅ Complete packet inventory (319 files mapped)

---

## Getting Started

### Prerequisites

```bash
# Elixir/Erlang (via mise)
mise install

# PostgreSQL
# Install via your package manager
# Ubuntu: sudo apt install postgresql
# macOS: brew install postgresql
```

### Database Setup

```bash
# Create database
mix ecto.create

# Run migrations
mix ecto.migrate

# (Optional) Seed data
mix run priv/repo/seeds.exs
```

### Run Tests

```bash
mix test
```

### Start Interactive Shell

```bash
# Start with all modules loaded
iex -S mix

# Try out the packet system
iex> packet = %RyujinCore.Packets.LoginRequest{username: "test", password: "password"}
iex> binary = RyujinCore.Packets.LoginRequest.serialize(packet)
iex> RyujinCore.Packets.LoginRequest.deserialize(binary)
```

---

## Using the Packet Generator

### Generate a Single Packet

```bash
# From a C# file
mix ryujin.gen.packet --source ../legacy/src/Sanctuary.Packet/PacketChat.cs

# Dry run (preview without creating file)
mix ryujin.gen.packet --source PacketChat.cs --dry-run
```

### Generate All Packets

```bash
# Generate all packets in a directory
mix ryujin.gen.packet --source-dir ../legacy/src/Sanctuary.Packet/

# This will create:
# lib/ryujin_core/packets/generated/*.ex
```

### Customize Output

```bash
# Specify output directory
mix ryujin.gen.packet \
  --source PacketChat.cs \
  --output lib/ryujin_core/packets/chat/
```

**Note**: Generated packets have skeleton implementations - you'll need to:
1. Review the C# source for binary format
2. Implement `serialize/1` and `deserialize/1` functions
3. Add unit tests

---

## Using Packet Capture

### Basic Usage

```elixir
# Start capturing all packets
{:ok, _pid} = RyujinCore.Tools.PacketCapture.start()

# Your server runs... packets are captured...

# View stats
RyujinCore.Tools.PacketCapture.stats()
# => %{
#      enabled: true,
#      capture_count: 1543,
#      uptime_seconds: 45.2,
#      filter: nil,
#      player_filter: nil
#    }

# Export to file
RyujinCore.Tools.PacketCapture.export("captures/session.json")

# Stop capturing
RyujinCore.Tools.PacketCapture.stop()
```

### Filtered Capture

```elixir
# Only capture specific packet types
PacketCapture.start(filter: [15, 26, 35])  # Chat, Commands, Player Updates

# Only capture for a specific player
PacketCapture.start(player: "SomePlayer123")

# Auto-save to file
PacketCapture.start(output: "captures/live.ndjson")
```

### Replay Sessions

```elixir
# Replay at normal speed
PacketCapture.replay("captures/session.json")

# Replay at 2x speed
PacketCapture.replay("captures/session.json", speed: 2.0)

# Replay to a specific connection
PacketCapture.replay("captures/session.json", connection: conn_pid)
```

---

## Development Workflow

### 1. Pick a Packet to Implement

Check `FEATURE_PARITY_ROADMAP.md` for priority order. Start with Phase 1 packets (login flow).

### 2. Generate Skeleton

```bash
mix ryujin.gen.packet --source ../legacy/src/Sanctuary.Packet/ExternalLogin/LoginRequest.cs
```

### 3. Review C# Implementation

```bash
# Open the C# source
code ../legacy/src/Sanctuary.Packet/ExternalLogin/LoginRequest.cs

# Look for:
# - Serialize() method - shows binary format
# - Deserialize() method - shows field order
# - Field types - map to Elixir types
```

### 4. Implement Serialization

```elixir
defmodule RyujinCore.Packets.LoginRequest do
  use RyujinCore.Packet

  defstruct [:session_id, :fingerprint, :locale]

  @impl true
  def serialize(%__MODULE__{session_id: sid, fingerprint: fp, locale: locale}) do
    # Match C# binary format exactly
    <<
      sid::32-little,
      byte_size(fingerprint)::16-little, fingerprint::binary,
      byte_size(locale)::16-little, locale::binary
    >>
  end

  @impl true
  def deserialize(data) do
    with <<sid::32-little, rest::binary>> <- data,
         {:ok, fingerprint, rest} <- read_string(rest),
         {:ok, locale, rest} <- read_string(rest) do
      {:ok, %__MODULE__{session_id: sid, fingerprint: fingerprint, locale: locale}, rest}
    else
      _ -> {:error, :invalid_login_request}
    end
  end
end
```

### 5. Write Tests

```elixir
defmodule RyujinCore.Packets.LoginRequestTest do
  use ExUnit.Case
  alias RyujinCore.Packets.LoginRequest

  test "serialization round-trip" do
    packet = %LoginRequest{
      session_id: 12345,
      fingerprint: "test_fingerprint",
      locale: "en_US"
    }

    binary = LoginRequest.serialize(packet)
    assert {:ok, ^packet, ""} = LoginRequest.deserialize(binary)
  end

  test "matches C# output byte-for-byte" do
    # Captured from C# server
    reference_bytes = <<...>>

    {:ok, packet, _} = LoginRequest.deserialize(reference_bytes)
    assert LoginRequest.serialize(packet) == reference_bytes
  end
end
```

### 6. Create Handler

```elixir
defmodule RyujinCore.Handlers.LoginRequest do
  @moduledoc """
  Handles client login requests.
  """

  alias RyujinCore.Packets.{LoginRequest, LoginReply}
  alias RyujinCore.Accounts

  def handle(%LoginRequest{} = packet, connection) do
    case Accounts.authenticate(packet.username, packet.password) do
      {:ok, user} ->
        session_key = :crypto.strong_rand_bytes(16)
        Accounts.update_session_key(user, session_key)

        reply = %LoginReply{
          result: :success,
          session_key: session_key
        }

        send_reply(connection, reply)

      {:error, _reason} ->
        reply = %LoginReply{
          result: :failure,
          error_message: "Invalid credentials"
        }

        send_reply(connection, reply)
    end
  end

  defp send_reply(connection, packet) do
    RyujinCore.UDP.Connection.send_packet(
      connection,
      packet.__struct__.serialize(packet),
      reliable: true
    )
  end
end
```

---

## Next Steps (Priority Order)

### Week 1: UDP Reliability

**Goal**: Implement reliable UDP protocol matching C# `UdpLibrary`

**Files to Study**:
- `legacy/src/Sanctuary.UdpLibrary/UdpConnection.cs`
- `legacy/src/Sanctuary.UdpLibrary/UdpReliableChannel.cs`
- `legacy/src/Sanctuary.UdpLibrary/Internal/UdpPacketType.cs`

**Implementation**:
1. Create `lib/ryujin_core/udp/protocol.ex` - Packet type definitions
2. Create `lib/ryujin_core/udp/reliable_channel.ex` - Per-channel reliability
3. Update `lib/ryujin_core/udp/connection.ex` - Add reliable channels
4. Add tests for ack/retransmit/ordering

**Success Criteria**:
- Can establish reliable connection
- Packets are acknowledged
- Lost packets are retransmitted
- Packets arrive in order
- Fragmented packets work

### Week 2-3: Login Flow

**Goal**: Complete end-to-end login

**Packets to Implement** (17 total):
1. LoginRequest/LoginReply ✅ (started)
2. ServerListRequest/ServerListReply
3. CharacterSelectInfoRequest/CharacterSelectInfoReply
4. CharacterCreateRequest/CharacterCreateReply
5. CharacterDeleteRequest/CharacterDeleteReply
6. CharacterLoginRequest/CharacterLoginReply
7. PacketLogin (Gateway)
8. PacketLoginReply (Gateway)

**Implementation**:
1. Generate all login packets: `mix ryujin.gen.packet --source-dir ../legacy/src/Sanctuary.Packet/ExternalLogin/`
2. Implement serialization for each
3. Create `LoginServer` GenServer
4. Add to supervision tree
5. Create handlers for each packet
6. Test with real client

**Success Criteria**:
- Client can authenticate
- Client can see character list
- Client can create character
- Client can delete character
- Client can enter world with character

---

## Project Structure

```
ryujin_core/
├── lib/
│   ├── mix/tasks/
│   │   └── ryujin.gen.packet.ex         # Packet generator
│   ├── ryujin_core/
│   │   ├── accounts/                    # User accounts
│   │   │   └── user.ex
│   │   ├── characters/                  # Characters
│   │   │   └── character.ex
│   │   ├── contexts/                    # Business logic
│   │   │   └── accounts.ex
│   │   ├── crypto/                      # Encryption
│   │   │   ├── rc4.ex
│   │   │   └── ccm.ex (TODO)
│   │   ├── data/                        # Game data structures (TODO)
│   │   │   ├── vector.ex
│   │   │   ├── quaternion.ex
│   │   │   └── character_stats.ex
│   │   ├── entities/                    # Game entities (TODO)
│   │   │   ├── player.ex
│   │   │   ├── npc.ex
│   │   │   └── mount.ex
│   │   ├── handlers/                    # Packet handlers (TODO)
│   │   │   ├── login_request.ex
│   │   │   └── ...
│   │   ├── items/                       # Items
│   │   │   └── item.ex
│   │   ├── mounts/                      # Mounts
│   │   │   └── mount.ex
│   │   ├── packets/                     # Packet definitions
│   │   │   ├── generated/              # Auto-generated
│   │   │   ├── login_request.ex
│   │   │   ├── login_reply.ex
│   │   │   └── ...
│   │   ├── titles/                      # Titles
│   │   │   └── title.ex
│   │   ├── tools/                       # Dev tools
│   │   │   ├── packet_capture.ex
│   │   │   └── protocol_tester.ex (TODO)
│   │   ├── udp/                         # UDP networking
│   │   │   ├── server.ex
│   │   │   ├── connection.ex
│   │   │   ├── protocol.ex (TODO)
│   │   │   ├── reliable_channel.ex (TODO)
│   │   │   └── fragment.ex (TODO)
│   │   ├── zones/                       # Zone system (TODO)
│   │   │   ├── zone.ex
│   │   │   ├── tile.ex
│   │   │   └── visibility.ex
│   │   ├── application.ex               # OTP application
│   │   ├── packet.ex                    # Packet behavior
│   │   └── repo.ex                      # Database
│   ├── ryujin_core_web/                 # Phoenix web interface
│   │   └── ...
│   └── ryujin_core.ex
├── priv/
│   └── repo/
│       ├── migrations/                  # Database migrations
│       │   ├── *_create_users.exs
│       │   ├── *_create_characters.exs
│       │   └── *_create_items.exs
│       └── seeds.exs
├── test/
│   └── ...
├── ARCHITECTURE.md                      # System architecture
├── FEATURE_PARITY_ROADMAP.md           # 17-week plan
├── QUICKSTART.md                        # This file
└── mix.exs
```

---

## Tips & Best Practices

### Elixir Conventions

- Use `snake_case` for files/functions
- Use `PascalCase` for modules
- Pattern match in function heads
- Use `with` for sequential operations
- Leverage pipe operator `|>`

### Packet Implementation

- Always test serialization round-trip
- Compare byte-for-byte with C# output
- Document binary format in module docs
- Use packet capture to validate

### Performance

- Use ETS for frequently accessed data (items, zones)
- Keep GenServer state minimal
- Leverage pattern matching (faster than if/case)
- Profile with `:observer.start()` in IEx

### Debugging

```elixir
# Start observer (visual process inspector)
:observer.start()

# Enable debug logging
Logger.configure(level: :debug)

# Inspect packet capture
PacketCapture.stats()
PacketCapture.export("debug.json")

# Check process mailbox
Process.info(self(), :message_queue_len)

# Memory usage
:erlang.memory()
```

---

## Resources

### Internal Docs
- `ARCHITECTURE.md` - System design
- `FEATURE_PARITY_ROADMAP.md` - Implementation plan
- C# source: `../legacy/src/`

### External Resources
- [Elixir Docs](https://hexdocs.pm/elixir/)
- [GenServer Guide](https://elixir-lang.org/getting-started/mix-otp/genserver.html)
- [Ecto Guide](https://hexdocs.pm/ecto/)
- [Binary Pattern Matching](https://elixir-lang.org/getting-started/binaries-strings-and-char-lists.html)

---

## Getting Help

### Check Existing Implementation
Most questions can be answered by reading the C# code:
- Packet format? → `Sanctuary.Packet/*.cs`
- Handler logic? → `Sanctuary.Gateway/Handlers/*.cs`
- UDP protocol? → `Sanctuary.UdpLibrary/*.cs`

### Community
- GitHub Issues: For bugs/features
- Discussions: For questions

---

**Let's build something amazing! 🚀**

The C# version is solid, but with Elixir we can:
- Handle 5x more players
- Hot-reload game logic
- Distribute across servers
- Debug with time-travel
- Build tools that "kidnap" packets to understand the protocol deeply

**Next command to run**:
```bash
# Start with UDP reliability layer
mkdir -p lib/ryujin_core/udp
touch lib/ryujin_core/udp/protocol.ex
```
