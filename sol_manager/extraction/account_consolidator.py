"""
ETK SOL Manager - Account Consolidator
Deduplicates and consolidates accounts from multiple SOL file locations
"""

import os
import json
from pathlib import Path
from typing import Dict, List, Optional, Tuple, Any
from datetime import datetime
import pyamf.sol

from ..data_models.account_data import AccountData, AccountCredentials, AccountStatus


class AccountConsolidator:
    """
    Consolidates accounts from multiple config.sol locations.
    
    Features:
    - Scans multiple Macromedia folders
    - Deduplicates by email
    - Merges data from multiple sources
    - Exports consolidated account list
    """
    
    def __init__(self):
        self.accounts: Dict[str, AccountData] = {}
        self.scan_paths: List[Path] = []
        self.errors: List[str] = []
        
    def add_scan_path(self, path: Path):
        """Add a path to scan for config.sol files"""
        if path.exists():
            self.scan_paths.append(path)
    
    def scan_all(self) -> int:
        """
        Scan all configured paths for config.sol files.
        Returns number of unique accounts found.
        """
        self.errors = []
        
        for scan_path in self.scan_paths:
            self._scan_path(scan_path)
        
        return len(self.accounts)
    
    def _scan_path(self, base_path: Path):
        """Scan a single path for config.sol files"""
        config_files = list(base_path.rglob("config.sol"))
        
        for config_path in config_files:
            try:
                self._process_config_sol(config_path)
            except Exception as e:
                self.errors.append(f"{config_path}: {e}")
    
    def _process_config_sol(self, config_path: Path):
        """Process a single config.sol file"""
        with open(config_path, 'rb') as f:
            result = pyamf.sol.decode(f)
        
        # Handle tuple return from pyamf.sol.decode
        if isinstance(result, tuple) and len(result) >= 2:
            data = result[1]
        else:
            data = result
        
        if not isinstance(data, dict) or 'now' not in data:
            return
        
        now = data['now']
        email = now.get('username', '').strip()
        password = now.get('password', '')
        
        if not email:
            return
        
        # Normalize email for deduplication
        email_key = email.lower()
        
        if email_key not in self.accounts:
            # Create new account
            credentials = AccountCredentials(
                email=email,
                password=password,
                server=now.get('server', 'cc2'),
                server_ip=now.get('serverIP', '216.66.17.35'),
                server_alias=now.get('strserverAlias', 'Parapet'),
                proxy_host=now.get('proxyHost', '127.0.0.1'),
                proxy_port=int(now.get('proxyPort', 8080) or 8080),
                proxy_type=now.get('proxyType', 'ss5')
            )
            
            account = AccountData(
                email=email,
                credentials=credentials,
                status=AccountStatus.VALID if password else AccountStatus.UNKNOWN
            )
            account.sol_paths.append(str(config_path))
            self.accounts[email_key] = account
        else:
            # Update existing account
            existing = self.accounts[email_key]
            existing.sol_paths.append(str(config_path))
            
            # Update password if we found one and didn't have it
            if password and existing.credentials and not existing.credentials.password:
                existing.credentials.password = password
                existing.status = AccountStatus.VALID
    
    def get_accounts_with_passwords(self) -> List[AccountData]:
        """Get all accounts that have passwords"""
        return [
            acc for acc in self.accounts.values()
            if acc.credentials and acc.credentials.password
        ]
    
    def get_accounts_without_passwords(self) -> List[AccountData]:
        """Get all accounts without passwords"""
        return [
            acc for acc in self.accounts.values()
            if not acc.credentials or not acc.credentials.password
        ]
    
    def get_duplicate_accounts(self) -> Dict[str, int]:
        """Get accounts with multiple SOL file copies"""
        return {
            email: len(acc.sol_paths)
            for email, acc in self.accounts.items()
            if len(acc.sol_paths) > 1
        }
    
    def export_to_json(self, output_path: Path) -> bool:
        """Export consolidated accounts to JSON"""
        try:
            data = {
                "generated": datetime.now().isoformat(),
                "total_accounts": len(self.accounts),
                "accounts_with_password": len(self.get_accounts_with_passwords()),
                "accounts": {
                    email: acc.to_dict()
                    for email, acc in sorted(self.accounts.items())
                }
            }
            
            output_path.parent.mkdir(parents=True, exist_ok=True)
            with open(output_path, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=2, default=str)
            
            return True
        except Exception as e:
            self.errors.append(f"Export failed: {e}")
            return False
    
    def export_credentials_csv(self, output_path: Path) -> bool:
        """Export credentials to CSV for easy viewing"""
        try:
            output_path.parent.mkdir(parents=True, exist_ok=True)
            
            with open(output_path, 'w', encoding='utf-8') as f:
                f.write("Email,Password,Server,ProxyPort,Status,Copies\n")
                
                for email, acc in sorted(self.accounts.items()):
                    if acc.credentials:
                        cred = acc.credentials
                        # Mask password for security
                        masked_pw = cred.password[:3] + "***" if cred.password else ""
                        f.write(f"{cred.email},{masked_pw},{cred.server},{cred.proxy_port},{acc.status.value},{len(acc.sol_paths)}\n")
            
            return True
        except Exception as e:
            self.errors.append(f"CSV export failed: {e}")
            return False
    
    def print_summary(self):
        """Print summary of consolidated accounts"""
        print("=" * 60)
        print("ACCOUNT CONSOLIDATION SUMMARY")
        print("=" * 60)
        print(f"Total unique accounts: {len(self.accounts)}")
        print(f"Accounts WITH passwords: {len(self.get_accounts_with_passwords())}")
        print(f"Accounts WITHOUT passwords: {len(self.get_accounts_without_passwords())}")
        print(f"Accounts with duplicates: {len(self.get_duplicate_accounts())}")
        print(f"Errors encountered: {len(self.errors)}")
        print()


def consolidate_accounts(
    system_path: Path = None,
    project_path: Path = None,
    output_dir: Path = None
) -> AccountConsolidator:
    """
    Convenience function to consolidate accounts from default locations.
    
    Args:
        system_path: System Macromedia path (default: %APPDATA%/Macromedia/...)
        project_path: Project Macromedia path (default: D:/EvonyToolKit/Macromedia/...)
        output_dir: Output directory for exports
    
    Returns:
        AccountConsolidator with scanned accounts
    """
    if system_path is None:
        appdata = os.environ.get('APPDATA', '')
        system_path = Path(appdata) / "Macromedia" / "Flash Player" / "#SharedObjects"
    
    if project_path is None:
        project_path = Path(r"D:\EvonyToolKit\Macromedia\Flash Player\#SharedObjects")
    
    if output_dir is None:
        output_dir = Path(r"D:\EvonyToolKit\data\accounts")
    
    consolidator = AccountConsolidator()
    
    # Add scan paths
    if system_path.exists():
        consolidator.add_scan_path(system_path)
    if project_path.exists():
        consolidator.add_scan_path(project_path)
    
    # Scan all paths
    consolidator.scan_all()
    
    # Export results
    consolidator.export_to_json(output_dir / "consolidated_accounts.json")
    consolidator.export_credentials_csv(output_dir / "account_credentials.csv")
    
    # Print summary
    consolidator.print_summary()
    
    return consolidator


if __name__ == "__main__":
    # Run consolidation
    consolidator = consolidate_accounts()
    
    # Show accounts with passwords
    print("\nAccounts with passwords:")
    for acc in sorted(consolidator.get_accounts_with_passwords(), key=lambda x: x.email.lower())[:20]:
        print(f"  {acc.email} | {acc.credentials.server}")
