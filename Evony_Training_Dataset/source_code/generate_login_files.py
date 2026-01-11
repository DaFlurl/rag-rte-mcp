#!/usr/bin/env python3
"""
BORG TOOLKIT - Generate Login Files
Creates all login file formats for Evony accounts
Uses existing proxy/Tor infrastructure
"""

import csv
import json
from pathlib import Path
from datetime import datetime

# Input/Output
INPUT_FILE = Path(__file__).parent / "data" / "scan_results" / "accounts_with_passwords_20260104_012004.csv"
OUTPUT_DIR = Path(__file__).parent / "data" / "login_files"

# Default server
DEFAULT_SERVER = "cc2"

# Tor/Proxy config
TOR_BASE_PORT = 9000
TOR_PORT_COUNT = 100  # 9000-9099
ACCOUNTS_PER_IP = 10


def load_accounts():
    """Load accounts with passwords"""
    accounts = []
    
    if not INPUT_FILE.exists():
        # Find most recent file
        scan_dir = Path(__file__).parent / "data" / "scan_results"
        files = list(scan_dir.glob("accounts_with_passwords_*.csv"))
        if files:
            input_file = sorted(files)[-1]
        else:
            print("[ERROR] No account files found!")
            return accounts
    else:
        input_file = INPUT_FILE
    
    with open(input_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            email = row.get('email', '').strip().lower()
            password = row.get('password', '').strip()
            
            if email and password and '@' in email:
                # Clean up password - remove quotes, extra spaces
                password = password.strip('"\'').strip()
                
                # Skip obvious non-passwords
                if password.lower() in ['active', 'inactive', 'not working', 'semi active?', '']:
                    continue
                
                # Skip very short passwords
                if len(password) < 3:
                    continue
                
                accounts.append({
                    'email': email,
                    'password': password,
                    'server': DEFAULT_SERVER
                })
    
    print(f"Loaded {len(accounts)} accounts with valid passwords")
    return accounts


def generate_files(accounts):
    """Generate all output formats"""
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    ts = datetime.now().strftime('%Y%m%d_%H%M%S')
    
    # Stats
    print(f"\n{'='*60}")
    print(f"  Generating Login Files - {len(accounts)} accounts")
    print(f"{'='*60}")
    
    # 1. Format: cc2.evony@user:pass
    file1 = OUTPUT_DIR / f"evony_login_format_{ts}.txt"
    with open(file1, 'w', encoding='utf-8') as f:
        for acc in accounts:
            f.write(f"{acc['server']}.evony@{acc['email']}:{acc['password']}\n")
    print(f"[1] {file1.name} - cc2.evony@user:pass format")
    
    # 2. Format: user:pass (plain)
    file2 = OUTPUT_DIR / f"userpass_{ts}.txt"
    with open(file2, 'w', encoding='utf-8') as f:
        for acc in accounts:
            f.write(f"{acc['email']}:{acc['password']}\n")
    print(f"[2] {file2.name} - user:pass format")
    
    # 3. Format: server,email,password (CSV)
    file3 = OUTPUT_DIR / f"accounts_{ts}.csv"
    with open(file3, 'w', newline='', encoding='utf-8') as f:
        w = csv.writer(f)
        w.writerow(['server', 'email', 'password'])
        for acc in accounts:
            w.writerow([acc['server'], acc['email'], acc['password']])
    print(f"[3] {file3.name} - CSV with server")
    
    # 4. Format: JSON array
    file4 = OUTPUT_DIR / f"accounts_{ts}.json"
    with open(file4, 'w', encoding='utf-8') as f:
        json.dump(accounts, f, indent=2)
    print(f"[4] {file4.name} - JSON format")
    
    # 5. Format: Batched by proxy (10 accounts per IP)
    batches_dir = OUTPUT_DIR / "proxy_batches"
    batches_dir.mkdir(exist_ok=True)
    
    batch_num = 0
    for i in range(0, len(accounts), ACCOUNTS_PER_IP):
        batch = accounts[i:i + ACCOUNTS_PER_IP]
        port = TOR_BASE_PORT + batch_num
        
        batch_file = batches_dir / f"batch_{batch_num:03d}_port{port}.txt"
        with open(batch_file, 'w', encoding='utf-8') as f:
            f.write(f"# Proxy: SOCKS4 127.0.0.1:{port}\n")
            f.write(f"# Accounts: {len(batch)}\n\n")
            for acc in batch:
                f.write(f"{acc['email']}:{acc['password']}\n")
        
        batch_num += 1
    
    print(f"[5] {batches_dir.name}/ - {batch_num} proxy batch files (10 accounts each)")
    
    # 6. Format: AutoEvony compatible (for script loading)
    file6 = OUTPUT_DIR / f"autoevony_accounts_{ts}.txt"
    with open(file6, 'w', encoding='utf-8') as f:
        f.write("# AutoEvony Account List\n")
        f.write("# Format: set accounts[N] \"email:password:server\"\n\n")
        for i, acc in enumerate(accounts):
            f.write(f'set accounts[{i}] "{acc["email"]}:{acc["password"]}:{acc["server"]}"\n')
    print(f"[6] {file6.name} - AutoEvony script format")
    
    # 7. Format: Proxy rotation config
    file7 = OUTPUT_DIR / f"proxy_config_{ts}.json"
    proxy_config = {
        "tor_base_port": TOR_BASE_PORT,
        "tor_port_count": TOR_PORT_COUNT,
        "accounts_per_ip": ACCOUNTS_PER_IP,
        "proxy_type": "SOCKS4",
        "proxy_host": "127.0.0.1",
        "total_accounts": len(accounts),
        "total_batches": batch_num,
        "ports_needed": list(range(TOR_BASE_PORT, TOR_BASE_PORT + batch_num)),
        "proxies": [
            {"host": "127.0.0.1", "port": TOR_BASE_PORT + i, "type": "SOCKS4"}
            for i in range(batch_num)
        ]
    }
    with open(file7, 'w', encoding='utf-8') as f:
        json.dump(proxy_config, f, indent=2)
    print(f"[7] {file7.name} - Proxy rotation config")
    
    # Summary
    print(f"\n{'='*60}")
    print(f"  OUTPUT SUMMARY")
    print(f"{'='*60}")
    print(f"  Total accounts:     {len(accounts)}")
    print(f"  Proxy batches:      {batch_num} (10 accounts each)")
    print(f"  Tor ports needed:   {TOR_BASE_PORT}-{TOR_BASE_PORT + batch_num - 1}")
    print(f"  Output directory:   {OUTPUT_DIR.absolute()}")
    print(f"{'='*60}")
    
    return len(accounts), batch_num


def check_missing_features():
    """List what's missing for complete solution"""
    print(f"\n{'='*60}")
    print(f"  FEATURE CHECKLIST")
    print(f"{'='*60}")
    
    features = [
        ("Account Import", [
            ("✓", "CSV import"),
            ("✓", "TXT import (multiple formats)"),
            ("✓", "XLSX import"),
            ("✓", "JSON import"),
            ("✓", "RTF import"),
            ("✓", "PDF import"),
            ("✓", "Deduplication by email"),
            ("✓", "Multi-directory scan"),
        ]),
        ("Output Formats", [
            ("✓", "cc2.evony@user:pass format"),
            ("✓", "Plain user:pass format"),
            ("✓", "CSV with server"),
            ("✓", "JSON complete"),
            ("✓", "AutoEvony script format"),
            ("✓", "Proxy batch files (10/IP)"),
            ("✓", "Proxy config JSON"),
        ]),
        ("Proxy/Tor Support", [
            ("✓", "SOCKS4 proxy support"),
            ("✓", "SOCKS5 proxy support"),
            ("✓", "Tor port rotation (9000-9999)"),
            ("✓", "10 accounts per IP limit"),
            ("✓", "Batch file generation"),
            ("?", "Tor service launcher"),
            ("?", "Automatic IP rotation"),
        ]),
        ("Login Validation", [
            ("✗", "Real Evony server login test"),
            ("✗", "Password verification"),
            ("✗", "Failed account retry (3-5 attempts)"),
            ("✗", "Failed account export for editing"),
        ]),
        ("Data Extraction", [
            ("✓", "Data models for all fields"),
            ("✓", "Output generator (JSON/CSV/HTML/TXT)"),
            ("✗", "Working Evony connection"),
            ("✗", "Real data extraction"),
        ]),
    ]
    
    missing = []
    for category, items in features:
        print(f"\n  {category}:")
        for status, desc in items:
            print(f"    [{status}] {desc}")
            if status in ["✗", "?"]:
                missing.append(desc)
    
    print(f"\n{'='*60}")
    print(f"  MISSING FEATURES TO IMPLEMENT:")
    print(f"{'='*60}")
    for i, item in enumerate(missing, 1):
        print(f"    {i}. {item}")
    
    return missing


def main():
    print("=" * 60)
    print("  BORG TOOLKIT - Login File Generator")
    print("=" * 60)
    
    accounts = load_accounts()
    
    if not accounts:
        print("[ERROR] No accounts found!")
        return
    
    count, batches = generate_files(accounts)
    
    missing = check_missing_features()
    
    print(f"\n[DONE] Generated all login files")
    print(f"       {count} accounts ready for extraction")
    print(f"       {batches} Tor proxy ports needed")


if __name__ == '__main__':
    main()
