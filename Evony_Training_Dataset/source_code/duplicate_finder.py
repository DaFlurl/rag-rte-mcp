"""
ETK SOL Manager - Duplicate Account Finder
Identifies duplicate accounts across all sources
"""

import os
import json
from pathlib import Path
from typing import Dict, List, Set, Tuple, Any
from collections import defaultdict
from dataclasses import dataclass, field
import pyamf.sol


@dataclass
class DuplicateGroup:
    """Group of duplicate accounts"""
    email: str
    password: str = ""
    sources: List[str] = field(default_factory=list)
    sol_paths: List[str] = field(default_factory=list)
    servers: Set[str] = field(default_factory=set)
    has_password: bool = False
    
    @property
    def count(self) -> int:
        return len(self.sol_paths)


class DuplicateFinder:
    """
    Finds duplicate accounts across multiple sources:
    - SOL files in system Macromedia folder
    - SOL files in project Macromedia folder
    - CSV account lists
    - Backup folders
    """
    
    def __init__(self):
        self.accounts: Dict[str, DuplicateGroup] = {}
        self.all_sources: List[str] = []
        self.errors: List[str] = []
    
    def scan_sol_folder(self, folder_path: Path) -> int:
        """Scan a folder for config.sol files"""
        count = 0
        
        if not folder_path.exists():
            return 0
        
        for config_path in folder_path.rglob("config.sol"):
            try:
                with open(config_path, 'rb') as f:
                    result = pyamf.sol.decode(f)
                
                if isinstance(result, tuple) and len(result) >= 2:
                    data = result[1]
                else:
                    data = result
                
                if not isinstance(data, dict) or 'now' not in data:
                    continue
                
                now = data['now']
                email = now.get('username', '').strip().lower()
                password = now.get('password', '')
                server = now.get('server', 'cc2')
                
                if not email:
                    continue
                
                if email not in self.accounts:
                    self.accounts[email] = DuplicateGroup(
                        email=email,
                        password=password,
                        has_password=bool(password)
                    )
                
                group = self.accounts[email]
                group.sol_paths.append(str(config_path))
                group.servers.add(server)
                group.sources.append(str(folder_path))
                
                # Update password if we found one
                if password and not group.password:
                    group.password = password
                    group.has_password = True
                
                count += 1
                
            except Exception as e:
                self.errors.append(f"{config_path}: {e}")
        
        return count
    
    def scan_csv_file(self, csv_path: Path) -> int:
        """Scan a CSV file for accounts"""
        count = 0
        
        if not csv_path.exists():
            return 0
        
        try:
            with open(csv_path, 'r', encoding='utf-8', errors='ignore') as f:
                lines = f.readlines()
            
            # Try to detect format
            for line in lines[1:]:  # Skip header
                parts = line.strip().split(',')
                if len(parts) >= 2:
                    # Assume email, password format
                    email = parts[0].strip().lower()
                    password = parts[1].strip() if len(parts) > 1 else ""
                    
                    if '@' not in email:
                        continue
                    
                    if email not in self.accounts:
                        self.accounts[email] = DuplicateGroup(
                            email=email,
                            password=password,
                            has_password=bool(password)
                        )
                    
                    group = self.accounts[email]
                    group.sources.append(f"CSV:{csv_path.name}")
                    
                    if password and not group.password:
                        group.password = password
                        group.has_password = True
                    
                    count += 1
                    
        except Exception as e:
            self.errors.append(f"CSV {csv_path}: {e}")
        
        return count
    
    def scan_all_sources(self, 
                        system_macromedia: Path = None,
                        project_macromedia: Path = None,
                        csv_files: List[Path] = None,
                        backup_folders: List[Path] = None) -> Dict[str, int]:
        """Scan all sources and return counts"""
        results = {}
        
        # System Macromedia folder
        if system_macromedia is None:
            appdata = os.environ.get('APPDATA', '')
            system_macromedia = Path(appdata) / "Macromedia" / "Flash Player" / "#SharedObjects"
        
        if system_macromedia.exists():
            count = self.scan_sol_folder(system_macromedia)
            results["system_macromedia"] = count
            self.all_sources.append(str(system_macromedia))
        
        # Project Macromedia folder
        if project_macromedia is None:
            project_macromedia = Path(r"D:\EvonyToolKit\Macromedia\Flash Player\#SharedObjects")
        
        if project_macromedia.exists():
            count = self.scan_sol_folder(project_macromedia)
            results["project_macromedia"] = count
            self.all_sources.append(str(project_macromedia))
        
        # CSV files
        if csv_files:
            for csv_path in csv_files:
                if csv_path.exists():
                    count = self.scan_csv_file(csv_path)
                    results[f"csv_{csv_path.stem}"] = count
        
        # Default CSV location
        default_csv = Path(r"D:\EvonyToolKit\scripts\khan_Accounts_556\khanaccounts.csv")
        if default_csv.exists() and default_csv not in (csv_files or []):
            count = self.scan_csv_file(default_csv)
            results["khan_accounts_csv"] = count
        
        # Backup folders
        if backup_folders:
            for backup_path in backup_folders:
                if backup_path.exists():
                    count = self.scan_sol_folder(backup_path)
                    results[f"backup_{backup_path.name}"] = count
        
        return results
    
    def get_duplicates(self, min_count: int = 2) -> List[DuplicateGroup]:
        """Get accounts that appear in multiple locations"""
        return [
            group for group in self.accounts.values()
            if group.count >= min_count
        ]
    
    def get_unique_accounts(self) -> List[DuplicateGroup]:
        """Get all unique accounts"""
        return list(self.accounts.values())
    
    def get_accounts_with_passwords(self) -> List[DuplicateGroup]:
        """Get accounts that have passwords"""
        return [
            group for group in self.accounts.values()
            if group.has_password
        ]
    
    def get_accounts_without_passwords(self) -> List[DuplicateGroup]:
        """Get accounts without passwords"""
        return [
            group for group in self.accounts.values()
            if not group.has_password
        ]
    
    def get_summary(self) -> Dict[str, Any]:
        """Get summary statistics"""
        duplicates = self.get_duplicates()
        with_passwords = self.get_accounts_with_passwords()
        
        return {
            "total_unique_accounts": len(self.accounts),
            "accounts_with_passwords": len(with_passwords),
            "accounts_without_passwords": len(self.accounts) - len(with_passwords),
            "duplicate_accounts": len(duplicates),
            "total_sol_files": sum(g.count for g in self.accounts.values()),
            "sources_scanned": len(self.all_sources),
            "errors": len(self.errors)
        }
    
    def export_to_json(self, output_path: Path) -> bool:
        """Export results to JSON"""
        try:
            data = {
                "summary": self.get_summary(),
                "accounts": {
                    email: {
                        "email": group.email,
                        "has_password": group.has_password,
                        "servers": list(group.servers),
                        "sol_count": group.count,
                        "sources": group.sources[:5]  # Limit for readability
                    }
                    for email, group in sorted(self.accounts.items())
                }
            }
            
            output_path.parent.mkdir(parents=True, exist_ok=True)
            with open(output_path, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=2)
            
            return True
        except Exception as e:
            self.errors.append(f"Export error: {e}")
            return False
    
    def print_summary(self):
        """Print summary to console"""
        summary = self.get_summary()
        print("=" * 60)
        print("DUPLICATE FINDER SUMMARY")
        print("=" * 60)
        print(f"Total unique accounts: {summary['total_unique_accounts']}")
        print(f"Accounts WITH passwords: {summary['accounts_with_passwords']}")
        print(f"Accounts WITHOUT passwords: {summary['accounts_without_passwords']}")
        print(f"Duplicate accounts: {summary['duplicate_accounts']}")
        print(f"Total SOL files found: {summary['total_sol_files']}")
        print(f"Sources scanned: {summary['sources_scanned']}")
        print(f"Errors: {summary['errors']}")
        print()
