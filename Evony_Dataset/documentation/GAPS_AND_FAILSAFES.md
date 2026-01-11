# Gaps, Failsafes & Action Plan

## Current State Analysis

### ✅ What's Working (Svony SOL Manager Pro)

| Feature | Status | Location |
|---------|--------|----------|
| SOL file reading | ✅ | `account_connector.py` |
| 194+ account management | ✅ | `UnifiedAccountManager` |
| Bot launcher (RoboEvony) | ✅ | `bot_launcher.py` |
| Path management (drive/folder) | ✅ | `path_manager.py` |
| Tor node assignment | ✅ | Ports 9000-9999 |
| Multi-backup import | ✅ | Scans all Macromedia locations |
| GUI interface | ✅ | `gui.py` (Tkinter) |

### ❌ Gaps Identified

#### Critical (Data Loss Risk)

| Gap | Risk | Solution | Priority |
|-----|------|----------|----------|
| No SOL validation | Corrupt files crash app | `SOLValidator` class | P0 |
| No backup before write | Data loss | Auto-backup system | P0 |
| No verify after write | Silent corruption | Read-back verification | P0 |
| No error recovery | User loses data | Transaction wrapper | P1 |

#### Important (Missing Features)

| Gap | Impact | Solution | Priority |
|-----|--------|----------|----------|
| Missing SOL fields in GUI | Can't set autoLogin, autoRun | Expose all fields | P1 |
| No batch operations | Slow for 500+ accounts | Async batch processor | P1 |
| No SOL diff/compare | Can't track changes | Diff tool | P2 |
| No export formats | Limited interop | JSON/XML/CSV export | P2 |
| No JPEXS integration | Manual editing only | FFDec CLI wrapper | P2 |

#### Nice to Have

| Gap | Impact | Solution | Priority |
|-----|--------|----------|----------|
| No SWF analysis | Missing game insights | FFDec script export | P3 |
| No visual SOL tree | Hard to explore data | TreeView widget | P3 |
| No city scripts export | Can't backup automation | citygoals*.sol parsing | P3 |

---

## Failsafes Implemented

### 1. SOL Validation (`swf_studio/validation.py`)

```python
from src.swf_studio import SOLValidator

# Before any operation
result = SOLValidator.validate(sol_path)
if not result.valid:
    print(f"Invalid SOL: {result.message}")
    return

# For account config files
result = SOLValidator.validate_account(config_sol_path)
if result.valid:
    print(f"Account: {result.details['username']}")
```

### 2. Auto-Backup (`swf_studio/sol_editor.py`)

```python
from src.swf_studio import SOLEditor

editor = SOLEditor()

# Automatic backup before any write
editor.set_field(sol_path, "proxyPort", "9050", backup=True)

# List backups for account
backups = editor.list_backups("Madmum2")

# Restore from backup
editor.restore_backup(backup_path, sol_path)
```

### 3. Verify After Write

```python
# Built into SOLEditor.write()
success = editor.write(sol_path, data)
if not success:
    print("Write verification failed!")
    # Backup still exists for recovery
```

---

## SOL Fields Reference

### Currently Used by Svony

| Field | Used | Location |
|-------|------|----------|
| `username` | ✅ | Primary key for accounts |
| `password` | ✅ | Authentication |
| `server` | ✅ | Server selection |
| `serverIP` | ✅ | Connection |
| `strserverAlias` | ✅ | Display name |
| `proxyPort` | ✅ | Tor node port |

### Should Be Exposed in GUI

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `proxyHost` | String | `""` | Proxy server (empty = localhost) |
| `proxyType` | String | `""` | SOCKS4/SOCKS5/HTTP |
| `autoLogin` | Boolean | `false` | Auto-login on start |
| `autoRun` | Boolean | `true` | Start automation |
| `autoScript` | Boolean | `false` | Run scripts |
| `autoLoginMinTime` | String | `"0"` | Min wait (seconds) |
| `autoLoginMaxTime` | String | `"20"` | Max wait (seconds) |
| `secCode` | String | `""` | Security code |
| `loginType` | String | `"ev"` | Login type |

---

## Action Plan

### Week 1: Critical Failsafes ✅ DONE

- [x] Create `SOLValidator` class
- [x] Create `SOLEditor` with auto-backup
- [x] Implement verify-after-write
- [x] Create `FFDecWrapper` for JPEXS integration

### Week 2: SOL Features

- [ ] Expose all SOL fields in GUI detail panel
- [ ] Add "Edit SOL" dialog with all fields
- [ ] Implement batch field modification
- [ ] Add JSON export/import buttons

### Week 3: SWF Studio

- [ ] Add "SWF Studio" tab to GUI
- [ ] Implement SOL tree view
- [ ] Add "Open in FFDec" button
- [ ] Add SWF script search

### Week 4: Advanced Features

- [ ] City goals/scripts viewer
- [ ] SOL diff/compare tool
- [ ] Account template system
- [ ] Proxy validation before launch

---

## Integration Points

### Add Validation to Account Connector

```python
# In account_connector.py _load_cevony_sol_accounts()

from .swf_studio import SOLValidator

for folder in sol_path.iterdir():
    config_path = folder / "roboevony.exe" / "config.sol"
    
    # Validate before loading
    result = SOLValidator.validate_account(config_path)
    if not result.valid:
        print(f"  [!] Invalid SOL for {folder.name}: {result.message}")
        continue
    
    # Load validated file...
```

### Add Backup to Bot Launcher

```python
# In bot_launcher.py before writing SOL

from .swf_studio import get_sol_editor

editor = get_sol_editor()

# This automatically creates backup
editor.set_multiple_fields(sol_path, {
    "proxyPort": str(port),
    "proxyHost": "",
    "proxyType": "SOCKS4"
}, backup=True)
```

### Add FFDec Button to GUI

```python
# In gui.py detail panel

from .swf_studio import get_ffdec

def _open_in_ffdec(self):
    """Open selected account's SOL in FFDec"""
    if not self.selected_account:
        return
    
    ffdec = get_ffdec()
    if not ffdec.available:
        messagebox.showerror("Error", "FFDec not installed")
        return
    
    sol_path = self._get_account_sol_path()
    ffdec.open_sol(sol_path)
```

---

## Files Created

| File | Purpose |
|------|---------|
| `src/swf_studio/__init__.py` | Module init |
| `src/swf_studio/validation.py` | SOL validation |
| `src/swf_studio/sol_editor.py` | SOL read/write with backup |
| `src/swf_studio/ffdec_wrapper.py` | JPEXS FFDec CLI |
| `docs/SVONY_INTEGRATION.md` | Integration guide |
| `docs/SWF_STUDIO_CONCEPT.md` | Studio design |
| `docs/GAPS_AND_FAILSAFES.md` | This file |

---

## Testing Checklist

```
[ ] SOLValidator.validate() returns correct result for valid SOL
[ ] SOLValidator.validate() catches corrupt/invalid files
[ ] SOLEditor.write() creates backup before modification
[ ] SOLEditor.write() verifies data after write
[ ] SOLEditor.restore_backup() recovers from backup
[ ] FFDecWrapper.available correctly detects installation
[ ] FFDecWrapper.open_sol() opens FFDec with SOL file
[ ] FFDecWrapper.export_scripts() extracts ActionScript
```
