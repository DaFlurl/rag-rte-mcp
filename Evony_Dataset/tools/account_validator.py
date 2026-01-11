"""
ETK Account Validator and Deduplicator
Analyzes khanaccounts.csv to create a clean, deduplicated account list.

Since we CANNOT directly login to Evony from Python (proprietary protocol),
validation must be done by:
1. Launching RoboEvony with each account
2. Checking if login succeeds
3. Recording result

This module prepares the account list for validation.
"""

import csv
import json
import re
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Tuple, Set
from collections import defaultdict


class AccountValidator:
    """
    Analyzes and cleans the khanaccounts.csv file.
    Creates a deduplicated list of accounts for validation.
    """
    
    CSV_PATH = Path(r"D:\EvonyToolKit\scripts\khan_Accounts_556\khanaccounts.csv")
    OUTPUT_DIR = Path(r"D:\EvonyToolKit\data")
    
    # Patterns that indicate notes, not passwords
    NOTE_PATTERNS = [
        r'^active$',
        r'^inactive$',
        r'^not working$',
        r'^quit$',
        r'^banned$',
        r'^suspended$',
        r'^deleted$',
        r'^\d+[kmbt]?\s*(food|iron|stone|wood|lumber)',  # Resource notes
        r'\d+\s*fleet',  # Fleet notes
        r'\d+\s*ring',  # Ring notes
        r'^arch\s+alt',  # Arch alt notes
        r'^feeder',  # Feeder notes
        r'^\d+\s*cents?$',  # Cents notes
    ]
    
    def __init__(self):
        self.raw_accounts: List[Tuple[str, str]] = []
        self.accounts: Dict[str, Dict] = {}
        self.duplicates: Dict[str, List[str]] = defaultdict(list)
        self.notes: Dict[str, List[str]] = defaultdict(list)
        
    def load_csv(self) -> int:
        """Load accounts from CSV file"""
        self.raw_accounts = []
        
        with open(self.CSV_PATH, 'r', encoding='utf-8', errors='ignore') as f:
            reader = csv.reader(f)
            for row in reader:
                if len(row) >= 2:
                    email = row[0].strip()
                    value = row[1].strip()
                    if '@' in email and value:
                        self.raw_accounts.append((email, value))
        
        return len(self.raw_accounts)
    
    def is_note(self, value: str) -> bool:
        """Check if value looks like a note rather than password"""
        value_lower = value.lower()
        
        for pattern in self.NOTE_PATTERNS:
            if re.search(pattern, value_lower):
                return True
        
        return False
    
    def is_valid_password(self, value: str) -> bool:
        """Check if value looks like a valid password"""
        if not value or len(value) < 3:
            return False
        if self.is_note(value):
            return False
        return True
    
    def deduplicate(self) -> Dict[str, Dict]:
        """
        Deduplicate accounts and extract best password for each.
        Returns dict of {email: {password, notes, duplicate_count}}
        """
        self.accounts = {}
        self.duplicates = defaultdict(list)
        self.notes = defaultdict(list)
        
        # Group by email
        email_values = defaultdict(list)
        for email, value in self.raw_accounts:
            email_lower = email.lower()
            email_values[email_lower].append((email, value))
        
        # Process each unique email
        for email_lower, entries in email_values.items():
            passwords = []
            notes = []
            original_email = entries[0][0]  # Use first occurrence's case
            
            for email, value in entries:
                if self.is_valid_password(value):
                    passwords.append(value)
                else:
                    notes.append(value)
            
            # Track duplicates
            self.duplicates[email_lower] = [v for _, v in entries]
            self.notes[email_lower] = notes
            
            if passwords:
                # Use the most recent (last) password, or longest one
                best_password = max(passwords, key=len)
                
                self.accounts[email_lower] = {
                    'email': original_email,
                    'password': best_password,
                    'alternate_passwords': [p for p in passwords if p != best_password],
                    'notes': notes,
                    'duplicate_count': len(entries),
                    'status': 'unknown',  # To be validated
                }
        
        return self.accounts
    
    def get_stats(self) -> Dict:
        """Get statistics about the accounts"""
        return {
            'total_rows': len(self.raw_accounts),
            'unique_emails': len(self.accounts),
            'with_duplicates': sum(1 for a in self.accounts.values() if a['duplicate_count'] > 1),
            'with_notes': sum(1 for a in self.accounts.values() if a['notes']),
            'with_alt_passwords': sum(1 for a in self.accounts.values() if a['alternate_passwords']),
        }
    
    def export_clean_csv(self, output_path: Path = None) -> str:
        """Export clean, deduplicated CSV"""
        if output_path is None:
            timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
            output_path = self.OUTPUT_DIR / f"accounts_clean_{timestamp}.csv"
        
        output_path.parent.mkdir(parents=True, exist_ok=True)
        
        with open(output_path, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow(['email', 'password', 'status', 'notes'])
            
            for email, data in sorted(self.accounts.items()):
                writer.writerow([
                    data['email'],
                    data['password'],
                    data['status'],
                    '; '.join(data['notes']) if data['notes'] else ''
                ])
        
        return str(output_path)
    
    def export_json(self, output_path: Path = None) -> str:
        """Export accounts as JSON for processing"""
        if output_path is None:
            timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
            output_path = self.OUTPUT_DIR / f"accounts_clean_{timestamp}.json"
        
        output_path.parent.mkdir(parents=True, exist_ok=True)
        
        data = {
            'generated': datetime.now().isoformat(),
            'stats': self.get_stats(),
            'accounts': list(self.accounts.values())
        }
        
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2)
        
        return str(output_path)
    
    def generate_validation_queue(self) -> List[Dict]:
        """Generate list of accounts to validate via RoboEvony"""
        return [
            {'email': data['email'], 'password': data['password']}
            for data in self.accounts.values()
        ]


def analyze_accounts():
    """Main function to analyze and clean accounts"""
    print("=" * 60)
    print("ETK Account Validator")
    print("=" * 60)
    
    validator = AccountValidator()
    
    # Load CSV
    total = validator.load_csv()
    print(f"\nLoaded {total} rows from CSV")
    
    # Deduplicate
    accounts = validator.deduplicate()
    
    # Stats
    stats = validator.get_stats()
    print(f"\nAnalysis Results:")
    print(f"  Total rows in CSV: {stats['total_rows']}")
    print(f"  Unique emails: {stats['unique_emails']}")
    print(f"  Accounts with duplicates: {stats['with_duplicates']}")
    print(f"  Accounts with notes: {stats['with_notes']}")
    print(f"  Accounts with alternate passwords: {stats['with_alt_passwords']}")
    
    # Export
    csv_path = validator.export_clean_csv()
    json_path = validator.export_json()
    
    print(f"\nExported:")
    print(f"  CSV: {csv_path}")
    print(f"  JSON: {json_path}")
    
    # Show accounts with alternate passwords (might need testing)
    print(f"\nAccounts with alternate passwords (may need testing):")
    for email, data in list(accounts.items())[:10]:
        if data['alternate_passwords']:
            print(f"  {data['email']}")
            print(f"    Primary: {data['password']}")
            print(f"    Alternates: {data['alternate_passwords']}")
    
    return validator


if __name__ == '__main__':
    analyze_accounts()
