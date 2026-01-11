"""
LIVE ACCOUNT EXTRACTOR v1.0
Connects directly to Evony servers and extracts current account data

Requires: pip install pyamf PySocks

Usage:
  python live_extract.py                 # Extract all accounts from CSV
  python live_extract.py --test          # Test with first 3 accounts
  python live_extract.py --single email  # Extract single account
"""
import socket
import hashlib
import json
import struct
import csv
import sys
import time
from pathlib import Path
from datetime import datetime
from urllib.request import urlopen
import xml.etree.ElementTree as ET

try:
    import pyamf
except ImportError:
    print("ERROR: pyamf not installed. Run: pip install pyamf")
    sys.exit(1)

try:
    import socks
except ImportError:
    print("WARNING: PySocks not installed. Proxy support disabled.")
    socks = None

# Configuration
KHAN_CSV = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\khanaccounts.csv')
OUTPUT_DIR = Path(r'D:\EvonyToolKit\scripts\khan_Accounts_556\accounts')
TIMEOUT = 30
USE_PROXY = False
PROXY_HOST = '127.0.0.1'
PROXY_PORT = 9999

class EvonyConnection:
    """Direct connection to Evony game server"""
    
    def __init__(self, host, port, use_proxy=False, proxy_host='', proxy_port=0):
        if use_proxy and socks:
            self.sock = socks.socksocket()
            self.sock.set_proxy(socks.SOCKS5, proxy_host, proxy_port)
        else:
            self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        
        self.sock.settimeout(TIMEOUT)
        self.sock.connect((str(host), port))
    
    def send(self, command, data):
        """Send AMF message to server"""
        msg = {'cmd': command, 'data': data}
        encoded = pyamf.encode(msg).read()
        size = len(encoded)
        packet = struct.pack('>L', size) + encoded
        self.sock.sendall(packet)
    
    def receive(self):
        """Receive AMF message from server"""
        # Read 4-byte length header
        header = b''
        while len(header) < 4:
            chunk = self.sock.recv(4 - len(header))
            if not chunk:
                raise ConnectionError("Connection closed")
            header += chunk
        
        length = struct.unpack('>L', header)[0]
        
        # Read message body
        data = b''
        while len(data) < length:
            chunk = self.sock.recv(length - len(data))
            if not chunk:
                raise ConnectionError("Connection closed")
            data += chunk
        
        return pyamf.decode(data).readElement()
    
    def close(self):
        self.sock.close()


def get_server_address(server_name):
    """Get server IP from config.xml"""
    try:
        url = f'http://{server_name}.evony.com/config.xml'
        response = urlopen(url, timeout=10)
        xml_data = response.read()
        root = ET.fromstring(xml_data)
        return root.find('server').text
    except Exception as e:
        print(f"  Failed to get server address: {e}")
        return None


def extract_account(email, password, server):
    """Extract data for a single account"""
    
    # Get server IP
    host = get_server_address(server)
    if not host:
        return None
    
    port = 443
    
    try:
        # Connect
        conn = EvonyConnection(host, port, USE_PROXY, PROXY_HOST, PROXY_PORT)
        
        # Send version
        conn.send('gameClient.version', '091103_11')
        
        # Login
        pwd_hash = hashlib.sha1(password.encode()).hexdigest()
        conn.send('login', {'user': email, 'pwd': pwd_hash})
        
        # Get response
        response = None
        for _ in range(10):  # Try up to 10 responses
            resp = conn.receive()
            if resp.get('cmd') == 'server.LoginResponse':
                response = resp
                break
        
        conn.close()
        
        if response and response.get('data', {}).get('ok') == 1:
            return response['data']
        else:
            error = response.get('data', {}).get('ok') if response else 'No response'
            print(f"  Login failed: {error}")
            return None
            
    except Exception as e:
        print(f"  Connection error: {e}")
        return None


def save_account_json(email, data):
    """Save account data to JSON file"""
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    
    safe_email = email.replace('@', '').replace('.', '')
    output_file = OUTPUT_DIR / f"{safe_email}.json"
    
    # Add extraction timestamp
    data['extracted'] = datetime.now().isoformat()
    data['msg'] = 'Live extraction'
    data['ok'] = 1
    
    with open(output_file, 'w') as f:
        json.dump(data, f, indent=2, default=str)
    
    return output_file


def load_accounts_from_csv():
    """Load accounts from khanaccounts.csv"""
    accounts = []
    
    with open(KHAN_CSV, 'r', encoding='utf-8', errors='ignore') as f:
        reader = csv.DictReader(f)
        for row in reader:
            email = row.get('email', '').strip()
            password = row.get('password', '').strip()
            server = row.get('server', '').strip()
            
            if email and password and server:
                accounts.append({
                    'email': email,
                    'password': password,
                    'server': server,
                })
    
    return accounts


def main():
    print("=" * 60)
    print("LIVE ACCOUNT EXTRACTOR")
    print("=" * 60)
    
    # Parse arguments
    test_mode = '--test' in sys.argv
    single_mode = '--single' in sys.argv
    
    if single_mode:
        idx = sys.argv.index('--single')
        if idx + 1 < len(sys.argv):
            target_email = sys.argv[idx + 1]
        else:
            print("Error: --single requires email argument")
            return
    
    # Load accounts
    accounts = load_accounts_from_csv()
    print(f"Loaded {len(accounts)} accounts from CSV")
    
    if test_mode:
        accounts = accounts[:3]
        print(f"TEST MODE: Processing first 3 accounts")
    
    if single_mode:
        accounts = [a for a in accounts if a['email'] == target_email]
        if not accounts:
            print(f"Account not found: {target_email}")
            return
    
    # Extract each account
    success = 0
    failed = 0
    
    for i, acc in enumerate(accounts, 1):
        email = acc['email']
        password = acc['password']
        server = acc['server']
        
        print(f"\n[{i}/{len(accounts)}] {email} @ {server}")
        
        data = extract_account(email, password, server)
        
        if data:
            output_file = save_account_json(email, data)
            
            # Show summary
            player = data.get('player', {})
            pi = player.get('playerInfo', {})
            castles = player.get('castles', [])
            
            name = pi.get('userName', 'Unknown')
            cities = len(castles)
            
            # Sum troops
            total_troops = 0
            for castle in castles:
                troop = castle.get('troop', {})
                total_troops += sum(int(v) for v in troop.values() if isinstance(v, (int, float)))
            
            print(f"  ✓ {name} - {cities} cities - {total_troops:,} troops")
            print(f"  Saved: {output_file.name}")
            success += 1
        else:
            print(f"  ✗ FAILED")
            failed += 1
        
        # Rate limiting
        time.sleep(1)
    
    print("\n" + "=" * 60)
    print(f"COMPLETE: {success} success, {failed} failed")
    print(f"Output: {OUTPUT_DIR}")
    print("=" * 60)


if __name__ == '__main__':
    main()
