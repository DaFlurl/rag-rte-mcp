# Evony Age II - Bot Integration Guide

> **"Bot Framework Integration"** - Connecting Svony Studio with RoboEvony & AutoEvony

---

## Overview

This guide covers integrating Svony Studio with existing Evony bot frameworks (RoboEvony, AutoEvony, pyEvony) for automated gameplay development.

---

## Required Dependencies

### Python Dependencies

Add to `requirements.txt`:

```ini
# Bot Framework Dependencies
Py3AMF>=0.8.0                    # AMF3 encoding/decoding
pysocks>=1.7.1                   # SOCKS proxy support (Tor)
cryptography>=41.0.0             # SSL/TLS handling
aiohttp>=3.8.0                   # Async HTTP client

# Optional: Install pyEvony from GitHub
# pip install git+https://github.com/sonya75/pyEvony.git

# Protocol Analysis
mitmproxy>=10.0.0                # Traffic capture
scapy>=2.5.0                     # Packet analysis
```

### External Tools

```bash
# Tor for anonymous multi-account
sudo apt install tor

# Or on Windows (via Chocolatey)
choco install tor

# RABCDAsm for bytecode manipulation
git clone https://github.com/RABCDasm/RABCDasm
cd RABCDasm && make
```

---

## pyEvony Integration

### Installation

```bash
# Clone pyEvony repository
git clone https://github.com/sonya75/pyEvony.git

# Install dependencies
cd pyEvony
pip install -r requirements.txt

# Or install as package
pip install git+https://github.com/sonya75/pyEvony.git
```

### Basic Usage

```python
from pyEvony import EvonyClient
from pyEvony.commands import Commands
from pyEvony.session import Session

class SvonyBotClient:
    """
    Svony Studio bot client using pyEvony.
    """
    
    def __init__(self, server: str, username: str, password: str):
        self.server = server
        self.username = username
        self.password = password
        self.session = None
        self.commands = None
    
    def connect(self):
        """
        Establish connection to Evony server.
        """
        self.session = Session(self.server)
        self.session.connect()
        
        # Login
        response = self.session.login(self.username, self.password)
        
        if response.get("ok"):
            self.commands = Commands(self.session)
            return True
        return False
    
    def get_city_info(self, city_id: int):
        """
        Get city information.
        """
        return self.commands.city_info(city_id)
    
    def train_troops(self, city_id: int, troop_type: int, count: int):
        """
        Train troops in a city.
        """
        return self.commands.train(city_id, troop_type, count)
    
    def attack_npc(self, city_id: int, target_x: int, target_y: int,
                   hero_id: int, troops: dict):
        """
        Send attack to NPC.
        """
        return self.commands.march(
            city_id=city_id,
            target_x=target_x,
            target_y=target_y,
            hero_id=hero_id,
            troops=troops,
            mission_type=1  # Attack
        )
    
    def disconnect(self):
        """
        Close connection.
        """
        if self.session:
            self.session.logout()
            self.session.disconnect()
```

---

## RoboEvony Integration

### Directory Structure

```
D:\evony_bots\
├── roboevony/
│   ├── roboevony.exe
│   ├── scripts/
│   │   ├── farm_npc.txt
│   │   ├── build_queue.txt
│   │   └── hero_train.txt
│   └── config/
│       └── accounts.xml
├── autoevony/
│   ├── autoevony.swf
│   └── goals/
└── svony_studio/
    └── (project files)
```

### Account Configuration

```xml
<!-- accounts.xml -->
<accounts>
    <account id="1">
        <username>player1</username>
        <password>md5_hash_here</password>
        <server>svr12.evony.com</server>
        <enabled>true</enabled>
        <script>farm_npc.txt</script>
    </account>
    <account id="2">
        <username>player2</username>
        <password>md5_hash_here</password>
        <server>svr12.evony.com</server>
        <enabled>true</enabled>
        <script>build_queue.txt</script>
    </account>
</accounts>
```

### Launching RoboEvony from Svony Studio

```python
import subprocess
import os
from pathlib import Path

class RoboEvonyLauncher:
    """
    Launch and manage RoboEvony instances.
    """
    
    def __init__(self, roboevony_path: str):
        self.roboevony_path = Path(roboevony_path)
        self.processes = {}
    
    def launch(self, account_id: int, script: str = None):
        """
        Launch RoboEvony for an account.
        """
        exe_path = self.roboevony_path / "roboevony.exe"
        
        args = [str(exe_path), f"-account={account_id}"]
        if script:
            args.append(f"-script={script}")
        
        process = subprocess.Popen(
            args,
            cwd=str(self.roboevony_path),
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        
        self.processes[account_id] = process
        return process.pid
    
    def stop(self, account_id: int):
        """
        Stop a running instance.
        """
        if account_id in self.processes:
            self.processes[account_id].terminate()
            del self.processes[account_id]
    
    def stop_all(self):
        """
        Stop all instances.
        """
        for pid in list(self.processes.keys()):
            self.stop(pid)
```

---

## AutoEvony Integration

### Loading AutoEvony SWF

```python
from svony.core.swf_tools import SWFTools
from svony.core.sol_manager import SOLManager

class AutoEvonyLoader:
    """
    Load and analyze AutoEvony SWF.
    """
    
    def __init__(self, swf_path: str):
        self.swf_path = swf_path
        self.swf_tools = SWFTools()
        self.sol_manager = SOLManager()
    
    def analyze(self):
        """
        Analyze AutoEvony structure.
        """
        return {
            "classes": self.swf_tools.list_classes(self.swf_path),
            "commands": self._find_command_handlers(),
            "goals": self._find_goal_definitions()
        }
    
    def _find_command_handlers(self):
        """
        Find command handler classes.
        """
        classes = self.swf_tools.list_classes(self.swf_path)
        return [c for c in classes if "Command" in c or "Handler" in c]
    
    def _find_goal_definitions(self):
        """
        Find goal/task definitions.
        """
        scripts = self.swf_tools.export_scripts(self.swf_path)
        goals = []
        for script in scripts:
            if "goal" in script.lower() or "task" in script.lower():
                goals.append(script)
        return goals
    
    def extract_credentials(self):
        """
        Extract saved credentials from SOL files.
        """
        return self.sol_manager.find_evony_sols()
```

---

## Tor/Anonymous Operation

### Tor Configuration

```python
import socks
import socket
from stem import Signal
from stem.control import Controller

class TorManager:
    """
    Manage Tor connections for anonymous bot operation.
    """
    
    def __init__(self, tor_port: int = 9050, control_port: int = 9051):
        self.tor_port = tor_port
        self.control_port = control_port
        self.original_socket = socket.socket
    
    def enable_tor(self):
        """
        Route all connections through Tor.
        """
        socks.set_default_proxy(socks.SOCKS5, "127.0.0.1", self.tor_port)
        socket.socket = socks.socksocket
    
    def disable_tor(self):
        """
        Restore normal networking.
        """
        socket.socket = self.original_socket
    
    def new_identity(self, password: str = None):
        """
        Request new Tor identity (new IP).
        """
        with Controller.from_port(port=self.control_port) as controller:
            if password:
                controller.authenticate(password=password)
            else:
                controller.authenticate()
            controller.signal(Signal.NEWNYM)
    
    def get_current_ip(self):
        """
        Check current exit IP.
        """
        import requests
        return requests.get("https://api.ipify.org").text
```

### Multi-Account with Tor

```python
class MultiAccountManager:
    """
    Manage multiple bot accounts with IP rotation.
    """
    
    def __init__(self, accounts: list, tor_manager: TorManager):
        self.accounts = accounts
        self.tor = tor_manager
        self.clients = {}
    
    def connect_account(self, account: dict):
        """
        Connect single account with fresh IP.
        """
        # Get new Tor identity
        self.tor.new_identity()
        time.sleep(5)  # Wait for new circuit
        
        # Connect
        client = SvonyBotClient(
            server=account["server"],
            username=account["username"],
            password=account["password"]
        )
        
        if client.connect():
            self.clients[account["username"]] = client
            return True
        return False
    
    def connect_all(self, delay: int = 30):
        """
        Connect all accounts with IP rotation.
        """
        for account in self.accounts:
            self.connect_account(account)
            time.sleep(delay)  # Delay between accounts
```

---

## Credential Management

### SOL Credential Extraction

```python
from svony.core.sol_manager import SOLManager

class CredentialManager:
    """
    Manage Evony credentials from SOL files.
    """
    
    def __init__(self):
        self.sol_manager = SOLManager()
    
    def find_all_accounts(self):
        """
        Find all saved Evony accounts on system.
        """
        sols = self.sol_manager.find_evony_sols()
        accounts = []
        
        for sol in sols:
            data = self.sol_manager.read_sol(sol["path"])
            if "username" in data.get("data", {}):
                accounts.append({
                    "path": sol["path"],
                    "username": data["data"]["username"],
                    "password": data["data"].get("password"),
                    "server": data["data"].get("server"),
                    "auto_login": data["data"].get("autoLogin", False)
                })
        
        return accounts
    
    def export_accounts(self, output_path: str):
        """
        Export accounts to JSON (passwords hashed).
        """
        accounts = self.find_all_accounts()
        
        # Mask passwords for security
        for acc in accounts:
            if acc.get("password"):
                acc["password"] = "***HIDDEN***"
        
        with open(output_path, "w") as f:
            json.dump(accounts, f, indent=2)
    
    def import_accounts(self, input_path: str):
        """
        Import accounts from JSON.
        """
        with open(input_path, "r") as f:
            return json.load(f)
```

---

## Protocol Capture Integration

### Traffic Capture Setup

```python
from mitmproxy import options
from mitmproxy import proxy
from mitmproxy.tools import dump

class ProtocolCapturer:
    """
    Capture Evony protocol traffic for analysis.
    """
    
    def __init__(self, listen_port: int = 8080):
        self.listen_port = listen_port
        self.captures = []
    
    def start(self):
        """
        Start capture proxy.
        """
        opts = options.Options(listen_port=self.listen_port)
        pconf = proxy.ProxyConfig(opts)
        
        # Configure as transparent proxy
        # Requires client to use proxy settings
        pass
    
    def analyze_captures(self):
        """
        Analyze captured AMF traffic.
        """
        from pyamf import remoting
        
        results = []
        for capture in self.captures:
            try:
                decoded = remoting.decode(capture["data"])
                results.append({
                    "timestamp": capture["timestamp"],
                    "direction": capture["direction"],
                    "decoded": decoded
                })
            except Exception as e:
                results.append({
                    "timestamp": capture["timestamp"],
                    "error": str(e)
                })
        
        return results
```

---

## Svony Studio UI Integration

### Bot Control Panel

```python
import customtkinter as ctk
from typing import Dict

class BotControlPanel(ctk.CTkFrame):
    """
    Bot control panel for Svony Studio UI.
    """
    
    def __init__(self, parent, launcher: RoboEvonyLauncher):
        super().__init__(parent)
        self.launcher = launcher
        self.account_frames: Dict[int, ctk.CTkFrame] = {}
        
        self._create_widgets()
    
    def _create_widgets(self):
        """
        Create control widgets.
        """
        # Header
        header = ctk.CTkLabel(self, text="Bot Control", font=("Arial", 16, "bold"))
        header.pack(pady=10)
        
        # Account list
        self.account_list = ctk.CTkScrollableFrame(self)
        self.account_list.pack(fill="both", expand=True, padx=10, pady=5)
        
        # Control buttons
        btn_frame = ctk.CTkFrame(self)
        btn_frame.pack(fill="x", padx=10, pady=10)
        
        ctk.CTkButton(btn_frame, text="Start All", 
                      command=self._start_all).pack(side="left", padx=5)
        ctk.CTkButton(btn_frame, text="Stop All",
                      command=self._stop_all).pack(side="left", padx=5)
        ctk.CTkButton(btn_frame, text="Refresh",
                      command=self._refresh).pack(side="right", padx=5)
    
    def add_account(self, account_id: int, username: str, server: str):
        """
        Add account to control panel.
        """
        frame = ctk.CTkFrame(self.account_list)
        frame.pack(fill="x", pady=2)
        
        ctk.CTkLabel(frame, text=f"{username} ({server})").pack(side="left", padx=5)
        
        status = ctk.CTkLabel(frame, text="Stopped", text_color="red")
        status.pack(side="left", padx=10)
        
        ctk.CTkButton(frame, text="Start", width=60,
                      command=lambda: self._start_account(account_id)).pack(side="right", padx=2)
        ctk.CTkButton(frame, text="Stop", width=60,
                      command=lambda: self._stop_account(account_id)).pack(side="right", padx=2)
        
        self.account_frames[account_id] = {"frame": frame, "status": status}
    
    def _start_account(self, account_id: int):
        self.launcher.launch(account_id)
        self.account_frames[account_id]["status"].configure(text="Running", text_color="green")
    
    def _stop_account(self, account_id: int):
        self.launcher.stop(account_id)
        self.account_frames[account_id]["status"].configure(text="Stopped", text_color="red")
    
    def _start_all(self):
        for account_id in self.account_frames:
            self._start_account(account_id)
    
    def _stop_all(self):
        self.launcher.stop_all()
        for account_id in self.account_frames:
            self.account_frames[account_id]["status"].configure(text="Stopped", text_color="red")
    
    def _refresh(self):
        # Check process status
        pass
```

---

## Configuration

### Bot Configuration File

```yaml
# config/bot_config.yaml

general:
  log_level: INFO
  log_file: logs/bot.log

tor:
  enabled: true
  port: 9050
  control_port: 9051
  rotate_interval: 300  # seconds

accounts:
  - username: player1
    server: svr12.evony.com
    script: farm_npc
    enabled: true
  - username: player2
    server: svr12.evony.com
    script: build_queue
    enabled: true

scripts:
  farm_npc:
    target_level: 10
    min_archers: 90000
    interval: 300
  build_queue:
    auto_upgrade: true
    priority: [barracks, forge, academy]
```

---

## Related Documentation

- `BOT_SCRIPTING.md` - Script syntax
- `COMMAND_REFERENCE.md` - Protocol commands
- `NPC_FARMING.md` - Farming strategies
- `EVONY_PROTOCOL.md` - Network protocol

---

*Document Version: 1.0.0 | Integration Guide for Svony Studio*
