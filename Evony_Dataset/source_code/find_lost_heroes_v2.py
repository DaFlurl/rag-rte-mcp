"""
Find Historic Heroes from accounts that can no longer be logged into.
Cross-references HH_Heroes_To_Get.txt with extraction results.
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

def normalize_email(email):
    """Normalize email for comparison"""
    email = email.lower().strip()
    email = email.replace("mailto:", "")
    return email

def get_fresh_account_emails():
    """Get list of emails from successfully extracted accounts"""
    emails = set()
    if os.path.exists(FRESH_ACCOUNTS_DIR):
        for f in os.listdir(FRESH_ACCOUNTS_DIR):
            if f.endswith('.json'):
                filepath = os.path.join(FRESH_ACCOUNTS_DIR, f)
                try:
                    with open(filepath, 'r', encoding='utf-8') as file:
                        data = json.load(file)
                        email = data.get('player', {}).get('playerInfo', {}).get('userName', '')
                        if email:
                            emails.add(normalize_email(email))
                except:
                    # Try extracting from filename
                    name = f.replace('.json', '').lower()
                    emails.add(name)
    return emails

def parse_hh_heroes_file():
    """Parse HH_Heroes_To_Get.txt - these are the HISTORIC HEROES"""
    heroes_list = []
    
    with open(HH_FILE, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            
            # Format: mailto:email coords hero_name
            match = re.match(r'(?:mailto:)?(\S+@\S+)\s+(\d+,\d+)\s+(.+)', line)
            if match:
                email = normalize_email(match.group(1))
                coords = match.group(2)
                hero_name = match.group(3).strip()
                heroes_list.append({
                    'email': email,
                    'coords': coords,
                    'hero': hero_name
                })
    
    return heroes_list

def parse_khans_cities():
    """Parse Khans_Heroes.txt for city locations"""
    cities = []
    with open(KHANS_HEROES_FILE, 'r', encoding='utf-8') as f:
        for line in f:
            parts = line.strip().split()
            if len(parts) >= 2:
                cities.append({
                    'email': normalize_email(parts[0]),
                    'coords': parts[1]
                })
    return cities

def main():
    print("=" * 80)
    print("LOST HISTORIC HEROES FINDER")
    print("Finding HH from accounts that can no longer be logged into")
    print("=" * 80)
    print()
    
    # Get fresh (working) account emails
    fresh_emails = get_fresh_account_emails()
    print(f"Successfully extracted accounts: {len(fresh_emails)}")
    
    # Parse HH heroes
    hh_heroes = parse_hh_heroes_file()
    print(f"Historic Heroes in HH file: {len(hh_heroes)}")
    
    # Get unique accounts from HH file
    hh_accounts = set(h['email'] for h in hh_heroes)
    print(f"Unique accounts with HH: {len(hh_accounts)}")
    
    # Find which HH accounts failed to login
    failed_hh_accounts = []
    working_hh_accounts = []
    
    for email in hh_accounts:
        # Check various email format variations
        found = False
        for fresh_email in fresh_emails:
            # Compare normalized versions
            if email in fresh_email or fresh_email in email:
                found = True
                break
            # Check without dots and special chars
            e1 = email.replace('.', '').replace('-', '').replace('_', '')
            e2 = fresh_email.replace('.', '').replace('-', '').replace('_', '')
            if e1 in e2 or e2 in e1:
                found = True
                break
        
        if found:
            working_hh_accounts.append(email)
        else:
            failed_hh_accounts.append(email)
    
    print(f"\nHH accounts that WORK: {len(working_hh_accounts)}")
    print(f"HH accounts that FAILED: {len(failed_hh_accounts)}")
    
    # Get lost heroes
    lost_heroes = [h for h in hh_heroes if h['email'] in failed_hh_accounts]
    
    # Remove duplicates (same hero appears multiple times in file)
    seen = set()
    unique_lost = []
    for h in lost_heroes:
        key = (h['email'], h['hero'])
        if key not in seen:
            seen.add(key)
            unique_lost.append(h)
    
    print(f"\nLOST HISTORIC HEROES: {len(unique_lost)}")
    print()
    
    # Print results
    print("=" * 80)
    print("HISTORIC HEROES THAT MAY BE BACK IN GAME (from failed accounts)")
    print("Search these coordinates on CC2 to find them!")
    print("=" * 80)
    print()
    print(f"{'Hero Name':<50} {'Coords':<12} Account")
    print("-" * 80)
    
    # Sort by hero name
    unique_lost.sort(key=lambda x: x['hero'])
    
    for h in unique_lost:
        print(f"{h['hero']:<50} {h['coords']:<12} {h['email']}")
    
    # Group by account
    print()
    print("=" * 80)
    print("GROUPED BY ACCOUNT")
    print("=" * 80)
    
    by_account = defaultdict(list)
    for h in unique_lost:
        by_account[h['email']].append(h)
    
    for email in sorted(by_account.keys()):
        heroes = by_account[email]
        print(f"\n{email} ({len(heroes)} historic heroes):")
        for h in heroes:
            print(f"  → {h['hero']} at ({h['coords']})")
    
    # Save to file
    output_file = r"D:\EvonyToolKit\scripts\extraction\LOST_HISTORIC_HEROES_2022.txt"
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("LOST HISTORIC HEROES FROM 2022 DATA\n")
        f.write("=" * 80 + "\n")
        f.write("These heroes were on accounts that can NO LONGER be logged into.\n")
        f.write("When accounts go inactive/deleted, their Historic Heroes return to the server!\n")
        f.write("Search these coordinates on CC2 server to find and capture them.\n")
        f.write("=" * 80 + "\n\n")
        
        f.write(f"Total: {len(unique_lost)} historic heroes from {len(by_account)} inactive accounts\n")
        f.write(f"Extraction date: Dec 31, 2025\n\n")
        
        f.write("HERO LIST (sorted alphabetically):\n")
        f.write("-" * 80 + "\n")
        for h in unique_lost:
            f.write(f"{h['hero']:<50} ({h['coords']}) - {h['email']}\n")
        
        f.write("\n\nGROUPED BY ACCOUNT:\n")
        f.write("-" * 80 + "\n")
        for email in sorted(by_account.keys()):
            heroes = by_account[email]
            f.write(f"\n{email} ({len(heroes)} heroes):\n")
            for h in heroes:
                f.write(f"  → {h['hero']} at ({h['coords']})\n")
        
        # Add search instructions
        f.write("\n\n" + "=" * 80 + "\n")
        f.write("HOW TO FIND THESE HEROES:\n")
        f.write("=" * 80 + "\n")
        f.write("1. Open Evony on CC2 server\n")
        f.write("2. Use map coordinates to navigate to each location\n")
        f.write("3. Check nearby NPC cities for the historic hero\n")
        f.write("4. Heroes may have moved to adjacent coordinates\n")
        f.write("5. Use scout to verify hero location before attacking\n")
    
    print(f"\n\nResults saved to: {output_file}")
    
    # Print working accounts with HH (for reference)
    print()
    print("=" * 80)
    print("WORKING ACCOUNTS WITH HISTORIC HEROES (still accessible)")
    print("=" * 80)
    for email in sorted(working_hh_accounts):
        heroes = [h for h in hh_heroes if h['email'] == email]
        hero_names = list(set(h['hero'] for h in heroes))
        print(f"  {email}: {', '.join(hero_names[:3])}{'...' if len(hero_names) > 3 else ''}")

if __name__ == "__main__":
    main()
