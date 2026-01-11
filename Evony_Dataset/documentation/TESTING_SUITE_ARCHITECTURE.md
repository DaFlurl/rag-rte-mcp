# 🧪 TESTING SUITE ARCHITECTURE
## Dual-SWF Interactive Testing Environment for Svony Studio

---

## 🎯 OVERVIEW

The Testing Suite provides a **side-by-side SWF testing environment** that allows you to:
1. Load EvonyClient.swf and AutoEvony.swf simultaneously
2. Intercept and decrypt ALL network traffic between client and server
3. Analyze AMF packets in real-time with full decryption
4. Test bot commands against live or simulated servers
5. Record sessions for AI training and replay

---

## 🏗️ ARCHITECTURE DIAGRAM

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        SVONY STUDIO - TESTING SUITE TAB                  │
├─────────────────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────┐   ┌─────────────────────────┐              │
│  │    EVONY CLIENT PANEL   │   │    AUTOEVONY BOT PANEL  │              │
│  │  ┌───────────────────┐  │   │  ┌───────────────────┐  │              │
│  │  │                   │  │   │  │                   │  │              │
│  │  │   Ruffle/Flash    │  │   │  │   Ruffle/Flash    │  │              │
│  │  │   SWF Emulator    │  │   │  │   SWF Emulator    │  │              │
│  │  │                   │  │   │  │                   │  │              │
│  │  │  EvonyClient.swf  │  │   │  │  AutoEvony.swf    │  │              │
│  │  │                   │  │   │  │                   │  │              │
│  │  └───────────────────┘  │   │  └───────────────────┘  │              │
│  │  [Load] [Reload] [Stop] │   │  [Load] [Reload] [Stop] │              │
│  └─────────────────────────┘   └─────────────────────────┘              │
├─────────────────────────────────────────────────────────────────────────┤
│                         PACKET INTERCEPTOR PROXY                         │
│  ┌────────────────────────────────────────────────────────────────────┐ │
│  │ 🔴 Recording │ Packets: 1,247 │ Decrypted: 1,245 │ Errors: 2      │ │
│  ├────────────────────────────────────────────────────────────────────┤ │
│  │ ┌──────────────────────────────────────────────────────────────┐   │ │
│  │ │ Time     │ Dir │ Command              │ Size │ Status        │   │ │
│  │ ├──────────────────────────────────────────────────────────────┤   │ │
│  │ │ 12:01:23 │ →   │ castle.getInfo       │ 128  │ ✅ Decrypted  │   │ │
│  │ │ 12:01:23 │ ←   │ castle.infoResponse  │ 2048 │ ✅ Decrypted  │   │ │
│  │ │ 12:01:24 │ →   │ army.getArmyList     │ 64   │ ✅ Decrypted  │   │ │
│  │ │ 12:01:24 │ ←   │ army.listResponse    │ 1536 │ ✅ Decrypted  │   │ │
│  │ │ 12:01:25 │ →   │ hero.getHeroList     │ 48   │ ✅ Decrypted  │   │ │
│  │ └──────────────────────────────────────────────────────────────┘   │ │
│  └────────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────────┤
│                          PACKET DETAIL VIEW                              │
│  ┌──────────────────┬──────────────────┬─────────────────────────────┐  │
│  │     RAW HEX      │    DECRYPTED     │      PARSED AMF             │  │
│  ├──────────────────┼──────────────────┼─────────────────────────────┤  │
│  │ 00 10 00 03 00   │ {                │ castle.getInfo              │  │
│  │ 00 00 01 00 0b   │   "cmd": "get",  │ ├── castleId: 123456        │  │
│  │ 63 61 73 74 6c   │   "castle": {    │ ├── playerId: 789012        │  │
│  │ 65 2e 67 65 74   │     "id": 123,   │ └── timestamp: 1704326400   │  │
│  │ 49 6e 66 6f 00   │     "player":    │                             │  │
│  │ ...              │     789012       │                             │  │
│  │                  │   }              │                             │  │
│  │                  │ }                │                             │  │
│  └──────────────────┴──────────────────┴─────────────────────────────┘  │
├─────────────────────────────────────────────────────────────────────────┤
│ [▶ Start Proxy] [⏹ Stop] [💾 Export] [🔄 Clear] [⚙️ Settings]          │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 📂 FILE STRUCTURE

```
D:\svony_studio\
├── src\
│   ├── ui\
│   │   └── panels\
│   │       ├── testing_suite_panel.py      # Main testing tab
│   │       ├── swf_viewer_panel.py         # Ruffle SWF embedding
│   │       ├── packet_log_panel.py         # Real-time packet list
│   │       ├── packet_detail_panel.py      # Hex/decrypted/parsed view
│   │       └── command_sender_panel.py     # Manual command testing
│   │
│   └── core\
│       ├── amf_interceptor.py              # MITM proxy server
│       ├── amf_decoder.py                  # AMF3 binary parsing
│       ├── decryption_engine.py            # Multi-algorithm decryptor
│       ├── packet_recorder.py              # Session recording
│       └── packet_replayer.py              # Replay for testing
│
├── tools\
│   └── ruffle\
│       ├── ruffle.exe                      # Flash emulator
│       └── ruffle-config.json              # Ruffle settings
│
└── data\
    └── recordings\
        ├── session_*.amf                   # Recorded sessions
        └── training_*.json                 # AI training data
```

---

## 🔧 CORE COMPONENTS

### 1. AMF Interceptor Proxy

The proxy sits between the SWF and server, capturing all traffic:

```python
# src/core/amf_interceptor.py

import socket
import threading
import ssl
from typing import Callable, Dict, Any
from dataclasses import dataclass
from datetime import datetime

@dataclass
class InterceptedPacket:
    timestamp: datetime
    direction: str  # 'outgoing' or 'incoming'
    raw_data: bytes
    decrypted_data: bytes = None
    parsed_amf: Dict[str, Any] = None
    command_name: str = None
    error: str = None

class AMFInterceptorProxy:
    """
    Man-in-the-middle proxy for capturing Evony AMF traffic.
    
    Architecture:
    - Listens on local port (default 8888)
    - SWF configured to connect to localhost:8888
    - Proxy forwards to real Evony server
    - All traffic intercepted and decrypted
    """
    
    def __init__(
        self,
        local_port: int = 8888,
        target_host: str = 'game.evony.com',
        target_port: int = 443,
        on_packet: Callable[[InterceptedPacket], None] = None
    ):
        self.local_port = local_port
        self.target_host = target_host
        self.target_port = target_port
        self.on_packet = on_packet
        self.running = False
        self.server_socket = None
        self.connections = []
        
        # Initialize decryption engine with all known keys
        from .decryption_engine import DecryptionEngine
        self.decryptor = DecryptionEngine()
        
        # Initialize AMF decoder
        from .amf_decoder import AMFDecoder
        self.amf_decoder = AMFDecoder()
    
    def start(self):
        """Start the interceptor proxy."""
        self.running = True
        self.server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.server_socket.bind(('127.0.0.1', self.local_port))
        self.server_socket.listen(5)
        
        print(f"[PROXY] Listening on 127.0.0.1:{self.local_port}")
        print(f"[PROXY] Forwarding to {self.target_host}:{self.target_port}")
        
        # Accept connections in background thread
        threading.Thread(target=self._accept_loop, daemon=True).start()
    
    def stop(self):
        """Stop the interceptor proxy."""
        self.running = False
        if self.server_socket:
            self.server_socket.close()
        for conn in self.connections:
            conn.close()
    
    def _accept_loop(self):
        """Accept incoming connections."""
        while self.running:
            try:
                client_socket, addr = self.server_socket.accept()
                print(f"[PROXY] New connection from {addr}")
                threading.Thread(
                    target=self._handle_connection,
                    args=(client_socket,),
                    daemon=True
                ).start()
            except Exception as e:
                if self.running:
                    print(f"[PROXY] Accept error: {e}")
    
    def _handle_connection(self, client_socket):
        """Handle a single client connection."""
        try:
            # Connect to real server
            server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            server_socket = ssl.wrap_socket(server_socket)
            server_socket.connect((self.target_host, self.target_port))
            
            self.connections.append(client_socket)
            self.connections.append(server_socket)
            
            # Bidirectional forwarding with interception
            threading.Thread(
                target=self._forward,
                args=(client_socket, server_socket, 'outgoing'),
                daemon=True
            ).start()
            
            self._forward(server_socket, client_socket, 'incoming')
            
        except Exception as e:
            print(f"[PROXY] Connection error: {e}")
        finally:
            client_socket.close()
    
    def _forward(self, source, dest, direction):
        """Forward data between sockets with interception."""
        try:
            while self.running:
                data = source.recv(65536)
                if not data:
                    break
                
                # Create packet object
                packet = InterceptedPacket(
                    timestamp=datetime.now(),
                    direction=direction,
                    raw_data=data
                )
                
                # Try to decrypt
                try:
                    packet.decrypted_data = self.decryptor.decrypt(data)
                except Exception as e:
                    packet.error = f"Decryption failed: {e}"
                
                # Try to parse AMF
                if packet.decrypted_data:
                    try:
                        packet.parsed_amf = self.amf_decoder.decode(packet.decrypted_data)
                        packet.command_name = packet.parsed_amf.get('command', 'unknown')
                    except Exception as e:
                        packet.error = f"AMF parse failed: {e}"
                
                # Notify callback
                if self.on_packet:
                    self.on_packet(packet)
                
                # Forward to destination
                dest.send(data)
                
        except Exception as e:
            if self.running:
                print(f"[PROXY] Forward error: {e}")
```

### 2. Decryption Engine

Multi-algorithm decryptor using all known keys:

```python
# src/core/decryption_engine.py

from Crypto.Cipher import AES, Blowfish, DES3, ARC4
from Crypto.Util.Padding import unpad
import hashlib

class DecryptionEngine:
    """
    Universal decryption engine for Evony traffic.
    Supports: AES, Blowfish, 3DES, RC4, XOR
    """
    
    # All known encryption keys
    KNOWN_KEYS = {
        'api': '9f758e2deccbe6244f734371b9642eda',
        'token': 'IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}',
        'action': 'TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}',
        'evony_key1': 'PlayEvony',
        'evony_key2': 'Celebrate',
        'evony_key3': 'EarnPrestige',
        'evony_key4': 'VisitAndReward'
    }
    
    STATIC_KEYS = {
        'game': 'EvonyGameKey2009',
        'network': 'EvonyNetKey2009',
        'resource': 'EvonyResKey2009',
        'config': 'EvonyConfigKey2009',
        'data': 'EvonyDataKey2009'
    }
    
    XOR_KEY = 0xAA
    
    def __init__(self):
        self.decryption_methods = [
            self._try_plain_amf,
            self._try_xor,
            self._try_aes_ecb,
            self._try_aes_cbc,
            self._try_blowfish,
            self._try_rc4
        ]
    
    def decrypt(self, data: bytes) -> bytes:
        """
        Attempt decryption using all known methods.
        Returns decrypted data or original if already plain.
        """
        for method in self.decryption_methods:
            for key_name, key_value in {**self.KNOWN_KEYS, **self.STATIC_KEYS}.items():
                try:
                    result = method(data, key_value.encode())
                    if self._is_valid_amf(result):
                        return result
                except:
                    continue
        
        # Return original if nothing worked
        return data
    
    def _try_plain_amf(self, data: bytes, key: bytes) -> bytes:
        """Check if already plain AMF."""
        if self._is_valid_amf(data):
            return data
        raise ValueError("Not plain AMF")
    
    def _try_xor(self, data: bytes, key: bytes) -> bytes:
        """XOR decryption with known key."""
        return bytes([b ^ self.XOR_KEY for b in data])
    
    def _try_aes_ecb(self, data: bytes, key: bytes) -> bytes:
        """AES ECB decryption."""
        key = self._pad_key(key, 16)
        cipher = AES.new(key, AES.MODE_ECB)
        return unpad(cipher.decrypt(data), AES.block_size)
    
    def _try_aes_cbc(self, data: bytes, key: bytes) -> bytes:
        """AES CBC decryption (IV from first block)."""
        key = self._pad_key(key, 16)
        iv = data[:16]
        ciphertext = data[16:]
        cipher = AES.new(key, AES.MODE_CBC, iv)
        return unpad(cipher.decrypt(ciphertext), AES.block_size)
    
    def _try_blowfish(self, data: bytes, key: bytes) -> bytes:
        """Blowfish ECB decryption."""
        cipher = Blowfish.new(key[:56], Blowfish.MODE_ECB)
        return unpad(cipher.decrypt(data), Blowfish.block_size)
    
    def _try_rc4(self, data: bytes, key: bytes) -> bytes:
        """RC4 stream cipher decryption."""
        cipher = ARC4.new(key)
        return cipher.decrypt(data)
    
    def _pad_key(self, key: bytes, length: int) -> bytes:
        """Pad or truncate key to required length."""
        if len(key) >= length:
            return key[:length]
        return key + b'\x00' * (length - len(key))
    
    def _is_valid_amf(self, data: bytes) -> bool:
        """Check if data looks like valid AMF."""
        if not data or len(data) < 6:
            return False
        # AMF0 starts with 0x00, AMF3 starts with 0x00 or 0x11
        if data[0] not in [0x00, 0x11]:
            return False
        # Check for readable strings in the first 50 bytes
        try:
            sample = data[:50].decode('utf-8', errors='ignore')
            return any(c.isalpha() for c in sample)
        except:
            return False
```

### 3. AMF Decoder

Full AMF3 binary parsing:

```python
# src/core/amf_decoder.py

import struct
from typing import Any, Dict, List, Union
from io import BytesIO

class AMFDecoder:
    """
    AMF3 (Action Message Format) binary decoder.
    Parses Evony's serialized game objects.
    """
    
    # AMF3 type markers
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
    BYTE_ARRAY = 0x0C
    
    def __init__(self):
        self.string_refs = []
        self.object_refs = []
        self.trait_refs = []
    
    def decode(self, data: bytes) -> Dict[str, Any]:
        """Decode AMF data to Python dict."""
        self.string_refs = []
        self.object_refs = []
        self.trait_refs = []
        
        stream = BytesIO(data)
        
        # Read AMF envelope
        result = {
            'version': struct.unpack('>H', stream.read(2))[0],
            'headers': [],
            'messages': []
        }
        
        # Read headers
        header_count = struct.unpack('>H', stream.read(2))[0]
        for _ in range(header_count):
            header = self._read_header(stream)
            result['headers'].append(header)
        
        # Read messages
        message_count = struct.unpack('>H', stream.read(2))[0]
        for _ in range(message_count):
            message = self._read_message(stream)
            result['messages'].append(message)
            
            # Extract command name
            if message.get('target'):
                result['command'] = message['target']
        
        return result
    
    def _read_header(self, stream: BytesIO) -> Dict:
        """Read AMF header."""
        name_length = struct.unpack('>H', stream.read(2))[0]
        name = stream.read(name_length).decode('utf-8')
        must_understand = struct.unpack('B', stream.read(1))[0] != 0
        length = struct.unpack('>I', stream.read(4))[0]
        value = self._read_value(stream)
        return {'name': name, 'must_understand': must_understand, 'value': value}
    
    def _read_message(self, stream: BytesIO) -> Dict:
        """Read AMF message."""
        target_length = struct.unpack('>H', stream.read(2))[0]
        target = stream.read(target_length).decode('utf-8')
        
        response_length = struct.unpack('>H', stream.read(2))[0]
        response = stream.read(response_length).decode('utf-8')
        
        length = struct.unpack('>I', stream.read(4))[0]
        value = self._read_value(stream)
        
        return {'target': target, 'response': response, 'value': value}
    
    def _read_value(self, stream: BytesIO) -> Any:
        """Read typed AMF value."""
        marker = struct.unpack('B', stream.read(1))[0]
        
        if marker == self.UNDEFINED:
            return None
        elif marker == self.NULL:
            return None
        elif marker == self.FALSE:
            return False
        elif marker == self.TRUE:
            return True
        elif marker == self.INTEGER:
            return self._read_u29(stream)
        elif marker == self.DOUBLE:
            return struct.unpack('>d', stream.read(8))[0]
        elif marker == self.STRING:
            return self._read_string(stream)
        elif marker == self.ARRAY:
            return self._read_array(stream)
        elif marker == self.OBJECT:
            return self._read_object(stream)
        elif marker == self.BYTE_ARRAY:
            return self._read_byte_array(stream)
        else:
            return f"<unknown type: {marker}>"
    
    def _read_u29(self, stream: BytesIO) -> int:
        """Read variable-length integer."""
        result = 0
        for i in range(4):
            b = struct.unpack('B', stream.read(1))[0]
            if i < 3:
                result = (result << 7) | (b & 0x7F)
                if not (b & 0x80):
                    break
            else:
                result = (result << 8) | b
        return result
    
    def _read_string(self, stream: BytesIO) -> str:
        """Read AMF string with reference support."""
        ref = self._read_u29(stream)
        if ref & 1:
            length = ref >> 1
            if length == 0:
                return ""
            s = stream.read(length).decode('utf-8')
            self.string_refs.append(s)
            return s
        else:
            return self.string_refs[ref >> 1]
    
    def _read_array(self, stream: BytesIO) -> List:
        """Read AMF array."""
        ref = self._read_u29(stream)
        if ref & 1:
            length = ref >> 1
            # Skip associative portion
            while True:
                key = self._read_string(stream)
                if not key:
                    break
                self._read_value(stream)
            # Read dense portion
            result = []
            for _ in range(length):
                result.append(self._read_value(stream))
            self.object_refs.append(result)
            return result
        else:
            return self.object_refs[ref >> 1]
    
    def _read_object(self, stream: BytesIO) -> Dict:
        """Read AMF object."""
        ref = self._read_u29(stream)
        if ref & 1:
            traits_ref = ref >> 1
            if traits_ref & 1:
                # Inline traits
                class_name = self._read_string(stream)
                trait_count = traits_ref >> 1
                traits = [self._read_string(stream) for _ in range(trait_count)]
                self.trait_refs.append({'class': class_name, 'traits': traits})
            else:
                traits_info = self.trait_refs[traits_ref >> 1]
                traits = traits_info['traits']
            
            obj = {}
            for trait in traits:
                obj[trait] = self._read_value(stream)
            self.object_refs.append(obj)
            return obj
        else:
            return self.object_refs[ref >> 1]
    
    def _read_byte_array(self, stream: BytesIO) -> bytes:
        """Read AMF byte array."""
        ref = self._read_u29(stream)
        if ref & 1:
            length = ref >> 1
            data = stream.read(length)
            self.object_refs.append(data)
            return data
        else:
            return self.object_refs[ref >> 1]
```

---

## 🖥️ UI IMPLEMENTATION

### Testing Suite Panel (Main Tab)

```python
# src/ui/panels/testing_suite_panel.py

import tkinter as tk
from tkinter import ttk, filedialog, messagebox
import threading
from datetime import datetime
from typing import Optional
import json

class TestingSuitePanel(ttk.Frame):
    """
    Main Testing Suite tab for Svony Studio.
    Provides dual-SWF viewing and packet interception.
    """
    
    def __init__(self, parent, **kwargs):
        super().__init__(parent, **kwargs)
        
        # Initialize components
        self.proxy = None
        self.recording = False
        self.packets = []
        
        self._create_ui()
        self._bind_events()
    
    def _create_ui(self):
        """Create the testing suite UI."""
        # Main paned window
        self.paned = ttk.PanedWindow(self, orient=tk.VERTICAL)
        self.paned.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Top section: Dual SWF viewers
        self.swf_frame = ttk.Frame(self.paned)
        self.paned.add(self.swf_frame, weight=2)
        
        # Left SWF viewer (Evony Client)
        self.client_frame = ttk.LabelFrame(self.swf_frame, text="Evony Client")
        self.client_frame.pack(side=tk.LEFT, fill=tk.BOTH, expand=True, padx=2)
        
        self.client_viewer = SWFViewerPanel(self.client_frame)
        self.client_viewer.pack(fill=tk.BOTH, expand=True)
        
        # Right SWF viewer (AutoEvony Bot)
        self.bot_frame = ttk.LabelFrame(self.swf_frame, text="AutoEvony Bot")
        self.bot_frame.pack(side=tk.RIGHT, fill=tk.BOTH, expand=True, padx=2)
        
        self.bot_viewer = SWFViewerPanel(self.bot_frame)
        self.bot_viewer.pack(fill=tk.BOTH, expand=True)
        
        # Middle section: Packet log
        self.packet_frame = ttk.LabelFrame(self.paned, text="Packet Interceptor")
        self.paned.add(self.packet_frame, weight=1)
        
        self.packet_log = PacketLogPanel(self.packet_frame)
        self.packet_log.pack(fill=tk.BOTH, expand=True)
        
        # Bottom section: Packet detail
        self.detail_frame = ttk.LabelFrame(self.paned, text="Packet Detail")
        self.paned.add(self.detail_frame, weight=1)
        
        self.packet_detail = PacketDetailPanel(self.detail_frame)
        self.packet_detail.pack(fill=tk.BOTH, expand=True)
        
        # Control bar
        self.control_bar = ttk.Frame(self)
        self.control_bar.pack(fill=tk.X, pady=5)
        
        self.start_btn = ttk.Button(
            self.control_bar, 
            text="▶ Start Proxy",
            command=self._start_proxy
        )
        self.start_btn.pack(side=tk.LEFT, padx=2)
        
        self.stop_btn = ttk.Button(
            self.control_bar,
            text="⏹ Stop",
            command=self._stop_proxy,
            state=tk.DISABLED
        )
        self.stop_btn.pack(side=tk.LEFT, padx=2)
        
        self.record_btn = ttk.Button(
            self.control_bar,
            text="🔴 Record",
            command=self._toggle_recording
        )
        self.record_btn.pack(side=tk.LEFT, padx=2)
        
        self.export_btn = ttk.Button(
            self.control_bar,
            text="💾 Export",
            command=self._export_packets
        )
        self.export_btn.pack(side=tk.LEFT, padx=2)
        
        self.clear_btn = ttk.Button(
            self.control_bar,
            text="🔄 Clear",
            command=self._clear_packets
        )
        self.clear_btn.pack(side=tk.LEFT, padx=2)
        
        # Status bar
        self.status_var = tk.StringVar(value="Ready")
        self.status_bar = ttk.Label(
            self.control_bar,
            textvariable=self.status_var,
            relief=tk.SUNKEN
        )
        self.status_bar.pack(side=tk.RIGHT, fill=tk.X, expand=True, padx=5)
    
    def _bind_events(self):
        """Bind UI events."""
        self.packet_log.bind('<<PacketSelected>>', self._on_packet_selected)
    
    def _start_proxy(self):
        """Start the packet interceptor proxy."""
        from src.core.amf_interceptor import AMFInterceptorProxy
        
        self.proxy = AMFInterceptorProxy(
            local_port=8888,
            on_packet=self._on_packet_received
        )
        self.proxy.start()
        
        self.start_btn.config(state=tk.DISABLED)
        self.stop_btn.config(state=tk.NORMAL)
        self.status_var.set("Proxy running on 127.0.0.1:8888")
    
    def _stop_proxy(self):
        """Stop the packet interceptor proxy."""
        if self.proxy:
            self.proxy.stop()
            self.proxy = None
        
        self.start_btn.config(state=tk.NORMAL)
        self.stop_btn.config(state=tk.DISABLED)
        self.status_var.set("Proxy stopped")
    
    def _on_packet_received(self, packet):
        """Handle received packet from proxy."""
        self.packets.append(packet)
        self.packet_log.add_packet(packet)
        
        # Update status
        decrypted = sum(1 for p in self.packets if p.decrypted_data)
        errors = sum(1 for p in self.packets if p.error)
        status = f"Packets: {len(self.packets)} | Decrypted: {decrypted} | Errors: {errors}"
        if self.recording:
            status = "🔴 Recording | " + status
        self.status_var.set(status)
    
    def _on_packet_selected(self, event):
        """Handle packet selection in log."""
        selected = self.packet_log.get_selected_packet()
        if selected:
            self.packet_detail.show_packet(selected)
    
    def _toggle_recording(self):
        """Toggle session recording."""
        self.recording = not self.recording
        if self.recording:
            self.record_btn.config(text="⏹ Stop Recording")
        else:
            self.record_btn.config(text="🔴 Record")
    
    def _export_packets(self):
        """Export captured packets."""
        if not self.packets:
            messagebox.showwarning("Export", "No packets to export")
            return
        
        filename = filedialog.asksaveasfilename(
            defaultextension=".json",
            filetypes=[("JSON files", "*.json"), ("All files", "*.*")]
        )
        if filename:
            export_data = []
            for p in self.packets:
                export_data.append({
                    'timestamp': p.timestamp.isoformat(),
                    'direction': p.direction,
                    'command': p.command_name,
                    'raw_hex': p.raw_data.hex(),
                    'decrypted': p.decrypted_data.hex() if p.decrypted_data else None,
                    'parsed': p.parsed_amf,
                    'error': p.error
                })
            
            with open(filename, 'w') as f:
                json.dump(export_data, f, indent=2)
            
            messagebox.showinfo("Export", f"Exported {len(export_data)} packets to {filename}")
    
    def _clear_packets(self):
        """Clear all captured packets."""
        self.packets.clear()
        self.packet_log.clear()
        self.packet_detail.clear()
        self.status_var.set("Packets cleared")
```

---

## 🚀 USAGE INSTRUCTIONS

### Step 1: Configure SWF to Use Proxy

Edit the SWF configuration or use a local hosts redirect:
```
# hosts file (C:\Windows\System32\drivers\etc\hosts)
127.0.0.1 game.evony.com
```

Or configure proxy in SWF loader.

### Step 2: Start Svony Studio

1. Launch Svony Studio
2. Navigate to **Testing Suite** tab
3. Click **Load** in each panel to load SWFs

### Step 3: Start Intercepting

1. Click **▶ Start Proxy**
2. Interact with the game in either SWF panel
3. Watch packets appear in the log
4. Click any packet to see decrypted details

### Step 4: Record Sessions

1. Click **🔴 Record** to start recording
2. Perform actions you want to capture
3. Click **⏹ Stop Recording**
4. Export to JSON for AI training

---

## 📊 WHAT YOU CAN ANALYZE

| Packet Type | Information Available |
|-------------|----------------------|
| `castle.getInfo` | City resources, buildings, troops |
| `army.getArmyList` | All army compositions, positions |
| `hero.getHeroList` | Hero stats, equipment, loyalty |
| `report.getReport` | Battle results, loot |
| `mail.getMail` | Incoming/outgoing messages |
| `alliance.getInfo` | Alliance members, stats |
| `map.scout` | Scouting results |
| `troop.train` | Training commands |
| `building.build` | Construction commands |

---

This architecture enables **complete visibility** into all game communication for developing advanced automation features.
