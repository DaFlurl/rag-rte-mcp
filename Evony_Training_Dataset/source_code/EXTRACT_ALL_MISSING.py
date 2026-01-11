#!/usr/bin/env python3
"""
COMPLETE EXTRACTION - Extract ALL missing accounts
Uses Tor proxy to avoid rate limiting
"""
import json
import sys
import time
from pathlib import Path
from datetime import datetime

sys.path.insert(0, r'D:\EvonyToolKit\sol_manager\extractor')
from evony_client import EvonyClient

FRESH_DIR = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\accounts_fresh')
SOL_FILE = Path(r'D:\EvonyToolKit\scripts\extraction\all_discovered_accounts.json')
CSV_FILE = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\khanaccounts.csv')

TOR_HOST = '127.0.0.1'
TOR_PORT = 9999
TOR_TYPE = 'SOCKS5'

MAX_RETRIES = 3
DELAY_BETWEEN = 1.0

def get_all_accounts():
    all_accounts = {}
    
    # Load SOL accounts
    sol_data = json.load(open(SOL_FILE))
    for acc in sol_data['accounts']:
        email = acc['email'].lower()
        all_accounts[email] = {
            'email': acc['email'],
            'password': acc['password'],
            'server': acc.get('server', 'cc2'),
        }
    
    # Load CSV accounts
    STATUS_WORDS = ['active', 'inactive', 'not working', 'working', 'semi', 'dead', 'banned', 'deleted']
    with open(CSV_FILE, 'r', encoding='utf-8', errors='ignore') as f:
        for line in f:
            parts = line.strip().split(',', 1)
            if len(parts) >= 2:
                email = parts[0].strip()
                pwd = parts[1].strip()
                if not any(s in pwd.lower() for s in STATUS_WORDS) and len(pwd) >= 4:
                    if email.lower() not in all_accounts:
                        all_accounts[email.lower()] = {
                            'email': email,
                            'password': pwd,
                            'server': 'cc2',
                        }
    
    return all_accounts

def get_extracted_emails():
    extracted = set()
    for f in FRESH_DIR.glob('*.json'):
        try:
            data = json.load(open(f))
            email = data.get('email', '').lower()
            if email:
                extracted.add(email)
        except:
            pass
    return extracted

def extract_account(acc):
    email = acc['email']
    password = acc['password']
    server = acc.get('server', 'cc2')
    
    for attempt in range(MAX_RETRIES):
        client = None
        try:
            client = EvonyClient(server, callback=lambda m: None, timeout=60)
            
            if not client.connect(proxy_host=TOR_HOST, proxy_port=TOR_PORT, proxy_type=TOR_TYPE):
                if client:
                    client.close()
                if attempt < MAX_RETRIES - 1:
                    time.sleep(0.5)
                    continue
                return None
            
            if client.login(email, password):
                data = client.extract_account()
                client.close()
                if data.get('cities') and len(data['cities']) > 0:
                    return data
                return None
            else:
                if client:
                    client.close()
                if attempt < MAX_RETRIES - 1:
                    time.sleep(0.5)
                    continue
                return None
                
        except Exception as e:
            if client:
                try:
                    client.close()
                except:
                    pass
            if attempt < MAX_RETRIES - 1:
                time.sleep(0.5)
                continue
            return None
    
    return None

def main():
    print("=" * 70)
    print("EVONY COMPLETE EXTRACTION - ALL MISSING ACCOUNTS")
    print("Started:", datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
    print("=" * 70)
    
    all_accounts = get_all_accounts()
    extracted = get_extracted_emails()
    
    missing = {e: a for e, a in all_accounts.items() if e not in extracted}
    
    print("Total accounts:", len(all_accounts))
    print("Already extracted:", len(extracted))
    print("Missing to extract:", len(missing))
    print("Tor proxy:", TOR_HOST, TOR_PORT)
    print("=" * 70)
    
    if not missing:
        print("All accounts already extracted!")
        return
    
    success = 0
    failed = 0
    
    for i, (email, acc) in enumerate(missing.items(), 1):
        print("[%d/%d] %s..." % (i, len(missing), email), end=" ", flush=True)
        
        data = extract_account(acc)
        
        if data and data.get('cities'):
            safe_name = email.replace('@', '').replace('.', '') + '.json'
            output_file = FRESH_DIR / safe_name
            
            with open(output_file, 'w') as f:
                json.dump(data, f, indent=2)
            
            cities = len(data.get('cities', []))
            print("OK - %d cities" % cities)
            success += 1
        else:
            print("FAILED")
            failed += 1
        
        time.sleep(DELAY_BETWEEN)
        
        if i % 25 == 0:
            print("--- Progress: %d/%d | Success: %d | Failed: %d ---" % (i, len(missing), success, failed))
    
    print("=" * 70)
    print("EXTRACTION COMPLETE")
    print("Success:", success)
    print("Failed:", failed)
    print("Total extracted:", len(extracted) + success)
    print("=" * 70)

if __name__ == '__main__':
    main()
