#!/usr/bin/env python3
"""
AutoEvony Integration - Bridge between AutoEvony bot and Web Browser
=====================================================================

This module provides the integration layer between:
- AutoEvony2.swf (bot client)
- FlashBrowser (web browser with Flash)
- Evony game servers
- Master Suite exploit framework

Based on the screenshot showing both running together, this module enables:
1. Script execution in AutoEvony
2. Browser automation for game client
3. Data synchronization between bot and game
4. Exploit chaining across both interfaces
"""

import os
import sys
import json
import socket
import threading
import time
from pathlib import Path
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse, parse_qs

# =============================================================================
# CONFIGURATION
# =============================================================================

# Default ports
SCRIPT_SERVER_PORT = 8088  # For AutoEvony includeurl
CONTROL_SERVER_PORT = 8089  # For control commands

# Paths
BASE_DIR = Path(__file__).parent.parent

# AutoEvony script loading endpoints
SCRIPT_ENDPOINTS = {
    '/overflow_chain': 'overflow_chain',
    '/race_blitz': 'race_blitz',
    '/valley_hide': 'valley_hide',
    '/full_auto': 'full_auto',
    '/security_bypass': 'security_bypass',
    '/custom': 'custom',
}

# =============================================================================
# SCRIPT TEMPLATES
# =============================================================================

SCRIPTS = {
    'overflow_chain': """// AUTOEVONY INTEGRATION - Overflow Chain
// Load via: includeurl http://localhost:8088/overflow_chain
setsilence off
echo ========================================
echo OVERFLOW CHAIN - ALL TROOPS
echo ========================================

// Phase 1: Archers
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
echo Expected: ~8.4B food gain
echo ========================================
""",

    'race_blitz': """// AUTOEVONY INTEGRATION - Race Condition Blitz
// Load via: includeurl http://localhost:8088/race_blitz
setsilence off
echo ========================================
echo RACE CONDITION BLITZ
echo 50 rapid item uses
echo ========================================

set item player.item.speed.1hr
""" + "\n".join(["useitem $item"] * 50) + """

echo ========================================
echo 50 USES FIRED
echo ========================================
""",

    'valley_hide': """// AUTOEVONY INTEGRATION - Valley Troop Hide
// Load via: includeurl http://localhost:8088/valley_hide
setsilence off
echo ========================================
echo VALLEY TROOP HIDING
echo ========================================

// Hide all troops in valley
reinforce 500,500 any all none

echo ========================================
echo Troops sent to valley
echo Food consumption reduced
echo ========================================
""",

    'full_auto': """// AUTOEVONY INTEGRATION - Full Automation
// Load via: includeurl http://localhost:8088/full_auto
setsilence off
echo ========================================
echo FULL AUTOMATION LOOP
echo Press STOP to end
echo ========================================

label mainloop

// Overflow exploit
train a:6135037
sleep 500
cleartroopqueues
sleep 500

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

goto mainloop
""",

    'security_bypass': """// AUTOEVONY INTEGRATION - Security Bypass
// Load via: includeurl http://localhost:8088/security_bypass
setsilence off
echo ========================================
echo SECURITY CODE ENUMERATION
echo ========================================

authsecurity 0000
authsecurity 1111
authsecurity 1234
authsecurity 4321
authsecurity 9999
authsecurity 0123
authsecurity 1212
authsecurity 2580

echo ========================================
echo Enumeration complete
echo ========================================
""",

    'custom': """// AUTOEVONY INTEGRATION - Custom Script
// Add your custom commands here
echo Ready for custom commands
""",
}


# =============================================================================
# SCRIPT SERVER
# =============================================================================

class ScriptServerHandler(BaseHTTPRequestHandler):
    """HTTP handler for AutoEvony script requests"""
    
    custom_script = ""  # Class variable for custom scripts
    
    def log_message(self, format, *args):
        from datetime import datetime
        timestamp = datetime.now().strftime("%H:%M:%S")
        print(f"[SCRIPT {timestamp}] {args[0]}")
    
    def do_GET(self):
        parsed = urlparse(self.path)
        path = parsed.path.lower()
        
        # Check for script endpoint
        if path in SCRIPT_ENDPOINTS:
            script_name = SCRIPT_ENDPOINTS[path]
            
            if script_name == 'custom' and ScriptServerHandler.custom_script:
                content = ScriptServerHandler.custom_script
            else:
                content = SCRIPTS.get(script_name, f"// Unknown script: {script_name}")
            
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.send_header("Access-Control-Allow-Origin", "*")
            self.end_headers()
            self.wfile.write(content.encode("utf-8"))
            print(f"    -> Served script: {script_name}")
        
        elif path == "/":
            # Index page
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.end_headers()
            
            index = """AutoEvony Integration Server
=============================

Available scripts (use includeurl http://localhost:8088/PATH):

  /overflow_chain   - Multi-troop overflow exploit
  /race_blitz       - 50 rapid item uses
  /valley_hide      - Hide troops in valleys
  /full_auto        - Complete automation loop
  /security_bypass  - Security code enumeration
  /custom           - Custom script (set via API)

Control API (http://localhost:8089):
  /set_custom       - Set custom script content
  /status           - Server status
"""
            self.wfile.write(index.encode())
        
        else:
            self.send_response(404)
            self.end_headers()


# =============================================================================
# CONTROL SERVER
# =============================================================================

class ControlServerHandler(BaseHTTPRequestHandler):
    """HTTP handler for control commands"""
    
    def log_message(self, format, *args):
        from datetime import datetime
        timestamp = datetime.now().strftime("%H:%M:%S")
        print(f"[CTRL {timestamp}] {args[0]}")
    
    def do_GET(self):
        parsed = urlparse(self.path)
        path = parsed.path.lower()
        
        if path == "/status":
            self.send_json({"status": "running", "custom_script_set": bool(ScriptServerHandler.custom_script)})
        
        elif path == "/scripts":
            self.send_json(list(SCRIPTS.keys()))
        
        else:
            self.send_json({"error": "Unknown endpoint"}, 404)
    
    def do_POST(self):
        parsed = urlparse(self.path)
        path = parsed.path.lower()
        
        if path == "/set_custom":
            content_length = int(self.headers.get('Content-Length', 0))
            body = self.rfile.read(content_length).decode('utf-8')
            ScriptServerHandler.custom_script = body
            self.send_json({"status": "ok", "length": len(body)})
        
        else:
            self.send_json({"error": "Unknown endpoint"}, 404)
    
    def send_json(self, data, status=200):
        self.send_response(status)
        self.send_header("Content-Type", "application/json")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(json.dumps(data).encode())


# =============================================================================
# SERVER MANAGER
# =============================================================================

class IntegrationServer:
    """Manage both script and control servers"""
    
    def __init__(self):
        self.script_server = None
        self.control_server = None
        self.running = False
    
    def start(self):
        """Start both servers"""
        self.running = True
        
        # Start script server
        self.script_server = HTTPServer(("0.0.0.0", SCRIPT_SERVER_PORT), ScriptServerHandler)
        script_thread = threading.Thread(target=self.script_server.serve_forever)
        script_thread.daemon = True
        script_thread.start()
        
        # Start control server
        self.control_server = HTTPServer(("0.0.0.0", CONTROL_SERVER_PORT), ControlServerHandler)
        control_thread = threading.Thread(target=self.control_server.serve_forever)
        control_thread.daemon = True
        control_thread.start()
        
        print(f"Script server running on port {SCRIPT_SERVER_PORT}")
        print(f"Control server running on port {CONTROL_SERVER_PORT}")
    
    def stop(self):
        """Stop both servers"""
        self.running = False
        if self.script_server:
            self.script_server.shutdown()
        if self.control_server:
            self.control_server.shutdown()


# =============================================================================
# MAIN
# =============================================================================

def main():
    print("=" * 60)
    print("  AutoEvony Integration Server")
    print("  Bridge between AutoEvony bot and Web Browser")
    print("=" * 60)
    print()
    print("Script Server (for AutoEvony includeurl):")
    print(f"  http://localhost:{SCRIPT_SERVER_PORT}/")
    print()
    print("Available scripts:")
    for endpoint, name in SCRIPT_ENDPOINTS.items():
        print(f"  http://localhost:{SCRIPT_SERVER_PORT}{endpoint}")
    print()
    print("In AutoEvony, use:")
    print(f"  includeurl http://localhost:{SCRIPT_SERVER_PORT}/overflow_chain")
    print()
    print("-" * 60)
    print("Press Ctrl+C to stop")
    print("-" * 60)
    
    server = IntegrationServer()
    server.start()
    
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print("\nShutting down...")
        server.stop()


if __name__ == "__main__":
    main()
