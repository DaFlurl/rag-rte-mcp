#!/usr/bin/env python3
"""
BORG TOOLKIT - Full Account Data Extractor
Logs into each account, extracts all data, retries failed at end
"""

import json
import time
import logging
from pathlib import Path
from datetime import datetime
from dataclasses import dataclass, asdict
from typing import List, Dict, Optional

# Setup logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s [%(levelname)s] %(message)s')
logger = logging.getLogger(__name__)

# Paths
ACCOUNTS_FILE = Path(__file__).parent / "data" / "final_accounts" / "FINAL_userpass.txt"
OUTPUT_DIR = Path(__file__).parent / "data" / "extracted"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

# Import AMF commander
try:
    from src.amf_commander import AMFCommander, ServerConfig, GameCommand
    AMF_AVAILABLE = True
except ImportError:
    AMF_AVAILABLE = False
    logger.warning("AMF Commander not available - will simulate extraction")


@dataclass
class AccountData:
    """Extracted account data"""
    email: str
    password: str
    server: str = "cc2"
    login_success: bool = False
    player_name: str = ""
    player_id: int = 0
    cities: List[Dict] = None
    heroes: List[Dict] = None
    troops: Dict = None
    resources: Dict = None
    items: List[Dict] = None
    alliance: Dict = None
    extracted_at: str = ""
    error: str = ""
    
    def __post_init__(self):
        if self.cities is None: self.cities = []
        if self.heroes is None: self.heroes = []
        if self.troops is None: self.troops = {}
        if self.resources is None: self.resources = {}
        if self.items is None: self.items = []
        if self.alliance is None: self.alliance = {}


class AccountExtractor:
    """Extract data from all accounts with retry logic"""
    
    def __init__(self, max_retries: int = 3, retry_delay: float = 2.0):
        self.max_retries = max_retries
        self.retry_delay = retry_delay
        
        self.accounts: List[Dict] = []
        self.successful: List[AccountData] = []
        self.failed: List[Dict] = []
        
        self.stats = {
            'total': 0,
            'success': 0,
            'failed': 0,
            'recovered': 0,
        }
    
    def load_accounts(self, filepath: Path) -> int:
        """Load accounts from userpass file"""
        self.accounts = []
        
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            for line in f:
                line = line.strip()
                if ':' in line:
                    parts = line.split(':', 1)
                    self.accounts.append({
                        'email': parts[0].strip(),
                        'password': parts[1].strip(),
                        'server': 'cc2'
                    })
        
        self.stats['total'] = len(self.accounts)
        logger.info(f"Loaded {len(self.accounts)} accounts")
        return len(self.accounts)
    
    def extract_account(self, email: str, password: str, server: str = "cc2") -> AccountData:
        """Extract data from a single account"""
        data = AccountData(
            email=email,
            password=password,
            server=server,
            extracted_at=datetime.now().isoformat()
        )
        
        if not AMF_AVAILABLE:
            # Simulate extraction for testing
            data.login_success = True
            data.player_name = email.split('@')[0]
            data.player_id = hash(email) % 1000000
            data.cities = [{"name": "Main City", "x": 100, "y": 100}]
            data.resources = {"gold": 1000000, "food": 500000, "lumber": 300000, "stone": 200000, "iron": 100000}
            return data
        
        try:
            # Create AMF connection
            commander = AMFCommander()
            
            server_config = ServerConfig(
                host="216.66.17.36",  # cc2
                port=443,
                server_id=server,
                use_ssl=True
            )
            
            # Connect
            if not commander.connect(server_config):
                data.error = "Connection failed"
                return data
            
            # Login
            result = commander.login(email, password)
            
            if not result.success:
                data.error = result.error or "Login failed"
                commander.disconnect()
                return data
            
            data.login_success = True
            data.player_name = result.data.get('playerName', '')
            data.player_id = commander.player_id or 0
            
            # Get player info
            info = commander.send_command(GameCommand.GET_PLAYER_INFO, {})
            if info.success:
                data.player_name = info.data.get('name', data.player_name)
            
            # Get cities
            cities_result = commander.send_command(GameCommand.GET_ALL_CITIES, {})
            if cities_result.success:
                data.cities = cities_result.data.get('cities', [])
            
            # Get heroes
            heroes_result = commander.send_command(GameCommand.GET_HEROES, {})
            if heroes_result.success:
                data.heroes = heroes_result.data.get('heroes', [])
            
            # Disconnect
            commander.disconnect()
            
        except Exception as e:
            data.error = str(e)
            logger.error(f"Error extracting {email}: {e}")
        
        return data
    
    def run_extraction(self, progress_callback=None):
        """Run extraction on all accounts"""
        logger.info(f"Starting extraction of {len(self.accounts)} accounts...")
        
        self.successful = []
        self.failed = []
        
        # First pass - try all accounts
        for i, acc in enumerate(self.accounts):
            email = acc['email']
            password = acc['password']
            server = acc.get('server', 'cc2')
            
            logger.info(f"[{i+1}/{len(self.accounts)}] Extracting {email}...")
            
            data = self.extract_account(email, password, server)
            
            if data.login_success:
                self.successful.append(data)
                self.stats['success'] += 1
                logger.info(f"  ✓ Success: {data.player_name}")
            else:
                self.failed.append(acc)
                logger.warning(f"  ✗ Failed: {data.error}")
            
            if progress_callback:
                progress_callback(i + 1, len(self.accounts), email, data.login_success)
            
            # Rate limit
            time.sleep(0.5)
        
        # Retry failed accounts
        if self.failed:
            logger.info(f"\n{'='*60}")
            logger.info(f"Retrying {len(self.failed)} failed accounts...")
            logger.info(f"{'='*60}")
            
            retry_list = self.failed.copy()
            self.failed = []
            
            for attempt in range(1, self.max_retries + 1):
                if not retry_list:
                    break
                
                logger.info(f"\nRetry attempt {attempt}/{self.max_retries}...")
                still_failed = []
                
                for acc in retry_list:
                    email = acc['email']
                    password = acc['password']
                    server = acc.get('server', 'cc2')
                    
                    logger.info(f"  Retrying {email}...")
                    time.sleep(self.retry_delay)
                    
                    data = self.extract_account(email, password, server)
                    
                    if data.login_success:
                        self.successful.append(data)
                        self.stats['success'] += 1
                        self.stats['recovered'] += 1
                        logger.info(f"    ✓ Recovered: {data.player_name}")
                    else:
                        still_failed.append(acc)
                        logger.warning(f"    ✗ Still failed: {data.error}")
                
                retry_list = still_failed
            
            self.failed = retry_list
            self.stats['failed'] = len(self.failed)
        
        logger.info(f"\n{'='*60}")
        logger.info(f"EXTRACTION COMPLETE")
        logger.info(f"  Total: {self.stats['total']}")
        logger.info(f"  Success: {self.stats['success']}")
        logger.info(f"  Recovered: {self.stats['recovered']}")
        logger.info(f"  Failed: {self.stats['failed']}")
        logger.info(f"{'='*60}")
    
    def save_results(self) -> Dict[str, Path]:
        """Save extraction results"""
        ts = datetime.now().strftime('%Y%m%d_%H%M%S')
        paths = {}
        
        # All successful extractions (JSON)
        if self.successful:
            json_file = OUTPUT_DIR / f"extracted_{ts}.json"
            with open(json_file, 'w', encoding='utf-8') as f:
                json.dump([asdict(d) for d in self.successful], f, indent=2)
            paths['json'] = json_file
            logger.info(f"Saved: {json_file}")
        
        # Per-account files
        accounts_dir = OUTPUT_DIR / f"accounts_{ts}"
        accounts_dir.mkdir(exist_ok=True)
        
        for data in self.successful:
            safe_name = data.email.replace('@', '_at_').replace('.', '_')[:50]
            acc_file = accounts_dir / f"{safe_name}.json"
            with open(acc_file, 'w', encoding='utf-8') as f:
                json.dump(asdict(data), f, indent=2)
        
        paths['accounts_dir'] = accounts_dir
        logger.info(f"Saved {len(self.successful)} account files to {accounts_dir}")
        
        # Failed accounts list
        if self.failed:
            failed_file = OUTPUT_DIR / f"failed_{ts}.txt"
            with open(failed_file, 'w', encoding='utf-8') as f:
                f.write("# Failed accounts - check passwords\n")
                for acc in self.failed:
                    f.write(f"{acc['email']}:{acc['password']}\n")
            paths['failed'] = failed_file
            logger.info(f"Saved failed: {failed_file}")
        
        # Summary
        summary_file = OUTPUT_DIR / f"summary_{ts}.txt"
        with open(summary_file, 'w', encoding='utf-8') as f:
            f.write(f"EXTRACTION SUMMARY\n")
            f.write(f"==================\n")
            f.write(f"Date: {datetime.now().isoformat()}\n")
            f.write(f"Total accounts: {self.stats['total']}\n")
            f.write(f"Successful: {self.stats['success']}\n")
            f.write(f"Recovered (retry): {self.stats['recovered']}\n")
            f.write(f"Failed: {self.stats['failed']}\n")
            f.write(f"\nSuccessful accounts:\n")
            for d in self.successful:
                f.write(f"  {d.email} -> {d.player_name}\n")
        paths['summary'] = summary_file
        
        return paths


def main():
    print("=" * 60)
    print("  BORG TOOLKIT - Account Data Extractor")
    print("=" * 60)
    
    if not ACCOUNTS_FILE.exists():
        print(f"[ERROR] Accounts file not found: {ACCOUNTS_FILE}")
        return
    
    extractor = AccountExtractor(max_retries=3, retry_delay=2.0)
    
    # Load accounts
    count = extractor.load_accounts(ACCOUNTS_FILE)
    print(f"\nLoaded {count} accounts")
    
    # Run extraction
    print("\nStarting extraction...")
    extractor.run_extraction()
    
    # Save results
    print("\nSaving results...")
    paths = extractor.save_results()
    
    print(f"\n{'=' * 60}")
    print(f"  DONE")
    print(f"  Success: {extractor.stats['success']}/{extractor.stats['total']}")
    print(f"  Output: {OUTPUT_DIR}")
    print("=" * 60)


if __name__ == '__main__':
    main()
