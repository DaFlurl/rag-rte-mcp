# Evony Knowledge RAG System

**Retrieval-Augmented Generation for Evony Reverse Engineering**

> **Updated: January 11, 2026**

## Model Purpose

The Evony LLM was trained **EXCLUSIVELY** for:
- ✅ **Reverse engineering** AS3/Flash source code (2009-2018)
- ✅ **Script creation** for bots (Autoevony, Roboevony)
- ✅ **Exploits/CVEs** - 1,358 verified CVEs, 1,476 overflow exploits
- ✅ **Packet editing** & protocol manipulation
- ❌ **NOT trained on gameplay** - won't answer "how to play"

## Current Stats

| Component | Count |
|-----------|-------|
| **Chunks** | 16,962 |
| **Embeddings** | 16,962 x 768 dims |
| **KG Entities** | 101,853 |
| **KG Relationships** | 346,398 |
| **Training Examples** | 766,822 |

## Quick Start

```bash
# 1. Install dependencies
SETUP_EVONY_RAG.bat

# 2. Choose your interface:
python -m evony_rag.gradio_ui   # Web UI with feedback (RECOMMENDED)
python -m evony_rag.cli         # Interactive CLI
python -m evony_rag.mcp_server  # MCP server for Windsurf/Claude
```

## Architecture (Updated Jan 2026)

```
┌─────────────────────────────────────────────────────────────┐
│                PRECISION RAG SYSTEM v2.0                     │
├─────────────────────────────────────────────────────────────┤
│  ┌──────────────────┐    ┌────────────────────────────────┐ │
│  │ Question Formatter│───▶│ Vague→Training Format         │ │
│  │ (15 patterns)     │    │ "troop glitch" → proper query │ │
│  └──────────────────┘    └────────────────────────────────┘ │
│           │                                                  │
│           ▼                                                  │
│  ┌─────────────────────────────────────────────────────────┐│
│  │              HYBRID RETRIEVAL                            ││
│  │  ┌───────────┐  ┌──────────────┐  ┌─────────────────┐  ││
│  │  │ Lexical   │  │ Semantic     │  │ Knowledge Graph │  ││
│  │  │ (BM25)    │  │ (Embeddings) │  │ (101K entities) │  ││
│  │  └───────────┘  └──────────────┘  └─────────────────┘  ││
│  └─────────────────────────────────────────────────────────┘│
│           │                                                  │
│           ▼                                                  │
│  ┌─────────────────────────────────────────────────────────┐│
│  │              CROSS-ENCODER RERANKING                     ││
│  │  - LM Studio relevance scoring                          ││
│  │  - Heuristic boosting (exact match, definitions)        ││
│  └─────────────────────────────────────────────────────────┘│
│           │                                                  │
│           ▼                                                  │
│  ┌─────────────────────────────────────────────────────────┐│
│  │              PRECISION ANSWER SYSTEM                     ││
│  │  - Confidence scoring (0-100%)                          ││
│  │  - Citation extraction                                   ││
│  │  - Hallucination detection                              ││
│  │  - Answer caching                                        ││
│  │  - Self-consistency (multi-answer consensus)            ││
│  └─────────────────────────────────────────────────────────┘│
├─────────────────────────────────────────────────────────────┤
│  INTERFACES                                                  │
│  ┌───────────┐  ┌────────────┐  ┌────────────────────────┐ │
│  │ Gradio UI │  │  MCP Server│  │    CLI                 │ │
│  │ + Feedback│  │ (8 tools)  │  │                        │ │
│  └───────────┘  └────────────┘  └────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## Interfaces

### 1. CLI (`EVONY_RAG_CLI.bat`)

Interactive terminal interface:

```
[You]: How does the troop overflow glitch work?

[Evony Knowledge]:
The troop overflow exploit occurs when...

📚 Sources:
  📄 exploits/GLITCH_MECHANICS.md:45-89 (94%)
  📄 source_code/TroopController.as:234-267 (87%)

[intent: exploit_info | model: lmstudio]
```

Commands:
- `/find <query>` - Find relevant files
- `/stats` - Index statistics
- `/nollm` - Toggle LLM mode
- `/rebuild` - Rebuild index

### 2. HTTP API (`EVONY_RAG_API.bat`)

OpenAI-compatible API on `http://localhost:8766`:

```bash
# Chat completion (OpenAI-compatible)
curl http://localhost:8766/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"messages": [{"role": "user", "content": "What is ACTION_KEY?"}]}'

# Direct RAG query
curl http://localhost:8766/query \
  -d '{"query": "army.newArmy parameters"}'

# Find files
curl http://localhost:8766/find \
  -d '{"query": "encryption", "top_k": 5}'
```

**LM Studio Integration:**
1. Run `EVONY_RAG_API.bat`
2. In LM Studio, set Custom API Base: `http://localhost:8766/v1`
3. Ask questions - RAG context is automatically injected

### 3. MCP Server (`mcp_server_v2.py`)

For Windsurf/Claude Desktop integration:

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

**MCP Tools (8 total):**
| Tool | Purpose |
|------|---------|
| `evony.search` | Hybrid lexical+semantic search |
| `evony.answer` | LLM-generated answer |
| `evony.precision` | Verified answer with citations |
| `evony.feedback` | **NEW** Submit user feedback |
| `evony.open` | Read source file |
| `evony.symbol` | Find symbol |
| `evony.mode` | Set query mode |
| `evony.stats` | Get statistics |

## New Features (Jan 2026)

### 1. Question Formatter (`question_formatter.py`)
Transforms vague questions into training-compatible format:
```python
# 15 patterns including:
"What does the {entity} class/function do in Evony?"
"How do I exploit {entity} in Evony?"
"What CVE affects {entity}?"
"Write a script to {action}"
```

### 2. Cross-Encoder Reranking (`reranker.py`)
- LM Studio-based relevance scoring (0-10)
- Heuristic boosting for exact matches, definitions
- Integrated in precision_rag.py

### 3. Feedback Loop (`feedback_loop.py`)
- Collect correct/incorrect/partial ratings
- Export corrections for fine-tuning
- Persists to `G:\evony_rag_index\user_feedback.json`

### 4. ChromaDB Integration (`chroma_search.py`)
- Optional vector database
- Non-destructive addition
- Self-hosted persistence

### 5. Self-Consistency
- Multi-answer consensus
- `query_with_consensus(question, num_answers=3)`

## Training Data

| Category | Count |
|----------|-------|
| **Total Examples** | 766,822 |
| **Source Code** | 120,645 |
| **Script-Related** | 15,764 |
| **ActionScript** | 6,468 |
| **Protocol** | 3,530 |
| **Verified CVEs** | 1,358 |
| **Overflow Exploits** | 1,476 |

## Files (Updated)

```
evony_rag/
├── precision_rag.py      # ✅ Main RAG system with all features
├── question_formatter.py # ✅ NEW - Vague→training format
├── feedback_loop.py      # ✅ NEW - User feedback collection
├── reranker.py           # ✅ UPDATED - Cross-encoder added
├── chroma_search.py      # ✅ NEW - ChromaDB integration
├── gradio_ui.py          # ✅ UPDATED - Feedback buttons
├── mcp_server_v2.py      # ✅ UPDATED - 8 tools
├── hybrid_search.py      # Lexical + semantic search
├── knowledge_graph.py    # 101K entity KG
├── query_expansion.py    # Query expansion
├── embeddings.py         # Vector index
├── cli.py                # CLI interface
└── index/
    └── chunks.json       # 16,962 chunks
```

## Benchmark Results (Jan 11, 2026)

| Metric | Score |
|--------|-------|
| Answer Rate | 60% |
| Grounded | 70% |
| Avg Confidence | 78% |
| Features Working | 100% (5/5) |
| **Overall** | **69% GOOD** |

## Best Questions to Ask

```python
# Works well (reverse engineering focus):
"troop glitch how to use?"
"food glitch script"
"farmNPC script command"
"SendTroops function"
"AMF3 packet decode"

# Won't work well (gameplay - not trained):
"how do I play Evony?"
"best troop combo?"
```
