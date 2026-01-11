"""
Find Lv150 Historic Heroes from deleted accounts.
Lv150 = Real Historic Heroes (regular heroes cap at 100)
"""

import os
import json
from collections import defaultdict

OLD_ACCOUNTS_DIR = r"D:\EvonyToolKit\scripts\khan_Accounts_556\accounts"
FRESH_ACCOUNTS_DIR = r"D:\EvonyToolKit\scripts\khan_Accounts_556\accounts_fresh"

def get_working_accounts():
    """Get filenames of accounts that successfully logged in"""
    working = set()
    if os.path.exists(FRESH_ACCOUNTS_DIR):
        for f in os.listdir(FRESH_ACCOUNTS_DIR):
            if f.endswith('.json'):
                working.add(f.replace('.json', '').lower())
    return working

def main():
    print("=" * 80)
    print("FINDING Lv150 HISTORIC HEROES FROM DELETED ACCOUNTS")
    print("=" * 80)
    print()
    
    working = get_working_accounts()
    print(f"Working accounts (fresh extraction): {len(working)}")
    
    old_files = [f for f in os.listdir(OLD_ACCOUNTS_DIR) if f.endswith('.json')]
    print(f"Old JSON files to scan: {len(old_files)}")
    
    # Track all Lv150 heroes
    all_hh = []
    deleted_hh = []
    working_hh = []
    
    for filename in old_files:
        filepath = os.path.join(OLD_ACCOUNTS_DIR, filename)
        base_name = filename.replace('.json', '').lower()
        
        # Check if account works
        account_works = base_name in working
        if not account_works:
            for w in working:
                if base_name in w or w in base_name:
                    account_works = True
                    break
        
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                data = json.load(f)
            
            player = data.get('player', {})
            player_info = player.get('playerInfo', {})
            email = player_info.get('userName', filename.replace('.json', ''))
            player_name = player_info.get('playerName', email)
            
            # Scan all castles for Lv150 heroes
            castles = player.get('castles', [])
            for castle in castles:
                castle_name = castle.get('name', 'Unknown')
                field_id = castle.get('fieldId', 0)
                x = field_id % 800 if field_id else 0
                y = field_id // 800 if field_id else 0
                
                heroes = castle.get('heros', [])
                for hero in heroes:
                    level = hero.get('level', 0)
                    if level >= 150:  # Historic Hero!
                        hh_info = {
                            'name': hero.get('name', 'Unknown'),
                            'level': level,
                            'attack': hero.get('attack', 0),
                            'power': hero.get('power', 0),
                            'politics': hero.get('management', 0),
                            'intel': hero.get('stratagem', 0),
                            'castle': castle_name,
                            'coords': f"{x},{y}",
                            'account_file': filename,
                            'email': email,
                            'player': player_name,
                            'account_works': account_works
                        }
                        
                        all_hh.append(hh_info)
                        if account_works:
                            working_hh.append(hh_info)
                        else:
                            deleted_hh.append(hh_info)
                            
        except Exception as e:
            pass
    
    print(f"\nTotal Lv150+ Historic Heroes found: {len(all_hh)}")
    print(f"HH on WORKING accounts: {len(working_hh)}")
    print(f"HH on DELETED accounts: {len(deleted_hh)}")
    
    # Print deleted account HH
    if deleted_hh:
        print()
        print("=" * 80)
        print("HISTORIC HEROES FROM DELETED ACCOUNTS - BACK IN GAME!")
        print("These HH have returned to the server and can be captured!")
        print("=" * 80)
        
        # Group by account
        by_account = defaultdict(list)
        for hh in deleted_hh:
            by_account[hh['account_file']].append(hh)
        
        for account, heroes in sorted(by_account.items()):
            email = heroes[0]['email']
            player = heroes[0]['player']
            print(f"\n{account}")
            print(f"  Player: {player} | Email: {email}")
            print(f"  Historic Heroes ({len(heroes)}):")
            for hh in sorted(heroes, key=lambda x: x['level'], reverse=True):
                print(f"    Lv{hh['level']} {hh['name']:<40} Atk:{hh['attack']:.0f} @ {hh['castle']} ({hh['coords']})")
    else:
        print("\nNo Lv150 Historic Heroes found on deleted accounts.")
    
    # Print working account HH for reference
    if working_hh:
        print()
        print("=" * 80)
        print("HISTORIC HEROES ON WORKING ACCOUNTS (still owned)")
        print("=" * 80)
        
        by_account = defaultdict(list)
        for hh in working_hh:
            by_account[hh['account_file']].append(hh)
        
        for account, heroes in sorted(by_account.items()):
            email = heroes[0]['email']
            print(f"\n{account} ({email}):")
            for hh in sorted(heroes, key=lambda x: x['level'], reverse=True):
                print(f"    Lv{hh['level']} {hh['name']:<40} @ {hh['castle']}")
    
    # Save to file
    output = r"D:\EvonyToolKit\scripts\extraction\LV150_HISTORIC_HEROES.txt"
    with open(output, 'w', encoding='utf-8') as f:
        f.write("Lv150 HISTORIC HEROES ANALYSIS\n")
        f.write("=" * 80 + "\n\n")
        f.write(f"Total Lv150+ HH found: {len(all_hh)}\n")
        f.write(f"HH on WORKING accounts: {len(working_hh)}\n")
        f.write(f"HH on DELETED accounts: {len(deleted_hh)}\n\n")
        
        if deleted_hh:
            f.write("=" * 80 + "\n")
            f.write("HISTORIC HEROES FROM DELETED ACCOUNTS\n")
            f.write("These heroes are BACK IN GAME and can be captured!\n")
            f.write("=" * 80 + "\n")
            
            by_account = defaultdict(list)
            for hh in deleted_hh:
                by_account[hh['account_file']].append(hh)
            
            for account, heroes in sorted(by_account.items()):
                email = heroes[0]['email']
                player = heroes[0]['player']
                f.write(f"\n{account}\n")
                f.write(f"  Player: {player} | Email: {email}\n")
                for hh in sorted(heroes, key=lambda x: x['level'], reverse=True):
                    f.write(f"    Lv{hh['level']} {hh['name']:<40} Atk:{hh['attack']:.0f} @ {hh['castle']} ({hh['coords']})\n")
        
        if working_hh:
            f.write("\n\n" + "=" * 80 + "\n")
            f.write("HISTORIC HEROES ON WORKING ACCOUNTS (still owned)\n")
            f.write("=" * 80 + "\n")
            
            by_account = defaultdict(list)
            for hh in working_hh:
                by_account[hh['account_file']].append(hh)
            
            for account, heroes in sorted(by_account.items()):
                f.write(f"\n{account}:\n")
                for hh in sorted(heroes, key=lambda x: x['level'], reverse=True):
                    f.write(f"    Lv{hh['level']} {hh['name']:<40} @ {hh['castle']}\n")
    
    print(f"\nResults saved to: {output}")
    
    return deleted_hh, working_hh

if __name__ == "__main__":
    deleted, working = main()
