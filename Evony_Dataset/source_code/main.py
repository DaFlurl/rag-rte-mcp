#!/usr/bin/env python3
# Evony Hub - Main Entry Point
"""
Unified launcher for the complete Evony RE & Exploitation framework.
Combines all components: organizer, scanner, exploit engine, script server.

Usage:
    python -m evony_hub.main              # Interactive menu
    python -m evony_hub.main --server     # Start script server
    python -m evony_hub.main --daemon     # Background automation
    python -m evony_hub.main --scan       # Run full scan
    python -m evony_hub.main --report     # Generate report
"""

import sys
import argparse
import threading
import time
from pathlib import Path
from datetime import datetime

# Add parent to path
sys.path.insert(0, str(Path(__file__).parent.parent))

from evony_hub.config import HUB_ROOT, DATA_INBOX, CATEGORIES
from evony_hub.borg_toolkit import BorgToolkit, PROTOCOL_COMMANDS, ENCRYPTION_KEYS
from evony_hub.exploit_discovery import ExploitDiscoveryEngine, run_full_discovery
from evony_hub.glitch_calculator import GlitchCalculator, run_glitch_calculator
from evony_hub.protocol_exploiter import generate_exploit_toolkit, CommandRegistry
from evony_hub.watcher import FileWatcher
from evony_hub.indexer import EvonyIndexer
from evony_hub.organizer import EvonyOrganizer
from evony_hub.scanner import ExternalScanner


class EvonyHub:
    """Main hub coordinating all Evony RE components."""
    
    def __init__(self):
        self.hub_root = HUB_ROOT
        self.toolkit = BorgToolkit()
        self.organizer = EvonyOrganizer(HUB_ROOT)
        self.indexer = EvonyIndexer(HUB_ROOT)
        self.scanner = ExternalScanner(HUB_ROOT)
        self.watcher = None
        self.server_thread = None
        self._running = False
    
    def print_banner(self):
        print("""
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║   ███████╗██╗   ██╗ ██████╗ ███╗   ██╗██╗   ██╗    ██╗  ██╗██╗   ██╗██████╗  ║
║   ██╔════╝██║   ██║██╔═══██╗████╗  ██║╚██╗ ██╔╝    ██║  ██║██║   ██║██╔══██╗ ║
║   █████╗  ██║   ██║██║   ██║██╔██╗ ██║ ╚████╔╝     ███████║██║   ██║██████╔╝ ║
║   ██╔══╝  ╚██╗ ██╔╝██║   ██║██║╚██╗██║  ╚██╔╝      ██╔══██║██║   ██║██╔══██╗ ║
║   ███████╗ ╚████╔╝ ╚██████╔╝██║ ╚████║   ██║       ██║  ██║╚██████╔╝██████╔╝ ║
║   ╚══════╝  ╚═══╝   ╚═════╝ ╚═╝  ╚═══╝   ╚═╝       ╚═╝  ╚═╝ ╚═════╝ ╚═════╝  ║
║                                                                              ║
║              COMPLETE REVERSE ENGINEERING & EXPLOITATION HUB                 ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
        """)
    
    def show_status(self):
        """Show current hub status."""
        print("\n" + "=" * 70)
        print("EVONY HUB STATUS")
        print("=" * 70)
        
        # Count files
        total_files = sum(1 for _ in self.hub_root.rglob("*") if _.is_file())
        
        # Count by category
        print(f"\nHub Root: {self.hub_root}")
        print(f"Total Files: {total_files:,}")
        print(f"\nCategories:")
        for cat_id, cat_info in CATEGORIES.items():
            cat_path = self.hub_root / cat_info['path']
            if cat_path.exists():
                count = sum(1 for _ in cat_path.rglob("*") if _.is_file())
                print(f"  {cat_info['path']:15} {count:5} files - {cat_info['description']}")
        
        # Exploit stats
        print(f"\nExploit Database:")
        print(f"  Protocol Commands: {sum(len(cmds) for cmds in PROTOCOL_COMMANDS.values())}")
        print(f"  Encryption Keys: {len(ENCRYPTION_KEYS)}")
        
        # Watcher status
        if self.watcher and self.watcher._running:
            print(f"\nFile Watcher: RUNNING (watching {DATA_INBOX})")
        else:
            print(f"\nFile Watcher: STOPPED")
    
    def start_watcher(self):
        """Start the file watcher daemon."""
        if self.watcher and self.watcher._running:
            print("Watcher already running")
            return
        
        # Create inbox if needed
        DATA_INBOX.mkdir(parents=True, exist_ok=True)
        
        self.watcher = FileWatcher(DATA_INBOX, HUB_ROOT)
        self.watcher.start()
        print(f"[Hub] File watcher started - watching {DATA_INBOX}")
    
    def stop_watcher(self):
        """Stop the file watcher."""
        if self.watcher:
            self.watcher.stop()
            print("[Hub] File watcher stopped")
    
    def start_script_server(self, port: int = 8088):
        """Start the integrated exploit script server."""
        try:
            # Use integrated server from evony_hub
            from evony_hub.server import run_server
            
            print(f"\n[Hub] Starting integrated script server on port {port}...")
            self.server_thread = threading.Thread(target=lambda: run_server(port), daemon=True)
            self.server_thread.start()
            
            time.sleep(1)  # Give server time to start
            print(f"[Hub] Script server started at http://localhost:{port}")
            print(f"      Use in AutoEvony: includeurl http://localhost:{port}/epic/overflow_chain")
            
        except Exception as e:
            print(f"[Hub] Error starting server: {e}")
    
    def run_full_scan(self):
        """Run full exploit discovery scan."""
        print("\n[Hub] Running full exploit discovery scan...")
        results = run_full_discovery()
        
        # Save results
        report_path = self.hub_root / "evony_hub" / "exploit_report.json"
        print(f"\n[Hub] Scan complete - report saved to {report_path}")
        
        return results
    
    def generate_report(self):
        """Generate comprehensive exploitation report."""
        print("\n[Hub] Generating comprehensive report...")
        
        report = {
            'generated': datetime.now().isoformat(),
            'hub_root': str(self.hub_root),
            'encryption_keys': ENCRYPTION_KEYS,
            'protocol_commands': PROTOCOL_COMMANDS,
            'critical_exploits': self.toolkit.get_critical_exploits(),
            'overflow_thresholds': self.toolkit.get_all_thresholds(),
        }
        
        report_path = self.hub_root / "evony_hub" / "full_report.json"
        with open(report_path, 'w') as f:
            import json
            json.dump(report, f, indent=2, default=str)
        
        print(f"[Hub] Report saved to {report_path}")
        return report
    
    def interactive_menu(self):
        """Run interactive menu."""
        self.print_banner()
        
        while True:
            print("""
┌─────────────────────────────────────────────────────────────────────────────┐
│                              EVONY HUB MENU                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│  1. Show Hub Status                                                          │
│  2. Start File Watcher (Auto-organize)                                       │
│  3. Start Script Server (port 8088)                                          │
│  4. Run Exploit Discovery Scan                                               │
│  5. Generate Full Report                                                     │
│  6. Interactive Overflow Calculator                                          │
│  7. Show Protocol Commands                                                   │
│  8. Show Encryption Keys                                                     │
│  9. Organize All Files                                                       │
│  10. Run Full Automation (watcher + server)                                  │
│  0. Exit                                                                     │
└─────────────────────────────────────────────────────────────────────────────┘
            """)
            
            try:
                choice = input("Select option: ").strip()
                
                if choice == "1":
                    self.show_status()
                elif choice == "2":
                    self.start_watcher()
                elif choice == "3":
                    self.start_script_server()
                elif choice == "4":
                    self.run_full_scan()
                elif choice == "5":
                    self.generate_report()
                elif choice == "6":
                    run_glitch_calculator()
                elif choice == "7":
                    self._show_commands()
                elif choice == "8":
                    self._show_keys()
                elif choice == "9":
                    self._organize_all()
                elif choice == "10":
                    self._run_full_automation()
                elif choice == "0":
                    self.stop_watcher()
                    print("\nExiting Evony Hub...")
                    break
                else:
                    print("Invalid option")
                    
            except KeyboardInterrupt:
                self.stop_watcher()
                print("\n\nInterrupted - exiting...")
                break
            except Exception as e:
                print(f"Error: {e}")
    
    def _show_commands(self):
        """Show all protocol commands."""
        print("\n" + "=" * 70)
        print("PROTOCOL COMMANDS")
        print("=" * 70)
        
        for category, commands in PROTOCOL_COMMANDS.items():
            print(f"\n[{category.upper()}]")
            for cmd_name, cmd_info in commands.items():
                risk = cmd_info.get('risk', 'LOW')
                params = cmd_info.get('params', [])
                print(f"  {category}.{cmd_name}")
                print(f"    Risk: {risk}, Params: {', '.join(params)}")
                if 'exploit' in cmd_info:
                    print(f"    Exploit: {cmd_info['exploit']}")
    
    def _show_keys(self):
        """Show encryption keys."""
        print("\n" + "=" * 70)
        print("ENCRYPTION KEYS")
        print("=" * 70)
        
        for key_name, key_value in ENCRYPTION_KEYS.items():
            print(f"\n{key_name}:")
            print(f"  {key_value}")
    
    def _organize_all(self):
        """Organize all files in hub."""
        print("\n[Hub] Organizing all files...")
        results = self.organizer.organize_all()
        print(f"[Hub] Organized {len(results)} files")
    
    def _run_full_automation(self):
        """Run full automation - watcher + server."""
        print("\n[Hub] Starting full automation...")
        
        # Start watcher
        self.start_watcher()
        
        # Start server
        self.start_script_server()
        
        print("\n" + "=" * 70)
        print("FULL AUTOMATION RUNNING")
        print("=" * 70)
        print(f"""
File Watcher:  ACTIVE - Drop files in {DATA_INBOX}
Script Server: http://localhost:8088

AutoEvony Commands:
  includeurl http://localhost:8088/epic/overflow_chain
  includeurl http://localhost:8088/epic/infinite_resources
  includeurl http://localhost:8088/epic/race_blitz

Press Ctrl+C to stop...
        """)
        
        try:
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            print("\n[Hub] Stopping automation...")
            self.stop_watcher()


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(description="Evony Hub - Complete RE Framework")
    parser.add_argument("--server", action="store_true", help="Start script server only")
    parser.add_argument("--daemon", action="store_true", help="Run as background daemon")
    parser.add_argument("--scan", action="store_true", help="Run exploit discovery scan")
    parser.add_argument("--report", action="store_true", help="Generate full report")
    parser.add_argument("--status", action="store_true", help="Show hub status")
    parser.add_argument("--port", type=int, default=8088, help="Server port")
    
    args = parser.parse_args()
    
    hub = EvonyHub()
    
    if args.server:
        hub.print_banner()
        hub.start_script_server(args.port)
        try:
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            print("\nStopping server...")
    
    elif args.daemon:
        hub.print_banner()
        hub._run_full_automation()
    
    elif args.scan:
        hub.run_full_scan()
    
    elif args.report:
        hub.generate_report()
    
    elif args.status:
        hub.show_status()
    
    else:
        hub.interactive_menu()


if __name__ == "__main__":
    main()
