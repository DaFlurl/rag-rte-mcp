#!/usr/bin/env python3
"""
Comprehensive Documentation Generator
Generates complete API docs, guides, and references for Evony
"""

import os
import json
import re
from pathlib import Path
from datetime import datetime
from typing import Dict, List

BASE_DIR = Path(__file__).parent.parent
DOCS_DIR = BASE_DIR / "docs"
OUTPUT_DIR = DOCS_DIR / "generated"


class DocGenerator:
    """Generates comprehensive documentation"""
    
    def __init__(self):
        self.docs_generated = []
        OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
        
    def generate_api_reference(self):
        """Generate complete API reference"""
        
        doc = """# Evony Protocol API Reference

> Auto-generated documentation for Evony client-server protocol

## Overview

The Evony protocol uses AMF (Action Message Format) over HTTP for client-server communication.
All commands follow the pattern: `category.command`

---

## Command Categories

| Category | Description | Example |
|----------|-------------|---------|
| `common` | Login, server info | `common.login` |
| `castle` | Castle management | `castle.getAvailableBuildingListInside` |
| `city` | City operations | `city.modifyCityName` |
| `hero` | Hero management | `hero.tryGetSeizedHero` |
| `army` | Military commands | `army.newArmy` |
| `troop` | Troop training | `troop.produceTroop` |
| `tech` | Research | `tech.research` |
| `alliance` | Alliance ops | `alliance.create` |
| `fortifications` | Defenses | `fortifications.produceWallProtect` |
| `quest` | Quest system | `quest.award` |
| `shop` | Item shop | `shop.buy` |
| `trade` | Trading | `trade.newTrade` |
| `field` | World map | `field.getOtherFieldInfo` |

---

## Core Commands

### army.newArmy
Create a new army for attack or transport.

**Parameters:**
| Name | Type | Description |
|------|------|-------------|
| `heroId` | int | Hero leading the army |
| `castleId` | int | Source castle ID |
| `targetPoint` | int | Target coordinates (x * 1000 + y) |
| `missionType` | int | 1=attack, 2=transport, 3=scout, 4=reinforce |
| `troops` | Object | Troop composition (troopType: count) |
| `resources` | Object | Resources to send (optional) |

**Response:** `army.newArmyResponse`
- `ok`: 1 if success
- `errorCode`: Error code if failed
- `army`: ArmyBean with army details

**Error Codes:**
- `-1`: Invalid hero
- `-2`: Insufficient troops
- `-3`: Hero busy
- `-10`: Target invalid

---

### troop.produceTroop
Train troops in barracks.

**Parameters:**
| Name | Type | Description |
|------|------|-------------|
| `castleId` | int | Castle ID |
| `troopType` | int | Type of troop (see TroopType) |
| `num` | int | Number to train |
| `queueId` | int | Queue slot (0-4) |

**Troop Types:**

1 = Worker, 2 = Warrior, 3 = Scout, 4 = Pikeman,
5 = Swordsman, 6 = Archer, 7 = Cavalry, 8 = Cataphract,
9 = Transporter, 10 = Ballista, 11 = Ram, 12 = Catapult

**Error Codes:**
- `-1`: Invalid castle
- `-2`: Insufficient resources
- `-3`: Queue full
- `-4`: Barracks level too low

---

### castle.getAvailableBuildingListInside
Get buildable structures for castle interior.

**Parameters:**
| Name | Type | Description |
|------|------|-------------|
| `castleId` | int | Castle ID |

**Response:** Array of BuildingBean objects

---

### hero.tryGetSeizedHero
Attempt to capture NPC hero.

**Parameters:**
| Name | Type | Description |
|------|------|-------------|
| `heroId` | int | Target hero ID |
| `castleId` | int | Destination castle |

**Error Codes:**
- `-1`: Hero not available
- `-2`: No free hero slot
- `-51`: Already captured

---

### tech.research
Start research on technology.

**Parameters:**
| Name | Type | Description |
|------|------|-------------|
| `castleId` | int | Castle ID |
| `techType` | int | Technology type |

**Tech Types:**

Military: 1-10, Infrastructure: 11-20, Commerce: 21-30, Medicine: 31-40

---

## Bean Classes

### PlayerInfoBean
Player account information.

| Field | Type | Description |
|-------|------|-------------|
| `id` | int | Player ID |
| `name` | String | Player name |
| `level` | int | Player level |
| `prestige` | int | Prestige points |
| `honor` | int | Honor points |
| `gold` | int | Gold balance |
| `gems` | int | Gem balance |
| `allianceId` | int | Alliance ID (0 if none) |

### CastleBean
Castle/city data.

| Field | Type | Description |
|-------|------|-------------|
| `id` | int | Castle ID |
| `name` | String | Castle name |
| `level` | int | Town Hall level |
| `x` | int | X coordinate |
| `y` | int | Y coordinate |
| `resource` | ResourceBean | Current resources |
| `buildings` | Array | BuildingBean array |
| `heroes` | Array | HeroBean array |

### HeroBean
Hero information.

| Field | Type | Description |
|-------|------|-------------|
| `id` | int | Hero ID |
| `name` | String | Hero name |
| `level` | int | Hero level |
| `experience` | int | Current XP |
| `politics` | int | Politics stat |
| `attack` | int | Attack stat |
| `intelligence` | int | Intelligence stat |
| `status` | int | 0=idle, 1=mayor, 2=fighting... |

### ArmyBean
Army/march data.

| Field | Type | Description |
|-------|------|-------------|
| `id` | int | Army ID |
| `heroId` | int | Leading hero |
| `startX` | int | Origin X |
| `startY` | int | Origin Y |
| `targetX` | int | Target X |
| `targetY` | int | Target Y |
| `missionType` | int | Mission type |
| `troops` | Object | Troop composition |
| `arriveTime` | long | Arrival timestamp |

---

## Error Code Reference

| Code | Constant | Description |
|------|----------|-------------|
| `-1` | INVALID_PARAM | Invalid parameter |
| `-2` | INSUFFICIENT_RESOURCE | Not enough resources |
| `-3` | BUSY | Target is busy |
| `-4` | LEVEL_TOO_LOW | Level requirement not met |
| `-10` | INVALID_TARGET | Target doesn't exist |
| `-50` | PERMISSION_DENIED | No permission |
| `-51` | ALREADY_EXISTS | Already done |
| `-52` | ALLIANCE_NOT_FOUND | Alliance doesn't exist |
| `-100` | SERVER_ERROR | Internal server error |

---

## Response Handlers

All responses are dispatched through `ResponseDispatcher.as`:

Response handlers are mapped in ResponseDispatcher.as to callback functions
like onNewArmyResponse, onProduceResponse, onGetBuildingListResponse, etc.

---

*Generated: {timestamp}*
"""
        
        content = doc.replace("{timestamp}", datetime.now().isoformat())
        output_path = OUTPUT_DIR / "API_REFERENCE.md"
        with open(output_path, "w", encoding="utf-8") as f:
            f.write(content)
        
        self.docs_generated.append(str(output_path))
        return output_path

    def generate_quick_start(self):
        """Generate quick start guide"""
        
        doc = """# Evony Development Quick Start Guide

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

*Generated: {timestamp}*
"""
        
        content = doc.replace("{timestamp}", datetime.now().isoformat())
        output_path = OUTPUT_DIR / "QUICK_START.md"
        with open(output_path, "w", encoding="utf-8") as f:
            f.write(content)
        
        self.docs_generated.append(str(output_path))
        return output_path

    def generate_training_guide(self):
        """Generate model training guide"""
        
        doc = """# Evony Model Training Guide

## Overview

This guide covers training a custom Evony knowledge model using QLoRA on Qwen2.5-VL-7B.

## Training Pipeline

```
Dataset (10k examples)
        │
        ▼
┌───────────────────┐
│  Data Preparation │  ← prepare_multitask.py
│  (RAG-native fmt) │
└───────────────────┘
        │
        ▼
┌───────────────────┐
│   QLoRA Training  │  ← train_runpod.py
│   (H100 80GB)     │
└───────────────────┘
        │
        ▼
┌───────────────────┐
│    Evaluation     │  ← evaluate.py
│   (vs base model) │
└───────────────────┘
        │
        ▼
┌───────────────────┐
│   LoRA Adapter    │  ← output/final/
│   (deployable)    │
└───────────────────┘
```

## Dataset Structure

### Task Buckets (RAG-Native)

| Bucket | Weight | Description |
|--------|--------|-------------|
| `gui_widget_map` | 20% | Screenshot → JSON widget map |
| `gui_action_plan` | 20% | Screenshot → step-by-step actions |
| `evidence_explain` | 15% | Code chunks → explanation + citations |
| `evidence_summarize` | 15% | Retrieved data → summary + citations |
| `patch_plan` | 10% | Evidence → patch plan + diff |
| `patch_validate` | 10% | Patch → validation tests |
| `query_synthesis` | 10% | Uncertainty → retrieval queries |

### Example Format

```json
{
  "messages": [
    {
      "role": "system",
      "content": "You explain code with citations..."
    },
    {
      "role": "user", 
      "content": "[EVIDENCE] Explain army.newArmy"
    },
    {
      "role": "assistant",
      "content": "The `army.newArmy` command... `@source_code/ArmyCommands.as:45-60`"
    }
  ],
  "task": "evidence_explain"
}
```

## Training Configuration

### QLoRA Settings (H100)

```python
CONFIG = {
    "model_name": "Qwen/Qwen2.5-VL-7B-Instruct",
    "max_seq_length": 16384,
    "load_in_4bit": True,
    "lora_r": 32,
    "lora_alpha": 64,
    "batch_size": 4,
    "gradient_accumulation": 4,
    "learning_rate": 2e-5,
    "num_epochs": 3,
}
```

### GPU Requirements

| GPU | VRAM | Time | Cost |
|-----|------|------|------|
| H100 80GB | 80GB | ~1 hr | ~$2.50 |
| A100 80GB | 80GB | ~1.5 hr | ~$3 |
| RTX 3090 | 24GB | ~3 hr | local |

## Running Training

### Option 1: RunPod (Recommended)

```bash
cd runpod
# Add API key to .env
RUN_RUNPOD.bat
```

### Option 2: Local (RTX 3090)

```bash
cd training
RUN_UNSLOTH.bat
```

## Evaluation Metrics

The trained model is evaluated on:

1. **Task Accuracy**: Correct task type responses
2. **Citation Rate**: % of responses with proper citations
3. **Uncertainty Gate**: Correctly refuses without evidence
4. **Code Quality**: Valid code/JSON generation

### Expected Improvements

| Metric | Base | Fine-tuned | Δ |
|--------|------|------------|---|
| Evony Knowledge | 20% | 85% | +65% |
| Citation Format | 5% | 90% | +85% |
| Uncertainty Gate | 10% | 80% | +70% |
| Code Generation | 30% | 75% | +45% |

## Using the Trained Model

### With LoRA Adapter

```python
from transformers import AutoModelForCausalLM
from peft import PeftModel

base = AutoModelForCausalLM.from_pretrained("Qwen/Qwen2.5-VL-7B-Instruct")
model = PeftModel.from_pretrained(base, "./output/final")
```

### Merged Model

```python
model = AutoModelForCausalLM.from_pretrained("./output/merged")
```

---

*Generated: {timestamp}*
"""
        
        content = doc.replace("{timestamp}", datetime.now().isoformat())
        output_path = OUTPUT_DIR / "TRAINING_GUIDE.md"
        with open(output_path, "w", encoding="utf-8") as f:
            f.write(content)
        
        self.docs_generated.append(str(output_path))
        return output_path

    def run_all(self):
        """Generate all documentation"""
        print("="*60)
        print("DOCUMENTATION GENERATOR")
        print(f"Started: {datetime.now()}")
        print("="*60)
        
        print(f"\nOutput: {OUTPUT_DIR}")
        
        self.generate_api_reference()
        print("✓ API Reference generated")
        
        self.generate_quick_start()
        print("✓ Quick Start guide generated")
        
        self.generate_training_guide()
        print("✓ Training Guide generated")
        
        print(f"\n✅ Documentation complete!")
        print(f"Files generated: {len(self.docs_generated)}")
        
        return self.docs_generated


def main():
    generator = DocGenerator()
    generator.run_all()


if __name__ == "__main__":
    main()
