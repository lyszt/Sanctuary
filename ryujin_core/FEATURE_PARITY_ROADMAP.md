# Feature Parity Roadmap - Sanctuary → Ryujin

**Goal**: Achieve 100% feature parity with C# implementation, then optimize and extend.

## Statistics
- **Total Packets**: 214 packet definitions
- **Data Structures**: 105 common types
- **Total Files to Port**: 319
- **Base Packet Classes**: 23
- **Critical Path Packets**: ~40 (for MVP)

---

## Phase 0: Foundation & Tools (Current)

**Status**: ✅ In Progress

### Completed
- ✅ Project structure
- ✅ Basic packet DSL
- ✅ RC4 encryption
- ✅ UDP server/connection GenServer
- ✅ Database schemas

### Tools to Build
- [ ] **Packet Generator**: Auto-generate Elixir packets from C# analysis
- [ ] **Packet Capture Tool**: Intercept and log real client<→server traffic
- [ ] **Protocol Tester**: Send/receive test packets
- [ ] **Diff Tool**: Compare C# vs Elixir packet output byte-by-byte

---

## Phase 1: Core Protocol (2-3 weeks)

**Goal**: Login flow working end-to-end

### 1.1 UDP Reliability Layer (Week 1)
**C# Reference**: `legacy/src/Sanctuary.UdpLibrary/`

**Implementation**:
```elixir
# Packet types to implement
- 0x00: Connect
- 0x01: Confirm
- 0x02: Disconnect
- 0x03: Data (application packets)
- 0x09: Reliable
- 0x11: Ack/AckAll
- 0x0D: Multi (coalesced packets)
- 0x15: KeepAlive
- 0x1D: ClockSync

# Modules
lib/ryujin_core/udp/
  ├── protocol.ex           # Packet type definitions
  ├── reliable_channel.ex   # Per-channel reliability
  ├── ack_manager.ex        # Acknowledgment tracking
  └── fragment.ex           # Large packet fragmentation
```

**Critical Features**:
- [ ] Reliable delivery with ack/retransmit
- [ ] Packet ordering (sequence numbers)
- [ ] Fragment support (>467 byte packets)
- [ ] Multi-packet coalescing
- [ ] CRC validation
- [ ] Keep-alive/timeout

**C# Files to Reference**:
- `UdpConnection.cs` (~1800 lines)
- `UdpReliableChannel.cs` (~400 lines)
- `UdpManager.cs` (~900 lines)

### 1.2 Packet Infrastructure (Week 1-2)

**OpCode System**:
```elixir
defmodule Ryujin.Packet.OpCode do
  # Main opcodes
  @chat 15
  @command 26
  @player_update 35
  @ability 36
  @client_update 38
  # ... all 23 base opcodes

  # SubOpCode mapping
  def subopcode(:chat, 1), do: :packet_chat
  def subopcode(:command, 10), do: :interact_request
  # ... all subopcodes
end
```

**Packet Routing**:
```elixir
defmodule Ryujin.Packet.Router do
  @moduledoc """
  Routes packets to handlers based on OpCode/SubOpCode.
  Inspired by Phoenix.Router for familiarity.
  """

  defmacro route(opcode, subopcode, to: handler) do
    # Register handler
  end
end

# Usage in handler modules
defmodule Ryujin.Handlers.Login do
  use Ryujin.Packet.Router

  route 1, :byte, to: :handle_login_request
  route 2, :byte, to: :handle_login_reply

  def handle_login_request(packet, connection) do
    # Handle packet
  end
end
```

**Data Structures**:
```elixir
# Port critical structures first
lib/ryujin_core/data/
  ├── vector.ex             # Vector4
  ├── quaternion.ex         # Quaternion
  ├── character_stats.ex    # CharacterStats (73 stat types)
  ├── item.ex              # ItemRecord, ItemInstance
  ├── name.ex              # NameData
  └── customization.ex     # PlayerCustomizationData
```

### 1.3 ExternalLogin Packets (Week 2)

**Priority Order** (17 packets):
1. ✅ LoginRequest/LoginReply (already started)
2. [ ] ServerListRequest/ServerListReply
3. [ ] CharacterSelectInfoRequest/CharacterSelectInfoReply
4. [ ] CharacterCreateRequest/CharacterCreateReply
5. [ ] CharacterDeleteRequest/CharacterDeleteReply
6. [ ] CharacterLoginRequest/CharacterLoginReply
7. [ ] PacketCheckNameRequest/PacketCheckNameReply (tunneled)
8. [ ] ForceDisconnect, Logout, ServerUpdate

**Testing Strategy**:
- Unit test each packet serialization/deserialization
- Integration test full login flow
- Packet capture comparison with C# server

### 1.4 Gateway Connection (Week 2-3)

**Packets** (4 packets):
- [ ] PacketLogin (Gateway authentication)
- [ ] PacketLoginReply
- [ ] PacketTunneledClientPacket (recursive parsing!)
- [ ] PacketTunneledClientWorldPacket

**Gateway-Login Communication** (4 custom packets):
- [ ] GatewayLoginRequest/Reply
- [ ] GatewayCharacterLogin/Logout

**Implementation**:
```elixir
defmodule Ryujin.GatewayServer do
  use GenServer

  # Registers with LoginServer on startup
  # Validates tickets from client
  # Routes game packets
end
```

### 1.5 World Entry Sequence (Week 3)

**Packets** (~12 packets):
- [ ] PacketClientIsReady
- [ ] PacketSendSelfToClient (player's own data)
- [ ] PacketSendZoneDetails (zone info)
- [ ] PacketInitializationParameters
- [ ] PacketZoneDoneSendingInitialData
- [ ] PacketGameTimeSync
- [ ] PacketClientBeginZoning
- [ ] PacketClientFinishedLoading
- [ ] PacketSetLocale
- [ ] PacketMOTD
- [ ] ReferenceDataPacket subpackets (item classes, categories, profiles)

**Milestone**: Client can log in and enter world!

---

## Phase 2: Core Gameplay (3-4 weeks)

**Goal**: Players can move, chat, see each other

### 2.1 Movement System (Week 4)

**Packets**:
- [ ] PlayerUpdatePacketUpdatePosition (most critical!)
- [ ] PlayerUpdatePacketJump
- [ ] PlayerUpdatePacketCameraUpdate
- [ ] PacketWorldTeleportRequest
- [ ] PacketZoneTeleportRequest
- [ ] PacketZoneSafeTeleportRequest

**Zone System**:
```elixir
defmodule Ryujin.Zone do
  use GenServer

  # Spatial partitioning (tile-based grid)
  # Entity tracking via ETS
  # Visibility calculation (2-tile radius)
  # 10Hz position update broadcast
end
```

**Optimizations**:
- [ ] Dead reckoning (predict movement between updates)
- [ ] Area of Interest (only send updates for visible entities)
- [ ] Position compression (use integer grid coordinates)

### 2.2 Entity Visibility (Week 4-5)

**Packets**:
- [ ] PlayerUpdatePacketAddPc (huge packet! ~40 fields)
- [ ] PlayerUpdatePacketAddNpc
- [ ] PlayerUpdatePacketRemovePlayer
- [ ] PlayerUpdatePacketRemovePlayerGracefully
- [ ] PlayerUpdatePacketNpcRelevance

**Implementation**:
```elixir
defmodule Ryujin.Visibility do
  @moduledoc """
  Manages what each player can see.
  Uses ETS for fast lookups.
  """

  # Calculate visible tiles
  # Send AddPc for entering entities
  # Send RemovePlayer for leaving entities
  # Update on position change
end
```

### 2.3 Chat System (Week 5)

**Packets** (BaseChatPacket - OpCode 15):
- [ ] PacketChat (11 channel types)
- [ ] ChatPacketFromStringId
- [ ] TellEchoPacket

**QuickChat** (BaseQuickChatPacket - OpCode 67):
- [ ] QuickChatSendDataPacket
- [ ] QuickChatSendTellPacket
- [ ] QuickChatSendChatToChannelPacket

**Channels**:
- WorldSay, Tell, System, Whisper, GroupSay
- WorldShout, WorldTrade, WorldLfg, WorldArea
- GuildSay, WorldMembersOnly

**Implementation**:
```elixir
defmodule Ryujin.Chat do
  # PubSub-based channel system
  # Per-player channel subscriptions
  # Spam protection (rate limiting)
  # Message history (last 100 per channel)
end
```

### 2.4 Command System (Week 6)

**Packets** (BaseCommandPacket - OpCode 26):
- [ ] CommandPacketInteractionList
- [ ] CommandPacketInteractionSelect
- [ ] CommandPacketInteractRequest
- [ ] CommandPacketSelectPlayer (targeting)
- [ ] CommandPacketSetProfile
- [ ] CommandPacketSetChatBubbleColor
- [ ] CommandPacketChatChannelOn/Off

**Interactions**:
- [ ] NPC interactions (shop, quest, dialogue)
- [ ] Player interactions (trade, inspect, duel)
- [ ] Object interactions (chests, doors)

### 2.5 Client Updates (Week 6-7)

**Packets** (BaseClientUpdatePacket - OpCode 38):
- [ ] ClientUpdatePacketHitpoints
- [ ] ClientUpdatePacketMana
- [ ] ClientUpdatePacketUpdateStat (73 stat types!)
- [ ] ClientUpdatePacketCoinCount
- [ ] ClientUpdatePacketUpdateLocation
- [ ] ClientUpdatePacketActivateProfile
- [ ] ClientUpdatePacketUpdateActionBarSlot

**Milestone**: Players can move, chat, and interact!

---

## Phase 3: Inventory & Items (2-3 weeks)

**Goal**: Full inventory and equipment system

### 3.1 Item System (Week 8)

**Data Structures**:
- [ ] ItemRecord (DefinitionID + Tint)
- [ ] ItemInstance (full item data)
- [ ] ItemDefinition (27MB JSON file!)
- [ ] ItemCategoryDefinition
- [ ] ItemClassDefinition

**Packets** (BaseClientUpdatePacket):
- [ ] ClientUpdatePacketItemAdd
- [ ] ClientUpdatePacketItemUpdate
- [ ] ClientUpdatePacketItemDelete
- [ ] ClientUpdatePacketEquipItem
- [ ] ClientUpdatePacketUnequipSlot

### 3.2 Inventory Management (Week 8-9)

**Packets** (BaseInventoryPacket - OpCode 42):
- [ ] InventoryPacketEquipByGuid
- [ ] InventoryPacketEquipByItemRecord
- [ ] InventoryPacketEquippedRemove
- [ ] InventoryPacketItemActionBarAssign
- [ ] InventoryPacketUseStyleCard
- [ ] InventoryPacketPreviewStyleCard

**Implementation**:
```elixir
defmodule Ryujin.Inventory do
  # Slot-based system (backpack, bank, equipped)
  # Stack management (stackable items)
  # Weight/capacity limits
  # Item durability
end
```

### 3.3 Equipment Visuals (Week 9)

**Packets** (PlayerUpdatePacket):
- [ ] PlayerUpdatePacketEquipItemChange
- [ ] PlayerUpdatePacketEquippedItemsChange
- [ ] PlayerUpdatePacketCustomizationChange
- [ ] PlayerUpdatePacketCustomizationData
- [ ] PlayerUpdatePacketSlotCompositeEffectOverride

**Character Attachments**:
- [ ] Weapon models
- [ ] Armor visuals
- [ ] Cosmetic items

### 3.4 NPC Shops (Week 10)

**Packets** (BaseCoinStorePacket - OpCode 165):
- [ ] CoinStoreItemListPacket
- [ ] CoinStoreItemDefinitionsRequest/Response
- [ ] CoinStoreSellToClientRequest
- [ ] CoinStoreBuyFromClientRequest
- [ ] CoinStoreTransactionCompletePacket
- [ ] CoinStoreItemDynamicListUpdateRequest/Response

**Milestone**: Full inventory and shopping system!

---

## Phase 4: Social Features (2 weeks)

**Goal**: Friends, ignore, inspect, titles

### 4.1 Friends System (Week 11)

**Packets** (BaseFriendPacket - OpCode 74):
- [ ] FriendListPacket
- [ ] FriendOnlinePacket
- [ ] FriendOfflinePacket
- [ ] FriendUpdatePositionsPacket
- [ ] FriendAddPacket
- [ ] FriendRemovePacket
- [ ] FriendMessagePacket
- [ ] FriendStatusPacket
- [ ] FriendRenamePacket

**Commands** (BaseCommandPacket):
- [ ] CommandPacketAddFriendRequest
- [ ] CommandPacketRemoveFriendRequest
- [ ] CommandPacketConfirmFriendRequest/Response
- [ ] CommandPacketFriendsPositionRequest

**Database**:
- Already have friends table (migrations from legacy)
- Friend status tracking (online/offline/game)

### 4.2 Ignore List (Week 11)

**Packets** (BaseIgnorePacket - OpCode 112):
- [ ] IgnoreListPacket
- [ ] IgnoreAddPacket
- [ ] IgnoreRemovePacket

**Command**:
- [ ] CommandPacketIgnoreRequest

### 4.3 Player Inspection (Week 12)

**Packets** (BaseInspectPacket - OpCode 149):
- [ ] StartInspectPacket
- [ ] StopInspectPacket

**Data**:
- [ ] InspectProxy (equipment, stats, titles)

### 4.4 Titles & Profiles (Week 12)

**Packets** (BasePlayerTitlePacket - OpCode 152):
- [ ] PlayerTitleRequestSelectPacket
- [ ] PlayerTitleUpdateAllPacket

**PlayerUpdate**:
- [ ] PlayerUpdatePacketPlayerTitle

**Profiles** (ReferenceDataPacket):
- [ ] ReferenceDataPacketClientProfileData

**Milestone**: Full social system!

---

## Phase 5: Advanced Features (3-4 weeks)

**Goal**: Mounts, housing, cash shop, abilities

### 5.1 Mounts (Week 13)

**Packets** (MountBasePacket - OpCode 168):
- [ ] PacketMountList
- [ ] PacketMountSpawn
- [ ] PacketMountSpawnByItemDefinitionId
- [ ] PacketMountResponse
- [ ] PacketDismountRequest
- [ ] PacketDismountResponse

**Implementation**:
- Mount speed modifiers
- Mount models/visuals
- Dismount on damage

### 5.2 Housing (Week 14-15)

**Packets** (BaseHousingPacket - OpCode 127):
- [ ] ClientHousingPacketSetEditMode
- [ ] ClientHousingPacketEnterRequest
- [ ] HousingPacketInstanceData
- [ ] HousingPacketInstanceList
- [ ] HousingPacketFixtureItemList
- [ ] HousingPacketUpdateHouseInfo
- [ ] HousingPacketZoneData

**Features**:
- Instanced housing zones
- Furniture placement
- Permissions system
- Housing editor

### 5.3 Cash Shop (Week 16)

**Packets** (PacketBaseInGamePurchase - OpCode 66):
- 23 subpackets for store system
- Bundle definitions
- Currency codes (country/state)
- Wallet info
- Purchase flow

**Integration**:
- External payment processing (mock for now)
- Transaction logging
- Item delivery

### 5.4 Abilities & Combat (Week 17)

**Packets** (BaseAbilityPacket - OpCode 36):
- [ ] AbilityPacketClientRequestStartAbility
- [ ] AbilityPacketFailed

**Encounters** (BaseEncounterPacket - OpCode 41):
- [ ] EncounterOverworldCombatPacket

**Implementation**:
- Ability definitions
- Cooldown tracking
- Target validation
- Damage calculation
- Stat system (73 stats!)

**Milestone**: Feature parity achieved! 🎉

---

## Phase 6: Optimization & Beyond (Ongoing)

**Goal**: Surpass C# implementation

### 6.1 Performance Optimizations

**Elixir Advantages**:
- [ ] ETS-based caching for game data (items, zones, mounts)
- [ ] Process-per-player isolation (no shared state bugs)
- [ ] Hot code reloading (update game logic without restarts)
- [ ] Distributed Erlang (cluster multiple servers)
- [ ] Per-process GC (no global GC pauses)

**Specific Optimizations**:
```elixir
# Replace JSON parsing with binary protocols
defmodule Ryujin.Resources.FastLoader do
  # Convert JSON to Erlang Term Format (.etf)
  # Load into ETS at startup
  # 10-100x faster lookups than C# dictionaries with locks
end

# Spatial indexing with ETS ordered_set
defmodule Ryujin.Zone.SpatialIndex do
  # Grid-based spatial partitioning
  # O(1) neighbor lookups
  # Lock-free reads
end

# Connection pooling for database
# Use Ecto's built-in pooling (10x better than C#'s DbContextFactory)
```

### 6.2 Observability (Elixir Superpower!)

```elixir
# Real-time metrics dashboard
defmodule Ryujin.Telemetry do
  # Track every packet type (latency, frequency)
  # Zone population heatmaps
  # Connection metrics (bandwidth, packet loss)
  # Player behavior analytics
end

# LiveView dashboard (built-in!)
defmodule RyujinCoreWeb.AdminLive do
  # Real-time server stats
  # Player list with instant teleport/kick
  # Item spawning
  # Broadcast messages
  # Hot code reload button
end
```

### 6.3 Developer Experience

**Tools**:
- [ ] Packet capture/replay tool (record→replay client sessions)
- [ ] Protocol fuzzer (find edge cases)
- [ ] Load tester (spawn 1000s of bot connections)
- [ ] GM commands via IEx (interactive admin console)

**Documentation**:
- [ ] ExDoc API docs for all modules
- [ ] Packet format documentation (auto-generated)
- [ ] Contribution guide
- [ ] Architecture decision records (ADRs)

### 6.4 New Features (Beyond C#)

**Elixir-Enabled Features**:

1. **Distributed World**:
   - Multiple zones on different nodes
   - Cross-zone chat/friends
   - Load balancing (spawn zones on least-loaded node)

2. **Time-Travel Debugging**:
   - Record all packets for 24 hours
   - Replay any player session
   - Find bugs by rewinding time

3. **A/B Testing**:
   - Hot-swap game logic per player
   - Test balance changes on 10% of players
   - Real-time analytics

4. **Scripting Engine**:
   - Elixir DSL for quests/NPCs
   - Hot-reload quest content
   - Sandboxed player scripts (building minigames)

5. **Protocol Versioning**:
   - Support multiple client versions simultaneously
   - Gradual rollout of protocol changes

---

## Metrics & Milestones

### Definition of Done for Each Phase

**Phase 1**: Can authenticate and enter world ✅
**Phase 2**: Can move and chat with other players ✅
**Phase 3**: Can manage inventory and buy from shops ✅
**Phase 4**: Can add friends and use titles ✅
**Phase 5**: Can use mounts, housing, and abilities ✅
**Phase 6**: Surpasses C# in performance and features ✅

### Success Metrics

- **Compatibility**: Can connect official client to Elixir server
- **Performance**: Handle 10,000 concurrent connections (C# caps at ~2,000)
- **Latency**: <50ms average packet processing (C# ~100ms)
- **Memory**: <50MB per 1,000 connections (C# ~150MB)
- **Uptime**: 99.9% uptime (hot code reload = no downtime deploys)

---

## Tools & Automation

### Packet Generator

```bash
# Auto-generate Elixir packets from C# source
mix ryujin.gen.packet \
  --source legacy/src/Sanctuary.Packet/PacketChat.cs \
  --output lib/ryujin_core/packets/chat.ex

# Generates:
# - Struct definition
# - Serialization function
# - Deserialization function
# - Type specs
# - Documentation
# - Unit tests
```

### Packet Capture Tool

```elixir
# lib/ryujin_core/tools/packet_capture.ex
defmodule Ryujin.Tools.PacketCapture do
  @moduledoc """
  Captures packets between client and server.
  Outputs to .pcap format for Wireshark analysis.
  """

  # Start capturing
  # Filter by player, packet type, or time range
  # Export to JSON for analysis
  # Replay captured sessions
end
```

### Protocol Tester

```elixir
# test/protocol_test.exs
defmodule RyujinProtocolTest do
  use ExUnit.Case

  test "login flow matches C# byte-for-byte" do
    # Send LoginRequest
    # Assert LoginReply matches reference
    # Compare binary output with captured C# traffic
  end
end
```

---

## Continuous Integration

```yaml
# .github/workflows/ci.yml
- Run all tests
- Check code formatting (mix format --check-formatted)
- Check warnings (mix compile --warnings-as-errors)
- Run Credo (code quality)
- Run Dialyzer (type checking)
- Generate ExDoc documentation
- Deploy to staging on main branch
```

---

## Timeline Summary

| Phase | Duration | Milestone |
|-------|----------|-----------|
| 0: Foundation | 1 week | Project setup ✅ |
| 1: Core Protocol | 3 weeks | Login & world entry |
| 2: Core Gameplay | 4 weeks | Movement, chat, commands |
| 3: Inventory & Items | 3 weeks | Full inventory system |
| 4: Social Features | 2 weeks | Friends, titles, inspect |
| 5: Advanced Features | 4 weeks | Mounts, housing, combat |
| 6: Optimization | Ongoing | Surpass C# |

**Total**: ~17 weeks to feature parity
**Then**: Continuous improvement and new features

---

## Next Immediate Steps

1. ✅ Fix migration error
2. [ ] Implement UDP reliability layer (Week 1 priority)
3. [ ] Create packet generator tool
4. [ ] Port ExternalLogin packets (17 packets)
5. [ ] Build packet routing system
6. [ ] Implement LoginServer GenServer
7. [ ] Test login flow end-to-end

Let's get started! 🚀
