#!/usr/bin/env python3
"""Check extraction status and identify missing accounts"""
import json
from pathlib import Path

FRESH_DIR = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\accounts_fresh')
SOL_FILE = Path(r'D:\EvonyToolKit\scripts\extraction\all_discovered_accounts.json')
CSV_FILE = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\khanaccounts.csv')

# Get fresh extracted accounts
fresh_files = list(FRESH_DIR.glob('*.json'))
fresh_emails = set()
for f in fresh_files:
    try:
        data = json.load(open(f))
        email = data.get('email', '').lower()
        if email:
            fresh_emails.add(email)
    except:
        pass

print(f"Fresh extracted: {len(fresh_files)} files, {len(fresh_emails)} unique emails")

# Get all accounts from SOL
sol_data = json.load(open(SOL_FILE))
sol_accounts = {a['email'].lower(): a for a in sol_data['accounts']}
print(f"SOL accounts: {len(sol_accounts)}")

# Get CSV accounts
STATUS_WORDS = ['active', 'inactive', 'not working', 'working', 'semi', 'dead', 'banned']
csv_accounts = {}
with open(CSV_FILE, 'r', encoding='utf-8', errors='ignore') as f:
    for line in f:
        parts = line.strip().split(',', 1)
        if len(parts) >= 2:
            email = parts[0].strip().lower()
            pwd = parts[1].strip()
            if not any(s in pwd.lower() for s in STATUS_WORDS) and len(pwd) >= 3:
                csv_accounts[email] = pwd

print(f"CSV accounts (with passwords): {len(csv_accounts)}")

# Merge all accounts
all_accounts = {}
for email, acc in sol_accounts.items():
    all_accounts[email] = acc

for email, pwd in csv_accounts.items():
    if email not in all_accounts:
        all_accounts[email] = {'email': email, 'password': pwd, 'server': 'cc2', 'server_ip': '216.66.17.168'}

print(f"Total unique accounts: {len(all_accounts)}")

# Find missing
missing = []
for email in all_accounts:
    if email not in fresh_emails:
        missing.append(email)

print(f"\nMISSING (not yet extracted): {len(missing)}")
print(f"EXTRACTED: {len(fresh_emails)}")
print(f"COMPLETION: {len(fresh_emails)}/{len(all_accounts)} ({100*len(fresh_emails)/len(all_accounts):.1f}%)")
