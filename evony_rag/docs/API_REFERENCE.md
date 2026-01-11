# Evony Knowledge RAG - API Reference

## Overview

The RAG system provides three interfaces:
1. **HTTP API** (port 8766) - OpenAI-compatible + RAG endpoints
2. **MCP Server** (port 8765) - Windsurf IDE integration
3. **CLI** - Interactive terminal

---

## HTTP API (port 8766)

Start with: `EVONY_RAG_V2_API.bat`

### OpenAI-Compatible Endpoints

#### POST /v1/chat/completions

Standard chat completion with RAG context injection.

```bash
curl -X POST http://localhost:8766/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "messages": [
      {"role": "user", "content": "What is ACTION_KEY used for?"}
    ],
    "mode": "research",
    "include": ["source_code", "keys"],
    "exclude": ["exploits"]
  }'
```

**Response:**
```json
{
  "id": "chatcmpl-abc123",
  "object": "chat.completion",
  "model": "evony-rag-v2",
  "choices": [{
    "message": {
      "role": "assistant",
      "content": "ACTION_KEY is used for...\n\n---\n**Sources:**\n- `keys/ACTION_KEY.txt:1-15` (92%)"
    }
  }]
}
```

#### GET /v1/models

List available models.

```bash
curl http://localhost:8766/v1/models
```

---

### RAG-Specific Endpoints

#### POST /v1/rag/search

Retrieval-only search (no LLM generation).

```bash
curl -X POST http://localhost:8766/v1/rag/search \
  -H "Content-Type: application/json" \
  -d '{
    "query": "army.newArmy parameters",
    "k": 10,
    "include": ["source_code", "protocol"]
  }'
```

**Response:**
```json
{
  "results": [
    {
      "file": "source_code/army/ArmyController.as",
      "lines": "45-89",
      "category": "source_code",
      "score": 0.847,
      "lexical": 12.5,
      "semantic": 0.72,
      "snippet": "public function newArmy(..."
    }
  ]
}
```

#### POST /v1/rag/answer

Full RAG answer with citations.

```bash
curl -X POST http://localhost:8766/v1/rag/answer \
  -H "Content-Type: application/json" \
  -d '{
    "question": "How does troop training work?",
    "mode": "research",
    "evidence_level": "verbose",
    "k": 8,
    "use_llm": true
  }'
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| question | string | required | The question to answer |
| mode | string | "research" | Query mode |
| include | array | null | Categories to include |
| exclude | array | null | Categories to exclude |
| k | integer | 8 | Number of sources |
| evidence_level | string | "normal" | brief/normal/verbose |
| use_llm | boolean | true | Use LM Studio for generation |

#### POST /v1/rag/symbol

Find symbol definitions and usages.

```bash
curl -X POST http://localhost:8766/v1/rag/symbol \
  -H "Content-Type: application/json" \
  -d '{"name": "ACTION_KEY"}'
```

**Response:**
```json
{
  "symbol": "ACTION_KEY",
  "occurrences": [
    {
      "symbol": "ACTION_KEY",
      "file": "keys/encryption.py",
      "line": 15,
      "context": "ACTION_KEY = \"TAO_{313-894..."
    }
  ]
}
```

#### POST /v1/rag/trace

Multi-hop concept tracing.

```bash
curl -X POST http://localhost:8766/v1/rag/trace \
  -H "Content-Type: application/json" \
  -d '{
    "topic": "troop.produceTroop",
    "depth": 3
  }'
```

**Response:**
```json
{
  "topic": "troop.produceTroop",
  "trace": [
    {"hop": 1, "topic": "troop.produceTroop", "file": "...", "score": 0.9},
    {"hop": 2, "topic": "TroopController", "file": "...", "score": 0.8},
    {"hop": 3, "topic": "ResourceManager", "file": "...", "score": 0.7}
  ]
}
```

#### POST /v1/rag/open

Get file content.

```bash
curl -X POST http://localhost:8766/v1/rag/open \
  -H "Content-Type: application/json" \
  -d '{
    "path": "source_code/army/ArmyController.as",
    "start_line": 45,
    "end_line": 89
  }'
```

#### GET /modes

List available query modes.

```bash
curl http://localhost:8766/modes
```

#### POST /mode

Set current mode.

```bash
curl -X POST http://localhost:8766/mode \
  -H "Content-Type: application/json" \
  -d '{"mode": "full_access"}'
```

#### GET /health

Health check.

```bash
curl http://localhost:8766/health
```

#### GET /stats

System statistics.

```bash
curl http://localhost:8766/stats
```

---

## MCP Server (port 8765)

Start with: `EVONY_RAG_V2_MCP.bat`

### Configuration

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

### Available Tools

#### evony.search

```json
{
  "name": "evony.search",
  "arguments": {
    "query": "encryption key",
    "include": ["keys", "source_code"],
    "exclude": ["exploits"],
    "k": 10
  }
}
```

#### evony.answer

```json
{
  "name": "evony.answer",
  "arguments": {
    "question": "What parameters does army.newArmy accept?",
    "mode": "research",
    "evidence_level": "normal",
    "use_llm": true
  }
}
```

#### evony.open

```json
{
  "name": "evony.open",
  "arguments": {
    "path": "source_code/Client.as",
    "start_line": 100,
    "end_line": 150
  }
}
```

#### evony.symbol

```json
{
  "name": "evony.symbol",
  "arguments": {
    "name": "ACTION_KEY"
  }
}
```

#### evony.trace

```json
{
  "name": "evony.trace",
  "arguments": {
    "topic": "encryption",
    "depth": 3
  }
}
```

#### evony.mode

```json
{
  "name": "evony.mode",
  "arguments": {
    "mode": "full_access"
  }
}
```

#### evony.stats

```json
{
  "name": "evony.stats",
  "arguments": {}
}
```

---

## CLI Reference

Start with: `EVONY_RAG_V2_CLI.bat`

### Commands

| Command | Description |
|---------|-------------|
| `/mode [name]` | Get/set query mode |
| `/find <query>` | Search without generation |
| `/symbol <name>` | Find symbol definitions |
| `/trace <topic>` | Multi-hop trace |
| `/open <path> [start:end]` | View file content |
| `/stats` | System statistics |
| `/nollm` | Toggle LLM generation |
| `/evidence [level]` | Set evidence level |
| `/include <cats>` | Set include filter |
| `/exclude <cats>` | Set exclude filter |
| `/quit` | Exit |

### Examples

```
[research] > What is ACTION_KEY?

[research] > /mode full_access
Mode set to: full_access

[full_access] > /symbol army.newArmy
Symbol 'army.newArmy' found 15 times:
  📍 source_code/army/ArmyController.as:45 - newArmy
  ...

[full_access] > /trace encryption
Trace from 'encryption':
  [hop 1] encryption → keys/crypto.py:10-50
  [hop 2] XOR_KEY → keys/xor.py:1-20
  ...

[full_access] > /open source_code/Client.as 100:150
--- source_code/Client.as ---
...file content...
```

---

## Query Modes

| Mode | Include | Exclude | Use Case |
|------|---------|---------|----------|
| `research` | source_code, protocol, docs, scripts, game_data, tools | exploits | Default RE work |
| `forensics` | source_code, protocol, docs | exploits, keys, scripts | Strict analysis |
| `full_access` | All categories | None | Educational deep-dive |

---

## Evidence Levels

| Level | Max Sources | Show Snippets | Max Chars |
|-------|-------------|---------------|-----------|
| `brief` | 3 | No | 200 |
| `normal` | 5 | Yes | 500 |
| `verbose` | 10 | Yes | 1200 |

---

## Error Responses

```json
{
  "error": "Operational requests are blocked. Ask about mechanics instead."
}
```

Common errors:
- Query blocked by safety filter
- File not found
- Invalid mode
- LM Studio not running (falls back to standalone)
