#!/usr/bin/env python3
"""
Browser Controller - FlashBrowser Integration
==============================================

Control FlashBrowser via automation for:
- Opening game URLs
- Injecting scripts
- Capturing traffic
- Screenshot automation
"""

import subprocess
import os
import time
import json
from pathlib import Path

# FlashBrowser path
FLASH_BROWSER_PATH = Path(__file__).parent.parent / "FlashBrowser" / "FlashBrowser.exe"
AUTOEVONY_PATH = Path(__file__).parent.parent / "Tools" / "ruffle" / "ruffle.exe"

# Game URLs
EVONY_URLS = {
    'cc2': 'http://cc2.evony.com/s.html',
    'cc1': 'http://cc1.evony.com/s.html',
    'ss70': 'http://ss70.evony.com/s.html',
    'na81': 'http://na81.evony.com/s.html',
}


class BrowserController:
    """Control FlashBrowser for Evony automation"""
    
    def __init__(self):
        self.process = None
        self.flash_browser_path = FLASH_BROWSER_PATH
    
    def is_running(self):
        """Check if FlashBrowser is running"""
        return self.process is not None and self.process.poll() is None
    
    def start(self, url=None):
        """Start FlashBrowser"""
        if not self.flash_browser_path.exists():
            print(f"[ERROR] FlashBrowser not found at: {self.flash_browser_path}")
            return False
        
        args = [str(self.flash_browser_path)]
        if url:
            args.append(url)
        
        try:
            self.process = subprocess.Popen(args)
            print(f"[OK] FlashBrowser started (PID: {self.process.pid})")
            return True
        except Exception as e:
            print(f"[ERROR] Failed to start FlashBrowser: {e}")
            return False
    
    def stop(self):
        """Stop FlashBrowser"""
        if self.process:
            self.process.terminate()
            self.process = None
            print("[OK] FlashBrowser stopped")
    
    def open_server(self, server_key):
        """Open a specific Evony server"""
        url = EVONY_URLS.get(server_key)
        if url:
            return self.start(url)
        else:
            print(f"[ERROR] Unknown server: {server_key}")
            print(f"Available servers: {list(EVONY_URLS.keys())}")
            return False


class AutoEvonyController:
    """Control AutoEvony SWF with Ruffle"""
    
    def __init__(self, swf_path=None):
        self.swf_path = swf_path
        self.process = None
    
    def start(self):
        """Start AutoEvony in Ruffle"""
        ruffle_path = Path(__file__).parent.parent / "Tools" / "ruffle" / "ruffle.exe"
        
        if not ruffle_path.exists():
            print(f"[ERROR] Ruffle not found at: {ruffle_path}")
            return False
        
        if not self.swf_path or not Path(self.swf_path).exists():
            print("[ERROR] SWF file not specified or not found")
            return False
        
        try:
            self.process = subprocess.Popen([str(ruffle_path), self.swf_path])
            print(f"[OK] AutoEvony started (PID: {self.process.pid})")
            return True
        except Exception as e:
            print(f"[ERROR] Failed to start AutoEvony: {e}")
            return False


def find_flash_player():
    """Find Adobe Flash Player installation"""
    possible_paths = [
        r"C:\Windows\SysWOW64\Macromed\Flash\FlashPlayerStandalone.exe",
        r"C:\Windows\System32\Macromed\Flash\FlashPlayerStandalone.exe",
        os.path.expanduser(r"~\AppData\Local\Adobe\FlashPlayer\FlashPlayer.exe"),
    ]
    
    for path in possible_paths:
        if os.path.exists(path):
            return path
    return None


def list_tools():
    """List available automation tools"""
    tools_dir = Path(__file__).parent.parent / "Tools"
    
    print("\nAvailable Tools:")
    print("-" * 40)
    
    if tools_dir.exists():
        for item in tools_dir.iterdir():
            if item.is_dir():
                print(f"  📁 {item.name}")
    
    print("\nBrowsers:")
    print("-" * 40)
    
    if FLASH_BROWSER_PATH.exists():
        print(f"  ✅ FlashBrowser: {FLASH_BROWSER_PATH}")
    else:
        print(f"  ❌ FlashBrowser: Not found")
    
    flash_player = find_flash_player()
    if flash_player:
        print(f"  ✅ Flash Player: {flash_player}")
    else:
        print(f"  ❌ Flash Player: Not found")


if __name__ == "__main__":
    print("=" * 50)
    print("  Browser Controller - Evony Master Suite")
    print("=" * 50)
    
    list_tools()
    
    print("\nUsage:")
    print("  from browser_controller import BrowserController")
    print("  bc = BrowserController()")
    print("  bc.start('http://cc2.evony.com/s.html')")
