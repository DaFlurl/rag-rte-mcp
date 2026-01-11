#!/usr/bin/env python3
"""Debug response structure to fix data extraction"""
import requests

BASE = 'http://localhost:9999'

# Get logs to see actual response structure
r = requests.get(f'{BASE}/api/logs', timeout=5)
logs = r.json()

print("=== Last 10 Received Responses ===")
for log in logs[-15:]:
    if log.get('type') == 'received':
        cmd = log.get('cmd', 'unknown')
        data = log.get('data', '')
        print(f"CMD: {cmd}")
        print(f"DATA: {str(data)[:400]}")
        print("---")

# Check discovered
print("\n=== Discovered Data ===")
r = requests.get(f'{BASE}/api/discovered', timeout=5)
print(r.json())
