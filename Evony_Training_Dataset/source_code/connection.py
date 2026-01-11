# BORG TOOLKIT - Live Server Connection Module
"""
Enterprise-grade live connection to Evony servers.
Handles AMF protocol, packet capture, and real-time data extraction.

Features:
- Direct server connection via AMF/TCP port 443
- Proxy support (SOCKS4/5, HTTP)
- Packet interception and logging
- Live data streaming
- Multi-account session management
"""

import socket
import struct
import hashlib
import json
import threading
import queue
import time
from pathlib import Path
from typing import Dict, Any, Optional, Callable, List
from datetime import datetime
from dataclasses import dataclass, field

try:
    import pyamf
    PYAMF_AVAILABLE = True
except ImportError:
    PYAMF_AVAILABLE = False
    print("[!] pyamf not installed. Run: pip install pyamf")

try:
    import socks
    SOCKS_AVAILABLE = True
except ImportError:
    SOCKS_AVAILABLE = False


# =============================================================================
# ENCRYPTION KEYS (Extracted from EvonyClient1921.swf)
# =============================================================================

EVONY_KEYS = {
    'ACTION_KEY': "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}",
    'API_KEY': "9f758e2deccbe6244f734371b9642eda",
    'USER_INFO_KEY': "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}",
    'XOR_KEY': 0xAA,
    'LOGIN_SALT': "evony",
}

# Known server IPs
SERVER_IPS = {
    'na1': '216.66.17.35', 'na2': '216.66.17.36', 'na3': '216.66.17.37',
    'na4': '216.66.17.38', 'na5': '216.66.17.39', 'na6': '216.66.17.40',
    'cc1': '216.66.17.35', 'cc2': '216.66.17.36', 'cc3': '216.66.17.37',
    'ss1': '216.66.17.50', 'ss2': '216.66.17.51', 'ss3': '216.66.17.52',
}


@dataclass
class PacketLog:
    """Logged packet data"""
    timestamp: datetime
    direction: str  # 'sent' or 'received'
    command: str
    data: Dict
    raw_size: int
    
    def to_dict(self) -> Dict:
        return {
            'timestamp': self.timestamp.isoformat(),
            'direction': self.direction,
            'command': self.command,
            'data': self.data,
            'raw_size': self.raw_size,
        }


@dataclass
class SessionState:
    """Current session state"""
    connected: bool = False
    logged_in: bool = False
    server: str = ""
    username: str = ""
    player_id: int = 0
    castles: List[Dict] = field(default_factory=list)
    resources: Dict = field(default_factory=dict)
    troops: Dict = field(default_factory=dict)
    items: List[Dict] = field(default_factory=list)
    last_update: Optional[datetime] = None


class EvonyConnection:
    """
    Live connection to Evony server with packet capture.
    
    Usage:
        conn = EvonyConnection('na1')
        conn.connect()
        conn.login('email', 'password')
        
        # Get live data
        player = conn.get_player_data()
        
        # Inject packets
        conn.send_command('troop.produceTroop', {...})
    """
    
    def __init__(self, server: str = 'na1', 
                 proxy_host: str = '', proxy_port: int = 0, proxy_type: str = '',
                 log_packets: bool = True, callback: Callable = None):
        self.server = server
        self.proxy_host = proxy_host
        self.proxy_port = proxy_port
        self.proxy_type = proxy_type
        self.log_packets = log_packets
        self.callback = callback
        
        self.socket: Optional[socket.socket] = None
        self.state = SessionState()
        self.packet_log: List[PacketLog] = []
        self.response_queue = queue.Queue()
        self.listener_thread: Optional[threading.Thread] = None
        self.running = False
        
    def _log(self, msg: str, level: str = 'INFO'):
        """Log message"""
        timestamp = datetime.now().strftime('%H:%M:%S')
        formatted = f"[{timestamp}] [{level}] {msg}"
        if self.callback:
            self.callback(formatted)
        else:
            print(formatted)
    
    def _get_server_ip(self) -> str:
        """Get server IP from cache or config.xml"""
        if self.server in SERVER_IPS:
            return SERVER_IPS[self.server]
        
        # Try fetching from config.xml
        try:
            import urllib.request
            import xml.etree.ElementTree as ET
            
            url = f"http://{self.server}.evony.com/config.xml"
            with urllib.request.urlopen(url, timeout=10) as resp:
                xml_data = resp.read()
            root = ET.fromstring(xml_data)
            ip = root.find('server').text
            SERVER_IPS[self.server] = ip
            return ip
        except:
            return self.server  # Assume it's an IP
    
    def connect(self, timeout: int = 30) -> bool:
        """Connect to Evony server"""
        try:
            host = self._get_server_ip()
            self._log(f"Connecting to {self.server} ({host}:443)...")
            
            # Create socket with optional proxy
            if self.proxy_host and SOCKS_AVAILABLE:
                self.socket = socks.socksocket()
                proxy_map = {'HTTP': socks.HTTP, 'SOCKS4': socks.SOCKS4, 'SOCKS5': socks.SOCKS5}
                ptype = proxy_map.get(self.proxy_type.upper(), socks.SOCKS5)
                self.socket.set_proxy(ptype, self.proxy_host, self.proxy_port)
                self._log(f"Using proxy: {self.proxy_type}://{self.proxy_host}:{self.proxy_port}")
            else:
                self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            
            self.socket.settimeout(timeout)
            self.socket.connect((host, int(443)))
            
            # Send version handshake
            self._send_packet('gameClient.version', '091103_11')
            
            self.state.connected = True
            self.state.server = self.server
            self._log("Connected successfully", "SUCCESS")
            
            # Start listener thread
            self.running = True
            self.listener_thread = threading.Thread(target=self._listen_loop, daemon=True)
            self.listener_thread.start()
            
            return True
            
        except Exception as e:
            self._log(f"Connection failed: {e}", "ERROR")
            return False
    
    def _send_packet(self, command: str, data: Any) -> bool:
        """Send AMF packet to server"""
        if not PYAMF_AVAILABLE:
            self._log("pyamf not available", "ERROR")
            return False
            
        try:
            msg = {'cmd': command, 'data': data}
            encoded = pyamf.encode(msg).read()
            packet = struct.pack('>L', len(encoded)) + encoded
            
            self.socket.sendall(packet)
            
            if self.log_packets:
                self.packet_log.append(PacketLog(
                    timestamp=datetime.now(),
                    direction='sent',
                    command=command,
                    data=data if isinstance(data, dict) else {'value': data},
                    raw_size=len(packet)
                ))
            
            self._log(f">> {command}", "SEND")
            return True
            
        except Exception as e:
            self._log(f"Send failed: {e}", "ERROR")
            return False
    
    def _receive_packet(self, timeout: int = 30) -> Optional[Dict]:
        """Receive AMF packet from server"""
        if not PYAMF_AVAILABLE:
            return None
            
        try:
            import select
            
            # Read length header
            data = b''
            while len(data) < 4:
                ready = select.select([self.socket], [], [], timeout)
                if not ready[0]:
                    return None
                chunk = self.socket.recv(4 - len(data))
                if not chunk:
                    return None
                data += chunk
            
            length = struct.unpack('>L', data)[0]
            
            # Read body
            data = b''
            while len(data) < length:
                ready = select.select([self.socket], [], [], timeout)
                if not ready[0]:
                    return None
                chunk = self.socket.recv(length - len(data))
                if not chunk:
                    return None
                data += chunk
            
            # Decode
            result = pyamf.decode(data).readElement()
            
            if self.log_packets:
                cmd = result.get('cmd', 'unknown')
                self.packet_log.append(PacketLog(
                    timestamp=datetime.now(),
                    direction='received',
                    command=cmd,
                    data=result.get('data', {}),
                    raw_size=length + 4
                ))
            
            return result
            
        except Exception as e:
            self._log(f"Receive error: {e}", "ERROR")
            return None
    
    def _listen_loop(self):
        """Background thread to listen for server responses"""
        while self.running:
            try:
                packet = self._receive_packet(timeout=1)
                if packet:
                    cmd = packet.get('cmd', '')
                    self._log(f"<< {cmd}", "RECV")
                    self.response_queue.put(packet)
                    self._process_response(packet)
            except:
                pass
    
    def _process_response(self, packet: Dict):
        """Process server response and update state"""
        cmd = packet.get('cmd', '')
        data = packet.get('data', {})
        
        if cmd == 'login.login':
            if data.get('ok', 0) == 1:
                self.state.logged_in = True
                player = data.get('player', {})
                self.state.player_id = player.get('id', 0)
                self.state.username = player.get('userName', '')
                self._log(f"Logged in as: {self.state.username}", "SUCCESS")
        
        elif cmd == 'castle.getCastleFieldInfo':
            self.state.last_update = datetime.now()
    
    def login(self, email: str, password: str) -> bool:
        """Login to Evony server"""
        if not self.state.connected:
            self._log("Not connected", "ERROR")
            return False
        
        # Generate password hash
        pwd_hash = hashlib.md5((password + EVONY_KEYS['LOGIN_SALT']).encode()).hexdigest()
        
        login_data = {
            'user': email,
            'pwd': pwd_hash,
            'platform': 'web',
        }
        
        self._send_packet('login.login', login_data)
        
        # Wait for response
        try:
            while True:
                packet = self.response_queue.get(timeout=30)
                if packet.get('cmd') == 'login.login':
                    return packet.get('data', {}).get('ok', 0) == 1
        except queue.Empty:
            self._log("Login timeout", "ERROR")
            return False
    
    def send_command(self, command: str, params: Dict) -> Optional[Dict]:
        """Send game command and wait for response"""
        self._send_packet(command, params)
        
        try:
            while True:
                packet = self.response_queue.get(timeout=30)
                if packet.get('cmd') == command:
                    return packet.get('data')
        except queue.Empty:
            return None
    
    def get_player_data(self) -> Dict:
        """Get full player data"""
        return {
            'server': self.state.server,
            'username': self.state.username,
            'player_id': self.state.player_id,
            'logged_in': self.state.logged_in,
            'castles': self.state.castles,
            'resources': self.state.resources,
        }
    
    def export_packet_log(self, filepath: Path = None) -> Path:
        """Export packet log to JSON"""
        if filepath is None:
            filepath = Path(f"packet_log_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json")
        
        log_data = [p.to_dict() for p in self.packet_log]
        filepath.write_text(json.dumps(log_data, indent=2))
        return filepath
    
    def close(self):
        """Close connection"""
        self.running = False
        if self.socket:
            try:
                self.socket.close()
            except:
                pass
        self.state.connected = False
        self._log("Connection closed")


class PacketSniffer:
    """
    Passive packet sniffer for Evony traffic.
    Captures packets without active connection.
    """
    
    def __init__(self, interface: str = 'eth0', port: int = 443):
        self.interface = interface
        self.port = port
        self.packets: List[PacketLog] = []
        self.running = False
    
    def start(self):
        """Start packet capture (requires root/admin)"""
        self._log("Packet sniffing requires scapy and admin privileges")
        self._log("Install: pip install scapy")
        # Implementation would use scapy for actual capture
    
    def _log(self, msg):
        print(f"[Sniffer] {msg}")


class MultiSessionManager:
    """
    Manage multiple Evony connections simultaneously.
    Useful for multi-account operations.
    """
    
    def __init__(self):
        self.sessions: Dict[str, EvonyConnection] = {}
    
    def add_session(self, name: str, server: str, email: str, password: str) -> bool:
        """Add and connect a new session"""
        conn = EvonyConnection(server)
        if conn.connect() and conn.login(email, password):
            self.sessions[name] = conn
            return True
        return False
    
    def get_session(self, name: str) -> Optional[EvonyConnection]:
        """Get session by name"""
        return self.sessions.get(name)
    
    def broadcast_command(self, command: str, params: Dict) -> Dict[str, Any]:
        """Send command to all sessions"""
        results = {}
        for name, conn in self.sessions.items():
            results[name] = conn.send_command(command, params)
        return results
    
    def close_all(self):
        """Close all sessions"""
        for conn in self.sessions.values():
            conn.close()
        self.sessions.clear()


def test_connection():
    """Test connection module"""
    print("=" * 60)
    print("BORG TOOLKIT - Connection Module Test")
    print("=" * 60)
    
    conn = EvonyConnection('na1', log_packets=True)
    print(f"\n[+] Server IPs loaded: {len(SERVER_IPS)}")
    print(f"[+] Encryption keys loaded: {len(EVONY_KEYS)}")
    print(f"[+] pyamf available: {PYAMF_AVAILABLE}")
    print(f"[+] socks available: {SOCKS_AVAILABLE}")
    
    print("\nTo connect:")
    print("  conn = EvonyConnection('na1')")
    print("  conn.connect()")
    print("  conn.login('email', 'password')")


if __name__ == "__main__":
    test_connection()
