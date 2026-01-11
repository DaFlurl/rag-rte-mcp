# Advanced Reverse Engineering Automation Framework

## Borg Swarm Agent-Driven Full Extraction System

---

## 🎯 Vision Statement

A fully automated, distributed reverse engineering platform powered by Borg Swarm Agents that extracts, decrypts, analyzes, and reconstructs **everything** from the Evony game protocol in real-time.

**Goal**: Complete protocol mastery enabling private server creation, bot automation, and game modification.

---

## 📊 Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                        BORG SWARM RE AUTOMATION FRAMEWORK                                │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                          │
│  ┌─────────────────────────────────────────────────────────────────────────────────────┐│
│  │                              SWARM COORDINATOR                                       ││
│  │                                                                                      ││
│  │   Distributes RE tasks across agents, aggregates findings, manages key rotation     ││
│  │                                                                                      ││
│  └─────────────────────────────────────────────────────────────────────────────────────┘│
│                                        │                                                 │
│         ┌──────────────────────────────┼──────────────────────────────┐                 │
│         │                              │                              │                 │
│         ▼                              ▼                              ▼                 │
│  ┌─────────────────┐          ┌─────────────────┐          ┌─────────────────┐         │
│  │ CAPTURE AGENT   │          │ ANALYSIS AGENT  │          │ EXTRACTION AGENT│         │
│  │                 │          │                 │          │                 │         │
│  │ • MITM Proxy    │          │ • PacketType    │          │ • GameState     │         │
│  │ • Packet Logger │          │   Detector      │          │ • PlayerInfo    │         │
│  │ • Traffic Tap   │          │ • Protocol      │          │ • Commands      │         │
│  │ • SSL Intercept │          │   Analyzer      │          │ • Security      │         │
│  │                 │          │ • Pattern Match │          │                 │         │
│  └────────┬────────┘          └────────┬────────┘          └────────┬────────┘         │
│           │                            │                            │                   │
│           └────────────────────────────┼────────────────────────────┘                   │
│                                        │                                                 │
│                                        ▼                                                 │
│  ┌─────────────────────────────────────────────────────────────────────────────────────┐│
│  │                           COLLECTIVE MEMORY                                          ││
│  │                                                                                      ││
│  │   ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐           ││
│  │   │ Key Vault    │  │ Protocol DB  │  │ Game State   │  │ Command Map  │           ││
│  │   │              │  │              │  │              │  │              │           ││
│  │   │ • XOR Keys   │  │ • PacketTypes│  │ • Map Coords │  │ • Attack     │           ││
│  │   │ • AES Keys   │  │ • Structures │  │ • Resources  │  │ • Build      │           ││
│  │   │ • Blowfish   │  │ • Validation │  │ • Troops     │  │ • Research   │           ││
│  │   │ • RSA Keys   │  │ • Patterns   │  │ • Buildings  │  │ • Trade      │           ││
│  │   │ • Session    │  │              │  │ • Alliances  │  │ • March      │           ││
│  │   └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘           ││
│  │                                                                                      ││
│  └─────────────────────────────────────────────────────────────────────────────────────┘│
│                                                                                          │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## 🔧 Core Components

### 1. Packet Capture Layer

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           PACKET CAPTURE LAYER                                   │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                  │
│   GAME CLIENT                                                                    │
│       │                                                                          │
│       │ HTTPS/WSS (Encrypted)                                                   │
│       ▼                                                                          │
│   ┌─────────────────────────────────────────────────────────────────────────┐   │
│   │                         MITM PROXY (Port 8888)                           │   │
│   │                                                                          │   │
│   │  ┌─────────────┐   ┌─────────────┐   ┌─────────────┐   ┌─────────────┐  │   │
│   │  │ SSL/TLS     │   │ Traffic     │   │ Packet      │   │ Real-time   │  │   │
│   │  │ Termination │──►│ Splitter    │──►│ Queue       │──►│ Decoder     │  │   │
│   │  │             │   │             │   │             │   │             │  │   │
│   │  │ • Cert Gen  │   │ • Duplicate │   │ • Buffer    │   │ • AMF       │  │   │
│   │  │ • Key Exch  │   │ • Forward   │   │ • Priority  │   │ • JSON      │  │   │
│   │  │ • Decrypt   │   │ • Log       │   │ • Filter    │   │ • XML       │  │   │
│   │  └─────────────┘   └─────────────┘   └─────────────┘   └─────────────┘  │   │
│   │                                                                          │   │
│   └──────────────────────────────────┬──────────────────────────────────────┘   │
│                                      │                                          │
│                                      ▼                                          │
│   ┌─────────────────────────────────────────────────────────────────────────┐   │
│   │                         PACKET LOGGER                                    │   │
│   │                                                                          │   │
│   │   • Raw packet storage (before/after decrypt)                           │   │
│   │   • Timestamp with microsecond precision                                │   │
│   │   • Direction tagging (client→server, server→client)                    │   │
│   │   • Packet correlation (request→response matching)                      │   │
│   │   • Searchable index by packet type, command, time                      │   │
│   │                                                                          │   │
│   └─────────────────────────────────────────────────────────────────────────┘   │
│                                      │                                          │
│                                      ▼                                          │
│                              EVONY SERVERS                                      │
│                                                                                  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### 2. PacketTypeDetector

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                          PACKET TYPE DETECTOR                                    │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                  │
│  INPUT: Raw Decrypted Packet                                                    │
│         │                                                                        │
│         ▼                                                                        │
│  ┌─────────────────────────────────────────────────────────────────────────┐    │
│  │                      HEADER ANALYZER                                     │    │
│  │                                                                          │    │
│  │   Byte 0-1: Protocol Version                                            │    │
│  │   Byte 2-3: Packet Length                                               │    │
│  │   Byte 4-5: Command ID                                                  │    │
│  │   Byte 6-7: Sequence Number                                             │    │
│  │   Byte 8+:  Payload                                                     │    │
│  └──────────────────────────────────┬──────────────────────────────────────┘    │
│                                     │                                           │
│                                     ▼                                           │
│  ┌─────────────────────────────────────────────────────────────────────────┐    │
│  │                      PACKET CLASSIFICATION                               │    │
│  │                                                                          │    │
│  │   ┌─────────────────────────────────────────────────────────────────┐   │    │
│  │   │ COMMAND PACKETS (Client → Server)                                │   │    │
│  │   │                                                                  │   │    │
│  │   │  0x0001  LOGIN_REQUEST     │  0x0101  CITY_BUILD                │   │    │
│  │   │  0x0002  LOGOUT            │  0x0102  CITY_UPGRADE              │   │    │
│  │   │  0x0010  ATTACK_SEND       │  0x0103  CITY_DEMOLISH             │   │    │
│  │   │  0x0011  ATTACK_CANCEL     │  0x0201  RESEARCH_START            │   │    │
│  │   │  0x0020  MARCH_CREATE      │  0x0202  RESEARCH_CANCEL           │   │    │
│  │   │  0x0021  MARCH_RECALL      │  0x0301  TROOP_TRAIN               │   │    │
│  │   │  0x0030  SCOUT_SEND        │  0x0302  TROOP_DISMISS             │   │    │
│  │   │  0x0040  TRADE_CREATE      │  0x0401  ALLIANCE_JOIN             │   │    │
│  │   │  0x0041  TRADE_CANCEL      │  0x0402  ALLIANCE_LEAVE            │   │    │
│  │   └─────────────────────────────────────────────────────────────────┘   │    │
│  │                                                                          │    │
│  │   ┌─────────────────────────────────────────────────────────────────┐   │    │
│  │   │ RESPONSE PACKETS (Server → Client)                               │   │    │
│  │   │                                                                  │   │    │
│  │   │  0x8001  LOGIN_RESPONSE    │  0x8101  BUILD_RESULT              │   │    │
│  │   │  0x8010  ATTACK_RESULT     │  0x8201  RESEARCH_RESULT           │   │    │
│  │   │  0x8020  MARCH_UPDATE      │  0x8301  TRAIN_RESULT              │   │    │
│  │   │  0x8030  SCOUT_REPORT      │  0x8401  ALLIANCE_UPDATE           │   │    │
│  │   │  0x8040  TRADE_RESULT      │  0x9001  WORLD_MAP_UPDATE          │   │    │
│  │   │  0x8050  CHAT_MESSAGE      │  0x9002  PLAYER_UPDATE             │   │    │
│  │   │  0x8060  MAIL_RECEIVED     │  0x9003  RESOURCE_UPDATE           │   │    │
│  │   └─────────────────────────────────────────────────────────────────┘   │    │
│  │                                                                          │    │
│  │   ┌─────────────────────────────────────────────────────────────────┐   │    │
│  │   │ HEARTBEAT/SYSTEM PACKETS                                         │   │    │
│  │   │                                                                  │   │    │
│  │   │  0xF001  KEEPALIVE_PING    │  0xF003  SERVER_TIME               │   │    │
│  │   │  0xF002  KEEPALIVE_PONG    │  0xF004  VERSION_CHECK             │   │    │
│  │   └─────────────────────────────────────────────────────────────────┘   │    │
│  └──────────────────────────────────────────────────────────────────────────┘    │
│                                                                                  │
│  OUTPUT: PacketInfo { type, command, payload, direction, timestamp }            │
│                                                                                  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### 3. Data Extraction Pipeline

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                        DATA EXTRACTION PIPELINE                                  │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                  │
│  DECODED PACKET                                                                 │
│       │                                                                          │
│       ▼                                                                          │
│  ┌─────────────────────────────────────────────────────────────────────────┐    │
│  │                      EXTRACTION ROUTER                                   │    │
│  └──────────────────────────────────┬──────────────────────────────────────┘    │
│                                     │                                           │
│      ┌──────────────┬───────────────┼───────────────┬──────────────┐           │
│      │              │               │               │              │           │
│      ▼              ▼               ▼               ▼              ▼           │
│  ┌────────┐    ┌────────┐    ┌────────────┐   ┌────────┐    ┌────────┐        │
│  │GAME    │    │PLAYER  │    │ COMMAND    │   │SECURITY│    │MAP     │        │
│  │STATE   │    │INFO    │    │ PROTOCOL   │   │PARAMS  │    │DATA    │        │
│  │        │    │        │    │            │   │        │    │        │        │
│  │• Rsrc  │    │• Profile│   │• Validation│   │• Keys  │    │• Coords│        │
│  │• Troops│    │• Alliance│  │• Parameters│   │• Salts │    │• NPCs  │        │
│  │• Builds│    │• Cities │   │• Responses │   │• Tokens│    │• Tiles │        │
│  │• Tech  │    │• Heros  │   │• Errors    │   │• Rotate│    │• Zones │        │
│  └────┬───┘    └────┬───┘    └─────┬──────┘   └────┬───┘    └────┬───┘        │
│       │             │              │               │             │             │
│       └─────────────┴──────────────┼───────────────┴─────────────┘             │
│                                    │                                            │
│                                    ▼                                            │
│  ┌─────────────────────────────────────────────────────────────────────────┐    │
│  │                     COLLECTIVE DATABASE                                  │    │
│  │                                                                          │    │
│  │   game_state.db  │  players.db  │  protocols.db  │  security.db        │    │
│  │                                                                          │    │
│  └─────────────────────────────────────────────────────────────────────────┘    │
│                                                                                  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## 🔐 Security Parameter Extraction

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                      SECURITY PARAMETER EXTRACTOR                                │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                  │
│  ┌─────────────────────────────────────────────────────────────────────────┐    │
│  │                     KEY EXTRACTION SOURCES                               │    │
│  │                                                                          │    │
│  │   SOURCE                 │ KEYS EXTRACTED          │ UPDATE FREQUENCY   │    │
│  │   ──────────────────────┼─────────────────────────┼───────────────────  │    │
│  │   EvonyClient.swf       │ XOR, AES, SHA1 Salt     │ Per version        │    │
│  │   AutoEvony.swf         │ Blowfish, Chat, Token   │ Per version        │    │
│  │   Login Handshake       │ Session, RSA Public     │ Per session        │    │
│  │   Server Response       │ Dynamic keys            │ Per request        │    │
│  │   Config Files          │ Static keys, salts      │ On change          │    │
│  │                                                                          │    │
│  └─────────────────────────────────────────────────────────────────────────┘    │
│                                                                                  │
│  ┌─────────────────────────────────────────────────────────────────────────┐    │
│  │                     KEY ROTATION DETECTION                               │    │
│  │                                                                          │    │
│  │   Monitor Pattern:                                                       │    │
│  │   ┌─────────────────────────────────────────────────────────────────┐   │    │
│  │   │                                                                  │   │    │
│  │   │  Session Start ──► Key A ──► [packets] ──► Rotation Signal ──►  │   │    │
│  │   │                                                                  │   │    │
│  │   │  ──► Key B ──► [packets] ──► Rotation Signal ──► Key C ──►      │   │    │
│  │   │                                                                  │   │    │
│  │   └─────────────────────────────────────────────────────────────────┘   │    │
│  │                                                                          │    │
│  │   Detection Methods:                                                     │    │
│  │   • Packet counter threshold (rotate every N packets)                   │    │
│  │   • Time-based rotation (rotate every M minutes)                        │    │
│  │   • Server-initiated rotation (special packet type)                     │    │
│  │   • Failed decryption trigger (key has rotated)                         │    │
│  │                                                                          │    │
│  └─────────────────────────────────────────────────────────────────────────┘    │
│                                                                                  │
│  ┌─────────────────────────────────────────────────────────────────────────┐    │
│  │                     PASSWORD HASH EXTRACTION                             │    │
│  │                                                                          │    │
│  │   Login Flow Analysis:                                                   │    │
│  │                                                                          │    │
│  │   Client                          Server                                 │    │
│  │     │                               │                                    │    │
│  │     │──── Login Request ───────────►│                                    │    │
│  │     │     { user, hash(pass+salt) } │                                    │    │
│  │     │                               │                                    │    │
│  │     │◄─── Challenge ────────────────│                                    │    │
│  │     │     { nonce, server_salt }    │                                    │    │
│  │     │                               │                                    │    │
│  │     │──── Response ─────────────────►                                    │    │
│  │     │     { hash(nonce+prev_hash) } │                                    │    │
│  │     │                               │                                    │    │
│  │     │◄─── Session Token ────────────│                                    │    │
│  │     │     { token, session_key }    │                                    │    │
│  │                                                                          │    │
│  │   Extracted:                                                             │    │
│  │   • Client-side salt (from SWF)                                         │    │
│  │   • Server-side salt (from challenge)                                   │    │
│  │   • Hash algorithm (SHA1/SHA256/MD5)                                    │    │
│  │   • Iteration count (if PBKDF2)                                         │    │
│  │                                                                          │    │
│  └─────────────────────────────────────────────────────────────────────────┘    │
│                                                                                  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## 📦 Full Extraction Categories

### What Gets Extracted

| Category | Data Points | Update Frequency | Storage |
|----------|-------------|------------------|---------|
| **Game State** | Resources, troops, buildings, tech | Real-time | game_state.db |
| **Player Info** | Profile, alliance, heroes, items | Per login | players.db |
| **Map Data** | Coordinates, tiles, NPCs, valleys | Per view | map_data.db |
| **Command Protocols** | Attack, build, research params | On discovery | protocols.db |
| **Server Responses** | Validation rules, error codes | On occurrence | responses.db |
| **Security Params** | Keys, salts, tokens, rotation | On change | security.db |
| **Chat/Mail** | Messages, alliance comms | Real-time | comms.db |
| **Events** | Quests, events, rewards | Per update | events.db |

---

## 🤖 Borg Swarm RE Agents

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                          BORG SWARM RE AGENTS                                    │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                  │
│  ┌─────────────────────────────────────────────────────────────────────────┐    │
│  │                        AGENT TYPES                                       │    │
│  │                                                                          │    │
│  │   ┌────────────────┐                                                    │    │
│  │   │ CAPTURE AGENT  │  Role: Intercept and log all traffic              │    │
│  │   │                │                                                    │    │
│  │   │  • Run MITM proxy on assigned port                                 │    │
│  │   │  • Log all packets with timestamps                                 │    │
│  │   │  • Forward to Analysis agents                                      │    │
│  │   │  • Handle SSL/TLS termination                                      │    │
│  │   └────────────────┘                                                    │    │
│  │                                                                          │    │
│  │   ┌────────────────┐                                                    │    │
│  │   │ DECRYPT AGENT  │  Role: Real-time decryption of all packets        │    │
│  │   │                │                                                    │    │
│  │   │  • Pull keys from Key Vault                                        │    │
│  │   │  • Decrypt incoming packets                                        │    │
│  │   │  • Detect key rotation                                             │    │
│  │   │  • Report new keys to vault                                        │    │
│  │   └────────────────┘                                                    │    │
│  │                                                                          │    │
│  │   ┌────────────────┐                                                    │    │
│  │   │ ANALYSIS AGENT │  Role: Protocol analysis and pattern detection    │    │
│  │   │                │                                                    │    │
│  │   │  • Classify packet types                                           │    │
│  │   │  • Map command structures                                          │    │
│  │   │  • Identify validation patterns                                    │    │
│  │   │  • Discover new commands                                           │    │
│  │   └────────────────┘                                                    │    │
│  │                                                                          │    │
│  │   ┌────────────────┐                                                    │    │
│  │   │ EXTRACT AGENT  │  Role: Data extraction and storage                │    │
│  │   │                │                                                    │    │
│  │   │  • Parse game state from packets                                   │    │
│  │   │  • Extract player information                                      │    │
│  │   │  • Store in collective database                                    │    │
│  │   │  • Update world state model                                        │    │
│  │   └────────────────┘                                                    │    │
│  │                                                                          │    │
│  │   ┌────────────────┐                                                    │    │
│  │   │ INJECT AGENT   │  Role: Command crafting and injection             │    │
│  │   │                │                                                    │    │
│  │   │  • Build valid command packets                                     │    │
│  │   │  • Encrypt with current keys                                       │    │
│  │   │  • Inject into traffic stream                                      │    │
│  │   │  • Validate responses                                              │    │
│  │   └────────────────┘                                                    │    │
│  │                                                                          │    │
│  └─────────────────────────────────────────────────────────────────────────┘    │
│                                                                                  │
│  ┌─────────────────────────────────────────────────────────────────────────┐    │
│  │                     SWARM COORDINATION                                   │    │
│  │                                                                          │    │
│  │   Account 1 ──► [Capture] ──► [Decrypt] ──► [Analysis] ──► [Extract]   │    │
│  │        │                                         │                       │    │
│  │        │         ┌───────────────────────────────┘                       │    │
│  │        │         │                                                       │    │
│  │        │         ▼                                                       │    │
│  │   Account 2 ──► [Capture] ──► [Decrypt] ──►─┬──► [Analysis] ──►─┐       │    │
│  │        │                                    │                    │       │    │
│  │        │                                    │                    ▼       │    │
│  │   Account 3 ──► [Capture] ──► [Decrypt] ──►─┴──► COLLECTIVE ◄───┘       │    │
│  │                                                   MEMORY                 │    │
│  │                                                                          │    │
│  │   Benefits:                                                              │    │
│  │   • Multiple viewpoints (different accounts see different data)         │    │
│  │   • Parallel processing (faster extraction)                             │    │
│  │   • Redundancy (one agent fails, others continue)                       │    │
│  │   • Cross-validation (compare data across accounts)                     │    │
│  │                                                                          │    │
│  └─────────────────────────────────────────────────────────────────────────┘    │
│                                                                                  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## 📋 Implementation Milestones

### Phase 8.1: Packet Capture Infrastructure (Week 1)
- [ ] MITM Proxy with SSL termination
- [ ] Packet Logger with indexed storage
- [ ] Traffic splitter (forward + log)
- [ ] Real-time packet queue

### Phase 8.2: Protocol Analysis (Week 2)
- [ ] PacketTypeDetector implementation
- [ ] Command ID mapping
- [ ] Response correlation
- [ ] Pattern recognition engine

### Phase 8.3: Data Extraction (Week 3)
- [ ] Game State Extractor
- [ ] Player Info Extractor
- [ ] Map Data Extractor
- [ ] Command Protocol Mapper

### Phase 8.4: Security Analysis (Week 4)
- [ ] Key rotation detector
- [ ] Salt extraction
- [ ] Token management
- [ ] Dynamic key handler

### Phase 8.5: Borg Integration (Week 5)
- [ ] RE Agent types
- [ ] Swarm coordinator for RE
- [ ] Collective database
- [ ] Cross-account correlation

### Phase 8.6: Automation & UI (Week 6)
- [ ] Auto-extraction on login
- [ ] Live dashboard
- [ ] Export tools
- [ ] Private server data format

---

## 📁 New Files Required

```
src/
├── realtime/
│   ├── __init__.py              ✅ Done
│   ├── key_vault.py             ✅ Done
│   ├── crypto_engine.py         ✅ Done
│   ├── action_recorder.py       ✅ Done
│   ├── packet_interceptor.py    🔄 In Progress
│   ├── packet_logger.py         ⏳ Pending
│   ├── packet_type_detector.py  ⏳ Pending
│   ├── amf_codec.py             ⏳ Pending
│   ├── json_codec.py            ⏳ Pending
│   ├── xml_codec.py             ⏳ Pending
│   └── injection_system.py      ⏳ Pending
│
├── extraction/
│   ├── __init__.py              ⏳ Pending
│   ├── game_state_extractor.py  ⏳ Pending
│   ├── player_info_extractor.py ⏳ Pending
│   ├── map_data_extractor.py    ⏳ Pending
│   ├── command_mapper.py        ⏳ Pending
│   ├── security_extractor.py    ⏳ Pending
│   └── protocol_analyzer.py     ⏳ Pending
│
├── borg/
│   ├── re_agents/
│   │   ├── __init__.py          ⏳ Pending
│   │   ├── capture_agent.py     ⏳ Pending
│   │   ├── decrypt_agent.py     ⏳ Pending
│   │   ├── analysis_agent.py    ⏳ Pending
│   │   ├── extract_agent.py     ⏳ Pending
│   │   └── inject_agent.py      ⏳ Pending
│   └── re_coordinator.py        ⏳ Pending
│
└── ui/panels/
    ├── live_re_panel.py         ⏳ Pending
    ├── extraction_dashboard.py  ⏳ Pending
    └── protocol_browser.py      ⏳ Pending
```

---

## 🎯 Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Packet Capture Rate | 100% | All packets logged |
| Decryption Success | >95% | Packets successfully decrypted |
| Command Coverage | >90% | Known commands mapped |
| Extraction Latency | <100ms | Time from packet to database |
| Key Detection | 100% | All key rotations caught |
| Swarm Uptime | >99% | Agents running continuously |

---

*Advanced RE Automation Framework - Svony Studio v2.0*
