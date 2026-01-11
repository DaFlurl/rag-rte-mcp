"""
MASTER ACCOUNT EXTRACTOR v2.0
Extracts fresh data from ALL accounts using RoboEvony/pyEvony protocol

Uses pyamf to connect directly to Evony servers (same as RoboEvony does)
Logs into each account and saves the full player data to JSON

Requirements:
  pip install pyamf

Usage:
  python MASTER_EXTRACT_ALL.py              # Extract all accounts
  python MASTER_EXTRACT_ALL.py --test 5     # Test with first 5 accounts
  python MASTER_EXTRACT_ALL.py --server cc2 # Only extract from server cc2
"""
import socket
import hashlib
import json
import struct
import sys
import time
import os
from pathlib import Path
from datetime import datetime
from urllib.request import urlopen
import xml.etree.ElementTree as ET

try:
    import pyamf
except ImportError:
    print("ERROR: pyamf not installed")
    print("Run: pip install pyamf")
    sys.exit(1)

# ============================================================================
# CONFIGURATION
# ============================================================================
KHAN_CSV = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\khanaccounts.csv')
OUTPUT_DIR = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\accounts')
SERVERS_CACHE = Path(r'D:\EvonyToolKit\scripts\extraction\servers.json')

# Default server if not specified in account
DEFAULT_SERVER = 'cc2'

# List of servers to try (most common Evony Age 2 servers)
SERVERS_TO_TRY = ['cc2', 'na1', 'na2', 'na3', 'eu1', 'eu2', 'ss1', 'ss2', 'ss3', 'ss4']

# Connection settings
TIMEOUT = 30
GAME_VERSION = '091103_11'

# Rate limiting
DELAY_BETWEEN_ACCOUNTS = 0.5  # seconds

# ============================================================================
# CONNECTION CLASS (Python 3 version of pyEvony)
# ============================================================================
class EvonyConnection:
    """Direct connection to Evony game server using AMF protocol"""
    
    def __init__(self, host, port, timeout=30, silent=True):
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.sock.settimeout(timeout)
        self.silent = silent
        self.sock.connect((str(host), port))
    
    def send(self, command, data):
        """Send AMF-encoded message"""
        msg = {'cmd': command, 'data': data}
        if not self.silent:
            print(f"  >> {command}")
        
        encoded = pyamf.encode(msg).read()
        size = len(encoded)
        packet = struct.pack('>L', size) + encoded
        self.sock.sendall(packet)
    
    def receive(self):
        """Receive AMF-encoded message"""
        # Read 4-byte length header
        header = self._recv_exact(4)
        length = struct.unpack('>L', header)[0]
        
        # Read message body
        data = self._recv_exact(length)
        decoded = pyamf.decode(data).readElement()
        
        if not self.silent:
            cmd = decoded.get('cmd', 'unknown')
            print(f"  << {cmd}")
        
        return decoded
    
    def _recv_exact(self, size):
        """Receive exact number of bytes"""
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
# SERVER ADDRESS LOOKUP
# ============================================================================
def get_server_address(server_name, cache=None):
    """Get server IP from Evony config.xml"""
    
    # Check cache first
    if cache and server_name in cache:
        return cache[server_name]
    
    try:
        url = f'http://{server_name}.evony.com/config.xml'
        response = urlopen(url, timeout=10)
        xml_data = response.read()
        root = ET.fromstring(xml_data)
        ip = root.find('server').text
        
        # Update cache
        if cache is not None:
            cache[server_name] = ip
        
        return ip
    except Exception as e:
        print(f"  ERROR getting server {server_name}: {e}")
        return None


def load_server_cache():
    """Load cached server addresses"""
    if SERVERS_CACHE.exists():
        try:
            with open(SERVERS_CACHE, 'r') as f:
                return json.load(f)
        except:
            pass
    return {}


def save_server_cache(cache):
    """Save server address cache"""
    SERVERS_CACHE.parent.mkdir(parents=True, exist_ok=True)
    with open(SERVERS_CACHE, 'w') as f:
        json.dump(cache, f, indent=2)


# ============================================================================
# ACCOUNT EXTRACTION
# ============================================================================
def extract_account(email, password, server, server_cache, silent=True):
    """
    Login to account and extract full player data
    Returns the complete login response data
    """
    
    # Get server IP
    host = get_server_address(server, server_cache)
    if not host:
        return None, f"Cannot resolve server {server}"
    
    port = 443
    conn = None
    
    try:
        # Connect
        conn = EvonyConnection(host, port, TIMEOUT, silent)
        
        # Send game version
        conn.send('gameClient.version', GAME_VERSION)
        
        # Hash password (SHA1)
        pwd_hash = hashlib.sha1(password.encode('utf-8')).hexdigest()
        
        # Login
        conn.send('login', {'user': email, 'pwd': pwd_hash})
        
        # Wait for LoginResponse
        response = None
        for _ in range(20):  # Try up to 20 messages
            resp = conn.receive()
            if resp.get('cmd') == 'server.LoginResponse':
                response = resp
                break
        
        if not response:
            return None, "No LoginResponse received"
        
        data = response.get('data', {})
        ok = data.get('ok')
        
        if ok == 1:
            return data, None
        elif ok == -1:
            return None, "Invalid credentials"
        elif ok == -4:
            return None, "Account needs setup"
        elif ok == -99:
            return None, "Server maintenance"
        else:
            return None, f"Login failed: ok={ok}"
            
    except socket.timeout:
        return None, "Connection timeout"
    except ConnectionError as e:
        return None, f"Connection error: {e}"
    except Exception as e:
        return None, f"Error: {e}"
    finally:
        if conn:
            conn.close()


def save_account_json(email, data, output_dir):
    """Save account data to JSON file"""
    output_dir.mkdir(parents=True, exist_ok=True)
    
    # Create safe filename from email
    safe_email = email.replace('@', '').replace('.', '')
    output_file = output_dir / f"{safe_email}.json"
    
    # Add metadata
    data['_extracted'] = datetime.now().isoformat()
    data['_email'] = email
    
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, default=str)
    
    return output_file


# ============================================================================
# ACCOUNT LOADING
# ============================================================================
def load_accounts_from_csv(csv_path, default_server='cc2'):
    """
    Load accounts from CSV file
    Format: email,password (no header)
    Filters out status entries (active, inactive, not working, etc.)
    """
    accounts = []
    
    # Words that indicate status, not passwords
    STATUS_WORDS = ['active', 'inactive', 'not working', 'working', 'semi', 
                    'dead', 'banned', 'deleted', 'sold', 'given']
    
    with open(csv_path, 'r', encoding='utf-8', errors='ignore') as f:
        for line_num, line in enumerate(f, 1):
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            
            parts = line.split(',', 1)
            if len(parts) >= 2:
                email = parts[0].strip()
                password = parts[1].strip()
                
                # Skip if second column is status, not password
                if any(s in password.lower() for s in STATUS_WORDS):
                    continue
                
                if email and password and len(password) >= 3:
                    accounts.append({
                        'email': email,
                        'password': password,
                        'server': default_server,
                        'line': line_num,
                    })
    
    return accounts


def determine_server_from_json(email, json_dir):
    """Try to determine server from existing JSON file"""
    safe_email = email.replace('@', '').replace('.', '')
    json_file = json_dir / f"{safe_email}.json"
    
    if json_file.exists():
        try:
            with open(json_file, 'r') as f:
                data = json.load(f)
            # Try to find server info in the data
            # This varies by data structure
            return None  # Would need to parse actual server from data
        except:
            pass
    return None


# ============================================================================
# MAIN EXTRACTION
# ============================================================================
def main():
    print("=" * 70)
    print("MASTER ACCOUNT EXTRACTOR v2.0")
    print("Using RoboEvony/pyEvony protocol")
    print("=" * 70)
    
    # Parse arguments
    test_count = None
    target_server = DEFAULT_SERVER
    
    args = sys.argv[1:]
    i = 0
    while i < len(args):
        if args[i] == '--test' and i + 1 < len(args):
            test_count = int(args[i + 1])
            i += 2
        elif args[i] == '--server' and i + 1 < len(args):
            target_server = args[i + 1]
            i += 2
        else:
            i += 1
    
    # Load accounts
    print(f"\nLoading accounts from: {KHAN_CSV}")
    accounts = load_accounts_from_csv(KHAN_CSV, target_server)
    print(f"Found {len(accounts)} accounts")
    
    if test_count:
        accounts = accounts[:test_count]
        print(f"TEST MODE: Processing first {test_count} accounts")
    
    # Load server cache
    server_cache = load_server_cache()
    
    # Process accounts
    print(f"\nOutput directory: {OUTPUT_DIR}")
    print(f"Server: {target_server}")
    print("\n" + "-" * 70)
    
    success = 0
    failed = 0
    errors = []
    
    start_time = time.time()
    
    for i, acc in enumerate(accounts, 1):
        email = acc['email']
        password = acc['password']
        server = acc['server']
        
        # Progress
        pct = (i / len(accounts)) * 100
        print(f"[{i}/{len(accounts)}] ({pct:.0f}%) {email[:30]}...", end=" ", flush=True)
        
        # Extract
        data, error = extract_account(email, password, server, server_cache)
        
        if data:
            # Save to JSON
            output_file = save_account_json(email, data, OUTPUT_DIR)
            
            # Get player name
            player = data.get('player', {})
            pi = player.get('playerInfo', {})
            name = pi.get('userName', '?')
            cities = len(player.get('castles', []))
            
            print(f"✓ {name} ({cities} cities)")
            success += 1
        else:
            print(f"✗ {error}")
            failed += 1
            errors.append({'email': email, 'error': error})
        
        # Rate limiting
        if i < len(accounts):
            time.sleep(DELAY_BETWEEN_ACCOUNTS)
    
    # Save server cache
    save_server_cache(server_cache)
    
    # Summary
    elapsed = time.time() - start_time
    print("\n" + "=" * 70)
    print("EXTRACTION COMPLETE")
    print("=" * 70)
    print(f"Success: {success}")
    print(f"Failed:  {failed}")
    print(f"Time:    {elapsed:.1f}s ({elapsed/len(accounts):.2f}s per account)")
    print(f"Output:  {OUTPUT_DIR}")
    
    if errors:
        print(f"\nFailed accounts saved to: extraction_errors.json")
        with open('extraction_errors.json', 'w') as f:
            json.dump(errors, f, indent=2)


if __name__ == '__main__':
    main()
