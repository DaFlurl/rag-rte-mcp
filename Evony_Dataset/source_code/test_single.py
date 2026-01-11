#!/usr/bin/env python3
"""Test a specific SOL account to debug extraction issues"""
import sys
sys.path.insert(0, r'D:\EvonyToolKit\sol_manager\extractor')
from evony_client import EvonyClient
import json

SOL_FILE = r'D:\EvonyToolKit\scripts\extraction\all_discovered_accounts.json'
sol_data = json.load(open(SOL_FILE))

# Find and test first missing SOL account
test_email = 'baseball_junky3@yahoo.com'

for acc in sol_data['accounts']:
    if acc['email'].lower() == test_email.lower():
        print(f"Testing: {acc['email']}")
        print(f"Password: {acc['password']}")
        print(f"Server: {acc.get('server', 'cc2')}")
        print(f"Server IP: {acc.get('server_ip', 'unknown')}")
        print("-" * 50)
        
        client = EvonyClient(
            server=acc.get('server', 'cc2'),
            server_ip=acc.get('server_ip', '216.66.17.168'),
            proxy=('127.0.0.1', 9999),
            timeout=30,
            verbose=True
        )
        
        result = client.login(acc['email'], acc['password'])
        print(f"\nLogin result: {result}")
        
        if result:
            data = client.extract_account()
            print(f"Cities: {len(data.get('cities', []))}")
        
        client.close()
        break
