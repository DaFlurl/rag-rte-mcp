#!/usr/bin/env python3
"""
BORG TOOLKIT - Multi-Format Account Importer
============================================
Imports accounts from CSV, XLSX, TXT, JSON, RTF, PDF
Deduplicates, validates logins with retry, manages failed accounts
"""

import re
import csv
import json
import hashlib
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Tuple, Optional, Set
from dataclasses import dataclass, field, asdict
import time
import threading

# Optional imports for various formats
try:
    import openpyxl
    XLSX_AVAILABLE = True
except ImportError:
    XLSX_AVAILABLE = False

try:
    from striprtf.striprtf import rtf_to_text
    RTF_AVAILABLE = True
except ImportError:
    RTF_AVAILABLE = False

try:
    import PyPDF2
    PDF_AVAILABLE = True
except ImportError:
    PDF_AVAILABLE = False


@dataclass
class AccountCredential:
    """Single account credential"""
    email: str
    password: str
    server: str = "cc2"
    status: str = "pending"  # pending, active, failed, extracted
    login_attempts: int = 0
    last_attempt: Optional[str] = None
    fail_reason: Optional[str] = None
    player_name: Optional[str] = None
    source_file: Optional[str] = None
    
    def to_dict(self) -> dict:
        return asdict(self)
    
    @classmethod
    def from_dict(cls, d: dict) -> 'AccountCredential':
        return cls(**{k: v for k, v in d.items() if k in cls.__dataclass_fields__})


class AccountImporter:
    """
    Multi-format account importer with deduplication and retry logic
    """
    
    # Common password patterns to extract
    PASSWORD_HINTS = ['pw', 'pw:', 'password', 'password:', 'pass', 'pass:']
    
    # Email regex
    EMAIL_REGEX = re.compile(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}')
    
    def __init__(self, data_dir: Path):
        self.data_dir = Path(data_dir)
        self.data_dir.mkdir(parents=True, exist_ok=True)
        
        self.master_file = self.data_dir / "master_accounts.json"
        self.failed_file = self.data_dir / "failed_accounts.txt"
        self.log_file = self.data_dir / "import_log.txt"
        
        self.accounts: Dict[str, AccountCredential] = {}  # email -> credential
        self.import_log: List[str] = []
        
        self._load_master()
    
    def _load_master(self):
        """Load existing master accounts"""
        if self.master_file.exists():
            try:
                data = json.loads(self.master_file.read_text(encoding='utf-8'))
                for item in data:
                    acc = AccountCredential.from_dict(item)
                    self.accounts[acc.email.lower()] = acc
                self._log(f"Loaded {len(self.accounts)} existing accounts")
            except Exception as e:
                self._log(f"Error loading master: {e}")
    
    def _save_master(self):
        """Save master accounts"""
        data = [acc.to_dict() for acc in self.accounts.values()]
        self.master_file.write_text(json.dumps(data, indent=2), encoding='utf-8')
    
    def _save_failed(self):
        """Save failed accounts in editable format"""
        failed = [acc for acc in self.accounts.values() if acc.status == 'failed']
        lines = ["# Failed Accounts - Edit passwords and resubmit", 
                 "# Format: email:password", ""]
        for acc in failed:
            lines.append(f"{acc.email}:{acc.password}  # {acc.fail_reason or 'unknown'}")
        self.failed_file.write_text('\n'.join(lines), encoding='utf-8')
    
    def _log(self, msg: str):
        """Add to import log"""
        ts = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        entry = f"[{ts}] {msg}"
        self.import_log.append(entry)
        print(entry)
        with open(self.log_file, 'a', encoding='utf-8') as f:
            f.write(entry + '\n')
    
    def import_directory(self, directory: Path) -> Tuple[int, int]:
        """
        Recursively import all account files from a directory
        Returns (imported_count, duplicate_count)
        """
        directory = Path(directory)
        if not directory.exists():
            self._log(f"Directory not found: {directory}")
            return 0, 0
        
        total_imported = 0
        total_dupes = 0
        
        # Find all supported files
        extensions = ['*.csv', '*.txt', '*.json', '*.xlsx', '*.xls', '*.rtf', '*.pdf']
        files = []
        for ext in extensions:
            files.extend(directory.rglob(ext))
        
        self._log(f"Found {len(files)} files in {directory}")
        
        for filepath in files:
            try:
                imported, dupes = self.import_file(filepath)
                total_imported += imported
                total_dupes += dupes
            except Exception as e:
                self._log(f"Error importing {filepath}: {e}")
        
        self._save_master()
        return total_imported, total_dupes
    
    def import_file(self, filepath: Path) -> Tuple[int, int]:
        """Import accounts from a single file"""
        filepath = Path(filepath)
        if not filepath.exists():
            self._log(f"File not found: {filepath}")
            return 0, 0
        
        ext = filepath.suffix.lower()
        self._log(f"Importing {filepath.name} ({ext})")
        
        accounts = []
        
        if ext == '.csv':
            accounts = self._parse_csv(filepath)
        elif ext == '.txt':
            accounts = self._parse_txt(filepath)
        elif ext == '.json':
            accounts = self._parse_json(filepath)
        elif ext in ['.xlsx', '.xls']:
            accounts = self._parse_xlsx(filepath)
        elif ext == '.rtf':
            accounts = self._parse_rtf(filepath)
        elif ext == '.pdf':
            accounts = self._parse_pdf(filepath)
        else:
            self._log(f"Unsupported format: {ext}")
            return 0, 0
        
        # Add to master, counting dupes
        imported = 0
        dupes = 0
        for email, password in accounts:
            email_lower = email.lower().strip()
            if email_lower in self.accounts:
                dupes += 1
                # Update password if different and not extracted
                if self.accounts[email_lower].status != 'extracted':
                    if password and password != self.accounts[email_lower].password:
                        self.accounts[email_lower].password = password
            else:
                self.accounts[email_lower] = AccountCredential(
                    email=email_lower,
                    password=password,
                    source_file=str(filepath.name)
                )
                imported += 1
        
        self._log(f"  -> {imported} new, {dupes} duplicates")
        return imported, dupes
    
    def _parse_csv(self, filepath: Path) -> List[Tuple[str, str]]:
        """Parse CSV file"""
        results = []
        try:
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                # Try to detect format
                sample = f.read(2000)
                f.seek(0)
                
                # Check if it has headers
                has_header = any(h in sample.lower() for h in ['email', 'user', 'account', 'password'])
                
                reader = csv.reader(f)
                if has_header:
                    next(reader, None)  # Skip header
                
                for row in reader:
                    if len(row) >= 2:
                        email = row[0].strip()
                        password = row[1].strip()
                        if self.EMAIL_REGEX.match(email) and password and password.lower() not in ['active', 'inactive', 'not working']:
                            results.append((email, password))
                        elif len(row) >= 3 and self.EMAIL_REGEX.match(email):
                            # Try third column as password
                            password = row[2].strip()
                            if password:
                                results.append((email, password))
                    elif len(row) == 1:
                        # Try email:password format
                        parts = row[0].split(':')
                        if len(parts) == 2 and self.EMAIL_REGEX.match(parts[0].strip()):
                            results.append((parts[0].strip(), parts[1].strip()))
        except Exception as e:
            self._log(f"CSV parse error: {e}")
        return results
    
    def _parse_txt(self, filepath: Path) -> List[Tuple[str, str]]:
        """Parse TXT file with various formats"""
        results = []
        try:
            content = filepath.read_text(encoding='utf-8', errors='ignore')
            lines = content.split('\n')
            
            i = 0
            while i < len(lines):
                line = lines[i].strip()
                
                # Skip empty lines and comments
                if not line or line.startswith('#') or line.startswith('='):
                    i += 1
                    continue
                
                # Format 1: email:password or email,password
                if ':' in line or ',' in line:
                    parts = re.split(r'[,:]\s*', line)
                    for j, part in enumerate(parts):
                        if self.EMAIL_REGEX.match(part.strip()):
                            email = part.strip()
                            # Look for password in next parts
                            if j + 1 < len(parts):
                                password = parts[j + 1].strip()
                                if password and not self.EMAIL_REGEX.match(password):
                                    results.append((email, password))
                                    break
                    i += 1
                    continue
                
                # Format 2: name email password (space/tab separated)
                parts = line.split()
                emails_in_line = [p for p in parts if self.EMAIL_REGEX.match(p)]
                if emails_in_line:
                    email = emails_in_line[0]
                    email_idx = parts.index(email)
                    # Password is likely after email
                    if email_idx + 1 < len(parts):
                        password = parts[email_idx + 1]
                        if password and not self.EMAIL_REGEX.match(password):
                            results.append((email, password))
                            i += 1
                            continue
                
                # Format 3: Multi-line (email on one line, password on next)
                emails = self.EMAIL_REGEX.findall(line)
                if emails and i + 1 < len(lines):
                    next_line = lines[i + 1].strip().lower()
                    # Check if next line has password hint
                    password = None
                    for hint in self.PASSWORD_HINTS:
                        if next_line.startswith(hint):
                            password = next_line.replace(hint, '').strip()
                            break
                    if not password and i + 1 < len(lines):
                        # Just take next non-empty line as password
                        next_line = lines[i + 1].strip()
                        if next_line and not self.EMAIL_REGEX.match(next_line):
                            password = next_line.split()[0] if next_line.split() else next_line
                    if password:
                        results.append((emails[0], password))
                        i += 2
                        continue
                
                i += 1
                
        except Exception as e:
            self._log(f"TXT parse error: {e}")
        return results
    
    def _parse_json(self, filepath: Path) -> List[Tuple[str, str]]:
        """Parse JSON file"""
        results = []
        try:
            data = json.loads(filepath.read_text(encoding='utf-8'))
            if isinstance(data, list):
                for item in data:
                    if isinstance(item, dict):
                        email = item.get('email') or item.get('user') or item.get('username')
                        password = item.get('password') or item.get('pass') or item.get('pw')
                        if email and password:
                            results.append((email, password))
            elif isinstance(data, dict):
                for email, password in data.items():
                    if self.EMAIL_REGEX.match(email):
                        results.append((email, str(password)))
        except Exception as e:
            self._log(f"JSON parse error: {e}")
        return results
    
    def _parse_xlsx(self, filepath: Path) -> List[Tuple[str, str]]:
        """Parse Excel file"""
        results = []
        if not XLSX_AVAILABLE:
            self._log("openpyxl not installed - pip install openpyxl")
            return results
        try:
            wb = openpyxl.load_workbook(filepath, read_only=True, data_only=True)
            for sheet in wb.worksheets:
                for row in sheet.iter_rows(values_only=True):
                    if row and len(row) >= 2:
                        email = str(row[0] or '').strip()
                        password = str(row[1] or '').strip()
                        if self.EMAIL_REGEX.match(email) and password:
                            results.append((email, password))
            wb.close()
        except Exception as e:
            self._log(f"XLSX parse error: {e}")
        return results
    
    def _parse_rtf(self, filepath: Path) -> List[Tuple[str, str]]:
        """Parse RTF file"""
        results = []
        if not RTF_AVAILABLE:
            self._log("striprtf not installed - pip install striprtf")
            return results
        try:
            content = filepath.read_text(encoding='utf-8', errors='ignore')
            text = rtf_to_text(content)
            # Parse as text
            temp_file = self.data_dir / "_temp_rtf.txt"
            temp_file.write_text(text)
            results = self._parse_txt(temp_file)
            temp_file.unlink()
        except Exception as e:
            self._log(f"RTF parse error: {e}")
        return results
    
    def _parse_pdf(self, filepath: Path) -> List[Tuple[str, str]]:
        """Parse PDF file"""
        results = []
        if not PDF_AVAILABLE:
            self._log("PyPDF2 not installed - pip install PyPDF2")
            return results
        try:
            reader = PyPDF2.PdfReader(str(filepath))
            text = ""
            for page in reader.pages:
                text += page.extract_text() or ""
            # Parse as text
            temp_file = self.data_dir / "_temp_pdf.txt"
            temp_file.write_text(text)
            results = self._parse_txt(temp_file)
            temp_file.unlink()
        except Exception as e:
            self._log(f"PDF parse error: {e}")
        return results
    
    def import_failed_edits(self, filepath: Path) -> int:
        """
        Re-import edited failed accounts file
        Updates passwords and resets status to pending
        """
        filepath = Path(filepath)
        if not filepath.exists():
            return 0
        
        updated = 0
        content = filepath.read_text(encoding='utf-8')
        for line in content.split('\n'):
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            
            # Format: email:password
            if ':' in line:
                parts = line.split(':')
                email = parts[0].strip().lower()
                password = parts[1].split('#')[0].strip()  # Remove comment
                
                if email in self.accounts:
                    acc = self.accounts[email]
                    if acc.status == 'failed':
                        acc.password = password
                        acc.status = 'pending'
                        acc.login_attempts = 0
                        acc.fail_reason = None
                        updated += 1
        
        self._save_master()
        self._log(f"Updated {updated} failed accounts from edits")
        return updated
    
    def get_pending_accounts(self) -> List[AccountCredential]:
        """Get all pending accounts for login testing"""
        return [acc for acc in self.accounts.values() if acc.status == 'pending']
    
    def get_active_accounts(self) -> List[AccountCredential]:
        """Get all active (login successful) accounts"""
        return [acc for acc in self.accounts.values() if acc.status == 'active']
    
    def get_failed_accounts(self) -> List[AccountCredential]:
        """Get all failed accounts"""
        return [acc for acc in self.accounts.values() if acc.status == 'failed']
    
    def mark_login_success(self, email: str, player_name: str = None):
        """Mark account as successfully logged in"""
        email = email.lower()
        if email in self.accounts:
            self.accounts[email].status = 'active'
            self.accounts[email].player_name = player_name
            self._save_master()
    
    def mark_login_failed(self, email: str, reason: str = None):
        """
        Mark account login attempt failed
        After MAX_RETRIES, marks as failed permanently
        """
        email = email.lower()
        if email in self.accounts:
            acc = self.accounts[email]
            acc.login_attempts += 1
            acc.last_attempt = datetime.now().isoformat()
            acc.fail_reason = reason
            
            if acc.login_attempts >= 5:
                acc.status = 'failed'
                self._save_failed()
            
            self._save_master()
    
    def get_stats(self) -> Dict:
        """Get import statistics"""
        stats = {
            'total': len(self.accounts),
            'pending': len([a for a in self.accounts.values() if a.status == 'pending']),
            'active': len([a for a in self.accounts.values() if a.status == 'active']),
            'failed': len([a for a in self.accounts.values() if a.status == 'failed']),
            'extracted': len([a for a in self.accounts.values() if a.status == 'extracted']),
        }
        return stats
    
    def export_active_csv(self, filepath: Path):
        """Export active accounts to CSV"""
        active = self.get_active_accounts()
        with open(filepath, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow(['email', 'password', 'server', 'player_name'])
            for acc in active:
                writer.writerow([acc.email, acc.password, acc.server, acc.player_name or ''])
    
    def export_all_csv(self, filepath: Path):
        """Export all accounts to CSV"""
        with open(filepath, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow(['email', 'password', 'server', 'status', 'player_name', 'attempts', 'fail_reason'])
            for acc in self.accounts.values():
                writer.writerow([acc.email, acc.password, acc.server, acc.status, 
                               acc.player_name or '', acc.login_attempts, acc.fail_reason or ''])


class LoginValidator:
    """
    Validates account logins with retry logic
    """
    
    def __init__(self, importer: AccountImporter, max_retries: int = 5, 
                 retry_delay: float = 3.0):
        self.importer = importer
        self.max_retries = max_retries
        self.retry_delay = retry_delay
        self.running = False
        self._stop_event = threading.Event()
    
    def validate_account(self, acc: AccountCredential) -> bool:
        """
        Attempt to login to an account with retries
        Returns True if successful
        """
        from .connection import EvonyConnection
        
        for attempt in range(1, self.max_retries + 1):
            if self._stop_event.is_set():
                return False
            
            print(f"  Login attempt {attempt}/{self.max_retries} for {acc.email}")
            
            try:
                conn = EvonyConnection()
                if conn.connect(acc.server):
                    result = conn.login(acc.email, acc.password)
                    conn.disconnect()
                    
                    if result and result.get('ok'):
                        player_name = result.get('player', {}).get('name', 'Unknown')
                        self.importer.mark_login_success(acc.email, player_name)
                        print(f"  ✓ SUCCESS: {acc.email} -> {player_name}")
                        return True
                    else:
                        error = result.get('errorMsg', 'Login failed') if result else 'No response'
                        self.importer.mark_login_failed(acc.email, error)
                else:
                    self.importer.mark_login_failed(acc.email, "Connection failed")
            except Exception as e:
                self.importer.mark_login_failed(acc.email, str(e))
            
            if attempt < self.max_retries:
                time.sleep(self.retry_delay)
        
        print(f"  ✗ FAILED: {acc.email} after {self.max_retries} attempts")
        return False
    
    def validate_all_pending(self, callback=None):
        """
        Validate all pending accounts
        callback(email, status, progress) called for each account
        """
        self.running = True
        self._stop_event.clear()
        
        pending = self.importer.get_pending_accounts()
        total = len(pending)
        
        print(f"\nValidating {total} pending accounts...")
        
        for i, acc in enumerate(pending):
            if self._stop_event.is_set():
                break
            
            success = self.validate_account(acc)
            
            if callback:
                callback(acc.email, 'active' if success else 'failed', (i + 1) / total)
        
        self.running = False
        stats = self.importer.get_stats()
        print(f"\nValidation complete: {stats['active']} active, {stats['failed']} failed")
    
    def stop(self):
        """Stop validation"""
        self._stop_event.set()


# =============================================================================
# CLI Interface
# =============================================================================

def main():
    """CLI for account importer"""
    import argparse
    
    parser = argparse.ArgumentParser(description='Borg Account Importer')
    parser.add_argument('--data-dir', default='./data/accounts', help='Data directory')
    parser.add_argument('--import-dir', help='Import all files from directory')
    parser.add_argument('--import-file', help='Import single file')
    parser.add_argument('--import-failed', help='Re-import edited failed accounts')
    parser.add_argument('--validate', action='store_true', help='Validate pending accounts')
    parser.add_argument('--export', help='Export active accounts to CSV')
    parser.add_argument('--stats', action='store_true', help='Show statistics')
    
    args = parser.parse_args()
    
    importer = AccountImporter(Path(args.data_dir))
    
    if args.import_dir:
        imported, dupes = importer.import_directory(Path(args.import_dir))
        print(f"Imported {imported} accounts ({dupes} duplicates)")
    
    if args.import_file:
        imported, dupes = importer.import_file(Path(args.import_file))
        print(f"Imported {imported} accounts ({dupes} duplicates)")
    
    if args.import_failed:
        updated = importer.import_failed_edits(Path(args.import_failed))
        print(f"Updated {updated} accounts")
    
    if args.validate:
        validator = LoginValidator(importer)
        validator.validate_all_pending()
    
    if args.export:
        importer.export_active_csv(Path(args.export))
        print(f"Exported to {args.export}")
    
    if args.stats or not any([args.import_dir, args.import_file, args.validate, args.export]):
        stats = importer.get_stats()
        print(f"\n=== Account Statistics ===")
        print(f"Total:     {stats['total']}")
        print(f"Pending:   {stats['pending']}")
        print(f"Active:    {stats['active']}")
        print(f"Failed:    {stats['failed']}")
        print(f"Extracted: {stats['extracted']}")


if __name__ == '__main__':
    main()
