# 🎯 EVONY F16 MODEL - PROFESSIONAL LM STUDIO CONFIGURATION

> **Complete Configuration Guide for Svony-7B-3800-F16**  
> **Multiple Presets for Testing | Optimized for Claude/Windsurf Integration**  
> **Version:** 2.0 | **Last Updated:** January 2026

---

## 📊 MODEL INFORMATION

| Property | Value |
|----------|-------|
| **Model File** | `evony-7b-3800-F16.gguf` |
| **Base Model** | Qwen2.5-Coder-7B |
| **Quantization** | F16 (Full Precision) |
| **Size** | 15.24 GB |
| **Training Data** | 84,627 examples (Phase 4) |
| **Max Context** | 32,768 tokens |
| **Architecture** | Transformer (28 layers) |

---

# 📑 SECTION 1: LOAD TAB

## Complete Load Settings

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        LOAD TAB - RECOMMENDED SETTINGS                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Context Length                                                    32768    │
│  ════════════════════════════════════════════════════════════════════════  │
│  Model supports up to 32768 tokens                               [●━━━━━━] │
│                                                                             │
│  GPU Offload                                                    28 / 28    │
│  ════════════════════════════════════════════════════════════════════════  │
│  Model offload limited to dedicated GPU memory                   [●━━━━━━] │
│                                                                             │
│  CPU Thread Pool Size                                                  8    │
│  ════════════════════════════════════════════════════════════════════════  │
│  Match your CPU core count (8-16 recommended)                    [━━●━━━━] │
│                                                                             │
│  Evaluation Batch Size                                               512    │
│  ════════════════════════════════════════════════════════════════════════  │
│  Higher = faster, more VRAM. 512 optimal for F16                 [━━━━●━━] │
│                                                                             │
├─────────────────────────────────────────────────────────────────────────────┤
│  TOGGLE SETTINGS                                                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ☐ RoPE Frequency Base                                              Auto    │
│     Leave unchecked for auto-detection                                      │
│                                                                             │
│  ☐ RoPE Frequency Scale                                             Auto    │
│     Leave unchecked for auto-detection                                      │
│                                                                             │
│  ☑ Offload KV Cache to GPU Memory                                    ON    │
│     CRITICAL: Keeps key-value cache on GPU for speed                        │
│                                                                             │
│  ☑ Keep Model in Memory                                              ON    │
│     Prevents reloading between requests                                     │
│                                                                             │
│  ☑ Try mmap()                                                        ON    │
│     Memory-mapped file access for faster loading                            │
│                                                                             │
│  ☐ Seed                                                       Random Seed   │
│     Leave unchecked for varied responses                                    │
│                                                                             │
│  ☑ Flash Attention                                                   ON    │
│     CRITICAL: 2-3x faster inference with less VRAM                          │
│                                                                             │
├─────────────────────────────────────────────────────────────────────────────┤
│  KV CACHE QUANTIZATION (Experimental)                                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ☑ K Cache Quantization Type    [Experimental]                       F16   │
│     Best quality for F16 model                                              │
│                                                                             │
│  ☑ V Cache Quantization Type    [Experimental]                       F16   │
│     Match K cache for consistency                                           │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Load Settings Explanation

| Setting | Value | Why |
|---------|-------|-----|
| **Context Length** | 32768 | Maximum supported by model - needed for long exploit analysis |
| **GPU Offload** | 28/28 | All layers on GPU for maximum speed |
| **CPU Thread Pool** | 8 | Match CPU cores (adjust for your system) |
| **Eval Batch Size** | 512 | Optimal balance of speed and memory |
| **KV Cache on GPU** | ON | Critical for performance |
| **Keep in Memory** | ON | Prevents slow reloads |
| **mmap()** | ON | Faster initial loading |
| **Flash Attention** | ON | 2-3x speed improvement |
| **K/V Cache Quant** | F16 | Full precision for F16 model |

---

# 📑 SECTION 2: CONTEXT TAB

## System Prompt (Paste This)

### 🎯 EVONY EXPERT SYSTEM PROMPT (RECOMMENDED)

```
You are **Svony**, an Evony Age II domain expert model trained on 84,627 curated examples.

## YOUR KNOWLEDGE BASE
- **Protocol**: Complete AMF3 specification with 301+ documented commands
- **Source Code**: Decompiled Flash AS3, AutoEvony, EVA bots, Python automation
- **Security**: 100+ verified exploit templates, CVE mappings, vulnerability patterns
- **Game Data**: Enums, constants, item IDs, building stats, troop mechanics

## YOUR CAPABILITIES
1. **Packet Analysis**: Decode AMF3 binary payloads, identify command IDs, parse parameters
2. **Exploit Research**: Analyze attack vectors, document exploit chains, assess impact
3. **Code Audit**: Review AS3/Python for vulnerabilities, trace data flows, identify unsafe patterns
4. **Protocol RE**: Map packet flows to game actions, document undocumented commands
5. **Automation**: Generate bot logic, optimize farming strategies, script interactions

## RESPONSE GUIDELINES
- Be precise and technical - cite specific function names, packet commands, file paths
- When analyzing exploits, clearly identify: attack vector, prerequisites, impact, detection
- For packet decoding, show byte-level breakdown when relevant
- Cross-reference findings with source code evidence when available
- Use tables and code blocks for structured data

## DATA ACCESS
You have knowledge derived from:
- C:\Users\Admin\Downloads\Evony_Decrypted\Evony_Dataset\
- C:\Users\Admin\Downloads\Evony_Decrypted\Evony_Training_Data\
- C:\Users\Admin\Downloads\Evony_Decrypted\Docs\

## TRAINING LINEAGE
- Phase 2: RunPod 1x B200 (12,304 examples) ✅
- Phase 3: Failed (data preserved)
- Phase 4: RunPod 8x H200 (84,627 examples) ✅ - Phase 2 data + new updated dataset
```

**Token Count:** ~350 tokens

---

### 🔬 EXPLOIT ANALYST SYSTEM PROMPT

```
You are an Evony Age II security researcher specializing in exploit analysis and vulnerability assessment.

## EXPERTISE
- 100+ verified exploit templates from EVA bots, AutoEvony, and community research
- Complete AMF3 protocol specification with command injection patterns
- Flash AS3 source code analysis including decompiled SWF vulnerabilities
- CVE database knowledge for Flash Player and related technologies

## METHODOLOGY
When analyzing exploits:
1. **Identify Attack Vector**: Packet injection, race condition, integer overflow, logic flaw
2. **Document Prerequisites**: Required game state, timing windows, account requirements
3. **Map Exploit Chain**: Step-by-step sequence from initial action to exploitation
4. **Assess Impact**: Resource manipulation, account compromise, server stability
5. **Detection Signatures**: Packet patterns, timing anomalies, state inconsistencies
6. **Mitigation Strategies**: Server-side validation, rate limiting, state verification

## OUTPUT FORMAT
For each exploit analysis, provide:
- **CVE/ID**: If applicable
- **Severity**: Critical/High/Medium/Low
- **Attack Vector**: Network/Local
- **Complexity**: Low/Medium/High
- **Technical Details**: Code snippets, packet structures
- **Proof of Concept**: Sanitized demonstration
- **Remediation**: Specific fixes

Be precise, technical, and cite specific packet commands or source code when possible.
```

**Token Count:** ~280 tokens

---

### 📡 PROTOCOL ENGINEER SYSTEM PROMPT

```
You are an Evony Age II protocol reverse engineer with deep expertise in binary protocol analysis.

## KNOWLEDGE
- AMF3 (Action Message Format 3) binary encoding/decoding
- 301+ documented protocol commands with parameter structures
- PCAP analysis and traffic reconstruction
- Client-server communication patterns and state machines
- Encryption and obfuscation techniques used in game protocols

## CAPABILITIES
1. **Decode AMF3**: Parse binary payloads → human-readable structures
2. **Command Mapping**: ID → Name → Parameters → Response
3. **Traffic Analysis**: Reconstruct sessions from packet captures
4. **State Tracking**: Model client-server synchronization
5. **Undocumented Commands**: Identify and document hidden functionality

## OUTPUT FORMAT
For packet analysis:
```
Command: [ID] [Name]
Direction: Client→Server / Server→Client
Parameters:
  - param1: type (description)
  - param2: type (description)
Response: [expected response command]
Game Action: [what this does in-game]
```

Provide byte-level analysis when relevant. Use hex dumps for binary data.
```

**Token Count:** ~230 tokens

---

### ⚡ FAST ASSISTANT SYSTEM PROMPT

```
You are a fast Evony assistant optimized for quick, accurate responses.

## SPECIALIZATION
- Protocol command lookups (ID ↔ Name)
- Enum value references
- Quick packet structure summaries
- Syntax help for automation scripts
- Game constant lookups

## RULES
- Keep responses concise (under 200 words when possible)
- Use bullet points and tables
- Skip lengthy explanations unless asked
- Provide direct answers first, context second

Format: Direct answer → Brief explanation → Reference if needed
```

**Token Count:** ~100 tokens

---

# 📑 SECTION 3: INFERENCE TAB

## 3.1 Settings Section

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  ⚙️ SETTINGS                                              [Basic] [All]     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Temperature                                                ⟨🗑️⟩    0.4    │
│  ════════════════════════════●════════════════════════════════════════════  │
│  Lower = deterministic, Higher = creative                                   │
│  RECOMMENDED: 0.3-0.5 for technical, 0.7 for creative                       │
│                                                                             │
│  Limit Response Length                                      ⟨○━━●⟩   OFF    │
│  Leave OFF to use max_tokens from preset                            ⟨🗑️⟩   │
│                                                                             │
│  Context Overflow                                    [Truncate Middle ▼]    │
│  Best for long conversations - keeps beginning and end                      │
│                                                                             │
│  Stop Strings                                                               │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │ Enter a string and press ⏎                                          │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│  Add: </s>  <|im_end|>  [/INST]                                             │
│                                                                             │
│  CPU Threads                                                           6    │
│  ════════════════════════════════●══════════════════════════════════════   │
│  For inference. 6-8 recommended                                             │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 3.2 Sampling Section

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  🎚️ SAMPLING                                                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ☑ Top K Sampling                                          ⟨🗑️⟩       50   │
│  ════════════════════════════════════════════════●══════════════════════   │
│  Limits to top K most likely tokens                                         │
│  RECOMMENDED: 20-50 (Qwen recommends 20)                                    │
│                                                                             │
│  ☑ Repeat Penalty                                                     1.1   │
│  ════════════════════════════════●══════════════════════════════════════   │
│  Penalizes repeated tokens. 1.0 = off, 1.1-1.2 = mild                       │
│  RECOMMENDED: 1.1 for technical, 1.15 for creative                          │
│                                                                             │
│  ☑ Min P Sampling                                                    0.05   │
│  ════════════●══════════════════════════════════════════════════════════   │
│  Filters tokens below this probability threshold                            │
│  RECOMMENDED: 0.05 (Qwen recommends 0)                                      │
│                                                                             │
│  ☑ Top P Sampling                                                    0.95   │
│  ════════════════════════════════════════════════════════●══════════════   │
│  Nucleus sampling - cumulative probability threshold                        │
│  RECOMMENDED: 0.8-0.95 (Qwen: 0.8 non-thinking, 0.95 thinking)              │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Sampling Parameters Explained

| Parameter | Range | Technical Tasks | Creative Tasks | Why |
|-----------|-------|-----------------|----------------|-----|
| **Top K** | 1-100 | 20-40 | 40-60 | Limits vocabulary to top K options |
| **Top P** | 0-1 | 0.8-0.9 | 0.9-0.95 | Dynamic vocabulary based on probability mass |
| **Min P** | 0-1 | 0.05 | 0.02 | Filters low-probability noise |
| **Repeat Penalty** | 1.0-2.0 | 1.1 | 1.15 | Prevents repetitive output |

**Research Note:** Based on Qwen official recommendations:
- Non-thinking mode: `temperature=0.7, top_p=0.8, top_k=20, min_p=0`
- Thinking mode: `temperature=0.6, top_p=0.95, top_k=20, min_p=0`
- Presence penalty `0-2` reduces endless repetitions

---

## 3.3 Structured Output Section

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  📋 STRUCTURED OUTPUT                                                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ☐ Structured Output                                                        │
│                                                                             │
│  Advanced: you can provide a JSON Schema to enforce a particular            │
│  output format from the model. Read the documentation to learn more.        │
│                                                                             │
│  FOR EVONY: Leave DISABLED unless you need specific JSON output             │
│                                                                             │
│  Example JSON Schema for packet analysis:                                   │
│  {                                                                          │
│    "type": "object",                                                        │
│    "properties": {                                                          │
│      "command_id": {"type": "integer"},                                     │
│      "command_name": {"type": "string"},                                    │
│      "parameters": {"type": "array"},                                       │
│      "direction": {"type": "string", "enum": ["c2s", "s2c"]}                │
│    }                                                                        │
│  }                                                                          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 3.4 Speculative Decoding Section

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  🚀 SPECULATIVE DECODING                              [Basic] [All]         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Draft Model                                         Read how it works      │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │ Select a compatible draft model                              [▼] [×]│   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  FOR EVONY F16: Leave DISABLED                                              │
│  Speculative decoding uses a smaller model to predict tokens.               │
│  Not recommended for F16 - adds complexity without significant benefit.     │
│                                                                             │
│  Min Draft Size                                                        0    │
│  ════●══════════════════════════════════════════════════════════════════   │
│                                                                             │
│  Drafting Probability Cutoff                                          0.75  │
│  ════════════════════════════════════════════●══════════════════════════   │
│                                                                             │
│  Max Draft Size                                                       16    │
│  ════════════════════●══════════════════════════════════════════════════   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 3.5 Prompt Template Section

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  📝 PROMPT TEMPLATE                                                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Prompt Template                                                            │
│  [Template (Jinja)]  [Manual]                                               │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │ {%- if tools %}                                                     │   │
│  │   {{- '<|im_start|>system\n' }}                                     │   │
│  │   {%- if messages[0]['role'] == 'system' %}                         │   │
│  │     {{- messages[0]['content'] }}                                   │   │
│  │   {%- else %}                                                       │   │
│  │     {{- 'You are Svony, an Evony Age II expert assistant.' }}       │   │
│  │   {%- endif %}                                                      │   │
│  │   {{- '<|im_end|>\n' }}                                             │   │
│  │ {%- endif %}                                                        │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  Additional Stop Strings                                                    │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │ Enter a string and press ⏎                                          │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  RECOMMENDED STOP STRINGS:                                                  │
│  • <|im_end|>                                                               │
│  • </s>                                                                     │
│  • [/INST]                                                                  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

# 📑 SECTION 4: PRESETS TO TEST

## 🔬 PRESET 1: "Evony Exploit Analysis" (RECOMMENDED FOR SECURITY)

**Use Case:** Deep vulnerability analysis, CVE research, exploit documentation

### Settings
| Parameter | Value | Rationale |
|-----------|-------|-----------|
| **Temperature** | 0.3 | Low for precise, deterministic output |
| **Top K** | 40 | Moderate vocabulary diversity |
| **Top P** | 0.9 | Focused probability mass |
| **Min P** | 0.05 | Filter noise |
| **Repeat Penalty** | 1.1 | Mild repetition prevention |
| **Max Tokens** | 4096 | Long detailed analysis |

### Copy-Paste Values
```
Temperature:     0.3
Top K:           40
Top P:           0.9
Min P:           0.05
Repeat Penalty:  1.1
Context Overflow: Truncate Middle
```

---

## 📡 PRESET 2: "Evony Packet Decoder" (DETERMINISTIC)

**Use Case:** AMF3 decoding, protocol analysis, binary parsing

### Settings
| Parameter | Value | Rationale |
|-----------|-------|-----------|
| **Temperature** | 0.1 | Very low for consistent decoding |
| **Top K** | 20 | Narrow vocabulary (Qwen recommended) |
| **Top P** | 0.95 | High precision |
| **Min P** | 0.0 | No filtering needed |
| **Repeat Penalty** | 1.0 | Disabled (repetition may be valid) |
| **Max Tokens** | 2048 | Sufficient for packet analysis |

### Copy-Paste Values
```
Temperature:     0.1
Top K:           20
Top P:           0.95
Min P:           0.0
Repeat Penalty:  1.0
Context Overflow: Truncate Middle
```

---

## 💻 PRESET 3: "Evony Code Review" (BALANCED TECHNICAL)

**Use Case:** Source code audit, vulnerability scanning, code explanation

### Settings
| Parameter | Value | Rationale |
|-----------|-------|-----------|
| **Temperature** | 0.4 | Balanced precision with some flexibility |
| **Top K** | 50 | Good vocabulary range |
| **Top P** | 0.9 | Focused output |
| **Min P** | 0.05 | Filter low-quality tokens |
| **Repeat Penalty** | 1.1 | Mild penalty |
| **Max Tokens** | 4096 | Long code reviews |

### Copy-Paste Values
```
Temperature:     0.4
Top K:           50
Top P:           0.9
Min P:           0.05
Repeat Penalty:  1.1
Context Overflow: Truncate Middle
```

---

## 🎯 PRESET 4: "Evony General" (QWEN OPTIMIZED)

**Use Case:** General assistance, balanced for all tasks

### Settings (Based on Qwen Official Recommendations)
| Parameter | Value | Rationale |
|-----------|-------|-----------|
| **Temperature** | 0.7 | Qwen recommended for instruct |
| **Top K** | 20 | Qwen recommended |
| **Top P** | 0.8 | Qwen recommended (non-thinking) |
| **Min P** | 0.0 | Qwen recommended |
| **Repeat Penalty** | 1.1 | Presence penalty equivalent |
| **Max Tokens** | 2048 | Standard conversation |

### Copy-Paste Values
```
Temperature:     0.7
Top K:           20
Top P:           0.8
Min P:           0.0
Repeat Penalty:  1.1
Context Overflow: Truncate Middle
```

---

## ⚡ PRESET 5: "Evony Fast" (QUICK RESPONSES)

**Use Case:** Quick lookups, simple questions, fast iteration

### Settings
| Parameter | Value | Rationale |
|-----------|-------|-----------|
| **Temperature** | 0.5 | Moderate randomness |
| **Top K** | 30 | Focused vocabulary |
| **Top P** | 0.85 | Balanced |
| **Min P** | 0.05 | Filter noise |
| **Repeat Penalty** | 1.0 | Disabled for speed |
| **Max Tokens** | 1024 | Short responses |

### Copy-Paste Values
```
Temperature:     0.5
Top K:           30
Top P:           0.85
Min P:           0.05
Repeat Penalty:  1.0
Context Overflow: Truncate Middle
```

---

## 🎨 PRESET 6: "Evony Creative" (DOCUMENTATION/REPORTS)

**Use Case:** Writing documentation, reports, creative explanations

### Settings
| Parameter | Value | Rationale |
|-----------|-------|-----------|
| **Temperature** | 0.8 | Higher for creative expression |
| **Top K** | 60 | Wide vocabulary |
| **Top P** | 0.95 | Diverse output |
| **Min P** | 0.02 | Minimal filtering |
| **Repeat Penalty** | 1.15 | Prevent repetitive writing |
| **Max Tokens** | 4096 | Long form content |

### Copy-Paste Values
```
Temperature:     0.8
Top K:           60
Top P:           0.95
Min P:           0.02
Repeat Penalty:  1.15
Context Overflow: Truncate Middle
```

---

# 📑 SECTION 5: PRESET COMPARISON MATRIX

| Preset | Temp | Top K | Top P | Min P | Repeat | Max Tokens | Best For |
|--------|------|-------|-------|-------|--------|------------|----------|
| **Exploit Analysis** | 0.3 | 40 | 0.9 | 0.05 | 1.1 | 4096 | Security research, CVE analysis |
| **Packet Decoder** | 0.1 | 20 | 0.95 | 0.0 | 1.0 | 2048 | AMF3 decoding, binary parsing |
| **Code Review** | 0.4 | 50 | 0.9 | 0.05 | 1.1 | 4096 | Source audit, vulnerability scan |
| **General** | 0.7 | 20 | 0.8 | 0.0 | 1.1 | 2048 | Balanced, all-purpose |
| **Fast** | 0.5 | 30 | 0.85 | 0.05 | 1.0 | 1024 | Quick lookups, simple Q&A |
| **Creative** | 0.8 | 60 | 0.95 | 0.02 | 1.15 | 4096 | Docs, reports, explanations |

---

# 📑 SECTION 6: HOW TO CREATE PRESETS

## Step-by-Step in LM Studio

1. **Load Model**: Select `evony-7b-3800-F16.gguf`
2. **Configure Load Tab**: Apply settings from Section 1
3. **Set System Prompt**: Paste from Section 2 into Context tab
4. **Configure Inference**: Apply preset values from Section 4
5. **Save Preset**:
   - Click **Preset** dropdown (top of Inference tab)
   - Click **+ New Preset**
   - Enter name: `Evony Exploit Analysis`
   - Click **Save**
6. **Repeat** for each preset you want to test

## Import Preset (Alternative)

Presets are stored in: `%USERPROFILE%\.lmstudio\presets\`

Copy the JSON files from `C:\Users\Admin\Downloads\Evony_Decrypted\lmstudio_presets\` to that folder.

---

# 📑 SECTION 7: TESTING RECOMMENDATIONS

## Test Matrix

| Test | Prompt | Expected | Best Preset |
|------|--------|----------|-------------|
| **Packet Decode** | "Decode AMF3 command 0x12" | Structured output | Packet Decoder |
| **Exploit Query** | "Explain the resource dupe exploit" | Detailed chain | Exploit Analysis |
| **Code Audit** | "Review this AS3 function for vulns" | Security findings | Code Review |
| **Quick Lookup** | "What is command ID 45?" | Short answer | Fast |
| **Documentation** | "Write a report on AMF3 protocol" | Long-form doc | Creative |

## Evaluation Criteria

1. **Accuracy**: Are technical details correct?
2. **Completeness**: Are all relevant aspects covered?
3. **Speed**: How fast is response generation?
4. **Consistency**: Same query = similar results?
5. **Formatting**: Proper code blocks, tables, structure?

---

# 📑 SECTION 8: TROUBLESHOOTING

## Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Slow responses | Context too long | Reduce context to 16384 |
| Repetitive output | Low repeat penalty | Increase to 1.2-1.5 |
| Incoherent output | Temperature too high | Reduce to 0.3-0.5 |
| Truncated responses | Max tokens too low | Increase max tokens |
| Model won't load | Insufficient VRAM | Use Q8 model instead of F16 |
| Flash Attention error | Incompatible GPU | Disable Flash Attention |

## VRAM Requirements

| Model | VRAM Needed | Context 8K | Context 32K |
|-------|-------------|------------|-------------|
| F16 | ~16 GB | ~18 GB | ~22 GB |
| Q8 | ~9 GB | ~11 GB | ~15 GB |
| Q4 | ~5 GB | ~7 GB | ~11 GB |

---

# ✅ FINAL CHECKLIST

## Load Tab
- [ ] Context Length: 32768
- [ ] GPU Offload: 28/28
- [ ] CPU Thread Pool: 8
- [ ] Eval Batch Size: 512
- [ ] KV Cache to GPU: ON
- [ ] Keep in Memory: ON
- [ ] mmap(): ON
- [ ] Flash Attention: ON
- [ ] K Cache Quant: F16
- [ ] V Cache Quant: F16

## Context Tab
- [ ] System Prompt: Pasted (choose from Section 2)

## Inference Tab
- [ ] Preset created/selected
- [ ] Temperature: Set per preset
- [ ] Sampling parameters: Set per preset
- [ ] Context Overflow: Truncate Middle
- [ ] Structured Output: OFF (unless needed)
- [ ] Speculative Decoding: OFF

## Presets Saved
- [ ] Evony Exploit Analysis
- [ ] Evony Packet Decoder
- [ ] Evony Code Review
- [ ] Evony General
- [ ] Evony Fast
- [ ] Evony Creative

---

*Professional LM Studio Configuration for Evony F16 Model*  
*Optimized for Claude/Windsurf Integration*  
*Version 2.0 - January 2026* 
