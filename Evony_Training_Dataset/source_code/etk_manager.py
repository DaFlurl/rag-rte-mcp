#!/usr/bin/env python3
"""
ETK Account Manager - Modern replacement for EvonyToolKit
Manages 556+ Evony Age II accounts with SOL file support
"""
import os
import sys
import json
import csv
import shutil
import struct
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional, Any

# Try to import AMF library
try:
    import pyamf.sol as sol
    HAS_AMF = True
except ImportError:
    HAS_AMF = False
    print("[!] pyamf not available - install with: pip install Py3AMF")

# Paths
ETK_ROOT = Path(r"D:\EvonyToolKit")
MACROMEDIA_PATH = ETK_ROOT / "Macromedia" / "Flash Player" / "#SharedObjects"
SOL_BACKUPS_PATH = ETK_ROOT / "SOL_Backups"
KHAN_ACCOUNTS_CSV = ETK_ROOT / "scripts" / "khan_Accounts_556" / "khanaccounts.csv"
SYSTEM_SHAREDOBJECTS = Path(os.path.expandvars(r"%AppData%\Macromedia\Flash Player\#SharedObjects"))

class Account:
    """Represents an Evony account"""
    def __init__(self, email: str, password: str = "", status: str = "unknown"):
        self.email = email
        self.password = password
        self.status = status
        self.server = ""
        self.server_ip = ""
        self.sid = ""
        self.proxy_port = ""
        self.proxy_host = ""
        self.sol_path = ""
        self.last_login = None
        self.alias = ""
    
    def to_dict(self) -> Dict:
        return {
            "email": self.email,
            "password": self.password,
            "status": self.status,
            "server": self.server,
            "server_ip": self.server_ip,
            "sid": self.sid,
            "proxy_port": self.proxy_port,
            "proxy_host": self.proxy_host,
            "sol_path": self.sol_path,
            "alias": self.alias
        }
    
    @classmethod
    def from_sol(cls, sol_data: Dict, sol_path: str = "") -> 'Account':
        """Create account from SOL file data"""
        now = sol_data.get("now", {})
        acc = cls(
            email=now.get("username", ""),
            password=now.get("password", ""),
            status="active" if now.get("autoLogin") else "inactive"
        )
        acc.server = now.get("server", "")
        acc.server_ip = now.get("serverIP", "")
        acc.sid = str(now.get("sid", ""))
        acc.proxy_port = now.get("proxyPort", "")
        acc.proxy_host = now.get("proxyHost", "")
        acc.sol_path = sol_path
        acc.alias = now.get("strserverAlias", "")
        return acc


class ETKManager:
    """Main ETK Account Manager"""
    
    def __init__(self):
        self.accounts: Dict[str, Account] = {}
        self.sol_files: List[Dict] = []
        self.csv_accounts: List[Dict] = []
        
    def load_csv_accounts(self, csv_path: Path = KHAN_ACCOUNTS_CSV) -> int:
        """Load accounts from khan_Accounts_556 CSV"""
        if not csv_path.exists():
            print(f"[!] CSV not found: {csv_path}")
            return 0
        
        count = 0
        with open(csv_path, 'r', encoding='utf-8', errors='ignore') as f:
            for line in f:
                parts = line.strip().split(',')
                if len(parts) >= 2:
                    email = parts[0].strip()
                    password = parts[1].strip()
                    
                    # Determine status
                    status = "active"
                    if password.lower() in ['active', 'inactive', 'not working']:
                        status = password.lower()
                        password = ""
                    
                    self.csv_accounts.append({
                        "email": email,
                        "password": password,
                        "status": status
                    })
                    
                    # Add to main accounts dict
                    if email not in self.accounts:
                        self.accounts[email] = Account(email, password, status)
                    count += 1
        
        return count
    
    def scan_sol_files(self, base_path: Path = None) -> List[Dict]:
        """Scan for all SOL files in a directory"""
        if base_path is None:
            # Scan both Macromedia backup and system folders
            paths_to_scan = [MACROMEDIA_PATH, SYSTEM_SHAREDOBJECTS]
        else:
            paths_to_scan = [base_path]
        
        sol_files = []
        for scan_path in paths_to_scan:
            if not scan_path.exists():
                continue
            
            for sol_file in scan_path.rglob("*.sol"):
                sol_files.append({
                    "path": str(sol_file),
                    "name": sol_file.name,
                    "size": sol_file.stat().st_size,
                    "modified": datetime.fromtimestamp(sol_file.stat().st_mtime).isoformat(),
                    "parent": sol_file.parent.name
                })
        
        self.sol_files = sol_files
        return sol_files
    
    def read_sol_file(self, sol_path: str) -> Optional[Dict]:
        """Read and parse a SOL file"""
        if not HAS_AMF:
            return None
        
        try:
            with open(sol_path, 'rb') as f:
                data = sol.load(f)
            return dict(data)
        except Exception as e:
            return {"error": str(e)}
    
    def extract_accounts_from_sol_files(self) -> int:
        """Extract account info from all discovered SOL files"""
        if not self.sol_files:
            self.scan_sol_files()
        
        count = 0
        for sol_info in self.sol_files:
            if sol_info["name"] != "config.sol":
                continue
            
            data = self.read_sol_file(sol_info["path"])
            if not data or "error" in data:
                continue
            
            if "now" in data and "username" in data["now"]:
                email = data["now"]["username"]
                account = Account.from_sol(data, sol_info["path"])
                
                # Update or add account
                if email in self.accounts:
                    # Merge data
                    existing = self.accounts[email]
                    if not existing.password and account.password:
                        existing.password = account.password
                    if account.sol_path:
                        existing.sol_path = account.sol_path
                    existing.server = account.server
                    existing.proxy_port = account.proxy_port
                else:
                    self.accounts[email] = account
                
                count += 1
        
        return count
    
    def scan_sol_backups(self, backup_path: Path = SOL_BACKUPS_PATH) -> Dict[str, List[str]]:
        """Scan SOL backup folders organized by account name"""
        backups = {}
        
        if not backup_path.exists():
            return backups
        
        for date_folder in backup_path.iterdir():
            if not date_folder.is_dir():
                continue
            
            for account_folder in date_folder.iterdir():
                if not account_folder.is_dir():
                    continue
                
                account_name = account_folder.name
                sol_files = list(account_folder.glob("*.sol"))
                
                if sol_files:
                    if account_name not in backups:
                        backups[account_name] = []
                    backups[account_name].extend([str(f) for f in sol_files])
        
        return backups
    
    def create_sol_file(self, account: Account, output_path: str) -> bool:
        """Create a new SOL file for an account"""
        if not HAS_AMF:
            return False
        
        try:
            # Create SOL data structure
            sol_data = {
                "now": {
                    "username": account.email,
                    "password": account.password,
                    "server": account.server or "cc2",
                    "serverIP": account.server_ip or "216.66.17.168",
                    "sid": account.sid or "375",
                    "proxyHost": account.proxy_host or "127.0.0.1",
                    "proxyPort": account.proxy_port or "9999",
                    "proxyType": "ss5",
                    "proxyUn": "",
                    "proxyPw": "",
                    "loginType": "ev",
                    "autoLogin": True,
                    "autoRun": True,
                    "autoScript": False,
                    "autoLoginMinTime": "0",
                    "autoLoginMaxTime": "3",
                    "theme": "Classic Blue RE",
                    "secCode": "",
                    "skypeUn": "",
                    "skypePw": "",
                    "strserverAlias": account.alias or "Parapet",
                    "tokenExpires": float('nan')
                }
            }
            
            # Ensure output directory exists
            os.makedirs(os.path.dirname(output_path), exist_ok=True)
            
            # Write SOL file
            with open(output_path, 'wb') as f:
                sol.save(sol_data, f, name="config")
            
            return True
        except Exception as e:
            print(f"[!] Error creating SOL: {e}")
            return False
    
    def batch_create_sol_files(self, accounts: List[Account], output_dir: str, node_start: int = 0) -> int:
        """Create SOL files for multiple accounts with node assignment"""
        created = 0
        port_base = 9999  # Ports go from 9999 down to 9949
        
        for i, account in enumerate(accounts):
            node = node_start + (i % 50)  # 50 nodes available
            port = port_base - node
            
            account.proxy_port = str(port)
            account.proxy_host = "127.0.0.1"
            
            # Create folder structure like ETK expects
            safe_email = account.email.replace("@", "_at_").replace(".", "_")
            sol_path = os.path.join(output_dir, safe_email, "roboevony.exe", "config.sol")
            
            if self.create_sol_file(account, sol_path):
                created += 1
                account.sol_path = sol_path
        
        return created
    
    def export_accounts(self, output_file: str = None) -> str:
        """Export all accounts to JSON"""
        if output_file is None:
            output_file = str(ETK_ROOT / "tools" / f"accounts_export_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json")
        
        export_data = {
            "exported": datetime.now().isoformat(),
            "total_accounts": len(self.accounts),
            "accounts": [acc.to_dict() for acc in self.accounts.values()]
        }
        
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(export_data, f, indent=2)
        
        return output_file
    
    def get_stats(self) -> Dict:
        """Get statistics about loaded accounts"""
        active = sum(1 for a in self.accounts.values() if a.status == "active")
        with_password = sum(1 for a in self.accounts.values() if a.password)
        with_sol = sum(1 for a in self.accounts.values() if a.sol_path)
        
        return {
            "total_accounts": len(self.accounts),
            "active": active,
            "inactive": len(self.accounts) - active,
            "with_password": with_password,
            "with_sol_file": with_sol,
            "csv_accounts": len(self.csv_accounts),
            "sol_files_found": len(self.sol_files)
        }
    
    def assign_nodes(self, accounts: List[Account] = None) -> Dict[int, List[Account]]:
        """Assign accounts to nodes (0-49) for proxy routing"""
        if accounts is None:
            accounts = list(self.accounts.values())
        
        nodes = {i: [] for i in range(50)}
        
        for i, account in enumerate(accounts):
            node = i % 50
            nodes[node].append(account)
            account.proxy_port = str(9999 - node)
        
        return nodes


def main():
    print("=" * 60)
    print("  ETK Account Manager")
    print("  Evony Age II - 556+ Account Management")
    print("=" * 60)
    print()
    
    manager = ETKManager()
    
    # Load CSV accounts
    print("[*] Loading accounts from CSV...")
    csv_count = manager.load_csv_accounts()
    print(f"[+] Loaded {csv_count} accounts from CSV")
    
    # Scan SOL files
    print("\n[*] Scanning for SOL files...")
    sol_files = manager.scan_sol_files()
    print(f"[+] Found {len(sol_files)} SOL files")
    
    config_sols = [f for f in sol_files if f["name"] == "config.sol"]
    print(f"[+] Found {len(config_sols)} config.sol files (account data)")
    
    # Extract accounts from SOL files
    print("\n[*] Extracting accounts from SOL files...")
    sol_count = manager.extract_accounts_from_sol_files()
    print(f"[+] Extracted {sol_count} accounts from SOL files")
    
    # Scan backups
    print("\n[*] Scanning SOL backups...")
    backups = manager.scan_sol_backups()
    print(f"[+] Found backups for {len(backups)} accounts")
    
    # Stats
    stats = manager.get_stats()
    print("\n" + "=" * 40)
    print("  ACCOUNT STATISTICS")
    print("=" * 40)
    for key, value in stats.items():
        print(f"  {key.replace('_', ' ').title()}: {value}")
    
    # Export accounts
    print("\n[*] Exporting accounts...")
    export_file = manager.export_accounts()
    print(f"[+] Exported to: {export_file}")
    
    # Show sample accounts
    print("\n[*] Sample accounts with credentials:")
    count = 0
    for email, acc in manager.accounts.items():
        if acc.password and acc.password not in ['active', 'inactive']:
            print(f"    {email}: {acc.server or 'cc2'} (port {acc.proxy_port or 'N/A'})")
            count += 1
            if count >= 10:
                break
    
    print(f"\n[+] Done! Total unique accounts: {len(manager.accounts)}")
    
    return manager


if __name__ == "__main__":
    manager = main()
