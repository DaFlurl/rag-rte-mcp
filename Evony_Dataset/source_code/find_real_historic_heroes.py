"""
Find REAL Historic Heroes from deleted accounts.
Historic Heroes have distinctive names - not player-renamed heroes.
"""

import os
import json
from collections import defaultdict

OLD_ACCOUNTS_DIR = r"D:\EvonyToolKit\scripts\khan_Accounts_556\accounts"
FRESH_ACCOUNTS_DIR = r"D:\EvonyToolKit\scripts\khan_Accounts_556\accounts_fresh"

# Actual Historic Hero names from Evony
HISTORIC_HEROES = [
    # Famous rulers/emperors
    "Charlemagne", "Peter the Great", "William the Conqueror", "Oliver Cromwell",
    "Cardinal Richelieu", "Elizabeth I", "Napoleon", "Julius Caesar", "Augustus",
    "Frederick", "Richard III", "Henry VIII", "Catherine", "Louis XIV",
    "Ivan III", "Ivan the Terrible", "Genghis Khan", "Kublai Khan",
    "Alexander the Great", "Attila", "Constantine", "Justinian",
    
    # Explorers
    "Marco Polo", "Amerigo Vespucci", "Christopher Columbus", "Leif Ericson",
    "Henry Hudson", "Hernando de Soto", "Vasco da Gama", "Ferdinand Magellan",
    
    # Scientists/Philosophers
    "Hippocrates", "Aristotle", "Plato", "Socrates", "Cicero", "Archimedes",
    "Galileo", "Leonardo da Vinci", "Michelangelo", "Copernicus",
    
    # Military leaders
    "Hamilcar Barca", "Hannibal", "Sun Tzu", "Spartacus", "Joan of Arc",
    "El Cid", "Saladin", "Richard the Lionheart",
    
    # Artists/Writers
    "Shakespeare", "Dante", "Virgil", "Homer", "Botticelli", "Durer",
    "Raphael", "Titian", "Rembrandt",
    
    # Saints/Religious
    "St. Augustine", "St. Thomas", "St. Francis", "Pope", "Cardinal",
    
    # Celtic/Norse
    "Brian Boru", "MacBeth", "Boudica", "Vercingetorix",
    
    # Other notable figures
    "Cleopatra", "Nefertiti", "Hatshepsut", "Montezuma", "Moctezuma",
    "Pocahontas", "Sitting Bull", "Geronimo",
    
    # Common HH patterns (partial matches)
    "Duke of", "Earl of", "Count of", "King of", "Queen of",
    "Emperor", "Empress", "Sultan", "Caliph", "Khan",
    "Holy Roman", "Byzantine", "Ottoman", "Habsburg",
    "Borgia", "Medici", "Sforza", "Tudor", "Stuart", "Plantagenet",
]

# Convert to lowercase for matching
HISTORIC_PATTERNS = [h.lower() for h in HISTORIC_HEROES]

def is_historic_hero(hero_name):
    """Check if hero name matches known Historic Hero patterns"""
    name_lower = hero_name.lower()
    
    # Check for exact or partial matches
    for pattern in HISTORIC_PATTERNS:
        if pattern in name_lower or name_lower in pattern:
            return True
    
    # Check for common HH naming patterns
    hh_indicators = [
        " i ", " ii ", " iii ", " iv ", " v ",  # Roman numerals
        " the great", " the conqueror", " the wise", " the bold",
        " of england", " of france", " of spain", " of russia",
        " of denmark", " of sweden", " of poland", " of austria",
        "holy roman", "duke of", "earl of", "count of", "baron of",
        "emperor", "empress", "sultan", "caliph", "pope",
    ]
    
    for indicator in hh_indicators:
        if indicator in name_lower:
            return True
    
    return False

def get_fresh_account_filenames():
    """Get filenames of accounts that work"""
    filenames = set()
    if os.path.exists(FRESH_ACCOUNTS_DIR):
        for f in os.listdir(FRESH_ACCOUNTS_DIR):
            if f.endswith('.json'):
                filenames.add(f.replace('.json', '').lower())
    return filenames

def scan_old_accounts_for_hh():
    """Scan old JSON files for Historic Heroes"""
    working = get_fresh_account_filenames()
    print(f"Working accounts: {len(working)}")
    
    old_files = [f for f in os.listdir(OLD_ACCOUNTS_DIR) if f.endswith('.json')]
    print(f"Old JSON files: {len(old_files)}")
    
    deleted_with_hh = []
    working_with_hh = []
    
    for filename in old_files:
        filepath = os.path.join(OLD_ACCOUNTS_DIR, filename)
        base_name = filename.replace('.json', '').lower()
        
        # Check if account works
        account_works = base_name in working or any(base_name in w or w in base_name for w in working)
        
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                data = json.load(f)
            
            player = data.get('player', {})
            player_info = player.get('playerInfo', {})
            email = player_info.get('userName', filename)
            
            # Scan all castles for heroes
            hh_found = []
            castles = player.get('castles', [])
            
            for castle in castles:
                castle_name = castle.get('name', 'Unknown')
                heroes = castle.get('heros', [])
                
                for hero in heroes:
                    hero_name = hero.get('name', '')
                    if hero_name and is_historic_hero(hero_name):
                        hh_found.append({
                            'name': hero_name,
                            'level': hero.get('level', 0),
                            'attack': hero.get('attack', 0),
                            'castle': castle_name
                        })
            
            if hh_found:
                entry = {
                    'filename': filename,
                    'email': email,
                    'historic_heroes': hh_found,
                    'works': account_works
                }
                
                if account_works:
                    working_with_hh.append(entry)
                else:
                    deleted_with_hh.append(entry)
                    
        except Exception as e:
            pass
    
    return deleted_with_hh, working_with_hh

def main():
    print("=" * 80)
    print("SEARCHING FOR REAL HISTORIC HEROES FROM DELETED ACCOUNTS")
    print("=" * 80)
    print()
    
    deleted, working = scan_old_accounts_for_hh()
    
    print(f"\nDeleted accounts with Historic Heroes: {len(deleted)}")
    print(f"Working accounts with Historic Heroes: {len(working)}")
    
    total_lost_hh = sum(len(a['historic_heroes']) for a in deleted)
    total_active_hh = sum(len(a['historic_heroes']) for a in working)
    
    print(f"\nLOST Historic Heroes (from deleted accounts): {total_lost_hh}")
    print(f"ACTIVE Historic Heroes (still accessible): {total_active_hh}")
    
    if deleted:
        print()
        print("=" * 80)
        print("HISTORIC HEROES FROM DELETED ACCOUNTS - BACK IN GAME!")
        print("=" * 80)
        
        # Sort by number of HH
        deleted.sort(key=lambda x: len(x['historic_heroes']), reverse=True)
        
        for acc in deleted:
            print(f"\n{acc['filename']}")
            print(f"  Email: {acc['email']}")
            for hh in acc['historic_heroes']:
                print(f"    → Lv{hh['level']:3d} {hh['name']:<50} @ {hh['castle']}")
    else:
        print("\nNo Historic Heroes found in deleted accounts.")
        print("The HH data in the text files may be more accurate.")
    
    # Save results
    output = r"D:\EvonyToolKit\scripts\extraction\REAL_LOST_HH.txt"
    with open(output, 'w', encoding='utf-8') as f:
        f.write("REAL HISTORIC HEROES FROM DELETED ACCOUNTS\n")
        f.write("=" * 80 + "\n\n")
        
        if deleted:
            f.write(f"Total: {total_lost_hh} Historic Heroes from {len(deleted)} deleted accounts\n\n")
            for acc in deleted:
                f.write(f"\n{acc['filename']} ({acc['email']})\n")
                for hh in acc['historic_heroes']:
                    f.write(f"  Lv{hh['level']:3d} {hh['name']:<50} @ {hh['castle']}\n")
        else:
            f.write("No Historic Heroes found in old JSON files from deleted accounts.\n")
            f.write("\nNote: Historic Heroes may have been renamed by players.\n")
            f.write("Check HH_Heroes_To_Get.txt for tracked HH by coordinates.\n")
    
    print(f"\nResults saved to: {output}")
    
    return deleted, working

if __name__ == "__main__":
    deleted, working = main()
