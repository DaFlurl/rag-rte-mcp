"""
ETK Account Parser - Properly handles password + security code format
"""

import csv
import json
from pathlib import Path
from datetime import datetime
from collections import defaultdict


def parse_khan_accounts():
    """
    Parse khanaccounts.csv with proper handling of:
    - Email (column 1)
    - Password or notes (column 2)
    - When email appears twice: first = password, second = security code
    """
    
    csv_path = Path(r"D:\EvonyToolKit\scripts\khan_Accounts_556\khanaccounts.csv")
    
    # Group all values by email
    email_entries = defaultdict(list)
    
    with open(csv_path, 'r', encoding='utf-8', errors='ignore') as f:
        reader = csv.reader(f)
        for row in reader:
            if len(row) >= 2 and '@' in row[0]:
                email = row[0].strip()
                value = row[1].strip()
                if value:
                    email_entries[email.lower()].append({
                        'original_email': email,
                        'value': value
                    })
    
    # Note patterns (not passwords)
    note_keywords = [
        'active', 'inactive', 'not working', 'quit', 'banned', 
        'suspended', 'deleted', 'fleet', 'ring', 'food', 'iron',
        'stone', 'wood', 'lumber', 'arch alt', 'feeder', 'cents',
        'scouts', 'troops', 'key ', 'has ', 'one of', 'og'
    ]
    
    def is_note(value):
        v = value.lower()
        return any(kw in v for kw in note_keywords) or len(value) < 3
    
    def looks_like_sec_code(value):
        """Security codes are often short numbers or simple words"""
        v = value.strip()
        # Pure numbers like "40", "60", "2097"
        if v.isdigit() and len(v) <= 6:
            return True
        # "sec code XXXX" pattern
        if 'sec code' in v.lower():
            return True
        return False
    
    # Process accounts
    accounts = []
    
    for email_lower, entries in email_entries.items():
        original_email = entries[0]['original_email']
        values = [e['value'] for e in entries]
        
        password = None
        sec_code = None
        notes = []
        
        if len(values) == 1:
            # Single entry
            v = values[0]
            if is_note(v):
                notes.append(v)
            else:
                password = v
        
        elif len(values) == 2:
            # Two entries: password + sec_code OR password + note
            v1, v2 = values[0], values[1]
            
            if is_note(v1) and is_note(v2):
                notes = [v1, v2]
            elif is_note(v1):
                notes.append(v1)
                password = v2
            elif is_note(v2):
                password = v1
                notes.append(v2)
            else:
                # Both look like valid values - first is password, second is sec_code
                password = v1
                sec_code = v2
        
        else:
            # More than 2 entries - find best password
            for v in values:
                if is_note(v):
                    notes.append(v)
                elif password is None:
                    password = v
                elif sec_code is None and not is_note(v):
                    sec_code = v
        
        # Only include accounts with passwords
        if password:
            accounts.append({
                'email': original_email,
                'password': password,
                'sec_code': sec_code or '',
                'notes': '; '.join(notes) if notes else '',
                'status': 'pending',  # To be validated
            })
    
    return accounts


def export_accounts():
    """Export parsed accounts to CSV and JSON"""
    accounts = parse_khan_accounts()
    
    output_dir = Path(r"D:\EvonyToolKit\data")
    output_dir.mkdir(parents=True, exist_ok=True)
    
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    
    # Stats
    with_sec_code = sum(1 for a in accounts if a['sec_code'])
    with_notes = sum(1 for a in accounts if a['notes'])
    
    print(f"Parsed Accounts: {len(accounts)}")
    print(f"  With security code: {with_sec_code}")
    print(f"  With notes: {with_notes}")
    
    # Export CSV
    csv_path = output_dir / f"accounts_with_seccode_{timestamp}.csv"
    with open(csv_path, 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow(['email', 'password', 'sec_code', 'notes', 'status'])
        for acc in accounts:
            writer.writerow([
                acc['email'],
                acc['password'],
                acc['sec_code'],
                acc['notes'],
                acc['status']
            ])
    print(f"\nExported CSV: {csv_path}")
    
    # Export JSON
    json_path = output_dir / f"accounts_with_seccode_{timestamp}.json"
    with open(json_path, 'w', encoding='utf-8') as f:
        json.dump({
            'generated': datetime.now().isoformat(),
            'total': len(accounts),
            'with_sec_code': with_sec_code,
            'accounts': accounts
        }, f, indent=2)
    print(f"Exported JSON: {json_path}")
    
    # Show sample
    print("\nSample accounts with security codes:")
    for acc in accounts[:20]:
        if acc['sec_code']:
            print(f"  {acc['email'][:35]:35} | {acc['password'][:15]:15} | {acc['sec_code'][:15]}")
    
    return accounts


if __name__ == '__main__':
    export_accounts()
