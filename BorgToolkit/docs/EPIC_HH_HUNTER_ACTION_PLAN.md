# Epic HH Hunter - Comprehensive Action Plan

> Complete analysis and implementation plan for Historic Hero hunting on the Evony map

---

## Executive Summary

After deep analysis of all source files, scripts, and protocol documentation, this document outlines the complete architecture for an **Epic HH Hunter** system that can:

1. **Identify unowned HH** via statistics page (existing capability)
2. **Scan the map** for Level 10 NPC cities (where unowned HH reside)
3. **Scout NPCs** and parse reports for HH defenders
4. **Track and alert** when HH are found
5. **Auto-capture** HH with optimized attack waves

---

## Source Code Analysis Summary

### Key APIs Discovered

| Component | Source | API/Method |
|-----------|--------|------------|
| Map Scanning | `[Start] - Snippet.txt` | `c.getMapFieldList(npc,10,radius,fieldId)` |
| Scout Command | `draftFinder_for_RE.txt` | `scout %coord% none s:1` |
| Report Fetching | `draftFinder_for_RE.txt` | `c.af.getReportCommands().receiveReportList(0,10,3)` |
| Report Reading | `draftFinder_for_RE.txt` | `c.af.getReportCommands().markAsRead(reportId)` |
| Report Content | `draftFinder_for_RE.txt` | `$%x%.report.content$` |
| Hero Detection | `spam_script_v13.4.txt` | `c.cm.heroes[f].isHero` (1 = HH) |
| HH Database | `HH_Hunting_Script.txt` | 692 HH names with IDs |
| Stats Lookup | `HH_Hunting_Script.txt` | `m_city.accountTab.statInfo.heroes.fetchPage()` |
| Attack Send | `fastattack.txt` | `c.af.getArmyCommands().newArmy()` |

### Protocol Commands (from `protocol_commands.py`)

```python
# Map & Field Commands
'common.mapInfo': {'params': ['x', 'y']}
'common.mapInfoSimple': {'params': ['x', 'y']}
'field.getOtherFieldInfo': {'params': ['x', 'y']}
'army.getOtherFieldInfo': {'params': ['x', 'y']}

# Report Commands  
'report.getReportList': {'params': ['castleId', 'type', 'pageNo', 'pageSize']}
'report.readReport': {'params': ['castleId', 'reportId']}

# Army Commands
'army.newArmy': {'params': ['castleId', 'newArmyBean']}
```

---

## Gap Analysis

### What EXISTS (from user scripts):

| Feature | Status | Source |
|---------|--------|--------|
| HH Database (692 heroes) | ✅ Complete | `HH_Hunting_Script.txt` |
| Stats-based HH detection | ✅ Complete | `HH_Hunting_Script.txt` |
| Map region scanning | ✅ Complete | `Scanmap.txt`, `[Start] - Snippet.txt` |
| NPC L10 list fetching | ✅ Complete | `c.getMapFieldList(npc,10,radius,fieldId)` |
| Basic scouting | ✅ Complete | `draftFinder_for_RE.txt` |
| Scout report parsing | ✅ Partial | `draftFinder_for_RE.txt` |
| Attack wave sending | ✅ Complete | `fastattack.txt` |

### What's MISSING (gaps to fill):

| Gap | Description | Priority |
|-----|-------------|----------|
| **HH Detection in Scout Reports** | Parse `report.content` for `isHero=1` or HH names | 🔴 CRITICAL |
| **Coordinated System** | Combine stats check + map scan + scout + capture | 🔴 CRITICAL |
| **HH Location Tracking** | Store found HH coords and freshness timestamps | 🟡 HIGH |
| **Multi-Region Scanning** | Scan all 16 states systematically | 🟡 HIGH |
| **Scout Report Hero Parser** | Extract hero name/stats from scout reports | 🔴 CRITICAL |
| **Auto-Capture Logic** | Send optimized waves when HH found | 🟢 MEDIUM |
| **Progress Logging** | Track scanning progress and results | 🟢 MEDIUM |

---

## Architecture Design

### System Flow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         EPIC HH HUNTER SYSTEM                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐    ┌───────────┐ │
│  │ Phase 1:     │    │ Phase 2:     │    │ Phase 3:     │    │ Phase 4:  │ │
│  │ Stats Check  │───▶│ Map Scan     │───▶│ Scout NPCs   │───▶│ Capture   │ │
│  │              │    │              │    │              │    │           │ │
│  │ - Fetch HH   │    │ - All L10s   │    │ - Send scout │    │ - Attack  │ │
│  │   stats      │    │   in region  │    │ - Parse rpt  │    │   waves   │ │
│  │ - Find       │    │ - Filter     │    │ - Check for  │    │ - Capture │ │
│  │   unowned    │    │   scanned    │    │   HH hero    │    │   HH      │ │
│  └──────────────┘    └──────────────┘    └──────────────┘    └───────────┘ │
│         │                   │                   │                   │       │
│         ▼                   ▼                   ▼                   ▼       │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │                         HH TRACKING DATABASE                          │  │
│  │  - Unowned HH list (from stats)                                      │  │
│  │  - Scanned NPC coords + timestamps                                   │  │
│  │  - Found HH locations + hero names                                   │  │
│  │  - Capture attempts + results                                        │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Scout Report Hero Detection

The KEY missing piece - extracting hero info from scout reports:

```javascript
// Scout report structure (from draftFinder analysis)
$%x%.report.content$ contains:
  - isSuccess="true/false"
  - troopStrType typeId="X" count="Y"
  - gold="amount"
  - <food>amount</food>
  
// NEED TO ADD: Hero detection
// Look for patterns like:
  - heroName="Name Here"
  - isHero="1"  (1 = Historic Hero, 0 = regular)
  - power="X" stratagem="Y" management="Z"
```

---

## Implementation Plan

### Phase 1: HH Stats Scanner (Enhance Existing)
**File:** `hh_stats_scanner.txt`

```
1. Fetch all HH from stats page
2. Check ownership status for each
3. Build "unowned HH" list
4. Output: List of HH names that are NOT owned by any player
```

### Phase 2: Map Scanner Module  
**File:** `hh_map_scanner.txt`

```
1. Define scan regions (all 16 states)
2. For each region:
   - scanmap center radius
   - getMapFieldList(npc,10,radius,center)
3. Build master list of all L10 NPCs
4. Track which have been scouted (with timestamps)
```

### Phase 3: Scout & Parse Module
**File:** `hh_scout_parser.txt`

```
1. For each unscanned L10 NPC:
   - Send 1 scout
   - Wait for report
   - Parse report.content for:
     a) isSuccess (was scout successful?)
     b) Hero name in defending army
     c) isHero flag (is it a Historic Hero?)
     d) Match against unowned HH list
2. If HH found:
   - Log coordinates
   - Alert user
   - Add to capture queue
```

### Phase 4: Capture Module
**File:** `hh_capture.txt`

```
1. When HH location confirmed:
   - Calculate optimal attack composition
   - Send breaker wave
   - Send capture waves
   - Monitor for success
2. Track capture attempts and results
```

### Phase 5: Master Controller
**File:** `epic_hh_hunter.txt`

```
1. Load configuration
2. Run Phase 1 (stats check)
3. Run Phase 2 (map scan)
4. Run Phase 3 (scout & parse)
5. Run Phase 4 (capture) when HH found
6. Loop with configurable intervals
```

---

## Configuration Options

```javascript
// === EPIC HH HUNTER CONFIGURATION ===

// Scanning Settings
set scanRadius 100           // Radius around each region center
set scanAllStates true       // Scan all 16 states or just specified
setarr targetStates "Friesland Saxony Bohemia"  // If not scanning all

// Scout Settings
set scoutsPerBatch 5         // How many scouts to send before checking reports
set scoutWaitTime 60         // Seconds to wait for scout reports
set rescoutInterval 3600     // Seconds before re-scouting an NPC (1 hour)

// HH Filtering
set searchForHeroesList "all"  // "all" or specific HH names
set prioritizeHeroOrder "atk"  // atk, pol, int, lead, alpha

// Capture Settings
set autoCaptureEnabled true  // Auto-send capture waves when HH found
set captureHeroMinAtk 300    // Minimum hero attack for capture attempts
set captureWaveDelay 3       // Seconds between capture waves

// Logging
set verboseLogging true      // Show detailed progress
set logToWarLog true         // Log to war log tab
```

---

## State Coordinates Reference

```javascript
// Map region centers for systematic scanning
setarray stateCoords [
    "100,100",   // Friesland (0,0 to 199,199)
    "300,100",   // Saxony (200,0 to 399,199)
    "500,100",   // North March (400,0 to 599,199)
    "700,100",   // Bohemia (600,0 to 799,199)
    "100,300",   // Lower Lorraine (0,200 to 199,399)
    "300,300",   // Franconia (200,200 to 399,399)
    "500,300",   // Thuringia (400,200 to 599,399)
    "700,300",   // Moravia (600,200 to 799,399)
    "100,500",   // Upper Lorraine (0,400 to 199,599)
    "300,500",   // Swabia (200,400 to 399,599)
    "500,500",   // Bavaria (400,400 to 599,599)
    "700,500",   // Carinthia (600,400 to 799,599)
    "100,700",   // Burgundy (0,600 to 199,799)
    "300,700",   // Lombardy (200,600 to 399,799)
    "500,700",   // Tuscany (400,600 to 599,799)
    "700,700"    // Romagna (600,600 to 799,799)
]
```

---

## Key Code Patterns to Implement

### Pattern 1: Get All L10 NPCs in Region
```javascript
scanmap %center% %radius%
set npcList $c.getMapFieldList(npc,10,%radius%,c.getValue(Coordinate,%center%))$
setarr npcs "%npcList%"
```

### Pattern 2: Scout and Wait for Report
```javascript
scout %coord% none s:1
sleep {$c.cm.getBaseTravelTime(c.castle.fieldId,c.getValue(Coordinate,%coord%),c.getValue(Troop,s:1))$+5}
set r $c.af.getReportCommands().receiveReportList(0,10,3)$
```

### Pattern 3: Parse Report Content
```javascript
set reportContent $%x%.report.content$
// Check for hero in report
if {$c.getValue(String,%reportContent%).indexOf(heroName=")$>0} goto foundHero
// Check if Historic Hero
if {$c.getValue(String,%reportContent%).indexOf(isHero="1")$>0} goto foundHH
```

### Pattern 4: Match Against HH Database
```javascript
// Check if hero name matches any in HH database
set heroStart {$c.getValue(String,%reportContent%).indexOf(heroName=")$+10}
set heroEnd $c.getValue(String,%reportContent%).indexOf(",%heroStart%)$
set foundHeroName $c.getValue(String,%reportContent%).substring(%heroStart%,%heroEnd%)$

// Compare against hhArr (692 HH names)
set hhIndex 0
label checkHHMatch
if {%foundHeroName%==%hhArr[{%hhIndex%}]%} goto confirmedHH
set hhIndex {%hhIndex%+1}
if {%hhIndex%<%hhArr.length%} goto checkHHMatch
```

---

## Files to Create

| File | Purpose | Lines (Est) |
|------|---------|-------------|
| `epic_hh_hunter.txt` | Master controller script | ~500 |
| `hh_database.txt` | Complete 692 HH names/IDs | ~700 |
| `hh_stats_scanner.txt` | Stats-based HH finder | ~200 |
| `hh_map_scanner.txt` | L10 NPC map scanner | ~150 |
| `hh_scout_parser.txt` | Scout report parser with HH detection | ~300 |
| `hh_capture.txt` | Auto-capture module | ~200 |
| **TOTAL** | | **~2050** |

---

## Testing Strategy

1. **Unit Test Stats Scanner** - Verify HH ownership detection
2. **Unit Test Map Scanner** - Verify L10 NPC list accuracy
3. **Unit Test Scout Parser** - Verify report parsing with test data
4. **Integration Test** - Run on single region first
5. **Full System Test** - Run on all 16 states

---

## Next Steps

1. ✅ Review complete - All source files analyzed
2. ⏳ Create `hh_database.txt` with all 692 HH
3. ⏳ Create `hh_map_scanner.txt` module
4. ⏳ Create `hh_scout_parser.txt` with HH detection
5. ⏳ Create `epic_hh_hunter.txt` master script
6. ⏳ Test and iterate

---

*Document Created: 2026-01-03*
*Based on analysis of 15+ source scripts and protocol documentation*
