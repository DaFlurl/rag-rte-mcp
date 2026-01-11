# 🧪 SVONY STUDIO - TESTING SUITE INTEGRATION
## Dual-Panel SWF Testing with Network Analysis

---

> **Purpose**: Create a 1:1 testing environment for EvonyClient.swf and AutoEvony.swf
> **Location**: D:\svony_studio
> **Status**: SPECIFICATION COMPLETE

---

## 🎯 ARCHITECTURE OVERVIEW

### Option A: Side-by-Side SWF Embedding (RECOMMENDED)

Since both SWFs are Flash/AS3 and can communicate via:
1. **LocalConnection** - Direct Flash-to-Flash messaging
2. **ExternalInterface** - JavaScript bridge between both
3. **Shared AMF Socket** - Same server connection

```
┌─────────────────────────────────────────────────────────────────┐
│  SVONY TESTING SUITE                                            │
├─────────────────────────────────────────────────────────────────┤
│  ┌──────────────────────┐  ┌──────────────────────┐             │
│  │   EvonyClient.swf    │  │   AutoEvony.swf      │             │
│  │   (Ruffle Emulator)  │  │   (Ruffle Emulator)  │             │
│  │                      │  │                      │             │
│  │   - Game UI Preview  │  │   - Bot Interface    │             │
│  │   - Map Rendering    │  │   - Script Runner    │             │
│  │   - Asset Preview    │  │   - Command Panel    │             │
│  │                      │  │                      │             │
│  └──────────────────────┘  └──────────────────────┘             │
│              │                        │                         │
│              └──────────┬─────────────┘                         │
│                         │                                       │
│  ┌──────────────────────▼─────────────────────────────────┐    │
│  │           PACKET INTERCEPTOR / PROXY                    │    │
│  │  ┌─────────────────────────────────────────────────┐   │    │
│  │  │ Captures ALL AMF traffic between client & server │   │    │
│  │  │ Decrypts using extracted keys                    │   │    │
│  │  │ Logs to real-time display                        │   │    │
│  │  │ Allows packet injection/modification             │   │    │
│  │  └─────────────────────────────────────────────────┘   │    │
│  └────────────────────────────────────────────────────────┘    │
│                         │                                       │
│  ┌──────────────────────▼─────────────────────────────────┐    │
│  │           ANALYSIS PANEL                                │    │
│  │  [Packet Log] [Decrypt View] [Compare] [Export]        │    │
│  └────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
```

### Option B: Network Hook + Traffic Analysis (ALTERNATE)

When SWFs can't communicate directly, use network interception:

```
┌────────────────────────────────────────────────────────────────┐
│  NETWORK ANALYSIS MODE                                         │
├────────────────────────────────────────────────────────────────┤
│                                                                │
│  [Real Evony Server] ←──┐                                      │
│        │                │                                      │
│        │                │ SSL/TLS                               │
│        ▼                │                                      │
│  ┌─────────────┐       │                                      │
│  │   MITMPROXY │ ──────┘                                      │
│  │   (Python)  │                                              │
│  └──────┬──────┘                                              │
│         │                                                      │
│         │ Decrypted AMF                                        │
│         ▼                                                      │
│  ┌──────────────────────────────────────────────────────────┐ │
│  │  SVONY ANALYZER                                          │ │
│  │                                                          │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌────────────────┐ │ │
│  │  │ Request Log  │  │ Response Log │  │ Decrypted View │ │ │
│  │  │              │  │              │  │                │ │ │
│  │  │ cmd: login   │  │ ok: 1        │  │ {              │ │ │
│  │  │ user: xxx    │  │ session: xxx │  │   player: {...}│ │ │
│  │  │              │  │              │  │   cities: [...] │ │ │
│  │  └──────────────┘  └──────────────┘  └────────────────┘ │ │
│  └──────────────────────────────────────────────────────────┘ │
└────────────────────────────────────────────────────────────────┘
```

---

## 🔧 IMPLEMENTATION PLAN

### Step 1: Ruffle Integration (Flash Emulator)

Since Flash Player is dead, use Ruffle (Rust-based Flash emulator):

```python
# src/ui/panels/swf_viewer_panel.py

import tkinter as tk
from tkinter import ttk
import subprocess
import webview  # pywebview for embedding

class SWFViewerPanel(ttk.Frame):
    """Embeds Ruffle to display SWF files"""
    
    def __init__(self, parent):
        super().__init__(parent)
        self.setup_ui()
    
    def setup_ui(self):
        # Create two frames for dual SWF display
        self.left_frame = ttk.LabelFrame(self, text="EvonyClient.swf")
        self.right_frame = ttk.LabelFrame(self, text="AutoEvony.swf")
        
        self.left_frame.pack(side='left', fill='both', expand=True, padx=5)
        self.right_frame.pack(side='right', fill='both', expand=True, padx=5)
        
        # Embed Ruffle via webview
        self.left_webview = None
        self.right_webview = None
    
    def load_swf(self, swf_path, panel='left'):
        """Load SWF into specified panel using Ruffle"""
        html = f"""
        <!DOCTYPE html>
        <html>
        <head>
            <script src="https://unpkg.com/@aspect-ratio/core"></script>
            <script src="https://unpkg.com/@aspect-ratio/core"></script>
            <script src="ruffle/ruffle.js"></script>
        </head>
        <body style="margin:0; padding:0; background:#1e1e1e;">
            <object type="application/x-shockwave-flash" 
                    data="{swf_path}" 
                    width="100%" height="100%">
                <param name="movie" value="{swf_path}">
            </object>
        </body>
        </html>
        """
        # Create webview with Ruffle-enabled HTML
        if panel == 'left':
            self.left_webview = webview.create_window('Client', html=html)
        else:
            self.right_webview = webview.create_window('Bot', html=html)
```

### Step 2: AMF Packet Interceptor

```python
# src/core/amf_interceptor.py

import socket
import threading
import pyamf
from pyamf import remoting
from Crypto.Cipher import AES, Blowfish
import struct

class AMFInterceptor:
    """Intercepts and decrypts AMF traffic between client and server"""
    
    # Your extracted keys
    KEYS = {
        'game': b'EvonyGameKey2009',
        'network': b'EvonyNetKey2009',
        'xor': 0xAA,
        'api': '9f758e2deccbe6244f734371b9642eda'
    }
    
    def __init__(self, local_port=8888, remote_host='evony.server.com', remote_port=443):
        self.local_port = local_port
        self.remote_host = remote_host
        self.remote_port = remote_port
        self.callbacks = []
    
    def start(self):
        """Start proxy server"""
        self.server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.server.bind(('localhost', self.local_port))
        self.server.listen(5)
        
        print(f"[*] AMF Interceptor listening on port {self.local_port}")
        
        while True:
            client_socket, addr = self.server.accept()
            proxy_thread = threading.Thread(
                target=self.handle_client,
                args=(client_socket,)
            )
            proxy_thread.start()
    
    def handle_client(self, client_socket):
        """Handle client connection"""
        # Connect to real server
        server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        server_socket.connect((self.remote_host, self.remote_port))
        
        # Bidirectional forwarding with interception
        threading.Thread(target=self.forward, 
                        args=(client_socket, server_socket, 'request')).start()
        threading.Thread(target=self.forward, 
                        args=(server_socket, client_socket, 'response')).start()
    
    def forward(self, source, destination, direction):
        """Forward data with interception and decryption"""
        while True:
            data = source.recv(4096)
            if not data:
                break
            
            # Decrypt and log
            decrypted = self.decrypt_amf(data)
            self.log_packet(direction, decrypted)
            
            # Forward original
            destination.send(data)
    
    def decrypt_amf(self, data):
        """Decrypt AMF packet using extracted keys"""
        # Check for encryption markers
        if data[:4] == b'\x45\x56\x4F\x01':  # EVO1 - AES
            return self.decrypt_aes(data[4:])
        elif data[:4] == b'\x45\x56\x4F\x02':  # EVO2 - Blowfish
            return self.decrypt_blowfish(data[4:])
        elif data[:4] == b'\x45\x56\x4F\x03':  # EVO3 - XOR
            return self.decrypt_xor(data[4:])
        else:
            # Try to decode as plain AMF
            try:
                return self.decode_amf(data)
            except:
                return data
    
    def decrypt_xor(self, data):
        """XOR decryption with key 0xAA"""
        return bytes([b ^ self.KEYS['xor'] for b in data])
    
    def decrypt_aes(self, data):
        """AES-ECB decryption"""
        cipher = AES.new(self.KEYS['game'], AES.MODE_ECB)
        return cipher.decrypt(data)
    
    def decode_amf(self, data):
        """Decode AMF data to Python objects"""
        try:
            request = remoting.decode(data)
            return str(request)
        except:
            return data.hex()
    
    def log_packet(self, direction, data):
        """Log packet to UI callbacks"""
        packet_info = {
            'direction': direction,
            'data': data,
            'timestamp': time.time()
        }
        for callback in self.callbacks:
            callback(packet_info)
    
    def add_callback(self, callback):
        """Add callback for packet notifications"""
        self.callbacks.append(callback)
```

### Step 3: Packet Log Panel

```python
# src/ui/panels/packet_log_panel.py

import tkinter as tk
from tkinter import ttk
import json

class PacketLogPanel(ttk.Frame):
    """Real-time packet logging with decryption view"""
    
    def __init__(self, parent, interceptor):
        super().__init__(parent)
        self.interceptor = interceptor
        self.setup_ui()
        
        # Register for packet notifications
        interceptor.add_callback(self.on_packet)
    
    def setup_ui(self):
        # Toolbar
        toolbar = ttk.Frame(self)
        toolbar.pack(fill='x', padx=5, pady=5)
        
        ttk.Button(toolbar, text="Clear", command=self.clear).pack(side='left')
        ttk.Button(toolbar, text="Export", command=self.export).pack(side='left')
        ttk.Button(toolbar, text="Filter...", command=self.filter).pack(side='left')
        
        self.auto_scroll = tk.BooleanVar(value=True)
        ttk.Checkbutton(toolbar, text="Auto-scroll", 
                       variable=self.auto_scroll).pack(side='left')
        
        # Split view
        paned = ttk.PanedWindow(self, orient='horizontal')
        paned.pack(fill='both', expand=True)
        
        # Packet list
        list_frame = ttk.Frame(paned)
        self.packet_tree = ttk.Treeview(list_frame, columns=(
            'time', 'direction', 'command', 'size'
        ))
        self.packet_tree.heading('#0', text='#')
        self.packet_tree.heading('time', text='Time')
        self.packet_tree.heading('direction', text='Dir')
        self.packet_tree.heading('command', text='Command')
        self.packet_tree.heading('size', text='Size')
        
        self.packet_tree.column('#0', width=50)
        self.packet_tree.column('time', width=100)
        self.packet_tree.column('direction', width=50)
        self.packet_tree.column('command', width=200)
        self.packet_tree.column('size', width=80)
        
        self.packet_tree.pack(fill='both', expand=True)
        self.packet_tree.bind('<<TreeviewSelect>>', self.on_select)
        paned.add(list_frame)
        
        # Detail view
        detail_frame = ttk.Frame(paned)
        
        # Raw hex
        ttk.Label(detail_frame, text="Raw Data:").pack(anchor='w')
        self.raw_text = tk.Text(detail_frame, height=8, font=('Consolas', 10))
        self.raw_text.pack(fill='x', padx=5)
        
        # Decrypted
        ttk.Label(detail_frame, text="Decrypted:").pack(anchor='w')
        self.decrypted_text = tk.Text(detail_frame, height=8, font=('Consolas', 10))
        self.decrypted_text.pack(fill='x', padx=5)
        
        # Parsed
        ttk.Label(detail_frame, text="Parsed AMF:").pack(anchor='w')
        self.parsed_text = tk.Text(detail_frame, height=10, font=('Consolas', 10))
        self.parsed_text.pack(fill='both', expand=True, padx=5)
        
        paned.add(detail_frame)
    
    def on_packet(self, packet_info):
        """Handle incoming packet"""
        self.packet_tree.insert('', 'end', values=(
            packet_info['timestamp'],
            packet_info['direction'],
            self.extract_command(packet_info['data']),
            len(packet_info.get('raw', b''))
        ))
        
        if self.auto_scroll.get():
            self.packet_tree.yview_moveto(1)
    
    def extract_command(self, data):
        """Extract command name from AMF data"""
        if isinstance(data, dict) and 'cmd' in data:
            return data['cmd']
        elif isinstance(data, str) and 'cmd' in data:
            return data.split('cmd')[1][:50]
        return '(unknown)'
    
    def on_select(self, event):
        """Show selected packet details"""
        selection = self.packet_tree.selection()
        if not selection:
            return
        
        item = self.packet_tree.item(selection[0])
        # Update detail views...
```

---

## 🔌 COMPLETE TOOL LIST FOR TESTING SUITE

### Network Analysis Tools (Built-in):

| Tool | Description | Implementation |
|------|-------------|----------------|
| **AMF Decoder** | Decode AMF0/AMF3 packets | pyamf library |
| **Packet Logger** | Real-time packet capture | Socket proxy |
| **Decryption Engine** | All encryption methods | Extracted keys |
| **Traffic Replayer** | Replay captured packets | Socket injection |
| **Response Simulator** | Fake server responses | AMF encoder |

### SWF Analysis Tools (Built-in):

| Tool | Description | Implementation |
|------|-------------|----------------|
| **Ruffle Embedder** | Display SWF in panel | pywebview + Ruffle |
| **ABC Inspector** | View bytecode | FFDEC integration |
| **Asset Browser** | View extracted assets | Image/sound viewers |
| **Symbol Table** | Browse class symbols | symbols.csv parser |

### Command Tools (From Commands.as):

| Command | Source Line | Description |
|---------|-------------|-------------|
| qFarm | Commands.as:1200 | NPC farming automation |
| qBuild | Commands.as:800 | Auto-building |
| qTrain | Commands.as:950 | Troop training |
| qMarch | Commands.as:1050 | Army movement |
| qResearch | Commands.as:700 | Tech research |
| qColony | Commands.as:1400 | Colony management |

---

## 📁 FILES TO CREATE

```
D:\svony_studio\
├── src\
│   ├── ui\
│   │   └── panels\
│   │       ├── testing_suite_panel.py      ← NEW
│   │       ├── swf_viewer_panel.py         ← NEW  
│   │       ├── packet_log_panel.py         ← NEW
│   │       └── command_sender_panel.py     ← NEW
│   └── core\
│       ├── amf_interceptor.py              ← NEW
│       ├── amf_decoder.py                  ← NEW
│       ├── decryption_engine.py            ← NEW
│       └── packet_replayer.py              ← NEW
├── resources\
│   ├── ruffle\                             ← Ruffle files
│   └── swf\                                ← Test SWF files
└── docs\
    └── TESTING_SUITE_INTEGRATION.md        ← THIS FILE
```

---

## 🎮 USAGE WORKFLOW

### 1. Launch Testing Suite
```
1. Open Svony Studio
2. Navigate to "Testing Suite" tab
3. Load EvonyClient.swf in left panel
4. Load AutoEvony.swf in right panel
```

### 2. Configure Proxy
```
1. Set local port (default 8888)
2. Set target server (evony server)
3. Click "Start Intercept"
```

### 3. Analyze Traffic
```
1. Interact with either SWF
2. Watch packets in real-time log
3. Click packet to see decrypted content
4. Export for further analysis
```

### 4. Test Commands
```
1. Use Command Sender panel
2. Select command from dropdown (from Commands.as)
3. Fill parameters
4. Send and observe response
```

---

*Testing Suite Specification Complete*
*Ready for Implementation*
