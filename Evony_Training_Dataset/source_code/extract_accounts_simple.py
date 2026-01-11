#!/usr/bin/env python3
"""
Simple Email:Password Extractor
Just finds email:password pairs from all files - nothing fancy
"""

import re
import csv
import json
from pathlib import Path
from datetime import datetime

EMAIL_RE = re.compile(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}')
OUTPUT_DIR = Path(__file__).parent / "data" / "final_accounts"

# All account data stored here: email -> password
ACCOUNTS = {}

def add_account(email: str, password: str):
    """Add account - SIMPLE: email + password, minimal filtering"""
    email = email.lower().strip()
    password = password.strip()
    
    if not email or not password or '@' not in email:
        return
    if len(password) < 2:
        return
    
    # Only skip exact status words
    if password.lower() in {'active', 'inactive', 'none', 'password', 'n/a'}:
        return
    
    # Keep longer password if duplicate email
    if email not in ACCOUNTS or len(password) > len(ACCOUNTS.get(email, '')):
        ACCOUNTS[email] = password


def extract_csv(filepath: Path):
    """Extract from CSV: email,password"""
    try:
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            for line in f:
                line = line.strip()
                if ',' in line:
                    parts = line.split(',', 1)
                    email = parts[0].strip().replace('mailto:', '')
                    pwd = parts[1].strip().strip('"') if len(parts) > 1 else ''
                    if EMAIL_RE.match(email) and pwd:
                        add_account(email, pwd)
    except Exception as e:
        print(f"  Error {filepath.name}: {e}")


def extract_txt(filepath: Path):
    """Extract from TXT: various formats"""
    try:
        content = filepath.read_text(encoding='utf-8', errors='ignore')
        lines = content.split('\n')
        
        for i, line in enumerate(lines):
            line = line.strip()
            
            # Format: email:password or email password
            for sep in [':', '\t', '  ']:
                if sep in line:
                    parts = line.split(sep, 1)
                    if EMAIL_RE.match(parts[0].strip()):
                        email = parts[0].strip()
                        pwd = parts[1].strip().split()[0] if parts[1].strip() else ''
                        if pwd:
                            add_account(email, pwd)
                        break
            
            # Check for "pw" on next line
            if EMAIL_RE.match(line.split()[0] if line.split() else ''):
                if i + 1 < len(lines):
                    next_line = lines[i + 1].strip()
                    if next_line.lower().startswith('pw'):
                        pwd = next_line.replace('pw', '').replace(':', '').strip()
                        if pwd:
                            add_account(line.split()[0], pwd)
    except Exception as e:
        print(f"  Error {filepath.name}: {e}")


def extract_xlsx(filepath: Path):
    """Extract from Excel - check ALL columns for email,password pairs"""
    count = 0
    try:
        import openpyxl
        wb = openpyxl.load_workbook(filepath, read_only=True, data_only=True)
        
        for sheet in wb.worksheets:
            for row in sheet.iter_rows(values_only=True):
                if not row:
                    continue
                
                # Check each cell for email:password patterns
                for i, cell in enumerate(row):
                    if not cell:
                        continue
                    cell_str = str(cell).strip()
                    
                    # Pattern 1: "email,password" in single cell
                    if ',' in cell_str and '@' in cell_str:
                        parts = cell_str.split(',', 1)
                        if EMAIL_RE.match(parts[0].strip()):
                            add_account(parts[0].strip(), parts[1].strip())
                            count += 1
                            continue
                    
                    # Pattern 2: email in this column, password in next
                    if EMAIL_RE.match(cell_str):
                        # Check next column for password
                        if i + 1 < len(row) and row[i + 1]:
                            pwd = str(row[i + 1]).strip()
                            if pwd.lower() not in ['password', 'none', '']:
                                add_account(cell_str, pwd)
                                count += 1
        wb.close()
        if count > 0:
            print(f"    {filepath.name}: {count} accounts")
    except Exception as e:
        print(f"  Error {filepath.name}: {e}")


def main():
    print("=" * 60)
    print("  SIMPLE EMAIL:PASSWORD EXTRACTOR")
    print("=" * 60)
    
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    
    # Source files - ALL DRIVES
    sources = [
        # C: drive
        Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\Scripts\khan_Accounts_556\khanaccounts.csv"),
        Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\Accounts"),
        Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\checkme"),
        # D: drive
        Path(r"D:\Desktop\evony"),
        Path(r"D:\evony"),
        Path(r"D:\EvonyToolKit"),
    ]
    
    # Skip coordinate/non-password files
    skip_files = {'citieskhans.csv', 'khans_heroes.txt'}
    
    # Process ALL sources
    for i, src in enumerate(sources, 1):
        if not src.exists():
            continue
        
        print(f"\n[{i}] {src}...")
        
        if src.is_file():
            if src.suffix.lower() == '.csv':
                extract_csv(src)
            elif src.suffix.lower() == '.xlsx':
                extract_xlsx(src)
        else:
            for f in src.rglob('*'):
                if f.is_file() and f.name.lower() not in skip_files:
                    ext = f.suffix.lower()
                    if ext == '.csv':
                        extract_csv(f)
                    elif ext == '.xlsx':
                        extract_xlsx(f)
                    elif ext == '.txt':
                        extract_txt(f)
        
        print(f"    Total: {len(ACCOUNTS)} accounts")
    
    # Output results
    ts = datetime.now().strftime('%Y%m%d_%H%M%S')
    
    print(f"\n{'=' * 60}")
    print(f"  FINAL: {len(ACCOUNTS)} accounts with passwords")
    print(f"{'=' * 60}")
    
    # 1. CSV output
    csv_file = OUTPUT_DIR / f'accounts_{ts}.csv'
    with open(csv_file, 'w', newline='', encoding='utf-8') as f:
        w = csv.writer(f)
        w.writerow(['email', 'password', 'server'])
        for email, pwd in sorted(ACCOUNTS.items()):
            w.writerow([email, pwd, 'cc2'])
    print(f"\n[OUTPUT] {csv_file}")
    
    # 2. JSON output
    json_file = OUTPUT_DIR / f'accounts_{ts}.json'
    data = [{'email': e, 'password': p, 'server': 'cc2'} for e, p in sorted(ACCOUNTS.items())]
    with open(json_file, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2)
    print(f"[OUTPUT] {json_file}")
    
    # 3. Simple user:pass
    txt_file = OUTPUT_DIR / f'userpass_{ts}.txt'
    with open(txt_file, 'w', encoding='utf-8') as f:
        for email, pwd in sorted(ACCOUNTS.items()):
            f.write(f"{email}:{pwd}\n")
    print(f"[OUTPUT] {txt_file}")
    
    # 4. Evony format
    evony_file = OUTPUT_DIR / f'evony_format_{ts}.txt'
    with open(evony_file, 'w', encoding='utf-8') as f:
        for email, pwd in sorted(ACCOUNTS.items()):
            f.write(f"cc2.evony@{email}:{pwd}\n")
    print(f"[OUTPUT] {evony_file}")
    
    print(f"\n{'=' * 60}")
    print(f"  DONE: {len(ACCOUNTS)} accounts extracted")
    print(f"  Output: {OUTPUT_DIR}")
    print("=" * 60)
    
    return len(ACCOUNTS)


if __name__ == '__main__':
    main()
