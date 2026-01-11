# Evony Knowledge RAG - Troubleshooting Guide

## Common Issues

### 1. MCP Server Not Starting

**Symptom:** Windsurf doesn't see evony-knowledge tools

**Solutions:**

```bash
# Check if Python can find the module
cd c:\Users\Admin\Downloads\Evony_Decrypted
python -m evony_rag.mcp_server_v2

# If module not found, check Python path
python -c "import sys; print(sys.path)"
```

**Fix:** Ensure cwd is correct in mcp_config.json:
```json
"cwd": "c:\\Users\\Admin\\Downloads\\Evony_Decrypted"
```

### 2. LM Studio Connection Failed

**Symptom:** Answers work but show "model: standalone"

**Solutions:**

1. Check LM Studio is running on port 1234
2. Verify model is loaded (not just started)
3. Test connection:
```bash
curl http://localhost:1234/v1/models
```

**Fallback:** System works without LM Studio (retrieval-only mode)

### 3. Index Not Found

**Symptom:** "Knowledge index not loaded" error

**Solutions:**

```bash
# Rebuild the index
cd c:\Users\Admin\Downloads\Evony_Decrypted
python -c "from evony_rag.embeddings import build_index; build_index()"
```

**Check index files exist:**
```
evony_rag/index/
├── embeddings.npy     # ~250MB
├── chunks.json        # ~200MB
├── metadata.json      # Small
├── bm25_index.json    # ~50MB
└── symbol_index.json  # ~20MB
```

### 4. Slow Query Performance

**Symptom:** Queries take >5 seconds

**Causes:**
- First query loads model (~5-10s)
- Large result sets
- LM Studio generation time

**Solutions:**
- Reduce `k` parameter (default: 8)
- Use `evidence_level: brief`
- Set `use_llm: false` for search-only

### 5. Empty Search Results

**Symptom:** No results returned for valid queries

**Solutions:**

1. Check category filters:
```bash
# Wrong - exploits excluded by default
curl -X POST http://localhost:8766/v1/rag/search \
  -d '{"query": "overflow glitch"}'

# Right - include exploits
curl -X POST http://localhost:8766/v1/rag/search \
  -d '{"query": "overflow glitch", "include": ["exploits"]}'
```

2. Lower `min_score` threshold:
```python
# In policy.yaml
retrieval:
  min_score: 0.15  # Lower from 0.25
```

3. Check mode allows category:
```bash
# Switch to full_access mode
curl -X POST http://localhost:8766/mode -d '{"mode": "full_access"}'
```

### 6. Query Blocked by Safety Filter

**Symptom:** "Operational requests are blocked" error

**Reason:** Query matches blocked patterns (step-by-step exploit instructions)

**Solutions:**

1. Rephrase as educational:
   - ❌ "How do I use the overflow exploit?"
   - ✅ "How does the overflow mechanism work?"

2. Check policy.yaml for blocked patterns:
```yaml
blocked_patterns:
  - "how (do i|can i|to) (use|exploit|abuse)"
  - "step.?by.?step .* (glitch|exploit)"
```

### 7. Symbol Not Found

**Symptom:** `/symbol X` returns empty

**Solutions:**

1. Check exact spelling (case-sensitive for some)
2. Try partial match:
```bash
# Instead of exact
/symbol ACTION_KEY

# Try lowercase
/symbol action_key
```

3. Rebuild symbol index:
```python
from evony_rag.hybrid_search import get_hybrid_search
hs = get_hybrid_search()
# Index rebuilds automatically on first load
```

### 8. API Port Already in Use

**Symptom:** "Address already in use" error

**Solutions:**

```powershell
# Find process using port 8766
netstat -ano | findstr :8766

# Kill the process
taskkill /PID <pid> /F
```

Or change port in config.py:
```python
MCP_PORT = 8767  # Different port
```

### 9. Out of Memory (Embedding Generation)

**Symptom:** MemoryError during index building

**Solutions:**

1. Reduce batch size in embeddings.py:
```python
batch_size = 32  # Reduce from 64
```

2. Close other applications

3. Use smaller embedding model:
```python
EMBEDDING_MODEL = "sentence-transformers/paraphrase-MiniLM-L3-v2"  # Smaller
```

### 10. Training Fails (Out of GPU Memory)

**Symptom:** CUDA out of memory during training

**Solutions:**

1. Reduce batch size:
```python
per_device_train_batch_size = 2
gradient_accumulation_steps = 8
```

2. Enable gradient checkpointing:
```python
model.gradient_checkpointing_enable()
```

3. Use smaller model:
```python
model_name = "unsloth/Qwen2.5-1.5B-Instruct"  # 1.5B instead of 3B
```

---

## Diagnostic Commands

### Check System Status

```bash
# RAG index stats
curl http://localhost:8766/stats

# Health check
curl http://localhost:8766/health

# LM Studio status
curl http://localhost:1234/v1/models

# Current mode
curl http://localhost:8766/modes
```

### Test Components

```python
# Test embedding model
from sentence_transformers import SentenceTransformer
model = SentenceTransformer('sentence-transformers/all-MiniLM-L6-v2')
print(model.encode(["test"]).shape)  # Should be (1, 384)

# Test hybrid search
from evony_rag.hybrid_search import get_hybrid_search
hs = get_hybrid_search()
print(f"Chunks: {len(hs.chunks)}")
print(f"Symbols: {len(hs.symbols.symbols)}")

# Test policy
from evony_rag.policy import get_policy
p = get_policy()
print(f"Mode: {p.current_mode}")
print(f"Modes: {p.get_modes()}")
```

### Log Locations

```
evony_rag/
├── index/           # Index files (check sizes)
└── logs/            # Runtime logs (if enabled)

LM Studio logs:
~/.lmstudio/logs/
```

---

## Reset Procedures

### Full Reset

```bash
cd c:\Users\Admin\Downloads\Evony_Decrypted

# Delete index
rmdir /s /q evony_rag\index

# Rebuild
python -c "from evony_rag.embeddings import build_index; build_index()"
python -c "from evony_rag.hybrid_search import get_hybrid_search; get_hybrid_search()"
```

### Reset Mode Only

```bash
curl -X POST http://localhost:8766/mode -d '{"mode": "research"}'
```

### Restart All Services

```batch
:: Kill existing
taskkill /IM python.exe /F

:: Restart LM Studio manually

:: Start RAG API
start EVONY_RAG_V2_API.bat
```

---

## Getting Help

1. Check this troubleshooting guide
2. Review API_REFERENCE.md for correct usage
3. Check ARCHITECTURE.md for system understanding
4. Inspect logs for specific errors
