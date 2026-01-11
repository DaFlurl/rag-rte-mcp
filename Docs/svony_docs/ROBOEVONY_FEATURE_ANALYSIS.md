# ROBOEVONY REFERENCE UI ANALYSIS
## Complete Feature Extraction from Screenshots

**Analysis Date:** January 2, 2026  
**Source:** 9 RoboEvony/AutoEvony Screenshots  
**Purpose:** Extract ALL features missing from Svony Studio for 1:1 parity

---

## 📸 SCREENSHOT ANALYSIS

### Screenshot 1: Main Bot Interface with Script Editor & Troop Table
**Features Identified:**

#### TOP BAR - Account/City Tabs
- Multiple city tabs: `aat(3,796)`, `bat(796,7)`, `Bor(790,796)`, `f(799,9)`, `Fal(0,799)`, `Hin(8,7)`, `Jer(300,700)`, `Moj(793,796)`
- Active city indicator: `Atl(0,0)` highlighted in green
- Quick-switch between cities

#### HEADER INFO BAR
- Alliance name with banner: "Borg"
- Server info: `Parapet (cc2)`
- Population: `1227`
- Gold: `44,841,205`
- Rank: `General`
- Medals: `234`
- Food indicator: `380`
- Member count
- Honor: `267,009,832`
- Title: `Prinzessin`
- Prestige: `5`
- **Clock display: `23:59:19`** (real-time)
- Pause/Refresh/Logout buttons

#### LEFT PANEL - Goals & Script Editor
- **Goals/Script tabs**
- Full ActionScript-like scripting:
  ```
  setarray gltcctv [...]
  label totalcount
  set fullmsg null
  #Glitch triggering number
  set glitchnumber 2147483647
  ```
- Syntax highlighting (yellow, white, cyan)
- **Save File / Load File buttons**
- **Run / Stop buttons**
- **Save / Load / Save All buttons**

#### RIGHT PANEL - City Info & Troop Table
- City name: `Atlantis`
- Coordinates: `(0,0) Friesland`
- Resources: Food `55,050`, Gold `-13,350`
- Loyalty: `100%`
- **Troop Table with columns:**
  - Troop type (worker, warrior, scout, pikemen, swordsmen, archer, cavalry, cataphract, transport, ballista, battering ram, catapult)
  - R, V, C, I, H, B, S, G, A, T, Q, F, X, E columns
  - Avail, Total, All, Queue, Goal, Remain, Reinf. columns
  - **Tooltip showing:** "Avail: 1,786,706,432 Total: 1,786,706,432 (ontraining) 0.051% -38 +74,013"

#### BOTTOM TABS
- **Log / City Log / War Log / Maps / Account / Snippets**

#### BOTTOM PANEL - Items/Inventory
- **Mail / Alliance / Statistics / Historic Heroes / Legendary Hero / Items / Reports tabs**
- Item table: Name, Desc, Price, Count, Action (View button)
- Items listed: Speaker, Delicate_gem, City_Teleporter, Bernini's_Hammer, etc.

#### CHAT PANEL
- **Alliance Chat / Private Chat / World Chat / System / Commands tabs**
- Chat messages with timestamps and usernames

---

### Screenshot 2: New Army Dialog
**Features Identified:**

#### Army Deployment Dialog
- **Title:** "New Army"
- City selector: `Atlantis(0,0)`
- **Dispatch limit:** `0 / 375,000`
- **Available Rally Slots:** `10`
- **Apply War Ensign** checkbox
- **Apply Stygandt's Banner** checkbox
- **Target coordinates:** X, Y inputs with "none" dropdown
- **Mission type dropdown:** Attack
- **Hero selector:** `Queen (100) 85/754/85`
- **Hero options:** HH, LH, Pol, Atk, Int checkboxes
- **Camp Time:** hours:minutes:seconds + "time" button
- **Load capacity:** `16,300,000 / 16,300,000`

#### Troop Selection Grid
- Troop icons with quantity inputs
- **Clear button**
- Resource/item counts for each troop type
- Massive numbers displayed (billions)

#### Preset Management
- **Save Preset button**
- Preset dropdown selector

#### Army Queue Table
- Columns: Army, Target, Remain time, Action, View

#### Deployment Info
- Distance calculation
- Required food
- One-way time
- Arrival time
- **Deploy button**

#### Checkboxes at bottom
- Enemy, Valley, Colony options

---

### Screenshot 3: Hero Equipment & Historic Heroes
**Features Identified:**

#### Gear Table (Right Panel)
- **Columns:** Gear Name, Level, Star, Bonus, Cooldown, Upgrade
- Equipment slots: weapon, shield, mount, necklace, charm, ring, head, shoulder, chest, back, gauntlets, belts, legs, foot
- All showing 10/10 Level, 15 Star, +37.98 or +75.96 Bonus

#### Historic Heroes Panel (Bottom Left)
- **Search box**
- **Hearsay / Buy Details / Accept Task buttons**
- Hero list: Frederick III, Gaius Duilus, Martin Luther, Niccolo de Conti, Ovid, Pachacuti, René Descartes
- **Hero Details:**
  - Name, ID
  - Ownership info
  - Owner, Level, Stats
  - Alliance, Rank, Prestige, Honor
  - StarSet, Cities, Population, Title
  - Office, Flag
- **Inn Keeper section** with purchase option
- **History section** with historical info

---

### Screenshot 4: Map View & Building List
**Features Identified:**

#### Building Table
- **Columns:** Building, Level(s)
- Buildings: Wall, Cottage, Barrack, Farm, Market, Relief Station, Academy, Workshop, Feasting Hall, Embassy, Rally Spot, Beacon Tower, Townhall
- Multiple building levels shown (e.g., Farm: 18 repeated many times)

#### Interactive Map (Bottom)
- **Colored tile grid** showing territory
- **Coordinates:** X, Y inputs
- **Scale slider:** 32
- **Valleys checkbox**
- **Tooltip on hover:**
  - Castle name and coordinates
  - Distance from city
  - Distance from coord
  - Status (peace)
  - Location (Atlantis in FRIESLAND)
  - Owner, Alliance, Prestige, Honor
  - "Double click to fetch player information"

---

### Screenshot 5: Different Theme (Gold) & Transport Mission
**Features Identified:**

#### Gold/Yellow Theme
- Different color scheme from dark blue
- Player: `CrazyJR`
- Multiple cities visible in tabs

#### New Army Dialog (Transport)
- **Mission: Transport** selected
- Hero dropdown empty
- Different troop allocation
- Resource amounts shown

#### Items Panel
- More items visible: Courage_Medal, Flawless_gem, Lion_Medal, Honor_Medal, Wisdom_Medal, Freedom_Medal, Speaker, City_Teleporter, etc.

---

### Screenshot 6: Hero Management Panel
**Features Identified:**

#### Hero Table
- **Columns:** View, Hero, Status, Level, Type, Base, Energy, Recall, Fire
- Heroes listed: Queen, LeifEricson, NancyWard, HenryIV, Tess, Ansel, Armstrong, Murphy
- Status: Idle for all
- Levels: 100-150
- Types: Atk (Attack stats shown)
- **Fire buttons** for dismissing heroes
- **View buttons** for each hero

#### City Log (Bottom)
- Timestamped entries
- Color-coded messages:
  - White: Normal operations
  - Yellow: Warnings ("FOOD IS LOW, UNDER 1 DAY LEFT")
  - Config settings displayed

---

### Screenshot 7: Empty Hero Recruitment Table
**Features Identified:**

#### Hero Recruitment Panel
- **Columns:** Hero, Type, Lvl, Stats, Base, Hire
- Empty table (Inn not refreshed)
- Same log panel below

---

### Screenshot 8: Valley/Coordinate View
**Features Identified:**

#### Coordinate Table
- **Columns:** Coord, Lord, Prestige, Relation, Event Time, Abandon
- Shows valley/NPC coordinates
- Empty in this view

---

### Screenshot 9: Valley Management
**Features Identified:**

#### Valley Table
- **Columns:** Coord, Type, Level, Distance, Abandon
- Valley entry: `(799,0)`, Grassland, Level 8, Distance 1
- **Abandon button** for each valley

---

## 🔴 FEATURES MISSING FROM SVONY STUDIO

### Category 1: Live Bot Interface (NOT IN SVONY)
| Feature | Priority | Complexity |
|---------|----------|------------|
| Multi-city tabs with quick-switch | P0 | High |
| Real-time clock display | P1 | Low |
| Pause/Refresh/Logout controls | P0 | Medium |
| Live troop table with all columns | P0 | High |
| Resource bars (food/gold/loyalty) | P0 | Medium |
| City coordinates display | P1 | Low |

### Category 2: Script Editor (PARTIAL IN SVONY)
| Feature | Priority | Complexity |
|---------|----------|------------|
| Goals/Script tab separation | P1 | Medium |
| Full scripting language support | P0 | High |
| Save File/Load File buttons | P1 | Low |
| Run/Stop script execution | P0 | High |
| Save/Load/Save All for goals | P1 | Medium |
| Syntax highlighting for bot scripts | P1 | Medium |
| Snippets tab with presets | P1 | Medium |

### Category 3: Army Deployment (NOT IN SVONY)
| Feature | Priority | Complexity |
|---------|----------|------------|
| New Army dialog | P0 | High |
| Dispatch limit display | P1 | Low |
| Rally slots counter | P1 | Low |
| War Ensign/Banner toggles | P2 | Low |
| Target coordinate inputs | P0 | Medium |
| Mission type dropdown | P0 | Low |
| Hero selector with stats | P0 | High |
| Hero option checkboxes (HH/LH/Pol/Atk/Int) | P1 | Low |
| Camp time configuration | P1 | Medium |
| Load capacity display | P1 | Low |
| Troop selection grid with icons | P0 | High |
| Preset save/load | P1 | Medium |
| Army queue table | P1 | Medium |
| Distance/time calculations | P1 | Medium |
| Deploy button | P0 | Medium |

### Category 4: Hero Management (NOT IN SVONY)
| Feature | Priority | Complexity |
|---------|----------|------------|
| Hero table with View/Fire actions | P1 | Medium |
| Hero status tracking | P1 | Medium |
| Hero stats display (Type/Base/Energy) | P1 | Medium |
| Hero recruitment panel | P2 | Medium |
| Historic Heroes browser | P2 | High |
| Hero search functionality | P2 | Low |
| Hero details with history | P2 | Medium |
| Gear/Equipment table | P2 | Medium |

### Category 5: Map & Territory (NOT IN SVONY)
| Feature | Priority | Complexity |
|---------|----------|------------|
| Interactive colored map grid | P1 | High |
| Map coordinate navigation | P1 | Medium |
| Scale/zoom control | P2 | Medium |
| Valley visibility toggle | P2 | Low |
| Hover tooltips with player info | P1 | Medium |
| Double-click for player details | P2 | Medium |
| Valley management table | P1 | Medium |
| Abandon valley functionality | P2 | Low |

### Category 6: Logging & Chat (NOT IN SVONY)
| Feature | Priority | Complexity |
|---------|----------|------------|
| City Log tab | P1 | Medium |
| War Log tab | P1 | Medium |
| Color-coded log messages | P1 | Low |
| Alliance Chat panel | P1 | High |
| Private Chat panel | P2 | High |
| World Chat panel | P2 | High |
| System messages panel | P1 | Medium |
| Commands panel | P1 | Medium |
| Send message functionality | P1 | Medium |

### Category 7: Inventory & Items (NOT IN SVONY)
| Feature | Priority | Complexity |
|---------|----------|------------|
| Items table with descriptions | P1 | Medium |
| Item count display | P1 | Low |
| View item button | P2 | Low |
| Mail tab | P2 | Medium |
| Alliance tab | P2 | Medium |
| Statistics tab | P1 | Medium |
| Reports tab | P1 | Medium |

### Category 8: Building Management (NOT IN SVONY)
| Feature | Priority | Complexity |
|---------|----------|------------|
| Building list with levels | P1 | Medium |
| Multiple building instances | P1 | Medium |

---

## 🛠️ REAL-TIME TESTING & DEBUGGING FEATURES NEEDED

### Live Testing Without Rebuild
| Feature | Description | Priority |
|---------|-------------|----------|
| **Hot Script Reload** | Modify scripts and apply without restarting bot | P0 |
| **Live Variable Watch** | Monitor script variables in real-time | P0 |
| **Breakpoint System** | Pause script execution at specific lines | P1 |
| **Step Execution** | Execute scripts line-by-line | P1 |
| **Console Injection** | Execute commands directly in running bot | P0 |
| **AMF Message Preview** | See outgoing/incoming messages before sending | P0 |
| **Response Mocking** | Test with fake server responses | P1 |
| **State Snapshots** | Save/restore bot state for testing | P2 |

### SWF Modification Pipeline
| Feature | Description | Priority |
|---------|-------------|----------|
| **Auto-Unpack on Load** | Decompress/decompile SWF automatically | P0 |
| **Live Edit Mode** | Edit decompiled code with instant preview | P0 |
| **Auto-Repack** | One-click rebuild modified SWF | P0 |
| **Diff View** | Show changes before rebuild | P1 |
| **Rollback** | Undo changes and restore original | P1 |
| **Test Launch** | Launch modified SWF in Ruffle/Flash immediately | P0 |
| **Connect to Server** | Test modified client against live server | P0 |
| **Proxy Inject** | Route traffic through proxy for inspection | P0 |

### Debugging Tools
| Feature | Description | Priority |
|---------|-------------|----------|
| **Protocol Replay** | Replay captured AMF sequences | P0 |
| **Request Editor** | Modify requests before sending | P0 |
| **Response Editor** | Modify responses before processing | P1 |
| **Timing Analysis** | Measure request/response times | P2 |
| **Error Injection** | Test error handling by injecting failures | P2 |
| **Memory Inspector** | View SWF memory state | P1 |
| **Call Stack Viewer** | See function call hierarchy | P1 |

---

## 📊 TOTAL MISSING FEATURES COUNT

| Category | Features | In Svony | Missing |
|----------|----------|----------|---------|
| Live Bot Interface | 6 | 0 | 6 |
| Script Editor | 7 | 2 | 5 |
| Army Deployment | 15 | 0 | 15 |
| Hero Management | 8 | 0 | 8 |
| Map & Territory | 8 | 0 | 8 |
| Logging & Chat | 9 | 1 | 8 |
| Inventory & Items | 7 | 0 | 7 |
| Building Management | 2 | 0 | 2 |
| Real-time Testing | 8 | 0 | 8 |
| SWF Pipeline | 8 | 3 | 5 |
| Debugging Tools | 7 | 1 | 6 |
| **TOTAL** | **85** | **7** | **78** |

---

## 🎯 PRIORITY IMPLEMENTATION ORDER

### Phase 1: Core Bot Connection (Week 1-2)
1. AMF protocol connection to game server
2. Login/authentication handling
3. Basic city data retrieval
4. Troop table display
5. Resource monitoring

### Phase 2: Script Engine (Week 3-4)
6. Bot scripting language parser
7. Script execution engine
8. Hot reload capability
9. Run/Stop controls
10. Variable watching

### Phase 3: Live Testing (Week 5-6)
11. Protocol replay
12. Request/response editing
13. Proxy integration
14. Console injection
15. Breakpoints

### Phase 4: Full Bot UI (Week 7-8)
16. Multi-city tabs
17. Army deployment dialog
18. Hero management
19. Map view
20. Chat integration

---

**This document identifies 78 missing features from the RoboEvony reference that should be in Svony Studio for complete bot integration and real-time testing capabilities.**
