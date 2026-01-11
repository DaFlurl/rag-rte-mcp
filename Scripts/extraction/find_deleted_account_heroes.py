"""
Find heroes from accounts that existed in 2022 but can NO LONGER be logged into.
These accounts are likely deleted - their heroes returned to the game server.
"""

import os
import json
from collections import defaultdict
from datetime import datetime

# Paths
OLD_ACCOUNTS_DIR = r"D:\EvonyToolKit\scripts\khan_Accounts_556\accounts"
FRESH_ACCOUNTS_DIR = r"D:\EvonyToolKit\scripts\khan_Accounts_556\accounts_fresh"

def get_fresh_account_emails():
    """Get emails from accounts that successfully logged in today"""
    emails = set()
    filenames = set()
    
    if os.path.exists(FRESH_ACCOUNTS_DIR):
        for f in os.listdir(FRESH_ACCOUNTS_DIR):
            if f.endswith('.json'):
                filenames.add(f.replace('.json', '').lower())
                filepath = os.path.join(FRESH_ACCOUNTS_DIR, f)
                try:
                    with open(filepath, 'r', encoding='utf-8') as file:
                        data = json.load(file)
                        # Try to get email from player info
                        email = data.get('player', {}).get('playerInfo', {}).get('userName', '')
                        if email:
                            emails.add(email.lower())
                except:
                    pass
    
    return emails, filenames

def extract_heroes_from_old_json(filepath):
    """Extract all heroes from an old 2022 JSON file"""
    heroes = []
    account_info = {}
    
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        player = data.get('player', {})
        player_info = player.get('playerInfo', {})
        
        account_info = {
            'email': player_info.get('userName', ''),
            'player_name': player_info.get('userName', ''),
            'alliance': player_info.get('allianceName', ''),
        }
        
        # Get heroes from all castles
        castles = player.get('castles', [])
        for castle in castles:
            castle_name = castle.get('name', 'Unknown')
            castle_x = castle.get('fieldId', 0) % 800 if castle.get('fieldId') else 0
            castle_y = castle.get('fieldId', 0) // 800 if castle.get('fieldId') else 0
            
            # Heroes are in 'heros' key (note spelling)
            castle_heroes = castle.get('heros', [])
            for hero in castle_heroes:
                hero_name = hero.get('name', '')
                hero_level = hero.get('level', 0)
                hero_power = hero.get('power', 0)
                hero_attack = hero.get('attack', 0)
                
                if hero_name:
                    heroes.append({
                        'name': hero_name,
                        'level': hero_level,
                        'power': hero_power,
                        'attack': hero_attack,
                        'castle': castle_name,
                        'castle_coords': f"{castle_x},{castle_y}"
                    })
        
    except Exception as e:
        pass
    
    return account_info, heroes

def main():
    print("=" * 80)
    print("FINDING HEROES FROM DELETED ACCOUNTS (2022 data vs current)")
    print("=" * 80)
    print()
    
    # Get accounts that work NOW
    working_emails, working_filenames = get_fresh_account_emails()
    print(f"Accounts that LOGIN NOW: {len(working_filenames)}")
    
    # Scan all old JSON files
    old_files = [f for f in os.listdir(OLD_ACCOUNTS_DIR) if f.endswith('.json')]
    print(f"Old JSON files from 2022: {len(old_files)}")
    
    # Find accounts that existed in 2022 but DON'T work now
    deleted_accounts = []
    all_old_heroes = {}
    
    for filename in old_files:
        filepath = os.path.join(OLD_ACCOUNTS_DIR, filename)
        account_info, heroes = extract_heroes_from_old_json(filepath)
        
        if not heroes:
            continue
        
        # Check if this account still works
        base_name = filename.replace('.json', '').lower()
        email = account_info.get('email', '').lower()
        
        # Check various matching methods
        account_works = False
        
        # Direct filename match
        if base_name in working_filenames:
            account_works = True
        
        # Email match
        if email and email in working_emails:
            account_works = True
        
        # Partial match (for different filename formats)
        for wf in working_filenames:
            if base_name in wf or wf in base_name:
                account_works = True
                break
        
        all_old_heroes[filename] = {
            'account': account_info,
            'heroes': heroes,
            'works': account_works
        }
        
        if not account_works:
            deleted_accounts.append({
                'filename': filename,
                'account': account_info,
                'heroes': heroes
            })
    
    print(f"\nAccounts with heroes in 2022: {len(all_old_heroes)}")
    print(f"Accounts that NO LONGER WORK: {len(deleted_accounts)}")
    
    # Count total heroes from deleted accounts
    total_lost_heroes = sum(len(a['heroes']) for a in deleted_accounts)
    print(f"Total heroes from deleted accounts: {total_lost_heroes}")
    
    # Print deleted accounts and their heroes
    print()
    print("=" * 80)
    print("DELETED ACCOUNTS - HEROES NOW BACK IN GAME")
    print("=" * 80)
    
    # Sort by number of heroes
    deleted_accounts.sort(key=lambda x: len(x['heroes']), reverse=True)
    
    for acc in deleted_accounts:
        email = acc['account'].get('email', acc['filename'])
        heroes = acc['heroes']
        print(f"\n{acc['filename']} ({len(heroes)} heroes)")
        print(f"  Email: {email}")
        
        # Sort heroes by level descending
        heroes.sort(key=lambda h: h['level'], reverse=True)
        
        for h in heroes[:20]:  # Show top 20 heroes
            print(f"    Lv{h['level']:3d} {h['name']:<40} Atk:{h['attack']:.0f} @ {h['castle']}")
        
        if len(heroes) > 20:
            print(f"    ... and {len(heroes) - 20} more heroes")
    
    # Save detailed results
    output_file = r"D:\EvonyToolKit\scripts\extraction\DELETED_ACCOUNTS_HEROES.txt"
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("HEROES FROM DELETED ACCOUNTS\n")
        f.write("=" * 80 + "\n")
        f.write("These accounts existed in 2022 but can NO LONGER be logged into.\n")
        f.write("Their heroes have returned to the game server!\n")
        f.write(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M')}\n")
        f.write("=" * 80 + "\n\n")
        
        f.write(f"Total deleted accounts: {len(deleted_accounts)}\n")
        f.write(f"Total heroes from deleted accounts: {total_lost_heroes}\n\n")
        
        for acc in deleted_accounts:
            email = acc['account'].get('email', acc['filename'])
            heroes = acc['heroes']
            f.write(f"\n{'='*60}\n")
            f.write(f"{acc['filename']}\n")
            f.write(f"Email: {email}\n")
            f.write(f"Heroes: {len(heroes)}\n")
            f.write(f"{'='*60}\n")
            
            heroes.sort(key=lambda h: h['level'], reverse=True)
            for h in heroes:
                f.write(f"  Lv{h['level']:3d} {h['name']:<40} Atk:{h['attack']:.0f} @ {h['castle']} ({h['castle_coords']})\n")
    
    print(f"\n\nFull results saved to: {output_file}")
    
    # Also create a simple hero list for searching
    hero_list_file = r"D:\EvonyToolKit\scripts\extraction\DELETED_HERO_LIST.txt"
    with open(hero_list_file, 'w', encoding='utf-8') as f:
        f.write("HERO NAMES FROM DELETED ACCOUNTS (searchable list)\n")
        f.write("=" * 60 + "\n\n")
        
        all_heroes = []
        for acc in deleted_accounts:
            for h in acc['heroes']:
                all_heroes.append({
                    'name': h['name'],
                    'level': h['level'],
                    'attack': h['attack'],
                    'account': acc['filename']
                })
        
        # Sort by level
        all_heroes.sort(key=lambda h: h['level'], reverse=True)
        
        f.write(f"Total: {len(all_heroes)} heroes\n\n")
        f.write(f"{'Hero Name':<45} {'Lv':<4} {'Attack':<8} Account\n")
        f.write("-" * 100 + "\n")
        
        for h in all_heroes:
            f.write(f"{h['name']:<45} {h['level']:<4} {h['attack']:<8.0f} {h['account']}\n")
    
    print(f"Hero list saved to: {hero_list_file}")
    
    return deleted_accounts

if __name__ == "__main__":
    deleted = main()
