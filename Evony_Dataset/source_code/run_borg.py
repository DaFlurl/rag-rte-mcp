# BORG TOOLKIT LAUNCHER
"""
Main launcher for the Borg Toolkit - Complete Evony RE Framework.
Run this to access all tools and generate reports.
"""

import sys
import json
from pathlib import Path
from datetime import datetime

# Add parent to path
sys.path.insert(0, str(Path(__file__).parent.parent))

from evony_hub.borg_toolkit import BorgToolkit, PROTOCOL_COMMANDS, GLITCH_THRESHOLDS
from evony_hub.exploit_discovery import ExploitDiscoveryEngine, run_full_discovery
from evony_hub.glitch_calculator import GlitchCalculator, run_glitch_calculator
from evony_hub.protocol_exploiter import generate_exploit_toolkit, CommandRegistry

HUB_ROOT = Path(r"c:\Users\Admin\Downloads\Evony_Decrypted")


def print_banner():
    print("""
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║   ██████╗  ██████╗ ██████╗  ██████╗     ████████╗ ██████╗  ██████╗ ██╗      ║
║   ██╔══██╗██╔═══██╗██╔══██╗██╔════╝     ╚══██╔══╝██╔═══██╗██╔═══██╗██║      ║
║   ██████╔╝██║   ██║██████╔╝██║  ███╗       ██║   ██║   ██║██║   ██║██║      ║
║   ██╔══██╗██║   ██║██╔══██╗██║   ██║       ██║   ██║   ██║██║   ██║██║      ║
║   ██████╔╝╚██████╔╝██║  ██║╚██████╔╝       ██║   ╚██████╔╝╚██████╔╝███████╗ ║
║   ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝        ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝ ║
║                                                                              ║
║              EVONY COMPLETE REVERSE ENGINEERING FRAMEWORK                    ║
║                    Based on EvonyClient1921.swf (2009-2018)                  ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
    """)


def show_menu():
    print("""
┌─────────────────────────────────────────────────────────────────────────────┐
│                              MAIN MENU                                       │
├─────────────────────────────────────────────────────────────────────────────┤
│  1. Show Critical Exploits                                                   │
│  2. Calculate Troop Glitch                                                   │
│  3. List All Protocol Commands                                               │
│  4. Run Full Exploit Discovery Scan                                          │
│  5. Generate Complete Exploit Report                                         │
│  6. Show Encryption Keys                                                     │
│  7. Show Flash CVE Database                                                  │
│  8. Export Full Toolkit                                                      │
│  9. Interactive Overflow Calculator                                          │
│  0. Exit                                                                     │
└─────────────────────────────────────────────────────────────────────────────┘
    """)


def show_critical_exploits(toolkit: BorgToolkit):
    print("\n" + "=" * 70)
    print("CRITICAL EXPLOITS (High Risk Commands)")
    print("=" * 70)
    
    exploits = toolkit.get_critical_exploits()
    for i, exp in enumerate(exploits, 1):
        print(f"\n[{i}] {exp['command']}")
        print(f"    Risk: {exp['risk']}")
        print(f"    Exploit: {exp['exploit']}")
        print(f"    Params: {', '.join(exp['params'])}")


def calculate_troop_glitch(toolkit: BorgToolkit):
    print("\n" + "=" * 70)
    print("TROOP GLITCH CALCULATOR")
    print("=" * 70)
    
    print("\nAvailable troop types:")
    troops = list(GLITCH_THRESHOLDS.keys())
    troops = [t for t in troops if t not in ['INT32_MAX', 'INT32_MIN', 'UINT32_MAX']]
    
    for i, troop in enumerate(troops, 1):
        threshold = GLITCH_THRESHOLDS[troop]
        print(f"  {i}. {troop}: threshold = {threshold:,}")
    
    print("\nGlitch Mechanism:")
    print("  1. Queue troops above threshold")
    print("  2. Cost calculation overflows to negative")
    print("  3. Cancel training = negative refund = RESOURCE GAIN")
    
    print("\nExample - Archer Glitch:")
    result = toolkit.calculate_overflow('archer', 6135037)
    print(f"  Queue: {result['num']:,} archers")
    print(f"  Normal cost: {result['total_cost']:,} food")
    print(f"  After overflow: {result['wrapped_value']:,}")
    print(f"  Gain on cancel: {result['gain_on_cancel']:,} food")


def list_protocol_commands(toolkit: BorgToolkit):
    print("\n" + "=" * 70)
    print("PROTOCOL COMMANDS (168 total)")
    print("=" * 70)
    
    for category, commands in PROTOCOL_COMMANDS.items():
        print(f"\n[{category.upper()}] - {len(commands)} commands")
        for cmd_name, cmd_info in commands.items():
            risk = cmd_info.get('risk', 'LOW')
            risk_marker = '⚠️' if risk in ['CRITICAL', 'HIGH'] else ''
            print(f"  • {category}.{cmd_name} {risk_marker}")


def show_encryption_keys(toolkit: BorgToolkit):
    print("\n" + "=" * 70)
    print("ENCRYPTION KEYS (Extracted from Source)")
    print("=" * 70)
    
    for key_name, key_value in toolkit.keys.items():
        if isinstance(key_value, int):
            print(f"  {key_name}: 0x{key_value:02X} ({key_value})")
        else:
            print(f"  {key_name}: {key_value}")
    
    print("\nUsage:")
    print("  API Signature: MD5(data + API_KEY)")
    print("  Action Signature: MD5(action + params + ACTION_KEY)")
    print("  User Key: MD5(server + user_id + USER_INFO_KEY)")


def show_flash_cves(toolkit: BorgToolkit):
    print("\n" + "=" * 70)
    print("FLASH CVE DATABASE (2009-2018)")
    print("=" * 70)
    
    for cve_id, cve_info in toolkit.cves.items():
        print(f"\n[{cve_id}] {cve_info['name']}")
        print(f"  Description: {cve_info['description']}")
        print(f"  Affected: {cve_info['affected']}")
        print(f"  Impact: {cve_info['impact']}")
        print(f"  Relevance to Evony: {cve_info['relevance']}")


def interactive_overflow_calc(toolkit: BorgToolkit):
    print("\n" + "=" * 70)
    print("INTERACTIVE OVERFLOW CALCULATOR")
    print("=" * 70)
    
    troops = ['worker', 'warrior', 'scout', 'pikeman', 'swordsman', 
              'archer', 'cavalry', 'cataphract', 'transporter', 
              'ballista', 'ram', 'catapult']
    
    print("\nTroop types:")
    for i, t in enumerate(troops, 1):
        print(f"  {i}. {t}")
    
    try:
        choice = int(input("\nSelect troop type (1-12): ")) - 1
        if 0 <= choice < len(troops):
            troop = troops[choice]
            num = int(input(f"Enter number of {troop}s to queue: "))
            
            result = toolkit.calculate_overflow(troop, num)
            
            print(f"\n--- RESULT ---")
            print(f"Troop: {result['troop_type']}")
            print(f"Quantity: {result['num']:,}")
            print(f"Cost per unit: {result['cost_per_unit']:,} food")
            print(f"Total cost: {result['total_cost']:,}")
            print(f"Overflowed: {result['overflowed']}")
            print(f"Wrapped value: {result['wrapped_value']:,}")
            print(f"Exploit viable: {result['exploit_viable']}")
            if result['gain_on_cancel'] > 0:
                print(f"🎯 GAIN ON CANCEL: {result['gain_on_cancel']:,} FOOD!")
    except (ValueError, IndexError):
        print("Invalid input")


def generate_full_report():
    print("\n" + "=" * 70)
    print("GENERATING COMPLETE EXPLOIT REPORT")
    print("=" * 70)
    
    output_dir = HUB_ROOT / "evony_hub" / "reports"
    output_dir.mkdir(parents=True, exist_ok=True)
    
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    
    # Generate all reports
    print("\n[1/4] Initializing Borg Toolkit...")
    toolkit = BorgToolkit()
    toolkit.export_toolkit(output_dir / f"borg_toolkit_{timestamp}.json")
    
    print("[2/4] Running Glitch Calculator...")
    calc = GlitchCalculator()
    calc.save_database(output_dir / f"glitch_database_{timestamp}.json")
    
    print("[3/4] Generating Protocol Exploit Toolkit...")
    generate_exploit_toolkit()
    
    print("[4/4] Writing Summary Report...")
    
    summary = {
        'generated': datetime.now().isoformat(),
        'total_commands': len(toolkit.get_all_commands()),
        'critical_exploits': len(toolkit.get_critical_exploits()),
        'flash_cves': len(toolkit.cves),
        'glitch_thresholds': GLITCH_THRESHOLDS,
        'encryption_keys': toolkit.keys,
        'exploit_categories': [
            'Integer Overflow (Troop Glitch)',
            'Race Conditions (Quest/Item)',
            'Negative Value Injection',
            'Protocol Command Manipulation',
            'Flash CVE Exploitation',
        ],
    }
    
    with open(output_dir / f"summary_{timestamp}.json", 'w') as f:
        json.dump(summary, f, indent=2)
    
    print(f"\n✓ Reports saved to: {output_dir}")
    print(f"  - borg_toolkit_{timestamp}.json")
    print(f"  - glitch_database_{timestamp}.json")
    print(f"  - summary_{timestamp}.json")


def main():
    print_banner()
    
    toolkit = BorgToolkit()
    
    print(f"[+] Loaded {len(toolkit.get_all_commands())} protocol commands")
    print(f"[+] Loaded {len(toolkit.get_critical_exploits())} critical exploits")
    print(f"[+] Loaded {len(toolkit.cves)} Flash CVEs")
    
    while True:
        show_menu()
        
        try:
            choice = input("Select option: ").strip()
            
            if choice == '1':
                show_critical_exploits(toolkit)
            elif choice == '2':
                calculate_troop_glitch(toolkit)
            elif choice == '3':
                list_protocol_commands(toolkit)
            elif choice == '4':
                print("\nRunning full exploit discovery scan...")
                run_full_discovery()
            elif choice == '5':
                generate_full_report()
            elif choice == '6':
                show_encryption_keys(toolkit)
            elif choice == '7':
                show_flash_cves(toolkit)
            elif choice == '8':
                toolkit.export_toolkit()
                print("\n✓ Toolkit exported!")
            elif choice == '9':
                interactive_overflow_calc(toolkit)
            elif choice == '0':
                print("\nExiting Borg Toolkit...")
                break
            else:
                print("Invalid option")
                
        except KeyboardInterrupt:
            print("\n\nExiting...")
            break
        except Exception as e:
            print(f"Error: {e}")
        
        input("\nPress Enter to continue...")


if __name__ == "__main__":
    main()
