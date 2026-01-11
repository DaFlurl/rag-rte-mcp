# Evony Hub - Task Scheduler
"""
Automated task scheduler for running recurring operations:
- Periodic exploit scans
- Auto-organization
- Report generation
- Index updates
"""

import time
import threading
import schedule
from pathlib import Path
from datetime import datetime
from typing import Callable, Dict, List, Optional
import json

from .config import HUB_ROOT
from .indexer import EvonyIndexer
from .organizer import EvonyOrganizer


class TaskScheduler:
    """Manages scheduled automation tasks."""
    
    def __init__(self, hub_root: Path = HUB_ROOT):
        self.hub_root = hub_root
        self.indexer = EvonyIndexer(hub_root)
        self.organizer = EvonyOrganizer(hub_root)
        self._running = False
        self._thread: Optional[threading.Thread] = None
        self._tasks: Dict[str, dict] = {}
        self._log: List[dict] = []
    
    def add_task(self, name: str, func: Callable, interval_minutes: int = 60):
        """Add a recurring task."""
        self._tasks[name] = {
            'function': func,
            'interval': interval_minutes,
            'last_run': None,
            'run_count': 0,
            'errors': 0,
        }
        
        # Schedule the task
        schedule.every(interval_minutes).minutes.do(self._run_task, name)
        print(f"[Scheduler] Added task: {name} (every {interval_minutes} min)")
    
    def _run_task(self, name: str):
        """Execute a scheduled task."""
        if name not in self._tasks:
            return
        
        task = self._tasks[name]
        log_entry = {
            'timestamp': datetime.now().isoformat(),
            'task': name,
            'status': 'started',
        }
        
        try:
            task['function']()
            task['last_run'] = datetime.now()
            task['run_count'] += 1
            log_entry['status'] = 'completed'
            print(f"[Scheduler] Task completed: {name}")
            
        except Exception as e:
            task['errors'] += 1
            log_entry['status'] = 'error'
            log_entry['error'] = str(e)
            print(f"[Scheduler] Task error: {name} - {e}")
        
        self._log.append(log_entry)
    
    def setup_default_tasks(self):
        """Setup default automation tasks."""
        
        # Reindex every hour
        self.add_task("reindex", self._task_reindex, 60)
        
        # Organize inbox every 5 minutes
        self.add_task("organize_inbox", self._task_organize_inbox, 5)
        
        # Generate report every 6 hours
        self.add_task("generate_report", self._task_generate_report, 360)
        
        print("[Scheduler] Default tasks configured")
    
    def _task_reindex(self):
        """Reindex all files."""
        self.indexer.index_all()
    
    def _task_organize_inbox(self):
        """Organize files in inbox."""
        inbox = self.hub_root / "data"
        if inbox.exists():
            for f in inbox.iterdir():
                if f.is_file():
                    self.organizer.organize_file(f)
    
    def _task_generate_report(self):
        """Generate automation report."""
        report = {
            'generated': datetime.now().isoformat(),
            'tasks': {
                name: {
                    'last_run': task['last_run'].isoformat() if task['last_run'] else None,
                    'run_count': task['run_count'],
                    'errors': task['errors'],
                }
                for name, task in self._tasks.items()
            },
            'recent_log': self._log[-100:],
        }
        
        report_path = self.hub_root / "evony_hub" / "scheduler_report.json"
        with open(report_path, 'w') as f:
            json.dump(report, f, indent=2, default=str)
    
    def start(self):
        """Start the scheduler in background thread."""
        if self._running:
            return
        
        self._running = True
        self._thread = threading.Thread(target=self._run_loop, daemon=True)
        self._thread.start()
        print("[Scheduler] Started")
    
    def stop(self):
        """Stop the scheduler."""
        self._running = False
        if self._thread:
            self._thread.join(timeout=2)
        print("[Scheduler] Stopped")
    
    def _run_loop(self):
        """Main scheduler loop."""
        while self._running:
            schedule.run_pending()
            time.sleep(1)
    
    def run_now(self, name: str):
        """Run a task immediately."""
        if name in self._tasks:
            self._run_task(name)
        else:
            print(f"[Scheduler] Unknown task: {name}")
    
    def get_status(self) -> dict:
        """Get scheduler status."""
        return {
            'running': self._running,
            'tasks': {
                name: {
                    'interval': task['interval'],
                    'last_run': task['last_run'].isoformat() if task['last_run'] else None,
                    'run_count': task['run_count'],
                    'errors': task['errors'],
                }
                for name, task in self._tasks.items()
            },
            'log_count': len(self._log),
        }


def run_scheduler():
    """Run the scheduler as standalone."""
    print("=" * 70)
    print("EVONY HUB - Task Scheduler")
    print("=" * 70)
    
    scheduler = TaskScheduler()
    scheduler.setup_default_tasks()
    scheduler.start()
    
    print("\nScheduler running. Press Ctrl+C to stop.\n")
    
    try:
        while True:
            time.sleep(60)
            status = scheduler.get_status()
            print(f"[{datetime.now().strftime('%H:%M:%S')}] Tasks: {len(status['tasks'])}, Logs: {status['log_count']}")
    except KeyboardInterrupt:
        scheduler.stop()
        print("\nScheduler stopped.")


if __name__ == "__main__":
    run_scheduler()
