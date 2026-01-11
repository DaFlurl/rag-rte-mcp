# Claude → Windsurf Handoff: Phase 4 H200 Dataset

## 🎯 Project Context

**Owner:** ShadowByte (vibe coder, non-programmer)  
**Purpose:** Curating Evony game data for AI/ML training on H200 GPU infrastructure  
**Location:** `C:\Users\Admin\Downloads\Evony_Decrypted\phase4-h200`

---

## ✅ Round 1 Complete: Dataset Cleanup

### What Was Done
Sorted 1,587 files to separate Evony-related training content from junk:

| Location | Before | After | Trashed |
|----------|--------|-------|---------|
| `dataset/keys/` | 1,311 | **532** | 779 |
| `dataset/protocols/` | 276 | **123** | 153 |
| **Total** | 1,587 | **655** | **932** |

### Junk Categories Removed (932 files → `dataset/trash/`)
- 🦠 Virus group documentation (110 files) - malware history docs unrelated to Evony
- 📜 License files (93) - Apache, GPL, BSD, MIT, LGPL text files
- 🔧 Ghidra/RE tool configs (142) - pattern XMLs, batch scripts, decompiler configs
- ⚙️ Flex SDK artifacts (157) - compile configs, style files, manifests
- 🌐 Web/JS junk (23) - jQuery, mootools, swfobject
- 🐍 Generic Python boilerplate (51) - Django __init__.py, settings.py without Evony context
- 📋 Hash-named duplicates (101) - README_abc123.md, index_abc123.md patterns
- 📁 Numbered metadata (123) - metadata_1.json through metadata_123.json
- 🔬 dnSpy configs (18), misc junk (25)

### Kept Content (655 files) - EVONY TRAINING DATA
**Keys folder (532 files):**
- Account data: `accounts_*.json`, `accounts_userpass_*.txt`
- Evony scripts: `accept.txt`, `acceptquest.txt`, `issuequest.txt`, `questaddarmy.txt`
- AMF/Protocol: `amf_version.py`, `authentication.py`, `analyze_dump.py`
- Config SOLs: `#localWithNet_projects_evony_Extracted_AutoEvony.swf_config.sol.json`
- Documentation: `AI-Evony_Chat.txt`, `Alliance.md`, `API_REFERENCE.md`
- Batch tools: `BorgToolkit.bat`, `CURATE_EVONY_DATA.bat`, `RUN_EVONY_HUB.bat`

**Protocols folder (123 files):**
- Catalogs: `00_base_catalog.md`, `00_extended_catalog.md`, `00_ultra_catalog.md`
- Analysis: `04_EVONY_ANALYSIS.md`, `BORG_GLITCH_ANALYSIS.md`, `CLIENT_STRUCTURE.md`
- Scripts: `7of9_4Borg_script.txt`, `Current_Attacking_Script_Borg.txt`, `fastattack (5).txt`
- Integration: `AUTOEVONY_INTEGRATION.md`, `BOT_INTEGRATION.md`, `SVONY_INTEGRATION.md`
- Mechanics: `GLITCH_MECHANICS.md`, `BATTLE_MECHANICS.md`, `MOVE_VS_UNTRAIN.md`

---

## 📂 Current Dataset Structure

```
phase4-h200/
├── dataset/
│   ├── autoevony/      # AutoEvony bot AS3 source - KEEP
│   ├── client/         # EvonyClient decompiled AS3 - KEEP
│   ├── borg/           # Borg automation scripts/glitches - KEEP
│   ├── as_source/      # Evony client AS3 source - KEEP
│   ├── scripts/        # EvonyCommQuest PHP, pyEvony - KEEP
│   ├── training_jsonl/ # Pre-formatted training data - KEEP
│   ├── cve/            # CVE research (Evony-specific) - KEEP
│   ├── enums_cve/      # Enumeration data - KEEP
│   ├── keys/           # 532 files (CLEANED)
│   ├── protocols/      # 123 files (CLEANED)
│   └── trash/          # 932 files staged for deletion
│       ├── keys/       # 779 junk files
│       └── protocols/  # 153 junk files
├── sort_dataset.py     # Cleanup script used
└── claude.md           # This handoff file
```

---

## 🔄 Remaining Rounds (2 of 3)

### Round 2: Quality Audit & Deduplication
- [ ] Scan `dataset/borg/` for potential junk
- [ ] Check for duplicate content across folders
- [ ] Verify `.as` files in autoevony/client are complete
- [ ] Validate training_jsonl format integrity
- [ ] Consider merging related documentation

### Round 3: Training Data Preparation
- [ ] Convert cleaned dataset to JSONL training format
- [ ] Create train/val/test splits
- [ ] Generate dataset statistics/metadata
- [ ] Document final schema for H200 training
- [ ] Create data loader scripts

---

## 🛠️ Tools & Scripts Created

### `sort_dataset.py`
Location: `C:\Users\Admin\Downloads\Evony_Decrypted\phase4-h200\sort_dataset.py`

Python script that:
1. Uses exact filename matching for known junk patterns
2. Pattern matches numbered duplicates (metadata_*.json, README_*.md)
3. Checks for Evony keywords: evony, autoevony, borg, quest, castle, troop, hero, alliance, glitch, attack, amf, .sol
4. Files without keywords treated as generic → trashed
5. Preserves original folder structure in trash

---

## ⚠️ Notes for Windsurf

1. **Trash folder is staged, not deleted** - Review before permanent removal
2. **Keys/protocols heavily cleaned** - 932 junk files removed
3. **Other folders untouched** - autoevony, client, borg, as_source, scripts, training_jsonl, cve, enums_cve
4. **Sorting report saved** at `dataset/sorting_report.txt`
5. **User prefers Docker-first, local-first solutions** - no cloud dependencies
6. **User is vibe coder** - provide complete implementations, no placeholders

---

## 📊 Quick Stats
- **Total Evony files:** 655 (after cleanup)
- **Junk removed:** 932 files
- **Cleanup ratio:** 59% junk, 41% useful
- **Primary content types:** AS3 source, Python scripts, JSON configs, MD documentation, batch tools

---

*Last updated: 2026-01-07 by Claude Opus 4.5*
*Handoff: Round 1 → Round 2*
