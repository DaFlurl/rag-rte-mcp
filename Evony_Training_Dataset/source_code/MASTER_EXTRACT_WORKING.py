"""
MASTER EXTRACT - Using Working evony_client.py
Combines SOL account discovery with proven extraction client
"""
import sys
import json
import time
import os
from pathlib import Path
from datetime import datetime
from collections import defaultdict

# Add paths
sys.path.insert(0, r'D:\EvonyToolKit\sol_manager')
sys.path.insert(0, r'D:\EvonyToolKit\sol_manager\extractor')

from evony_client import EvonyClient, save_account_json
from sol_handler import SOLHandler

# ============================================================================
# CONFIG
# ============================================================================
SOL_PATHS_FILE = Path(r'D:\EvonyToolKit\scripts\extraction\all_config_sol_paths.txt')
KHAN_CSV = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\khanaccounts.csv')
OUTPUT_DIR = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\accounts_fresh')

# Tor proxy to bypass rate limiting
TOR_PROXY_HOST = '127.0.0.1'
TOR_PROXY_PORT = 9999
TOR_PROXY_TYPE = 'SOCKS5'

MAX_RETRIES = 3
RETRY_DELAY = 0.5
DELAY_BETWEEN = 0.3

# ============================================================================
# LOAD ACCOUNTS
# ============================================================================
def load_sol_accounts():
    """Load accounts from SOL files"""
    if not SOL_PATHS_FILE.exists():
        return {}
    
    handler = SOLHandler()
    accounts = {}
    
    with open(SOL_PATHS_FILE, 'r') as f:
        paths = [line.strip() for line in f if line.strip()]
    
    for path in paths:
        if not os.path.exists(path):
            continue
        try:
            data = handler.read_sol(path)
            if data and '_error' not in data:
                info = handler.extract_account_info(data)
                email = info.get('email', '').lower().strip()
                if email and info.get('password'):
                    if email not in accounts or info.get('server_ip'):
                        accounts[email] = {
                            'email': info['email'],
                            'password': info['password'],
                            'server': info.get('server', 'cc2'),
                            'source': 'sol',
                        }
        except:
            pass
    
    return accounts

def load_csv_accounts():
    """Load from khan CSV"""
    if not KHAN_CSV.exists():
        return {}
    
    STATUS_WORDS = ['active', 'inactive', 'not working', 'working', 'semi', 'dead', 'banned']
    accounts = {}
    
    with open(KHAN_CSV, 'r', encoding='utf-8', errors='ignore') as f:
        for line in f:
            parts = line.strip().split(',', 1)
            if len(parts) >= 2:
                email = parts[0].strip()
                pwd = parts[1].strip()
                if not any(s in pwd.lower() for s in STATUS_WORDS) and len(pwd) >= 3:
                    accounts[email.lower()] = {
                        'email': email,
                        'password': pwd,
                        'server': 'cc2',
                        'source': 'csv',
                    }
    
    return accounts

# ============================================================================
# EXTRACTION WITH RETRY
# ============================================================================
def extract_with_retry(email, password, server='cc2'):
    """Extract account with retry for logged-in accounts, using Tor proxy"""
    last_error = "Unknown"
    
    for attempt in range(MAX_RETRIES):
        client = None
        try:
            client = EvonyClient(server, callback=lambda m: None, timeout=60)
            
            # Connect through Tor proxy to bypass rate limiting
            if not client.connect(proxy_host=TOR_PROXY_HOST, proxy_port=TOR_PROXY_PORT, proxy_type=TOR_PROXY_TYPE):
                last_error = "Connection failed"
                if attempt < MAX_RETRIES - 1:
                    time.sleep(RETRY_DELAY)
                    continue
                return None, last_error
            
            if client.login(email, password):
                data = client.extract_account()
                client.close()
                return data, None
            else:
                if client:
                    client.close()
                last_error = "Login failed"
                if attempt < MAX_RETRIES - 1:
                    time.sleep(RETRY_DELAY)
                    continue
                return None, last_error
                
        except KeyboardInterrupt:
            if client:
                client.close()
            raise
        except Exception as e:
            if client:
                try:
                    client.close()
                except:
                    pass
            last_error = str(e)[:30]
            if attempt < MAX_RETRIES - 1:
                time.sleep(RETRY_DELAY)
                continue
            return None, last_error
    
    return None, last_error

# ============================================================================
# MAIN
# ============================================================================
def main():
    print("=" * 70)
    print("MASTER EXTRACT - Using Working Client")
    print("=" * 70)
    
    # Parse args
    test_count = None
    for i, arg in enumerate(sys.argv):
        if arg == '--test' and i + 1 < len(sys.argv):
            test_count = int(sys.argv[i + 1])
    
    # Load accounts
    print("\n[1] Loading accounts...")
    sol_accounts = load_sol_accounts()
    csv_accounts = load_csv_accounts()
    
    # Merge (SOL preferred)
    all_accounts = {}
    for email, acc in sol_accounts.items():
        all_accounts[email] = acc
    for email, acc in csv_accounts.items():
        if email not in all_accounts:
            all_accounts[email] = acc
    
    accounts = list(all_accounts.values())
    print(f"    SOL: {len(sol_accounts)}, CSV: {len(csv_accounts)}, Total: {len(accounts)}")
    
    if test_count:
        accounts = accounts[:test_count]
        print(f"\n[TEST MODE] {len(accounts)} accounts")
    
    # Extract
    print(f"\n[2] Extracting (retry={MAX_RETRIES})...")
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    
    success = 0
    failed = 0
    errors = defaultdict(int)
    
    start_time = time.time()
    
    for i, acc in enumerate(accounts, 1):
        email = acc['email']
        pct = (i / len(accounts)) * 100
        print(f"[{i}/{len(accounts)}] ({pct:.0f}%) {email[:35]:35}", end=" ", flush=True)
        
        data, error = extract_with_retry(email, acc['password'], acc['server'])
        
        if data and 'error' not in data:
            safe = email.replace('@', '').replace('.', '')
            outfile = OUTPUT_DIR / f"{safe}.json"
            
            with open(outfile, 'w') as f:
                json.dump(data, f, indent=2, default=str)
            
            name = data.get('player_name', '?')
            cities = len(data.get('cities', []))
            print(f"✓ {name} ({cities})")
            success += 1
        else:
            err = error or data.get('error', 'Unknown')
            print(f"✗ {err}")
            failed += 1
            errors[err] += 1
        
        time.sleep(DELAY_BETWEEN)
    
    elapsed = time.time() - start_time
    
    print("\n" + "=" * 70)
    print(f"DONE: {success} success, {failed} failed in {elapsed:.0f}s")
    print(f"Output: {OUTPUT_DIR}")
    
    if errors:
        print("\nErrors:")
        for e, c in sorted(errors.items(), key=lambda x: -x[1]):
            print(f"  {e}: {c}")

if __name__ == '__main__':
    main()
