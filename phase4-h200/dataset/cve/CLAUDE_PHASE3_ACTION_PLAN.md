# 🎯 CLAUDE'S PHASE 3 ACTION PLAN
## Evony Flash Security Model - CVE Training Enhancement

**Author:** Claude (Anthropic)  
**Date:** 2025-01-06  
**Version:** 1.0  
**For Comparison With:** Windsurf's Plan  
**Final Review By:** ChatGPT

---

## 📋 Executive Summary

Phase 3 transforms our Evony-trained model into a **security-aware expert** by teaching it:
1. CVE vulnerability patterns
2. Code-to-exploit mappings
3. Attack surface analysis
4. Exploitation chains specific to Flash 10.0.x

**Goal:** Model should answer "What vulnerabilities affect this Evony code?" with specific CVEs, CVSS scores, and exploitation details.

---

## 🏗️ Architecture: Multi-Stage Training

### Stage 3A: Foundation Security (Quick Win)
**Duration:** ~1 hour  
**Data:** 500 high-confidence CVE examples  
**Focus:** Core vulnerability types

```
┌─────────────────────────────────────────────────────────┐
│  Stage 3A: Security Fundamentals                        │
├─────────────────────────────────────────────────────────┤
│  • Memory Corruption basics (UAF, heap overflow)        │
│  • Integer overflow patterns                            │
│  • Type confusion concepts                              │
│  • ByteArray vulnerabilities                            │
│  • Top 25 wild exploits (highest priority)              │
└─────────────────────────────────────────────────────────┘
```

### Stage 3B: Evony-Specific Mapping (Core Value)
**Duration:** ~1.5 hours  
**Data:** 1,000 Evony-CVE mapped examples  
**Focus:** Direct code-to-vulnerability relationships

```
┌─────────────────────────────────────────────────────────┐
│  Stage 3B: Evony Code ↔ CVE Mappings                   │
├─────────────────────────────────────────────────────────┤
│  • GameClient.as:87 → CVE-2015-0311 (uncompress UAF)   │
│  • GameClient.as:91 → AMF deserialization CVEs          │
│  • EvonyClient.as:32 → ExternalInterface XSS            │
│  • Socket operations → Network-based CVEs               │
│  • SharedObject → Local storage attacks                 │
└─────────────────────────────────────────────────────────┘
```

### Stage 3C: Advanced Exploitation (Expert Level)
**Duration:** ~1 hour  
**Data:** 800 exploitation chain examples  
**Focus:** Multi-step attack scenarios

```
┌─────────────────────────────────────────────────────────┐
│  Stage 3C: Exploitation Chains                          │
├─────────────────────────────────────────────────────────┤
│  • JIT spray techniques (Blazakis method)               │
│  • Heap spray + trigger combinations                    │
│  • ROP chain construction for Flash                     │
│  • Sandbox escape sequences                             │
│  • MITM → Code execution paths                          │
└─────────────────────────────────────────────────────────┘
```

---

## 📊 Data Strategy

### Priority Tiers (Quality > Quantity)

| Tier | CVE Type | Count | Training Weight | Why |
|------|----------|-------|-----------------|-----|
| **S** | Wild Exploits | 25 | 3x | Real-world proven |
| **A** | Evony Code Match | 50 | 2x | Direct relevance |
| **B** | Flash 10.0.x Specific | 150 | 1.5x | Version accurate |
| **C** | General Flash | 300 | 1x | Breadth coverage |

### Data Augmentation Techniques

1. **Question Variations** (5x multiplier)
```json
{"instruction": "What is CVE-2015-0311?", ...}
{"instruction": "Explain CVE-2015-0311 vulnerability", ...}
{"instruction": "How does CVE-2015-0311 affect Flash?", ...}
{"instruction": "Is Evony vulnerable to CVE-2015-0311?", ...}
{"instruction": "Where in Evony code is CVE-2015-0311 relevant?", ...}
```

2. **Reverse Questions** (Code → CVE)
```json
{"instruction": "What vulnerabilities affect ByteArray.uncompress()?", ...}
{"instruction": "What CVEs should I check for Socket operations?", ...}
{"instruction": "Is mainBuffer.uncompress() at line 87 vulnerable?", ...}
```

3. **Scenario-Based** (Attack chains)
```json
{"instruction": "How would an attacker exploit Evony's AMF parsing?", ...}
{"instruction": "What's the exploitation chain for CVE-2015-5119?", ...}
{"instruction": "Describe a MITM attack against Evony's Socket connection", ...}
```

---

## 🎯 Training Examples: Quality Templates

### Template 1: CVE Identification
```json
{
  "instruction": "What is CVE-2015-0311 and does it affect Evony?",
  "input": "",
  "output": "CVE-2015-0311 is a CRITICAL (CVSS 9.3) Use-After-Free vulnerability in Adobe Flash Player's ByteArray.uncompress() function. It affects Flash Player versions before 16.0.0.287.\n\n**Evony Impact:** YES - DIRECTLY VULNERABLE\n- Location: GameClient.as line 87\n- Code: `mainBuffer.uncompress()`\n- Attack Vector: Malicious server sends crafted compressed data\n- Exploitation: Attacker triggers UAF via malformed zlib stream\n\n**Mitigation:** Update Flash Player (not possible for legacy Evony client)"
}
```

### Template 2: Code Analysis
```json
{
  "instruction": "Analyze this Evony code for vulnerabilities:\n```actionscript\nmainBuffer.uncompress();\nvar obj:Object = mainBuffer.readObject();\n```",
  "input": "",
  "output": "**Critical Vulnerabilities Found:**\n\n1. **CVE-2015-0311** (CVSS 9.3) - ByteArray.uncompress() UAF\n   - Line 1 is directly vulnerable\n   - Exploited in the wild (Angler EK)\n\n2. **CVE-2010-1297** (CVSS 9.3) - AMF Deserialization\n   - Line 2 readObject() vulnerable to malicious AMF\n   - Can trigger arbitrary code execution\n\n**Risk Level:** CRITICAL - Both patterns exploited in wild"
}
```

### Template 3: Exploitation Chain
```json
{
  "instruction": "Describe how to exploit Evony via CVE-2015-5119",
  "input": "",
  "output": "**CVE-2015-5119 Exploitation Chain (Hacking Team Leak):**\n\n1. **Setup:** Attacker positions as MITM or compromises game server\n2. **Trigger:** Send crafted ByteArray to Evony client\n3. **Vulnerability:** UAF in ByteArray valueOf() handling\n4. **Heap Spray:** Use Vector.<uint> for controlled memory layout\n5. **Code Execution:** Overwrite function pointer, gain RCE\n\n**Evony Specific:**\n- Target: GameClient.as packet processing\n- Entry Point: mainBuffer operations\n- No user interaction required after connection"
}
```

---

## 🔬 Validation Strategy

### Test Prompt Categories

**Category A: Direct CVE Questions (20 prompts)**
```
- What is CVE-2015-0311?
- Explain CVE-2015-5119
- What CVSS score is CVE-2010-1297?
```

**Category B: Evony-Specific (20 prompts)**
```
- What vulnerabilities affect GameClient.as?
- Is Evony's ByteArray usage vulnerable?
- What CVEs affect Flash 10.0.x Socket class?
```

**Category C: Code Analysis (15 prompts)**
```
- Analyze mainBuffer.uncompress() for vulnerabilities
- What's wrong with this AMF parsing code?
- Review EvonyClient.as ExternalInterface usage
```

**Category D: Exploitation (15 prompts)**
```
- How would you exploit Evony's protocol?
- Describe a heap spray attack on Flash 10
- What's the JIT spray technique?
```

**Category E: Mitigation (10 prompts)**
```
- How to protect against CVE-2015-0311?
- What defenses exist for AMF attacks?
- Can Evony be patched against these CVEs?
```

### Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| CVE Accuracy | >90% | Correct CVE details (ID, CVSS, type) |
| Evony Relevance | >85% | Correctly identifies Evony impact |
| Code Mapping | >80% | Maps CVE to correct code location |
| Exploitation Detail | >75% | Provides accurate attack steps |
| Hallucination Rate | <5% | No made-up CVEs or wrong details |

---

## 🛠️ Technical Specifications

### Training Parameters (Optimized for F16)

```python
training_args = {
    # Model
    "base_model": "phase2_merged",  # Build on Phase 2
    "output_format": "merged_16bit",  # F16 for quality
    
    # LoRA (increased for security patterns)
    "lora_r": 32,          # Up from 16
    "lora_alpha": 64,      # Up from 32
    "lora_dropout": 0.05,  # Slight regularization
    
    # Training
    "epochs": 4,           # More passes for CVE data
    "learning_rate": 1e-5, # Lower for fine-tuning
    "batch_size": 4,       # Adjust for VRAM
    "gradient_accumulation": 4,
    
    # Optimization
    "warmup_ratio": 0.1,
    "weight_decay": 0.01,
    "lr_scheduler": "cosine",
    
    # Memory
    "use_flash_attention": True,
    "gradient_checkpointing": True,
}
```

### Data Format Requirements

```json
{
  "instruction": "Clear question about CVE/security",
  "input": "",
  "output": "Structured response with:\n- CVE ID and name\n- Severity (CRITICAL/HIGH/MEDIUM)\n- CVSS score\n- Affected versions\n- Evony relevance (YES/NO + location)\n- Attack vector\n- Exploitation details (if applicable)"
}
```

---

## 📁 File Organization

### Claude's Deliverables (CVE_Research/)
```
CVE_Research/
├── CLAUDE_PHASE3_ACTION_PLAN.md    ← This file
├── evony_verified_cves.json         ← 473 CVEs (needs JSON fix)
├── CLAUDE_CVE_CONTRIBUTION.md       ← Documentation
├── CVE_ATTACK_SURFACE_DIAGRAM.md    ← Mermaid diagrams
├── WINDSURF_MERGE_INSTRUCTIONS.md   ← Merge guide
├── validation_prompts.json          ← Test prompts (TODO)
└── quality_review.md                ← Post-training review (TODO)
```

### Windsurf's Deliverables (training/)
```
training/
├── train_phase3_security.jsonl      ← Merged CVE training data
├── train_phase3_optimized.py        ← Training script
├── phase3_config.yaml               ← Training parameters
└── [existing files...]
```

---

## 📅 Timeline

| Phase | Duration | Owner | Deliverable |
|-------|----------|-------|-------------|
| Day 1 AM | 2 hrs | Claude | Validation prompts, quality review criteria |
| Day 1 AM | 2 hrs | Windsurf | Merge all CVE data, create training script |
| Day 1 PM | 3 hrs | Windsurf | Run Stage 3A+3B training |
| Day 1 PM | 1 hr | Claude | Review intermediate model |
| Day 2 AM | 2 hrs | Windsurf | Run Stage 3C, GGUF conversion |
| Day 2 AM | 2 hrs | Claude | Full validation testing |
| Day 2 PM | 1 hr | Both | Final review, documentation |

---

## 🎁 Bonus Ideas (If Time Permits)

### 1. Exploit Database Integration
Create training examples from actual exploit code:
- Metasploit modules for Flash CVEs
- Hacking Team leaked exploits
- Public PoC code analysis

### 2. Defense-Focused Training
Add examples for:
- Detecting exploitation attempts
- Log analysis for CVE indicators
- Mitigation recommendations

### 3. Cross-Reference Training
Teach model to connect:
- CVE → APSB bulletin → Patch version
- CVE → Exploit kit (Angler, RIG, etc.)
- CVE → APT group usage

### 4. Interactive Scenarios
Training for multi-turn conversations:
```
User: "I found uncompress() in my Flash code"
Model: "That could be vulnerable to CVE-2015-0311. What Flash version?"
User: "Flash 10"
Model: "Confirmed vulnerable. Here's the risk..."
```

---

## ✅ Checklist for ChatGPT Review

- [ ] Is the multi-stage approach sound?
- [ ] Are priority tiers correctly weighted?
- [ ] Are training parameters optimal?
- [ ] Is validation strategy comprehensive?
- [ ] Any missing CVE categories?
- [ ] Timeline realistic?
- [ ] File organization clear?
- [ ] Coordination with Windsurf defined?

---

## 🤝 Coordination Notes

**For Windsurf:**
- I'll handle all CVE research/documentation in `CVE_Research/`
- You own all training code in `training/` and `scripts/`
- Check `Claude.md` for status updates
- I'll create `validation_prompts.json` for testing

**For ChatGPT:**
- Compare this plan with Windsurf's
- Identify gaps or conflicts
- Suggest optimizations
- Flag any technical issues

---

*"A model that knows vulnerabilities but not how to exploit them is incomplete. A model that knows exploits but not their context is dangerous. We aim for comprehensive, responsible security awareness."*

— Claude's Phase 3 Philosophy
