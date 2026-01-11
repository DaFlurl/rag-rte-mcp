"""
ETK SOL Manager - Account Scanner
Scans and validates accounts with real-time progress display
"""

import os
import json
import time
import threading
import queue
from pathlib import Path
from typing import Dict, List, Any, Optional, Callable, Tuple
from dataclasses import dataclass, field
from datetime import datetime
from enum import Enum

from .evony_client import EvonyClient, LoginResult, AccountInfo
from .duplicate_finder import DuplicateFinder, DuplicateGroup


class ScanStatus(Enum):
    PENDING = "pending"
    SCANNING = "scanning"
    COMPLETED = "completed"
    FAILED = "failed"
    SKIPPED = "skipped"


@dataclass
class ScanResult:
    """Result of scanning a single account"""
    email: str
    status: ScanStatus = ScanStatus.PENDING
    login_result: LoginResult = LoginResult.SUCCESS
    player_name: str = ""
    prestige: int = 0
    honor: int = 0
    gold: int = 0
    food: int = 0
    cities_count: int = 0
    heroes_count: int = 0
    troops_count: int = 0
    alliance: str = ""
    server: str = "cc2"
    error_message: str = ""
    scan_duration: float = 0.0
    has_password: bool = False
    is_duplicate: bool = False
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "email": self.email,
            "status": self.status.value,
            "login_result": self.login_result.value,
            "player_name": self.player_name,
            "prestige": self.prestige,
            "honor": self.honor,
            "gold": self.gold,
            "food": self.food,
            "cities_count": self.cities_count,
            "heroes_count": self.heroes_count,
            "troops_count": self.troops_count,
            "alliance": self.alliance,
            "server": self.server,
            "error_message": self.error_message,
            "scan_duration": self.scan_duration,
            "has_password": self.has_password,
            "is_duplicate": self.is_duplicate
        }


@dataclass
class ScanProgress:
    """Current scan progress"""
    total_accounts: int = 0
    scanned: int = 0
    successful: int = 0
    failed: int = 0
    skipped: int = 0
    duplicates_found: int = 0
    current_account: str = ""
    current_status: str = ""
    elapsed_time: float = 0.0
    estimated_remaining: float = 0.0
    is_running: bool = False
    is_paused: bool = False
    
    @property
    def percent_complete(self) -> float:
        if self.total_accounts == 0:
            return 0.0
        return (self.scanned / self.total_accounts) * 100


class AccountScanner:
    """
    Main account scanner for validating and extracting data from accounts.
    
    Features:
    - Scans all accounts from SOL files and CSV
    - Finds duplicates
    - Validates credentials
    - Extracts account data
    - Real-time progress updates
    - Pause/Resume/Stop support
    """
    
    def __init__(self, server: str = "cc2"):
        self.server = server
        self.accounts: List[DuplicateGroup] = []
        self.results: Dict[str, ScanResult] = {}
        self.progress = ScanProgress()
        
        # Threading
        self._scan_thread: Optional[threading.Thread] = None
        self._stop_flag = threading.Event()
        self._pause_flag = threading.Event()
        self._result_queue = queue.Queue()
        
        # Callbacks
        self.on_progress: Optional[Callable[[ScanProgress], None]] = None
        self.on_account_scanned: Optional[Callable[[ScanResult], None]] = None
        self.on_complete: Optional[Callable[[Dict[str, ScanResult]], None]] = None
        
        # Duplicate finder
        self.duplicate_finder = DuplicateFinder()
    
    def load_accounts(self) -> int:
        """Load all accounts from available sources"""
        # Scan all sources
        self.duplicate_finder.scan_all_sources()
        
        # Get unique accounts with passwords
        self.accounts = self.duplicate_finder.get_accounts_with_passwords()
        
        # Initialize results
        self.results = {}
        for group in self.accounts:
            self.results[group.email] = ScanResult(
                email=group.email,
                has_password=group.has_password,
                is_duplicate=group.count > 1,
                server=list(group.servers)[0] if group.servers else "cc2"
            )
        
        self.progress.total_accounts = len(self.accounts)
        self.progress.duplicates_found = len(self.duplicate_finder.get_duplicates())
        
        return len(self.accounts)
    
    def start_scan(self, accounts: List[DuplicateGroup] = None, 
                   use_roboevony: bool = True):
        """
        Start scanning accounts.
        
        Args:
            accounts: Optional list of accounts to scan (defaults to all loaded)
            use_roboevony: If True, uses RoboEvony for actual login
        """
        if self._scan_thread and self._scan_thread.is_alive():
            return  # Already running
        
        if accounts:
            self.accounts = accounts
            self.progress.total_accounts = len(accounts)
        
        self._stop_flag.clear()
        self._pause_flag.clear()
        self.progress.is_running = True
        self.progress.scanned = 0
        self.progress.successful = 0
        self.progress.failed = 0
        
        self._scan_thread = threading.Thread(
            target=self._scan_worker,
            args=(use_roboevony,),
            daemon=True
        )
        self._scan_thread.start()
    
    def _scan_worker(self, use_roboevony: bool):
        """Worker thread for scanning"""
        start_time = time.time()
        
        for i, account in enumerate(self.accounts):
            # Check stop flag
            if self._stop_flag.is_set():
                break
            
            # Check pause flag
            while self._pause_flag.is_set() and not self._stop_flag.is_set():
                time.sleep(0.1)
            
            email = account.email
            password = account.password
            
            self.progress.current_account = email
            self.progress.current_status = "Scanning..."
            
            result = self.results.get(email, ScanResult(email=email))
            result.status = ScanStatus.SCANNING
            
            scan_start = time.time()
            
            try:
                if use_roboevony:
                    # For RoboEvony-based scanning, we mark as pending
                    # Actual data extraction happens via RoboEvony scripts
                    result.status = ScanStatus.PENDING
                    result.login_result = LoginResult.SUCCESS
                    result.error_message = "Pending RoboEvony scan"
                else:
                    # Direct API validation (limited)
                    client = EvonyClient(self.server)
                    login_result, account_info = client.login(email, password)
                    client.disconnect()
                    
                    result.login_result = login_result
                    if login_result == LoginResult.SUCCESS:
                        result.status = ScanStatus.COMPLETED
                        result.player_name = account_info.player_name
                        result.prestige = account_info.prestige
                        self.progress.successful += 1
                    else:
                        result.status = ScanStatus.FAILED
                        result.error_message = account_info.error_message
                        self.progress.failed += 1
                
            except Exception as e:
                result.status = ScanStatus.FAILED
                result.error_message = str(e)
                self.progress.failed += 1
            
            result.scan_duration = time.time() - scan_start
            self.results[email] = result
            
            # Update progress
            self.progress.scanned = i + 1
            self.progress.elapsed_time = time.time() - start_time
            
            # Estimate remaining time
            if self.progress.scanned > 0:
                avg_time = self.progress.elapsed_time / self.progress.scanned
                remaining = self.progress.total_accounts - self.progress.scanned
                self.progress.estimated_remaining = avg_time * remaining
            
            # Notify callbacks
            if self.on_account_scanned:
                self.on_account_scanned(result)
            
            if self.on_progress:
                self.on_progress(self.progress)
        
        # Scan complete
        self.progress.is_running = False
        self.progress.current_account = ""
        self.progress.current_status = "Complete"
        
        if self.on_complete:
            self.on_complete(self.results)
    
    def pause_scan(self):
        """Pause the scan"""
        self._pause_flag.set()
        self.progress.is_paused = True
    
    def resume_scan(self):
        """Resume the scan"""
        self._pause_flag.clear()
        self.progress.is_paused = False
    
    def stop_scan(self):
        """Stop the scan"""
        self._stop_flag.set()
        self._pause_flag.clear()
        self.progress.is_running = False
    
    def get_results_summary(self) -> Dict[str, Any]:
        """Get summary of scan results"""
        return {
            "total_accounts": len(self.accounts),
            "scanned": self.progress.scanned,
            "successful": self.progress.successful,
            "failed": self.progress.failed,
            "skipped": self.progress.skipped,
            "duplicates": self.progress.duplicates_found,
            "elapsed_time": self.progress.elapsed_time,
            "accounts_with_data": sum(
                1 for r in self.results.values() 
                if r.status == ScanStatus.COMPLETED
            )
        }
    
    def export_results(self, output_path: Path) -> bool:
        """Export scan results to JSON"""
        try:
            data = {
                "scan_date": datetime.now().isoformat(),
                "server": self.server,
                "summary": self.get_results_summary(),
                "results": {
                    email: result.to_dict()
                    for email, result in sorted(self.results.items())
                }
            }
            
            output_path.parent.mkdir(parents=True, exist_ok=True)
            with open(output_path, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=2)
            
            return True
        except Exception as e:
            print(f"Export error: {e}")
            return False
    
    def get_valid_accounts(self) -> List[ScanResult]:
        """Get list of valid/successful accounts"""
        return [
            r for r in self.results.values()
            if r.status == ScanStatus.COMPLETED and r.login_result == LoginResult.SUCCESS
        ]
    
    def get_failed_accounts(self) -> List[ScanResult]:
        """Get list of failed accounts"""
        return [
            r for r in self.results.values()
            if r.status == ScanStatus.FAILED
        ]


def run_full_scan(progress_callback: Callable = None) -> Dict[str, Any]:
    """
    Convenience function to run a full account scan.
    
    Returns summary of results.
    """
    scanner = AccountScanner()
    
    # Load accounts
    count = scanner.load_accounts()
    print(f"Loaded {count} accounts with passwords")
    
    # Print duplicate finder summary
    scanner.duplicate_finder.print_summary()
    
    # Start scan (marks accounts as pending for RoboEvony)
    scanner.on_progress = progress_callback
    scanner.start_scan(use_roboevony=True)
    
    # Wait for completion
    while scanner.progress.is_running:
        time.sleep(0.5)
    
    # Export results
    output_path = Path(r"D:\EvonyToolKit\data\scan_results.json")
    scanner.export_results(output_path)
    
    return scanner.get_results_summary()


if __name__ == "__main__":
    def print_progress(progress: ScanProgress):
        print(f"\rScanning: {progress.scanned}/{progress.total_accounts} "
              f"({progress.percent_complete:.1f}%) - {progress.current_account[:30]}...", 
              end="", flush=True)
    
    results = run_full_scan(print_progress)
    print("\n")
    print("Scan Results:")
    for key, value in results.items():
        print(f"  {key}: {value}")
