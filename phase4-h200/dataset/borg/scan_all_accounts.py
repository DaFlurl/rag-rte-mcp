#!/usr/bin/env python3
"""
BORG TOOLKIT - Complete Account Scanner
Scans ALL directories for email:password pairs and unique emails
No login validation - just file scanning and consolidation
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

# Output directory
OUTPUT_DIR = Path(__file__).parent / "data" / "scan_results"

# Email regex
EMAIL_RE = re.compile(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}')

# Common password hints
PW_HINTS = ['pw', 'pw:', 'password', 'password:', 'pass', 'pass:']


def scan_file_for_accounts(filepath: Path) -> list:
    """Extract email:password pairs from a file"""
    results = []
    
    try:
        # Try different encodings
        content = None
        for enc in ['utf-8', 'latin-1', 'cp1252']:
            try:
                content = filepath.read_text(encoding=enc, errors='ignore')
                break
            except:
                continue
        
        if not content:
            return results
        
        lines = content.split('\n')
        
        for i, line in enumerate(lines):
            line = line.strip()
            if not line:
                continue
            
            # Find emails in line
            emails = EMAIL_RE.findall(line)
            
            for email in emails:
                email = email.lower()
                password = None
                
                # Method 1: email:password or email,password
                for sep in [':', ',', '\t', '  ']:
                    if sep in line:
                        parts = line.split(sep)
                        for j, part in enumerate(parts):
                            if email in part.lower() and j + 1 < len(parts):
                                candidate = parts[j + 1].strip().split()[0] if parts[j + 1].strip().split() else ''
                                if candidate and not EMAIL_RE.match(candidate) and len(candidate) > 2:
                                    # Skip common non-password values
                                    if candidate.lower() not in ['active', 'inactive', 'not', 'working', 'semi']:
                                        password = candidate
                                        break
                
                # Method 2: Space-separated (name email password)
                if not password:
                    parts = line.split()
                    for j, part in enumerate(parts):
                        if email in part.lower() and j + 1 < len(parts):
                            candidate = parts[j + 1]
                            if not EMAIL_RE.match(candidate) and len(candidate) > 2:
                                if candidate.lower() not in ['active', 'inactive', 'not', 'working', 'lt', 'semi']:
                                    password = candidate
                                    break
                
                # Method 3: Check next line for password
                if not password and i + 1 < len(lines):
                    next_line = lines[i + 1].strip().lower()
                    for hint in PW_HINTS:
                        if next_line.startswith(hint):
                            password = next_line.replace(hint, '').strip()
                            break
                
                results.append({
                    'email': email,
                    'password': password,
                    'source': filepath.name,
                    'has_password': password is not None
                })
    
    except Exception as e:
        print(f"  Error reading {filepath}: {e}")
    
    return results


def scan_csv_file(filepath: Path) -> list:
    """Extract accounts from CSV files"""
    results = []
    try:
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            # Detect delimiter
            sample = f.read(2000)
            f.seek(0)
            
            delimiter = ',' if ',' in sample else '\t'
            reader = csv.reader(f, delimiter=delimiter)
            
            for row in reader:
                if not row:
                    continue
                
                # Find email in row
                for j, cell in enumerate(row):
                    cell = cell.strip()
                    if EMAIL_RE.match(cell):
                        email = cell.lower()
                        password = None
                        
                        # Check next columns for password
                        for k in range(j + 1, min(j + 3, len(row))):
                            candidate = row[k].strip()
                            if candidate and not EMAIL_RE.match(candidate):
                                if candidate.lower() not in ['active', 'inactive', 'not working', 'semi active?']:
                                    if len(candidate) > 2:
                                        password = candidate
                                        break
                        
                        results.append({
                            'email': email,
                            'password': password,
                            'source': filepath.name,
                            'has_password': password is not None
                        })
                        break
    except Exception as e:
        print(f"  CSV error {filepath}: {e}")
    
    return results


def scan_xlsx_file(filepath: Path) -> list:
    """Extract accounts from Excel files"""
    results = []
    try:
        import openpyxl
        wb = openpyxl.load_workbook(filepath, read_only=True, data_only=True)
        
        for sheet in wb.worksheets:
            for row in sheet.iter_rows(values_only=True):
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
                        for k in range(j + 1, min(j + 3, len(row))):
                            if row[k] is None:
                                continue
                            candidate = str(row[k]).strip()
                            if candidate and not EMAIL_RE.match(candidate):
                                if candidate.lower() not in ['active', 'inactive', 'not working']:
                                    if len(candidate) > 2:
                                        password = candidate
                                        break
                        
                        results.append({
                            'email': email,
                            'password': password,
                            'source': filepath.name,
                            'has_password': password is not None
                        })
                        break
        wb.close()
    except ImportError:
        print("  openpyxl not installed - skipping Excel files")
    except Exception as e:
        print(f"  Excel error {filepath}: {e}")
    
    return results


def main():
    print("=" * 70)
    print("  BORG TOOLKIT - Complete Account Scanner")
    print("=" * 70)
    
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    
    all_accounts = []  # email -> best record
    emails_seen = set()
    accounts_by_email = defaultdict(list)
    
    # Scan all directories
    for scan_dir in SCAN_DIRS:
        if not scan_dir.exists():
            print(f"\n[SKIP] {scan_dir} - not found")
            continue
        
        print(f"\n[SCAN] {scan_dir}")
        
        # Find all files
        files = list(scan_dir.rglob('*'))
        files = [f for f in files if f.is_file()]
        
        print(f"  Found {len(files)} files")
        
        for filepath in files:
            ext = filepath.suffix.lower()
            
            results = []
            if ext in ['.csv']:
                results = scan_csv_file(filepath)
            elif ext in ['.xlsx', '.xls']:
                results = scan_xlsx_file(filepath)
            elif ext in ['.txt', '.json', '.rtf']:
                results = scan_file_for_accounts(filepath)
            
            if results:
                for acc in results:
                    accounts_by_email[acc['email']].append(acc)
                    emails_seen.add(acc['email'])
                print(f"    {filepath.name}: {len(results)} accounts")
    
    # Consolidate - prefer records with passwords
    print(f"\n[CONSOLIDATE] Processing {len(emails_seen)} unique emails...")
    
    final_accounts = []
    with_password = 0
    without_password = 0
    
    for email in sorted(emails_seen):
        records = accounts_by_email[email]
        
        # Find best record (one with password)
        best = None
        for rec in records:
            if rec['has_password']:
                best = rec
                break
        
        if not best:
            best = records[0]
        
        final_accounts.append(best)
        if best['has_password']:
            with_password += 1
        else:
            without_password += 1
    
    print(f"  With password: {with_password}")
    print(f"  Without password: {without_password}")
    print(f"  Total unique: {len(final_accounts)}")
    
    # Generate outputs
    ts = datetime.now().strftime('%Y%m%d_%H%M%S')
    
    # 1. Master CSV (all accounts)
    csv_all = OUTPUT_DIR / f'all_accounts_{ts}.csv'
    with open(csv_all, 'w', newline='', encoding='utf-8') as f:
        w = csv.writer(f)
        w.writerow(['email', 'password', 'has_password', 'source'])
        for acc in final_accounts:
            w.writerow([acc['email'], acc['password'] or '', acc['has_password'], acc['source']])
    print(f"\n[OUTPUT] {csv_all}")
    
    # 2. Accounts with passwords only
    csv_valid = OUTPUT_DIR / f'accounts_with_passwords_{ts}.csv'
    valid = [a for a in final_accounts if a['has_password']]
    with open(csv_valid, 'w', newline='', encoding='utf-8') as f:
        w = csv.writer(f)
        w.writerow(['email', 'password', 'source'])
        for acc in valid:
            w.writerow([acc['email'], acc['password'], acc['source']])
    print(f"[OUTPUT] {csv_valid} ({len(valid)} accounts)")
    
    # 3. Simple user:pass format
    txt_userpass = OUTPUT_DIR / f'userpass_{ts}.txt'
    with open(txt_userpass, 'w', encoding='utf-8') as f:
        for acc in valid:
            f.write(f"{acc['email']}:{acc['password']}\n")
    print(f"[OUTPUT] {txt_userpass}")
    
    # 4. Emails without passwords (for reference)
    txt_nopass = OUTPUT_DIR / f'emails_no_password_{ts}.txt'
    nopass = [a for a in final_accounts if not a['has_password']]
    with open(txt_nopass, 'w', encoding='utf-8') as f:
        for acc in nopass:
            f.write(f"{acc['email']}\n")
    print(f"[OUTPUT] {txt_nopass} ({len(nopass)} emails)")
    
    # 5. JSON complete
    json_file = OUTPUT_DIR / f'accounts_{ts}.json'
    with open(json_file, 'w', encoding='utf-8') as f:
        json.dump(final_accounts, f, indent=2)
    print(f"[OUTPUT] {json_file}")
    
    # 6. By source file
    by_source = defaultdict(list)
    for acc in valid:
        by_source[acc['source']].append(acc)
    
    source_dir = OUTPUT_DIR / 'by_source'
    source_dir.mkdir(exist_ok=True)
    for src, accs in by_source.items():
        safe = re.sub(r'[^\w\-_]', '_', src)[:40]
        with open(source_dir / f'{safe}.txt', 'w', encoding='utf-8') as f:
            for acc in accs:
                f.write(f"{acc['email']}:{acc['password']}\n")
    print(f"[OUTPUT] {source_dir}/ ({len(by_source)} source files)")
    
    print(f"\n{'=' * 70}")
    print(f"SCAN COMPLETE")
    print(f"  Total unique emails: {len(final_accounts)}")
    print(f"  With passwords:      {with_password}")
    print(f"  Without passwords:   {without_password}")
    print(f"  Output directory:    {OUTPUT_DIR.absolute()}")
    print("=" * 70)


if __name__ == '__main__':
    main()
