# 🚀 EPIC TRAINING PLAN
## Maximum Quality Model for Evony Client + AutoEvony

**Version:** 1.0  
**Created:** January 2026  
**Target:** F16 Quality Model with Complete Domain Coverage  
**Collaboration:** Windsurf + Claude + ChatGPT

---

# 📊 COVERAGE MATRIX

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    EPIC TRAINING COVERAGE MATRIX                             │
├─────────────────────┬──────────┬──────────┬──────────────────────────────────┤
│ Category            │ Priority │ Files    │ Training Focus                   │
├─────────────────────┼──────────┼──────────┼──────────────────────────────────┤
│ 🔴 ENUMS            │ CRITICAL │ 50+      │ All constants, bugs, fixes       │
│ 🔴 PROTOCOL         │ CRITICAL │ 30+      │ AMF, commands, packets           │
│ 🟠 GUI/UI           │ HIGH     │ 200+     │ Components, windows, dialogs     │
│ 🟠 SCRIPTING        │ HIGH     │ 40+      │ ScriptWindow, commands, parser   │
│ 🟡 ANIMATIONS       │ MEDIUM   │ 100+     │ Effects, tweens, transitions     │
│ 🟡 SOUNDS           │ MEDIUM   │ 20+      │ SoundManager, effects            │
│ 🟡 LOGS             │ MEDIUM   │ 10+      │ CityLog, WarLog, DebugLog        │
│ 🟢 LOADING          │ LOW      │ 5+       │ SWF loader, splash, logo         │
│ 🔴 CVE SECURITY     │ CRITICAL │ 2862     │ Flash vulnerabilities            │
└─────────────────────┴──────────┴──────────┴──────────────────────────────────┘
```

---

# 🎯 PHASE BREAKDOWN

## PHASE A: ENUMS (MOST COMPLEX - HIGHEST PRIORITY)
**Why Critical:** "Enums were the worst to work on, most complex in all of AutoEvony" - Original Programmer

### A.1 Constant Files to Train On
```
ErrorCode.as           - 200+ error codes, DUPLICATE BUG at -52
TFConstants.as         - Troop/Fort types, ID GAPS at 0-1, 14-19
HeroConstants.as       - Hero status, DUPLICATE with CityStateConstants
FieldConstants.as      - Field types, TYPOS (STAUTS vs STATUS)
ObjConstants.as        - Object types, TYPO (AVAIBLE vs AVAILABLE)
ArmyConstants.as       - Army missions, MISSING codes 1-16
BuildingConstants.as   - 40+ building types
TechConstants.as       - Technology IDs
CommonConstants.as     - Quest/effort types, TYPO (ACHIEVMENT)
ColonyConstants.as     - Colony status, TYPO (ABADON)
NpcHeroBean.as         - 3 VERSIONS with inconsistent constants!
EvonyAnimation.as      - 250+ animation type constants
```

### A.2 Training Data to Generate
| Topic | Examples | Format |
|-------|----------|--------|
| Enum values & meanings | 500 | Q&A |
| Bug identification | 100 | Analysis |
| Correct usage patterns | 200 | Code snippets |
| Cross-reference lookups | 150 | Mapping tables |
| **TOTAL** | **950** | |

### A.3 Example Training Pairs
```json
{
  "messages": [
    {"role": "user", "content": "What is TFConstants.T_CATAPHRACT in Evony?"},
    {"role": "assistant", "content": "TFConstants.T_CATAPHRACT = 9 represents Cataphracts (Heavy Cavalry) in the Evony troop type system. Note: Troop IDs start at 2 (T_PEASANTS), with IDs 0-1 reserved. The gap between troops (13) and fortifications (20) is intentional for category separation."}
  ]
}
```

---

## PHASE B: PROTOCOL & NETWORKING
**Why Critical:** Core communication layer between client and server

### B.1 Protocol Files
```
GameClient.as          - Main client socket handler
ServerConnection.as    - Socket connection management
CommMgr.as             - Communication manager
CommandManager.as      - Command dispatch
AMFSerializer.as       - AMF3 serialization
AMFDeserializer.as     - AMF3 deserialization
PacketHandler.as       - Packet processing
EncryptionManager.as   - AES encryption layer
```

### B.2 Command Categories (301+ Commands)
```
army.*                 - Troop movement, attacks
building.*             - Construction, upgrades
city.*                 - City management
hero.*                 - Hero operations
alliance.*             - Alliance operations
mail.*                 - Messaging
quest.*                - Quests and achievements
shop.*                 - Item shop
trade.*                - Market trading
fortifications.*       - Defense building
```

### B.3 Training Data to Generate
| Topic | Examples | Format |
|-------|----------|--------|
| Command syntax | 301 | Reference |
| Packet structure | 100 | Technical |
| Request/Response pairs | 200 | Examples |
| Error handling | 100 | Patterns |
| Encryption details | 50 | Technical |
| **TOTAL** | **751** | |

---

## PHASE C: GUI & UI COMPONENTS
**Why Important:** User explicitly prioritized GUI for new features

### C.1 Core UI Classes
```
MainScreen.as          - Main game interface
RootWin.as             - Root window container
DialogManager.as       - Dialog/popup management
WindowManager.as       - Window lifecycle
UIComponent.as         - Base UI component (262 matches)
Button.as              - Button components
TextInput.as           - Text input fields
DataGrid.as            - Data tables
List.as                - List components
ComboBox.as            - Dropdown selects
```

### C.2 Game-Specific Windows
```
CityView.as            - City management view
MapView.as             - World map interface
ArmyView.as            - Army management
HeroView.as            - Hero management
AllianceView.as        - Alliance interface
MailView.as            - Mail system
QuestView.as           - Quest tracker
ShopView.as            - Item shop
ReportView.as          - Battle reports
```

### C.3 AutoEvony-Specific UI
```
AdvancedScriptWindow.as - Script editor (14 references)
CityLogWindow.as       - City activity log
WarLogWindow.as        - War/battle log
AccountPanel.as        - Account management
SettingsPanel.as       - Bot settings
StatusBar.as           - Status display
```

### C.4 Training Data to Generate
| Topic | Examples | Format |
|-------|----------|--------|
| Component usage | 200 | Code patterns |
| Event handling | 150 | Examples |
| Layout management | 100 | Techniques |
| Window creation | 100 | Templates |
| AutoEvony UI | 150 | Specific |
| **TOTAL** | **700** | |

---

## PHASE D: SCRIPTING SYSTEM
**Why Important:** Core automation feature of AutoEvony

### D.1 Scripting Components
```
AdvancedScriptWindow.as  - Main script editor
ScriptParser.as          - Script parsing
ScriptExecutor.as        - Script execution
ScriptCommands.as        - Available commands
ScriptVariables.as       - Variable management
ScriptConditions.as      - Conditional logic
```

### D.2 Script Commands to Document
```
set <var> <value>        - Variable assignment
if <condition>           - Conditional
goto <label>             - Jump to label
call <function>          - Function call
return                   - Return from function
wait <ms>                - Delay execution
log <message>            - Debug output
modifyResource           - Resource manipulation
sendArmy                 - Send army command
buildBuilding            - Construction
trainTroops              - Troop training
upgradeHero              - Hero upgrade
```

### D.3 Training Data to Generate
| Topic | Examples | Format |
|-------|----------|--------|
| Command syntax | 100 | Reference |
| Script examples | 200 | Complete scripts |
| Error handling | 50 | Debugging |
| Advanced patterns | 100 | Techniques |
| **TOTAL** | **450** | |

---

## PHASE E: ANIMATIONS & EFFECTS
**Why Important:** Visual feedback, game feel

### E.1 Animation Classes
```
Animation.as             - Core animation (199 matches)
AnimateInstance.as       - Animation instances (132)
AnimateTransform.as      - Transform animations (112)
Tween.as                 - Tweening engine (54)
EffectManager.as         - Effect coordination (192)
Effect.as                - Base effect class (57)
EffectInstance.as        - Effect instances (91)
```

### E.2 Effect Types
```
Fade                     - Opacity transitions
Move                     - Position animations
Resize                   - Size animations
Rotate                   - Rotation effects
Glow                     - Glow effects
Blur                     - Blur effects
Dissolve                 - Dissolve transitions
Iris                     - Iris wipe effects
Zoom                     - Zoom transitions
```

### E.3 Training Data to Generate
| Topic | Examples | Format |
|-------|----------|--------|
| Animation basics | 100 | Tutorials |
| Effect usage | 100 | Examples |
| Custom effects | 50 | Advanced |
| Performance tips | 50 | Optimization |
| **TOTAL** | **300** | |

---

## PHASE F: SOUND SYSTEM
**Why Important:** Audio feedback, atmosphere

### F.1 Sound Classes
```
SoundEffect.as           - Sound effect player (83 matches)
SoundEffectInstance.as   - Sound instances (80)
SoundManager.as          - Sound coordination
SoundChannel.as          - Audio channels
```

### F.2 Training Data to Generate
| Topic | Examples | Format |
|-------|----------|--------|
| Sound playback | 50 | Examples |
| Volume control | 30 | Techniques |
| Sound events | 40 | Patterns |
| **TOTAL** | **120** | |

---

## PHASE G: LOGGING SYSTEMS
**Why Important:** Debugging, activity tracking

### G.1 Log Components
```
CityLog                  - City activity tracking
WarLog                   - Battle/war records
DebugLog                 - Debug output
EventLog                 - Event history
```

### G.2 Training Data to Generate
| Topic | Examples | Format |
|-------|----------|--------|
| Log formats | 50 | Reference |
| Log analysis | 50 | Techniques |
| Custom logging | 50 | Examples |
| **TOTAL** | **150** | |

---

## PHASE H: LOADING & INITIALIZATION
**Why Important:** SWF loading, splash screen, Evony logo

### H.1 Loading Components
```
Main.as                  - Entry point
Preloader.as             - Asset preloader
SplashScreen.as          - Loading splash
LogoAnimation.as         - Evony logo animation
AssetManager.as          - Asset loading
```

### H.2 Training Data to Generate
| Topic | Examples | Format |
|-------|----------|--------|
| Load sequence | 30 | Technical |
| Asset management | 40 | Examples |
| Progress tracking | 30 | Patterns |
| **TOTAL** | **100** | |

---

# 📈 TOTAL TRAINING DATA TARGETS

```
┌─────────────────────────────────────────────────────────────────┐
│                 TRAINING DATA SUMMARY                            │
├─────────────────────┬────────────┬───────────────────────────────┤
│ Phase               │ Examples   │ Status                        │
├─────────────────────┼────────────┼───────────────────────────────┤
│ Existing Base       │   15,104   │ ✅ COMPLETE (Phase 1+2)       │
│ CVE Security        │    2,862   │ ✅ COMPLETE                   │
│ A: Enums            │      950   │ 🔄 TO GENERATE                │
│ B: Protocol         │      751   │ 🔄 TO GENERATE                │
│ C: GUI/UI           │      700   │ 🔄 TO GENERATE                │
│ D: Scripting        │      450   │ 🔄 TO GENERATE                │
│ E: Animations       │      300   │ 🔄 TO GENERATE                │
│ F: Sounds           │      120   │ 🔄 TO GENERATE                │
│ G: Logging          │      150   │ 🔄 TO GENERATE                │
│ H: Loading          │      100   │ 🔄 TO GENERATE                │
├─────────────────────┼────────────┼───────────────────────────────┤
│ GRAND TOTAL         │   21,487   │ 🎯 TARGET                     │
└─────────────────────┴────────────┴───────────────────────────────┘
```

---

# 🛠️ IMPLEMENTATION PLAN

## Week 1: Enum Deep Dive (CRITICAL)
- [ ] Extract ALL enum constants from source
- [ ] Document all 27 identified bugs
- [ ] Generate 950 enum training examples
- [ ] Validate against source code

## Week 2: Protocol & Commands
- [ ] Document all 301+ commands
- [ ] Create packet structure examples
- [ ] Generate protocol training data
- [ ] Include encryption details

## Week 3: GUI & Scripting
- [ ] Map all UI components
- [ ] Document scripting commands
- [ ] Create UI pattern examples
- [ ] Generate script examples

## Week 4: Effects, Sounds, Loading
- [ ] Document animation system
- [ ] Map sound effects
- [ ] Document load sequence
- [ ] Generate remaining training data

## Week 5: Training & Validation
- [ ] Merge all training data
- [ ] Train F16 model on RunPod
- [ ] Validate model quality
- [ ] Iterate if needed

---

# 🔧 GENERATION SCRIPTS NEEDED

## 1. Enum Generator
```python
# generate_enum_training.py
# Extract all constants, generate Q&A pairs
```

## 2. Protocol Generator
```python
# generate_protocol_training.py
# Parse commands, create examples
```

## 3. GUI Generator
```python
# generate_gui_training.py
# Document components, patterns
```

## 4. Script Generator
```python
# generate_script_training.py
# Create script examples
```

---

# 🎯 SUCCESS CRITERIA

1. **Enum Mastery**: Model correctly identifies all enum values and bugs
2. **Protocol Knowledge**: Model explains any of 301+ commands
3. **GUI Expertise**: Model generates valid UI component code
4. **Scripting**: Model writes working AutoEvony scripts
5. **Animation**: Model creates effect configurations
6. **Security**: Model identifies CVE-relevant code patterns

---

# 📋 COLLABORATION TASKS

## Windsurf Tasks
- [ ] Create generation scripts
- [ ] Run data extraction
- [ ] Manage training pipeline
- [ ] Validate output

## Claude Tasks
- [ ] Generate enum documentation
- [ ] Create protocol examples
- [ ] Write script examples
- [ ] Security analysis

## ChatGPT Tasks
- [ ] Research Flash CVEs
- [ ] Generate Q&A variations
- [ ] Review training quality
- [ ] Suggest improvements

---

*EPIC TRAINING PLAN v1.0*
*Target: 21,487+ training examples*
*Output: F16 quality model with complete Evony/AutoEvony coverage*
