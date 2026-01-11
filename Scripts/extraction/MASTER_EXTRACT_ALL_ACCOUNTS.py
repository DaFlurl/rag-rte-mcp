"""
MASTER EXTRACTOR - ALL ACCOUNTS
Finds ALL config.sol files and extracts fresh data from every account

Sources:
1. D:\EvonyToolKit\SOL_Backups\ - SOL backup files
2. D:\EvonyToolKit\Macromedia\ - Flash shared objects
3. All other config.sol files in EvonyToolKit

Based on:
- sol_handler.py (config.sol structure)
- pyEvony evony.py (login protocol)
"""
import sys
import json
import socket
import hashlib
import struct
import time
import os
from pathlib import Path
from datetime import datetime
from urllib.request import urlopen
import xml.etree.ElementTree as ET
from collections import defaultdict

sys.path.insert(0, r'D:\EvonyToolKit\sol_manager')
from sol_handler import SOLHandler

try:
    import pyamf
except ImportError:
    print("ERROR: pip install pyamf")
    sys.exit(1)

# ============================================================================
# CONFIGURATION  
# ============================================================================
SEARCH_ROOTS = [
    Path(r'C:\Users'),
    Path(r'D:\EvonyToolKit\SOL_Backups'),
    Path(r'D:\EvonyToolKit\Macromedia'),
    Path(r'D:\EvonyToolKit'),
]

# Pre-discovered SOL paths file (faster than re-scanning)
SOL_PATHS_FILE = Path(r'D:\EvonyToolKit\scripts\extraction\all_config_sol_paths.txt')
OUTPUT_DIR = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\accounts_fresh')
KHAN_CSV = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\khanaccounts.csv')

TIMEOUT = 20
GAME_VERSION = '091103_11'
DELAY_BETWEEN = 0.2
MAX_RETRIES = 3  # Retry 2-3 times if account already logged in
RETRY_DELAY = 0.3  # Fast retry after failure

# ============================================================================
# EVONY CONNECTION (from pyEvony source)
# ============================================================================
class EvonyConnection:
    def __init__(self, host, port, timeout=20):
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.sock.settimeout(timeout)
        self.sock.connect((str(host), port))
    
    def send(self, command, data):
        msg = {'cmd': command, 'data': data}
        encoded = pyamf.encode(msg).read()
        packet = struct.pack('>L', len(encoded)) + encoded
        self.sock.sendall(packet)
    
    def receive(self):
        header = self._recv_exact(4)
        length = struct.unpack('>L', header)[0]
        data = self._recv_exact(length)
        return pyamf.decode(data).readElement()
    
    def _recv_exact(self, size):
        data = b''
        while len(data) < size:
            chunk = self.sock.recv(size - len(data))
            if not chunk:
                raise ConnectionError("Connection closed")
            data += chunk
        return data
    
    def close(self):
        try:
            self.sock.close()
        except:
            pass

# ============================================================================
# SERVER ADDRESS CACHE
# ============================================================================
_server_cache = {}

def get_server_address(server_name):
    if not server_name:
        return None
    if server_name in _server_cache:
        return _server_cache[server_name]
    try:
        url = f'http://{server_name}.evony.com/config.xml'
        response = urlopen(url, timeout=10)
        xml_data = response.read()
        root = ET.fromstring(xml_data)
        ip = root.find('server').text
        _server_cache[server_name] = ip
        return ip
    except:
        return None

# ============================================================================
# EXTRACTION (with retry for accounts already logged in)
# ============================================================================
def extract_account_single(email, password, server, server_ip=None):
    """Single extraction attempt"""
    if server_ip:
        host = server_ip
    else:
        host = get_server_address(server)
        if not host:
            return None, f"No server IP for {server}"
    
    try:
        conn = EvonyConnection(host, 443, TIMEOUT)
        conn.send('gameClient.version', GAME_VERSION)
        pwd_hash = hashlib.sha1(password.encode('utf-8')).hexdigest()
        conn.send('login', {'user': email, 'pwd': pwd_hash})
        
        response = None
        for _ in range(15):
            resp = conn.receive()
            if resp.get('cmd') == 'server.LoginResponse':
                response = resp
                break
        
        conn.close()
        
        if not response:
            return None, "No response"
        
        data = response.get('data', {})
        ok = data.get('ok')
        
        if ok == 1:
            return data, None
        elif ok == -1:
            return None, "Bad credentials"
        elif ok == -2:
            return None, "Wrong server"
        elif ok == -4:
            return None, "Needs setup"
        elif ok == -3:
            return None, "Already logged in"  # Needs retry
        else:
            return None, f"Error {ok}"
            
    except socket.timeout:
        return None, "Timeout"
    except ConnectionError:
        return None, "Connection closed"  # Needs retry
    except Exception as e:
        return None, str(e)[:30]

def extract_account(email, password, server, server_ip=None):
    """Extract with retry logic for already-logged-in accounts"""
    retryable_errors = ["Already logged in", "Connection closed", "Timeout", "No response"]
    
    for attempt in range(MAX_RETRIES):
        data, error = extract_account_single(email, password, server, server_ip)
        
        if data:
            return data, None
        
        # Check if error is retryable
        if error and any(e in error for e in retryable_errors):
            if attempt < MAX_RETRIES - 1:
                time.sleep(RETRY_DELAY)  # Fast retry
                continue
        
        # Non-retryable error or last attempt
        return None, error
    
    return None, error

# ============================================================================
# FIND ALL CONFIG.SOL FILES
# ============================================================================
def find_all_config_sol():
    """Find all config.sol files - use pre-discovered paths if available"""
    all_files = set()
    
    # Use pre-discovered paths file if exists (much faster)
    if SOL_PATHS_FILE.exists():
        with open(SOL_PATHS_FILE, 'r') as f:
            for line in f:
                path = line.strip()
                if path and os.path.exists(path):
                    all_files.add(Path(path))
        if all_files:
            return list(all_files)
    
    # Fall back to scanning
    for root_path in SEARCH_ROOTS:
        if root_path.exists():
            for cf in root_path.rglob('config.sol'):
                all_files.add(cf)
    
    return list(all_files)

# ============================================================================
# LOAD ACCOUNTS FROM SOL FILES
# ============================================================================
def load_accounts_from_sol_files(config_files):
    """Extract unique accounts from config.sol files"""
    handler = SOLHandler()
    accounts = {}  # email -> account info (deduplicated)
    
    for cf in config_files:
        try:
            data = handler.read_sol(str(cf))
            if data and '_error' not in data:
                info = handler.extract_account_info(data)
                email = info.get('email', '').lower().strip()
                
                if email and info.get('password'):
                    # Keep the one with most info (has server IP)
                    if email not in accounts or (info.get('server_ip') and not accounts[email].get('server_ip')):
                        accounts[email] = {
                            'email': info['email'],
                            'password': info['password'],
                            'server': info.get('server', 'cc2'),
                            'server_ip': info.get('server_ip', ''),
                            'source': 'sol',
                        }
        except:
            pass
    
    return list(accounts.values())

# ============================================================================
# LOAD ACCOUNTS FROM CSV (fallback for accounts not in SOL)
# ============================================================================
def load_accounts_from_csv():
    """Load accounts from khan CSV that have real passwords"""
    accounts = {}
    STATUS_WORDS = ['active', 'inactive', 'not working', 'working', 'semi', 'dead', 'banned']
    
    if not KHAN_CSV.exists():
        return []
    
    with open(KHAN_CSV, 'r', encoding='utf-8', errors='ignore') as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            parts = line.split(',', 1)
            if len(parts) >= 2:
                email = parts[0].strip().lower()
                password = parts[1].strip()
                
                if any(s in password.lower() for s in STATUS_WORDS):
                    continue
                
                if email and password and len(password) >= 3:
                    accounts[email] = {
                        'email': parts[0].strip(),  # Original case
                        'password': password,
                        'server': 'cc2',  # Default, will try multiple
                        'server_ip': '',
                        'source': 'csv',
                    }
    
    return list(accounts.values())

# ============================================================================
# MERGE ACCOUNTS
# ============================================================================
def merge_accounts(sol_accounts, csv_accounts):
    """Merge SOL and CSV accounts, preferring SOL (has server info)"""
    merged = {}
    
    # Add SOL accounts first (they have server info)
    for acc in sol_accounts:
        email = acc['email'].lower()
        merged[email] = acc
    
    # Add CSV accounts that aren't in SOL
    for acc in csv_accounts:
        email = acc['email'].lower()
        if email not in merged:
            merged[email] = acc
    
    return list(merged.values())

# ============================================================================
# MAIN
# ============================================================================
def main():
    print("=" * 70)
    print("MASTER EXTRACTOR - ALL ACCOUNTS")
    print("=" * 70)
    
    # Parse args
    test_count = None
    for i, arg in enumerate(sys.argv):
        if arg == '--test' and i + 1 < len(sys.argv):
            test_count = int(sys.argv[i + 1])
    
    # Find all config.sol files
    print("\n[1] Finding config.sol files...")
    config_files = find_all_config_sol()
    print(f"    Found {len(config_files)} config.sol files")
    
    # Load from SOL
    print("\n[2] Loading accounts from SOL files...")
    sol_accounts = load_accounts_from_sol_files(config_files)
    print(f"    Loaded {len(sol_accounts)} accounts from SOL")
    
    # Load from CSV
    print("\n[3] Loading accounts from CSV...")
    csv_accounts = load_accounts_from_csv()
    print(f"    Loaded {len(csv_accounts)} accounts from CSV")
    
    # Merge
    print("\n[4] Merging accounts...")
    all_accounts = merge_accounts(sol_accounts, csv_accounts)
    print(f"    Total unique accounts: {len(all_accounts)}")
    
    sol_count = sum(1 for a in all_accounts if a['source'] == 'sol')
    csv_count = sum(1 for a in all_accounts if a['source'] == 'csv')
    print(f"    From SOL (with server): {sol_count}")
    print(f"    From CSV (need server): {csv_count}")
    
    if test_count:
        all_accounts = all_accounts[:test_count]
        print(f"\n[TEST MODE] Processing {len(all_accounts)} accounts")
    
    # Extract
    print(f"\n[5] Extracting fresh data...")
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    
    success = 0
    failed = 0
    errors = defaultdict(int)
    
    start_time = time.time()
    
    for i, acc in enumerate(all_accounts, 1):
        email = acc['email']
        password = acc['password']
        server = acc['server']
        server_ip = acc['server_ip']
        
        pct = (i / len(all_accounts)) * 100
        print(f"[{i}/{len(all_accounts)}] ({pct:.0f}%) {email[:35]:35}", end=" ", flush=True)
        
        data, error = extract_account(email, password, server, server_ip)
        
        if data:
            safe_email = email.replace('@', '').replace('.', '')
            output_file = OUTPUT_DIR / f"{safe_email}.json"
            
            data['_extracted'] = datetime.now().isoformat()
            data['_email'] = email
            data['_server'] = server
            
            with open(output_file, 'w') as f:
                json.dump(data, f, indent=2, default=str)
            
            player = data.get('player', {})
            name = player.get('playerInfo', {}).get('userName', '?')
            cities = len(player.get('castles', []))
            
            print(f"✓ {name} ({cities} cities)")
            success += 1
        else:
            print(f"✗ {error}")
            failed += 1
            errors[error] += 1
        
        time.sleep(DELAY_BETWEEN)
    
    elapsed = time.time() - start_time
    
    print("\n" + "=" * 70)
    print("EXTRACTION COMPLETE")
    print("=" * 70)
    print(f"Success: {success}")
    print(f"Failed:  {failed}")
    print(f"Time:    {elapsed:.1f}s")
    print(f"Output:  {OUTPUT_DIR}")
    
    if errors:
        print("\nError breakdown:")
        for err, count in sorted(errors.items(), key=lambda x: -x[1]):
            print(f"  {err}: {count}")


if __name__ == '__main__':
    main()
