# Evony Reverse Engineering Project

## Complete Knowledge System for Evony Game Analysis

---

## Project Overview

This project provides a comprehensive suite of tools for Evony game reverse engineering, including:

- **RAG Knowledge System** - AI-powered Q&A with citations
- **Curated Dataset** - 8,957 quality-filtered files
- **Training Pipeline** - LoRA fine-tuning setup
- **Protocol Tools** - 301+ AMF commands
- **Automation Hub** - Bot scripting and analysis

---

## Quick Start

### 1. RAG Knowledge System (Recommended)

```batch
:: Interactive CLI
EVONY_RAG_V2_CLI.bat

:: HTTP API for LM Studio
EVONY_RAG_V2_API.bat

:: MCP Server for Windsurf
EVONY_RAG_V2_MCP.bat
```

### 2. Evony Hub GUI

```batch
RUN_EVONY_HUB.bat
```

### 3. Train Custom Model (Tomorrow)

```batch
SETUP_EVONY_AI.bat    :: Install dependencies
TRAIN_EVONY_AI.bat    :: Start training (~2-3 hours)
CHAT_EVONY_AI.bat     :: Test model
```

---

## Directory Structure

```
Evony_Decrypted/
│
├── evony_rag/                  # RAG Knowledge System (NEW)
│   ├── docs/                   # Documentation
│   │   ├── ARCHITECTURE.md
│   │   ├── API_REFERENCE.md
│   │   ├── MCP_TOOLS_REFERENCE.md
│   │   ├── TRAINING_GUIDE.md
│   │   ├── TROUBLESHOOTING.md
│   │   └── QUICK_REFERENCE.md
│   ├── index/                  # Vector + BM25 indexes
│   └── *.py                    # RAG components
│
├── evony_ai/                   # Training Setup
│   ├── train_unsloth.py        # LoRA training script
│   ├── chat_evony.py           # Chat interface
│   └── requirements_unsloth.txt
│
├── evony_hub/                  # Master Toolkit
│   ├── gui.py                  # Unified GUI (7 tabs)
│   ├── server.py               # Script server (port 8088)
│   ├── borg_toolkit.py         # 301+ protocol commands
│   ├── data_curator.py         # Quality scoring
│   ├── build_curated_dataset.py
│   └── generate_training_data.py
│
├── Evony_Training_Dataset/     # Curated Knowledge Base
│   ├── source_code/            # 7,469 AS3/Python files
│   ├── keys/                   # 1,230 encryption files
│   ├── protocol/               # 85 protocol docs
│   ├── scripts/                # 106 bot scripts
│   ├── exploits/               # 26 glitch docs
│   └── metadata/
│       └── policy.yaml         # Access policy
│
├── Evony_Training_Data/        # Alpaca Format
│   └── training_data.json      # 36,370 Q&A pairs
│
├── BorgToolkit/                # Original Toolkit
│   ├── docs/                   # Protocol documentation
│   └── diagrams/               # Architecture diagrams
│
├── EvonyCommandCenter/         # 352 Commands GUI
├── EvonyMasterSuite/           # Browser Controller
├── FlashBrowser/               # Flash-enabled Browser
└── flash_toolkit_v2/           # Analysis Tools
```

---

## Launcher Scripts

| Script | Purpose | Port |
|--------|---------|------|
| `EVONY_RAG_V2_CLI.bat` | Interactive RAG terminal | - |
| `EVONY_RAG_V2_API.bat` | HTTP API server | 8766 |
| `EVONY_RAG_V2_MCP.bat` | Windsurf MCP server | 8765 |
| `RUN_EVONY_HUB.bat` | Evony Hub GUI | - |
| `SETUP_EVONY_AI.bat` | Install training deps | - |
| `TRAIN_EVONY_AI.bat` | Run LoRA training | - |
| `CHAT_EVONY_AI.bat` | Chat with trained model | - |
| `CURATE_EVONY_DATA.bat` | Run data curation | - |

---

## Port Allocation

| Service | Port | Description |
|---------|------|-------------|
| LM Studio | 1234 | Local LLM inference |
| RAG API | 8766 | OpenAI-compatible API |
| MCP Server | 8765 | Windsurf integration |
| Script Server | 8088 | AutoEvony scripts |

---

## Key Components

### 1. RAG Knowledge System (`evony_rag/`)

**Purpose:** AI-powered Q&A with source citations

**Features:**
- Hybrid search (BM25 + embeddings)
- 166,043 indexed chunks
- 55,871 code symbols
- Policy-based access control
- Multi-interface (CLI, API, MCP)

**Documentation:** See `evony_rag/docs/`

### 2. Curated Dataset (`Evony_Training_Dataset/`)

**Purpose:** Quality-filtered knowledge base

**Statistics:**
- 8,957 approved files
- ~90MB total size
- 6 categories

**Categories:**
| Category | Files | Description |
|----------|-------|-------------|
| source_code | 7,469 | AS3/Python source |
| keys | 1,230 | Encryption keys |
| protocol | 85 | Protocol specs |
| scripts | 106 | Bot scripts |
| exploits | 26 | Glitch docs |

### 3. Training Pipeline (`evony_ai/`)

**Purpose:** Fine-tune custom Evony model

**Configuration:**
- Base: Qwen2.5-3B-Instruct
- Method: LoRA (4-bit)
- Data: 36,370 examples
- Time: ~2-3 hours on RTX 3090 Ti

### 4. Evony Hub (`evony_hub/`)

**Purpose:** Unified toolkit GUI

**Features:**
- 7 tabs (Dashboard, Server, Exploits, Protocol, Scripts, Crypto, Tools)
- Script server for AutoEvony
- 301+ protocol commands
- Overflow calculator

---

## Encryption Keys

```python
ACTION_KEY = "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"
API_KEY = "9f758e2deccbe6244f734371b9642eda"
USER_INFO_KEY = "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}"
XOR_KEY = 0xAA
LOGIN_SALT = "evony"
```

---

## Overflow Thresholds

| Unit | Threshold | Formula |
|------|-----------|---------|
| Archer | 6,135,037 | INT32_MAX / 350 + 1 |
| Worker | 42,949,673 | INT32_MAX / 50 + 1 |
| Warrior | 21,474,837 | INT32_MAX / 100 + 1 |
| Scout | 14,316,558 | INT32_MAX / 150 + 1 |
| Catapult | 715,828 | INT32_MAX / 3000 + 1 |

---

## Windsurf MCP Integration

Add to `~/.codeium/windsurf/mcp_config.json`:

```json
{
  "mcpServers": {
    "evony-knowledge": {
      "command": "python",
      "args": ["-m", "evony_rag.mcp_server_v2"],
      "cwd": "c:\\Users\\Admin\\Downloads\\Evony_Decrypted"
    }
  }
}
```

**Available Tools:**
- `evony.search` - Hybrid search
- `evony.answer` - RAG answer with citations
- `evony.symbol` - Find definitions
- `evony.trace` - Multi-hop tracing
- `evony.open` - Get file content
- `evony.mode` - Set query mode
- `evony.stats` - Statistics

---

## LM Studio Setup

1. **Model:** `qwen3-vl-8b-instruct-abliterated-v2.0`
2. **Context:** 8K-16K tokens (80K available)
3. **Port:** 1234 (default)
4. **GPU:** Full offload (36/36 layers)
5. **VRAM:** ~22GB

---

## Workflow

### Research Workflow

1. Start RAG: `EVONY_RAG_V2_CLI.bat`
2. Query: "What is ACTION_KEY?"
3. Follow citations to source files
4. Use `/trace` for related code
5. Use `/symbol` for definitions

### Training Workflow

1. Setup: `SETUP_EVONY_AI.bat`
2. Train: `TRAIN_EVONY_AI.bat` (~2-3 hours)
3. Test: `CHAT_EVONY_AI.bat`
4. Export to GGUF for LM Studio (optional)

### Development Workflow

1. Open Windsurf with MCP enabled
2. Use `@evony-knowledge` tools
3. Get AI-assisted analysis with citations
4. Open source files directly from citations

---

## Next Steps

1. ✅ RAG system operational
2. ✅ MCP integration configured
3. ⏳ Fine-tuning (tomorrow)
4. ⏳ GGUF export for LM Studio
5. ⏳ Continuous dataset updates

---

## Documentation Index

| Document | Location |
|----------|----------|
| RAG Architecture | `evony_rag/docs/ARCHITECTURE.md` |
| API Reference | `evony_rag/docs/API_REFERENCE.md` |
| MCP Tools | `evony_rag/docs/MCP_TOOLS_REFERENCE.md` |
| Training Guide | `evony_rag/docs/TRAINING_GUIDE.md` |
| Troubleshooting | `evony_rag/docs/TROUBLESHOOTING.md` |
| Quick Reference | `evony_rag/docs/QUICK_REFERENCE.md` |
| Evony Hub | `evony_hub/README.md` |
| Protocol Docs | `BorgToolkit/docs/` |
