# Evony Age II - Reverse Engineering Analysis Guide

This guide documents the structure of Evony Age II Flash clients and automation bots, based on decompilation analysis of EvonyClient.swf and AutoEvony.swf.

## Overview

| Component | Version | Flash Version | Purpose |
|-----------|---------|---------------|---------|
| EvonyClient.swf | 1921 | Flash 11 | Main game client |
| AutoEvony.swf | v1.60 | Flash 11 | Automation bot ("RE for Age II") |
| roboevony.exe | - | Projector | Standalone executable wrapper |

---

## Key Packages & Classes

### EvonyClient Structure

```
com.evony.
├── client/
│   ├── LoginManager           # Login flow, session management
│   ├── GameClient             # Main game state
│   └── action/
│       └── ActionFactory      # API call factory
├── common/
│   ├── beans/                 # Data structures (POJOs)
│   │   ├── CastleBean         # City data
│   │   ├── HeroBean           # Hero data
│   │   ├── TroopBean          # Troop data
│   │   ├── ResourceBean       # Resources (gold, food, wood, etc.)
│   │   ├── PlayerInfoBean     # Player profile
│   │   ├── AllianceBean       # Alliance data
│   │   └── ...
│   ├── module/                # Protocol handlers
│   │   ├── colony/            # Colony operations
│   │   ├── alliance/          # Alliance operations
│   │   ├── report/            # Battle reports
│   │   ├── mail/              # In-game mail
│   │   └── common/            # Shared operations
│   └── constants/             # Game constants
│       ├── FieldConstants     # Map field types
│       ├── TFConstants        # Troop/Formation
│       └── ObjConstants       # Object types
└── crypto/
    └── MD5                    # Password hashing
```

### AutoEvony Structure

```
autoevony/
├── cmds/
│   └── Commands               # Bot command implementations
├── scripts/
│   ├── Script                 # Script interpreter
│   └── CityState              # Per-city state tracking
├── player/
│   ├── Map                    # World map state
│   └── LoginHelper            # Login automation
├── management/
│   └── CityManager            # City automation
├── net/
│   └── Connection             # Network layer
└── gui/
    └── MainScreen             # Bot UI
```

---

## SOL File Structure

### Location
```
%APPDATA%\Macromedia\Flash Player\#SharedObjects\<random>\evony.com\
%APPDATA%\Macromedia\Flash Player\#SharedObjects\<random>\localhost\
```

### Known SOL Names

| SOL Name | Purpose | Key Fields |
|----------|---------|------------|
| `cevony_sol` | Account credentials | username, password, server, email, playerId |
| `evony_settings` | Client preferences | volume, quality, showTips, language |
| `evony_cache` | Cached data | lastServer, rememberMe |
| `auto_evony` | Bot settings | autoLogin, scripts, timing |

### cevony_sol Structure (Example)
```json
{
  "username": "player@email.com",
  "password": "encrypted_or_plain",
  "server": "cc2",
  "serverIp": "216.66.17.168",
  "playerId": 12345678,
  "playerName": "Madmum1",
  "alliance": "ThePride",
  "lastLogin": 1704067200
}
```

---

## Network Protocol

### AMF (Action Message Format)

Evony uses AMF3 over HTTP for client-server communication.

**Endpoint Pattern:**
```
http://<server>/game/<action>.php
```

### Key API Actions

| Action | Description | Parameters |
|--------|-------------|------------|
| `login` | Authenticate | username, password, server |
| `getPlayerInfo` | Player stats | playerId |
| `getCastle` | City data | castleId |
| `getTroops` | Troop counts | castleId |
| `trainTroops` | Start training | castleId, troopType, count |
| `sendArmy` | Deploy army | from, to, troops, hero |
| `getFriendList` | Alliance friends | - |

### Request/Response Format

**Request (AMF3):**
```
{
  "method": "getCastle",
  "params": {
    "castleId": 12345
  },
  "sessionKey": "abc123..."
}
```

**Response (AMF3):**
```
{
  "ok": 1,
  "data": {
    "castleBean": { ... }
  }
}
```

---

## Bot Scripting Language

AutoEvony uses a custom scripting language. Based on decompiled code:

### Script Commands

```bash
# Variables
set variableName value
setarray arrayName [val1, val2, val3]

# Control Flow
if {%condition%} then
  # commands
endif

goto labelName
label labelName

# Loops
loop count
  # commands
endloop

# City Operations
echo "message"
config key:value
troop type:count,type:count

# Built-in Variables
%mode%           # Current mode
%cityIndex%      # Current city
%troopCount%     # Total troops
%foodPerHour%    # Food production
```

### Example Script (from decompiled code)
```bash
# City troop count reporter
setarray gltcctv ["%{$%tv%.peasants$-%gltcctc[0]%}", "%{$%tv%.militia$-%gltcctc[1]%}%", ...]
label totalcount
set fullmsg null

# Glitch triggering
set glitchnumber 2147483647
label incity_troop_glitch_numbers
setarr cfrn "{{{%glitchnumber%%fpt[0]%}1}+1} {{{%glitchnumber%%fpt[1]%}1}+1}..."

if {%mode%==full} echo "Food Per Hour: -$m_city.formatNum(%HorseFood%)$"
echo " Cavalry: $m_city.formatNum(%CavalryCount%)$"
```

---

## Decompilation Workflow

### 1. Extract Scripts with FFDec

```powershell
# Export all ActionScript
ffdec -export script D:\EvonyToolKit\analysis\scripts D:\EvonyToolKit\swf\EvonyClient.swf

# Search for specific patterns
Select-String -Path "D:\EvonyToolKit\analysis\scripts\*.as" -Pattern "SharedObject"
Select-String -Path "D:\EvonyToolKit\analysis\scripts\*.as" -Pattern "getLocal"
```

### 2. Find Login Flow

```powershell
# Look for login-related classes
Get-ChildItem -Recurse "D:\EvonyToolKit\analysis\scripts" -Filter "*Login*"
Get-ChildItem -Recurse "D:\EvonyToolKit\analysis\scripts" -Filter "*Session*"
```

### 3. Analyze SharedObject Usage

Key files to examine:
- `com/evony/client/LoginManager.as`
- `autoevony/player/LoginHelper.as`
- `autoevony/management/CityManager.as`

Look for:
```actionscript
SharedObject.getLocal("cevony_sol")
sharedObject.data.username
sharedObject.data.password
sharedObject.flush()
```

### 4. Find Network Calls

```powershell
# Search for API patterns
Select-String -Path "D:\EvonyToolKit\analysis\scripts\*.as" -Pattern "sendAndLoad|URLLoader|NetConnection"

# Find action factory methods
Select-String -Path "D:\EvonyToolKit\analysis\scripts\*.as" -Pattern "ActionFactory"
```

---

## Patching Guide

### Change Server Address

1. Decompile with FFDec
2. Find `ServerConfig` or similar class
3. Edit server URLs
4. Recompile

### Bypass Login Validation

1. Find `LoginManager` class
2. Locate validation logic
3. Use RABCDAsm to patch bytecode:

```bash
# Export ABC
abcexport EvonyClient.swf

# Disassemble
rabcdasm EvonyClient-0.abc

# Edit .asasm file to NOP validation
# Look for: iffalse/iftrue instructions
# Change condition or jump target

# Reassemble
rabcasm EvonyClient-0/EvonyClient-0.main.asasm

# Replace in SWF
abcreplace EvonyClient.swf 0 EvonyClient-0/EvonyClient-0.main.abc
```

### Add Debug Logging

Insert trace statements:
```actionscript
trace("Login attempt: " + username);
```

---

## Integration with Svony

### Reading SOL Data for Account List

```python
import pyamf.sol
import os

sol_base = os.path.expandvars(r"%APPDATA%\Macromedia\Flash Player\#SharedObjects")

def find_evony_sols():
    accounts = []
    for root, dirs, files in os.walk(sol_base):
        for f in files:
            if f.endswith(".sol") and "evony" in root.lower():
                path = os.path.join(root, f)
                try:
                    with open(path, "rb") as fp:
                        data = pyamf.sol.load(fp)
                    accounts.append({
                        "path": path,
                        "data": data
                    })
                except:
                    pass
    return accounts

# Use in Svony
accounts = find_evony_sols()
for acc in accounts:
    print(f"Found: {acc['data'].get('username')} on {acc['data'].get('server')}")
```

### Launching Bot with Credentials

```python
import subprocess

def launch_bot(sol_path, account_data):
    # Bot reads from SOL file
    # Modify SOL to set active account, then launch
    with open(sol_path, "wb") as f:
        pyamf.sol.save(f, account_data, "cevony_sol")
    
    # Launch projector
    subprocess.Popen([r"D:\EvonyToolKit\roboevony.exe"])
```

---

## Useful Regex Patterns

```powershell
# Find all class definitions
Select-String -Pattern "public class \w+" 

# Find all SharedObject usage
Select-String -Pattern "SharedObject\.getLocal\([^)]+\)"

# Find network URLs
Select-String -Pattern "https?://[^\s\"']+"

# Find password handling
Select-String -Pattern "password|passwd|pwd"

# Find encryption/hashing
Select-String -Pattern "MD5|SHA|encrypt|decrypt|hash"
```

---

## Security Notes

⚠️ **Credentials in SOL files may be stored in plain text or weakly encrypted.**

- Always backup SOL files before modification
- The game uses MD5 for password hashing (see `com.evony.crypto.MD5`)
- Network traffic is AMF over HTTP (can be inspected with Fiddler/Charles)
- Session tokens are typically short-lived

---

## Tools Summary

| Task | Tool | Command |
|------|------|---------|
| Decompile SWF | FFDec | `ffdec EvonyClient.swf` |
| Extract strings | swfstrings | `swfstrings EvonyClient.swf > strings.txt` |
| Patch bytecode | RABCDAsm | See workflow above |
| Read SOL | Py3AMF | `pyamf.sol.load(file)` |
| Edit SOL | Minerva | https://mariani.life/projects/minerva/ |
| Inspect traffic | Fiddler | AMF inspector plugin |
| Run without Flash | Ruffle | `ruffle EvonyClient.swf` |
