# Svony SOL Manager Pro - Flash Toolkit Integration

## Overview

Integration plan for merging `flash_toolkit_v2` features into Svony SOL Manager Pro v2.0.

---

## Current Svony Capabilities

| Feature | Status | Notes |
|---------|--------|-------|
| SOL file reading | ✅ | Using PyAMF |
| Account management | ✅ | 194+ accounts |
| Bot launcher | ✅ | RoboEvony integration |
| Path management | ✅ | Drive/folder selection |
| GUI interface | ✅ | Tkinter-based |
| Import from backups | ✅ | Multi-location scan |

---

## Gaps & Missing Features

### 🔴 Critical Gaps

| Gap | Impact | Solution |
|-----|--------|----------|
| **No SOL validation** | Corrupted files crash app | Add AMF format validation |
| **No backup before write** | Data loss risk | Auto-backup before modifications |
| **No error recovery** | User loses data | Transaction-like operations |
| **No duplicate detection** | Wasted storage | Hash-based deduplication |

### 🟡 Important Gaps

| Gap | Impact | Solution |
|-----|--------|----------|
| **No JPEXS integration** | Manual SOL editing | CLI wrapper for FFDec |
| **No SOL corruption repair** | Lost accounts | AMF structure repair tool |
| **No batch operations** | Slow for 500+ accounts | Async batch processor |
| **No export formats** | Limited interop | JSON/XML/CSV export |
| **No SOL diff/compare** | Can't track changes | Visual diff tool |

### 🟢 Nice to Have

| Gap | Impact | Solution |
|-----|--------|----------|
| **No SWF analysis** | Missing game insights | FFDec CLI integration |
| **No visual SOL tree** | Hard to explore | TreeView editor |
| **No script extraction** | Limited automation | City goals/scripts export |
| **No proxy validation** | Failed connections | Pre-launch proxy check |

---

## Failsafes Required

### SOL File Protection

```python
class SOLProtection:
    """Failsafes for SOL file operations"""
    
    def validate_sol(self, path: Path) -> bool:
        """Validate SOL file structure before operations"""
        # Check magic bytes (0x00 0xBF for SOL)
        # Verify AMF structure
        # Check file size sanity
        pass
    
    def backup_before_write(self, path: Path) -> Path:
        """Create timestamped backup before any modification"""
        # backup_path = path.with_suffix(f'.sol.{timestamp}.bak')
        pass
    
    def verify_write(self, path: Path, expected_data: dict) -> bool:
        """Read back and verify written data matches"""
        pass
    
    def repair_corrupted(self, path: Path) -> bool:
        """Attempt to repair corrupted SOL files"""
        # Try to salvage readable portions
        pass
```

### Transaction-Like Operations

```python
class SOLTransaction:
    """Atomic SOL operations with rollback"""
    
    def __enter__(self):
        # Create backup
        # Lock file
        pass
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        if exc_type:
            # Rollback from backup
            pass
        else:
            # Commit changes
            # Remove backup
            pass
```

---

## Toolkit Features to Integrate

### Priority 1: SOL Tools

| Tool | Integration | Benefit |
|------|-------------|---------|
| **FFDec SOL Editor** | CLI wrapper | Visual editing fallback |
| **Py3AMF validation** | Direct integration | Format validation |
| **rust-flash-lso** | Optional backend | Better error handling |

### Priority 2: Analysis Tools

| Tool | Integration | Benefit |
|------|-------------|---------|
| **swfstrings** | Asset extraction | Find SharedObject keys |
| **FFDec export** | Script analysis | Discover hidden features |

### Priority 3: Utility Tools

| Tool | Integration | Benefit |
|------|-------------|---------|
| **Ruffle** | Testing environment | Run without Flash Player |
| **swfmill** | XML conversion | Structure analysis |

---

## SOL Data Structure (from JPEXS)

Based on your extracted config.sol:

```json
{
  "now": {
    "type": "Object",
    "sealedMembers": {
      "username": "fnice@q.com",
      "password": "ZX0107Zx0107",
      "server": "cc2",
      "serverIP": "216.66.17.168",
      "strserverAlias": "Parapet",
      "sid": "375",
      "proxyHost": "",
      "proxyPort": "8080",
      "proxyType": "",
      "proxyUn": "",
      "proxyPw": "",
      "loginType": "ev",
      "autoLogin": false,
      "autoLoginMinTime": "0",
      "autoLoginMaxTime": "20",
      "autoRun": true,
      "autoScript": false,
      "secCode": "",
      "theme": "Ice Blue RE",
      "skypeUn": "",
      "skypePw": "",
      "tokenExpires": "NaN"
    }
  }
}
```

### Field Analysis

| Field | Type | Purpose | Svony Uses |
|-------|------|---------|------------|
| `username` | String | Login email | ✅ Primary key |
| `password` | String | Account password | ✅ Authentication |
| `server` | String | Server code (cc2) | ✅ Server selection |
| `serverIP` | String | Server IP address | ✅ Connection |
| `strserverAlias` | String | Server name (Parapet) | ✅ Display |
| `sid` | String | Server ID | ⚠️ Not used |
| `proxyHost` | String | Proxy address | ✅ Tor routing |
| `proxyPort` | String | Proxy port | ✅ Tor port |
| `proxyType` | String | SOCKS4/SOCKS5/HTTP | ⚠️ Hardcoded |
| `autoLogin` | Boolean | Auto-login flag | ⚠️ Not used |
| `autoRun` | Boolean | Auto-start scripts | ⚠️ Not used |
| `autoScript` | Boolean | Run automation | ⚠️ Not used |
| `secCode` | String | Security code | ⚠️ Not used |
| `theme` | String | UI theme | ❌ Not needed |
| `tokenExpires` | NaN | Session token | ❌ Not needed |

### Missing from Svony

These SOL fields should be exposed in the GUI:

1. **autoLogin** - Enable auto-login on launch
2. **autoRun** - Start scripts automatically
3. **autoScript** - Enable automation features
4. **proxyType** - Currently hardcoded, should be configurable
5. **secCode** - Security code for protected accounts

---

## Action Plan

### Phase 1: Failsafes (Week 1)

```
[ ] Add SOL validation before all read operations
[ ] Implement auto-backup before write operations
[ ] Add verify-after-write confirmation
[ ] Create SOL repair utility for corrupted files
[ ] Add transaction wrapper for atomic operations
```

### Phase 2: SOL Features (Week 2)

```
[ ] Expose all SOL fields in GUI (autoLogin, autoRun, etc.)
[ ] Add batch SOL editing (change proxy for all accounts)
[ ] Implement SOL diff/compare tool
[ ] Add export to JSON/XML/CSV formats
[ ] Create SOL template system (copy settings between accounts)
```

### Phase 3: JPEXS Integration (Week 3)

```
[ ] Create FFDec CLI wrapper class
[ ] Add "Open in FFDec" button for visual editing
[ ] Implement SOL export via FFDec for verification
[ ] Add SWF analysis for discovering new SOL fields
```

### Phase 4: SWF Studio (Week 4)

```
[ ] Create SWF Studio module
[ ] Add script extraction and viewing
[ ] Implement asset browser
[ ] Add bytecode patching interface
```

---

## Integration Code Snippets

### FFDec CLI Wrapper

```python
from pathlib import Path
import subprocess
import json

class FFDecWrapper:
    """Wrapper for JPEXS FFDec CLI operations"""
    
    FFDEC_PATH = Path(r"C:\Program Files\FFDec\ffdec.bat")
    
    @classmethod
    def export_sol_to_json(cls, sol_path: Path, output_path: Path) -> bool:
        """Export SOL to JSON using FFDec"""
        cmd = [str(cls.FFDEC_PATH), "-export", "sol", str(output_path), str(sol_path)]
        result = subprocess.run(cmd, capture_output=True, text=True)
        return result.returncode == 0
    
    @classmethod
    def open_sol_editor(cls, sol_path: Path):
        """Open SOL in FFDec visual editor"""
        subprocess.Popen([str(cls.FFDEC_PATH), str(sol_path)])
    
    @classmethod
    def extract_swf_scripts(cls, swf_path: Path, output_dir: Path) -> bool:
        """Export all ActionScript from SWF"""
        cmd = [str(cls.FFDEC_PATH), "-export", "script", str(output_dir), str(swf_path)]
        result = subprocess.run(cmd, capture_output=True, text=True)
        return result.returncode == 0
    
    @classmethod
    def search_swf(cls, swf_path: Path, pattern: str) -> list:
        """Search for pattern in SWF"""
        cmd = [str(cls.FFDEC_PATH), "-search", pattern, str(swf_path)]
        result = subprocess.run(cmd, capture_output=True, text=True)
        return result.stdout.strip().split('\n') if result.returncode == 0 else []
```

### SOL Validation

```python
import struct
from pathlib import Path

class SOLValidator:
    """Validate SOL file integrity"""
    
    SOL_MAGIC = b'\x00\xbf'  # SOL file signature
    
    @classmethod
    def validate(cls, path: Path) -> tuple[bool, str]:
        """
        Validate SOL file structure.
        Returns (is_valid, error_message)
        """
        if not path.exists():
            return False, "File does not exist"
        
        if path.stat().st_size < 10:
            return False, "File too small to be valid SOL"
        
        if path.stat().st_size > 10 * 1024 * 1024:  # 10MB max
            return False, "File suspiciously large"
        
        with open(path, 'rb') as f:
            magic = f.read(2)
            if magic != cls.SOL_MAGIC:
                return False, f"Invalid magic bytes: {magic.hex()}"
            
            # Read length
            length_bytes = f.read(4)
            if len(length_bytes) < 4:
                return False, "File truncated"
            
            length = struct.unpack('>I', length_bytes)[0]
            
            # Verify signature "TCSO"
            sig = f.read(4)
            if sig != b'TCSO':
                return False, f"Invalid signature: {sig}"
        
        return True, "Valid SOL file"
    
    @classmethod
    def get_sol_info(cls, path: Path) -> dict:
        """Get SOL file metadata"""
        is_valid, msg = cls.validate(path)
        
        return {
            "path": str(path),
            "size": path.stat().st_size,
            "valid": is_valid,
            "message": msg,
            "modified": path.stat().st_mtime
        }
```

### Batch Operations

```python
from concurrent.futures import ThreadPoolExecutor
from typing import Callable, List
from pathlib import Path

class BatchSOLProcessor:
    """Process multiple SOL files efficiently"""
    
    def __init__(self, max_workers: int = 4):
        self.max_workers = max_workers
    
    def process_all(self, sol_paths: List[Path], 
                    operation: Callable[[Path], bool],
                    progress_callback: Callable[[int, int], None] = None) -> dict:
        """
        Process multiple SOL files with given operation.
        Returns dict with success/failure counts.
        """
        results = {"success": 0, "failed": 0, "errors": []}
        total = len(sol_paths)
        
        with ThreadPoolExecutor(max_workers=self.max_workers) as executor:
            futures = {executor.submit(operation, p): p for p in sol_paths}
            
            for i, future in enumerate(futures):
                path = futures[future]
                try:
                    if future.result():
                        results["success"] += 1
                    else:
                        results["failed"] += 1
                except Exception as e:
                    results["failed"] += 1
                    results["errors"].append((str(path), str(e)))
                
                if progress_callback:
                    progress_callback(i + 1, total)
        
        return results
```

---

## File Structure After Integration

```
D:\EvonyToolKit\Svony\
├── src\
│   ├── account_connector.py    # Enhanced with validation
│   ├── bot_launcher.py         # Enhanced with failsafes
│   ├── gui.py                  # New SOL fields exposed
│   ├── path_manager.py         # Drive/folder management
│   ├── sol_validator.py        # NEW: SOL validation
│   ├── sol_protection.py       # NEW: Backup/restore
│   ├── ffdec_wrapper.py        # NEW: FFDec integration
│   ├── batch_processor.py      # NEW: Batch operations
│   └── swf_studio\             # NEW: SWF Studio module
│       ├── __init__.py
│       ├── analyzer.py
│       ├── script_viewer.py
│       └── asset_browser.py
├── tools\
│   ├── ffdec\                  # JPEXS FFDec
│   ├── swftools\               # SWFTools utilities
│   └── ruffle\                 # Flash emulator
└── backups\                    # Auto-backup location
    └── sol\
```

---

## Next Steps

1. **Immediate**: Implement SOL validation in `account_connector.py`
2. **This Week**: Add auto-backup before write operations
3. **Next Week**: Expose all SOL fields in GUI
4. **Future**: Full SWF Studio implementation
