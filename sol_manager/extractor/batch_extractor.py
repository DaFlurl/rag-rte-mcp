"""
ETK Batch Account Extractor
Launches RoboEvony for each account with auto-extraction

Since Evony uses a proprietary binary protocol that only RoboEvony implements,
we automate RoboEvony to:
1. Login with credentials
2. Auto-run extraction script
3. Save JSON to fresh_exports folder
4. Import to database
"""

import json
import time
import subprocess
from pathlib import Path
from datetime import datetime
from typing import List, Dict, Optional

import sys
sys.path.insert(0, str(Path(__file__).parent.parent.parent))

from sol_manager.bot_launcher import get_bot_launcher, AccountSOLData
from sol_manager.extractor.database import AccountDatabase


class BatchExtractor:
    """
    Batch extraction system using RoboEvony.
    
    Workflow:
    1. Load account list with passwords + sec_codes
    2. For each account:
       - Deploy config.sol with auto-login and auto-script enabled
       - Launch RoboEvony
       - Wait for extraction to complete
       - Close RoboEvony
    3. Import all fresh JSON exports to database
    """
    
    FRESH_EXPORTS_DIR = Path(r"D:\EvonyToolKit\data\fresh_exports")
    EXTRACTION_SCRIPT = Path(r"D:\EvonyToolKit\scripts\extraction\complete_extraction_v2.txt")
    
    def __init__(self):
        self.launcher = get_bot_launcher()
        self.db = AccountDatabase()
        self.results: List[Dict] = []
        
        # Ensure directories exist
        self.FRESH_EXPORTS_DIR.mkdir(parents=True, exist_ok=True)
    
    def load_accounts(self) -> List[Dict]:
        """Load accounts from the latest parsed JSON"""
        data_dir = Path(r"D:\EvonyToolKit\data")
        json_files = list(data_dir.glob("accounts_with_seccode_*.json"))
        
        if not json_files:
            print("No account files found!")
            return []
        
        latest = max(json_files, key=lambda f: f.stat().st_mtime)
        
        with open(latest, 'r') as f:
            data = json.load(f)
        
        return data.get('accounts', [])
    
    def create_sol_data(self, account: Dict, node: int = 0) -> AccountSOLData:
        """Create SOL data for an account with auto-login enabled"""
        return AccountSOLData(
            email=account['email'],
            password=account['password'],
            server='cc2',
            server_ip='216.66.17.35',
            proxy_host='',
            proxy_port=0,
            proxy_type='',
            auto_login=True,
            node=node
        )
    
    def extract_single(self, account: Dict, timeout: int = 120) -> Dict:
        """
        Extract data from a single account.
        
        Args:
            account: Account dict with email, password, sec_code
            timeout: Max seconds to wait for extraction
            
        Returns:
            Result dict with success status and details
        """
        email = account['email']
        result = {
            'email': email,
            'success': False,
            'error': None,
            'json_path': None,
            'start_time': datetime.now().isoformat()
        }
        
        try:
            # Create SOL data
            sol_data = self.create_sol_data(account)
            
            # Launch RoboEvony
            instance, error = self.launcher.launch_bot(sol_data, wait_seconds=2)
            
            if error and instance is None:
                result['error'] = error
                return result
            
            # Wait for JSON file to appear (extraction complete)
            safe_email = email.replace('@', '_at_').replace('.', '_')
            expected_json = self.FRESH_EXPORTS_DIR / f"{safe_email}.json"
            
            start = time.time()
            while time.time() - start < timeout:
                if expected_json.exists():
                    # Check if file was modified recently (within last minute)
                    if expected_json.stat().st_mtime > start:
                        result['success'] = True
                        result['json_path'] = str(expected_json)
                        break
                time.sleep(5)
            
            if not result['success']:
                result['error'] = "Timeout waiting for extraction"
            
            # Stop the bot
            self.launcher.stop_bot(email)
            
        except Exception as e:
            result['error'] = str(e)
        
        result['end_time'] = datetime.now().isoformat()
        return result
    
    def extract_batch(self, accounts: List[Dict], max_concurrent: int = 1,
                     delay_between: int = 30) -> List[Dict]:
        """
        Extract data from multiple accounts.
        
        Args:
            accounts: List of account dicts
            max_concurrent: Max simultaneous extractions (1 recommended to avoid conflicts)
            delay_between: Seconds to wait between starting each account
            
        Returns:
            List of result dicts
        """
        self.results = []
        total = len(accounts)
        
        print(f"Starting batch extraction of {total} accounts")
        print(f"Fresh exports will be saved to: {self.FRESH_EXPORTS_DIR}")
        print("=" * 60)
        
        for i, account in enumerate(accounts):
            print(f"\n[{i+1}/{total}] {account['email']}")
            
            result = self.extract_single(account)
            self.results.append(result)
            
            if result['success']:
                print(f"  ✓ Extracted: {result['json_path']}")
            else:
                print(f"  ✗ Failed: {result['error']}")
            
            # Delay before next account
            if i < total - 1:
                print(f"  Waiting {delay_between}s before next account...")
                time.sleep(delay_between)
        
        return self.results
    
    def import_fresh_exports(self) -> Dict:
        """Import all fresh JSON exports to database"""
        json_files = list(self.FRESH_EXPORTS_DIR.glob("*.json"))
        
        imported = 0
        failed = 0
        
        for json_path in json_files:
            try:
                with open(json_path, 'r') as f:
                    data = json.load(f)
                
                # Import to database
                email = data.get('player', {}).get('email', json_path.stem)
                # ... import logic here
                imported += 1
                
            except Exception as e:
                print(f"Failed to import {json_path.name}: {e}")
                failed += 1
        
        return {'imported': imported, 'failed': failed}
    
    def get_summary(self) -> Dict:
        """Get extraction summary"""
        success = sum(1 for r in self.results if r['success'])
        failed = len(self.results) - success
        
        return {
            'total': len(self.results),
            'success': success,
            'failed': failed,
            'success_rate': f"{(success/len(self.results)*100):.1f}%" if self.results else "0%"
        }


def main():
    """Run batch extraction"""
    print("=" * 60)
    print("ETK Batch Account Extractor")
    print("=" * 60)
    print("\nNOTE: This requires server to be online.")
    print("Each account will be logged in via RoboEvony,")
    print("extraction script will run, and JSON will be saved.")
    print()
    
    extractor = BatchExtractor()
    accounts = extractor.load_accounts()
    
    print(f"Loaded {len(accounts)} accounts")
    
    # For testing, just show first few
    print("\nFirst 10 accounts:")
    for acc in accounts[:10]:
        sec = "+" if acc.get('sec_code') else " "
        print(f"  [{sec}] {acc['email']}")
    
    print(f"\nTo run extraction, the server must be online.")
    print(f"Extraction script: {extractor.EXTRACTION_SCRIPT}")
    print(f"Output folder: {extractor.FRESH_EXPORTS_DIR}")


if __name__ == '__main__':
    main()
