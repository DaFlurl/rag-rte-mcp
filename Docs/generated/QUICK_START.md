# Evony Development Quick Start Guide

## 🚀 Getting Started in 5 Minutes

### 1. Understanding the Architecture

```
┌─────────────────┐     AMF/HTTP     ┌─────────────────┐
│  EvonyClient    │ ◄──────────────► │   Game Server   │
│  (Flash/AS3)    │                  │                 │
└─────────────────┘                  └─────────────────┘
        │
        │ Commands
        ▼
┌─────────────────┐
│   AutoEvony     │
│   (C# Bot)      │
└─────────────────┘
```

### 2. Key Directories

| Directory | Contents |
|-----------|----------|
| `source_code/` | Decompiled AS3 source |
| `keys/` | Configuration, keys, constants |
| `scripts/` | AutoEvony bot scripts |
| `protocol/` | Protocol definitions |
| `evony_rag/` | RAG knowledge system |
| `evony_hub/` | Master toolkit GUI |

### 3. Essential Files

```
Commands:
├── CommonCommands.as      # Login, server
├── ArmyCommands.as        # Military
├── CastleCommands.as      # Building
├── HeroCommands.as        # Heroes
└── TroopCommands.as       # Training

Beans (Data Classes):
├── PlayerInfoBean.as      # Player data
├── CastleBean.as          # City data
├── HeroBean.as            # Hero data
├── ArmyBean.as            # Army data
└── TroopBean.as           # Troop data

Constants:
├── BuildingConstants.as   # Building IDs
├── TroopType.as           # Troop IDs
├── ErrorCode.as           # Error codes
└── MissionType.as         # Mission types
```

### 4. Common Tasks

#### Send Troops to Attack
```actionscript
// Using army.newArmy
var troops:Object = {
    6: 1000,   // 1000 Archers
    8: 500     // 500 Cataphracts
};

ArmyCommands.newArmy(
    heroId,           // Hero to lead
    castleId,         // Your castle
    targetX * 1000 + targetY,  // Target coords
    1,                // MissionType.ATTACK
    troops,
    null              // No resources
);
```

#### Train Troops
```actionscript
// Using troop.produceTroop
TroopCommands.produceTroop(
    castleId,
    6,        // TroopType.ARCHER
    1000,     // Amount
    0         // Queue slot
);
```

#### Research Technology
```actionscript
TechCommands.research(castleId, techType);
```

### 5. AutoEvony Scripts

Basic script structure:
```
// Script commands
train a:1000          // Train 1000 archers
attack 500:500        // Attack coords 500,500
build barracks        // Build barracks
research military     // Research military tech
wait 3600            // Wait 1 hour
```

### 6. Using the RAG System

```bash
# CLI Mode
python -m evony_rag.cli_v2

# API Mode (port 8766)
python -m evony_rag.api_v2

# Query examples:
> What is army.newArmy?
> How do I train archers?
> What are the troop types?
```

### 7. Using the Evony Hub

```bash
# Launch GUI
python -m evony_hub.gui

# Or use batch file
RUN_EVONY_HUB.bat
```

### 8. Encryption Keys

```python
ACTION_KEY = "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"
API_KEY = "9f758e2deccbe6244f734371b9642eda"
XOR_KEY = 0xAA
```

---

## 📚 Next Steps

1. Read `docs/API_REFERENCE.md` for full protocol docs
2. Explore `source_code/` for implementation details
3. Try the RAG system for quick answers
4. Use Evony Hub for advanced operations

---

*Generated: 2026-01-05T10:37:53.978479*
