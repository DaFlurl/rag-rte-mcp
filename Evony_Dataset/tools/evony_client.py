"""
ETK Evony Client - Python 3 port of pyEvony
Direct connection to Evony servers for account data extraction

Based on sonya75's pyEvony: https://github.com/sonya75/pyEvony-master
Protocol: AMF over raw socket on port 443
"""

import socket
import struct
import hashlib
import json
import os
import select
from pathlib import Path
from typing import Dict, Any, Optional, Callable
from datetime import datetime

import pyamf

# Try to import socks for proxy support
try:
    import socks
    SOCKS_AVAILABLE = True
except ImportError:
    SOCKS_AVAILABLE = False


class EvonyConnection:
    """Low-level socket connection to Evony server with AMF protocol"""
    
    def __init__(self, host: str, port: int = 443, 
                 proxy_host: str = '', proxy_port: int = 0, proxy_type: str = '',
                 callback: Callable = None, timeout: int = 30):
        self.callback = callback
        self.timeout = timeout
        
        # Create socket
        if proxy_host and SOCKS_AVAILABLE:
            self.socket = socks.socksocket()
            if proxy_type.upper() == 'HTTP':
                self.socket.set_proxy(socks.HTTP, proxy_host, proxy_port)
            elif proxy_type.upper() in ('SOCKS4', 'SS4'):
                self.socket.set_proxy(socks.SOCKS4, proxy_host, proxy_port)
            else:
                self.socket.set_proxy(socks.SOCKS5, proxy_host, proxy_port)
            self._log(f"Using proxy: {proxy_type}://{proxy_host}:{proxy_port}")
        else:
            self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        
        self.socket.settimeout(timeout)
        self.socket.connect((host, port))
        self._log(f"Connected to {host}:{port}")
    
    def _log(self, msg):
        if self.callback:
            self.callback(msg)
    
    def send_message(self, command: str, data: Any):
        """Send AMF-encoded message"""
        msg = {'cmd': command, 'data': data}
        self._log(f">> {command}")
        
        # AMF encode
        encoded = pyamf.encode(msg).read()
        
        # Prepend 4-byte length (big-endian)
        packet = struct.pack('>L', len(encoded)) + encoded
        self.socket.sendall(packet)
    
    def receive_message(self, timeout: int = 30) -> Dict:
        """Receive AMF-encoded message"""
        # Read 4-byte length header
        data = b''
        while len(data) < 4:
            ready = select.select([self.socket], [], [], timeout)
            if not ready[0]:
                raise TimeoutError("Timeout waiting for response")
            chunk = self.socket.recv(4 - len(data))
            if not chunk:
                raise ConnectionError("Connection closed")
            data += chunk
        
        length = struct.unpack('>L', data)[0]
        
        # Read message body
        data = b''
        while len(data) < length:
            ready = select.select([self.socket], [], [], timeout)
            if not ready[0]:
                raise TimeoutError("Timeout reading message")
            chunk = self.socket.recv(length - len(data))
            if not chunk:
                raise ConnectionError("Connection closed")
            data += chunk
        
        # AMF decode
        result = pyamf.decode(data).readElement()
        self._log(f"<< {result.get('cmd', 'unknown')}")
        return result
    
    def close(self):
        try:
            self.socket.close()
        except:
            pass


class EvonyClient:
    """
    Evony game client for login and data extraction.
    
    Usage:
        client = EvonyClient('cc2')
        if client.login('email@example.com', 'password'):
            data = client.get_player_data()
            client.close()
    """
    
    # Known server IPs (fallback if config.xml fails)
    SERVER_IPS = {
        'cc2': '216.66.17.35',
    }
    
    def __init__(self, server: str = 'cc2', callback: Callable = None, timeout: int = 30):
        self.server = server
        self.callback = callback
        self.timeout = timeout
        self.connection: Optional[EvonyConnection] = None
        self.logged_in = False
        self.player_data: Dict = {}
        self.email = ''
    
    def _log(self, msg):
        if self.callback:
            self.callback(msg)
        else:
            print(f"[EvonyClient] {msg}")
    
    def get_server_ip(self, server: str) -> str:
        """Get server IP from config.xml or fallback"""
        # Check cache
        cache_path = Path(r"D:\EvonyToolKit\data\servers.json")
        servers = {}
        if cache_path.exists():
            try:
                servers = json.loads(cache_path.read_text())
            except:
                pass
        
        if server in servers:
            return servers[server]
        
        # Try to fetch from config.xml
        try:
            import urllib.request
            import xml.etree.ElementTree as ET
            
            url = f"http://{server}.evony.com/config.xml"
            self._log(f"Fetching server IP from {url}")
            
            with urllib.request.urlopen(url, timeout=10) as resp:
                xml_data = resp.read()
            
            root = ET.fromstring(xml_data)
            ip = root.find('server').text
            
            # Cache it
            servers[server] = ip
            cache_path.parent.mkdir(parents=True, exist_ok=True)
            cache_path.write_text(json.dumps(servers))
            
            return ip
        except Exception as e:
            self._log(f"Failed to get IP from config.xml: {e}")
        
        # Use fallback
        return self.SERVER_IPS.get(server, server)
    
    def connect(self, proxy_host: str = '', proxy_port: int = 0, proxy_type: str = '') -> bool:
        """Connect to Evony server"""
        try:
            host = self.get_server_ip(self.server)
            self._log(f"Connecting to {self.server} ({host})")
            
            self.connection = EvonyConnection(
                host, 443,
                proxy_host=proxy_host,
                proxy_port=proxy_port,
                proxy_type=proxy_type,
                callback=self._log,
                timeout=self.timeout
            )
            
            # Send version handshake
            self.connection.send_message('gameClient.version', '091103_11')
            
            return True
        except Exception as e:
            self._log(f"Connection failed: {e}")
            return False
    
    def login(self, email: str, password: str) -> bool:
        """Login to Evony with credentials"""
        self.email = email
        
        if not self.connection:
            if not self.connect():
                return False
        
        try:
            # Hash password with SHA1
            pwd_hash = hashlib.sha1(password.encode()).hexdigest()
            
            # Send login request
            self.connection.send_message('login', {
                'user': email,
                'pwd': pwd_hash
            })
            
            # Wait for login response
            response = self._wait_for_response('server.LoginResponse')
            
            if response and response.get('data', {}).get('ok') == 1:
                self.logged_in = True
                self.player_data = response.get('data', {})
                self._log(f"Login successful!")
                return True
            else:
                error_code = response.get('data', {}).get('ok', 'unknown') if response else 'no response'
                self._log(f"Login failed: {error_code}")
                return False
                
        except Exception as e:
            self._log(f"Login error: {e}")
            return False
    
    def _wait_for_response(self, expected_cmd: str, max_messages: int = 10) -> Optional[Dict]:
        """Wait for a specific response command"""
        for _ in range(max_messages):
            try:
                response = self.connection.receive_message(self.timeout)
                if response.get('cmd') == expected_cmd:
                    return response
            except Exception as e:
                self._log(f"Error receiving: {e}")
                break
        return None
    
    def get_player_data(self) -> Dict:
        """Get the player data received at login"""
        return self.player_data
    
    def get_castles(self) -> list:
        """Get list of castles/cities"""
        player = self.player_data.get('player', {})
        return player.get('castles', [])
    
    def get_heroes(self) -> list:
        """Get list of heroes"""
        player = self.player_data.get('player', {})
        return player.get('heroes', [])
    
    def get_items(self) -> list:
        """Get list of items"""
        player = self.player_data.get('player', {})
        return player.get('items', [])
    
    def extract_account(self) -> Dict:
        """Extract complete account data"""
        if not self.logged_in:
            return {'error': 'Not logged in'}
        
        player = self.player_data.get('player', {})
        
        return {
            'extraction_time': datetime.now().isoformat(),
            'email': self.email,
            'server': self.server,
            'player_name': player.get('userName', ''),
            'player_id': player.get('id', 0),
            'prestige': player.get('prestige', 0),
            'honor': player.get('honor', 0),
            'alliance_name': player.get('allianceName', ''),
            'alliance_id': player.get('allianceId', 0),
            'cities': self.get_castles(),
            'heroes': self.get_heroes(),
            'items': self.get_items(),
            'raw_player': player
        }
    
    def close(self):
        """Close connection"""
        if self.connection:
            self.connection.close()
        self.logged_in = False


def extract_account(email: str, password: str, server: str = 'cc2') -> Dict:
    """
    Quick function to login and extract account data.
    
    Args:
        email: Account email
        password: Account password
        server: Server name (default 'cc2')
        
    Returns:
        Dict with account data or error
    """
    client = EvonyClient(server)
    
    if client.login(email, password):
        data = client.extract_account()
        client.close()
        return data
    else:
        client.close()
        return {'error': 'Login failed', 'email': email}


def save_account_json(data: Dict, output_dir: str = None) -> str:
    """Save account data to JSON file"""
    if output_dir is None:
        output_dir = Path(r"D:\EvonyToolKit\data\fresh_exports")
    else:
        output_dir = Path(output_dir)
    
    output_dir.mkdir(parents=True, exist_ok=True)
    
    email = data.get('email', 'unknown')
    safe_email = email.replace('@', '_at_').replace('.', '_')
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    
    filepath = output_dir / f"{safe_email}_{timestamp}.json"
    
    with open(filepath, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, default=str)
    
    return str(filepath)


if __name__ == '__main__':
    # Test with Borg's account
    print("=" * 60)
    print("ETK Evony Client - Account Extractor")
    print("=" * 60)
    
    email = "Tarasdbe@yahoo.com"
    password = "bojangles5"
    
    print(f"\nExtracting: {email}")
    print(f"Server: cc2")
    
    data = extract_account(email, password, 'cc2')
    
    if 'error' not in data:
        print(f"\n✓ Success!")
        print(f"  Player: {data.get('player_name', 'Unknown')}")
        print(f"  Cities: {len(data.get('cities', []))}")
        print(f"  Heroes: {len(data.get('heroes', []))}")
        print(f"  Items: {len(data.get('items', []))}")
        
        filepath = save_account_json(data)
        print(f"\n  Saved to: {filepath}")
    else:
        print(f"\n✗ Failed: {data.get('error')}")
