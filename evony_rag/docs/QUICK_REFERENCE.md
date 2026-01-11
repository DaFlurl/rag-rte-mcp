# Evony Knowledge RAG - Quick Reference

## Launchers

| Script | Purpose |
|--------|---------|
| `EVONY_RAG_V2_CLI.bat` | Interactive terminal |
| `EVONY_RAG_V2_API.bat` | HTTP API (port 8766) |
| `EVONY_RAG_V2_MCP.bat` | Windsurf MCP (port 8765) |

## CLI Commands

```
/mode [name]       - Get/set mode (research/forensics/full_access)
/find <query>      - Search only
/symbol <name>     - Find symbol
/trace <topic>     - Multi-hop trace
/open <path>       - View file
/stats             - Statistics
/nollm             - Toggle LLM
/quit              - Exit
```

## API Endpoints (port 8766)

```bash
# Chat (OpenAI-compatible)
POST /v1/chat/completions

# RAG-specific
POST /v1/rag/search    # Retrieval only
POST /v1/rag/answer    # Answer + citations
POST /v1/rag/symbol    # Symbol lookup
POST /v1/rag/trace     # Multi-hop
POST /v1/rag/open      # File content
GET  /modes            # List modes
POST /mode             # Set mode
GET  /stats            # Statistics
```

## MCP Tools

```
evony.search(query, include?, exclude?, k?)
evony.answer(question, mode?, evidence_level?, use_llm?)
evony.open(path, start_line?, end_line?)
evony.symbol(name)
evony.trace(topic, depth?)
evony.mode(mode?)
evony.stats()
```

## Query Modes

| Mode | Description |
|------|-------------|
| `research` | Default - excludes exploits |
| `forensics` | Strict - only code/protocol/docs |
| `full_access` | Everything including exploits |

## Categories

| Category | Files | Safe |
|----------|-------|------|
| source_code | 7,469 | ✅ |
| keys | 1,230 | ✅ |
| protocol | 85 | ✅ |
| scripts | 106 | ✅ |
| exploits | 26 | ⚠️ |

## Evidence Levels

| Level | Sources | Snippets |
|-------|---------|----------|
| brief | 3 | No |
| normal | 5 | Yes |
| verbose | 10 | Yes |

## Key Values

```python
ACTION_KEY = "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"
API_KEY = "9f758e2deccbe6244f734371b9642eda"
XOR_KEY = 0xAA
```

## Overflow Thresholds

```
Archer:   6,135,037
Worker:  42,949,673
Catapult:   715,828
```

## Ports

| Service | Port |
|---------|------|
| LM Studio | 1234 |
| RAG API | 8766 |
| MCP Server | 8765 |
| Script Server | 8088 |

## Index Stats

```
Chunks:  166,043
Symbols:  55,871
Embeddings: 384-dim
```

## Windsurf Config

`~/.codeium/windsurf/mcp_config.json`:
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

## Example Queries

```
What is ACTION_KEY?
How does army.newArmy work?
What parameters does troop.produceTroop accept?
Where is the encryption key defined?
How does the overflow glitch work? (requires full_access mode)
```

## Training (Tomorrow)

```batch
SETUP_EVONY_AI.bat    # Install deps
TRAIN_EVONY_AI.bat    # Start training (~2-3 hours)
CHAT_EVONY_AI.bat     # Test model
```
