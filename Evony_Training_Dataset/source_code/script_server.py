#!/usr/bin/env python3
"""
BORG TOOLKIT - External Script Server for AutoEvony

AutoEvony can load scripts via 'includeurl http://server/script.txt'
This server provides exploit scripts on demand.

Usage in AutoEvony:
    includeurl http://localhost:8088/overflow
    includeurl http://localhost:8088/valley_hide
    includeurl http://localhost:8088/gold_farm

Start server:
    python script_server.py
"""

from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse, parse_qs
import json
from datetime import datetime

PORT = 8088
HOST = "0.0.0.0"  # Listen on all interfaces


# =============================================================================
# EXPLOIT SCRIPTS - Served to AutoEvony on request
# =============================================================================

SCRIPTS = {
    "overflow": """// BORG TOOLKIT - Troop Overflow Exploit
// Loaded via: includeurl http://localhost:8088/overflow
setsilence off
echo ========================================
echo TROOP OVERFLOW EXPLOIT - FOOD GLITCH
echo ========================================

// Queue archers above overflow threshold
train a:6135037

// Wait for server
sleep 1000

// Cancel to trigger negative refund = resource GAIN
cleartroopqueues

echo ========================================
echo EXPLOIT COMPLETE - Check resources!
echo ========================================
""",

    "valley_hide": """// BORG TOOLKIT - Valley Troop Hiding
// Troops in valleys don't consume food!
setsilence off
echo ========================================
echo VALLEY TROOP HIDING
echo Troops sent to valleys don't eat food
echo ========================================

// Send all troops to distant valley
// Change coords as needed
reinforce 500,500 any all none

echo Troops hidden! No more food consumption
echo Use 'recall 500,500' to bring them back
""",

    "gold_farm": """// BORG TOOLKIT - Gold Farming Loop
setsilence off
echo Starting Gold Farm Loop...

label goldloop
settaxrate 100
sleep 500
levy tax
comfort disaster
echo Gold collected! Waiting 5 min...
sleep 300000
goto goldloop
""",

    "item_dupe": """// BORG TOOLKIT - Item Race Condition
// Rapid use attempts race condition dupe
setsilence off
echo ========================================
echo ITEM RAPID USE - Race Condition
echo ========================================

// Change itemId to your target
set itemId player.item.speed.1hr

// Fire 10 rapid uses
useitem $itemId
useitem $itemId
useitem $itemId
useitem $itemId
useitem $itemId
useitem $itemId
useitem $itemId
useitem $itemId
useitem $itemId
useitem $itemId

echo 10 rapid uses sent!
""",

    "auto_quest": """// BORG TOOLKIT - Auto Quest
setsilence off
echo Completing all quests...
completequests all
echo All quests completed!
""",

    "amulet_spin": """// BORG TOOLKIT - Amulet Spinner
setsilence off
echo ========================================
echo AMULET SPINNER
echo ========================================

set i 0
label spinloop
useitem player.box.gambling.3
sleep 500
set i i+1
if i < 10 goto spinloop

echo 10 spins complete!
""",

    "transport_loop": """// BORG TOOLKIT - Transport Resources Loop
// Edit target coords and amounts
setsilence off

set target 500,500
label transloop
transport $target t:100000 f:1000000000
sleep 60000
goto transloop
""",

    "colony_farm": """// BORG TOOLKIT - Colony Farming
// Edit colony coords
setsilence off

set colony 123,456
label colonyloop
colony levyfood $colony
sleep 500
colony levytax $colony
sleep 500
colony levyarmy $colony
echo Colony levied!
sleep 300000
goto colonyloop
""",

    "help": """// BORG TOOLKIT - Available Scripts
// Use: includeurl http://localhost:8088/SCRIPT_NAME
//
// EXPLOITS:
//   overflow     - Troop overflow food glitch
//   valley_hide  - Hide troops to stop food consumption
//   item_dupe    - Race condition item duplication
//
// AUTOMATION:
//   gold_farm    - Automated tax collection loop
//   auto_quest   - Complete all quests
//   amulet_spin  - Rapid amulet gambling
//   colony_farm  - Colony resource levying
//   transport_loop - Resource transport loop
//
// Example:
//   includeurl http://localhost:8088/overflow

echo Use 'includeurl http://localhost:8088/SCRIPT_NAME' to load scripts
echo Available: overflow, valley_hide, item_dupe, gold_farm, auto_quest
""",
}


class BorgScriptHandler(BaseHTTPRequestHandler):
    """HTTP handler that serves scripts to AutoEvony"""
    
    def log_message(self, format, *args):
        """Custom logging"""
        timestamp = datetime.now().strftime("%H:%M:%S")
        print(f"[{timestamp}] {args[0]}")
    
    def do_GET(self):
        """Handle GET requests from AutoEvony"""
        parsed = urlparse(self.path)
        script_name = parsed.path.strip("/").lower()
        
        # Parse query params for dynamic scripts
        params = parse_qs(parsed.query)
        
        if script_name in SCRIPTS:
            script_content = SCRIPTS[script_name]
            
            # Dynamic parameter substitution
            for key, values in params.items():
                script_content = script_content.replace(f"${{{key}}}", values[0])
            
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.send_header("Access-Control-Allow-Origin", "*")
            self.end_headers()
            self.wfile.write(script_content.encode("utf-8"))
            
            print(f"    -> Served script: {script_name}")
        
        elif script_name == "" or script_name == "index":
            # List available scripts
            response = "BORG TOOLKIT Script Server\n\n"
            response += "Available scripts:\n"
            for name in SCRIPTS.keys():
                response += f"  - http://localhost:{PORT}/{name}\n"
            
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.end_headers()
            self.wfile.write(response.encode("utf-8"))
        
        else:
            self.send_response(404)
            self.send_header("Content-Type", "text/plain")
            self.end_headers()
            self.wfile.write(f"Script not found: {script_name}\n".encode("utf-8"))
    
    def do_POST(self):
        """Handle POST requests (for receiving data from bot)"""
        content_length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(content_length).decode("utf-8")
        
        print(f"    <- Received data: {body[:100]}...")
        
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(json.dumps({"status": "ok"}).encode("utf-8"))


def run_server():
    """Start the script server"""
    print("=" * 60)
    print("BORG TOOLKIT - External Script Server")
    print("=" * 60)
    print(f"\nListening on http://{HOST}:{PORT}")
    print("\nIn AutoEvony, use:")
    print(f"  includeurl http://localhost:{PORT}/overflow")
    print(f"  includeurl http://localhost:{PORT}/valley_hide")
    print(f"  includeurl http://localhost:{PORT}/help")
    print("\nAvailable scripts:")
    for name in SCRIPTS.keys():
        print(f"  - {name}")
    print("\nPress Ctrl+C to stop\n")
    print("-" * 60)
    
    server = HTTPServer((HOST, PORT), BorgScriptHandler)
    
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nServer stopped.")
        server.shutdown()


if __name__ == "__main__":
    run_server()
