#!/usr/bin/env python3
"""
BORG TOOLKIT - Advanced Exploit Server
=======================================

EPIC level exploitation framework that leverages:
- Complete protocol knowledge (301+ commands)
- Extracted encryption keys
- Integer overflow calculations
- Race condition automation
- Packet injection chains
- Automated exploit sequences

This is NOT a basic script server - this is a full exploitation framework.

Usage:
    python advanced_server.py

In AutoEvony:
    includeurl http://localhost:8088/epic/overflow_chain
    includeurl http://localhost:8088/epic/resource_drain
    includeurl http://localhost:8088/api/troop.produceTroop?num=6135037
"""

from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse, parse_qs
import json
import hashlib
import time
from datetime import datetime
from typing import Dict, List, Any

PORT = 8088
HOST = "0.0.0.0"

# =============================================================================
# ENCRYPTION KEYS - Extracted from source
# =============================================================================
KEYS = {
    'ACTION_KEY': "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}",
    'API_KEY': "9f758e2deccbe6244f734371b9642eda",
    'USER_INFO_KEY': "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}",
    'XOR_KEY': 0xAA,
    'LOGIN_SALT': "evony",
}

# =============================================================================
# INTEGER LIMITS & OVERFLOW THRESHOLDS
# =============================================================================
INT32_MAX = 2147483647
INT32_MIN = -2147483648
UINT32_MAX = 4294967295

TROOP_COSTS = {
    1: {'name': 'worker', 'food': 50},
    2: {'name': 'warrior', 'food': 75},
    3: {'name': 'scout', 'food': 100},
    4: {'name': 'pikeman', 'food': 200},
    5: {'name': 'swordsman', 'food': 250},
    6: {'name': 'archer', 'food': 350},
    7: {'name': 'cavalry', 'food': 800},
    8: {'name': 'cataphract', 'food': 1500},
    9: {'name': 'transporter', 'food': 300},
    10: {'name': 'ballista', 'food': 2000},
    11: {'name': 'ram', 'food': 2500},
    12: {'name': 'catapult', 'food': 3000},
}

def calc_overflow_threshold(food_cost: int) -> int:
    """Calculate overflow threshold for troop production"""
    return (INT32_MAX // food_cost) + 1


OVERFLOW_THRESHOLDS = {
    troop_id: calc_overflow_threshold(data['food'])
    for troop_id, data in TROOP_COSTS.items()
}

# =============================================================================
# EPIC EXPLOIT CHAINS - Automated sequences
# =============================================================================

EPIC_EXPLOITS = {
    # =========================================================================
    # OVERFLOW CHAIN - Multiple troop types for maximum gain
    # =========================================================================
    'overflow_chain': """// BORG TOOLKIT - EPIC OVERFLOW CHAIN
// Cycles through all troop types with overflow values
// Maximum resource extraction per run

setsilence off
echo ========================================
echo EPIC OVERFLOW CHAIN - ALL TROOPS
echo ========================================

// Phase 1: Archers (lowest cost = safest)
echo [1/4] Archer overflow...
train a:6135037
sleep 500
cleartroopqueues
sleep 500

// Phase 2: Cavalry
echo [2/4] Cavalry overflow...
train cav:2684355
sleep 500
cleartroopqueues
sleep 500

// Phase 3: Cataphract
echo [3/4] Cataphract overflow...
train cata:1431656
sleep 500
cleartroopqueues
sleep 500

// Phase 4: Ballista
echo [4/4] Ballista overflow...
train ba:1073742
sleep 500
cleartroopqueues

echo ========================================
echo OVERFLOW CHAIN COMPLETE
echo Check resources - should see MASSIVE gain
echo ========================================
""",

    # =========================================================================
    # RESOURCE DRAIN - Extract all resources from account
    # =========================================================================
    'resource_drain': """// BORG TOOLKIT - RESOURCE DRAIN
// Maximize resource extraction through multiple methods

setsilence off
echo ========================================
echo RESOURCE DRAIN - MULTI-METHOD
echo ========================================

// Method 1: Tax levy spam
echo [1] Tax levy spam...
set i 0
label taxloop
levy tax
sleep 100
set i i+1
if i < 10 goto taxloop

// Method 2: Colony levy
echo [2] Colony levy...
colony levyfood all
colony levytax all
colony levyarmy all

// Method 3: Quest rewards
echo [3] Claiming all quests...
completequests all

// Method 4: Package claims
echo [4] Checking packages...
getpackages

echo ========================================
echo RESOURCE DRAIN COMPLETE
echo ========================================
""",

    # =========================================================================
    # RACE CONDITION BLITZ - Rapid fire item use
    # =========================================================================
    'race_blitz': """// BORG TOOLKIT - RACE CONDITION BLITZ
// Fires 50 rapid item uses to exploit race condition

setsilence off
echo ========================================
echo RACE CONDITION BLITZ
echo 50 rapid uses - NO DELAYS
echo ========================================

// Target item - CHANGE THIS
set item player.item.speed.1hr

// BLITZ - no delays between uses
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item
useitem $item

echo ========================================
echo 50 USES FIRED
echo Check if more than 1 item was consumed
echo ========================================
""",

    # =========================================================================
    # SECURITY BYPASS - Security code attacks
    # =========================================================================
    'security_bypass': """// BORG TOOLKIT - SECURITY BYPASS
// Attempts to enumerate security codes

setsilence off
echo ========================================
echo SECURITY CODE ENUMERATION
echo Trying common codes...
echo ========================================

// Try common 4-digit codes
authsecurity 0000
authsecurity 1111
authsecurity 1234
authsecurity 4321
authsecurity 9999
authsecurity 0123
authsecurity 1212
authsecurity 2580
authsecurity 1313
authsecurity 6969

echo ========================================
echo Common codes attempted
echo For full brute force, use external tool
echo ========================================
""",

    # =========================================================================
    # ARMY CLONER - Duplicate armies via race condition
    # =========================================================================
    'army_clone': """// BORG TOOLKIT - ARMY CLONER
// Attempts to duplicate armies via race condition

setsilence off
echo ========================================
echo ARMY CLONING ATTEMPT
echo ========================================

// Send same army to multiple targets rapidly
// May create duplicate armies if server doesn't lock

set target1 500,500
set target2 501,501
set target3 502,502

// Rapid dispatch attempts
attack $target1 any all 0
attack $target2 any all 0
attack $target3 any all 0

echo ========================================
echo Clone attempt complete
echo Check if multiple armies were created
echo ========================================
""",

    # =========================================================================
    # INFINITE RESOURCES - Combined exploits
    # =========================================================================
    'infinite_resources': """// BORG TOOLKIT - INFINITE RESOURCES
// Combines multiple exploits for maximum gain

setsilence off
echo ========================================
echo INFINITE RESOURCES EXPLOIT
echo Running all resource exploits...
echo ========================================

// Step 1: Valley hide (stop food drain)
echo [PHASE 1] Hiding troops in valleys...
reinforce 500,500 any all none
sleep 1000

// Step 2: Overflow exploit
echo [PHASE 2] Running overflow...
train a:6135037
sleep 500
cleartroopqueues
sleep 500

// Step 3: Negative trade (if works)
echo [PHASE 3] Negative trade attempt...
// newtrade food -1000000 1

// Step 4: Tax spam
echo [PHASE 4] Tax levy spam...
set i 0
label taxloop
settaxrate 100
levy tax
comfort disaster
set i i+1
if i < 5 goto taxloop

// Step 5: Colony drain
echo [PHASE 5] Colony drain...
colony levyfood all
colony levytax all

echo ========================================
echo INFINITE RESOURCES COMPLETE
echo Run repeatedly for maximum effect
echo ========================================
""",

    # =========================================================================
    # PACKAGE ENUMERATION - Find hidden packages
    # =========================================================================
    'package_enum': """// BORG TOOLKIT - PACKAGE ENUMERATION
// Attempts to claim packages by rule ID

setsilence off
echo ========================================
echo PACKAGE ENUMERATION
echo Trying to claim hidden packages...
echo ========================================

// Try common package IDs
getpackage 1 serial1
getpackage 2 serial2
getpackage 3 serial3
getpackage 10 serial10
getpackage 100 serial100
getpackage 1000 serial1000

echo ========================================
echo Package enumeration complete
echo ========================================
""",

    # =========================================================================
    # HERO EXPLOIT - Hero stat manipulation
    # =========================================================================
    'hero_exploit': """// BORG TOOLKIT - HERO EXPLOIT
// Attempts to manipulate hero stats

setsilence off
echo ========================================
echo HERO STAT MANIPULATION
echo ========================================

// Try adding negative experience (might give exp)
// addheroexp heroname -1000000

// Try adding massive points
// addpoint heroname attack 999999

// Refresh hero list for free
refreshheros

echo ========================================
echo Hero exploit attempts complete
echo ========================================
""",

    # =========================================================================
    # FULL AUTOMATION - Complete cheat cycle
    # =========================================================================
    'full_auto': """// BORG TOOLKIT - FULL AUTOMATION
// Complete cheat cycle - run on loop

setsilence off
echo ========================================
echo FULL AUTOMATION CYCLE
echo Press STOP to end
echo ========================================

label fullloop

// Resource generation
train a:6135037
sleep 300
cleartroopqueues
sleep 300

// Tax collection
settaxrate 100
levy tax
comfort disaster

// Colony farming
colony levyfood all
colony levytax all

// Quest completion
completequests all

echo Cycle complete - waiting 5 minutes...
sleep 300000

goto fullloop
""",

    # =========================================================================
    # EPIC HH HUNTER - Find Historic Heroes in NPC cities
    # =========================================================================
    'hh_hunter': """// BORG TOOLKIT - EPIC HH HUNTER v1.0
// Scans L10 NPCs for Historic Heroes
// Usage: includeurl http://localhost:8088/epic/hh_hunter

setsilence off
echo ==========================================
echo EPIC HH HUNTER v1.0
echo Scanning for Historic Heroes in L10 NPCs
echo ==========================================

// Configuration
set scanRadius 50
set scoutsPerBatch 3
set scoutWaitSeconds 30

// Get current city position as scan center
set centerCoord $c.castle.fieldId$
echo Scan center: %centerCoord%

// Phase 1: Get L10 NPCs in range
echo [PHASE 1] Finding L10 NPCs...
scanmap %centerCoord% %scanRadius%
sleep 2
set npcList $c.getMapFieldList(npc,10,%scanRadius%,c.castle.fieldId)$
iferror %npcList% noNPCsFound

setarr npcs "%npcList%"
echo Found %npcs.length% L10 NPCs to scout

// Phase 2: Scout each NPC
echo [PHASE 2] Scouting NPCs for HH...
set scoutIdx 0
set batchCount 0
setarr foundHH ""

label scoutLoop
if {%scoutIdx%>=%npcs.length%} goto scoutingDone

set npcCoord %npcs[{%scoutIdx%}]%
echo Scouting NPC at %npcCoord%...
scout %npcCoord% none s:1
set batchCount {%batchCount%+1}

// Process batch
if {%batchCount%>=%scoutsPerBatch%} goto processBatch
goto nextScout

label processBatch
echo Waiting %scoutWaitSeconds%s for reports...
sleep {%scoutWaitSeconds%*1000}
gosub checkReports
set batchCount 0

label nextScout
set scoutIdx {%scoutIdx%+1}
goto scoutLoop

label scoutingDone
// Final batch check
if {%batchCount%>0} gosub checkReports

// Phase 3: Results
echo ==========================================
echo HH HUNT COMPLETE
echo Scanned: %npcs.length% NPCs
echo Found HH: %foundHH.length%
echo ==========================================

if {%foundHH.length%>0} goto showFound
echo No Historic Heroes found in scanned NPCs
goto exitHunter

label showFound
echo FOUND HISTORIC HEROES:
set showIdx 0
label showLoop
if {%showIdx%>=%foundHH.length%} goto exitHunter
echo   - %foundHH[{%showIdx%}]%
set showIdx {%showIdx%+1}
goto showLoop

label noNPCsFound
echo ERROR: No L10 NPCs found in range!
echo Try increasing scanRadius or moving city

label exitHunter
echo HH Hunter finished.

// Subroutine: Check scout reports for HH
label checkReports
set rptResult $c.af.getReportCommands().receiveReportList(0,20,3)$
sleep 1
iferror $%rptResult%.reportsArray$ gosubreturn

set rptIdx 0
label rptLoop
iferror $%rptResult%.reportsArray[{%rptIdx%}]$ gosubreturn

set rptId $%rptResult%.reportsArray[{%rptIdx%}].id$
set readRpt $c.af.getReportCommands().markAsRead(%rptId%)$
sleep 0.3

iferror $%readRpt%.report.content$ goto nextRpt
set rptContent $%readRpt%.report.content$
set rptCoord $%readRpt%.report.targetPos$

// Check for isHero="1" (Historic Hero marker)
set heroCheck $c.getValue(String,%rptContent%).indexOf(isHero="1")$
if {%heroCheck%>0} goto foundHHinReport

// Check for heroName field
set nameCheck $c.getValue(String,%rptContent%).indexOf(heroName=")$
if {%nameCheck%>0} goto foundHHinReport
goto nextRpt

label foundHHinReport
echo !!! HH FOUND at %rptCoord% !!!
addtoarray foundHH %foundHH.length% %rptCoord%

label nextRpt
set rptIdx {%rptIdx%+1}
goto rptLoop
""",

    # =========================================================================
    # HH HUNTER LITE - Quick single-region scan
    # =========================================================================
    'hh_hunter_lite': """// BORG TOOLKIT - HH HUNTER LITE
// Quick scan of nearby L10 NPCs

setsilence off
echo === HH HUNTER LITE ===

// Scan 30 tiles around current city
scanmap $c.castle.fieldId$ 30
sleep 2
set npcs $c.getMapFieldList(npc,10,30,c.castle.fieldId)$
echo Found NPCs: %npcs%

// Scout first 5 NPCs
setarr targets "%npcs%"
set i 0
label quickScout
if {%i%>=5} goto quickDone
if {%i%>=%targets.length%} goto quickDone
scout %targets[{%i%}]% none s:1
echo Scouted: %targets[{%i%}]%
set i {%i%+1}
goto quickScout

label quickDone
echo Scouts sent! Check reports in 30s for HH
""",

    # =========================================================================
    # HELP - List all exploits
    # =========================================================================
    'help': """// BORG TOOLKIT - EPIC EXPLOITS
// Available at http://localhost:8088/epic/NAME
//
// HH HUNTING:
//   hh_hunter         - Full HH scanner (scans L10 NPCs for Historic Heroes)
//   hh_hunter_lite    - Quick nearby scan (5 closest NPCs)
//
// EXPLOITS:
//   overflow_chain    - Multi-troop overflow for max gain
//   resource_drain    - Extract all resources
//   race_blitz        - 50 rapid item uses
//   security_bypass   - Common security code attempts
//   army_clone        - Army duplication attempt
//   infinite_resources - Combined exploits
//   package_enum      - Hidden package discovery
//   hero_exploit      - Hero stat manipulation
//   full_auto         - Complete cheat loop
//
// RAW COMMANDS:
//   /api/CMD?param1=val1&param2=val2
//   Example: /api/troop.produceTroop?num=6135037
//
// CALCULATORS:
//   /calc/overflow?troop=6  - Calculate overflow for troop
//   /calc/signature?data=x  - Generate packet signature

echo Use includeurl http://localhost:8088/epic/NAME
""",
}

# =============================================================================
# DYNAMIC COMMAND GENERATOR
# =============================================================================

def generate_raw_command(cmd: str, params: Dict) -> str:
    """Generate AutoEvony script from raw command and params"""
    # Map command to AutoEvony script command
    cmd_map = {
        'troop.produceTroop': lambda p: f"train {get_troop_abbrev(p.get('troopType', 6))}:{p.get('num', 1000)}",
        'troop.cancelTroopProduce': lambda p: "cleartroopqueues",
        'shop.useGoods': lambda p: f"useitem {p.get('itemId', 'unknown')}",
        'common.getPackage': lambda p: f"getpackage {p.get('ruleId', 1)} {p.get('serial', 'x')}",
        'interior.taxLevy': lambda p: "levy tax",
        'interior.comforting': lambda p: f"comfort {p.get('type', 'disaster')}",
        'colony.levyResource': lambda p: f"colony levy{p.get('type', 'food')} all",
        'quest.award': lambda p: "completequests all",
    }
    
    generator = cmd_map.get(cmd)
    if generator:
        return f"""// BORG TOOLKIT - Raw Command: {cmd}
setsilence off
{generator(params)}
echo Command sent: {cmd}
"""
    else:
        return f"""// BORG TOOLKIT - Unknown command: {cmd}
// Params: {params}
echo Command not mapped to script: {cmd}
"""


def get_troop_abbrev(troop_type: int) -> str:
    """Get troop abbreviation for AutoEvony"""
    abbrevs = {1: 'wo', 2: 'wa', 3: 'sc', 4: 'pi', 5: 'sw', 6: 'a', 
               7: 'cav', 8: 'cata', 9: 'tr', 10: 'ba', 11: 'r', 12: 'c'}
    return abbrevs.get(troop_type, 'a')


def calculate_overflow(troop_type: int) -> Dict:
    """Calculate overflow values for troop type"""
    if troop_type not in TROOP_COSTS:
        return {'error': f'Unknown troop type: {troop_type}'}
    
    cost = TROOP_COSTS[troop_type]['food']
    threshold = OVERFLOW_THRESHOLDS[troop_type]
    
    return {
        'troop_type': troop_type,
        'troop_name': TROOP_COSTS[troop_type]['name'],
        'food_cost': cost,
        'overflow_threshold': threshold,
        'safe_overflow': threshold + 100,
        'expected_gain': (threshold * cost) - INT32_MAX,
        'script': f"train {get_troop_abbrev(troop_type)}:{threshold}",
    }


def generate_signature(data: str) -> str:
    """Generate packet signature using extracted keys"""
    combined = data + KEYS['ACTION_KEY']
    return hashlib.md5(combined.encode()).hexdigest()


# =============================================================================
# HTTP HANDLER
# =============================================================================

class AdvancedHandler(BaseHTTPRequestHandler):
    
    def log_message(self, format, *args):
        timestamp = datetime.now().strftime("%H:%M:%S")
        print(f"[{timestamp}] {args[0]}")
    
    def send_script(self, content: str):
        self.send_response(200)
        self.send_header("Content-Type", "text/plain")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(content.encode("utf-8"))
    
    def send_json(self, data: dict):
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(json.dumps(data, indent=2).encode("utf-8"))
    
    def do_GET(self):
        parsed = urlparse(self.path)
        path = parsed.path.strip("/").lower()
        params = {k: v[0] for k, v in parse_qs(parsed.query).items()}
        
        # Epic exploits
        if path.startswith("epic/"):
            exploit_name = path[5:]
            if exploit_name in EPIC_EXPLOITS:
                self.send_script(EPIC_EXPLOITS[exploit_name])
                print(f"    -> Served EPIC exploit: {exploit_name}")
            else:
                self.send_script(EPIC_EXPLOITS['help'])
        
        # Raw API commands
        elif path.startswith("api/"):
            cmd = path[4:]
            script = generate_raw_command(cmd, params)
            self.send_script(script)
            print(f"    -> Generated command: {cmd}")
        
        # Calculators
        elif path.startswith("calc/"):
            calc_type = path[5:]
            
            if calc_type == "overflow":
                troop = int(params.get('troop', 6))
                result = calculate_overflow(troop)
                self.send_json(result)
            
            elif calc_type == "signature":
                data = params.get('data', '')
                sig = generate_signature(data)
                self.send_json({'data': data, 'signature': sig})
            
            elif calc_type == "all_thresholds":
                self.send_json({
                    k: {'name': v['name'], 'threshold': OVERFLOW_THRESHOLDS[k]}
                    for k, v in TROOP_COSTS.items()
                })
            
            else:
                self.send_json({'error': f'Unknown calculator: {calc_type}'})
        
        # Keys
        elif path == "keys":
            self.send_json(KEYS)
        
        # Index
        elif path == "" or path == "index":
            self.send_index()
        
        # Legacy basic scripts
        elif path in EPIC_EXPLOITS:
            self.send_script(EPIC_EXPLOITS[path])
        
        else:
            self.send_response(404)
            self.end_headers()
    
    def send_index(self):
        index = """
BORG TOOLKIT - Advanced Exploit Server
======================================

EPIC EXPLOITS (use includeurl http://localhost:8088/epic/NAME):
  - overflow_chain     Multi-troop overflow chain
  - resource_drain     Extract all resources
  - race_blitz         50 rapid item uses (race condition)
  - security_bypass    Common security code attempts
  - army_clone         Army duplication attempt
  - infinite_resources Combined exploits
  - full_auto          Complete automation loop
  - help               List all exploits

RAW COMMANDS (use /api/command?params):
  - /api/troop.produceTroop?num=6135037
  - /api/shop.useGoods?itemId=player.item.x
  - /api/interior.taxLevy

CALCULATORS (JSON responses):
  - /calc/overflow?troop=6   Overflow for troop type
  - /calc/all_thresholds     All overflow thresholds
  - /calc/signature?data=x   Generate packet signature

OTHER:
  - /keys                    Encryption keys

Total commands available: 301+
"""
        self.send_response(200)
        self.send_header("Content-Type", "text/plain")
        self.end_headers()
        self.wfile.write(index.encode())


def run_server():
    print("=" * 70)
    print("BORG TOOLKIT - Advanced Exploit Server")
    print("=" * 70)
    print(f"\nListening on http://{HOST}:{PORT}")
    print("\nEPIC EXPLOITS:")
    for name in EPIC_EXPLOITS.keys():
        print(f"  http://localhost:{PORT}/epic/{name}")
    print(f"\nOverflow thresholds:")
    for tid, data in TROOP_COSTS.items():
        print(f"  {data['name']}: {OVERFLOW_THRESHOLDS[tid]:,}")
    print("\nPress Ctrl+C to stop\n")
    print("-" * 70)
    
    server = HTTPServer((HOST, PORT), AdvancedHandler)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nServer stopped.")
        server.shutdown()


if __name__ == "__main__":
    run_server()
