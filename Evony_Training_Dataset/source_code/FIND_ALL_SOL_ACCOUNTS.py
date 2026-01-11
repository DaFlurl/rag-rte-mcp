"""
FIND ALL SOL ACCOUNTS - Searches all drives for config.sol files
Extracts unique accounts from ALL #SharedObjects folders
"""
import os
import sys
import json
from pathlib import Path
from datetime import datetime
from concurrent.futures import ThreadPoolExecutor, as_completed

sys.path.insert(0, r'D:\EvonyToolKit\sol_manager')
from sol_handler import SOLHandler

# ============================================================================
# SEARCH LOCATIONS
# ============================================================================
DRIVES = ['C:', 'D:', 'E:', 'F:', 'G:']

# Known SharedObjects patterns
PATTERNS = [
    r'Users\*\AppData\Roaming\Macromedia\Flash Player\#SharedObjects',
    r'Users\*\AppData\Local\Macromedia\Flash Player\#SharedObjects', 
    r'Macromedia\Flash Player\#SharedObjects',
    r'SOL_Backups',
    r'EvonyToolKit\Macromedia',
    r'EvonyToolKit\SOL_Backups',
    r'AI-Evony',
]

OUTPUT_DIR = Path(r'D:\EvonyToolKit\scripts\extraction')

# ============================================================================
# FIND ALL CONFIG.SOL FILES
# ============================================================================
def find_config_sol_in_path(search_path):
    """Find all config.sol files in a path"""
    results = []
    try:
        for root, dirs, files in os.walk(search_path):
            for f in files:
                if f.lower() == 'config.sol':
                    results.append(os.path.join(root, f))
    except:
        pass
    return results

def find_all_config_sol():
    """Search all drives and patterns for config.sol"""
    all_files = set()
    
    for drive in DRIVES:
        if not os.path.exists(drive + '\\'):
            print(f"  [{drive}] Not available")
            continue
        
        print(f"  [{drive}] Searching...", end=" ", flush=True)
        drive_count = 0
        
        # Search known patterns
        for pattern in PATTERNS:
            # Handle wildcards
            if '*' in pattern:
                base, rest = pattern.split('*', 1)
                base_path = os.path.join(drive + '\\', base)
                if os.path.exists(base_path):
                    for item in os.listdir(base_path):
                        full_pattern = os.path.join(base_path, item, rest.lstrip('\\'))
                        if os.path.exists(full_pattern):
                            files = find_config_sol_in_path(full_pattern)
                            all_files.update(files)
                            drive_count += len(files)
            else:
                full_path = os.path.join(drive + '\\', pattern)
                if os.path.exists(full_path):
                    files = find_config_sol_in_path(full_path)
                    all_files.update(files)
                    drive_count += len(files)
        
        # Also search root #SharedObjects if exists
        shared_objects = os.path.join(drive + '\\', '#SharedObjects')
        if os.path.exists(shared_objects):
            files = find_config_sol_in_path(shared_objects)
            all_files.update(files)
            drive_count += len(files)
        
        print(f"found {drive_count}")
    
    return list(all_files)

# ============================================================================
# EXTRACT ACCOUNTS FROM SOL FILES
# ============================================================================
def extract_accounts_from_sol(sol_files):
    """Extract unique accounts from config.sol files"""
    handler = SOLHandler()
    accounts = {}  # email -> account data
    
    for i, sf in enumerate(sol_files):
        if i % 100 == 0:
            print(f"  Processing {i}/{len(sol_files)}...", end="\r")
        
        try:
            data = handler.read_sol(sf)
            if data and '_error' not in data:
                info = handler.extract_account_info(data)
                email = info.get('email', '').lower().strip()
                
                if email and info.get('password'):
                    # Keep best version (with server IP)
                    if email not in accounts or (info.get('server_ip') and not accounts[email].get('server_ip')):
                        accounts[email] = {
                            'email': info['email'],
                            'password': info['password'],
                            'server': info.get('server', ''),
                            'server_ip': info.get('server_ip', ''),
                            'server_alias': info.get('server_alias', ''),
                            'source_file': sf,
                        }
        except Exception as e:
            pass
    
    print(f"  Processing {len(sol_files)}/{len(sol_files)}... done")
    return accounts

# ============================================================================
# MAIN
# ============================================================================
def main():
    print("=" * 70)
    print("FIND ALL SOL ACCOUNTS")
    print("Searching all drives for config.sol files")
    print("=" * 70)
    
    # Find all config.sol files
    print("\n[1] Searching for config.sol files...")
    sol_files = find_all_config_sol()
    print(f"\n    Total config.sol files found: {len(sol_files)}")
    
    # Save file list
    files_output = OUTPUT_DIR / 'all_config_sol_paths.txt'
    with open(files_output, 'w') as f:
        for sf in sorted(sol_files):
            f.write(sf + '\n')
    print(f"    Saved paths to: {files_output}")
    
    # Extract accounts
    print("\n[2] Extracting accounts from SOL files...")
    accounts = extract_accounts_from_sol(sol_files)
    print(f"    Unique accounts found: {len(accounts)}")
    
    # Count by server
    servers = {}
    for acc in accounts.values():
        srv = acc.get('server', 'unknown') or 'unknown'
        servers[srv] = servers.get(srv, 0) + 1
    
    print("\n    Accounts by server:")
    for srv, count in sorted(servers.items(), key=lambda x: -x[1]):
        print(f"      {srv}: {count}")
    
    # Save accounts
    accounts_output = OUTPUT_DIR / 'all_discovered_accounts.json'
    output_data = {
        'discovered': datetime.now().isoformat(),
        'total_sol_files': len(sol_files),
        'unique_accounts': len(accounts),
        'accounts': list(accounts.values()),
    }
    
    with open(accounts_output, 'w') as f:
        json.dump(output_data, f, indent=2)
    print(f"\n    Saved accounts to: {accounts_output}")
    
    # Summary
    print("\n" + "=" * 70)
    print("SUMMARY")
    print("=" * 70)
    print(f"Total SOL files:     {len(sol_files)}")
    print(f"Unique accounts:     {len(accounts)}")
    with_server = sum(1 for a in accounts.values() if a.get('server'))
    with_ip = sum(1 for a in accounts.values() if a.get('server_ip'))
    print(f"With server code:    {with_server}")
    print(f"With server IP:      {with_ip}")
    
    # Show sample
    print("\nSample accounts:")
    for acc in list(accounts.values())[:10]:
        print(f"  {acc['email'][:35]:35} | {acc.get('server','?'):5} | {acc.get('server_ip','')[:15]}")


if __name__ == '__main__':
    main()
