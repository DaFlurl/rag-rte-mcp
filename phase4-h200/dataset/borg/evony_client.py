"""
Evony Client - Correct AMF Protocol Implementation
Based on AutoEvony Connection.as source code

Protocol (from Connection.as):
1. Connect to game server IP:443 (RAW TCP, no SSL)
2. Send "gameClient.version" with version string
3. Send "login" with {user: email, pwd: hashedPassword}

Packet Format:
- 4 bytes: length (big-endian int)
- N bytes: AMF3 encoded object {cmd: string, data: object}
"""

import socket
import struct
import hashlib
import time
import logging
from typing import Dict, Optional, Any, Tuple
from dataclasses import dataclass

# PyAMF for proper AMF encoding
try:
    import pyamf
    from pyamf.util import BufferedByteStream
    PYAMF_AVAILABLE = True
except ImportError:
    PYAMF_AVAILABLE = False
    print("[!] PyAMF not available. Run: pip install Py3AMF")

logger = logging.getLogger(__name__)

# Server configurations from config.xml
SERVERS = {
    'cc2': {'host': '216.66.17.168', 'port': 443, 'name': 'Parapet'},
    'cc1': {'host': '216.66.17.167', 'port': 443, 'name': 'CC1'},
    'cc3': {'host': '216.66.17.169', 'port': 443, 'name': 'CC3'},
    'na1': {'host': '216.66.17.165', 'port': 443, 'name': 'NA1'},
    'na2': {'host': '216.66.17.166', 'port': 443, 'name': 'NA2'},
}

# Game client version (from AutoEvony)
GAME_VERSION = "4.274"

@dataclass
class LoginResult:
    success: bool
    player_name: str = ""
    player_id: int = 0
    error: str = ""
    data: Dict = None

class EvonyClient:
    """
    Evony game client using correct AMF protocol.
    Based on AutoEvony Connection.as source.
    """
    
    def __init__(self, server: str = 'cc2'):
        self.server = server
        self.server_info = SERVERS.get(server, SERVERS['cc2'])
        self.socket: Optional[socket.socket] = None
        self.connected = False
        self.authenticated = False
        self.player_id = None
        self.player_name = None
        self.session_data = {}
        
    def connect(self) -> bool:
        """Connect to game server (raw TCP, no SSL)"""
        if not PYAMF_AVAILABLE:
            logger.error("PyAMF required for AMF protocol")
            return False
            
        try:
            host = self.server_info['host']
            port = self.server_info['port']
            
            logger.info(f"Connecting to {self.server} ({host}:{port})...")
            
            self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.socket.settimeout(30)
            self.socket.connect((host, port))
            
            self.connected = True
            logger.info("Connected!")
            
            # Send version handshake (required first step)
            self._send_command("gameClient.version", GAME_VERSION)
            
            return True
            
        except Exception as e:
            logger.error(f"Connection failed: {e}")
            return False
    
    def login(self, email: str, password: str) -> LoginResult:
        """Login to game server"""
        if not self.connected:
            return LoginResult(success=False, error="Not connected")
        
        try:
            # Password sent PLAIN (not hashed - server handles hashing)
            # Send login command
            login_data = {
                "user": email,
                "pwd": password
            }
            
            logger.info(f"Logging in as {email}...")
            self._send_command("login", login_data)
            
            # Wait for response
            response = self._receive_response(timeout=15)
            
            if response:
                cmd = response.get('cmd', '')
                data = response.get('data', {})
                
                if cmd == 'cyclopeServer.cyclopeServerLoginResponse':
                    # Successful login
                    player = data.get('player', {})
                    self.player_id = player.get('id')
                    self.player_name = player.get('n', player.get('name', ''))
                    self.session_data = data
                    self.authenticated = True
                    
                    logger.info(f"Login successful! Player: {self.player_name}")
                    return LoginResult(
                        success=True,
                        player_name=self.player_name,
                        player_id=self.player_id,
                        data=data
                    )
                elif 'error' in str(data).lower() or 'fail' in str(data).lower():
                    error = data.get('errorMsg', data.get('msg', str(data)))
                    return LoginResult(success=False, error=error)
                else:
                    # Might be ok=1 response
                    if data.get('ok') == 1:
                        self.authenticated = True
                        return LoginResult(success=True, data=data)
                    return LoginResult(success=False, error=f"Unknown response: {cmd}", data=data)
            
            return LoginResult(success=False, error="No response from server")
            
        except Exception as e:
            logger.error(f"Login error: {e}")
            return LoginResult(success=False, error=str(e))
    
    def send_command(self, cmd: str, data: Any = None) -> Optional[Dict]:
        """Send a game command and get response"""
        if not self.connected:
            return None
        
        self._send_command(cmd, data or {})
        return self._receive_response()
    
    def _send_command(self, cmd: str, data: Any):
        """Send command using AMF protocol (from Connection.as directSendMessage)"""
        # Build message object
        message = {"cmd": cmd, "data": data}
        
        # Encode to AMF3
        stream = BufferedByteStream()
        encoder = pyamf.get_encoder(pyamf.AMF3, stream)
        encoder.writeElement(message)
        amf_bytes = stream.getvalue()
        
        # Send: 4-byte length prefix + AMF data
        packet = struct.pack(">I", len(amf_bytes)) + amf_bytes
        
        logger.debug(f"Sending: {cmd} ({len(packet)} bytes)")
        self.socket.sendall(packet)
    
    def _receive_response(self, timeout: float = 10) -> Optional[Dict]:
        """Receive response using AMF protocol"""
        self.socket.settimeout(timeout)
        
        try:
            # Read 4-byte length
            header = self._recv_exact(4)
            if not header:
                return None
            
            length = struct.unpack(">I", header)[0]
            
            if length <= 0 or length > 0x100000:  # MAX_PACKAGE_SIZE
                logger.warning(f"Invalid package size: {length}")
                return None
            
            # Read AMF data
            amf_data = self._recv_exact(length)
            if not amf_data:
                return None
            
            # Decode AMF3
            stream = BufferedByteStream(amf_data)
            decoder = pyamf.get_decoder(pyamf.AMF3, stream)
            message = decoder.readElement()
            
            logger.debug(f"Received: {message.get('cmd', 'unknown')}")
            return message
            
        except socket.timeout:
            logger.debug("Receive timeout")
            return None
        except Exception as e:
            logger.error(f"Receive error: {e}")
            return None
    
    def _recv_exact(self, n: int) -> Optional[bytes]:
        """Receive exactly n bytes"""
        data = b''
        while len(data) < n:
            chunk = self.socket.recv(n - len(data))
            if not chunk:
                return None
            data += chunk
        return data
    
    def disconnect(self):
        """Disconnect from server"""
        if self.socket:
            try:
                self.socket.close()
            except:
                pass
        self.socket = None
        self.connected = False
        self.authenticated = False
    
    def get_player_info(self) -> Optional[Dict]:
        """Get full player info"""
        return self.send_command("gameClient.playerInfo", {})
    
    def get_cities(self) -> Optional[Dict]:
        """Get all cities"""
        return self.send_command("castle.getCastleFieldInfo", {})
    
    def get_heroes(self, city_id: int) -> Optional[Dict]:
        """Get heroes in city"""
        return self.send_command("hero.getHerosListFromTavern", {"castleId": city_id})


def test_login(email: str, password: str, server: str = 'cc2') -> LoginResult:
    """Quick test login function"""
    client = EvonyClient(server)
    
    if not client.connect():
        return LoginResult(success=False, error="Connection failed")
    
    result = client.login(email, password)
    client.disconnect()
    
    return result


if __name__ == "__main__":
    # Test with Borg account
    logging.basicConfig(level=logging.INFO)
    
    result = test_login("Tarasdbe@yahoo.com", "bojangles5", "cc2")
    print(f"Login result: {result}")
