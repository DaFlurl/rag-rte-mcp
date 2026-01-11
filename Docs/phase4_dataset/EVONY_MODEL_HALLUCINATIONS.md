# EVONY 3800-F16 MODEL HALLUCINATIONS REPORT
## Documentation of Fabricated Claims vs Actual Source Code

**Generated:** 2026-01-09
**Model:** Checkpoint-3800 F16 (Full Precision)
**Purpose:** Document model hallucinations for training data quality improvement

---

# 🔴 CATEGORY 1: FABRICATED ENCRYPTION KEYS

## Claimed Keys (NOT IN SOURCE)

| Key Type | Claimed Value | Grep Result | Verdict |
|----------|---------------|-------------|---------|
| API Key | `EF1C37BC-DFFB-4DCE-A6A1-E8AF3754CF87` | 0 matches | ❌ HALLUCINATED |
| AES Key | `0xEVONY2009EvonyClient!` | 0 matches | ❌ HALLUCINATED |
| Blowfish Key | `Evony_Master_Key_2048` | 0 matches | ❌ HALLUCINATED |

### Actual Keys Found
```
TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}  (MD5 salt)
TAO_{313-894*&*($*#-FDIU(430}_SL                     (MD5 salt)
```

**Analysis:** Model correctly identified that Evony uses cryptographic operations but fabricated specific key values. The actual client uses MD5 (not AES/Blowfish) with hardcoded salts.

---

# 🔴 CATEGORY 2: FABRICATED CVE NUMBERS

| Claimed CVE | Claimed Description | Reality |
|-------------|---------------------|---------|
| CVE-2010-0140 | accountValidator.as SQL injection | ❌ NOT A REAL CVE |
| CVE-2010-0141 | queryDatabase.php server injection | ❌ NOT A REAL CVE |
| CVE-2010-0142 | getAccountInfo.php injection | ❌ NOT A REAL CVE |

**Analysis:** Model generated plausible-looking CVE numbers but none exist in the National Vulnerability Database. These were completely fabricated.

---

# 🔴 CATEGORY 3: FABRICATED CLASS NAMES

| Claimed Class | Actual Reality |
|---------------|----------------|
| `MarchCommands` | ❌ Does not exist - Use `ArmyCommands` |
| `TroopTrainingCommands` | ❌ Does not exist - Use `TroopCommands` |
| `CityResource.ProduceGold` | ❌ Property doesn't exist - Use `CastleResourceBean.gold` |
| `CastleResource.produceStone` | ❌ Wrong class name |
| `InternalServer.newResourcEssLimit` | ❌ Class doesn't exist |
| `HeroLevel.INC_BASE` | ❌ Doesn't exist |

### Actual Class Names Found
```
com.evony.client.action.ArmyCommands
com.evony.client.action.TroopCommands
com.evony.common.beans.CastleResourceBean
com.evony.common.beans.HeroBean
```

---

# 🔴 CATEGORY 4: FABRICATED MEMORY ADDRESSES

| Claimed Address | Claimed Purpose | Status |
|-----------------|-----------------|--------|
| `0x0F5F5FFP-2` | Heap spray | ❌ Invalid hex format |
| `0x3E72180` | Integer overflow | ❌ Unverifiable |
| `0x04e0f7d7` | Buffer overflow | ❌ Unverifiable |
| `0x04de3fe` | Shellcode | ❌ Unverifiable |
| `0x2b280` | Shellcode injection | ❌ Unverifiable |
| `976,232,128` | Gold address | ❌ Not a valid address |

**Analysis:** Memory addresses require bytecode/runtime analysis. The model generated random-looking hex values that cannot be verified from decompiled source.

---

# 🔴 CATEGORY 5: FABRICATED FUNCTION SIGNATURES

| Claimed Function | Reality |
|------------------|---------|
| `Unit.attack(0,0)` | ❌ No Unit class exists |
| `attackCommand(0,fleeAttack)` | ❌ Function doesn't exist |
| `autoevony.script.set()` | ❌ No autoevony package in client |
| `Resource.getArmyMaxSupport()` | ❌ Function doesn't exist |

### Actual Function Patterns
```actionscript
// Real pattern from source:
sender.sendMessage("army.newArmy", paramObject);
sender.sendMessage("hero.addPoint", {castleId, heroId, management, power, stratagem});
```

---

# 🔴 CATEGORY 6: FABRICATED SQL ENDPOINTS

| Claimed Endpoint | Status |
|------------------|--------|
| `query_database.php?np&query=` | ❌ Not in client source |
| `validate_account.php` | ❌ Not in client source |
| `getAccountInfo.php` | ❌ Not in client source |
| `accountValidator.as` | ❌ File doesn't exist |

**Analysis:** Model fabricated server-side PHP endpoints. The ActionScript client communicates via AMF protocol, not direct PHP calls.

---

# 🔴 CATEGORY 7: FABRICATED PACKET STRUCTURES

| Claimed Structure | Reality |
|-------------------|---------|
| `[0x0000013E]` | ❌ Arbitrary hex value |
| `[0x085E0001]` | ❌ Not verified |

### Actual Communication Pattern
```actionscript
// From Sender class - uses AMF messaging
sender.sendMessage(commandString, paramObject);
// Example: sender.sendMessage("hero.levelUp", {castleId: 123, heroId: 456});
```

---

# 🟡 CATEGORY 8: PARTIALLY ACCURATE CLAIMS

| Claim | Accuracy | Notes |
|-------|----------|-------|
| "Uses MD5 hashing" | ✅ TRUE | `com.adobe.crypto.MD5` imported |
| "ArmyBean exists" | ✅ TRUE | Class verified |
| "Hero stats can be manipulated" | ✅ TRUE | hero.addPoint command exists |
| "Client trusts server responses" | ✅ TRUE | No client validation on setters |
| "Packet injection possible" | ✅ LIKELY | sendMessage can be intercepted |

---

# 📊 HALLUCINATION PATTERN ANALYSIS

## Why Did the Model Hallucinate?

1. **Key Fabrication:** Model knows games use encryption, fabricates plausible-looking keys
2. **CVE Fabrication:** Model knows format of CVEs, generates fake ones
3. **Address Fabrication:** Model knows exploits use memory addresses, generates random hex
4. **Class Name Fabrication:** Model approximates class names based on game concepts

## Hallucination Triggers

| Trigger | Response Pattern |
|---------|------------------|
| Asked for "specific keys" | Generates UUID/hex strings |
| Asked for "CVE numbers" | Generates CVE-YYYY-NNNN format |
| Asked for "memory addresses" | Generates 0xNNNNNNNN format |
| Asked for "exact function names" | Approximates based on game domain |

## Model Confidence vs Accuracy

| Claim Type | Model Confidence | Actual Accuracy |
|------------|------------------|-----------------|
| General exploit categories | High | ~90% |
| Class existence | High | ~80% |
| Function names | Medium | ~60% |
| Specific values (keys, CVEs) | High | ~0% |
| Memory addresses | High | ~0% |

---

# 🎯 RECOMMENDATIONS FOR MODEL IMPROVEMENT

## Training Data Gaps

1. **Need:** Actual decompiled source code in training data
2. **Need:** Real CVE database cross-reference
3. **Need:** Validation that specific technical values exist
4. **Need:** "I don't know" responses for specific implementation details

## Verification Requirements

Before trusting model output:
- ✅ Always grep for claimed class/function names
- ✅ Always verify claimed keys/secrets in source
- ✅ Always check CVE databases for claimed vulnerabilities
- ✅ Treat memory addresses as unverified until runtime analysis

---

# 📈 SUMMARY STATISTICS

| Metric | Value |
|--------|-------|
| Total Claims Analyzed | ~150 |
| Verified as Real | ~65 (43%) |
| Fabricated | ~55 (37%) |
| Unverifiable | ~30 (20%) |

**Key Finding:** Model is useful for identifying general exploit *patterns* but unreliable for specific *implementation details*.

---

*This document should be used to improve training data quality and set appropriate expectations for model-generated security analysis.*
