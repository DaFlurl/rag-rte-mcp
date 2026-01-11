"""
Evony Account Manager - Import/Export/Scan Tool
- Scan all Macromedia backup locations
- Extract zipped/rared backups
- Compare duplicates, keep version with most data
- Change drive letter and folder name
- Import/export between locations
"""
import os
import sys
import json
import shutil
import zipfile
import subprocess
from pathlib import Path
from datetime import datetime
from collections import defaultdict

# Known Macromedia backup locations to scan
BACKUP_LOCATIONS = [
    r"C:\EvonyToolKit\Macromedia",
    r"C:\Users\Admin\AppData\Roaming\Macromedia\Flash Player\#SharedObjects",
    r"D:\evony\Macromedia_1-6-24_Borg (1-6-24)\Macromedia\Flash Player",
    r"D:\Evony_from_CentOS\Macromedia\Flash Player",
    r"D:\EvonyToolKit\Macromedia\Flash Player",
    r"D:\Users\Admin\AppData\Roaming\Macromedia\Flash Player",
    r"G:\C_Drive\Evony2\evony_etk2\Flash Player",
    r"G:\C_Drive\Evony2\Macromedia\Flash Player",
    r"G:\Github\Evonytoolkit\Macromedia\Flash Player",
    r"C:\Users\Admin\AppData\Roaming\Macromedia\Flash Player",
]

# Zip/rar files to extract
ARCHIVE_LOCATIONS = [
    r"C:\Users\Admin\AppData\Local\Temp\8c8abd83-4826-4014-9783-3ef61768bdb1_Flash Player.zip.db1",
    r"C:\Users\Admin\AppData\Local\Temp\8d8ac4d0-84ae-4fc1-ad9b-8324b0910752_Flash Player.zip.752",
]

CONFIG_FILE = Path(r"D:\EvonyToolKit\account_manager_config.json")
ACCOUNTS_FOLDER = Path(r"D:\EvonyToolKit\Accounts")

class AccountManager:
    def __init__(self):
        self.config = self.load_config()
        self.accounts = {}  # name -> {path, sol_count, size, has_config, has_scripts}
        self.all_found = []  # All account instances found
        
    def load_config(self):
        if CONFIG_FILE.exists():
            return json.loads(CONFIG_FILE.read_text())
        return {
            "drive_letter": "C",
            "folder_name": "evony",
            "accounts_folder": str(ACCOUNTS_FOLDER),
            "last_scan": None
        }
    
    def save_config(self):
        CONFIG_FILE.write_text(json.dumps(self.config, indent=2))
    
    def get_bot_path(self):
        """Get current bot folder path based on config"""
        return Path(f"{self.config['drive_letter']}:/{self.config['folder_name']}")
    
    def get_macromedia_path(self):
        """Get Macromedia SOL path for current config"""
        base = Path(r"C:\Users\Admin\AppData\Roaming\Macromedia\Flash Player\#SharedObjects")
        # Find the hash folder
        if base.exists():
            for item in base.iterdir():
                if item.is_dir() and not item.name.startswith('.'):
                    return item / "#localWithNet" / self.config['folder_name']
        return None
    
    def scan_location(self, path):
        """Scan a location for account folders with SOL files"""
        path = Path(path)
        if not path.exists():
            return []
        
        found = []
        
        # Look for #SharedObjects folder structure
        for root, dirs, files in os.walk(path):
            root_path = Path(root)
            
            # Look for config.sol files
            if "config.sol" in files:
                config_sol = root_path / "config.sol"
                
                # Get account name from parent folder structure
                # Usually: .../account_name/roboevony.exe/config.sol
                if root_path.name == "roboevony.exe":
                    account_name = root_path.parent.name
                else:
                    account_name = root_path.name
                
                # Count all SOL files in this account
                sol_files = list(root_path.glob("*.sol"))
                parent_sols = list(root_path.parent.glob("*.sol")) if root_path.parent.exists() else []
                
                total_sols = len(sol_files) + len(parent_sols)
                total_size = sum(f.stat().st_size for f in sol_files)
                
                # Check for scripts/goals (citygoals*.sol files)
                has_scripts = any("citygoals" in f.name or "citytab" in f.name for f in sol_files)
                
                found.append({
                    "name": account_name,
                    "path": str(root_path),
                    "config_path": str(config_sol),
                    "sol_count": total_sols,
                    "size": total_size,
                    "config_size": config_sol.stat().st_size if config_sol.exists() else 0,
                    "has_scripts": has_scripts,
                    "source": str(path)
                })
        
        return found
    
    def scan_all_backups(self):
        """Scan all known backup locations"""
        print("Scanning all Macromedia backup locations...")
        print()
        
        self.all_found = []
        
        for location in BACKUP_LOCATIONS:
            if Path(location).exists():
                print(f"  Scanning: {location[:60]}...")
                found = self.scan_location(location)
                self.all_found.extend(found)
                print(f"    Found {len(found)} accounts")
        
        print()
        print(f"Total accounts found: {len(self.all_found)}")
        
        # Group by account name
        by_name = defaultdict(list)
        for acc in self.all_found:
            by_name[acc["name"]].append(acc)
        
        print(f"Unique account names: {len(by_name)}")
        
        # Find best version of each account
        self.accounts = {}
        for name, versions in by_name.items():
            # Sort by: has_scripts, sol_count, config_size, size
            best = max(versions, key=lambda x: (
                x["has_scripts"],
                x["sol_count"],
                x["config_size"],
                x["size"]
            ))
            self.accounts[name] = best
        
        self.config["last_scan"] = datetime.now().isoformat()
        self.save_config()
        
        return self.accounts
    
    def extract_archives(self):
        """Extract zipped/rared backup files"""
        print("Extracting archive backups...")
        
        extract_dir = Path(r"D:\EvonyToolKit\ExtractedBackups")
        extract_dir.mkdir(parents=True, exist_ok=True)
        
        for archive in ARCHIVE_LOCATIONS:
            archive_path = Path(archive)
            if archive_path.exists():
                print(f"  Extracting: {archive_path.name}")
                try:
                    # Try as zip
                    with zipfile.ZipFile(archive_path, 'r') as zf:
                        dest = extract_dir / archive_path.stem
                        zf.extractall(dest)
                        print(f"    Extracted to: {dest}")
                except:
                    print(f"    Failed to extract (may need 7zip for rar)")
    
    def copy_best_accounts(self, dest_folder=None):
        """Copy best version of each account to Accounts folder"""
        if dest_folder is None:
            dest_folder = Path(self.config["accounts_folder"])
        else:
            dest_folder = Path(dest_folder)
        
        dest_folder.mkdir(parents=True, exist_ok=True)
        
        print(f"Copying best accounts to: {dest_folder}")
        
        count = 0
        for name, acc in self.accounts.items():
            if acc["config_size"] < 100:  # Skip empty configs
                continue
            
            src_path = Path(acc["path"])
            dst_path = dest_folder / name / "roboevony.exe"
            dst_path.mkdir(parents=True, exist_ok=True)
            
            # Copy all SOL files
            for sol_file in src_path.glob("*.sol"):
                shutil.copy2(sol_file, dst_path / sol_file.name)
            
            count += 1
            if count <= 10:
                scripts = "✓" if acc["has_scripts"] else "-"
                print(f"  [{scripts}] {name}: {acc['sol_count']} SOLs, {acc['config_size']}b config")
        
        if count > 10:
            print(f"  ... and {count - 10} more")
        
        print(f"\nCopied {count} accounts to {dest_folder}")
        return count
    
    def setup_drive(self, drive_letter, folder_name="evony"):
        """Setup bot folder on specified drive"""
        self.config["drive_letter"] = drive_letter.upper().rstrip(":")
        self.config["folder_name"] = folder_name
        self.save_config()
        
        bot_path = self.get_bot_path()
        bot_path.mkdir(parents=True, exist_ok=True)
        
        # Setup Macromedia path
        mac_base = Path(r"C:\Users\Admin\AppData\Roaming\Macromedia\Flash Player\#SharedObjects")
        if mac_base.exists():
            for hash_dir in mac_base.iterdir():
                if hash_dir.is_dir() and not hash_dir.name.startswith('.'):
                    mac_path = hash_dir / "#localWithNet" / folder_name
                    mac_path.mkdir(parents=True, exist_ok=True)
                    print(f"Created Macromedia path: {mac_path}")
        
        print(f"Bot folder: {bot_path}")
        return bot_path
    
    def import_to_drive(self, drive_letter, folder_name="evony"):
        """Import all best accounts to a new drive/folder"""
        self.setup_drive(drive_letter, folder_name)
        
        bot_path = self.get_bot_path()
        mac_path = self.get_macromedia_path()
        
        # Find source roboevony.exe
        robo_src = None
        for src in [Path(r"C:\evony"), Path(r"C:\evony2")]:
            if src.exists():
                for folder in src.iterdir():
                    exe = folder / "roboevony.exe"
                    if exe.exists():
                        robo_src = exe
                        break
                if robo_src:
                    break
        
        if not robo_src:
            print("ERROR: No roboevony.exe found to copy!")
            return 0
        
        print(f"Using roboevony.exe from: {robo_src}")
        print(f"Importing to: {bot_path}")
        print(f"Macromedia: {mac_path}")
        print()
        
        count = 0
        for name, acc in self.accounts.items():
            if acc["config_size"] < 100:
                continue
            
            # Create bot folder
            player_dir = bot_path / name
            player_dir.mkdir(parents=True, exist_ok=True)
            
            # Copy roboevony.exe
            exe_dst = player_dir / "roboevony.exe"
            if not exe_dst.exists():
                shutil.copy2(robo_src, exe_dst)
            
            # Copy SOL files to Macromedia
            if mac_path:
                sol_dst = mac_path / name / "roboevony.exe"
                sol_dst.mkdir(parents=True, exist_ok=True)
                
                src_path = Path(acc["path"])
                for sol_file in src_path.glob("*.sol"):
                    shutil.copy2(sol_file, sol_dst / sol_file.name)
            
            count += 1
        
        print(f"Imported {count} accounts to {drive_letter}:\\{folder_name}")
        return count
    
    def show_status(self):
        """Show current configuration and account status"""
        print("=" * 60)
        print("  ACCOUNT MANAGER STATUS")
        print("=" * 60)
        print()
        print(f"Drive Letter:    {self.config['drive_letter']}:")
        print(f"Folder Name:     {self.config['folder_name']}")
        print(f"Bot Path:        {self.get_bot_path()}")
        print(f"Macromedia Path: {self.get_macromedia_path()}")
        print(f"Accounts Folder: {self.config['accounts_folder']}")
        print(f"Last Scan:       {self.config.get('last_scan', 'Never')}")
        print()
        
        if self.accounts:
            valid = sum(1 for a in self.accounts.values() if a["config_size"] >= 100)
            with_scripts = sum(1 for a in self.accounts.values() if a["has_scripts"])
            print(f"Accounts Found:  {len(self.accounts)}")
            print(f"Valid (has login): {valid}")
            print(f"With Scripts:    {with_scripts}")
        print()

def main():
    mgr = AccountManager()
    
    if len(sys.argv) < 2:
        mgr.show_status()
        print("Commands:")
        print("  python account_manager.py scan          - Scan all backups")
        print("  python account_manager.py extract       - Extract zip/rar backups")
        print("  python account_manager.py copy          - Copy best accounts to Accounts folder")
        print("  python account_manager.py drive <X>     - Set drive letter (C, D, E, etc)")
        print("  python account_manager.py folder <name> - Set folder name")
        print("  python account_manager.py import <X>    - Import all to drive X")
        print("  python account_manager.py list          - List best accounts")
        return
    
    cmd = sys.argv[1].lower()
    
    if cmd == "scan":
        mgr.scan_all_backups()
    
    elif cmd == "extract":
        mgr.extract_archives()
    
    elif cmd == "copy":
        if not mgr.accounts:
            mgr.scan_all_backups()
        mgr.copy_best_accounts()
    
    elif cmd == "drive":
        if len(sys.argv) < 3:
            print("Usage: python account_manager.py drive <letter>")
            print("Example: python account_manager.py drive D")
            return
        mgr.setup_drive(sys.argv[2])
    
    elif cmd == "folder":
        if len(sys.argv) < 3:
            print("Usage: python account_manager.py folder <name>")
            return
        mgr.config["folder_name"] = sys.argv[2]
        mgr.save_config()
        print(f"Folder name set to: {sys.argv[2]}")
    
    elif cmd == "import":
        if len(sys.argv) < 3:
            print("Usage: python account_manager.py import <drive_letter>")
            print("Example: python account_manager.py import E")
            return
        if not mgr.accounts:
            mgr.scan_all_backups()
        folder = sys.argv[3] if len(sys.argv) > 3 else "evony"
        mgr.import_to_drive(sys.argv[2], folder)
    
    elif cmd == "list":
        if not mgr.accounts:
            mgr.scan_all_backups()
        
        print(f"\nBest version of each account ({len(mgr.accounts)} total):\n")
        valid = [(n, a) for n, a in mgr.accounts.items() if a["config_size"] >= 100]
        valid.sort(key=lambda x: (-x[1]["sol_count"], x[0]))
        
        for name, acc in valid[:50]:
            scripts = "✓" if acc["has_scripts"] else " "
            print(f"  [{scripts}] {name:30} SOLs:{acc['sol_count']:3} Config:{acc['config_size']:4}b")
        
        if len(valid) > 50:
            print(f"  ... and {len(valid) - 50} more")

if __name__ == "__main__":
    main()
