# Evony LLM Model Configuration Guide

**Complete guide for optimizing Evony-trained models in LM Studio**

---

## 📊 Model Catalog

### Available Evony Models (from LM Studio)

| Model | Quant | Size | Speed | Best For |
|-------|-------|------|-------|----------|
| `evony-7b-3800-F16` | F16 | 15.24 GB | Quality | Exploit verification, deep analysis |
| `evony-7b-evony-7b-f16` | F14 | 15.24 GB | Quality | Documentation, code review |
| `evony-7b-3800-rtx30801` | Q8 | 8.10 GB | Balanced | Packet analysis, AMF3 decode |
| `evony-7b-3800-rx7800xt` | Q6 | 6.25 GB | Balanced | Quick scan, protocol lookup |
| `evony-7b-rtx3080` | Q5 | 4.68 GB | Fast | General queries |
| `evony-7b-3800-rtx3080` | Q4 | 4.68 GB | Fast | Rapid iteration, testing |
| `evony-7b-3800-speed` | Q3 | 2.81 GB | Fast | Ultra-fast responses |
| `evony-7b-3800-ultrafast` | Q2 | 3.02 GB | Fast | Instant basic tasks |
| `evony-qwen3-8b-phase2k3_8` | Q8_0 | 9.10 GB | Balanced | Phase 2 enhanced, CVE research |
| `evony-qwen3-8b-phase2k4_k_m` | Q4_K_M | 4.68 GB | Fast | Phase 2 fast mode |
| `evony-qwen3-8b-phase2pf16` | F16 | 15.24 GB | Quality | Phase 2 maximum quality |

---

## ⚙️ Optimal LM Studio Settings

### Load Tab Settings

```
┌─────────────────────────────────────────────────────────────┐
│  RECOMMENDED LOAD SETTINGS FOR EVONY MODELS                 │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Context Length:        32768 tokens (maximum)              │
│  GPU Offload:           28/28 layers (full GPU)             │
│  CPU Thread Pool Size:  8 (or match your CPU cores)         │
│  Evaluation Batch Size: 512                                 │
│                                                             │
│  ✅ RoPE Frequency Base:     Auto                           │
│  ✅ RoPE Frequency Scale:    Auto                           │
│  ✅ Offload KV Cache to GPU: ENABLED                        │
│  ✅ Keep Model in Memory:    ENABLED                        │
│  ✅ Try mmap():              ENABLED                        │
│  ✅ Flash Attention:         ENABLED                        │
│                                                             │
│  K Cache Quantization:  F16 (Experimental ✓)                │
│  V Cache Quantization:  F16 (Experimental ✓)                │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Configuration Presets

#### Maximum Quality (F16 models)
```json
{
  "context_length": 32768,
  "gpu_offload": "max",
  "flash_attention": true,
  "kv_cache_quant": "F16",
  "eval_batch_size": 512,
  "keep_in_memory": true
}
```

#### Balanced (Q8/Q6 models)
```json
{
  "context_length": 16384,
  "gpu_offload": "max",
  "flash_attention": true,
  "kv_cache_quant": "Q8_0",
  "eval_batch_size": 512,
  "keep_in_memory": true
}
```

#### Fast (Q4/Q3 models)
```json
{
  "context_length": 8192,
  "gpu_offload": "max",
  "flash_attention": true,
  "kv_cache_quant": "Q4_0",
  "eval_batch_size": 256,
  "keep_in_memory": true
}
```

---

## 🎯 Inference Presets

### Exploit Analysis
```
Temperature:     0.3 (low - precise)
Top P:           0.9
Top K:           40
Repeat Penalty:  1.1
Max Tokens:      4096
Model:           evony-7b-3800-F16
```

### Packet Decoding
```
Temperature:     0.1 (very low - deterministic)
Top P:           0.95
Top K:           20
Repeat Penalty:  1.0
Max Tokens:      2048
Model:           evony-7b-3800-rtx30801
```

### Protocol Research
```
Temperature:     0.4
Top P:           0.9
Top K:           50
Repeat Penalty:  1.05
Max Tokens:      4096
Model:           evony-qwen3-8b-phase2pf16
```

### Code Review
```
Temperature:     0.2
Top P:           0.9
Top K:           40
Repeat Penalty:  1.1
Max Tokens:      4096
Model:           evony-7b-3800-F16
```

### Quick Help
```
Temperature:     0.5
Top P:           0.9
Top K:           40
Repeat Penalty:  1.0
Max Tokens:      1024
Model:           evony-7b-3800-speed
```

### Interactive Chat
```
Temperature:     0.7
Top P:           0.9
Top K:           50
Repeat Penalty:  1.1
Max Tokens:      2048
Model:           evony-7b-3800-rtx3080
```

---

## 📝 System Prompts

### Exploit Analyst
```
You are an Evony Age II security researcher specializing in exploit analysis.
Your knowledge includes:
- 100+ verified exploit templates from EVA bots and AutoEvony
- Complete AMF3 protocol specification and packet structures
- Flash AS3 source code analysis and decompilation
- CVE research and vulnerability patterns

When analyzing exploits:
1. Cross-reference with known CVEs and vulnerability databases
2. Identify the attack vector (packet injection, race condition, overflow)
3. Document the exploit chain step-by-step
4. Assess impact on game integrity
5. Suggest detection and mitigation strategies

Be precise, technical, and cite specific packet commands or source code when possible.
```

### Protocol Engineer
```
You are an Evony Age II protocol reverse engineer.
Your expertise covers:
- AMF3 binary protocol encoding/decoding
- 301+ documented protocol commands
- Packet capture analysis from PCAP files
- Client-server communication patterns

When analyzing protocols:
1. Decode AMF3 payloads to human-readable format
2. Identify command IDs and parameter structures
3. Map packet flows to game actions
4. Document undocumented or obfuscated commands
5. Explain encryption and obfuscation layers

Provide byte-level analysis when relevant.
```

### Source Auditor
```
You are an Evony Age II source code auditor.
Your knowledge spans:
- ActionScript 3 (AS3) codebase from decompiled SWF files
- Python automation scripts from AutoEvony and EVA bots
- Server-side command handlers and validation logic
- Anti-cheat bypass techniques

When auditing code:
1. Identify security vulnerabilities (injection, overflow, race)
2. Trace data flow from user input to server action
3. Document unsafe patterns and their exploitation
4. Cross-reference with known exploits
5. Suggest secure coding fixes

Focus on actionable security findings.
```

### Packet Decoder
```
You are an Evony Age II packet decoder specialist.
You can decode and analyze:
- Raw AMF3 binary data
- Captured network traffic
- Encrypted payloads
- Command sequences

When decoding packets:
1. Parse AMF3 markers and data types
2. Extract command IDs and parameters
3. Identify the game action being performed
4. Flag suspicious or malformed packets
5. Reconstruct the full conversation flow

Output structured decoded data.
```

---

## 🔄 Model Switching with MCP

### Available MCP Tools

| Tool | Description |
|------|-------------|
| `evony_model_list` | List all Evony models with status |
| `evony_model_switch` | Switch to a different model |
| `evony_model_recommend` | Get model recommendation for task |
| `evony_model_status` | Check current model loading status |
| `evony_model_unload` | Unload model to free VRAM |
| `evony_preset_list` | List inference presets |
| `evony_preset_get` | Get detailed preset config |
| `evony_prompt_get` | Get system prompt |
| `evony_config_optimal` | Get optimal LM Studio settings |
| `evony_access_check` | Check file path access |
| `evony_data_paths` | Get Evony data locations |

### Usage Examples

```python
# List available models
evony_model_list()

# Switch to F16 for deep analysis
evony_model_switch(model_id="evony-7b-3800-F16", config="maximum_quality")

# Get recommendation for exploit analysis
evony_model_recommend(task="exploit analysis")

# Get optimal settings for speed
evony_config_optimal(use_case="fast")

# Get exploit analyst system prompt
evony_prompt_get(prompt_type="exploit_analyst")
```

---

## 📁 File System Access

### Evony Data Paths (Always Accessible)

```
C:\Users\Admin\Downloads\Evony_Decrypted\
├── Evony_Training_Data\     → Training datasets
├── Evony_Dataset\
│   ├── exploits\            → Exploit documentation
│   ├── source_code\         → Decompiled AS3/Python
│   └── network_captures\    → PCAP files
├── Docs\                    → Protocol documentation
└── evony_rte\               → MCP server tools
```

### Allowed Drives
- **D:, E:, F:, G:, H:** - Full access
- **C:** - Access except Windows system folders

### Blocked Paths
- `C:\Windows`
- `C:\Program Files`
- `C:\Program Files (x86)`
- `C:\ProgramData`

---

## 🚀 Quick Start

### 1. Start LM Studio API Server
```
Settings → Developer → Enable API Server
Port: 1234 (default)
```

### 2. Load Evony Model
```bash
lms load evony-7b-3800-F16 --gpu max --context-length 32768
```

### 3. Use MCP Tools
```python
# Claude/Windsurf can now switch models
evony_model_switch("evony-7b-3800-speed")  # Fast mode
evony_model_switch("evony-7b-3800-F16")    # Quality mode
```

### 4. Set System Prompt in LM Studio
Copy the appropriate system prompt from this guide into the **Context** tab.

---

## 📈 Performance Tips

### For Deep Exploit Analysis
1. Use F16 model (`evony-7b-3800-F16` or `evony-qwen3-8b-phase2pf16`)
2. Set context to 32768
3. Use "Exploit Analyst" system prompt
4. Temperature 0.3, Top K 40

### For Fast Packet Decoding
1. Use Q4 model (`evony-7b-3800-rtx3080`)
2. Set context to 8192
3. Use "Packet Decoder" system prompt
4. Temperature 0.1, Top K 20

### For Interactive Chat
1. Use Q6 model (`evony-7b-3800-rx7800xt`)
2. Set context to 16384
3. Use "General Assistant" system prompt
4. Temperature 0.7, Top K 50

---

## 🔧 Troubleshooting

### Model Won't Load
- Check VRAM availability (F16 needs ~16GB)
- Try reducing context length
- Use a smaller quantization (Q4 instead of F16)

### Slow Responses
- Enable Flash Attention
- Increase GPU Offload to max
- Use faster quantization (Q4 > Q6 > Q8 > F16)

### Poor Quality Output
- Switch to higher quantization (F16 > Q8 > Q6 > Q4)
- Use appropriate system prompt
- Lower temperature for precise tasks

### LM Studio Not Responding
- Check if API server is enabled (port 1234)
- Restart LM Studio
- Check `lms` CLI is installed: `lms --version`

---

*Generated for Evony MCP Integration - January 2026*
