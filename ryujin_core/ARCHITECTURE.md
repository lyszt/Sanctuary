# Ryujin Core - Architecture Overview

**A modern Elixir/OTP rewrite of the Sanctuary game server**

## Project Status

### ✅ Completed Foundation (Phase 1)

#### 1. **Directory Structure**
```
lib/ryujin_core/
├── accounts/           # User authentication
├── characters/         # Character management
├── contexts/          # Business logic contexts
├── crypto/            # Encryption (RC4, CCM)
├── entities/          # Game entities (TODO)
├── handlers/          # Packet handlers (TODO)
├── items/             # Inventory system
├── mounts/            # Mount system
├── packets/           # Protocol definitions
├── titles/            # Title system
├── udp/               # UDP server & connections
└── zones/             # Zone management (TODO)
```

#### 2. **Packet System** (`lib/ryujin_core/packet.ex`)
- Behavior-based packet serialization/deserialization
- Binary pattern matching DSL
- Helper functions for common patterns:
  - Length-prefixed strings
  - Length-prefixed lists
  - Nested packet parsing

**Example packets implemented:**
- `LoginRequest` - Client authentication
- `LoginReply` - Server response

#### 3. **Cryptography** (`lib/ryujin_core/crypto/`)
- ✅ **RC4** stream cipher (connection-level encryption)
- ⏳ **CCM** (TODO - packet-level encryption)

#### 4. **UDP Networking** (`lib/ryujin_core/udp/`)

**UDP Server** (`server.ex`)
- Listens on configurable port
- Routes packets to connection processes
- Manages connection registry
- Monitors connection lifecycle

**UDP Connection** (`connection.ex`)
- One GenServer per client connection
- Connection state machine (connecting → connected → disconnecting)
- Encryption/decryption per connection
- Keep-alive and timeout detection
- Reliable channel support (TODO: full implementation)

#### 5. **Database Layer**

**Ecto Schemas:**
- ✅ `User` - Account management
- ✅ `Character` - Player characters
- ✅ `Item` - Inventory items
- ✅ `Mount` - Character mounts
- ✅ `Title` - Unlocked titles

**Context Modules:**
- ✅ `Accounts` - User CRUD and authentication
- ⏳ `Characters` (TODO)
- ⏳ `Inventory` (TODO)

**Migrations:**
- Users table with unique username constraint
- Characters table with position, appearance, stats
- Items, Mounts, Titles tables with character relationships

---

## Architecture Advantages (Elixir vs C#)

### 🚀 **Concurrency & Scalability**
- **One process per connection** - Natural isolation, no locking
- **Lightweight processes** - Spawn thousands with minimal overhead
- **Built-in supervision** - Automatic crash recovery
- **Per-process GC** - No global GC pauses

### 💪 **Code Quality**
- **Binary pattern matching** - Cleaner packet parsing than manual byte reading
- **Immutable data** - No shared state bugs
- **Fault tolerance** - Supervisor trees handle failures gracefully
- **Hot code reloading** - Update game logic without restarts

### ⚡ **Performance**
- **ETS tables** - Lock-free reads for game data (items, zones, etc.)
- **Message passing** - Natural fit for packet-based protocols
- **BEAM scheduler** - Fair scheduling for all connections
- **Distribution ready** - Easy clustering for multiple servers

---

## System Flow

### Current Connection Flow
```
Client UDP Packet
    ↓
[UDP Server GenServer]
    ├─ New connection? → Spawn Connection GenServer
    └─ Existing? → Route to Connection process
    ↓
[Connection GenServer]
    ├─ Decrypt packet (RC4)
    ├─ Parse packet type
    └─ Route to handler (TODO)
    ↓
[Packet Handler] (TODO)
    ├─ Deserialize packet
    ├─ Validate & execute game logic
    └─ Send response packets
```

### Planned Login Flow
```
1. Client → LoginRequest
2. Server validates credentials (Accounts context)
3. Server generates session key
4. Server → LoginReply (success + session_key)
5. Client → CharacterSelectInfoRequest
6. Server → CharacterSelectInfoReply (character list)
7. Client → CharacterLoginRequest
8. Server validates, loads character
9. Server spawns Player entity in Zone
10. Client enters game world
```

---

## Next Steps (In Priority Order)

### 🔴 **High Priority**

1. **Implement Reliable UDP Layer**
   - Acknowledgment system (Ack packets)
   - Retransmission with timeouts
   - Ordered packet delivery
   - Fragment support for large packets

2. **Login Server Implementation**
   - Create `LoginServer` GenServer
   - Implement packet handlers:
     - `LoginRequestHandler`
     - `CharacterSelectInfoHandler`
     - `CharacterCreateHandler`
     - `CharacterLoginHandler`
   - Session ticket generation

3. **Packet Handler Registry**
   - OpCode → Handler mapping
   - Dynamic handler discovery
   - Handler behavior definition

### 🟡 **Medium Priority**

4. **CCM Cipher Implementation**
   - Packet-level encryption (more secure than RC4)
   - Integration with Connection GenServer

5. **Zone System**
   - Zone GenServer with periodic ticks
   - Spatial partitioning (tile-based grid)
   - Entity visibility calculation
   - ETS-backed entity registry

6. **Entity System**
   - `Player` GenServer (one per online character)
   - `NPC` data structures
   - `Mount` spawning

7. **Gateway Server**
   - Separate server for in-game packets
   - Connection handoff from Login → Gateway
   - Integration with Zone system

### 🟢 **Low Priority**

8. **Resource Management**
   - Load game data (items, zones, mounts) from JSON
   - ETS caching for fast lookups
   - Hot-reload support

9. **Social Systems**
   - Friends list (database migration already exists in legacy)
   - Ignore list
   - Chat channels

10. **Combat & Abilities**
    - Ability system
    - Stat calculations
    - Damage/healing

---

## Testing Strategy

### Unit Tests
```elixir
# Packet serialization/deserialization
test "LoginRequest deserializes correctly"
test "LoginReply serializes with session key"

# Crypto
test "RC4 encrypts and decrypts"
test "CCM authenticated encryption"

# Database contexts
test "authenticate/2 returns user on valid credentials"
test "create_character/1 validates name uniqueness"
```

### Integration Tests
```elixir
# UDP connection lifecycle
test "UDP server accepts new connections"
test "Connection timeout disconnects client"
test "Reliable packet delivery with retransmission"

# Login flow
test "complete login flow from LoginRequest to character select"
test "invalid credentials returns error"
```

### Load Tests
- Spawn 1000+ simultaneous connections
- Measure latency under load
- Test zone visibility updates with many players

---

## Configuration

### Database (config/dev.exs)
```elixir
config :ryujin_core, RyujinCore.Repo,
  database: "ryujin_core_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
```

### UDP Servers (runtime config)
```elixir
config :ryujin_core, :login_server,
  port: 20060

config :ryujin_core, :gateway_server,
  port: 20061
```

---

## Migration Strategy from C#

### Direct Ports
- ✅ Packet structures → Elixir structs with pattern matching
- ✅ EF Core entities → Ecto schemas
- ✅ RC4 cipher → Native Elixir implementation

### Architecture Changes
- ❌ ~~UdpManager (single-threaded)~~ → ✅ UDP Server GenServer
- ❌ ~~UdpConnection (callback-based)~~ → ✅ Connection GenServer (message-based)
- ❌ ~~Manual connection scheduling~~ → ✅ BEAM scheduler
- ❌ ~~Static packet handlers~~ → ✅ GenServer message handlers

### Preserved Concepts
- ✅ Reliable UDP with channels
- ✅ Hierarchical packet system
- ✅ Zone-based spatial partitioning
- ✅ Entity visibility system
- ✅ Session ticket authentication

---

## Performance Notes

### Memory
- Each Connection GenServer: ~2-3 KB base + packet buffers
- 10,000 connections ≈ 30-50 MB (vs 100+ MB in C# with threads)

### Latency
- Message passing: ~1-2 microseconds
- ETS lookup: ~1 microsecond
- Pattern matching: Sub-microsecond

### Throughput
- Single UDP server: 50k+ packets/sec
- Clustered: Linear scaling with nodes

---

## Contributing

### Code Style
- Follow Elixir conventions (snake_case, modules)
- Use `@moduledoc` and `@doc` for documentation
- Pattern match in function heads
- Use `with` for sequential operations

### Commit Messages
```
feat: Add reliable UDP acknowledgment system
fix: Connection timeout not triggering disconnect
refactor: Extract packet parsing helpers
docs: Update architecture with zone system
```

---

## References

### Original C# Codebase
- Located in `legacy/src/`
- Architecture analysis in `AGENTS.md`

### Elixir/OTP Resources
- [Official Elixir Guides](https://elixir-lang.org/getting-started/)
- [Phoenix Framework](https://www.phoenixframework.org/)
- [Ecto Documentation](https://hexdocs.pm/ecto/)
- [GenServer Guide](https://elixir-lang.org/getting-started/mix-otp/genserver.html)

---

Built with ❤️ in Elixir
