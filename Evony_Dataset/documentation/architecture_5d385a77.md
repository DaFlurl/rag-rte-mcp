# BORG TOOLKIT - Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           BORG TOOLKIT ARCHITECTURE                          │
└─────────────────────────────────────────────────────────────────────────────┘

                              ┌──────────────┐
                              │  run_borg.py │
                              │   (Launcher) │
                              └──────┬───────┘
                                     │
        ┌────────────────────────────┼────────────────────────────┐
        │                            │                            │
        ▼                            ▼                            ▼
┌───────────────┐          ┌───────────────┐          ┌───────────────┐
│  connection   │          │   injection   │          │   exploits    │
│     .py       │          │      .py      │          │      .py      │
├───────────────┤          ├───────────────┤          ├───────────────┤
│ • EvonyConn   │          │ • PacketForge │          │ • FoodExploit │
│ • PacketLog   │◄────────►│ • SignatureGen│◄────────►│ • Overflow    │
│ • SessionState│          │ • Injector    │          │ • ItemDupe    │
│ • MultiSession│          │               │          │ • RaceCondition│
└───────────────┘          └───────────────┘          └───────────────┘
        │                            │                            │
        │                            │                            │
        └────────────────────────────┼────────────────────────────┘
                                     │
                                     ▼
                          ┌───────────────┐
                          │    cheats     │
                          │      .py      │
                          ├───────────────┤
                          │ • ResourceChts│
                          │ • TroopCheats │
                          │ • ItemCheats  │
                          │ • SpeedCheats │
                          │ • CheatEngine │
                          └───────────────┘


┌─────────────────────────────────────────────────────────────────────────────┐
│                              DATA FLOW                                       │
└─────────────────────────────────────────────────────────────────────────────┘

┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│  User    │───►│ Launcher │───►│ Exploit  │───►│ Injector │───►│  Server  │
│  Input   │    │          │    │ Module   │    │          │    │          │
└──────────┘    └──────────┘    └──────────┘    └──────────┘    └──────────┘
                                                      │
                                                      ▼
                                               ┌──────────┐
                                               │  Packet  │
                                               │  Forger  │
                                               └────┬─────┘
                                                    │
                    ┌───────────────────────────────┼───────────────────────┐
                    │                               │                       │
                    ▼                               ▼                       ▼
             ┌──────────┐                    ┌──────────┐            ┌──────────┐
             │ Overflow │                    │  Race    │            │ Negative │
             │ Packets  │                    │ Condition│            │  Value   │
             └──────────┘                    │ Packets  │            │ Packets  │
                                             └──────────┘            └──────────┘


┌─────────────────────────────────────────────────────────────────────────────┐
│                          EXPLOIT EXECUTION FLOW                              │
└─────────────────────────────────────────────────────────────────────────────┘

TROOP GLITCH (Overflow):
┌──────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│   1. CALCULATE          2. FORGE              3. INJECT           4. PROFIT  │
│   ┌──────────┐         ┌──────────┐          ┌──────────┐       ┌──────────┐│
│   │ threshold│────────►│ produce  │─────────►│ send to  │──────►│ RESOURCE ││
│   │ = INT32/ │         │ packet   │          │ server   │       │   GAIN   ││
│   │   cost   │         │ overflow │          │          │       │          ││
│   └──────────┘         └──────────┘          └────┬─────┘       └──────────┘│
│                                                   │                         │
│                                                   ▼                         │
│                                              ┌──────────┐                   │
│                                              │  cancel  │                   │
│                                              │  packet  │                   │
│                                              └──────────┘                   │
└──────────────────────────────────────────────────────────────────────────────┘


RACE CONDITION (Item Dupe):
┌──────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│   ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐          │
│   │ Packet 1│  │ Packet 2│  │ Packet 3│  │ Packet 4│  │ Packet N│          │
│   └────┬────┘  └────┬────┘  └────┬────┘  └────┬────┘  └────┬────┘          │
│        │            │            │            │            │                │
│        └────────────┴─────┬──────┴────────────┴────────────┘                │
│                           │                                                 │
│                           ▼  (SIMULTANEOUS)                                 │
│                    ┌──────────────┐                                         │
│                    │    SERVER    │                                         │
│                    │  Processes   │                                         │
│                    │  All Before  │                                         │
│                    │  Decrement   │                                         │
│                    └──────────────┘                                         │
│                           │                                                 │
│                           ▼                                                 │
│                    ┌──────────────┐                                         │
│                    │  Item Used   │                                         │
│                    │   N Times    │                                         │
│                    │ Only 1 Lost  │                                         │
│                    └──────────────┘                                         │
└──────────────────────────────────────────────────────────────────────────────┘


┌─────────────────────────────────────────────────────────────────────────────┐
│                           PROTOCOL STRUCTURE                                 │
└─────────────────────────────────────────────────────────────────────────────┘

AMF Packet Format:
┌────────────┬─────────────────────────────────────────────────────────────────┐
│  4 bytes   │                        N bytes                                  │
│  (length)  │                     (AMF payload)                               │
├────────────┼─────────────────────────────────────────────────────────────────┤
│            │  ┌─────────────────────────────────────────────────────────┐    │
│  Big-      │  │  {                                                      │    │
│  Endian    │  │    "cmd": "troop.produceTroop",                         │    │
│  uint32    │  │    "data": {                                            │    │
│            │  │      "castleId": 12345,                                 │    │
│            │  │      "positionId": 1,                                   │    │
│            │  │      "troopType": 6,                                    │    │
│            │  │      "num": 6135037,  // OVERFLOW VALUE                 │    │
│            │  │      "isShare": false,                                  │    │
│            │  │      "toIdle": true                                     │    │
│            │  │    }                                                    │    │
│            │  │  }                                                      │    │
│            │  └─────────────────────────────────────────────────────────┘    │
└────────────┴─────────────────────────────────────────────────────────────────┘


┌─────────────────────────────────────────────────────────────────────────────┐
│                          ENCRYPTION FLOW                                     │
└─────────────────────────────────────────────────────────────────────────────┘

Password Authentication:
┌──────────┐     ┌──────────┐     ┌──────────┐     ┌──────────┐
│ Password │────►│  + salt  │────►│   MD5    │────►│ pwd_hash │
│  "pass"  │     │ "evony"  │     │   hash   │     │          │
└──────────┘     └──────────┘     └──────────┘     └──────────┘

Action Signature:
┌──────────┐     ┌──────────┐     ┌──────────┐     ┌──────────┐
│ command  │────►│+ params  │────►│+ ACTION  │────►│   MD5    │
│ + params │     │          │     │   _KEY   │     │ signature│
└──────────┘     └──────────┘     └──────────┘     └──────────┘


┌─────────────────────────────────────────────────────────────────────────────┐
│                           FILE STRUCTURE                                     │
└─────────────────────────────────────────────────────────────────────────────┘

BorgToolkit/
├── run_borg.py              # Main launcher (interactive menu)
├── src/
│   ├── __init__.py          # Package init
│   ├── connection.py        # Server connection & packet capture
│   ├── injection.py         # Packet forging & injection
│   ├── exploits.py          # Working exploit implementations
│   └── cheats.py            # Automated cheat sequences
├── docs/
│   ├── ACTION_PLAN.md       # Development roadmap
│   ├── EXPLOITS.md          # Exploit documentation
│   └── PROTOCOL.md          # Protocol reference
├── diagrams/
│   └── architecture.md      # This file
├── exploits/                # Standalone exploit scripts
├── network/                 # Network capture tools
└── cheats/                  # Cheat sequence files
```

---

## Component Descriptions

### connection.py
- `EvonyConnection`: Main connection class with AMF protocol support
- `PacketLog`: Logged packet data structure
- `SessionState`: Current session state tracking
- `MultiSessionManager`: Manage multiple accounts

### injection.py
- `SignatureGenerator`: Generate valid packet signatures
- `PacketForge`: Create exploit packets with proper signatures
- `PacketInjector`: Inject packets into live connection

### exploits.py
- `FoodConsumptionExploit`: Valley hiding and upkeep bypass
- `ResourceOverflowExploit`: Integer overflow for resource gain
- `ItemDuplicationExploit`: Race condition item duplication
- `DropRateExploit`: Drop rate analysis and manipulation
- `BorgExploitEngine`: Master exploit controller

### cheats.py
- `ResourceCheats`: Food glitch, gold farm sequences
- `TroopCheats`: Free troops, troop saving sequences
- `ItemCheats`: Item dupe, amulet exploit sequences
- `SpeedCheats`: Instant build/research sequences
- `BorgCheatEngine`: Master cheat controller

---

*Generated by Borg Toolkit v2.0*
