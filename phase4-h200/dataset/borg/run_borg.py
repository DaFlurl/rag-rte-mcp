#!/usr/bin/env python3
# BORG TOOLKIT - Main Launcher
"""
Enterprise-grade Evony exploitation framework.
Complete toolkit for reverse engineering, packet injection, and automated cheats.

Usage:
    python run_borg.py              # Interactive menu
    python run_borg.py --exploit    # Run exploit mode
    python run_borg.py --connect    # Connect to server
"""

import sys
import json
import argparse
from pathlib import Path
from datetime import datetime

# Add src to path
sys.path.insert(0, str(Path(__file__).parent / "src"))

try:
    from connection import EvonyConnection, EVONY_KEYS, SERVER_IPS
    from injection import PacketForge, PacketInjector, SignatureGenerator
    from exploits import (BorgExploitEngine, FoodConsumptionExploit, 
                          ResourceOverflowExploit, ItemDuplicationExploit,
                          TROOP_COSTS, OVERFLOW_THRESHOLDS)
    from cheats import BorgCheatEngine, ITEM_IDS, TROOP_TYPES
    MODULES_LOADED = True
except ImportError as e:
    print(f"[!] Module import error: {e}")
    MODULES_LOADED = False


def print_banner():
    print("""
╔═══════════════════════════════════════════════════════════════════════════════╗
║                                                                               ║
║   ██████╗  ██████╗ ██████╗  ██████╗     ████████╗ ██████╗  ██████╗ ██╗       ║
║   ██╔══██╗██╔═══██╗██╔══██╗██╔════╝     ╚══██╔══╝██╔═══██╗██╔═══██╗██║       ║
║   ██████╔╝██║   ██║██████╔╝██║  ███╗       ██║   ██║   ██║██║   ██║██║       ║
║   ██╔══██╗██║   ██║██╔══██╗██║   ██║       ██║   ██║   ██║██║   ██║██║       ║
║   ██████╔╝╚██████╔╝██║  ██║╚██████╔╝       ██║   ╚██████╔╝╚██████╔╝███████╗  ║
║   ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝        ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝  ║
║                                                                               ║
║                    ENTERPRISE EVONY EXPLOITATION FRAMEWORK                    ║
║                         v2.0 - Resistance is Futile                           ║
║                                                                               ║
╠═══════════════════════════════════════════════════════════════════════════════╣
║  Features:                                                                    ║
║    • Live server connection & packet capture                                  ║
║    • Packet injection with extracted encryption keys                          ║
║    • Working exploits: Food glitch, Item dupe, Race conditions                ║
║    • Automated cheat sequences                                                ║
║    • 168 protocol commands extracted                                          ║
╚═══════════════════════════════════════════════════════════════════════════════╝
    """)


def show_main_menu():
    print("""
┌───────────────────────────────────────────────────────────────────────────────┐
│                                MAIN MENU                                      │
├───────────────────────────────────────────────────────────────────────────────┤
│  CONNECTION                      │  EXPLOITS                                  │
│    1. Connect to Server          │    5. Food Glitch (Overflow)               │
│    2. Test Connection            │    6. Item Duplication                     │
│    3. Show Server List           │    7. Quest Reward Dupe                    │
│                                  │    8. Valley Troop Hiding                  │
│  INJECTION                       │                                            │
│    4. Forge Packets              │  CHEATS                                    │
│                                  │    9. Resource Cheats                      │
│  ANALYSIS                        │   10. Troop Cheats                         │
│   11. Calculate Overflow         │   11. Item Cheats                          │
│   12. Show Encryption Keys       │   12. Speed Cheats                         │
│   13. Protocol Commands          │                                            │
│                                  │  UTILITIES                                 │
│                                  │   14. Export Data                          │
│                                  │   15. View Documentation                   │
│                                  │    0. Exit                                 │
└───────────────────────────────────────────────────────────────────────────────┘
    """)


def show_exploit_summary():
    """Show summary of working exploits"""
    print("\n" + "=" * 70)
    print("WORKING EXPLOITS SUMMARY")
    print("=" * 70)
    
    exploits = [
        {
            'name': 'FOOD GLITCH (Troop Overflow)',
            'status': 'KNOWN WORKING (pre-2012 servers)',
            'description': 'Queue troops above overflow threshold, cancel for resource gain',
            'command': 'troop.produceTroop → troop.cancelTroopProduce',
        },
        {
            'name': 'VALLEY HIDING (Food Bypass)',
            'status': 'ALWAYS WORKS',
            'description': 'Send troops to valleys to avoid food consumption',
            'command': 'army.newArmy (missionType=4)',
        },
        {
            'name': 'ITEM DUPLICATION',
            'status': 'VARIABLE (depends on server load)',
            'description': 'Race condition - send many use requests simultaneously',
            'command': 'shop.useGoods (×N parallel)',
        },
        {
            'name': 'QUEST REWARD DUPE',
            'status': 'VARIABLE',
            'description': 'Race condition on quest completion',
            'command': 'quest.award (×N parallel)',
        },
        {
            'name': 'NEGATIVE VALUE INJECTION',
            'status': 'LIKELY PATCHED - needs testing',
            'description': 'Send negative quantities to reverse operations',
            'command': 'shop.buy/sellItem (num=-1)',
        },
    ]
    
    for i, exp in enumerate(exploits, 1):
        print(f"\n[{i}] {exp['name']}")
        print(f"    Status: {exp['status']}")
        print(f"    Method: {exp['description']}")
        print(f"    Command: {exp['command']}")


def show_overflow_calculator():
    """Interactive overflow calculator"""
    print("\n" + "=" * 70)
    print("TROOP OVERFLOW CALCULATOR")
    print("=" * 70)
    
    print("\nTroop Types and Overflow Thresholds:")
    print("-" * 50)
    
    for troop, threshold in OVERFLOW_THRESHOLDS.items():
        cost = TROOP_COSTS.get(troop, 0)
        print(f"  {troop:12} | Cost: {cost:>5} food | Threshold: {threshold:>12,}")
    
    print("\n" + "-" * 50)
    print("Enter troop type to calculate (or 'back' to return):")
    
    troop = input("Troop type: ").strip().lower()
    if troop == 'back':
        return
    
    if troop not in TROOP_COSTS:
        print(f"[!] Unknown troop: {troop}")
        return
    
    try:
        num = int(input("Number of troops: ").strip())
    except ValueError:
        print("[!] Invalid number")
        return
    
    cost = TROOP_COSTS[troop]
    total = num * cost
    threshold = OVERFLOW_THRESHOLDS[troop]
    
    INT32_MAX = 2147483647
    
    print(f"\n--- CALCULATION ---")
    print(f"Troop: {troop}")
    print(f"Quantity: {num:,}")
    print(f"Cost per unit: {cost:,} food")
    print(f"Total cost: {total:,}")
    print(f"INT32_MAX: {INT32_MAX:,}")
    print(f"Overflow threshold: {threshold:,}")
    
    if total > INT32_MAX:
        wrapped = total & 0xFFFFFFFF
        if wrapped > INT32_MAX:
            wrapped = wrapped - 0x100000000
        
        print(f"\n🎯 OVERFLOW DETECTED!")
        print(f"   Wrapped value: {wrapped:,}")
        print(f"   Is negative: {wrapped < 0}")
        if wrapped < 0:
            print(f"   💰 EXPECTED GAIN ON CANCEL: {abs(wrapped):,} food")
    else:
        print(f"\n❌ No overflow. Need at least {threshold + 1:,} troops.")


def show_encryption_keys():
    """Display extracted encryption keys"""
    print("\n" + "=" * 70)
    print("EXTRACTED ENCRYPTION KEYS (from EvonyClient1921.swf)")
    print("=" * 70)
    
    for key_name, key_value in EVONY_KEYS.items():
        if isinstance(key_value, int):
            print(f"\n  {key_name}:")
            print(f"    Hex: 0x{key_value:02X}")
            print(f"    Dec: {key_value}")
        else:
            print(f"\n  {key_name}:")
            print(f"    {key_value}")
    
    print("\n" + "-" * 70)
    print("USAGE:")
    print("  API Signature: MD5(data + API_KEY)")
    print("  Action Signature: MD5(command + params + ACTION_KEY)")
    print("  Password Hash: MD5(password + 'evony')")


def show_server_list():
    """Display known servers"""
    print("\n" + "=" * 70)
    print("KNOWN EVONY SERVERS")
    print("=" * 70)
    
    print("\n  Server ID    | IP Address")
    print("  " + "-" * 35)
    for server, ip in sorted(SERVER_IPS.items()):
        print(f"  {server:12} | {ip}")
    
    print(f"\n  Total: {len(SERVER_IPS)} servers")


def run_food_glitch_demo():
    """Run food glitch exploit demo"""
    print("\n" + "=" * 70)
    print("FOOD GLITCH EXPLOIT")
    print("=" * 70)
    
    if not MODULES_LOADED:
        print("[!] Modules not loaded")
        return
    
    engine = BorgExploitEngine()
    
    print("\nThis exploit uses integer overflow in troop production.")
    print("When total cost > INT32_MAX, it wraps to negative.")
    print("Canceling production gives 'refund' of negative = GAIN.\n")
    
    # Demo calculation
    print("ARCHER GLITCH EXAMPLE:")
    print("-" * 40)
    
    result = engine.resource.execute_troop_glitch(
        castle_id=12345,
        position_id=1,
        troop_type='archer'
    )
    
    print(f"\nExploit Ready: {result.success}")
    print(f"Message: {result.message}")
    print("\nPackets to send:")
    for key, value in result.data.items():
        if 'command' in key.lower():
            print(f"  {key}: {value}")
        elif 'params' in key.lower():
            print(f"  {key}: {json.dumps(value, indent=4)}")
        else:
            print(f"  {key}: {value}")


def run_item_dupe_demo():
    """Run item duplication demo"""
    print("\n" + "=" * 70)
    print("ITEM DUPLICATION EXPLOIT")
    print("=" * 70)
    
    if not MODULES_LOADED:
        print("[!] Modules not loaded")
        return
    
    engine = BorgExploitEngine()
    
    print("\nThis exploit uses race conditions in item usage.")
    print("Send many 'use item' packets simultaneously.")
    print("Server may process multiple before decrementing count.\n")
    
    print("Available item targets:")
    for name, item_id in list(ITEM_IDS.items())[:10]:
        print(f"  {name}: {item_id}")
    
    result = engine.items.execute_item_dupe(
        castle_id=12345,
        item_id=ITEM_IDS['speed_1hr'],
        simultaneous_requests=10
    )
    
    print(f"\n{result}")


def run_cheat_menu():
    """Run automated cheat engine"""
    print("\n" + "=" * 70)
    print("AUTOMATED CHEAT ENGINE")
    print("=" * 70)
    
    if not MODULES_LOADED:
        print("[!] Modules not loaded")
        return
    
    engine = BorgCheatEngine()
    
    print("\nAvailable Cheat Sequences:")
    for category, cheats in engine.get_all_cheats().items():
        print(f"\n  {category.upper()}:")
        for cheat in cheats:
            print(f"    • {cheat}")
    
    print("\n" + "-" * 70)
    print("DEMO - Food Glitch Sequence (Simulation):")
    
    seq = engine.resources.food_glitch_sequence(
        castle_id=12345,
        position_id=1,
        troop_type='archer'
    )
    
    print(f"\nSequence: {seq.name}")
    print(f"Description: {seq.description}")
    print(f"Actions: {len(seq.actions)}")
    
    for i, action in enumerate(seq.actions, 1):
        print(f"\n  Step {i}: {action.name}")
        print(f"    Command: {action.command}")
        print(f"    Params: {json.dumps(action.params, indent=6)}")


def interactive_mode():
    """Main interactive mode"""
    print_banner()
    
    print(f"\n[+] Modules loaded: {MODULES_LOADED}")
    if MODULES_LOADED:
        print(f"[+] Encryption keys: {len(EVONY_KEYS)}")
        print(f"[+] Known servers: {len(SERVER_IPS)}")
        print(f"[+] Troop types: {len(TROOP_TYPES)}")
        print(f"[+] Item IDs: {len(ITEM_IDS)}")
    
    while True:
        show_main_menu()
        
        try:
            choice = input("Select option: ").strip()
            
            if choice == '0':
                print("\nExiting Borg Toolkit...")
                break
            elif choice == '1':
                print("\n[*] Server connection requires credentials.")
                print("    Use: conn = EvonyConnection('na1')")
                print("    conn.connect()")
                print("    conn.login('email', 'password')")
            elif choice == '2':
                print("\n[*] Testing module imports...")
                print(f"    Modules loaded: {MODULES_LOADED}")
            elif choice == '3':
                show_server_list()
            elif choice == '4':
                print("\n[*] Packet forging available via PacketForge class")
                print("    forge = PacketForge()")
                print("    packet = forge.troop_produce_overflow(...)")
            elif choice == '5':
                run_food_glitch_demo()
            elif choice == '6':
                run_item_dupe_demo()
            elif choice == '7':
                print("\n[*] Quest dupe uses same race condition technique")
                print("    Send many quest.award packets simultaneously")
            elif choice == '8':
                print("\n[*] Valley hiding sends troops to distant valleys")
                print("    Troops don't consume food while marching/stationed")
            elif choice in ['9', '10', '11', '12'] and choice != '11':
                run_cheat_menu()
            elif choice == '11':
                show_overflow_calculator()
            elif choice == '12':
                show_encryption_keys()
            elif choice == '13':
                print("\n[*] 168 protocol commands extracted")
                print("    See: BorgToolkit/docs/PROTOCOL.md")
            elif choice == '14':
                print("\n[*] Export functions available in each module")
            elif choice == '15':
                print("\n[*] Documentation in BorgToolkit/docs/")
                print("    - ACTION_PLAN.md")
                print("    - EXPLOITS.md") 
                print("    - PROTOCOL.md")
            else:
                show_exploit_summary()
                
        except KeyboardInterrupt:
            print("\n\nExiting...")
            break
        except Exception as e:
            print(f"\n[!] Error: {e}")
        
        input("\nPress Enter to continue...")


def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(description='Borg Toolkit - Evony Exploitation Framework')
    parser.add_argument('--exploit', action='store_true', help='Run exploit mode')
    parser.add_argument('--connect', action='store_true', help='Connect to server')
    parser.add_argument('--server', type=str, default='na1', help='Server ID')
    parser.add_argument('--calc', type=str, help='Calculate overflow for troop type')
    
    args = parser.parse_args()
    
    if args.calc:
        if args.calc in OVERFLOW_THRESHOLDS:
            threshold = OVERFLOW_THRESHOLDS[args.calc]
            print(f"{args.calc}: Overflow threshold = {threshold:,}")
        else:
            print(f"Unknown troop: {args.calc}")
    elif args.exploit:
        print_banner()
        show_exploit_summary()
    elif args.connect:
        print(f"[*] Would connect to {args.server}")
        print("    Implement with: EvonyConnection('{args.server}').connect()")
    else:
        interactive_mode()


if __name__ == "__main__":
    main()
