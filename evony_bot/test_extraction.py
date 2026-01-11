#!/usr/bin/env python3
"""Test data extraction from server responses"""
import requests
import time

BASE = 'http://localhost:9999'

print("Step 1: Connecting and logging in...")
r = requests.post(f'{BASE}/api/connect', json={
    'host': 'cc2.evony.com', 'port': 443,
    'username': 'godivaevony@yahoo.com', 'password': 'SirensSoli2D'
}, timeout=30)
print(f"Connect result: {r.json().get('status')}")

print("\nStep 2: Waiting for login and responses...")
time.sleep(8)

print("\nStep 3: Checking status...")
r = requests.get(f'{BASE}/api/status', timeout=5)
status = r.json()
print(f"Connected: {status.get('connected')}")
print(f"Logged in: {status.get('logged_in')}")

print("\nStep 4: Checking discovered data...")
r = requests.get(f'{BASE}/api/discovered', timeout=5)
discovered = r.json()
print(f"Castle IDs: {discovered.get('castleIds')}")
print(f"Hero IDs: {discovered.get('heroIds')}")
print(f"Player Name: {discovered.get('playerName')}")

print("\nStep 5: Checking raw logs for castleId patterns...")
r = requests.get(f'{BASE}/api/logs', timeout=5)
logs = r.json()
castle_count = 0
for log in logs:
    if log.get('type') == 'received':
        data_str = str(log.get('data', ''))
        if 'castleId' in data_str or '636173746c654964' in data_str:
            castle_count += 1
            print(f"Found castleId in: {log.get('cmd')}")
            # Show part of the data
            print(f"  Data snippet: {data_str[:200]}")

print(f"\nTotal responses with castleId pattern: {castle_count}")

print("\nStep 6: Sending discovery command...")
r = requests.post(f'{BASE}/api/send_template', json={'template': 'get_zone_info'}, timeout=10)
print(f"Sent: {r.json()}")

time.sleep(3)

print("\nStep 7: Final discovered data check...")
r = requests.get(f'{BASE}/api/discovered', timeout=5)
discovered = r.json()
print(f"Castle IDs: {discovered.get('castleIds')}")
print(f"Hero IDs: {discovered.get('heroIds')}")

print("\n=== TEST COMPLETE ===")
