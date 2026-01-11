"""
MASTER EXTRACTOR - FIXED VERSION
Based directly on pyEvony evony.py source code (lines 44-73, 95-104, 123-160)

Key fixes from source:
1. Use select.select() for timeout handling (line 48, 60)
2. Proper receive loop with remaining bytes calculation
3. Correct login sequence: version -> login -> wait for LoginResponse
4. Retry logic for already-logged-in accounts
"""
import sys
import json
import socket
import select
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
SOL_PATHS_FILE = Path(r'D:\EvonyToolKit\scripts\extraction\all_config_sol_paths.txt')
OUTPUT_DIR = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\accounts_fresh')
KHAN_CSV = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\khanaccounts.csv')

TIMEOUT = 30  # From source line 77
RECV_TIMEOUT = 30  # From source line 48
GAME_VERSION = '091103_11'  # From source line 95
PORT = 443  # From source line 93

MAX_RETRIES = 3
RETRY_DELAY = 0.5
DELAY_BETWEEN = 0.3

# ============================================================================
# CONNECTION CLASS - Direct from pyEvony source (lines 11-75)
# ============================================================================
class Connection:
    """Direct port of pyEvony Connection class to Python 3"""
    
    def __init__(self, host, port, timeout=30):
        self.server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.server.settimeout(timeout)
        self.server.connect((str(host), port))
    
    def sendmessage(self, command, data):
        """From source lines 34-43"""
        msg = {'cmd': command, 'data': data}
        msg = pyamf.encode(msg).read()
        size = len(msg)
        msg = struct.pack('>L', size) + msg
        self.server.sendall(msg)
    
    def receivedata(self):
        """From source lines 44-73 - uses select for timeout"""
        # Read 4-byte length header
        data = b''
        remaining = 4
        while len(data) < 4:
            tt = select.select([self.server], [], [], RECV_TIMEOUT)
            if not tt[0]:
                raise TimeoutError("Select timeout waiting for header")
            u = self.server.recv(remaining)
            if u == b'':
                raise ConnectionError("Connection closed by server")
            data = data + u
            remaining = 4 - len(data)
        
        length = struct.unpack('>L', data)[0]
        
        # Read message body
        data = b''
        remaining = length
        while len(data) < length:
            tt = select.select([self.server], [], [], RECV_TIMEOUT)
            if not tt[0]:
                raise TimeoutError("Select timeout waiting for body")
            u = self.server.recv(remaining)
            if u == b'':
                raise ConnectionError("Connection closed by server")
            data = data + u
            remaining = length - len(data)
        
        # Decode AMF
        return pyamf.decode(data).readElement()
    
    def close(self):
        try:
            self.server.close()
        except:
            pass

# ============================================================================
# SERVER ADDRESS - From source lines 165-180
# ============================================================================
_server_cache = {}

def get_server_address(server_name):
    """From source getaddress method"""
    if not server_name:
        return None
    if server_name in _server_cache:
        return _server_cache[server_name]
    try:
        url = f'http://{server_name}.evony.com/config.xml'
        d = urlopen(url, timeout=10).read()
        d = ET.fromstring(d)
        ip = d.find('server').text
        _server_cache[server_name] = ip
        return ip
    except:
        return None

# ============================================================================
# EXTRACTION - From source lines 95-160
# ============================================================================
def extract_single(email, password, server, server_ip=None):
    """Single extraction attempt based on pyEvony Client.__init__ and loginresponsehandler"""
    
    # Get server IP (from source line 91-92)
    if server_ip:
        host = server_ip
    else:
        host = get_server_address(server)
        if not host:
            return None, f"No IP for {server}"
    
    conn = None
    try:
        # Connect (from source line 94)
        conn = Connection(host, PORT, TIMEOUT)
        
        # Send version (from source line 95)
        conn.sendmessage('gameClient.version', GAME_VERSION)
        
        # Hash password with SHA1 (from source line 101)
        pwd_hash = hashlib.sha1(password.encode('utf-8')).hexdigest()
        
        # Send login (from source lines 102-103)
        conn.sendmessage('login', {'user': email, 'pwd': pwd_hash})
        
        # Wait for server.LoginResponse (from source lines 152-156)
        response = None
        for _ in range(20):
            resp = conn.receivedata()
            if resp.get('cmd') == 'server.LoginResponse':
                response = resp
                break
        
        conn.close()
        
        if not response:
            return None, "No LoginResponse"
        
        data = response.get('data', {})
        ok = data.get('ok')
        
        # Handle response (from source lines 127-135, 157-159)
        if ok == 1:
            return data, None
        elif ok == -1:
            return None, "Bad credentials"
        elif ok == -2:
            return None, "Wrong server"
        elif ok == -3:
            return None, "Already logged in"  # Retryable
        elif ok == -4:
            return None, "Needs setup"
        else:
            return None, f"Error {ok}"
            
    except TimeoutError as e:
        return None, "Timeout"
    except ConnectionError as e:
        return None, "Connection closed"
    except Exception as e:
        return None, str(e)[:25]
    finally:
        if conn:
            conn.close()

def extract_account(email, password, server, server_ip=None):
    """Extract with retry for already-logged-in accounts"""
    retryable = ["Already logged in", "Connection closed", "Timeout", "No LoginResponse"]
    
    last_error = None
    for attempt in range(MAX_RETRIES):
        data, error = extract_single(email, password, server, server_ip)
        
        if data:
            return data, None
        
        last_error = error
        if error and any(e in error for e in retryable):
            if attempt < MAX_RETRIES - 1:
                time.sleep(RETRY_DELAY)
                continue
        break
    
    return None, last_error

# ============================================================================
# LOAD ACCOUNTS
# ============================================================================
def load_sol_accounts():
    """Load accounts from discovered SOL files"""
    if not SOL_PATHS_FILE.exists():
        return {}
    
    handler = SOLHandler()
    accounts = {}
    
    with open(SOL_PATHS_FILE, 'r') as f:
        paths = [line.strip() for line in f if line.strip()]
    
    for path in paths:
        if not os.path.exists(path):
            continue
        try:
            data = handler.read_sol(path)
            if data and '_error' not in data:
                info = handler.extract_account_info(data)
                email = info.get('email', '').lower().strip()
                if email and info.get('password'):
                    if email not in accounts or info.get('server_ip'):
                        accounts[email] = {
                            'email': info['email'],
                            'password': info['password'],
                            'server': info.get('server', 'cc2'),
                            'server_ip': info.get('server_ip', ''),
                            'source': 'sol',
                        }
        except:
            pass
    
    return accounts

def load_csv_accounts():
    """Load accounts from khan CSV"""
    if not KHAN_CSV.exists():
        return {}
    
    STATUS_WORDS = ['active', 'inactive', 'not working', 'working', 'semi', 'dead', 'banned']
    accounts = {}
    
    with open(KHAN_CSV, 'r', encoding='utf-8', errors='ignore') as f:
        for line in f:
            parts = line.strip().split(',', 1)
            if len(parts) >= 2:
                email = parts[0].strip()
                pwd = parts[1].strip()
                if not any(s in pwd.lower() for s in STATUS_WORDS) and len(pwd) >= 3:
                    accounts[email.lower()] = {
                        'email': email,
                        'password': pwd,
                        'server': 'cc2',
                        'server_ip': '',
                        'source': 'csv',
                    }
    
    return accounts

# ============================================================================
# MAIN
# ============================================================================
def main():
    print("=" * 70)
    print("MASTER EXTRACTOR - FIXED (Based on pyEvony source)")
    print("=" * 70)
    
    # Parse args
    test_count = None
    for i, arg in enumerate(sys.argv):
        if arg == '--test' and i + 1 < len(sys.argv):
            test_count = int(sys.argv[i + 1])
    
    # Load accounts
    print("\n[1] Loading accounts...")
    sol_accounts = load_sol_accounts()
    csv_accounts = load_csv_accounts()
    
    # Merge (SOL preferred - has server IP)
    all_accounts = {}
    for email, acc in sol_accounts.items():
        all_accounts[email] = acc
    for email, acc in csv_accounts.items():
        if email not in all_accounts:
            all_accounts[email] = acc
    
    accounts = list(all_accounts.values())
    print(f"    SOL: {len(sol_accounts)}, CSV: {len(csv_accounts)}, Total: {len(accounts)}")
    
    if test_count:
        accounts = accounts[:test_count]
        print(f"\n[TEST MODE] {len(accounts)} accounts")
    
    # Extract
    print(f"\n[2] Extracting (retry={MAX_RETRIES}, timeout={TIMEOUT}s)...")
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    
    success = 0
    failed = 0
    errors = defaultdict(int)
    
    for i, acc in enumerate(accounts, 1):
        email = acc['email']
        pct = (i / len(accounts)) * 100
        print(f"[{i}/{len(accounts)}] ({pct:.0f}%) {email[:35]:35}", end=" ", flush=True)
        
        data, error = extract_account(email, acc['password'], acc['server'], acc['server_ip'])
        
        if data:
            safe = email.replace('@', '').replace('.', '')
            outfile = OUTPUT_DIR / f"{safe}.json"
            data['_extracted'] = datetime.now().isoformat()
            data['_email'] = email
            
            with open(outfile, 'w') as f:
                json.dump(data, f, indent=2, default=str)
            
            player = data.get('player', {})
            name = player.get('playerInfo', {}).get('userName', '?')
            cities = len(player.get('castles', []))
            print(f"✓ {name} ({cities})")
            success += 1
        else:
            print(f"✗ {error}")
            failed += 1
            errors[error] += 1
        
        time.sleep(DELAY_BETWEEN)
    
    print("\n" + "=" * 70)
    print(f"DONE: {success} success, {failed} failed")
    print(f"Output: {OUTPUT_DIR}")
    
    if errors:
        print("\nErrors:")
        for e, c in sorted(errors.items(), key=lambda x: -x[1]):
            print(f"  {e}: {c}")

if __name__ == '__main__':
    main()
