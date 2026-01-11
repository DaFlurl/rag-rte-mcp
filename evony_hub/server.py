#!/usr/bin/env python3
# Evony Hub - Integrated Script Server
"""
Merged script server combining BorgToolkit's advanced_server with evony_hub.
Single server for all AutoEvony scripting needs.

Usage:
    python -m evony_hub.server
    
In AutoEvony:
    includeurl http://localhost:8088/epic/overflow_chain
"""

from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse, parse_qs
import json
import hashlib
import sys
from pathlib import Path
from datetime import datetime
from typing import Dict

# Add parent paths
sys.path.insert(0, str(Path(__file__).parent.parent))

PORT = 8088
HOST = "0.0.0.0"

# =============================================================================
# ENCRYPTION KEYS (from BorgToolkit)
# =============================================================================
ENCRYPTION_KEYS = {
    'ACTION_KEY': "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}",
    'API_KEY': "9f758e2deccbe6244f734371b9642eda",
    'USER_INFO_KEY': "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}",
    'XOR_KEY': 0xAA,
    'LOGIN_SALT': "evony",
}

# =============================================================================
# OVERFLOW THRESHOLDS
# =============================================================================
INT32_MAX = 2147483647

TROOP_DATA = {
    1: {'name': 'Worker', 'abbrev': 'wo', 'cost': 50},
    2: {'name': 'Warrior', 'abbrev': 'wa', 'cost': 75},
    3: {'name': 'Scout', 'abbrev': 'sc', 'cost': 100},
    4: {'name': 'Pikeman', 'abbrev': 'pi', 'cost': 200},
    5: {'name': 'Swordsman', 'abbrev': 'sw', 'cost': 250},
    6: {'name': 'Archer', 'abbrev': 'a', 'cost': 350},
    7: {'name': 'Cavalry', 'abbrev': 'cav', 'cost': 800},
    8: {'name': 'Cataphract', 'abbrev': 'cata', 'cost': 1500},
    9: {'name': 'Transporter', 'abbrev': 'tr', 'cost': 300},
    10: {'name': 'Ballista', 'abbrev': 'ba', 'cost': 2000},
    11: {'name': 'Ram', 'abbrev': 'r', 'cost': 2500},
    12: {'name': 'Catapult', 'abbrev': 'c', 'cost': 3000},
}

def calc_threshold(cost: int) -> int:
    return (INT32_MAX // cost) + 1

THRESHOLDS = {tid: calc_threshold(d['cost']) for tid, d in TROOP_DATA.items()}

# =============================================================================
# EXPLOIT SCRIPTS
# =============================================================================

def generate_overflow_chain() -> str:
    """Generate complete overflow chain for all troops."""
    lines = [
        "// EVONY HUB - Ultimate Overflow Chain",
        "// All 12 troop types in sequence",
        "",
        "setsilence off",
        "echo ========================================",
        "echo ULTIMATE OVERFLOW CHAIN",
        "echo ========================================",
        "",
    ]
    
    for tid, data in TROOP_DATA.items():
        threshold = THRESHOLDS[tid]
        lines.extend([
            f"// {data['name']} overflow",
            f"echo [{tid}/12] {data['name']}...",
            f"train {data['abbrev']}:{threshold}",
            "sleep 300",
            "cleartroopqueues",
            "sleep 300",
            "",
        ])
    
    lines.extend([
        "echo ========================================",
        "echo OVERFLOW CHAIN COMPLETE",
        "echo ========================================",
    ])
    
    return "\n".join(lines)


SCRIPTS = {
    "overflow_chain": generate_overflow_chain(),
    
    "overflow": """// EVONY HUB - Archer Overflow
setsilence off
echo Starting Archer Overflow...
train a:6135037
sleep 500
cleartroopqueues
echo Overflow complete!
""",

    "infinite_resources": """// EVONY HUB - Infinite Resources
setsilence off
echo ========================================
echo INFINITE RESOURCES EXPLOIT
echo ========================================

// Phase 1: Valley hide
echo [1] Hiding troops...
reinforce 500,500 any all none
sleep 1000

// Phase 2: Overflow
echo [2] Running overflow...
train a:6135037
sleep 500
cleartroopqueues
sleep 500

// Phase 3: Tax collection
echo [3] Collecting taxes...
set i 0
label taxloop
settaxrate 100
levy tax
comfort disaster
set i i+1
if i < 5 goto taxloop

// Phase 4: Colony farming
echo [4] Farming colonies...
colony levyfood all
colony levytax all

// Phase 5: Quest completion
echo [5] Completing quests...
completequests all

echo ========================================
echo INFINITE RESOURCES COMPLETE
echo ========================================
""",

    "race_blitz": """// EVONY HUB - Race Condition Blitz
// 100 rapid item uses with NO delays
setsilence off
echo ========================================
echo RACE CONDITION BLITZ - 100 USES
echo ========================================

set item player.item.speed.1hr
""" + "\n".join(["useitem $item"] * 100) + """

echo ========================================
echo 100 USES FIRED
echo ========================================
""",

    "full_auto": """// EVONY HUB - Full Automation Loop
setsilence off
echo ========================================
echo FULL AUTOMATION - INFINITE LOOP
echo Press STOP to end
echo ========================================

label autoloop

// Overflow exploit
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

echo Cycle complete - waiting 5 min...
sleep 300000
goto autoloop
""",

    "valley_hide": """// EVONY HUB - Valley Troop Hiding
setsilence off
echo Hiding all troops in valley...
reinforce 500,500 any all none
echo Troops hidden! No food consumption.
echo Use 'recall 500,500' to bring back.
""",

    "gold_farm": """// EVONY HUB - Gold Farming Loop
setsilence off
echo Starting Gold Farm...

label goldloop
settaxrate 100
levy tax
comfort disaster
sleep 300000
goto goldloop
""",

    "help": """// EVONY HUB - Available Scripts
// Use: includeurl http://localhost:8088/SCRIPT_NAME
//
// EPIC EXPLOITS:
//   overflow_chain    - All 12 troop overflows
//   infinite_resources - Combined multi-exploit
//   race_blitz        - 100 rapid item uses
//   full_auto         - Infinite automation loop
//
// BASIC EXPLOITS:
//   overflow          - Single archer overflow
//   valley_hide       - Hide troops in valley
//   gold_farm         - Automated tax collection
//
// API:
//   /calc/overflow?troop=6  - Calculate overflow
//   /keys                   - Show encryption keys

echo Visit http://localhost:8088/ for full list
""",
}


class EvonyHubHandler(BaseHTTPRequestHandler):
    """HTTP handler for script server."""
    
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
            script_name = path[5:]
            if script_name in SCRIPTS:
                self.send_script(SCRIPTS[script_name])
                print(f"    -> Served: {script_name}")
            else:
                self.send_script(SCRIPTS['help'])
        
        # Direct script names
        elif path in SCRIPTS:
            self.send_script(SCRIPTS[path])
            print(f"    -> Served: {path}")
        
        # Calculators
        elif path.startswith("calc/"):
            calc_type = path[5:]
            
            if calc_type == "overflow":
                troop = int(params.get('troop', 6))
                if troop in TROOP_DATA:
                    data = TROOP_DATA[troop]
                    threshold = THRESHOLDS[troop]
                    self.send_json({
                        'troop_type': troop,
                        'name': data['name'],
                        'cost': data['cost'],
                        'threshold': threshold,
                        'script': f"train {data['abbrev']}:{threshold}",
                    })
                else:
                    self.send_json({'error': f'Unknown troop: {troop}'})
            
            elif calc_type == "all":
                self.send_json({
                    tid: {
                        'name': d['name'],
                        'threshold': THRESHOLDS[tid],
                        'script': f"train {d['abbrev']}:{THRESHOLDS[tid]}"
                    }
                    for tid, d in TROOP_DATA.items()
                })
            
            else:
                self.send_json({'error': f'Unknown calc: {calc_type}'})
        
        # Keys
        elif path == "keys":
            self.send_json(ENCRYPTION_KEYS)
        
        # Index
        elif path == "" or path == "index":
            self.send_index()
        
        else:
            self.send_response(404)
            self.end_headers()
    
    def send_index(self):
        index = f"""
EVONY HUB - Integrated Script Server
=====================================

EPIC EXPLOITS:
  http://localhost:{PORT}/epic/overflow_chain    - All 12 troop overflows
  http://localhost:{PORT}/epic/infinite_resources - Combined exploits
  http://localhost:{PORT}/epic/race_blitz         - 100 rapid item uses
  http://localhost:{PORT}/epic/full_auto          - Infinite automation
  http://localhost:{PORT}/epic/valley_hide        - Hide troops
  http://localhost:{PORT}/epic/gold_farm          - Tax farming loop
  http://localhost:{PORT}/epic/help               - Show all scripts

CALCULATORS:
  http://localhost:{PORT}/calc/overflow?troop=6   - Overflow for troop
  http://localhost:{PORT}/calc/all                - All thresholds

OTHER:
  http://localhost:{PORT}/keys                    - Encryption keys

AutoEvony Usage:
  includeurl http://localhost:{PORT}/epic/overflow_chain
"""
        self.send_response(200)
        self.send_header("Content-Type", "text/plain")
        self.end_headers()
        self.wfile.write(index.encode())


def run_server(port: int = PORT):
    """Start the integrated script server."""
    print("=" * 70)
    print("EVONY HUB - Integrated Script Server")
    print("=" * 70)
    print(f"\nListening on http://{HOST}:{port}")
    print(f"\nAutoEvony Usage:")
    print(f"  includeurl http://localhost:{port}/epic/overflow_chain")
    print(f"  includeurl http://localhost:{port}/epic/infinite_resources")
    print(f"\nAvailable scripts: {', '.join(SCRIPTS.keys())}")
    print(f"\nOverflow thresholds:")
    for tid, data in TROOP_DATA.items():
        print(f"  {data['name']:12}: {THRESHOLDS[tid]:>10,}")
    print("\nPress Ctrl+C to stop\n")
    print("-" * 70)
    
    server = HTTPServer((HOST, port), EvonyHubHandler)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nServer stopped.")
        server.shutdown()


if __name__ == "__main__":
    run_server()
