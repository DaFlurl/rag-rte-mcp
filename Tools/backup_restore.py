#!/usr/bin/env python3
"""
Evony Account Backup & Restore Tool
Manages Flash SharedObjects for account migration between PCs
"""
import os
import sys
import json
import shutil
import zipfile
from datetime import datetime
from pathlib import Path

# Paths
SHAREDOBJECTS_PATH = os.path.expandvars(
    r"%AppData%\Macromedia\Flash Player\#SharedObjects"
)
BACKUP_DIR = r"D:\EvonyToolKit\backups"
TOOLS_DIR = r"D:\EvonyToolKit\tools"

class AccountBackupRestore:
    """Backup and restore Flash SharedObjects for Evony accounts"""
    
    def __init__(self):
        self.so_path = SHAREDOBJECTS_PATH
        self.backup_dir = BACKUP_DIR
        os.makedirs(self.backup_dir, exist_ok=True)
    
    def get_unique_folder_id(self):
        """Get the unique folder ID for this PC"""
        if os.path.exists(self.so_path):
            folders = [f for f in os.listdir(self.so_path) 
                      if os.path.isdir(os.path.join(self.so_path, f))]
            if folders:
                return folders[0]  # Usually only one folder
        return None
    
    def get_all_sol_files(self, folder_id=None):
        """Get all SOL files from SharedObjects folder"""
        if folder_id is None:
            folder_id = self.get_unique_folder_id()
        
        if not folder_id:
            return []
        
        base_path = os.path.join(self.so_path, folder_id)
        sol_files = []
        
        for root, dirs, files in os.walk(base_path):
            for file in files:
                if file.endswith('.sol'):
                    full_path = os.path.join(root, file)
                    rel_path = os.path.relpath(full_path, base_path)
                    sol_files.append({
                        'full_path': full_path,
                        'relative_path': rel_path,
                        'size': os.path.getsize(full_path),
                        'modified': datetime.fromtimestamp(os.path.getmtime(full_path)).isoformat()
                    })
        
        return sol_files
    
    def create_backup(self, backup_name=None, include_all=False):
        """Create a backup of all Evony-related SOL files"""
        folder_id = self.get_unique_folder_id()
        if not folder_id:
            return {'success': False, 'error': 'No SharedObjects folder found'}
        
        if backup_name is None:
            backup_name = f"evony_backup_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
        
        backup_path = os.path.join(self.backup_dir, backup_name)
        os.makedirs(backup_path, exist_ok=True)
        
        # Get all SOL files
        sol_files = self.get_all_sol_files(folder_id)
        
        if not include_all:
            # Filter for Evony-related files only
            evony_keywords = ['evony', 'robo', 'autoevony', 'yaeb', 'config']
            sol_files = [f for f in sol_files if any(
                kw in f['relative_path'].lower() for kw in evony_keywords
            )]
        
        # Copy files preserving directory structure
        copied = []
        for f in sol_files:
            dest_path = os.path.join(backup_path, 'data', f['relative_path'])
            os.makedirs(os.path.dirname(dest_path), exist_ok=True)
            shutil.copy2(f['full_path'], dest_path)
            copied.append(f['relative_path'])
        
        # Save metadata
        metadata = {
            'created': datetime.now().isoformat(),
            'source_folder_id': folder_id,
            'source_path': self.so_path,
            'file_count': len(copied),
            'files': copied
        }
        
        with open(os.path.join(backup_path, 'metadata.json'), 'w') as f:
            json.dump(metadata, f, indent=2)
        
        # Create ZIP archive
        zip_path = backup_path + '.zip'
        with zipfile.ZipFile(zip_path, 'w', zipfile.ZIP_DEFLATED) as zf:
            for root, dirs, files in os.walk(backup_path):
                for file in files:
                    file_path = os.path.join(root, file)
                    arcname = os.path.relpath(file_path, backup_path)
                    zf.write(file_path, arcname)
        
        return {
            'success': True,
            'backup_folder': backup_path,
            'backup_zip': zip_path,
            'files_backed_up': len(copied),
            'source_folder_id': folder_id
        }
    
    def list_backups(self):
        """List all available backups"""
        backups = []
        if os.path.exists(self.backup_dir):
            for item in os.listdir(self.backup_dir):
                item_path = os.path.join(self.backup_dir, item)
                
                # Check for folder backups
                if os.path.isdir(item_path):
                    meta_path = os.path.join(item_path, 'metadata.json')
                    if os.path.exists(meta_path):
                        with open(meta_path) as f:
                            meta = json.load(f)
                        backups.append({
                            'name': item,
                            'type': 'folder',
                            'path': item_path,
                            'created': meta.get('created'),
                            'file_count': meta.get('file_count', 0)
                        })
                
                # Check for ZIP backups
                elif item.endswith('.zip'):
                    backups.append({
                        'name': item,
                        'type': 'zip',
                        'path': item_path,
                        'size': os.path.getsize(item_path)
                    })
        
        return backups
    
    def restore_backup(self, backup_path, target_folder_id=None):
        """Restore a backup to the SharedObjects folder"""
        if target_folder_id is None:
            target_folder_id = self.get_unique_folder_id()
        
        if not target_folder_id:
            return {'success': False, 'error': 'No target folder ID. Create a SharedObjects folder first by running a Flash app.'}
        
        target_base = os.path.join(self.so_path, target_folder_id)
        
        # Handle ZIP files
        if backup_path.endswith('.zip'):
            extract_path = backup_path[:-4] + '_extracted'
            with zipfile.ZipFile(backup_path, 'r') as zf:
                zf.extractall(extract_path)
            backup_path = extract_path
        
        # Find data folder
        data_path = os.path.join(backup_path, 'data')
        if not os.path.exists(data_path):
            return {'success': False, 'error': 'Invalid backup: no data folder found'}
        
        # Copy files
        restored = []
        for root, dirs, files in os.walk(data_path):
            for file in files:
                src_path = os.path.join(root, file)
                rel_path = os.path.relpath(src_path, data_path)
                dest_path = os.path.join(target_base, rel_path)
                
                os.makedirs(os.path.dirname(dest_path), exist_ok=True)
                shutil.copy2(src_path, dest_path)
                restored.append(rel_path)
        
        return {
            'success': True,
            'files_restored': len(restored),
            'target_folder': target_base,
            'files': restored
        }
    
    def export_accounts_to_json(self, output_file=None):
        """Export all account credentials to a JSON file"""
        try:
            from py3amf import sol
        except ImportError:
            return {'success': False, 'error': 'py3amf not installed'}
        
        if output_file is None:
            output_file = os.path.join(self.backup_dir, f"accounts_export_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json")
        
        accounts = []
        sol_files = self.get_all_sol_files()
        
        # Filter for config.sol files
        config_files = [f for f in sol_files if 'config.sol' in f['relative_path'].lower()]
        
        for f in config_files:
            try:
                with open(f['full_path'], 'rb') as file:
                    data = sol.load(file)
                
                account_data = {
                    'source_file': f['relative_path'],
                    'data': {}
                }
                
                # Extract account info
                if hasattr(data, 'items'):
                    for key, value in data.items():
                        if isinstance(value, dict):
                            account_data['data'][key] = value
                        else:
                            account_data['data'][key] = str(value)
                
                accounts.append(account_data)
            except Exception as e:
                accounts.append({
                    'source_file': f['relative_path'],
                    'error': str(e)
                })
        
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(accounts, f, indent=2, default=str)
        
        return {
            'success': True,
            'output_file': output_file,
            'accounts_found': len(accounts)
        }


def main():
    print("=" * 60)
    print("  Evony Account Backup & Restore Tool")
    print("=" * 60)
    print()
    
    tool = AccountBackupRestore()
    
    # Show current status
    folder_id = tool.get_unique_folder_id()
    print(f"[+] SharedObjects folder ID: {folder_id or 'NOT FOUND'}")
    print(f"[+] Backup directory: {tool.backup_dir}")
    print()
    
    # Get SOL files
    sol_files = tool.get_all_sol_files()
    print(f"[+] Found {len(sol_files)} SOL file(s)")
    
    # Filter for Evony
    evony_files = [f for f in sol_files if 'evony' in f['relative_path'].lower() 
                   or 'robo' in f['relative_path'].lower()
                   or 'config' in f['relative_path'].lower()]
    print(f"[+] Evony-related files: {len(evony_files)}")
    
    if not sol_files:
        print("[!] No SOL files found. Run RoboEvony first to create them.")
        return
    
    # Create backup
    print("\n[*] Creating backup...")
    result = tool.create_backup()
    
    if result['success']:
        print(f"[+] Backup created successfully!")
        print(f"    Folder: {result['backup_folder']}")
        print(f"    ZIP: {result['backup_zip']}")
        print(f"    Files: {result['files_backed_up']}")
    else:
        print(f"[-] Backup failed: {result.get('error')}")
    
    # Export accounts
    print("\n[*] Exporting account credentials...")
    export_result = tool.export_accounts_to_json()
    
    if export_result['success']:
        print(f"[+] Exported {export_result['accounts_found']} account(s)")
        print(f"    File: {export_result['output_file']}")
    else:
        print(f"[-] Export failed: {export_result.get('error')}")
    
    # List backups
    print("\n[+] Available backups:")
    backups = tool.list_backups()
    for b in backups:
        print(f"    - {b['name']} ({b['type']})")
    
    print("\n[*] Done!")
    print("\nTo restore on a new PC:")
    print("  1. Copy the .zip backup file to the new PC")
    print("  2. Run RoboEvony once to create the SharedObjects folder")
    print("  3. Run this tool with --restore <backup.zip>")


if __name__ == "__main__":
    if len(sys.argv) > 1:
        tool = AccountBackupRestore()
        
        if sys.argv[1] == '--restore' and len(sys.argv) > 2:
            print(f"Restoring from: {sys.argv[2]}")
            result = tool.restore_backup(sys.argv[2])
            print(json.dumps(result, indent=2))
        
        elif sys.argv[1] == '--list':
            backups = tool.list_backups()
            for b in backups:
                print(f"{b['name']}: {b.get('file_count', 'N/A')} files")
        
        elif sys.argv[1] == '--export':
            result = tool.export_accounts_to_json()
            print(json.dumps(result, indent=2))
        
        else:
            print("Usage:")
            print("  python backup_restore.py          # Create backup")
            print("  python backup_restore.py --restore <backup.zip>")
            print("  python backup_restore.py --list   # List backups")
            print("  python backup_restore.py --export # Export accounts to JSON")
    else:
        main()
