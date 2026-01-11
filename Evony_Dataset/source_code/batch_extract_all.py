"""
BATCH ACCOUNT EXTRACTOR v1.0
Creates RoboEvony batch scripts and parses output to JSON

WORKFLOW:
1. Run this script to generate RoboEvony batch commands
2. Run the generated script in RoboEvony (paste into script tab)
3. Copy console output
4. Run this script with --parse to convert output to JSON
"""
import csv
import json
import re
import sys
from pathlib import Path
from datetime import datetime

# Paths
KHAN_CSV = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\khanaccounts.csv')
OUTPUT_DIR = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\accounts')
SCRIPT_OUTPUT = Path(r'D:\EvonyToolKit\scripts\extraction\BATCH_EXTRACT_ALL.txt')

def load_accounts():
    """Load all accounts from khanaccounts.csv"""
    accounts = []
    with open(KHAN_CSV, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            if row.get('email') and row.get('password'):
                accounts.append({
                    'email': row['email'],
                    'password': row['password'],
                    'server': row.get('server', ''),
                })
    return accounts

def generate_extraction_script():
    """Generate RoboEvony script to extract all accounts"""
    accounts = load_accounts()
    print(f"Loaded {len(accounts)} accounts from CSV")
    
    script = f"""//===============================================================
// BATCH ACCOUNT EXTRACTION - Generated {datetime.now().strftime('%Y-%m-%d %H:%M')}
// Accounts: {len(accounts)}
// Run in RoboEvony, then copy console output and parse
//===============================================================

setsilence true

"""
    
    # For each account, add extraction commands
    # Note: This is a template - actual RE batch login might differ
    script += """
// EXTRACTION TEMPLATE FOR CURRENT LOGGED-IN ACCOUNT
// Run this once per account after logging in

output "===ACCOUNT_DATA_START==="
output "TIMESTAMP:%date% %time%"
output "EMAIL:%config.username%"

iferror %player.name% goto NotLoggedIn

output "PLAYER_NAME:%player.name%"
output "SERVER:%server.name%"
output "ALLIANCE:%player.alliance%"
output "PRESTIGE:%player.prestige%"
output "HONOR:%player.honor%"
output "GOLD:%player.gold%"
output "TITLE:%player.title%"
output "CITIES:%cities.count%"

// Total troops across all cities
set totalWorkers 0
set totalWarriors 0
set totalScouts 0
set totalPikes 0
set totalSwords 0
set totalArchers 0
set totalCavalry 0
set totalCataphracts 0
set totalTransporters 0
set totalRams 0
set totalBallistas 0
set totalCatapults 0

set i 0
label cityLoop
iferror %cities[%i%].name% goto doneCities

// Add this city's troops
set totalWorkers {%totalWorkers%+%cities[%i%].troops.worker%}
set totalWarriors {%totalWarriors%+%cities[%i%].troops.warrior%}
set totalScouts {%totalScouts%+%cities[%i%].troops.scout%}
set totalPikes {%totalPikes%+%cities[%i%].troops.pike%}
set totalSwords {%totalSwords%+%cities[%i%].troops.sword%}
set totalArchers {%totalArchers%+%cities[%i%].troops.archer%}
set totalCavalry {%totalCavalry%+%cities[%i%].troops.cavalry%}
set totalCataphracts {%totalCataphracts%+%cities[%i%].troops.cataphract%}
set totalTransporters {%totalTransporters%+%cities[%i%].troops.transporter%}
set totalRams {%totalRams%+%cities[%i%].troops.ram%}
set totalBallistas {%totalBallistas%+%cities[%i%].troops.ballista%}
set totalCatapults {%totalCatapults%+%cities[%i%].troops.catapult%}

set i {%i%+1}
goto cityLoop

label doneCities

output "WORKERS:%totalWorkers%"
output "WARRIORS:%totalWarriors%"
output "SCOUTS:%totalScouts%"
output "PIKEMEN:%totalPikes%"
output "SWORDSMEN:%totalSwords%"
output "ARCHERS:%totalArchers%"
output "CAVALRY:%totalCavalry%"
output "CATAPHRACTS:%totalCataphracts%"
output "TRANSPORTERS:%totalTransporters%"
output "RAMS:%totalRams%"
output "BALLISTAS:%totalBallistas%"
output "CATAPULTS:%totalCatapults%"

// Key Items
output "BANNERS:%items.Stygandrs_Banner_of_the_Horde%"
output "THUNDER_RAIDS:%items.Thunder_Raid%"
output "RECALL_AMULETS:%items.Recall_Amulet%"
output "TRUCE:%items.Truce_Agreement%"
output "FLEET_FEET:%items.Fleet_Feet%"
output "LEGENDARY_RING:%items.Legendary_Ring%"
output "GILDED_HORN:%items.Gilded_Horn%"

output "STATUS:SUCCESS"
goto End

label NotLoggedIn
output "STATUS:NOT_LOGGED_IN"

label End
output "===ACCOUNT_DATA_END==="
"""
    
    with open(SCRIPT_OUTPUT, 'w') as f:
        f.write(script)
    
    print(f"\nGenerated extraction script: {SCRIPT_OUTPUT}")
    print("\nINSTRUCTIONS:")
    print("1. Open RoboEvony")
    print("2. Login to each account")
    print("3. Paste this script in Script tab and run")
    print("4. Copy the console output")
    print("5. Run: python batch_extract_all.py --parse output.txt")

def parse_extraction_output(input_file):
    """Parse RoboEvony output and save to JSON files"""
    with open(input_file, 'r', encoding='utf-8', errors='ignore') as f:
        text = f.read()
    
    # Find all account data blocks
    pattern = r'===ACCOUNT_DATA_START===(.*?)===ACCOUNT_DATA_END==='
    matches = re.findall(pattern, text, re.DOTALL)
    
    accounts = []
    for match in matches:
        data = {}
        for line in match.strip().split('\n'):
            line = line.strip()
            if ':' in line:
                key, value = line.split(':', 1)
                key = key.strip()
                value = value.strip()
                
                # Try to convert to number
                try:
                    if '.' in value:
                        data[key] = float(value)
                    else:
                        data[key] = int(value)
                except ValueError:
                    data[key] = value
        
        if data.get('EMAIL') and data.get('STATUS') == 'SUCCESS':
            accounts.append(data)
    
    print(f"Parsed {len(accounts)} accounts")
    
    # Save each account to its own JSON file
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    
    for acc in accounts:
        email = acc.get('EMAIL', 'unknown')
        safe_email = email.replace('@', '').replace('.', '')
        
        # Build player structure matching old format
        player_data = {
            'msg': 'Fresh extraction',
            'ok': 1,
            'player': {
                'playerInfo': {
                    'userName': acc.get('PLAYER_NAME', ''),
                    'alliance': acc.get('ALLIANCE', ''),
                    'prestige': acc.get('PRESTIGE', 0),
                    'honor': acc.get('HONOR', 0),
                    'gold': acc.get('GOLD', 0),
                    'title': acc.get('TITLE', ''),
                },
                'castles': [{
                    'troop': {
                        'peasants': acc.get('WORKERS', 0),
                        'militia': acc.get('WARRIORS', 0),
                        'scouter': acc.get('SCOUTS', 0),
                        'pikemen': acc.get('PIKEMEN', 0),
                        'swordsmen': acc.get('SWORDSMEN', 0),
                        'archer': acc.get('ARCHERS', 0),
                        'lightCavalry': acc.get('CAVALRY', 0),
                        'heavyCavalry': acc.get('CATAPHRACTS', 0),
                        'carriage': acc.get('TRANSPORTERS', 0),
                        'batteringRam': acc.get('RAMS', 0),
                        'ballista': acc.get('BALLISTAS', 0),
                        'catapult': acc.get('CATAPULTS', 0),
                    }
                }],
                'items': [
                    {'id': 'player.item.stygandrsbannerofthehorde', 'count': acc.get('BANNERS', 0)},
                    {'id': 'player.trick.tblj', 'count': acc.get('THUNDER_RAIDS', 0)},
                    {'id': 'player.trick.qlbx', 'count': acc.get('RECALL_AMULETS', 0)},
                    {'id': 'player.truce.dream', 'count': acc.get('TRUCE', 0)},
                    {'id': 'player.item.fleetfeet', 'count': acc.get('FLEET_FEET', 0)},
                    {'id': 'hero.gen.npc2', 'count': acc.get('LEGENDARY_RING', 0)},
                    {'id': 'player.item.gildedhorn', 'count': acc.get('GILDED_HORN', 0)},
                ]
            },
            'extracted': datetime.now().isoformat(),
        }
        
        output_file = OUTPUT_DIR / f"{safe_email}.json"
        with open(output_file, 'w') as f:
            json.dump(player_data, f, indent=2)
        
        print(f"  Saved: {output_file.name}")
    
    print(f"\nTotal accounts saved: {len(accounts)}")
    print(f"Output directory: {OUTPUT_DIR}")

def main():
    if len(sys.argv) > 1:
        if sys.argv[1] == '--parse' and len(sys.argv) > 2:
            parse_extraction_output(sys.argv[2])
        elif sys.argv[1] == '--help':
            print(__doc__)
        else:
            print(f"Unknown argument: {sys.argv[1]}")
            print("Use --parse <file> to parse RoboEvony output")
    else:
        generate_extraction_script()

if __name__ == '__main__':
    main()
