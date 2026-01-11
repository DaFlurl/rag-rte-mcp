"""
Find Historic Heroes from accounts that can no longer be logged into.
These heroes may have returned to the game server when accounts became inactive/deleted.
"""

import os
import json
import re
from collections import defaultdict

# Paths
HH_FILE = r"D:\EvonyToolKit\scripts\Roboevony_scripts\HH_Heroes_To_Get.txt"
KHANS_HEROES_FILE = r"D:\EvonyToolKit\scripts\Roboevony_scripts\Khans_Heroes.txt"
OLD_ACCOUNTS_DIR = r"D:\EvonyToolKit\scripts\khan_Accounts_556\accounts"
FRESH_ACCOUNTS_DIR = r"D:\EvonyToolKit\scripts\khan_Accounts_556\accounts_fresh"

# Known Historic Heroes list (famous historical figures)
HISTORIC_HERO_KEYWORDS = [
    "Charlemagne", "William the Conqueror", "Marco Polo", "Peter the Great",
    "Oliver Cromwell", "Cardinal Richelieu", "Elizabeth I", "Henry", "Richard",
    "Macbeth", "Boru", "Cromwell", "Vespucci", "Borgia", "Botticelli", "Durer",
    "Cicero", "Hippocrates", "Plato", "Aristotle", "Caesar", "Augustus",
    "Charlemagne", "Napoleon", "Joan", "Anne", "Mary", "Catherine",
    "Frederick", "Louis", "Charles", "Philip", "Edward", "George",
    "Sultan", "Emperor", "King", "Queen", "Duke", "Earl", "Baron",
    "Pope", "Saint", "St.", "Sir", "Lord", "Lady",
    # Add more historic identifiers
]

def normalize_email(email):
    """Normalize email for comparison"""
    email = email.lower().strip()
    email = email.replace("mailto:", "")
    return email

def parse_hh_heroes_file():
    """Parse HH_Heroes_To_Get.txt to get historic heroes by account"""
    heroes_by_account = defaultdict(list)
    
    with open(HH_FILE, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            
            # Format: mailto:email coords hero_name
            # Example: mailto:marknewsome1@sky.com 315,730 Manuela Beltran
            match = re.match(r'(?:mailto:)?(\S+@\S+)\s+(\d+,\d+)\s+(.+)', line)
            if match:
                email = normalize_email(match.group(1))
                coords = match.group(2)
                hero_name = match.group(3).strip()
                heroes_by_account[email].append({
                    'hero': hero_name,
                    'coords': coords
                })
    
    return heroes_by_account

def parse_khans_heroes_file():
    """Parse Khans_Heroes.txt to get city locations by account"""
    cities_by_account = defaultdict(list)
    
    with open(KHANS_HEROES_FILE, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            
            # Format: email coords
            parts = line.split()
            if len(parts) >= 2:
                email = normalize_email(parts[0])
                coords = parts[1]
                cities_by_account[email].append(coords)
    
    return cities_by_account

def get_fresh_accounts():
    """Get list of accounts that were successfully extracted (can login)"""
    fresh = set()
    if os.path.exists(FRESH_ACCOUNTS_DIR):
        for f in os.listdir(FRESH_ACCOUNTS_DIR):
            if f.endswith('.json'):
                # Extract email from filename
                name = f.replace('.json', '')
                fresh.add(name.lower())
    return fresh

def get_old_accounts_with_heroes():
    """Scan old account JSON files for heroes"""
    accounts_heroes = {}
    
    if not os.path.exists(OLD_ACCOUNTS_DIR):
        return accounts_heroes
    
    for filename in os.listdir(OLD_ACCOUNTS_DIR):
        if not filename.endswith('.json'):
            continue
        
        filepath = os.path.join(OLD_ACCOUNTS_DIR, filename)
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                data = json.load(f)
            
            # Extract email
            email = data.get('email', filename.replace('.json', ''))
            email = normalize_email(email)
            
            # Extract heroes from castles
            heroes = []
            castles = data.get('castles', [])
            for castle in castles:
                castle_heroes = castle.get('heroes', [])
                for hero in castle_heroes:
                    hero_name = hero.get('name', '')
                    hero_level = hero.get('level', 0)
                    hero_id = hero.get('id', 0)
                    
                    if hero_name:
                        heroes.append({
                            'name': hero_name,
                            'level': hero_level,
                            'id': hero_id,
                            'castle': castle.get('name', 'Unknown'),
                            'coords': f"{castle.get('x', 0)},{castle.get('y', 0)}"
                        })
            
            if heroes:
                accounts_heroes[email] = {
                    'heroes': heroes,
                    'filename': filename
                }
                
        except Exception as e:
            pass
    
    return accounts_heroes

def find_lost_historic_heroes():
    """Main function to find historic heroes from failed accounts"""
    
    print("=" * 70)
    print("HISTORIC HEROES FROM INACTIVE/DELETED ACCOUNTS")
    print("These heroes may have returned to the game server!")
    print("=" * 70)
    print()
    
    # Parse HH heroes file
    hh_by_account = parse_hh_heroes_file()
    print(f"Found {len(hh_by_account)} accounts in HH_Heroes_To_Get.txt")
    
    # Parse Khans heroes file
    cities_by_account = parse_khans_heroes_file()
    print(f"Found {len(cities_by_account)} accounts in Khans_Heroes.txt")
    
    # Get fresh (working) accounts
    fresh_accounts = get_fresh_accounts()
    print(f"Found {len(fresh_accounts)} successfully extracted accounts")
    
    # Get old accounts with heroes
    old_accounts = get_old_accounts_with_heroes()
    print(f"Found {len(old_accounts)} old account JSON files with heroes")
    print()
    
    # Find accounts with HH that failed login
    lost_hh = []
    
    for email, heroes in hh_by_account.items():
        # Check if account failed to login (not in fresh accounts)
        email_variants = [
            email,
            email.replace('@', ''),
            email.replace('.', '').replace('@', ''),
        ]
        
        account_works = False
        for variant in email_variants:
            if any(variant in fa for fa in fresh_accounts):
                account_works = True
                break
        
        if not account_works:
            for hero_info in heroes:
                lost_hh.append({
                    'email': email,
                    'hero': hero_info['hero'],
                    'last_coords': hero_info['coords'],
                    'source': 'HH_Heroes_To_Get.txt'
                })
    
    # Sort by hero name
    lost_hh.sort(key=lambda x: x['hero'])
    
    # Print results
    print("=" * 70)
    print(f"LOST HISTORIC HEROES ({len(lost_hh)} heroes from inactive accounts)")
    print("=" * 70)
    print()
    print(f"{'Hero Name':<45} {'Last Coords':<12} Account")
    print("-" * 70)
    
    for item in lost_hh:
        print(f"{item['hero']:<45} {item['last_coords']:<12} {item['email']}")
    
    # Group by account for easier searching
    print()
    print("=" * 70)
    print("GROUPED BY ACCOUNT (for server searching)")
    print("=" * 70)
    
    accounts_grouped = defaultdict(list)
    for item in lost_hh:
        accounts_grouped[item['email']].append(item)
    
    for email, items in sorted(accounts_grouped.items()):
        print(f"\n{email}:")
        for item in items:
            print(f"  - {item['hero']} at ({item['last_coords']})")
    
    # Save to file
    output_file = r"D:\EvonyToolKit\scripts\extraction\LOST_HISTORIC_HEROES.txt"
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("LOST HISTORIC HEROES FROM INACTIVE ACCOUNTS\n")
        f.write("These heroes may have returned to the game server!\n")
        f.write("Search these coordinates on CC2 server to find them.\n")
        f.write("=" * 70 + "\n\n")
        
        f.write(f"Total: {len(lost_hh)} historic heroes from {len(accounts_grouped)} inactive accounts\n\n")
        
        f.write("HERO LIST (sorted by name):\n")
        f.write("-" * 70 + "\n")
        for item in lost_hh:
            f.write(f"{item['hero']:<45} ({item['last_coords']}) - {item['email']}\n")
        
        f.write("\n\nGROUPED BY ACCOUNT:\n")
        f.write("-" * 70 + "\n")
        for email, items in sorted(accounts_grouped.items()):
            f.write(f"\n{email}:\n")
            for item in items:
                f.write(f"  - {item['hero']} at ({item['last_coords']})\n")
    
    print(f"\n\nResults saved to: {output_file}")
    
    return lost_hh, accounts_grouped

if __name__ == "__main__":
    lost_hh, accounts = find_lost_historic_heroes()
