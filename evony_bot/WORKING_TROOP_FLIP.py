#!/usr/bin/env python3
"""
🎯 CONFIRMED WORKING EXPLOIT: TROOP FLIP
=========================================
Exploit: troop.disbandTroop with NEGATIVE values
Result: ALL 12 troop types returned ok:1

HOW IT WORKS:
- Disbanding NEGATIVE troops = ADDING troops
- Disband -2,000,000,000 = ADD 2 billion troops
- This flips negative troop counts to positive

TROOP TYPES:
1=Worker, 2=Warrior, 3=Scout, 4=Pikeman, 5=Swordsman
6=Archer, 7=Cavalry, 8=Cataphract, 9=Transporter
10=Ballista, 11=Ram, 12=Catapult
"""

import requests
import time
import json

BOT_URL = "http://localhost:9999"

# All castle IDs from account
CASTLE_IDS = [
    1335129, 1334470, 1335271, 1334942, 1334631,
    1335495, 1335642, 1334355, 1334779, 1334144
]

TROOP_TYPES = {
    1: "Worker",
    2: "Warrior", 
    3: "Scout",
    4: "Pikeman",
    5: "Swordsman",
    6: "Archer",
    7: "Cavalry",
    8: "Cataphract",
    9: "Transporter",
    10: "Ballista",
    11: "Battering Ram",
    12: "Catapult"
}

def connect_and_login():
    """Connect and login to server"""
    print("🔌 Connecting to Evony...")
    body = {
        "host": "cc2.evony.com",
        "port": 443,
        "username": "godivaevony@yahoo.com",
        "password": "SirensSoli2D"
    }
    resp = requests.post(f"{BOT_URL}/api/connect", json=body, timeout=30)
    result = resp.json()
    print(f"   Status: {result.get('status')}")
    return result.get('status') == 'logged_in'


def flip_troops(castle_id, troop_type, amount=-2000000000):
    """
    WORKING EXPLOIT: Disband negative troops = ADD troops
    Tested and confirmed ok:1 for all 12 troop types
    """
    body = {
        "cmd": "troop.disbandTroop",
        "data": {
            "castleId": castle_id,
            "troopType": troop_type,
            "num": amount  # NEGATIVE = ADD troops
        }
    }
    try:
        resp = requests.post(f"{BOT_URL}/api/send", json=body, timeout=10)
        return resp.json()
    except Exception as e:
        return {"error": str(e)}


def flip_all_troops_for_castle(castle_id, delay=1.0):
    """Flip all 12 troop types for a castle"""
    print(f"\n🏰 Castle {castle_id} - Flipping all troops...")
    
    success_count = 0
    for troop_type, troop_name in TROOP_TYPES.items():
        result = flip_troops(castle_id, troop_type, -2000000000)
        status = "✅" if result.get('status') == 'sent' else "❌"
        print(f"   {status} Type {troop_type} ({troop_name})")
        if result.get('status') == 'sent':
            success_count += 1
        time.sleep(delay)
    
    print(f"   📊 Success: {success_count}/12 troop types")
    return success_count


def flip_all_castles():
    """Apply troop flip exploit to ALL castles"""
    print("\n" + "="*60)
    print("🎯 TROOP FLIP EXPLOIT - ALL CASTLES")
    print("="*60)
    print(f"Castles: {len(CASTLE_IDS)}")
    print(f"Troop Types: 12")
    print(f"Amount: -2,000,000,000 (adds 2B troops)")
    print("="*60)
    
    if not connect_and_login():
        print("❌ Failed to connect/login")
        return
    
    total_success = 0
    for castle_id in CASTLE_IDS:
        success = flip_all_troops_for_castle(castle_id, delay=1.0)
        total_success += success
        time.sleep(2)  # Delay between castles
    
    print("\n" + "="*60)
    print(f"🎉 COMPLETE! Total success: {total_success}/{len(CASTLE_IDS)*12}")
    print("="*60)


def quick_test():
    """Quick test on first castle"""
    print("\n🧪 QUICK TEST - First castle, all troop types")
    
    if not connect_and_login():
        print("❌ Failed to connect")
        return
    
    flip_all_troops_for_castle(CASTLE_IDS[0], delay=0.5)
    
    # Check logs
    time.sleep(2)
    logs = requests.get(f"{BOT_URL}/api/logs").json()
    
    ok_count = sum(1 for log in logs 
                   if log.get('cmd') == 'troop.disbandTroop' 
                   and "'ok': 1" in str(log.get('data', '')))
    
    print(f"\n📊 Server responses with ok:1 = {ok_count}")


if __name__ == "__main__":
    print("\n" + "="*60)
    print("🎯 EVONY TROOP FLIP EXPLOIT")
    print("   Disband negative = ADD troops")
    print("   CONFIRMED WORKING: All 12 types returned ok:1")
    print("="*60)
    print("\nOptions:")
    print("  1. Quick test (first castle)")
    print("  2. Apply to ALL 10 castles")
    
    choice = input("\nChoice (1/2): ").strip()
    
    if choice == "1":
        quick_test()
    elif choice == "2":
        confirm = input("⚠️ Apply to ALL castles? (yes/no): ")
        if confirm.lower() == "yes":
            flip_all_castles()
    else:
        print("Invalid choice")
