#!/usr/bin/env python3
"""
Bot Server Guardian - Auto-restart with failsafes
Keeps the bot server running, auto-restarts on crash/close.
Can be stopped by user via stop file or API call.
"""

import subprocess
import time
import os
import sys
import signal
import requests
import threading
import json
from pathlib import Path
from datetime import datetime

# Configuration
BOT_SERVER_PATH = Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\evony_bot")
BOT_SERVER_SCRIPT = "server.py"
BOT_SERVER_PORT = 9999
BOT_SERVER_URL = f"http://localhost:{BOT_SERVER_PORT}"
PYTHON_EXE = r"C:\Python313\python.exe"

# Control files
GUARDIAN_DIR = Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\scripts")
STOP_FILE = GUARDIAN_DIR / "bot_guardian_stop.flag"
STATUS_FILE = GUARDIAN_DIR / "bot_guardian_status.json"
LOG_FILE = GUARDIAN_DIR / "bot_guardian.log"

# Timing
CHECK_INTERVAL = 5  # seconds between health checks
RESTART_DELAY = 3   # seconds to wait before restart
MAX_RESTARTS = 10   # max restarts before giving up
RESTART_WINDOW = 300  # reset restart count after this many seconds

# Global state
_process = None
_restart_count = 0
_last_restart_time = 0
_running = True


def log(message: str):
    """Log message to file and console."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_entry = f"[{timestamp}] {message}"
    print(log_entry)
    
    try:
        with open(LOG_FILE, 'a', encoding='utf-8') as f:
            f.write(log_entry + "\n")
    except:
        pass


def update_status(status: dict):
    """Update status file for external monitoring."""
    status['timestamp'] = datetime.now().isoformat()
    status['pid'] = _process.pid if _process else None
    
    try:
        with open(STATUS_FILE, 'w', encoding='utf-8') as f:
            json.dump(status, f, indent=2)
    except:
        pass


def is_bot_server_running() -> bool:
    """Check if bot server is responding."""
    try:
        response = requests.get(f"{BOT_SERVER_URL}/api/status", timeout=3)
        return response.status_code == 200
    except:
        return False


def is_process_alive() -> bool:
    """Check if the subprocess is still running."""
    global _process
    if _process is None:
        return False
    return _process.poll() is None


def start_bot_server() -> bool:
    """Start the bot server process."""
    global _process, _restart_count, _last_restart_time
    
    # Check restart limits
    current_time = time.time()
    if current_time - _last_restart_time > RESTART_WINDOW:
        _restart_count = 0  # Reset counter
    
    if _restart_count >= MAX_RESTARTS:
        log(f"ERROR: Max restarts ({MAX_RESTARTS}) exceeded. Stopping guardian.")
        return False
    
    # Kill any existing process
    if _process and is_process_alive():
        log("Killing existing process...")
        _process.terminate()
        time.sleep(1)
        if is_process_alive():
            _process.kill()
    
    # Start new process
    log(f"Starting bot server (attempt {_restart_count + 1})...")
    
    try:
        _process = subprocess.Popen(
            [PYTHON_EXE, BOT_SERVER_SCRIPT],
            cwd=str(BOT_SERVER_PATH),
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            creationflags=subprocess.CREATE_NEW_PROCESS_GROUP if os.name == 'nt' else 0
        )
        
        _restart_count += 1
        _last_restart_time = current_time
        
        # Wait for server to start
        time.sleep(RESTART_DELAY)
        
        if is_bot_server_running():
            log(f"Bot server started successfully (PID: {_process.pid})")
            update_status({"status": "running", "restarts": _restart_count})
            return True
        else:
            log("Bot server started but not responding")
            return False
            
    except Exception as e:
        log(f"ERROR starting bot server: {e}")
        return False


def should_stop() -> bool:
    """Check if guardian should stop."""
    # Check stop file
    if STOP_FILE.exists():
        log("Stop file detected. Shutting down...")
        return True
    
    # Check global flag
    return not _running


def cleanup():
    """Cleanup on exit."""
    global _process
    
    log("Guardian shutting down...")
    
    # Kill bot server if running
    if _process and is_process_alive():
        log("Stopping bot server...")
        _process.terminate()
        time.sleep(2)
        if is_process_alive():
            _process.kill()
    
    # Update status
    update_status({"status": "stopped", "restarts": _restart_count})
    
    # Remove stop file
    if STOP_FILE.exists():
        STOP_FILE.unlink()
    
    log("Guardian stopped.")


def signal_handler(signum, frame):
    """Handle shutdown signals."""
    global _running
    _running = False


def guardian_loop():
    """Main guardian loop - monitors and restarts bot server."""
    global _running
    
    log("=" * 50)
    log("BOT SERVER GUARDIAN STARTED")
    log("=" * 50)
    log(f"Bot server path: {BOT_SERVER_PATH}")
    log(f"Check interval: {CHECK_INTERVAL}s")
    log(f"Stop file: {STOP_FILE}")
    log("")
    
    # Remove old stop file if exists
    if STOP_FILE.exists():
        STOP_FILE.unlink()
    
    # Initial start
    if not start_bot_server():
        log("ERROR: Initial start failed")
        return
    
    # Main loop
    while not should_stop():
        time.sleep(CHECK_INTERVAL)
        
        # Check if server is responding
        if not is_bot_server_running():
            log("Bot server not responding!")
            
            # Check if process died
            if not is_process_alive():
                log("Process died. Restarting...")
            else:
                log("Process alive but not responding. Restarting...")
            
            if not start_bot_server():
                log("ERROR: Restart failed")
                if _restart_count >= MAX_RESTARTS:
                    break
        else:
            # Reset restart count on successful health check
            if _restart_count > 0 and time.time() - _last_restart_time > RESTART_WINDOW:
                _restart_count = 0
                update_status({"status": "running", "restarts": 0})
    
    cleanup()


def stop_guardian():
    """Create stop file to signal guardian to stop."""
    STOP_FILE.touch()
    print(f"Stop signal sent. Guardian will stop shortly.")


def get_status() -> dict:
    """Get current guardian status."""
    if STATUS_FILE.exists():
        try:
            with open(STATUS_FILE, 'r') as f:
                return json.load(f)
        except:
            pass
    return {"status": "unknown"}


# ============================================================
# MCP Integration - Auto-start on access
# ============================================================

def ensure_bot_server_running() -> dict:
    """
    Ensure bot server is running - call this from MCP handlers.
    Returns status dict with server info.
    """
    if is_bot_server_running():
        return {
            "running": True,
            "message": "Bot server is running",
            "url": BOT_SERVER_URL
        }
    
    # Try to start it
    log("Bot server not running. Starting...")
    
    # Check if guardian is running
    status = get_status()
    if status.get("status") == "running":
        # Guardian is running, wait for it to restart
        for _ in range(10):
            time.sleep(1)
            if is_bot_server_running():
                return {
                    "running": True,
                    "message": "Bot server restarted by guardian",
                    "url": BOT_SERVER_URL
                }
        return {
            "running": False,
            "error": "Guardian running but bot server not responding"
        }
    
    # No guardian, start server directly
    try:
        subprocess.Popen(
            [PYTHON_EXE, BOT_SERVER_SCRIPT],
            cwd=str(BOT_SERVER_PATH),
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            creationflags=subprocess.CREATE_NEW_PROCESS_GROUP if os.name == 'nt' else 0
        )
        
        # Wait for startup
        for _ in range(10):
            time.sleep(1)
            if is_bot_server_running():
                return {
                    "running": True,
                    "message": "Bot server started on-demand",
                    "url": BOT_SERVER_URL
                }
        
        return {
            "running": False,
            "error": "Bot server started but not responding"
        }
        
    except Exception as e:
        return {
            "running": False,
            "error": f"Failed to start bot server: {e}"
        }


if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="Bot Server Guardian")
    parser.add_argument("--stop", action="store_true", help="Stop the guardian")
    parser.add_argument("--status", action="store_true", help="Show status")
    parser.add_argument("--start-server", action="store_true", help="Start server once (no guardian)")
    args = parser.parse_args()
    
    if args.stop:
        stop_guardian()
    elif args.status:
        status = get_status()
        print(json.dumps(status, indent=2))
    elif args.start_server:
        result = ensure_bot_server_running()
        print(json.dumps(result, indent=2))
    else:
        # Setup signal handlers
        signal.signal(signal.SIGINT, signal_handler)
        signal.signal(signal.SIGTERM, signal_handler)
        
        # Run guardian
        guardian_loop()
