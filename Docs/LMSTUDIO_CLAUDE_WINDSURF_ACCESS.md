# LM Studio Access for Claude/Windsurf

**Complete Reference for AI Assistant Integration with LM Studio**

---

## 🎯 Quick Reference Commands

### For Claude/Windsurf to Execute

```powershell
# STATUS & INFO
lms ps                           # List loaded models
lms ls                           # List all downloaded models
lms server status                # Check server status

# MODEL SWITCHING
lms unload --all                 # Unload all models
lms load evony-7b-3800 --gpu=max --context-length=32768  # Load F16
lms load evony-7b-3800-rtx3060 --gpu=max                 # Load Q4

# PRESET INSTALLATION
Copy-Item "C:\Users\Admin\Downloads\Evony_Decrypted\lmstudio_presets\*.preset.json" "$env:USERPROFILE\.lmstudio\config-presets\"
```

---

## 📡 API Endpoints (REST)

### Base URL: `http://localhost:1234`

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/v0/models` | GET | List all models (includes loaded state) |
| `/api/v0/models/{id}` | GET | Get specific model info |
| `/api/v0/chat/completions` | POST | Chat completion |
| `/api/v0/completions` | POST | Text completion |
| `/api/v0/embeddings` | POST | Text embeddings |
| `/v1/models` | GET | OpenAI-compatible models list |
| `/v1/chat/completions` | POST | OpenAI-compatible chat |

### Example: List Models (curl)
```powershell
curl http://localhost:1234/api/v0/models
```

### Example: Chat Completion
```powershell
curl -X POST http://localhost:1234/api/v0/chat/completions `
  -H "Content-Type: application/json" `
  -d '{
    "messages": [{"role": "user", "content": "What is AMF3?"}],
    "temperature": 0.4,
    "max_tokens": 2048
  }'
```

---

## 🔧 CLI Commands (lms)

### Server Management
```powershell
lms server start              # Start server
lms server stop               # Stop server
lms server status             # Check status
```

### Model Management
```powershell
lms ls                        # List downloaded models
lms ps                        # List loaded models (with stats)
lms load <model>              # Load model (interactive)
lms load <model> --yes        # Load model (no prompt)
lms unload                    # Unload current model
lms unload --all              # Unload all models
lms unload <identifier>       # Unload specific model
```

### Load Options
```powershell
lms load <model> --gpu=max                    # Full GPU offload
lms load <model> --gpu=0.5                    # 50% GPU offload
lms load <model> --gpu=off                    # CPU only
lms load <model> --context-length=32768       # Set context
lms load <model> --ttl=3600                   # Auto-unload after 1hr
lms load <model> --identifier="my-model"      # Custom API name
lms load <model> --estimate-only              # Estimate VRAM only
```

---

## 📋 Available Evony Models

| Model Key | Quant | Size | VRAM | Use Case |
|-----------|-------|------|------|----------|
| `evony-7b-3800` | F16 | 15.24 GB | ~16 GB | Maximum quality |
| `evony-7b-3800-rtx3090ti` | Q8 | 8.10 GB | ~10 GB | High quality |
| `evony-7b-3800-rx7800xt` | Q6 | 6.25 GB | ~8 GB | Balanced |
| `evony-7b-3800-rtx3060` | Q4 | 4.68 GB | ~6 GB | Low VRAM |
| `evony-7b-3800-speed` | Q4_K_S | 3.81 GB | ~5 GB | Fast |
| `evony-7b-3800-ultrafast` | Q3 | 3.02 GB | ~4 GB | Ultra fast |

### Switch Model Commands
```powershell
# Switch to F16 (full quality)
lms unload --all; lms load evony-7b-3800 --gpu=max --context-length=32768 --yes

# Switch to Q8 (balanced)
lms unload --all; lms load evony-7b-3800-rtx3090ti --gpu=max --context-length=32768 --yes

# Switch to Q4 (low VRAM)
lms unload --all; lms load evony-7b-3800-rtx3060 --gpu=max --context-length=32768 --yes
```

---

## 📑 Preset Management

### Available Evony Presets
| Preset | Temp | Purpose |
|--------|------|---------|
| `evony-master-expert` | 0.4 | All-in-one expert |
| `evony-exploit-hunter` | 0.2 | Vulnerability analysis |
| `evony-protocol-decoder` | 0.1 | AMF3 decoding |
| `evony-code-auditor` | 0.3 | Code security review |
| `evony-quick-reference` | 0.5 | Fast lookups |
| `evony-forensic-analyst` | 0.25 | Incident investigation |
| `evony-creative-writer` | 0.7 | Documentation |

### Install Presets
```powershell
# Install all Evony presets to LM Studio
Copy-Item "C:\Users\Admin\Downloads\Evony_Decrypted\lmstudio_presets\*.preset.json" "$env:USERPROFILE\.lmstudio\config-presets\"

# Verify installation
Get-ChildItem "$env:USERPROFILE\.lmstudio\config-presets\*.preset.json" | Select-Object Name
```

### Preset Location
- **System presets**: `%USERPROFILE%\.lmstudio\config-presets\`
- **Evony presets**: `C:\Users\Admin\Downloads\Evony_Decrypted\lmstudio_presets\`

---

## 🐍 Python Control Script

### Location
`C:\Users\Admin\Downloads\Evony_Decrypted\evony_rte\lmstudio_control.py`

### Usage
```powershell
python lmstudio_control.py status           # Full status
python lmstudio_control.py models           # List models
python lmstudio_control.py loaded           # Loaded models
python lmstudio_control.py presets          # List presets
python lmstudio_control.py load <model>     # Load model
python lmstudio_control.py unload           # Unload model
python lmstudio_control.py switch <model>   # Switch model
python lmstudio_control.py install-presets  # Install presets
python lmstudio_control.py evony-load F16   # Load Evony F16
python lmstudio_control.py evony-load Q8    # Load Evony Q8
```

### Python API
```python
from evony_rte.lmstudio_control import (
    lms_load_model,
    lms_unload_model,
    switch_model,
    api_chat_completion,
    get_preset,
    chat_with_preset,
    load_evony_model,
    evony_chat,
    get_status
)

# Get status
status = get_status()

# Switch model
result = switch_model("evony-7b-3800", context_length=32768)

# Load Evony variant
result = load_evony_model("Q8")  # or F16, Q6, Q4

# Chat with preset
response = evony_chat("What is command ID 45?", preset="quick")

# Chat completion with custom params
response = api_chat_completion(
    messages=[{"role": "user", "content": "Decode AMF3 0x0A"}],
    temperature=0.1,
    max_tokens=2048
)
```

---

## 🔌 OpenAI-Compatible API

### Python (openai library)
```python
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:1234/v1",
    api_key="not-needed"
)

response = client.chat.completions.create(
    model="evony-7b-3800",
    messages=[{"role": "user", "content": "What is AMF3?"}],
    temperature=0.4
)

print(response.choices[0].message.content)
```

### cURL (OpenAI format)
```powershell
curl -X POST http://localhost:1234/v1/chat/completions `
  -H "Content-Type: application/json" `
  -d '{
    "model": "evony-7b-3800",
    "messages": [{"role": "user", "content": "Explain protocol command 45"}],
    "temperature": 0.4
  }'
```

---

## ⚙️ Inference Parameters

### Via API Request
```json
{
  "messages": [...],
  "temperature": 0.4,
  "max_tokens": 4096,
  "top_p": 0.9,
  "top_k": 40,
  "repeat_penalty": 1.1,
  "min_p": 0.05,
  "stream": false
}
```

### Parameter Guide
| Parameter | Range | Technical | Creative |
|-----------|-------|-----------|----------|
| temperature | 0-2 | 0.1-0.4 | 0.7-0.9 |
| top_k | 1-100 | 20-40 | 50-60 |
| top_p | 0-1 | 0.8-0.9 | 0.9-0.95 |
| min_p | 0-1 | 0.05 | 0.02 |
| repeat_penalty | 1.0-2.0 | 1.1 | 1.15 |

---

## 🚀 Common Workflows

### 1. Check What's Running
```powershell
lms ps
# OR
curl http://localhost:1234/api/v0/models | ConvertFrom-Json | Select-Object -ExpandProperty data | Where-Object { $_.state -eq "loaded" }
```

### 2. Switch to Different Model
```powershell
lms unload --all
lms load evony-7b-3800-rtx3060 --gpu=max --yes
```

### 3. Quick Chat Test
```powershell
curl -X POST http://localhost:1234/api/v0/chat/completions `
  -H "Content-Type: application/json" `
  -d '{"messages": [{"role": "user", "content": "Hello, what can you do?"}]}'
```

### 4. Install Presets and Restart
```powershell
Copy-Item "C:\Users\Admin\Downloads\Evony_Decrypted\lmstudio_presets\*.preset.json" "$env:USERPROFILE\.lmstudio\config-presets\"
# Presets will appear in LM Studio UI after refresh
```

---

## 🔍 What Claude/Windsurf CAN Access

| Feature | Method | Notes |
|---------|--------|-------|
| ✅ List models | API/CLI | Full model info |
| ✅ Load models | CLI | With GPU/context options |
| ✅ Unload models | CLI | Single or all |
| ✅ Switch models | CLI | Unload + load |
| ✅ Chat completions | API | Full parameter control |
| ✅ Text completions | API | Prompt-based |
| ✅ Embeddings | API | Text embeddings |
| ✅ Server status | CLI | Running/port info |
| ✅ List presets | File read | JSON files |
| ✅ Install presets | File copy | To config folder |
| ✅ Read preset params | File read | Extract settings |
| ⚠️ Apply preset in UI | Manual | User must select in LM Studio |
| ❌ Change UI settings | Not available | No API for GUI |
| ❌ Download models | Needs GUI | Or `lms get` (interactive) |

---

## ⚠️ Limitations

1. **Presets**: Can install presets but user must select them in LM Studio UI
2. **Live UI Changes**: Cannot change settings in running LM Studio GUI
3. **Model Download**: `lms get` is interactive, better to download via GUI
4. **Inference Params**: API params override preset settings per-request

---

## 📁 File Locations

| Item | Path |
|------|------|
| LM Studio presets | `%USERPROFILE%\.lmstudio\config-presets\` |
| Evony presets | `C:\Users\Admin\Downloads\Evony_Decrypted\lmstudio_presets\` |
| Control script | `C:\Users\Admin\Downloads\Evony_Decrypted\evony_rte\lmstudio_control.py` |
| Models folder | `%USERPROFILE%\.lmstudio\models\` |
| LM Studio logs | `%USERPROFILE%\.lmstudio\logs\` |

---

*LM Studio Integration Guide for Claude/Windsurf*  
*January 2026*
