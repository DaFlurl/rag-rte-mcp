# 🤖 SVONY STUDIO - AUTOMATION CAPABILITIES MATRIX

## Overview

This document catalogs ALL automation capabilities discovered across the filesystem that can be integrated into Svony Studio for maximum Evony automation.

---

## 🎯 AUTOMATION CATEGORIES

### 1. SCRIPT-BASED AUTOMATION (RoboEvony Scripts)

#### Attack Automation
| Capability | Script | Location | Complexity |
|------------|--------|----------|------------|
| Mass Attack Spam | spam_script_v13.4.txt | D:\...\evony_2024\ | High |
| Fast Attack (Lag-Free) | fastattack_v6_LagFree.txt | Same | Medium |
| Multi-Target Attack | multiattack.txt | Same | High |
| Coordinated Assault | Multi_Attack.txt | Same | High |
| Quick Strike | fastattack.txt | Same | Low |

#### Troop Management
| Capability | Script | Location | Complexity |
|------------|--------|----------|------------|
| All-City Training | allcitiestrooptraining.txt | D:\...\evony_2024\ | Medium |
| Training Capacity Calc | trooptrainingcapacity.txt | Same | Low |
| Troop Counter | Troop_Counter.txt | Same | Low |
| Troop Deployment | Deploy.txt | Same | Medium |
| Colony Drafting | draftallcolonies.txt | Same | Medium |
| Resource Counter | Troop_&_RSS_Counter.txt | Same | Medium |

#### Exploit Automation
| Capability | Script | Location | Risk |
|------------|--------|----------|------|
| Food Glitch | FoodGlitchCounterV1.2.txt | D:\...\evony_2024\ | HIGH |
| Troop Glitch | Troop_Glitch.txt | Same | HIGH |
| Resource Glitch | Troop & Resource Glitch to Valley.txt | Same | HIGH |
| Quest Glitch | CommisionQuest_Troop_Glitch.txt | Same | HIGH |
| Amulet Glitch | Amulet_Glitch.TXT | Same | MEDIUM |
| Valley Rolling | Valley rolling at maint.txt | Same | MEDIUM |

#### Hero Automation
| Capability | Script | Location | Complexity |
|------------|--------|----------|------------|
| Historic Hero Hunt | HH_Hunting_Script.txt | D:\...\evony_2024\ | High |
| Legendary Hero | Legendary_Hero_Script.txt | Same | High |
| Hero Enhancement | Hero_Juice.TXT | Same | Medium |
| Hero Leveling | Hero_Level_up.txt | Same | Medium |
| Khan Heroes | Khans_Heroes.txt | Same | Medium |

#### City/Building Automation
| Capability | Script | Location | Complexity |
|------------|--------|----------|------------|
| Auto Build | Auto Build City Script.txt | D:\...\evony_2024\ | High |
| Colony Management | Colony Script.txt | Same | Medium |
| New Account Setup | newAccountStarter_Script_for_RE.txt | Same | High |
| Elite Builder | AccountBuilderSnippetElite.1.txt | Same | High |

---

### 2. PYTHON-BASED AUTOMATION

#### Script Generation
| Tool | Path | Capability |
|------|------|------------|
| script_generator.py | G:\...\scripts\automation\ | Generate scripts from templates |
| script_validator.py | Same | Validate script syntax |

**Integration Code:**
```python
from script_generator import ScriptGenerator

gen = ScriptGenerator()
script = gen.generate_script({
    'type': 'attack',
    'target': 'npc',
    'waves': 5,
    'troops': {'warrior': 1000, 'scout': 100}
}, description='NPC Farm Script')
```

#### Combat AI
| Tool | Path | Capability |
|------|------|------------|
| combat_strategy.py | G:\...\scripts\combat\ | AI combat decisions |
| troop_manager.py | Same | Troop coordination |
| troop_operations.py | Same | Attack operations |
| troop_safety.py | Same | Defense automation |
| troop_exploits.py | Same | Combat exploits |

#### Automation Management
| Tool | Path | Capability |
|------|------|------------|
| glitch_manager.py | G:\...\scripts\automation\ | Exploit management |
| chatbot_manager.py | Same | Chat automation |
| window_automation.py | Same | Window control |
| process_automation.py | Same | Process management |

---

### 3. MULTI-ACCOUNT AUTOMATION

#### Account Launcher Scripts
| Script | Path | Capability |
|--------|------|------------|
| launch_all_roboevony.ps1 | D:\...\ETK accounts\ | Launch 50+ bots |
| launch_all_roboevony.bat | Same | Batch launch |
| kill_all_roboevony.bat | Same | Mass terminate |
| monitor_roboevony.bat | Same | Health monitoring |

**PowerShell Integration:**
```powershell
# Launch all accounts
$accounts = Get-ChildItem "D:\Users\marki\Desktop\ETK accounts" -Directory
foreach ($account in $accounts) {
    $exe = Join-Path $account.FullName "roboevony.exe"
    if (Test-Path $exe) {
        Start-Process $exe -WorkingDirectory $account.FullName
        Start-Sleep -Seconds 2
    }
}
```

#### Account Configuration
| Config Type | Path | Format |
|-------------|------|--------|
| Khan JSON | D:\...\evony\khan\accounts\ | JSON |
| ETK Folders | D:\...\ETK accounts\*\ | Folder structure |

---

### 4. DECRYPTION & PROTOCOL AUTOMATION

#### Decryption Capabilities
| Capability | Tool | Keys Available |
|------------|------|----------------|
| AES Decrypt | evony_full_decryptor.py | 128/192/256-bit |
| Blowfish Decrypt | Same | Variable |
| 3DES Decrypt | Same | 168-bit |
| RC4 Decrypt | Same | Variable |
| XOR Decrypt | Same + decrypt_evony_protections.py | 0xAA |
| MD5 Context | Same | Hash-based |
| PBKDF2 | Same | Derived |

**Decryption Example:**
```python
from evony_full_decryptor import EvonyFullDecryptor

decryptor = EvonyFullDecryptor('client.swf', 'output/')

# Known keys available
keys = decryptor.known_keys
# {'api': '9f758e2deccbe6244f734371b9642eda', ...}

result = decryptor.try_decrypt_resource(encrypted_data)
if result.success:
    print(f"Decrypted using: {result.method_used}")
```

#### Protocol Automation
| Capability | Source | Details |
|------------|--------|---------|
| AMF Connection | Connection.as | Full socket handling |
| Session Management | Same | Cookie handling |
| Auto-Reconnect | Same | 10 sec timer |
| Health Check | Same | 5 min interval |
| Command Queue | Same | Send queue |

---

### 5. AI/ML AUTOMATION (PROPOSED)

#### Vision AI Capabilities
| Capability | Integration | Model |
|------------|-------------|-------|
| Map Scanning | Screenshot → GPT-4V | Cloud |
| NPC Detection | Screenshot → Claude | Cloud |
| Troop Count OCR | Screenshot → Vision | Cloud/Local |
| Building Level ID | Screenshot → Vision | Cloud/Local |
| Battle Report Parse | Screenshot → OCR | Local |

#### LLM Capabilities
| Capability | Integration | Model |
|------------|-------------|-------|
| Script Generation | NL → Script | GPT-4/Claude |
| Script Optimization | Script → Optimized | GPT-4/Claude |
| Error Explanation | Error → Fix | GPT-4/Claude |
| Strategy Advice | Situation → Advice | GPT-4/Claude |
| Chat Responses | Input → Response | Local LLM |

#### ML Capabilities
| Capability | Training Data | Model Type |
|------------|---------------|------------|
| Attack Timing | Historical logs | Time series |
| Resource Prediction | Resource logs | Regression |
| Player Behavior | Action logs | Classification |
| NPC Respawn | Spawn data | Pattern |
| Build Order | City data | Optimization |

---

## 📊 AUTOMATION INTEGRATION MATRIX

| Feature | Script | Python | Multi-Acct | Protocol | AI/ML | Priority |
|---------|--------|--------|------------|----------|-------|----------|
| Mass Attack | ✅ | ✅ | ✅ | ✅ | 🟡 | 🔴 |
| Troop Training | ✅ | ✅ | ✅ | ✅ | 🟢 | 🔴 |
| City Building | ✅ | ✅ | ✅ | ✅ | 🟡 | 🔴 |
| Hero Management | ✅ | 🟡 | ✅ | ✅ | 🟡 | 🟡 |
| Resource Glitch | ✅ | ✅ | ✅ | ❌ | ❌ | 🔴 |
| Map Scanning | ❌ | ✅ | ✅ | ✅ | ✅ | 🟡 |
| Chat Automation | ✅ | ✅ | ✅ | ✅ | ✅ | 🟢 |
| Script Generation | ❌ | ✅ | ❌ | ❌ | ✅ | 🟡 |
| Protocol Proxy | ❌ | ✅ | ✅ | ✅ | ❌ | 🟢 |
| Decision Engine | ❌ | ✅ | ❌ | ❌ | ✅ | 🟢 |

---

## 🔗 IMPLEMENTATION ROADMAP

### Phase 1: Core Automation (Week 1-2)
1. Port Commands.as command execution
2. Implement AMF protocol client from Connection.as
3. Integrate script parser from Script.as/ScriptCmd.as
4. Add evony_full_decryptor.py for encryption
5. Create basic multi-account launcher

### Phase 2: Advanced Automation (Week 3-4)
1. Integrate glitch_manager.py exploits
2. Add combat_strategy.py AI
3. Implement troop_manager.py coordination
4. Build script_generator.py integration
5. Create chatbot_manager.py for chat

### Phase 3: AI Automation (Week 5-6)
1. Add GPT-4V map scanning
2. Implement NL → Script generation
3. Build decision engine
4. Add pattern learning
5. Create prediction models

### Phase 4: Full Automation (Week 7-8)
1. Complete multi-account orchestration
2. Add protocol replay/proxy
3. Implement memory scanning
4. Build live SWF editing
5. Create automation dashboard

---

## 📝 NOTES

- All scripts require RoboEvony 1.60+ runtime
- Python tools require Python 3.10+
- AI features require API keys (OpenAI/Anthropic)
- Multi-account requires sufficient RAM (~500MB per instance)
- Exploits should be used at user's own risk

---

*Generated: 2026-01-02*
*Total Automation Capabilities: 50+*
