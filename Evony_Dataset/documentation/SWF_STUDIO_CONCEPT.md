# SWF Studio Concept

## Vision

A unified interface for Flash/SWF analysis, SOL editing, and bot management built around **JPEXS Free Flash Decompiler** as the core engine.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        SWF STUDIO                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │  SOL Editor  │  │ SWF Analyzer │  │ Bot Manager  │          │
│  │              │  │              │  │              │          │
│  │ • Tree View  │  │ • Scripts    │  │ • Accounts   │          │
│  │ • Validation │  │ • Assets     │  │ • Launcher   │          │
│  │ • Batch Edit │  │ • Search     │  │ • Nodes      │          │
│  │ • Export     │  │ • Patch      │  │ • Status     │          │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘          │
│         │                 │                 │                   │
│         └─────────────────┼─────────────────┘                   │
│                           │                                      │
│                    ┌──────┴───────┐                             │
│                    │  JPEXS FFDec │                             │
│                    │   (Engine)   │                             │
│                    └──────────────┘                             │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Modules

### 1. SOL Editor Module

**Purpose**: Visual editing of Flash Local Shared Objects

**Features**:
- Tree view of SOL data structure
- Type-aware editing (String, Number, Boolean, Array, Object)
- Validation before save
- Auto-backup on modification
- Batch operations (change field across all accounts)
- Template system (copy settings between accounts)
- Diff/compare tool

**JPEXS Integration**:
```python
# Open SOL in FFDec for visual editing
ffdec.exe "C:\path\to\config.sol"

# Export SOL to JSON for programmatic editing
ffdec.exe -export sol output.json input.sol

# Command-line SOL modification (future FFDec feature)
```

**Fields from config.sol**:
```
├── now (Object)
│   ├── username: "fnice@q.com"
│   ├── password: "ZX0107Zx0107"
│   ├── server: "cc2"
│   ├── serverIP: "216.66.17.168"
│   ├── strserverAlias: "Parapet"
│   ├── sid: "375"
│   ├── proxyHost: ""
│   ├── proxyPort: "8080"
│   ├── proxyType: ""
│   ├── proxyUn: ""
│   ├── proxyPw: ""
│   ├── loginType: "ev"
│   ├── autoLogin: false
│   ├── autoLoginMinTime: "0"
│   ├── autoLoginMaxTime: "20"
│   ├── autoRun: true
│   ├── autoScript: false
│   ├── secCode: ""
│   ├── theme: "Ice Blue RE"
│   ├── skypeUn: ""
│   ├── skypePw: ""
│   └── tokenExpires: NaN
```

---

### 2. SWF Analyzer Module

**Purpose**: Analyze and extract data from SWF files

**Features**:
- Script browser (ActionScript 1/2/3)
- Asset extraction (images, sounds, fonts)
- String search (find SharedObject keys)
- Class hierarchy viewer
- API endpoint discovery
- Deobfuscation

**JPEXS Commands**:
```powershell
# Export all scripts
ffdec.exe -export script "D:\output\scripts" "EvonyClient.swf"

# Export all images
ffdec.exe -export image "D:\output\images" "EvonyClient.swf"

# Search for patterns
ffdec.exe -search "SharedObject" "EvonyClient.swf"
ffdec.exe -search "proxyHost" "EvonyClient.swf"
ffdec.exe -search "URLLoader" "EvonyClient.swf"

# Deobfuscate
ffdec.exe -deobfuscate "input.swf" "output_clean.swf"

# Get SWF info
ffdec.exe -swfinfo "EvonyClient.swf"
```

**Key Classes to Analyze**:
```
com.evony.client.LoginManager           # Login flow
com.evony.client.action.ActionFactory   # API calls
com.evony.common.beans.*                # Data structures
com.evony.common.module.*               # Protocol handlers
autoevony.cmds.Commands                 # Bot commands
autoevony.net.Connection                # Network layer
```

---

### 3. Bot Manager Module

**Purpose**: Launch and manage RoboEvony instances

**Features**:
- Account grid with status
- Tor node assignment (10 per node)
- Port management (9000-9999)
- Batch launch
- Health monitoring
- Auto-restart on crash

**Current Implementation**: Already in Svony

---

## SOL Field Reference

### Credentials & Server

| Field | Type | Example | Description |
|-------|------|---------|-------------|
| `username` | String | `"fnice@q.com"` | Login email |
| `password` | String | `"ZX0107Zx0107"` | Account password |
| `server` | String | `"cc2"` | Server code |
| `serverIP` | String | `"216.66.17.168"` | Server IP |
| `strserverAlias` | String | `"Parapet"` | Server display name |
| `sid` | String | `"375"` | Server ID number |
| `loginType` | String | `"ev"` | Login type (ev=evony) |

### Proxy Settings

| Field | Type | Example | Description |
|-------|------|---------|-------------|
| `proxyHost` | String | `""` | Proxy server address |
| `proxyPort` | String | `"8080"` | Proxy port |
| `proxyType` | String | `""` | SOCKS4/SOCKS5/HTTP |
| `proxyUn` | String | `""` | Proxy username |
| `proxyPw` | String | `""` | Proxy password |

### Automation Settings

| Field | Type | Example | Description |
|-------|------|---------|-------------|
| `autoLogin` | Boolean | `false` | Auto-login on start |
| `autoLoginMinTime` | String | `"0"` | Min wait before login (sec) |
| `autoLoginMaxTime` | String | `"20"` | Max wait before login (sec) |
| `autoRun` | Boolean | `true` | Auto-start automation |
| `autoScript` | Boolean | `false` | Run scripts on login |

### Security & Misc

| Field | Type | Example | Description |
|-------|------|---------|-------------|
| `secCode` | String | `""` | Security/verification code |
| `theme` | String | `"Ice Blue RE"` | UI theme |
| `skypeUn` | String | `""` | Skype username (legacy) |
| `skypePw` | String | `""` | Skype password (legacy) |
| `tokenExpires` | NaN | `NaN` | Session token expiry |

---

## City Goals & Scripts

Beyond config.sol, RoboEvony stores city-specific data:

```
#SharedObjects\<hash>\localhost\evony\<account>\roboevony.exe\
├── config.sol              # Account settings (shown above)
├── citygoals0.sol          # City 1 goals/scripts
├── citygoals1.sol          # City 2 goals/scripts
├── citygoals2.sol          # City 3 goals/scripts
├── citytab0.sol            # City 1 tab settings
├── citytab1.sol            # City 2 tab settings
└── ...
```

**City Goals Structure**:
```json
{
  "goals": [
    {
      "type": "build",
      "building": "barracks",
      "level": 10,
      "priority": 1
    },
    {
      "type": "train",
      "unit": "cavalry",
      "count": 10000,
      "priority": 2
    }
  ]
}
```

---

## Implementation Roadmap

### Phase 1: Core Infrastructure

```python
# D:\EvonyToolKit\Svony\src\swf_studio\__init__.py

from .ffdec_wrapper import FFDecWrapper
from .sol_editor import SOLEditor
from .swf_analyzer import SWFAnalyzer
from .validation import SOLValidator

__all__ = ['FFDecWrapper', 'SOLEditor', 'SWFAnalyzer', 'SOLValidator']
```

### Phase 2: FFDec Wrapper

```python
# D:\EvonyToolKit\Svony\src\swf_studio\ffdec_wrapper.py

import subprocess
import json
from pathlib import Path
from typing import Optional, List

class FFDecWrapper:
    """Interface to JPEXS FFDec CLI"""
    
    def __init__(self, ffdec_path: Optional[Path] = None):
        self.ffdec_path = ffdec_path or self._find_ffdec()
    
    def _find_ffdec(self) -> Path:
        """Locate FFDec installation"""
        paths = [
            Path(r"C:\Program Files\FFDec\ffdec.bat"),
            Path(r"C:\Program Files (x86)\FFDec\ffdec.bat"),
            Path(r"D:\EvonyToolKit\flash_toolkit_v2\tools\ffdec\ffdec.bat"),
        ]
        for p in paths:
            if p.exists():
                return p
        raise FileNotFoundError("FFDec not found")
    
    def open_sol(self, sol_path: Path):
        """Open SOL in FFDec GUI"""
        subprocess.Popen([str(self.ffdec_path), str(sol_path)])
    
    def export_scripts(self, swf_path: Path, output_dir: Path) -> bool:
        """Export ActionScript from SWF"""
        output_dir.mkdir(parents=True, exist_ok=True)
        result = subprocess.run([
            str(self.ffdec_path), "-export", "script",
            str(output_dir), str(swf_path)
        ], capture_output=True)
        return result.returncode == 0
    
    def export_images(self, swf_path: Path, output_dir: Path) -> bool:
        """Export images from SWF"""
        output_dir.mkdir(parents=True, exist_ok=True)
        result = subprocess.run([
            str(self.ffdec_path), "-export", "image",
            str(output_dir), str(swf_path)
        ], capture_output=True)
        return result.returncode == 0
    
    def search(self, swf_path: Path, pattern: str) -> List[str]:
        """Search for pattern in SWF"""
        result = subprocess.run([
            str(self.ffdec_path), "-search", pattern, str(swf_path)
        ], capture_output=True, text=True)
        if result.returncode == 0:
            return [l.strip() for l in result.stdout.split('\n') if l.strip()]
        return []
    
    def get_swf_info(self, swf_path: Path) -> dict:
        """Get SWF metadata"""
        result = subprocess.run([
            str(self.ffdec_path), "-swfinfo", str(swf_path)
        ], capture_output=True, text=True)
        # Parse output into dict
        info = {}
        for line in result.stdout.split('\n'):
            if ':' in line:
                key, val = line.split(':', 1)
                info[key.strip()] = val.strip()
        return info
```

### Phase 3: SOL Editor

```python
# D:\EvonyToolKit\Svony\src\swf_studio\sol_editor.py

from pathlib import Path
from typing import Any, Dict, Optional
import pyamf.sol as sol
import json
import shutil
from datetime import datetime

class SOLEditor:
    """Edit SOL files with validation and backup"""
    
    def __init__(self, backup_dir: Optional[Path] = None):
        self.backup_dir = backup_dir or Path(r"D:\EvonyToolKit\Svony\backups\sol")
        self.backup_dir.mkdir(parents=True, exist_ok=True)
    
    def read(self, path: Path) -> Dict[str, Any]:
        """Read SOL file to dict"""
        with open(path, 'rb') as f:
            data = sol.decode(f)
        # sol.decode returns (name, data) tuple
        if isinstance(data, tuple):
            return {"_name": data[0], **data[1]}
        return data
    
    def write(self, path: Path, data: Dict[str, Any], 
              backup: bool = True) -> bool:
        """Write dict to SOL file with optional backup"""
        if backup:
            self._create_backup(path)
        
        name = data.pop("_name", path.stem)
        
        with open(path, 'wb') as f:
            sol.encode(f, data, name)
        
        # Verify write
        return self._verify_write(path, data)
    
    def _create_backup(self, path: Path) -> Path:
        """Create timestamped backup"""
        if not path.exists():
            return None
        
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        backup_path = self.backup_dir / f"{path.stem}_{timestamp}.sol.bak"
        shutil.copy2(path, backup_path)
        return backup_path
    
    def _verify_write(self, path: Path, expected: Dict) -> bool:
        """Verify written data matches expected"""
        try:
            actual = self.read(path)
            actual.pop("_name", None)
            return actual == expected
        except:
            return False
    
    def get_field(self, path: Path, field: str) -> Any:
        """Get specific field from SOL"""
        data = self.read(path)
        if "now" in data:
            return data["now"].get(field)
        return data.get(field)
    
    def set_field(self, path: Path, field: str, value: Any) -> bool:
        """Set specific field in SOL"""
        data = self.read(path)
        if "now" in data:
            data["now"][field] = value
        else:
            data[field] = value
        return self.write(path, data)
    
    def export_json(self, sol_path: Path, json_path: Path):
        """Export SOL to JSON"""
        data = self.read(sol_path)
        with open(json_path, 'w') as f:
            json.dump(data, f, indent=2, default=str)
    
    def import_json(self, json_path: Path, sol_path: Path):
        """Import JSON to SOL"""
        with open(json_path, 'r') as f:
            data = json.load(f)
        self.write(sol_path, data)
```

### Phase 4: Validation

```python
# D:\EvonyToolKit\Svony\src\swf_studio\validation.py

import struct
from pathlib import Path
from typing import Tuple, Optional
from dataclasses import dataclass

@dataclass
class ValidationResult:
    valid: bool
    message: str
    details: Optional[dict] = None

class SOLValidator:
    """Validate SOL file integrity"""
    
    SOL_MAGIC = b'\x00\xbf'
    TCSO_SIG = b'TCSO'
    MAX_SIZE = 10 * 1024 * 1024  # 10MB
    
    @classmethod
    def validate(cls, path: Path) -> ValidationResult:
        """Full validation of SOL file"""
        # Check existence
        if not path.exists():
            return ValidationResult(False, "File does not exist")
        
        # Check size
        size = path.stat().st_size
        if size < 10:
            return ValidationResult(False, f"File too small ({size} bytes)")
        if size > cls.MAX_SIZE:
            return ValidationResult(False, f"File too large ({size} bytes)")
        
        # Check structure
        try:
            with open(path, 'rb') as f:
                # Magic bytes
                magic = f.read(2)
                if magic != cls.SOL_MAGIC:
                    return ValidationResult(False, 
                        f"Invalid magic: {magic.hex()} (expected 00bf)")
                
                # Length field
                length_bytes = f.read(4)
                length = struct.unpack('>I', length_bytes)[0]
                
                # TCSO signature
                sig = f.read(4)
                if sig != cls.TCSO_SIG:
                    return ValidationResult(False,
                        f"Invalid signature: {sig} (expected TCSO)")
                
                # Try to parse AMF data
                f.seek(0)
                import pyamf.sol as sol
                data = sol.decode(f)
                
                details = {
                    "size": size,
                    "length_field": length,
                    "fields": len(data[1]) if isinstance(data, tuple) else len(data)
                }
                
                return ValidationResult(True, "Valid SOL file", details)
                
        except Exception as e:
            return ValidationResult(False, f"Parse error: {str(e)}")
    
    @classmethod
    def validate_account_sol(cls, path: Path) -> ValidationResult:
        """Validate config.sol has required account fields"""
        result = cls.validate(path)
        if not result.valid:
            return result
        
        import pyamf.sol as sol
        with open(path, 'rb') as f:
            data = sol.decode(f)
        
        if isinstance(data, tuple):
            data = data[1]
        
        # Check for 'now' object
        if 'now' not in data:
            return ValidationResult(False, "Missing 'now' object")
        
        now = data['now']
        required = ['username', 'password', 'server']
        missing = [f for f in required if not now.get(f)]
        
        if missing:
            return ValidationResult(False, f"Missing required fields: {missing}")
        
        return ValidationResult(True, "Valid account SOL", {
            "username": now.get('username'),
            "server": now.get('server'),
            "has_proxy": bool(now.get('proxyHost'))
        })
```

---

## GUI Integration

### SWF Studio Tab in Svony

```python
# Add to gui.py _create_widgets method

def _create_swf_studio_tab(self, parent):
    """Create SWF Studio tab"""
    tab = ttk.Frame(parent, style='Dark.TFrame')
    
    # Left: SOL Tree View
    sol_frame = ttk.LabelFrame(tab, text="SOL Editor")
    self.sol_tree = ttk.Treeview(sol_frame, columns=('value', 'type'))
    self.sol_tree.heading('#0', text='Field')
    self.sol_tree.heading('value', text='Value')
    self.sol_tree.heading('type', text='Type')
    
    # Right: SWF Analyzer
    swf_frame = ttk.LabelFrame(tab, text="SWF Analyzer")
    ttk.Button(swf_frame, text="Export Scripts", 
               command=self._export_scripts)
    ttk.Button(swf_frame, text="Search SWF",
               command=self._search_swf)
    ttk.Button(swf_frame, text="Open in FFDec",
               command=self._open_ffdec)
    
    # Bottom: Results
    self.results_text = tk.Text(tab, height=10)
    
    return tab
```

---

## Next Steps

1. **Install FFDec** - Download from GitHub releases
2. **Implement ffdec_wrapper.py** - CLI interface
3. **Implement sol_editor.py** - Read/write with backup
4. **Implement validation.py** - SOL integrity checks
5. **Add GUI tab** - Visual interface in Svony
6. **Test with real data** - Validate against 194 accounts
