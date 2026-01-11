"""
ETK SOL Manager - Backup Manager Module
Handles backup, rollback, timeline, and recovery features
"""

import os
import json
import shutil
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Any, Optional

from .config import BACKUP_PATH, MAX_BACKUPS_PER_ACCOUNT
from .utils import (
    safe_email_to_filename, 
    get_timestamp, 
    get_iso_timestamp,
    json_safe_dump
)


class BackupManager:
    """Handles backup, rollback, and timeline features with failsafes"""
    
    def __init__(self, backup_root: Path = None):
        self.backup_root = backup_root or BACKUP_PATH
        self.backup_root.mkdir(parents=True, exist_ok=True)
        self.max_backups = MAX_BACKUPS_PER_ACCOUNT
    
    def create_backup(self, account_email: str, sol_files: Dict[str, Any],
                      reason: str = "manual") -> tuple:
        """
        Create a backup before making changes - ALWAYS called before edits
        
        Args:
            account_email: Account email address
            sol_files: Dictionary of {sol_filename: data}
            reason: Reason for backup
            
        Returns:
            Tuple of (backup_path: str, success: bool)
        """
        timestamp = get_timestamp()
        safe_email = safe_email_to_filename(account_email)
        
        backup_dir = self.backup_root / safe_email / timestamp
        backup_dir.mkdir(parents=True, exist_ok=True)
        
        try:
            # Save all SOL data as JSON
            for filename, data in sol_files.items():
                if data is None:
                    continue
                backup_file = backup_dir / f"{filename}.json"
                with open(backup_file, 'w', encoding='utf-8') as f:
                    f.write(json_safe_dump(data))
            
            # Save metadata
            metadata = {
                "timestamp": timestamp,
                "account": account_email,
                "reason": reason,
                "files": list(sol_files.keys()),
                "created": get_iso_timestamp(),
                "file_count": len(sol_files)
            }
            with open(backup_dir / "metadata.json", 'w', encoding='utf-8') as f:
                json.dump(metadata, f, indent=2)
            
            # Cleanup old backups
            self._cleanup_old_backups(safe_email)
            
            return str(backup_dir), True
            
        except Exception as e:
            # Clean up failed backup attempt
            if backup_dir.exists():
                shutil.rmtree(backup_dir, ignore_errors=True)
            return str(e), False
    
    def get_timeline(self, account_email: str) -> List[Dict]:
        """
        Get backup timeline for an account
        
        Args:
            account_email: Account email address
            
        Returns:
            List of backup metadata dictionaries, newest first
        """
        safe_email = safe_email_to_filename(account_email)
        account_dir = self.backup_root / safe_email
        
        if not account_dir.exists():
            return []
        
        timeline = []
        for backup_dir in sorted(account_dir.iterdir(), reverse=True):
            if not backup_dir.is_dir():
                continue
                
            metadata_file = backup_dir / "metadata.json"
            if metadata_file.exists():
                try:
                    with open(metadata_file, 'r', encoding='utf-8') as f:
                        metadata = json.load(f)
                    metadata["path"] = str(backup_dir)
                    metadata["size"] = self._get_backup_size(backup_dir)
                    timeline.append(metadata)
                except Exception:
                    # Skip corrupted metadata
                    continue
        
        return timeline
    
    def restore_backup(self, backup_path: str) -> tuple:
        """
        Restore SOL data from a backup
        
        Args:
            backup_path: Path to backup directory
            
        Returns:
            Tuple of (data: Dict[str, Any], success: bool)
        """
        backup_dir = Path(backup_path)
        
        if not backup_dir.exists():
            return {"_error": "Backup not found"}, False
        
        restored_data = {}
        
        try:
            for json_file in backup_dir.glob("*.json"):
                if json_file.name == "metadata.json":
                    continue
                    
                with open(json_file, 'r', encoding='utf-8') as f:
                    restored_data[json_file.stem] = json.load(f)
            
            return restored_data, True
            
        except Exception as e:
            return {"_error": str(e)}, False
    
    def delete_backup(self, backup_path: str) -> bool:
        """Delete a specific backup"""
        try:
            backup_dir = Path(backup_path)
            if backup_dir.exists() and backup_dir.is_dir():
                shutil.rmtree(backup_dir)
                return True
            return False
        except Exception:
            return False
    
    def get_backup_count(self, account_email: str) -> int:
        """Get number of backups for an account"""
        return len(self.get_timeline(account_email))
    
    def get_total_backup_size(self, account_email: str = None) -> int:
        """Get total size of backups in bytes"""
        if account_email:
            safe_email = safe_email_to_filename(account_email)
            target_dir = self.backup_root / safe_email
        else:
            target_dir = self.backup_root
        
        if not target_dir.exists():
            return 0
        
        total = 0
        for root, dirs, files in os.walk(target_dir):
            for f in files:
                total += os.path.getsize(os.path.join(root, f))
        return total
    
    def get_stats(self) -> Dict[str, Any]:
        """Get backup system statistics"""
        accounts = []
        total_backups = 0
        total_size = 0
        
        if self.backup_root.exists():
            for account_dir in self.backup_root.iterdir():
                if account_dir.is_dir():
                    backup_count = len(list(account_dir.iterdir()))
                    accounts.append(account_dir.name)
                    total_backups += backup_count
                    
                    for root, dirs, files in os.walk(account_dir):
                        for f in files:
                            total_size += os.path.getsize(os.path.join(root, f))
        
        return {
            "total_accounts": len(accounts),
            "total_backups": total_backups,
            "total_size": total_size,
            "backup_root": str(self.backup_root),
            "max_backups_per_account": self.max_backups
        }
    
    def _cleanup_old_backups(self, safe_email: str) -> int:
        """
        Keep only max_backups most recent backups
        
        Returns:
            Number of backups deleted
        """
        account_dir = self.backup_root / safe_email
        if not account_dir.exists():
            return 0
        
        backups = sorted(account_dir.iterdir(), reverse=True)
        deleted = 0
        
        for old_backup in backups[self.max_backups:]:
            if old_backup.is_dir():
                try:
                    shutil.rmtree(old_backup)
                    deleted += 1
                except Exception:
                    pass
        
        return deleted
    
    def _get_backup_size(self, backup_dir: Path) -> int:
        """Get size of a backup directory in bytes"""
        total = 0
        try:
            for f in backup_dir.iterdir():
                if f.is_file():
                    total += f.stat().st_size
        except Exception:
            pass
        return total
    
    def cleanup_all_old_backups(self) -> Dict[str, int]:
        """Cleanup old backups for all accounts"""
        results = {}
        
        if not self.backup_root.exists():
            return results
        
        for account_dir in self.backup_root.iterdir():
            if account_dir.is_dir():
                deleted = self._cleanup_old_backups(account_dir.name)
                if deleted > 0:
                    results[account_dir.name] = deleted
        
        return results
    
    def export_backup(self, backup_path: str, export_path: str) -> bool:
        """Export a backup to a zip file"""
        try:
            shutil.make_archive(
                export_path.replace('.zip', ''),
                'zip',
                backup_path
            )
            return True
        except Exception:
            return False
    
    def import_backup(self, zip_path: str, account_email: str) -> tuple:
        """Import a backup from a zip file"""
        try:
            import zipfile
            
            timestamp = get_timestamp()
            safe_email = safe_email_to_filename(account_email)
            backup_dir = self.backup_root / safe_email / f"imported_{timestamp}"
            backup_dir.mkdir(parents=True, exist_ok=True)
            
            with zipfile.ZipFile(zip_path, 'r') as zip_ref:
                zip_ref.extractall(backup_dir)
            
            # Update metadata
            metadata_file = backup_dir / "metadata.json"
            if metadata_file.exists():
                with open(metadata_file, 'r', encoding='utf-8') as f:
                    metadata = json.load(f)
                metadata["imported"] = get_iso_timestamp()
                metadata["original_timestamp"] = metadata.get("timestamp", "unknown")
                metadata["timestamp"] = timestamp
                with open(metadata_file, 'w', encoding='utf-8') as f:
                    json.dump(metadata, f, indent=2)
            
            return str(backup_dir), True
            
        except Exception as e:
            return str(e), False


# Singleton instance
_backup_manager_instance: Optional[BackupManager] = None


def get_backup_manager() -> BackupManager:
    """Get the singleton backup manager instance"""
    global _backup_manager_instance
    if _backup_manager_instance is None:
        _backup_manager_instance = BackupManager()
    return _backup_manager_instance
