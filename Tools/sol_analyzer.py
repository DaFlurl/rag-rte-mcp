#!/usr/bin/env python3
"""
Comprehensive SOL File Analyzer for Evony Age II
Extracts ALL data from SOL files and presents in plain English
- Account credentials (login/password)
- Scripts and automation settings
- City configurations
- Troop data
- Game settings
"""
import os
import sys
import json
import re
from pathlib import Path
from datetime import datetime
from collections import defaultdict
from typing import Dict, List, Any, Optional

try:
    import pyamf.sol as sol
    HAS_AMF = True
except ImportError:
    HAS_AMF = False
    print("[!] Install pyamf: pip install Py3AMF")
    sys.exit(1)

# Paths
ETK_ROOT = Path(r"D:\EvonyToolKit")
MACROMEDIA_PATH = ETK_ROOT / "Macromedia"
OUTPUT_DIR = ETK_ROOT / "sol_analysis"

class SOLAnalyzer:
    """Comprehensive SOL file analyzer"""
    
    def __init__(self, base_path: Path = MACROMEDIA_PATH):
        self.base_path = base_path
        self.sol_files: List[Dict] = []
        self.accounts: Dict[str, Dict] = {}
        self.scripts: List[Dict] = []
        self.city_configs: List[Dict] = []
        self.troop_data: List[Dict] = []
        self.game_settings: List[Dict] = []
        self.raw_data: Dict[str, Any] = {}
        
    def scan_all_sol_files(self) -> int:
        """Find all SOL files in the Macromedia folder"""
        count = 0
        for sol_file in self.base_path.rglob("*.sol"):
            try:
                info = {
                    "path": str(sol_file),
                    "name": sol_file.name,
                    "size": sol_file.stat().st_size,
                    "parent": sol_file.parent.name,
                    "full_parent": str(sol_file.parent),
                }
                self.sol_files.append(info)
                count += 1
            except Exception as e:
                pass
        return count
    
    def read_sol_file(self, path: str) -> Optional[Dict]:
        """Read and parse a SOL file"""
        try:
            with open(path, 'rb') as f:
                data = sol.load(f)
            return dict(data)
        except Exception as e:
            return {"_error": str(e)}
    
    def extract_all_data(self) -> Dict:
        """Extract all data from all SOL files"""
        results = {
            "total_files": len(self.sol_files),
            "processed": 0,
            "errors": 0,
            "accounts_found": 0,
            "scripts_found": 0,
            "configs_found": 0
        }
        
        for sol_info in self.sol_files:
            path = sol_info["path"]
            name = sol_info["name"]
            
            data = self.read_sol_file(path)
            if not data or "_error" in data:
                results["errors"] += 1
                continue
            
            results["processed"] += 1
            
            # Store raw data
            self.raw_data[path] = {
                "file": name,
                "parent": sol_info["parent"],
                "data": data
            }
            
            # Categorize by file type
            if name == "config.sol":
                self._process_config_sol(data, sol_info)
                results["accounts_found"] += 1
            elif "script" in name.lower() or "goal" in name.lower():
                self._process_script_sol(data, sol_info)
                results["scripts_found"] += 1
            elif "army" in name.lower() or "troop" in name.lower():
                self._process_troop_sol(data, sol_info)
            elif "city" in name.lower():
                self._process_city_sol(data, sol_info)
                results["configs_found"] += 1
            else:
                # Generic processing - look for useful data
                self._process_generic_sol(data, sol_info)
        
        return results
    
    def _process_config_sol(self, data: Dict, info: Dict):
        """Extract account credentials from config.sol"""
        now = data.get("now", {})
        
        if not now:
            # Try other common keys
            for key in data.keys():
                if isinstance(data[key], dict):
                    now = data[key]
                    break
        
        email = now.get("username", "")
        password = now.get("password", "")
        
        if email:
            account = {
                "email": email,
                "password": password,
                "server": now.get("server", ""),
                "server_ip": now.get("serverIP", ""),
                "server_alias": now.get("strserverAlias", ""),
                "sid": now.get("sid", ""),
                "proxy_host": now.get("proxyHost", ""),
                "proxy_port": now.get("proxyPort", ""),
                "proxy_type": now.get("proxyType", ""),
                "auto_login": now.get("autoLogin", False),
                "auto_run": now.get("autoRun", False),
                "auto_script": now.get("autoScript", False),
                "theme": now.get("theme", ""),
                "login_type": now.get("loginType", ""),
                "source_file": info["path"],
                "account_folder": info["parent"]
            }
            
            # Use email as key, update if we have more complete data
            if email not in self.accounts or (password and not self.accounts[email].get("password")):
                self.accounts[email] = account
    
    def _process_script_sol(self, data: Dict, info: Dict):
        """Extract script data"""
        script_info = {
            "source_file": info["path"],
            "parent": info["parent"],
            "content": {}
        }
        
        # Try to find script content
        for key, value in data.items():
            if isinstance(value, str) and len(value) > 20:
                script_info["content"][key] = value
            elif isinstance(value, dict):
                script_info["content"][key] = self._flatten_dict(value)
        
        if script_info["content"]:
            self.scripts.append(script_info)
    
    def _process_troop_sol(self, data: Dict, info: Dict):
        """Extract troop configuration data"""
        troop_info = {
            "source_file": info["path"],
            "parent": info["parent"],
            "data": self._flatten_dict(data)
        }
        self.troop_data.append(troop_info)
    
    def _process_city_sol(self, data: Dict, info: Dict):
        """Extract city configuration data"""
        city_info = {
            "source_file": info["path"],
            "parent": info["parent"],
            "data": self._flatten_dict(data)
        }
        self.city_configs.append(city_info)
    
    def _process_generic_sol(self, data: Dict, info: Dict):
        """Process generic SOL files looking for useful data"""
        # Look for account-like data
        for key, value in data.items():
            if isinstance(value, dict):
                if "username" in value or "password" in value or "email" in value:
                    self._process_config_sol({key: value}, info)
                elif any(k in str(value).lower() for k in ["script", "goal", "action"]):
                    self._process_script_sol({key: value}, info)
    
    def _flatten_dict(self, d: Any, prefix: str = "") -> Dict:
        """Flatten nested dict for easier reading"""
        items = {}
        if isinstance(d, dict):
            for k, v in d.items():
                new_key = f"{prefix}.{k}" if prefix else k
                if isinstance(v, dict):
                    items.update(self._flatten_dict(v, new_key))
                elif isinstance(v, (list, tuple)):
                    items[new_key] = str(v)[:500]
                else:
                    items[new_key] = v
        return items
    
    def generate_plain_english_report(self) -> str:
        """Generate a plain English summary report"""
        lines = []
        lines.append("=" * 80)
        lines.append("  EVONY SOL FILE ANALYSIS REPORT")
        lines.append(f"  Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        lines.append("=" * 80)
        lines.append("")
        
        # Summary
        lines.append("## SUMMARY")
        lines.append("-" * 40)
        lines.append(f"Total SOL files scanned: {len(self.sol_files)}")
        lines.append(f"Accounts found: {len(self.accounts)}")
        lines.append(f"Scripts found: {len(self.scripts)}")
        lines.append(f"City configs found: {len(self.city_configs)}")
        lines.append(f"Troop configs found: {len(self.troop_data)}")
        lines.append("")
        
        # Accounts Section
        lines.append("=" * 80)
        lines.append("## ACCOUNT CREDENTIALS")
        lines.append("=" * 80)
        lines.append("")
        
        accounts_with_pass = [(e, a) for e, a in self.accounts.items() if a.get("password")]
        accounts_no_pass = [(e, a) for e, a in self.accounts.items() if not a.get("password")]
        
        lines.append(f"### Accounts WITH Passwords ({len(accounts_with_pass)}):")
        lines.append("-" * 40)
        for email, acc in sorted(accounts_with_pass, key=lambda x: x[0]):
            lines.append(f"\n  Email: {email}")
            lines.append(f"  Password: {acc['password']}")
            lines.append(f"  Server: {acc['server']} ({acc['server_alias']})")
            lines.append(f"  Proxy: {acc['proxy_host']}:{acc['proxy_port']} ({acc['proxy_type']})")
            lines.append(f"  Auto-Login: {'Yes' if acc['auto_login'] else 'No'}")
            lines.append(f"  Source: {acc['account_folder']}")
        
        lines.append(f"\n\n### Accounts WITHOUT Passwords ({len(accounts_no_pass)}):")
        lines.append("-" * 40)
        for email, acc in sorted(accounts_no_pass, key=lambda x: x[0])[:20]:
            lines.append(f"  - {email} (Server: {acc['server']})")
        if len(accounts_no_pass) > 20:
            lines.append(f"  ... and {len(accounts_no_pass) - 20} more")
        
        # Scripts Section
        if self.scripts:
            lines.append("\n\n" + "=" * 80)
            lines.append("## SCRIPTS AND AUTOMATION")
            lines.append("=" * 80)
            
            for i, script in enumerate(self.scripts[:10], 1):
                lines.append(f"\n### Script {i} (from: {script['parent']})")
                lines.append("-" * 40)
                for key, value in script["content"].items():
                    if isinstance(value, str) and len(value) > 200:
                        lines.append(f"  {key}:")
                        lines.append(f"    {value[:200]}...")
                    else:
                        lines.append(f"  {key}: {value}")
            
            if len(self.scripts) > 10:
                lines.append(f"\n... and {len(self.scripts) - 10} more scripts")
        
        # Troop Data
        if self.troop_data:
            lines.append("\n\n" + "=" * 80)
            lines.append("## TROOP CONFIGURATIONS")
            lines.append("=" * 80)
            
            for i, troop in enumerate(self.troop_data[:5], 1):
                lines.append(f"\n### Troop Config {i} (from: {troop['parent']})")
                lines.append("-" * 40)
                for key, value in list(troop["data"].items())[:10]:
                    lines.append(f"  {key}: {value}")
        
        # City Configs
        if self.city_configs:
            lines.append("\n\n" + "=" * 80)
            lines.append("## CITY CONFIGURATIONS")
            lines.append("=" * 80)
            
            for i, city in enumerate(self.city_configs[:5], 1):
                lines.append(f"\n### City Config {i} (from: {city['parent']})")
                lines.append("-" * 40)
                for key, value in list(city["data"].items())[:10]:
                    lines.append(f"  {key}: {value}")
        
        # All unique data keys found
        lines.append("\n\n" + "=" * 80)
        lines.append("## ALL DATA TYPES FOUND")
        lines.append("=" * 80)
        
        all_keys = set()
        for path, info in self.raw_data.items():
            if isinstance(info["data"], dict):
                all_keys.update(info["data"].keys())
        
        lines.append(f"\nUnique data keys across all SOL files ({len(all_keys)}):")
        for key in sorted(all_keys):
            lines.append(f"  - {key}")
        
        return "\n".join(lines)
    
    def export_all_data(self, output_dir: Path = OUTPUT_DIR):
        """Export all extracted data to files"""
        output_dir.mkdir(parents=True, exist_ok=True)
        
        # Export accounts
        accounts_file = output_dir / "accounts_extracted.json"
        with open(accounts_file, 'w', encoding='utf-8') as f:
            json.dump(self.accounts, f, indent=2, default=str)
        print(f"[+] Accounts: {accounts_file}")
        
        # Export accounts as CSV for easy review
        accounts_csv = output_dir / "accounts_extracted.csv"
        with open(accounts_csv, 'w', encoding='utf-8') as f:
            f.write("Email,Password,Server,ServerAlias,ProxyPort,AutoLogin,Source\n")
            for email, acc in sorted(self.accounts.items()):
                f.write(f"{email},{acc.get('password','')},{acc.get('server','')},{acc.get('server_alias','')},{acc.get('proxy_port','')},{acc.get('auto_login','')},{acc.get('account_folder','')}\n")
        print(f"[+] Accounts CSV: {accounts_csv}")
        
        # Export scripts
        if self.scripts:
            scripts_file = output_dir / "scripts_extracted.json"
            with open(scripts_file, 'w', encoding='utf-8') as f:
                json.dump(self.scripts, f, indent=2, default=str)
            print(f"[+] Scripts: {scripts_file}")
        
        # Export plain English report
        report_file = output_dir / "analysis_report.txt"
        with open(report_file, 'w', encoding='utf-8') as f:
            f.write(self.generate_plain_english_report())
        print(f"[+] Report: {report_file}")
        
        # Export raw data (for deep analysis)
        raw_file = output_dir / "all_sol_data_raw.json"
        with open(raw_file, 'w', encoding='utf-8') as f:
            json.dump(self.raw_data, f, indent=2, default=str)
        print(f"[+] Raw data: {raw_file}")
        
        return output_dir


def main():
    print("=" * 60)
    print("  Comprehensive SOL File Analyzer")
    print("  Extracting ALL data in Plain English")
    print("=" * 60)
    print()
    
    analyzer = SOLAnalyzer(MACROMEDIA_PATH)
    
    # Scan for SOL files
    print(f"[*] Scanning: {MACROMEDIA_PATH}")
    count = analyzer.scan_all_sol_files()
    print(f"[+] Found {count} SOL files")
    
    # Extract all data
    print("\n[*] Extracting data from all SOL files...")
    results = analyzer.extract_all_data()
    print(f"[+] Processed: {results['processed']} files")
    print(f"[+] Errors: {results['errors']}")
    print(f"[+] Accounts found: {results['accounts_found']}")
    print(f"[+] Scripts found: {results['scripts_found']}")
    print(f"[+] Configs found: {results['configs_found']}")
    
    # Export all data
    print("\n[*] Exporting data...")
    output_dir = analyzer.export_all_data()
    
    # Show summary
    print("\n" + "=" * 60)
    print("  EXTRACTION COMPLETE")
    print("=" * 60)
    print(f"\nTotal unique accounts: {len(analyzer.accounts)}")
    
    with_pass = sum(1 for a in analyzer.accounts.values() if a.get("password"))
    print(f"Accounts with passwords: {with_pass}")
    
    print(f"\nOutput directory: {output_dir}")
    print("\nFiles created:")
    print("  - accounts_extracted.json  (all account data)")
    print("  - accounts_extracted.csv   (easy spreadsheet view)")
    print("  - scripts_extracted.json   (automation scripts)")
    print("  - analysis_report.txt      (PLAIN ENGLISH REPORT)")
    print("  - all_sol_data_raw.json    (complete raw data)")
    
    print("\n[!] Open analysis_report.txt for plain English summary!")


if __name__ == "__main__":
    main()
