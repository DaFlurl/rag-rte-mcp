# 🎯 PHASE 3 ACTION PLAN - WINDSURF EDITION
## Epic Training for Epic Results

**Created:** January 5, 2026 23:31 UTC-07:00  
**Author:** Windsurf Cascade  
**Status:** ACTIVE  
**Target:** F16 Quality Model - 25,000+ Training Examples

---

# 📊 CURRENT STATE ASSESSMENT

## Training Data Inventory
| Dataset | Examples | Size | Status |
|---------|----------|------|--------|
| Base Source Code | 15,104 | 27.6 MB | ✅ Complete |
| CVE Security | 2,862 | 1.9 MB | ✅ Complete |
| Enums (NEW) | 137 | 90 KB | ✅ Generated |
| Protocol (NEW) | 69 | 50 KB | ✅ Generated |
| **TOTAL CURRENT** | **18,172** | **~30 MB** | |
| **TARGET** | **25,000+** | **~45 MB** | |
| **GAP** | **6,828** | | 🔄 In Progress |

## Quality Metrics from Phase 2
- F16 GGUF provides best quality ✅
- Q8_0 acceptable for testing
- Q4_K_M too lossy for this domain

---

# 🚀 PHASE 3 EXECUTION STRATEGY

## TRACK A: DATA GENERATION (Windsurf Primary)
**Timeline:** Days 1-3

### A.1 Enum Deep Training (CRITICAL - Day 1)
```
Target: 950 examples total (813 more needed)
Priority: HIGHEST - "Most complex area"
```

**Generation Tasks:**
1. Extract ALL constants from 15 enum files
2. Generate Q&A for each constant value
3. Create bug identification examples
4. Build cross-reference mappings
5. Usage pattern examples

**Files to Process:**
```
ErrorCode.as          → 200+ error codes
TFConstants.as        → 25+ troop/fort types  
HeroConstants.as      → 10+ hero states
FieldConstants.as     → 15+ field types
ObjConstants.as       → 20+ object types
ArmyConstants.as      → 10+ army states
BuildingConstants.as  → 40+ building types
TechConstants.as      → 30+ tech IDs
CommonConstants.as    → 30+ quest/effort types
NpcHeroBean.as        → 5+ NPC states (3 VERSIONS!)
EvonyAnimation.as     → 250+ animation types
```

### A.2 Protocol Command Training (Day 2)
```
Target: 750 examples total (681 more needed)
Priority: HIGH
```

**Generation Tasks:**
1. Document all 301+ commands
2. Request/Response pair examples
3. Error handling patterns
4. Encryption/decryption examples
5. Packet structure documentation

**Command Categories:**
- army.* (30+ commands)
- building.* (15+ commands)
- city.* (25+ commands)
- hero.* (20+ commands)
- alliance.* (25+ commands)
- mail.* (10+ commands)
- quest.* (15+ commands)
- shop.* (20+ commands)
- trade.* (10+ commands)
- tech.* (10+ commands)
- fortifications.* (10+ commands)

### A.3 GUI/UI Component Training (Day 2-3)
```
Target: 700 examples
Priority: HIGH - User explicitly prioritized
```

**Component Categories:**
1. Core UI Components (UIComponent, Button, TextInput, etc.)
2. Window Management (DialogManager, WindowManager)
3. Game-Specific Views (CityView, MapView, ArmyView)
4. AutoEvony UI (AdvancedScriptWindow, CityLogWindow)

### A.4 Scripting System Training (Day 3)
```
Target: 450 examples
Priority: HIGH
```

**Focus Areas:**
1. Script command syntax
2. Variable management
3. Conditional logic
4. Loop constructs
5. Error handling
6. Complete script examples

---

## TRACK B: DATA QUALITY (Claude Support)
**Timeline:** Parallel with Track A

### B.1 Research & Documentation
- Deep-dive into enum inconsistencies
- Flash CVE version matching
- Protocol command discovery
- Animation system mapping

### B.2 Example Variations
- Generate Q&A variations for existing data
- Create edge case examples
- Build debugging scenarios

### B.3 Cross-Reference Validation
- Verify constant values against source
- Check command parameters
- Validate error code usage

---

## TRACK C: MERGE & VALIDATION
**Timeline:** Day 4

### C.1 Dataset Merge
```python
# merge_phase3_data.py
datasets = [
    "train_combined_all.jsonl",    # 15,104
    "train_cve_all.jsonl",         # 2,862
    "train_enums.jsonl",           # 950 (target)
    "train_protocol.jsonl",        # 750 (target)
    "train_gui.jsonl",             # 700 (target)
    "train_scripting.jsonl",       # 450 (target)
    "train_effects.jsonl",         # 300 (target)
    "train_sounds.jsonl",          # 120 (target)
    "train_logs.jsonl",            # 150 (target)
    "train_loading.jsonl",         # 100 (target)
]
# Total: 21,486+ examples
```

### C.2 Deduplication
- Remove exact duplicates
- Merge similar examples
- Validate JSON format

### C.3 Quality Checks
- Verify all examples have system prompt
- Check message structure
- Validate code syntax in examples

---

## TRACK D: TRAINING EXECUTION
**Timeline:** Day 5-6

### D.1 Environment Setup
```bash
# RunPod or local with 24GB+ VRAM
pip install unsloth transformers datasets
```

### D.2 Training Configuration
```python
CONFIG = {
    "base_model": "phase2_merged",  # Continue from Phase 2
    "max_seq_length": 8192,
    "load_in_4bit": True,
    "lora_r": 32,           # Increased from 16
    "lora_alpha": 64,       # Increased from 32
    "lora_dropout": 0.05,
    "num_epochs": 4,        # Increased from 3
    "batch_size": 1,
    "gradient_accumulation": 16,
    "learning_rate": 1e-5,  # Lower for fine-tuning
    "warmup_ratio": 0.1,
    "output_format": "merged_16bit",  # F16 quality
}
```

### D.3 Training Execution
```bash
python train_phase3_optimized.py
```

### D.4 GGUF Conversion
```bash
python convert_hf_to_gguf.py ./output_phase3 --outtype f16
```

---

## TRACK E: VALIDATION & TESTING
**Timeline:** Day 6-7

### E.1 Model Loading
- Load in LM Studio
- Verify F16 format
- Check response quality

### E.2 Test Suite
```
# Test queries for each domain:

## Enums
"What is TFConstants.T_CATAPHRACT?"
"What is the ErrorCode -52 bug?"
"List all hero status constants"

## Protocol
"How do I send an army attack command?"
"What is the AMF packet structure?"
"Show me a building.construct example"

## GUI
"How do I create a new window in Evony?"
"Explain UIComponent lifecycle"
"What is AdvancedScriptWindow?"

## Scripting
"Write a script to attack all NPCs"
"How do I use variables in scripts?"
"Debug this script error..."

## Security
"What Flash CVEs affect Evony?"
"How is encryption implemented?"
```

### E.3 Quality Metrics
- Response accuracy
- Code correctness
- Domain knowledge depth
- Handling of edge cases

---

# 📋 DAILY EXECUTION CHECKLIST

## Day 1: Enum Generation
- [ ] Extract all constants from 15 files
- [ ] Generate 813 more enum examples
- [ ] Validate against source code
- [ ] Save to train_enums.jsonl

## Day 2: Protocol + GUI
- [ ] Generate 681 more protocol examples
- [ ] Document all command categories
- [ ] Generate 700 GUI examples
- [ ] Save to respective JSONL files

## Day 3: Scripting + Effects
- [ ] Generate 450 scripting examples
- [ ] Generate 300 effects examples
- [ ] Generate 120 sound examples
- [ ] Generate 150 log examples

## Day 4: Merge & Validate
- [ ] Run merge_phase3_data.py
- [ ] Deduplicate dataset
- [ ] Quality validation
- [ ] Final count: 25,000+ examples

## Day 5-6: Training
- [ ] Upload to RunPod (or local)
- [ ] Run train_phase3_optimized.py
- [ ] Monitor training progress
- [ ] Save checkpoints

## Day 7: Testing
- [ ] Convert to GGUF F16
- [ ] Load in LM Studio
- [ ] Run test suite
- [ ] Document results

---

# 🔧 TOOLS & SCRIPTS NEEDED

## Generation Scripts
```
training/generate_enum_training.py      ✅ Created
training/generate_protocol_training.py  ✅ Created
training/generate_gui_training.py       🔄 To Create
training/generate_scripting_training.py 🔄 To Create
training/generate_effects_training.py   🔄 To Create
```

## Merge Scripts
```
training/merge_phase3_data.py           🔄 To Create
training/validate_dataset.py            🔄 To Create
training/deduplicate.py                 🔄 To Create
```

## Training Scripts
```
training/train_phase3_optimized.py      ✅ Created
```

---

# 🎯 SUCCESS CRITERIA

| Metric | Target | Measure |
|--------|--------|---------|
| Total Examples | 25,000+ | Count |
| Enum Accuracy | 100% | Test queries |
| Protocol Coverage | 301/301 | Commands documented |
| GUI Patterns | Complete | All components |
| Script Examples | Working | Executable scripts |
| F16 Quality | Best | LM Studio testing |

---

# 📊 RISK MITIGATION

| Risk | Mitigation |
|------|------------|
| Duplicate data | Deduplication script |
| Invalid JSON | Validation checks |
| Missing constants | Source code extraction |
| Training failure | Checkpoints, lower LR |
| Quality regression | Test suite comparison |

---

# 🤝 COLLABORATION NOTES

## Windsurf Responsibilities
- Primary code generation
- Script creation and execution
- Dataset management
- Training pipeline

## Claude Responsibilities
- Research and documentation
- Example variations
- Quality review
- Edge case generation

## ChatGPT Responsibilities
- Web research (CVEs, Flash docs)
- Pattern finding
- Plan review
- Quality suggestions

---

*PHASE 3 ACTION PLAN v1.0*  
*Windsurf Cascade - January 2026*  
*Target: EPIC training for EPIC results*
