#!/usr/bin/env python3
"""Test all Evony Bot Server features before presenting to user"""
import requests
import time

BASE = 'http://localhost:9999'

def test_all():
    print("=" * 60)
    print("EVONY BOT SERVER - FEATURE TESTS")
    print("=" * 60)
    
    # Test 1: Connect and login
    print("\nTEST 1: Connecting and logging in...")
    try:
        r = requests.post(f'{BASE}/api/connect', json={
            'host': 'cc2.evony.com',
            'port': 443,
            'username': 'godivaevony@yahoo.com',
            'password': 'SirensSoli2D'
        }, timeout=30)
        result = r.json()
        print(f"  Result: {result.get('status', 'unknown')}")
    except Exception as e:
        print(f"  ERROR: {e}")
        return False
    
    # Wait for login
    print("  Waiting for login to complete...")
    time.sleep(5)
    
    # Test 2: Check status
    print("\nTEST 2: Checking connection status...")
    try:
        r = requests.get(f'{BASE}/api/status', timeout=5)
        status = r.json()
        print(f"  Connected: {status.get('connected')}")
        print(f"  Logged in: {status.get('logged_in')}")
        print(f"  Host: {status.get('host')}")
        
        if not status.get('connected'):
            print("  WARNING: Connection lost!")
            # Try to reconnect
            print("  Attempting reconnect...")
            r = requests.post(f'{BASE}/api/connect', json={
                'host': 'cc2.evony.com',
                'port': 443,
                'username': 'godivaevony@yahoo.com',
                'password': 'SirensSoli2D'
            }, timeout=30)
            time.sleep(5)
            r = requests.get(f'{BASE}/api/status', timeout=5)
            status = r.json()
            print(f"  After reconnect - Connected: {status.get('connected')}")
    except Exception as e:
        print(f"  ERROR: {e}")
    
    # Test 3: Get templates
    print("\nTEST 3: Checking templates...")
    try:
        r = requests.get(f'{BASE}/api/templates', timeout=5)
        templates = r.json()
        discovery = [k for k in templates.keys() if 'get_' in k or templates[k].get('category') == 'discovery']
        exploits = [k for k in templates.keys() if k not in discovery]
        print(f"  Discovery commands: {len(discovery)}")
        print(f"  Exploit templates: {len(exploits)}")
        print(f"  Discovery list: {discovery[:5]}")
    except Exception as e:
        print(f"  ERROR: {e}")
    
    # Test 4: Send discovery command
    print("\nTEST 4: Testing discovery command (get_zone_info)...")
    try:
        r = requests.post(f'{BASE}/api/send_template', json={
            'template': 'get_zone_info'
        }, timeout=10)
        result = r.json()
        print(f"  Result: {result}")
    except Exception as e:
        print(f"  ERROR: {e}")
    
    time.sleep(2)
    
    # Test 5: Send custom packet
    print("\nTEST 5: Testing custom packet send...")
    try:
        r = requests.post(f'{BASE}/api/send', json={
            'cmd': 'common.zoneInfo',
            'data': {}
        }, timeout=10)
        result = r.json()
        print(f"  Result: {result}")
    except Exception as e:
        print(f"  ERROR: {e}")
    
    time.sleep(2)
    
    # Test 6: Check logs
    print("\nTEST 6: Checking packet logs...")
    try:
        r = requests.get(f'{BASE}/api/logs', timeout=5)
        logs = r.json()
        received = [l for l in logs if l.get('type') == 'received']
        sent = [l for l in logs if l.get('type') == 'sent']
        print(f"  Total sent: {len(sent)}")
        print(f"  Total received: {len(received)}")
        
        # Show last few received
        print("  Last 5 received:")
        for log in received[-5:]:
            cmd = log.get('cmd', 'unknown')
            print(f"    - {cmd}")
    except Exception as e:
        print(f"  ERROR: {e}")
    
    print("\n" + "=" * 60)
    print("TESTS COMPLETE")
    print("=" * 60)
    
    return True

if __name__ == '__main__':
    test_all()
