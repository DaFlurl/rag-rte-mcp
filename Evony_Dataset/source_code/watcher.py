# Evony RE Hub - File Watcher
"""
Watches the data inbox folder for new files and automatically organizes them.
Runs as a background service for continuous auto-organization.
"""

import time
import threading
from pathlib import Path
from datetime import datetime
from typing import Set, Callable, Optional
import json

from .config import HUB_ROOT, DATA_INBOX
from .organizer import EvonyOrganizer
from .indexer import EvonyIndexer


class FileWatcher:
    """Watches for new files and triggers auto-organization."""
    
    def __init__(self, watch_path: Path = DATA_INBOX, 
                 hub_root: Path = HUB_ROOT,
                 poll_interval: float = 5.0):
        self.watch_path = watch_path
        self.hub_root = hub_root
        self.poll_interval = poll_interval
        self.organizer = EvonyOrganizer(hub_root)
        self.indexer = EvonyIndexer(hub_root)
        
        self._running = False
        self._thread: Optional[threading.Thread] = None
        self._known_files: Set[str] = set()
        self._callbacks: list = []
        self._log: list = []
        
        # Initialize known files
        self._scan_existing()
    
    def _scan_existing(self):
        """Scan existing files in watch path."""
        if self.watch_path.exists():
            for f in self.watch_path.rglob("*"):
                if f.is_file():
                    self._known_files.add(str(f))
    
    def _detect_new_files(self) -> list:
        """Detect newly added files."""
        new_files = []
        
        if not self.watch_path.exists():
            return new_files
        
        current_files = set()
        for f in self.watch_path.rglob("*"):
            if f.is_file():
                path_str = str(f)
                current_files.add(path_str)
                
                if path_str not in self._known_files:
                    new_files.append(f)
        
        self._known_files = current_files
        return new_files
    
    def _process_new_file(self, filepath: Path):
        """Process a newly detected file."""
        log_entry = {
            'timestamp': datetime.now().isoformat(),
            'file': str(filepath),
            'action': 'detected'
        }
        
        try:
            # Wait a moment for file to finish writing
            time.sleep(0.5)
            
            # Organize the file
            result = self.organizer.organize_file(filepath, copy=False)
            
            if result:
                log_entry['action'] = 'organized'
                log_entry['destination'] = str(result)
                print(f"[Watcher] Organized: {filepath.name} -> {result}")
            else:
                log_entry['action'] = 'skipped'
                print(f"[Watcher] Skipped: {filepath.name}")
            
            # Notify callbacks
            for callback in self._callbacks:
                try:
                    callback(filepath, result)
                except Exception as e:
                    print(f"Callback error: {e}")
                    
        except Exception as e:
            log_entry['action'] = 'error'
            log_entry['error'] = str(e)
            print(f"[Watcher] Error processing {filepath}: {e}")
        
        self._log.append(log_entry)
    
    def _watch_loop(self):
        """Main watch loop."""
        print(f"[Watcher] Monitoring: {self.watch_path}")
        
        while self._running:
            try:
                new_files = self._detect_new_files()
                
                for filepath in new_files:
                    self._process_new_file(filepath)
                
            except Exception as e:
                print(f"[Watcher] Error in watch loop: {e}")
            
            time.sleep(self.poll_interval)
    
    def add_callback(self, callback: Callable):
        """Add callback for file processing events."""
        self._callbacks.append(callback)
    
    def start(self):
        """Start the file watcher."""
        if self._running:
            return
        
        self._running = True
        self._thread = threading.Thread(target=self._watch_loop, daemon=True)
        self._thread.start()
        print(f"[Watcher] Started watching {self.watch_path}")
    
    def stop(self):
        """Stop the file watcher."""
        self._running = False
        if self._thread:
            self._thread.join(timeout=2)
        print("[Watcher] Stopped")
    
    def get_log(self) -> list:
        """Get the processing log."""
        return self._log
    
    def save_log(self, filepath: Path = None):
        """Save log to file."""
        if filepath is None:
            filepath = self.hub_root / "evony_hub" / "watcher_log.json"
        
        filepath.parent.mkdir(parents=True, exist_ok=True)
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(self._log, f, indent=2)


class HubMonitor:
    """Monitors entire hub for changes and keeps index updated."""
    
    def __init__(self, hub_root: Path = HUB_ROOT, poll_interval: float = 30.0):
        self.hub_root = hub_root
        self.poll_interval = poll_interval
        self.indexer = EvonyIndexer(hub_root)
        
        self._running = False
        self._thread: Optional[threading.Thread] = None
        self._file_mtimes: dict = {}
    
    def _scan_for_changes(self) -> tuple:
        """Scan hub for new/modified/deleted files."""
        new_files = []
        modified_files = []
        
        current_files = set()
        
        for f in self.hub_root.rglob("*"):
            if f.is_file() and 'evony_hub' not in str(f):
                path_str = str(f)
                current_files.add(path_str)
                mtime = f.stat().st_mtime
                
                if path_str not in self._file_mtimes:
                    new_files.append(f)
                elif self._file_mtimes[path_str] != mtime:
                    modified_files.append(f)
                
                self._file_mtimes[path_str] = mtime
        
        # Find deleted files
        deleted = set(self._file_mtimes.keys()) - current_files
        for path_str in deleted:
            del self._file_mtimes[path_str]
        
        return new_files, modified_files, list(deleted)
    
    def _monitor_loop(self):
        """Main monitoring loop."""
        print(f"[Monitor] Monitoring hub: {self.hub_root}")
        
        while self._running:
            try:
                new, modified, deleted = self._scan_for_changes()
                
                # Index new files
                for f in new:
                    self.indexer.index_file(f)
                
                # Re-index modified files
                for f in modified:
                    self.indexer.index_file(f, force=True)
                
                # Remove deleted from index
                for path_str in deleted:
                    rel_path = str(Path(path_str).relative_to(self.hub_root))
                    if rel_path in self.indexer.index:
                        del self.indexer.index[rel_path]
                
                if new or modified or deleted:
                    self.indexer._rebuild_secondary_indexes()
                    self.indexer._save_index()
                    print(f"[Monitor] Updated index: +{len(new)} ~{len(modified)} -{len(deleted)}")
                    
            except Exception as e:
                print(f"[Monitor] Error: {e}")
            
            time.sleep(self.poll_interval)
    
    def start(self):
        """Start monitoring."""
        if self._running:
            return
        
        self._running = True
        self._thread = threading.Thread(target=self._monitor_loop, daemon=True)
        self._thread.start()
    
    def stop(self):
        """Stop monitoring."""
        self._running = False
        if self._thread:
            self._thread.join(timeout=2)


def start_watcher_service():
    """Start the complete watcher service."""
    watcher = FileWatcher()
    monitor = HubMonitor()
    
    watcher.start()
    monitor.start()
    
    print("Evony Hub Watcher Service started.")
    print(f"  - Drop files in: {DATA_INBOX}")
    print("  - Press Ctrl+C to stop")
    
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print("\nShutting down...")
        watcher.stop()
        monitor.stop()
        watcher.save_log()


if __name__ == "__main__":
    start_watcher_service()
