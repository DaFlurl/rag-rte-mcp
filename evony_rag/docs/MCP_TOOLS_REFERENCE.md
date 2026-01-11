# Evony Knowledge MCP Tools Reference

## Overview

The Evony Knowledge MCP server provides 7 tools for Windsurf IDE integration, enabling AI-assisted reverse engineering of Evony game internals.

## Tool Specifications

### evony.search

**Purpose:** Hybrid lexical + semantic search over the knowledge base.

**Input Schema:**
```json
{
  "query": "string (required)",
  "include": ["array of category names"],
  "exclude": ["array of category names"],
  "k": "integer (default: 10)"
}
```

**Output:**
```json
{
  "results": [
    {
      "file": "source_code/Client.as",
      "lines": "45-89",
      "category": "source_code",
      "score": 0.847,
      "lexical": 12.5,
      "semantic": 0.72,
      "snippet": "public class Client..."
    }
  ]
}
```

**Example Usage in Windsurf:**
```
@evony-knowledge search for "army.newArmy parameters"
```

---

### evony.answer

**Purpose:** Full RAG answer with LLM generation and citations.

**Input Schema:**
```json
{
  "question": "string (required)",
  "mode": "research | forensics | full_access",
  "include": ["array of category names"],
  "exclude": ["array of category names"],
  "k": "integer (default: 8)",
  "evidence_level": "brief | normal | verbose",
  "use_llm": "boolean (default: true)"
}
```

**Output:**
```json
{
  "answer": "Detailed answer text...",
  "citations": [
    {
      "file": "protocol/commands.md",
      "lines": "120-145",
      "category": "protocol",
      "score": 0.92
    }
  ],
  "mode": "research",
  "categories": ["source_code", "protocol"],
  "model": "lmstudio"
}
```

**Example Usage:**
```
@evony-knowledge answer "What parameters does troop.produceTroop accept?"
```

---

### evony.open

**Purpose:** Get file content with optional line range.

**Input Schema:**
```json
{
  "path": "string (required) - relative path from dataset",
  "start_line": "integer (optional)",
  "end_line": "integer (optional)"
}
```

**Output:**
```json
{
  "path": "source_code/Client.as",
  "start_line": 100,
  "content": "file content here..."
}
```

**Example Usage:**
```
@evony-knowledge open "source_code/army/ArmyController.as" lines 45-100
```

---

### evony.symbol

**Purpose:** Find symbol definitions and usages across the codebase.

**Input Schema:**
```json
{
  "name": "string (required) - symbol name to find"
}
```

**Output:**
```json
{
  "symbol": "ACTION_KEY",
  "occurrences": [
    {
      "symbol": "ACTION_KEY",
      "file": "keys/crypto.py",
      "line": 15,
      "context": "ACTION_KEY = \"TAO_{313..."
    },
    {
      "symbol": "ACTION_KEY",
      "file": "source_code/RequestSigner.as",
      "line": 42,
      "context": "var key:String = ACTION_KEY;"
    }
  ]
}
```

**Example Usage:**
```
@evony-knowledge find symbol "ACTION_KEY"
@evony-knowledge find symbol "army.newArmy"
```

---

### evony.trace

**Purpose:** Multi-hop concept tracing - follow connections between related code.

**Input Schema:**
```json
{
  "topic": "string (required) - starting concept",
  "depth": "integer (default: 3) - trace depth"
}
```

**Output:**
```json
{
  "topic": "encryption",
  "trace": [
    {
      "hop": 1,
      "topic": "encryption",
      "file": "keys/crypto.py",
      "lines": "1-50",
      "score": 0.95,
      "snippet": "def encrypt_request..."
    },
    {
      "hop": 2,
      "topic": "XOR_KEY",
      "file": "keys/xor.py",
      "lines": "1-20",
      "score": 0.87,
      "snippet": "XOR_KEY = 0xAA"
    },
    {
      "hop": 3,
      "topic": "RequestSigner",
      "file": "source_code/RequestSigner.as",
      "lines": "30-80",
      "score": 0.78,
      "snippet": "public class RequestSigner..."
    }
  ]
}
```

**Example Usage:**
```
@evony-knowledge trace "troop.produceTroop" with depth 4
```

---

### evony.mode

**Purpose:** Get or set the current query mode.

**Input Schema:**
```json
{
  "mode": "research | forensics | full_access (optional)"
}
```

**Output:**
```json
{
  "mode": "research",
  "success": true,
  "available": ["research", "forensics", "full_access"]
}
```

**Modes:**
| Mode | Include | Exclude |
|------|---------|---------|
| research | All except exploits | exploits |
| forensics | code, protocol, docs only | keys, scripts, exploits |
| full_access | Everything | Nothing |

**Example Usage:**
```
@evony-knowledge set mode to "full_access"
@evony-knowledge what is current mode?
```

---

### evony.stats

**Purpose:** Get knowledge base statistics.

**Input Schema:**
```json
{}
```

**Output:**
```json
{
  "chunks": 166043,
  "symbols": 55871,
  "mode": "research",
  "modes_available": ["research", "forensics", "full_access"]
}
```

**Example Usage:**
```
@evony-knowledge show stats
```

---

## Categories Reference

| Category | Description | File Count | Default |
|----------|-------------|------------|---------|
| source_code | AS3/Python source files | 7,469 | ✅ Included |
| protocol | Protocol specifications | 85 | ✅ Included |
| keys | Encryption keys/algorithms | 1,230 | ✅ Included |
| scripts | Bot automation scripts | 106 | ✅ Included |
| exploits | Glitch documentation | 26 | ❌ Excluded |
| documentation | Guides, READMEs | varies | ✅ Included |
| game_data | Game mechanics | varies | ✅ Included |
| tools | Analysis utilities | varies | ✅ Included |

---

## Windsurf Integration Tips

### Natural Language Queries

The tools understand natural language. These all work:

```
@evony-knowledge What is ACTION_KEY used for?
@evony-knowledge search for troop training code
@evony-knowledge find where army.newArmy is defined
@evony-knowledge trace the encryption flow
@evony-knowledge open Client.as around line 100
```

### Combining Tools

For deep research, combine tools:

1. **Search** to find relevant files
2. **Symbol** to find definitions
3. **Open** to view full context
4. **Trace** to follow connections
5. **Answer** to get synthesized explanation

### Best Practices

1. Start with `research` mode for safe exploration
2. Use `evony.search` before `evony.answer` for precision
3. Use `evony.trace` to understand code flow
4. Switch to `full_access` only when needed for exploit docs
5. Use `evidence_level: verbose` for maximum context
