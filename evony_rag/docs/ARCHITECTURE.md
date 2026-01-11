# Evony Knowledge RAG - Architecture

## System Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         EVONY KNOWLEDGE SYSTEM                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐                   │
│  │   Windsurf   │    │  LM Studio   │    │     CLI      │                   │
│  │     IDE      │    │    Chat      │    │   Terminal   │                   │
│  └──────┬───────┘    └──────┬───────┘    └──────┬───────┘                   │
│         │                   │                   │                            │
│         │ MCP               │ HTTP              │ Direct                     │
│         │ :8765             │ :8766             │                            │
│         ▼                   ▼                   ▼                            │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                        INTERFACE LAYER                               │    │
│  │  ┌─────────────┐  ┌─────────────────┐  ┌─────────────┐              │    │
│  │  │ MCP Server  │  │  HTTP API (v2)  │  │  CLI (v2)   │              │    │
│  │  │ 7 tools     │  │  OpenAI-compat  │  │  Interactive│              │    │
│  │  └─────────────┘  └─────────────────┘  └─────────────┘              │    │
│  └─────────────────────────────┬───────────────────────────────────────┘    │
│                                │                                             │
│                                ▼                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                        RAG ENGINE (v2)                               │    │
│  │                                                                      │    │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                  │    │
│  │  │   Query     │  │   Policy    │  │  Response   │                  │    │
│  │  │   Router    │──│   Engine    │──│  Generator  │                  │    │
│  │  └─────────────┘  └─────────────┘  └─────────────┘                  │    │
│  │         │                │                │                          │    │
│  │         │                │                │                          │    │
│  │         ▼                ▼                ▼                          │    │
│  │  ┌───────────────────────────────────────────────────────────┐      │    │
│  │  │                   HYBRID SEARCH                            │      │    │
│  │  │                                                            │      │    │
│  │  │  ┌─────────────┐              ┌─────────────┐             │      │    │
│  │  │  │    BM25     │              │  Embeddings │             │      │    │
│  │  │  │  (Lexical)  │              │  (Semantic) │             │      │    │
│  │  │  │             │              │             │             │      │    │
│  │  │  │ - Exact     │              │ - Concept   │             │      │    │
│  │  │  │   symbols   │              │   matching  │             │      │    │
│  │  │  │ - Keywords  │              │ - Phrasing  │             │      │    │
│  │  │  │ - Code      │              │   variants  │             │      │    │
│  │  │  └──────┬──────┘              └──────┬──────┘             │      │    │
│  │  │         │                            │                    │      │    │
│  │  │         └──────────┬─────────────────┘                    │      │    │
│  │  │                    ▼                                      │      │    │
│  │  │         ┌─────────────────────┐                          │      │    │
│  │  │         │  Reciprocal Rank    │                          │      │    │
│  │  │         │      Fusion         │                          │      │    │
│  │  │         └─────────────────────┘                          │      │    │
│  │  └───────────────────────────────────────────────────────────┘      │    │
│  │                                                                      │    │
│  │  ┌─────────────┐                                                    │    │
│  │  │   Symbol    │  Multi-hop tracing, definition lookup              │    │
│  │  │   Index     │                                                    │    │
│  │  └─────────────┘                                                    │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                │                                             │
│                                ▼                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                        INDEX LAYER                                   │    │
│  │                                                                      │    │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌───────────┐  │    │
│  │  │ embeddings  │  │   chunks    │  │ bm25_index  │  │  symbol   │  │    │
│  │  │   .npy      │  │   .json     │  │   .json     │  │  _index   │  │    │
│  │  │ (166k×384)  │  │  metadata   │  │  inverted   │  │  55k syms │  │    │
│  │  └─────────────┘  └─────────────┘  └─────────────┘  └───────────┘  │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                │                                             │
│                                ▼                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                     CURATED DATASET                                  │    │
│  │                                                                      │    │
│  │  source_code/  protocol/  keys/  scripts/  exploits/  metadata/     │    │
│  │    7,469        85       1,230    106        26       policy.yaml   │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                          EXTERNAL SERVICES                                   │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │  LM Studio (localhost:1234)                                          │    │
│  │  Model: qwen3-vl-8b-instruct-abliterated-v2.0                       │    │
│  │  Context: 8K-80K tokens                                              │    │
│  │  GPU: RTX 3090 Ti (24GB) - 36/36 layers offloaded                   │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Data Flow

### Query Processing

```
User Query
    │
    ▼
┌─────────────────┐
│  Query Router   │ ─── Detect intent, extract keywords
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Policy Engine  │ ─── Check mode, apply category filters
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Hybrid Search  │
│                 │
│  ┌───────────┐  │
│  │   BM25    │──┼── k=20 lexical results
│  └───────────┘  │
│                 │
│  ┌───────────┐  │
│  │ Embeddings│──┼── k=20 semantic results
│  └───────────┘  │
│                 │
│  ┌───────────┐  │
│  │    RRF    │──┼── Fuse to k=8 final results
│  └───────────┘  │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│    Response     │
│    Generator    │
│                 │
│  • Format context
│  • Call LM Studio (optional)
│  • Add citations
│  • Return answer
└─────────────────┘
```

## Component Details

### 1. Hybrid Search

| Layer | Method | Purpose | Default k |
|-------|--------|---------|-----------|
| Lexical | BM25 | Exact symbol/keyword matching | 20 |
| Semantic | Embeddings | Conceptual similarity | 20 |
| Fusion | RRF | Combine rankings | 8 final |

**Why hybrid?**
- BM25 finds exact matches: `ACTION_KEY`, `army.newArmy`
- Embeddings find concepts: "how to train troops" → `troop.produceTroop`
- RRF ensures best of both worlds

### 2. Policy Engine

```yaml
modes:
  research:    # Default - excludes exploits
  forensics:   # Strict - excludes keys, scripts, exploits
  full_access: # Everything including exploits
```

**Safety Filters:**
- Blocked: Operational exploit requests
- Allowed: Educational/analytical questions

### 3. Symbol Index

Indexes 55,871 code symbols:
- Class definitions
- Function signatures
- Constants (ACTION_KEY, etc.)
- Protocol commands (module.action)

**Capabilities:**
- `evony.symbol("ACTION_KEY")` → All usages
- `evony.trace("encryption")` → Multi-hop exploration

### 4. Embedding Model

| Property | Value |
|----------|-------|
| Model | sentence-transformers/all-MiniLM-L6-v2 |
| Dimension | 384 |
| Runs On | CPU (no GPU needed) |
| Location | Local (not LM Studio) |

## File Locations

```
evony_rag/
├── config.py          # Constants, paths, defaults
├── hybrid_search.py   # BM25 + embeddings + RRF
├── policy.py          # Mode/filter management
├── rag_v2.py          # Main engine
├── mcp_server_v2.py   # Windsurf integration
├── api_v2.py          # HTTP API
├── cli_v2.py          # Terminal interface
└── index/
    ├── embeddings.npy    # 166k × 384 vectors
    ├── chunks.json       # Chunk metadata
    ├── bm25_index.json   # Inverted index
    └── symbol_index.json # Symbol definitions
```

## Performance Characteristics

| Metric | Value |
|--------|-------|
| Index Size | ~500MB on disk |
| Query Latency | 100-500ms (search) |
| LLM Latency | 1-5s (with answer) |
| Memory Usage | ~2GB (loaded index) |
| Startup Time | 5-10s (first query) |
