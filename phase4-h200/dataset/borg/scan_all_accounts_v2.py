#!/usr/bin/env python3
"""
BORG TOOLKIT - Complete Account Scanner V2
FIXED: Properly extracts ALL email:password pairs from khan format
"""

import re
import csv
import json
from pathlib import Path
from datetime import datetime
from collections import defaultdict

# Directories to scan
SCAN_DIRS = [
    Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\Accounts"),
    Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\Scripts\khan_Accounts_556"),
    Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\SOL_Accounts"),
    Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\checkme"),
]

OUTPUT_DIR = Path(__file__).parent / "data" / "scan_results_v2"

EMAIL_RE = re.compile(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}')

# ONLY these exact values are status-only (not passwords)
STATUS_ONLY = {
    'active', 'inactive', 'not working', 'semi active?', 
    'main', 'arch', '(0g)', 'fb password', 'evony login'
}

# Files that contain city/coordinate data, NOT passwords
SKIP_FILES = {
    'citieskhans.csv',      # Has coordinates not passwords
    'khans_heroes.txt',     # Has coordinates not passwords
}

# Directories that contain game data JSON, NOT passwords
SKIP_DIRS = {
    'accounts',             # Contains extracted game data, not passwords
}

# Pattern for coordinates like "103,100" or "103,100"
COORD_PATTERN = re.compile(r'^"?\d+,\d+"?$')


def is_valid_password(value: str) -> bool:
    """Check if value looks like a valid password (not just status)"""
    if not value or len(value) < 2:
        return False
    
    # Skip coordinates like "103,100"
    if COORD_PATTERN.match(value):
        return False
    
    # Skip resource strings like "r:205596" or "s:130000"
    if re.match(r'^[a-z]:\d+', value.lower()):
        return False
    
    val_lower = value.lower().strip()
    
    # Exact match to status words = not a password
    if val_lower in STATUS_ONLY:
        return False
    
    # If it contains numbers or special chars, likely a password
    if any(c.isdigit() for c in value):
        return True
    if any(c in value for c in '!@#$%^&*()_+-=[]{}|;:,.<>?'):
        return True
    
    # If it's a single word > 4 chars, probably password
    if len(value) >= 4 and ' ' not in value:
        return True
    
    # Short words that look like passwords
    if len(value) >= 3:
        return True
    
    return False


def parse_khan_csv(filepath: Path) -> list:
    """Parse khan-style CSV: email,password"""
    results = []
    
    try:
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            for line_num, line in enumerate(f, 1):
                line = line.strip()
                if not line:
                    continue
                
                # Split on comma
                if ',' in line:
                    parts = line.split(',', 1)  # Split only on first comma
                    email_part = parts[0].strip()
                    password_part = parts[1].strip() if len(parts) > 1 else ''
                    
                    # Clean email
                    email_part = email_part.replace('mailto:', '').strip()
                    
                    # Check if first part is email
                    if '@' in email_part and EMAIL_RE.match(email_part):
                        email = email_part.lower()
                        
                        # Clean password - remove quotes
                        password = password_part.strip('"\'')
                        
                        # Check if valid password
                        if is_valid_password(password):
                            results.append({
                                'email': email,
                                'password': password,
                                'source': filepath.name,
                                'line': line_num
                            })
                        else:
                            # Still record but mark as no password
                            results.append({
                                'email': email,
                                'password': None,
                                'source': filepath.name,
                                'line': line_num,
                                'status': password_part  # Keep the status
                            })
    except Exception as e:
        print(f"  Error: {e}")
    
    return results


def parse_text_file(filepath: Path) -> list:
    """Parse various text formats"""
    results = []
    
    try:
        content = filepath.read_text(encoding='utf-8', errors='ignore')
        lines = content.split('\n')
        
        for i, line in enumerate(lines, 1):
            line = line.strip()
            if not line:
                continue
            
            # Find emails
            emails = EMAIL_RE.findall(line)
            
            for email in emails:
                email = email.lower()
                password = None
                
                # Method 1: email:password or email,password
                for sep in [':', ',', '\t']:
                    if sep in line:
                        idx = line.lower().find(email)
                        if idx >= 0:
                            after = line[idx + len(email):]
                            if after.startswith(sep):
                                pwd_part = after[1:].split()[0] if after[1:].split() else ''
                                pwd_part = pwd_part.strip('"\'')
                                if is_valid_password(pwd_part):
                                    password = pwd_part
                                    break
                
                # Method 2: Space-separated
                if not password:
                    parts = line.split()
                    for j, part in enumerate(parts):
                        if email in part.lower() and j + 1 < len(parts):
                            pwd_part = parts[j + 1]
                            if not EMAIL_RE.match(pwd_part) and is_valid_password(pwd_part):
                                password = pwd_part
                                break
                
                # Method 3: Check next line for "pw" or "password"
                if not password and i < len(lines):
                    next_line = lines[i].strip().lower() if i < len(lines) else ''
                    if next_line.startswith('pw') or next_line.startswith('password'):
                        pwd = next_line.replace('pw', '').replace('password', '').strip(': ')
                        if is_valid_password(pwd):
                            password = pwd
                
                results.append({
                    'email': email,
                    'password': password,
                    'source': filepath.name,
                    'line': i
                })
    
    except Exception as e:
        print(f"  Error: {e}")
    
    return results


def parse_xlsx(filepath: Path) -> list:
    """Parse Excel files"""
    results = []
    try:
        import openpyxl
        wb = openpyxl.load_workbook(filepath, read_only=True, data_only=True)
        
        for sheet in wb.worksheets:
            for row_num, row in enumerate(sheet.iter_rows(values_only=True), 1):
                if not row:
                    continue
                
                for j, cell in enumerate(row):
                    if cell is None:
                        continue
                    cell_str = str(cell).strip()
                    
                    if EMAIL_RE.match(cell_str):
                        email = cell_str.lower()
                        password = None
                        
                        # Check next columns
                        for k in range(j + 1, min(j + 4, len(row))):
                            if row[k] is None:
                                continue
                            pwd = str(row[k]).strip()
                            if is_valid_password(pwd) and not EMAIL_RE.match(pwd):
                                password = pwd
                                break
                        
                        results.append({
                            'email': email,
                            'password': password,
                            'source': filepath.name,
                            'line': row_num
                        })
                        break
        wb.close()
    except Exception as e:
        print(f"  Excel error: {e}")
    
    return results


def main():
    print("=" * 70)
    print("  BORG TOOLKIT - Account Scanner V2 (FIXED)")
    print("=" * 70)
    
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    
    all_accounts = {}  # email -> best record
    stats = {'total_lines': 0, 'with_password': 0, 'without_password': 0}
    
    for scan_dir in SCAN_DIRS:
        if not scan_dir.exists():
            print(f"\n[SKIP] {scan_dir}")
            continue
        
        print(f"\n[SCAN] {scan_dir}")
        
        files = list(scan_dir.rglob('*'))
        files = [f for f in files if f.is_file()]
        print(f"  {len(files)} files")
        
        for filepath in files:
            # Skip files that contain coordinates, not passwords
            if filepath.name.lower() in SKIP_FILES:
                print(f"    [SKIP] {filepath.name} (coordinate data)")
                continue
            
            # Skip directories with game data (not passwords)
            if any(skip_dir in filepath.parts for skip_dir in SKIP_DIRS):
                continue
            
            ext = filepath.suffix.lower()
            results = []
            
            if ext == '.csv':
                results = parse_khan_csv(filepath)
            elif ext in ['.xlsx']:
                results = parse_xlsx(filepath)
            elif ext in ['.txt']:
                results = parse_text_file(filepath)
            # Skip .json files - they contain game data, not passwords
            
            if results:
                for acc in results:
                    email = acc['email']
                    has_new_pwd = acc.get('password') is not None
                    has_old_pwd = email in all_accounts and all_accounts[email].get('password') is not None
                    
                    # Always prefer entry WITH password
                    if email not in all_accounts:
                        all_accounts[email] = acc
                    elif has_new_pwd and not has_old_pwd:
                        # New has password, old doesn't - use new
                        all_accounts[email] = acc
                    elif has_new_pwd and has_old_pwd:
                        # Both have passwords - keep longer/better one
                        old_pwd = all_accounts[email].get('password', '')
                        new_pwd = acc.get('password', '')
                        if len(new_pwd) > len(old_pwd):
                            all_accounts[email] = acc
                
                with_pw = sum(1 for a in results if a.get('password'))
                print(f"    {filepath.name}: {len(results)} emails, {with_pw} with passwords")
    
    # Final consolidation
    final = list(all_accounts.values())
    with_password = [a for a in final if a.get('password')]
    without_password = [a for a in final if not a.get('password')]
    
    print(f"\n{'=' * 70}")
    print(f"  RESULTS")
    print(f"{'=' * 70}")
    print(f"  Total unique emails: {len(final)}")
    print(f"  With passwords:      {len(with_password)}")
    print(f"  Without passwords:   {len(without_password)}")
    
    # Generate outputs
    ts = datetime.now().strftime('%Y%m%d_%H%M%S')
    
    # 1. All accounts with passwords
    csv_file = OUTPUT_DIR / f'accounts_with_passwords_{ts}.csv'
    with open(csv_file, 'w', newline='', encoding='utf-8') as f:
        w = csv.writer(f)
        w.writerow(['email', 'password', 'source'])
        for acc in sorted(with_password, key=lambda x: x['email']):
            w.writerow([acc['email'], acc['password'], acc['source']])
    print(f"\n[OUTPUT] {csv_file.name} ({len(with_password)} accounts)")
    
    # 2. User:pass format
    txt_file = OUTPUT_DIR / f'userpass_{ts}.txt'
    with open(txt_file, 'w', encoding='utf-8') as f:
        for acc in sorted(with_password, key=lambda x: x['email']):
            f.write(f"{acc['email']}:{acc['password']}\n")
    print(f"[OUTPUT] {txt_file.name}")
    
    # 3. cc2.evony format
    evony_file = OUTPUT_DIR / f'evony_format_{ts}.txt'
    with open(evony_file, 'w', encoding='utf-8') as f:
        for acc in sorted(with_password, key=lambda x: x['email']):
            f.write(f"cc2.evony@{acc['email']}:{acc['password']}\n")
    print(f"[OUTPUT] {evony_file.name}")
    
    # 4. JSON complete
    json_file = OUTPUT_DIR / f'accounts_{ts}.json'
    with open(json_file, 'w', encoding='utf-8') as f:
        json.dump(with_password, f, indent=2)
    print(f"[OUTPUT] {json_file.name}")
    
    # 5. Emails without passwords
    nopass_file = OUTPUT_DIR / f'emails_no_password_{ts}.txt'
    with open(nopass_file, 'w', encoding='utf-8') as f:
        for acc in without_password:
            status = acc.get('status', '')
            f.write(f"{acc['email']}  # {status}\n")
    print(f"[OUTPUT] {nopass_file.name} ({len(without_password)} emails)")
    
    print(f"\n{'=' * 70}")
    print(f"  SUMMARY: {len(with_password)} accounts with passwords ready")
    print(f"  Output: {OUTPUT_DIR}")
    print("=" * 70)
    
    return len(with_password)


if __name__ == '__main__':
    main()
