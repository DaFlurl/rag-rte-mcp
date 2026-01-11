# Evony Hub - Full Automation Controller
"""
Complete automation controller that combines:
- File watcher (auto-organize)
- Script server (AutoEvony integration)
- Task scheduler (recurring operations)
- Exploit discovery (periodic scans)

Run with: python -m evony_hub.automation
"""

import sys
import time
import signal
import threading
from pathlib import Path
from datetime import datetime

sys.path.insert(0, str(Path(__file__).parent.parent))

from evony_hub.config import HUB_ROOT, DATA_INBOX
from evony_hub.watcher import FileWatcher
from evony_hub.scheduler import TaskScheduler
from evony_hub.indexer import EvonyIndexer


class AutomationController:
    """
    Master controller for full Evony Hub automation.
    Manages all background services and provides unified control.
    """
    
    def __init__(self):
        self.hub_root = HUB_ROOT
        self.watcher = None
        self.scheduler = None
        self.server_thread = None
        self._running = False
        self._start_time = None
        
        # Setup signal handlers
        signal.signal(signal.SIGINT, self._signal_handler)
        signal.signal(signal.SIGTERM, self._signal_handler)
    
    def _signal_handler(self, signum, frame):
        """Handle shutdown signals."""
        print("\n[Automation] Shutdown signal received...")
        self.stop()
    
    def start_all(self, enable_server: bool = True, enable_watcher: bool = True,
                  enable_scheduler: bool = True, server_port: int = 8088):
        """Start all automation components."""
        self._running = True
        self._start_time = datetime.now()
        
        print("=" * 70)
        print("EVONY HUB - Full Automation Controller")
        print("=" * 70)
        print(f"\nStarting at {self._start_time.strftime('%Y-%m-%d %H:%M:%S')}")
        print(f"Hub Root: {self.hub_root}\n")
        
        # Start file watcher
        if enable_watcher:
            self._start_watcher()
        
        # Start scheduler
        if enable_scheduler:
            self._start_scheduler()
        
        # Start script server
        if enable_server:
            self._start_server(server_port)
        
        self._print_status()
    
    def _start_watcher(self):
        """Start file watcher."""
        try:
            DATA_INBOX.mkdir(parents=True, exist_ok=True)
            self.watcher = FileWatcher(DATA_INBOX, self.hub_root)
            self.watcher.start()
            print(f"[✓] File Watcher: STARTED (watching {DATA_INBOX})")
        except Exception as e:
            print(f"[✗] File Watcher: FAILED - {e}")
    
    def _start_scheduler(self):
        """Start task scheduler."""
        try:
            self.scheduler = TaskScheduler(self.hub_root)
            self.scheduler.setup_default_tasks()
            self.scheduler.start()
            print(f"[✓] Scheduler: STARTED ({len(self.scheduler._tasks)} tasks)")
        except Exception as e:
            print(f"[✗] Scheduler: FAILED - {e}")
    
    def _start_server(self, port: int):
        """Start integrated exploit script server."""
        try:
            # Use integrated server from evony_hub
            from evony_hub.server import run_server
            
            def server_wrapper():
                try:
                    run_server(port)
                except Exception as e:
                    print(f"[Server] Error: {e}")
            
            self.server_thread = threading.Thread(target=server_wrapper, daemon=True)
            self.server_thread.start()
            time.sleep(1)  # Give server time to start
            
            print(f"[✓] Script Server: STARTED (http://localhost:{port})")
            
        except Exception as e:
            print(f"[✗] Script Server: FAILED - {e}")
    
    def _print_status(self):
        """Print automation status."""
        print("\n" + "=" * 70)
        print("AUTOMATION ACTIVE")
        print("=" * 70)
        print("""
Services Running:
  - File Watcher:  Auto-organizes files dropped in data/ folder
  - Scheduler:     Runs periodic indexing and reports
  - Script Server: Serves exploit scripts to AutoEvony

AutoEvony Integration:
  includeurl http://localhost:8088/epic/overflow_chain
  includeurl http://localhost:8088/epic/infinite_resources
  includeurl http://localhost:8088/epic/full_auto

Press Ctrl+C to stop all services...
        """)
    
    def stop(self):
        """Stop all automation components."""
        print("\n[Automation] Stopping all services...")
        self._running = False
        
        if self.watcher:
            try:
                self.watcher.stop()
                print("[✓] File Watcher stopped")
            except:
                pass
        
        if self.scheduler:
            try:
                self.scheduler.stop()
                print("[✓] Scheduler stopped")
            except:
                pass
        
        # Server thread is daemon, will stop with main process
        print("[✓] Script Server stopped")
        
        uptime = datetime.now() - self._start_time if self._start_time else None
        if uptime:
            print(f"\nUptime: {uptime}")
        
        print("[Automation] All services stopped")
    
    def run_forever(self):
        """Run until interrupted."""
        try:
            while self._running:
                time.sleep(1)
        except KeyboardInterrupt:
            pass
        finally:
            self.stop()
    
    def get_status(self) -> dict:
        """Get current automation status."""
        return {
            'running': self._running,
            'start_time': self._start_time.isoformat() if self._start_time else None,
            'uptime_seconds': (datetime.now() - self._start_time).total_seconds() if self._start_time else 0,
            'watcher': {
                'running': self.watcher._running if self.watcher else False,
            },
            'scheduler': self.scheduler.get_status() if self.scheduler else {},
            'server': {
                'running': self.server_thread.is_alive() if self.server_thread else False,
            },
        }


def run_automation():
    """Run full automation."""
    controller = AutomationController()
    controller.start_all()
    controller.run_forever()


if __name__ == "__main__":
    run_automation()
