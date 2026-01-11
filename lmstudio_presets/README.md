# LM Studio Presets for Evony Model

**Professional All-in-One Presets for LM Studio 0.3.x**

These `.preset.json` files are ready-to-import configurations that include all inference parameters AND system prompts in a single file.

---

## 📁 Installation

### Copy to LM Studio Presets Folder

```powershell
# Windows - Run in this directory
Copy-Item *.preset.json "$env:USERPROFILE\.lmstudio\config-presets\"
```

**Manual Path:** `%USERPROFILE%\.lmstudio\config-presets\`

### Import via LM Studio UI
1. Open LM Studio → **Inference** tab
2. Click **Preset** dropdown → **Import**
3. Select any `.preset.json` file

---

## 🎯 Available Presets

| Preset File | Temp | Use Case |
|-------------|------|----------|
| `evony-master-expert.preset.json` | 0.4 | **RECOMMENDED** - Complete expert |
| `evony-exploit-hunter.preset.json` | 0.2 | Deep vulnerability analysis |
| `evony-protocol-decoder.preset.json` | 0.1 | AMF3 binary decoding |
| `evony-code-auditor.preset.json` | 0.3 | AS3 & bot code review |
| `evony-quick-reference.preset.json` | 0.5 | Fast lookups |
| `evony-forensic-analyst.preset.json` | 0.25 | Incident investigation |
| `evony-creative-writer.preset.json` | 0.7 | Documentation writing |

---

## 📋 Preset Details

### 🏆 evony-master-expert (RECOMMENDED)
**All-in-one expert combining security, protocol, and quick reference**

| Parameter | Value |
|-----------|-------|
| Temperature | 0.4 |
| Top K | 40 |
| Top P | 0.9 |
| Repeat Penalty | 1.1 |
| Min P | 0.05 |
| Max Tokens | 4096 |

**System Prompt Features:**
- Security & Exploit Research (100+ templates)
- Protocol RE (301+ commands)
- Auto-switching operational modes

---

### 🔬 evony-exploit-hunter
**Deep security vulnerability analysis**

| Parameter | Value |
|-----------|-------|
| Temperature | 0.2 |
| Top K | 30 |
| Top P | 0.85 |

**Optimized For:** CVE research, attack vectors, exploit chains

---

### 📡 evony-protocol-decoder
**Deterministic AMF3 binary decoding**

| Parameter | Value |
|-----------|-------|
| Temperature | 0.1 |
| Top K | 20 |
| Top P | 0.95 |

**Optimized For:** Byte-level parsing, command lookups, packet analysis

---

### 💻 evony-code-auditor
**Source code security review**

| Parameter | Value |
|-----------|-------|
| Temperature | 0.3 |
| Top K | 40 |
| Top P | 0.9 |

**Optimized For:** Flash AS3 analysis, bot code review, CWE classification

---

### ⚡ evony-quick-reference
**Fast lookups and concise answers**

| Parameter | Value |
|-----------|-------|
| Temperature | 0.5 |
| Top K | 30 |
| Max Tokens | 1024 |

**Optimized For:** Command IDs, enums, quick decoding

---

### 🔍 evony-forensic-analyst
**Incident investigation**

| Parameter | Value |
|-----------|-------|
| Temperature | 0.25 |
| Top K | 35 |
| Top P | 0.88 |

**Optimized For:** PCAP analysis, timeline reconstruction, IoC extraction

---

### 📝 evony-creative-writer
**Documentation and reports**

| Parameter | Value |
|-----------|-------|
| Temperature | 0.7 |
| Top K | 50 |
| Top P | 0.95 |

**Optimized For:** Protocol specs, security reports, technical docs

---

## 🔧 JSON Schema (LM Studio 0.3.x)

```json
{
  "identifier": "@local:preset-name",
  "name": "Preset Display Name",
  "changed": false,
  "operation": {
    "fields": [
      {"key": "llm.prediction.temperature", "value": 0.4},
      {"key": "llm.prediction.topKSampling", "value": 40},
      {"key": "llm.prediction.repeatPenalty", "value": {"checked": true, "value": 1.1}},
      {"key": "llm.prediction.minPSampling", "value": {"checked": true, "value": 0.05}},
      {"key": "llm.prediction.topPSampling", "value": {"checked": true, "value": 0.9}},
      {"key": "llm.prediction.maxPredictedTokens", "value": {"checked": false, "value": 4096}},
      {"key": "llm.prediction.systemPrompt", "value": "System prompt here"}
    ]
  },
  "load": {"fields": []}
}
```

---

## ⚙️ Load Tab Settings (Configure Separately)

```
Context Length:     32768
GPU Offload:        28/28 (max)
Flash Attention:    ON
KV Cache Quant:     F16
Keep in Memory:     ON
```

---

## ✅ Testing Matrix

| Test Query | Best Preset |
|------------|-------------|
| "Decode AMF3 0x0A..." | protocol-decoder |
| "Explain resource dupe exploit" | exploit-hunter |
| "Review this AS3 function" | code-auditor |
| "Command ID 45?" | quick-reference |
| "Write protocol documentation" | creative-writer |
| "Analyze this PCAP session" | forensic-analyst |

---

*Professional LM Studio Presets for Evony F16 Model*  
*LM Studio 0.3.x Compatible | January 2026*
