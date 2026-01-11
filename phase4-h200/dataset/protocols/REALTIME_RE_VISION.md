# 🔮 Svony Studio Real-Time Reverse Engineering Vision

## Executive Summary

**Vision**: Transform Svony Studio into a fully automated, real-time reverse engineering platform where users can log into Evony accounts, see live encrypted traffic on the left side, and instantly view decrypted/decoded data on the right side - with the ability to modify, inject, and replay traffic seamlessly using all extracted keys.

---

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         SVONY STUDIO MAIN INTERFACE                          │
├─────────────────────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────┐    ┌─────────────────────────────┐        │
│  │     LEFT PANEL (LIVE)       │    │    RIGHT PANEL (DECODED)     │        │
│  │                             │    │                              │        │
│  │  ┌─────────────────────┐   │    │  ┌─────────────────────┐    │        │
│  │  │ Flash Browser       │   │    │  │ Protocol Decoder    │    │        │
│  │  │ (AutoEvony.swf)     │◄──┼────┼──► AMF/JSON/XML View   │    │        │
│  │  │                     │   │    │  │ Decrypted Packets   │    │        │
│  │  │ • Live Game Session │   │    │  │ • Click Events      │    │        │
│  │  │ • User Interactions │   │    │  │ • Command Params    │    │        │
│  │  │ • Visual Feedback   │   │    │  │ • Server Responses  │    │        │
│  │  └─────────────────────┘   │    │  └─────────────────────┘    │        │
│  │                             │    │                              │        │
│  │  ┌─────────────────────┐   │    │  ┌─────────────────────┐    │        │
│  │  │ Action Recorder     │   │    │  │ Editor Panel        │    │        │
│  │  │ • Button Clicks     │   │    │  │ • Modify Values     │    │        │
│  │  │ • Menu Selections   │   │    │  │ • Re-encrypt        │    │        │
│  │  │ • Form Inputs       │   │    │  │ • Inject Commands   │    │        │
│  │  └─────────────────────┘   │    │  └─────────────────────┘    │        │
│  └─────────────────────────────┘    └─────────────────────────────┘        │
│                                                                              │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │                        MIDDLE CONTROL BAR                              │  │
│  │  [▶ Record] [⏸ Pause] [⏹ Stop] [🔄 Replay] [💉 Inject] [🔐 Keys]      │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │                    BORG COLLECTIVE STATUS BAR                          │  │
│  │  Agents: 12/12 Active │ Tasks: 847 │ Swarm: SYNCHRONIZED              │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 🔑 Key Management System

### Available Keys (Extracted from Client/Bot)

| Key Type | Source | Purpose | Real-Time Use |
|----------|--------|---------|---------------|
| **AMF Session Key** | Login Response | Encrypt/Decrypt AMF packets | ✅ Bidirectional |
| **XOR Key** | Client SWF | Obfuscate string data | ✅ Bidirectional |
| **Blowfish Key** | AutoEvony.swf | Sensitive data encryption | ✅ Bidirectional |
| **AES-256 Key** | Client Config | Premium content encryption | ✅ Bidirectional |
| **RSA Public** | Server Handshake | Initial key exchange | ✅ Receive only |
| **SHA1 Salt** | Client/Bot | Password hashing | ✅ Generate |
| **Token Secret** | Session | API authentication | ✅ Generate/Validate |
| **Chat Cipher** | Alliance Config | Chat encryption | ✅ Bidirectional |

### Key Flow Architecture

```
┌──────────────────────────────────────────────────────────────────┐
│                     KEY MANAGEMENT ENGINE                         │
├──────────────────────────────────────────────────────────────────┤
│                                                                   │
│   ┌─────────────┐     ┌─────────────┐     ┌─────────────┐       │
│   │ Key Store   │────►│ Key Router  │────►│ Crypto Core │       │
│   │             │     │             │     │             │       │
│   │ • AMF Keys  │     │ • Auto-     │     │ • Encrypt   │       │
│   │ • XOR Keys  │     │   detect    │     │ • Decrypt   │       │
│   │ • AES Keys  │     │   packet    │     │ • Hash      │       │
│   │ • Blowfish  │     │   type      │     │ • Verify    │       │
│   │ • Session   │     │ • Select    │     │             │       │
│   │   Tokens    │     │   correct   │     │             │       │
│   └─────────────┘     │   key       │     └─────────────┘       │
│                       └─────────────┘                            │
│                                                                   │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                  REAL-TIME PIPELINE                      │   │
│   │                                                          │   │
│   │   INCOMING:  Raw → Decrypt → Decode → Display → Log     │   │
│   │   OUTGOING:  Edit → Encode → Encrypt → Inject → Send    │   │
│   │                                                          │   │
│   └─────────────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────────────┘
```

---

## 📡 Protocol Interception System

### What Gets Captured

1. **Client → Server (Outgoing)**
   - Login credentials (pre-encryption)
   - Game commands (attack, build, research, etc.)
   - Chat messages
   - UI interactions (button clicks, menu selections)
   - API requests

2. **Server → Client (Incoming)**
   - Session tokens
   - Game state updates
   - World map data
   - Player data
   - Server responses
   - Push notifications

### Interception Points

```
┌────────────────────────────────────────────────────────────────┐
│                  TRAFFIC INTERCEPTION LAYER                     │
├────────────────────────────────────────────────────────────────┤
│                                                                 │
│   AutoEvony.swf                    Evony Server                │
│        │                                │                       │
│        │  ┌────────────────────────┐   │                       │
│        └──► MITM Proxy (localhost) ◄───┘                       │
│            │                       │                            │
│            │  • SSL/TLS Intercept  │                            │
│            │  • AMF Deserialization│                            │
│            │  • Packet Logging     │                            │
│            │  • Real-time Decode   │                            │
│            └────────────────────────┘                           │
│                        │                                        │
│            ┌───────────┴───────────┐                           │
│            ▼                       ▼                            │
│    ┌─────────────┐         ┌─────────────┐                     │
│    │ Live View   │         │ Decoder View│                     │
│    │ (Left)      │         │ (Right)     │                     │
│    └─────────────┘         └─────────────┘                     │
│                                                                 │
└────────────────────────────────────────────────────────────────┘
```

---

## 🎯 Feature Matrix: What's Possible vs Not Possible

### ✅ FULLY POSSIBLE (Bidirectional with Keys)

| Feature | Description | Implementation |
|---------|-------------|----------------|
| **Live Packet Decryption** | Decrypt all incoming traffic in real-time | Use extracted keys automatically |
| **Command Replay** | Record and replay any command | Store decrypted, re-encrypt on send |
| **Value Modification** | Change troop counts, resources, coordinates | Edit decoded AMF, re-encrypt |
| **Button Click Recording** | Log all UI interactions | Hook into SWF event system |
| **Custom Command Injection** | Send arbitrary commands to server | Craft AMF, encrypt, inject |
| **Chat Interception** | Read/send encrypted alliance chat | Decrypt with chat cipher |
| **Session Hijacking** | Use captured tokens in external tools | Extract from decrypted traffic |
| **Bot Script Generation** | Convert recorded actions to scripts | Pattern recognition on recordings |
| **Automated Farming** | NPC farming with real-time optimization | Command injection + response analysis |
| **Multi-Account Sync** | Coordinate Borg swarm via decrypted chat | Cross-session command routing |

### ⚠️ PARTIALLY POSSIBLE (Limitations)

| Feature | Limitation | Workaround |
|---------|------------|------------|
| **Server-Side Validation** | Can't bypass server checks | Stay within valid ranges |
| **Rate Limiting** | Server may throttle | Implement delays, rotate accounts |
| **Anti-Cheat Detection** | Unusual patterns flagged | Mimic human behavior patterns |
| **Dynamic Keys** | Keys may rotate per session | Auto-extract on each login |

### ❌ NOT POSSIBLE

| Feature | Why |
|---------|-----|
| **Server Memory Editing** | No server access |
| **Bypassing Server Logic** | Validation is server-side |
| **Creating Resources** | Server authoritative |
| **Infinite Troops** | Server tracks actual counts |

---

## 🛠️ Complete Feature List for Phase 8

### 8.1 Real-Time Crypto Engine

```python
# Features to implement:
- AutoKeyExtractor: Extract keys from SWF/login
- KeyRotationManager: Handle dynamic key changes
- MultiCipherSupport: XOR, AES, Blowfish, RSA
- PacketTypeDetector: Auto-detect encryption method
- RealTimeDecryptor: Zero-latency decryption pipeline
- RealTimeEncryptor: Seamless re-encryption for injection
```

### 8.2 Protocol Interceptor

```python
# Features to implement:
- MITMProxy: Local proxy for traffic interception
- AMFDeserializer: Parse Action Message Format
- JSONParser: Handle JSON API calls
- XMLDecoder: Parse XML responses
- BinaryInspector: Raw hex analysis
- PacketLogger: Full traffic logging with timestamps
```

### 8.3 Action Recorder

```python
# Features to implement:
- ClickCapture: Record all button/menu clicks
- FormCapture: Log all form inputs
- NavigationTracker: Track screen changes
- TimingRecorder: Capture delays between actions
- SequenceBuilder: Convert recordings to scripts
- PlaybackEngine: Replay recorded sessions
```

### 8.4 Live Injection System

```python
# Features to implement:
- CommandCrafter: Build valid game commands
- PacketInjector: Insert into traffic stream
- ResponseModifier: Alter server responses
- UITrigger: Programmatically click buttons
- HotPatcher: Modify SWF at runtime
- ButtonAdder: Inject new UI elements
```

### 8.5 Side-by-Side View

```python
# Features to implement:
- SplitPanelLayout: Resizable left/right panels
- SyncScrolling: Linked scrolling between views
- PacketHighlighter: Color-code packet types
- DiffViewer: Compare original vs decoded
- TreeView: Hierarchical packet structure
- HexView: Raw bytes with annotations
```

### 8.6 Borg Integration

```python
# Features to implement:
- SwarmRecorder: Distribute recording across agents
- CollectiveDecryption: Share keys across swarm
- SynchronizedInjection: Coordinated command sending
- ChatRelay: Inter-agent encrypted communication
- TaskDistributor: Parallelize analysis tasks
- PatternSharing: Share learned patterns
```

---

## 📊 Data Flow Diagram

```
┌─────────────────────────────────────────────────────────────────────────┐
│                           COMPLETE DATA FLOW                             │
└─────────────────────────────────────────────────────────────────────────┘

  USER INPUT                    SYSTEM PROCESSING                OUTPUT
  ──────────                    ──────────────────               ──────

  ┌─────────┐                                                  ┌──────────┐
  │ Login   │ ───► Extract Session Key ───► Store in KeyVault │ Ready    │
  └─────────┘                                                  └──────────┘
       │
       ▼
  ┌─────────┐    ┌──────────────┐    ┌───────────────┐    ┌──────────────┐
  │ Click   │───►│ Capture Event│───►│ Serialize Cmd │───►│ Encrypt      │
  │ Button  │    └──────────────┘    └───────────────┘    └──────────────┘
  └─────────┘                                                    │
       │                                                         ▼
       │         ┌──────────────┐    ┌───────────────┐    ┌──────────────┐
       └────────►│ Record Action│───►│ Log to History│───►│ Display Left │
                 └──────────────┘    └───────────────┘    └──────────────┘
                                                                 │
                                           ┌─────────────────────┘
                                           ▼
  ┌─────────┐    ┌──────────────┐    ┌───────────────┐    ┌──────────────┐
  │ Server  │───►│ Intercept    │───►│ Decrypt       │───►│ Decode AMF   │
  │ Response│    └──────────────┘    └───────────────┘    └──────────────┘
  └─────────┘                                                    │
                                                                 ▼
                                                          ┌──────────────┐
                                                          │ Display Right│
                                                          │ (Decoded)    │
                                                          └──────────────┘
                                                                 │
                 ┌───────────────────────────────────────────────┘
                 ▼
  ┌─────────┐    ┌──────────────┐    ┌───────────────┐    ┌──────────────┐
  │ Edit    │───►│ Modify Values│───►│ Re-encode AMF │───►│ Re-encrypt   │
  │ Decoded │    └──────────────┘    └───────────────┘    └──────────────┘
  └─────────┘                                                    │
                                                                 ▼
                                                          ┌──────────────┐
                                                          │ Inject to    │
                                                          │ Live Stream  │
                                                          └──────────────┘
```

---

## 🎮 Use Case Scenarios

### Scenario 1: Recording a Farm Run

```
1. User logs into account via Flash Browser (Left Panel)
2. System extracts session keys automatically
3. User sends army to NPC
4. Action Recorder captures:
   - Button click: "Attack"
   - Target selection: NPC coords
   - Troop selection: 100k archers
   - March command sent
5. Right Panel shows:
   - Decoded command: {"cmd": "march", "target": [123,456], "troops": {...}}
6. User can:
   - Save as bot script
   - Modify troop counts and replay
   - Analyze timing for optimization
```

### Scenario 2: Injecting a Custom Button

```
1. User designs button in Template System
2. Template generates ActionScript code
3. SWF Patcher applies to loaded AutoEvony.swf
4. Hot reload updates live session
5. New button appears in game UI
6. Button clicks are routed through injection system
7. Custom commands sent to server
```

### Scenario 3: Borg Swarm Coordination

```
1. 12 accounts logged in across Borg agents
2. Master account sends encrypted chat command
3. All agents decrypt via shared key
4. Coordinated attack launched
5. All traffic logged to collective memory
6. Patterns shared for ML optimization
```

---

## 🔧 Implementation Phases

### Phase 8.1: Core Infrastructure (Week 1)
- [ ] KeyVault implementation
- [ ] MITM Proxy setup
- [ ] Basic packet capture
- [ ] Left/Right panel split

### Phase 8.2: Decryption Pipeline (Week 2)
- [ ] AMF deserializer
- [ ] XOR decryption
- [ ] AES decryption
- [ ] Blowfish decryption
- [ ] Auto key detection

### Phase 8.3: Recording System (Week 3)
- [ ] Event hook system
- [ ] Action serialization
- [ ] Timeline view
- [ ] Playback engine

### Phase 8.4: Injection System (Week 4)
- [ ] Command builder
- [ ] Re-encryption pipeline
- [ ] Packet injection
- [ ] Response modification

### Phase 8.5: Advanced Features (Week 5)
- [ ] Script generation from recordings
- [ ] Hot patching SWF
- [ ] Button injection
- [ ] Borg integration

### Phase 8.6: Polish & Testing (Week 6)
- [ ] Performance optimization
- [ ] Error handling
- [ ] Unit tests
- [ ] Integration tests
- [ ] Documentation

---

## 📁 New Files Required

```
src/
├── realtime/
│   ├── __init__.py
│   ├── key_vault.py           # Key storage and management
│   ├── crypto_engine.py       # Real-time encryption/decryption
│   ├── packet_interceptor.py  # MITM proxy implementation
│   ├── amf_codec.py          # AMF serialization/deserialization
│   ├── action_recorder.py     # UI interaction recording
│   ├── playback_engine.py     # Action replay system
│   ├── injection_system.py    # Command injection
│   └── hot_patcher.py         # Runtime SWF modification
│
├── ui/panels/
│   ├── live_panel.py          # Left panel - Flash browser
│   ├── decoder_panel.py       # Right panel - Decoded view
│   ├── recorder_controls.py   # Recording toolbar
│   ├── packet_viewer.py       # Detailed packet inspection
│   └── injection_editor.py    # Command crafting UI
│
└── borg/
    ├── collective_crypto.py   # Shared key distribution
    ├── swarm_recorder.py      # Distributed recording
    └── sync_injection.py      # Coordinated command sending
```

---

## 🎯 Success Metrics

| Metric | Target |
|--------|--------|
| Packet decode latency | < 5ms |
| Recording accuracy | 100% of interactions |
| Injection success rate | > 95% |
| Key extraction time | < 2 seconds |
| Swarm sync delay | < 100ms |
| Script generation accuracy | > 90% |

---

## 🚀 Quick Start After Implementation

```python
# 1. Start Svony Studio
# 2. Click "Real-Time RE" tab
# 3. Load AutoEvony.swf in left panel
# 4. Login to account
# 5. Keys automatically extracted
# 6. All traffic visible in right panel (decoded)
# 7. Click Record to capture actions
# 8. Edit any packet and click Inject
# 9. Watch live game respond to injected commands
```

---

*This document defines the complete vision for real-time reverse engineering automation in Svony Studio.*
