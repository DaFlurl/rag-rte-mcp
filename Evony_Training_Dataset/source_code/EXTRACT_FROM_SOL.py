"""
MASTER EXTRACTOR - Uses SOL files for credentials with correct servers
Based on sol_handler.py source code analysis

SOL config.sol structure (from source):
  now.username   = email
  now.password   = password  
  now.server     = server code (cc2, na1, etc)
  now.serverIP   = actual server IP
  now.sid        = server ID
"""
import sys
import json
import socket
import hashlib
import struct
import time
from pathlib import Path
from datetime import datetime
from urllib.request import urlopen
import xml.etree.ElementTree as ET

# Add sol_manager to path
sys.path.insert(0, r'D:\EvonyToolKit\sol_manager')
from sol_handler import SOLHandler

try:
    import pyamf
except ImportError:
    print("ERROR: pyamf not installed. Run: pip install pyamf")
    sys.exit(1)

# ============================================================================
# CONFIGURATION  
# ============================================================================
SOL_BACKUP_DIR = Path(r'D:\EvonyToolKit\SOL_Backups')
OUTPUT_DIR = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\accounts')
TIMEOUT = 30
GAME_VERSION = '091103_11'

# ============================================================================
# EVONY CONNECTION (from pyEvony source)
# ============================================================================
class EvonyConnection:
    def __init__(self, host, port, timeout=30):
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
# SERVER ADDRESS (from pyEvony source - evony.py line 163-178)
# ============================================================================
_server_cache = {}

def get_server_address(server_name):
    """Get server IP from config.xml (from pyEvony getaddress method)"""
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
    except Exception as e:
        return None

# ============================================================================
# EXTRACTION (from pyEvony source - login protocol)
# ============================================================================
def extract_account(email, password, server, server_ip=None):
    """
    Login and extract account data
    Based on pyEvony Client.__init__ and loginresponsehandler
    """
    # Get server IP
    if server_ip:
        host = server_ip
    else:
        host = get_server_address(server)
        if not host:
            return None, f"Cannot resolve server {server}"
    
    port = 443  # From pyEvony source line 93
    
    try:
        conn = EvonyConnection(host, port, TIMEOUT)
        
        # Send version (from pyEvony line 95)
        conn.send('gameClient.version', GAME_VERSION)
        
        # Hash password with SHA1 (from pyEvony line 101)
        pwd_hash = hashlib.sha1(password.encode('utf-8')).hexdigest()
        
        # Send login (from pyEvony lines 102-103)
        conn.send('login', {'user': email, 'pwd': pwd_hash})
        
        # Wait for server.LoginResponse (from pyEvony line 124)
        response = None
        for _ in range(20):
            resp = conn.receive()
            if resp.get('cmd') == 'server.LoginResponse':
                response = resp
                break
        
        conn.close()
        
        if not response:
            return None, "No LoginResponse"
        
        data = response.get('data', {})
        ok = data.get('ok')
        
        # Handle response codes (from pyEvony lines 127-133)
        if ok == 1:
            return data, None
        elif ok == -1:
            return None, "Invalid credentials"
        elif ok == -2:
            return None, "Wrong server"
        elif ok == -4:
            return None, "Account needs setup"
        else:
            return None, f"Login error: ok={ok}"
            
    except socket.timeout:
        return None, "Timeout"
    except Exception as e:
        return None, str(e)

# ============================================================================
# LOAD ACCOUNTS FROM SOL FILES
# ============================================================================
def load_accounts_from_sol():
    """
    Extract account credentials from config.sol files
    Using sol_handler.py extract_account_info method
    """
    handler = SOLHandler()
    accounts = []
    
    # Find all config.sol files
    config_files = list(SOL_BACKUP_DIR.rglob('config.sol'))
    print(f"Found {len(config_files)} config.sol files")
    
    for cf in config_files:
        data = handler.read_sol(str(cf))
        if data and '_error' not in data:
            # Use extract_account_info from source (lines 161-188)
            info = handler.extract_account_info(data)
            
            if info['email'] and info['password']:
                accounts.append({
                    'email': info['email'],
                    'password': info['password'],
                    'server': info['server'],
                    'server_ip': info['server_ip'],
                    'server_alias': info['server_alias'],
                    'source': str(cf),
                })
    
    return accounts

# ============================================================================
# MAIN
# ============================================================================
def main():
    print("=" * 70)
    print("MASTER EXTRACTOR - Using SOL credentials")
    print("Based on pyEvony and sol_handler.py source code")
    print("=" * 70)
    
    # Load accounts from SOL files
    print("\n[1] Loading accounts from SOL files...")
    accounts = load_accounts_from_sol()
    print(f"    Loaded {len(accounts)} accounts with credentials")
    
    if not accounts:
        print("ERROR: No accounts found in SOL files")
        return
    
    # Show sample
    print("\n    Sample accounts:")
    for acc in accounts[:5]:
        print(f"      {acc['email'][:30]:30} | {acc['server']:5} | {acc['server_ip']}")
    
    # Test mode - first 5 accounts
    test_mode = '--test' in sys.argv
    if test_mode:
        accounts = accounts[:5]
        print(f"\n[TEST MODE] Processing {len(accounts)} accounts")
    
    # Extract
    print(f"\n[2] Extracting account data...")
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    
    success = 0
    failed = 0
    
    for i, acc in enumerate(accounts, 1):
        email = acc['email']
        password = acc['password']
        server = acc['server']
        server_ip = acc['server_ip']
        
        print(f"    [{i}/{len(accounts)}] {email[:30]:30}", end=" ", flush=True)
        
        data, error = extract_account(email, password, server, server_ip)
        
        if data:
            # Save to JSON
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
        
        time.sleep(0.3)
    
    print("\n" + "=" * 70)
    print(f"COMPLETE: {success} success, {failed} failed")
    print(f"Output: {OUTPUT_DIR}")


if __name__ == '__main__':
    main()
