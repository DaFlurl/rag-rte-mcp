# Svony Studio - Architecture Documentation

> **"The Collective Architecture"** - Understanding How Svony Studio Works

---

## Overview

Svony Studio is a desktop application built with Python and CustomTkinter, designed for reverse engineering Flash SWF files, particularly Evony Age II game clients and automation bots.

```
┌─────────────────────────────────────────────────────────────────┐
│                     SVONY STUDIO v1.0.0                         │
├─────────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────────┐  ┌─────────────────────┐ │
│  │   UI Layer  │  │   Core Layer    │  │   External Tools    │ │
│  │  (main.py)  │◄─┤ (src/core/*.py) │◄─┤ (FFDec, SWFTools)   │ │
│  └─────────────┘  └─────────────────┘  └─────────────────────┘ │
│         │                  │                     │              │
│         ▼                  ▼                     ▼              │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │                    DATA LAYER                               ││
│  │  .svony projects | SOL files | SWF binaries | config.json   ││
│  └─────────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────────┘
```

---

## Layer Architecture

### 1. User Interface Layer (`main.py`)

The UI is built with CustomTkinter, providing a modern dark-themed interface.

**Main Components:**

| Component | Class | Description |
|-----------|-------|-------------|
| Main Window | `SvonyStudioApp` | Root application window (1600x1000) |
| Menu System | Built-in | File, Edit, View, Tools, Evony, Help |
| Toolbar | `CTkFrame` | Quick action buttons |
| Project Panel | `CTkFrame` | Tree view of project files |
| Tab View | `CTkTabview` | Overview, Scripts, Assets, Search, Console |
| SOL Panel | `CTkFrame` | Account manager with list/details |
| Status Bar | `CTkFrame` | Status, file info, memory |

**UI Color Scheme (Borg Theme):**

```python
COLORS = {
    "bg_dark": "#0a0a0a",      # Main background
    "bg_medium": "#1a1a1a",    # Panel backgrounds
    "bg_light": "#2a2a2a",     # Interactive elements
    "accent_green": "#00ff00", # Primary (Borg green)
    "accent_cyan": "#00ffff",  # Secondary
    "text_primary": "#e0e0e0", # Main text
    "text_secondary": "#808080" # Subtle text
}
```

### 2. Core Layer (`src/core/`)

Business logic and data processing modules.

#### `project.py` - Project Management

```python
class SvonyProject:
    """Manages .svony project files"""
    
    def __init__(self, path: str = None)
    def create(self, name: str, path: str) -> bool
    def load(self, path: str) -> bool
    def save(self) -> bool
    def add_swf(self, swf_path: str)
    def remove_swf(self, swf_path: str)
    def get_project_data(self) -> dict
```

#### `swf_tools.py` - SWF Analysis

```python
class FFDecWrapper:
    """Wrapper for JPEXS Flash Decompiler CLI"""
    
    def __init__(self, ffdec_path: str)
    def export_scripts(self, swf: str, output: str) -> bool
    def export_images(self, swf: str, output: str) -> bool
    def export_sounds(self, swf: str, output: str) -> bool
    def get_swf_info(self, swf: str) -> dict
    def deobfuscate(self, swf: str, output: str) -> bool
    def replace_script(self, swf: str, item: str, new_file: str) -> bool

class SWFToolsWrapper:
    """Wrapper for SWFTools utilities"""
    
    def swfdump(self, swf: str) -> str
    def swfstrings(self, swf: str) -> list[str]
```

#### `sol_manager.py` - SOL File Handling

```python
class SOLManager:
    """Manages Flash Local Shared Objects (cookies)"""
    
    def scan_sol_directories(self) -> list[str]
    def parse_sol(self, path: str) -> dict
    def extract_accounts(self, sol_data: dict) -> list[Account]
    def write_sol(self, path: str, data: dict) -> bool
    def export_json(self, sol_data: dict, output: str) -> bool
```

#### `config.py` - Configuration

```python
class Config:
    """Application configuration manager"""
    
    CONFIG_PATH = "%APPDATA%/SvonyStudio/config.json"
    
    def load(self) -> dict
    def save(self, data: dict) -> bool
    def get(self, key: str, default=None)
    def set(self, key: str, value: Any)
```

### 3. Evony-Specific Layer (`src/evony/`)

Specialized modules for Evony analysis.

#### `class_browser.py` - Class Explorer

Maps and browses Evony-specific ActionScript classes:

- `com.evony.client.*` - Client-side logic
- `com.evony.common.*` - Shared data structures
- `autoevony.*` - AutoEvony bot classes
- `roboevony.*` - RoboEvony bot classes

#### `protocol.py` - Network Protocol

Documents the AMF3-based network protocol:

- Command serialization
- Response parsing
- Known endpoints
- Packet structure

#### `bot_scripts.py` - Script Engine

Parses and manages bot automation scripts:

- Script syntax parsing
- Command validation
- Execution planning

### 4. External Tools Layer

Svony Studio integrates with external applications via CLI:

| Tool | Purpose | Integration |
|------|---------|-------------|
| FFDec | SWF decompilation | `subprocess.run()` |
| SWFTools | SWF analysis | `subprocess.run()` |
| Ruffle | Flash emulation | `subprocess.Popen()` |
| Flash Player | Native playback | `subprocess.Popen()` |

---

## Data Flow

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  User Input  │────▶│   UI Layer   │────▶│  Core Layer  │
└──────────────┘     └──────────────┘     └──────────────┘
                                                 │
                     ┌───────────────────────────┼───────────────────────────┐
                     │                           │                           │
                     ▼                           ▼                           ▼
              ┌──────────────┐           ┌──────────────┐           ┌──────────────┐
              │  SWF Files   │           │  SOL Files   │           │   Projects   │
              │  (Analysis)  │           │  (Accounts)  │           │   (.svony)   │
              └──────────────┘           └──────────────┘           └──────────────┘
                     │                           │                           │
                     ▼                           ▼                           ▼
              ┌──────────────┐           ┌──────────────┐           ┌──────────────┐
              │    FFDec     │           │   Py3AMF     │           │    JSON      │
              │   SWFTools   │           │   Parser     │           │   Storage    │
              └──────────────┘           └──────────────┘           └──────────────┘
                     │                           │                           │
                     └───────────────────────────┼───────────────────────────┘
                                                 │
                                                 ▼
                                          ┌──────────────┐
                                          │   Results    │
                                          │   Display    │
                                          └──────────────┘
```

### Typical Workflows

**1. Load and Analyze SWF:**
```
User clicks "Load SWF" → File picker → swf_tools.get_swf_info() 
→ Display in Overview tab → Enable analysis buttons
```

**2. Scan SOL Accounts:**
```
User clicks "Scan" → sol_manager.scan_directories() 
→ Parse each .sol file → Extract account data 
→ Display in SOL Panel list → Enable account actions
```

**3. Borg Mode Analysis:**
```
User triggers Ctrl+B → Run all analysis in sequence:
  1. Scan SharedObjects → Find account references
  2. Extract network endpoints → List API calls
  3. Identify crypto functions → Map encryption
  4. Generate report → Display in Console
```

---

## File Formats

### `.svony` Project File (JSON)

```json
{
  "name": "MyProject",
  "version": "1.0.0",
  "created": "2026-01-02T12:00:00Z",
  "modified": "2026-01-02T15:30:00Z",
  "author": "Borg",
  "swf_files": [
    {
      "path": "clients/EvonyClient.swf",
      "added": "2026-01-02T12:00:00Z",
      "analysis": {...}
    }
  ],
  "sol_paths": [
    "%APPDATA%/Macromedia/Flash Player/#SharedObjects/..."
  ],
  "settings": {
    "auto_analyze": true,
    "export_path": "exports/"
  },
  "notes": "Project notes here"
}
```

### `config.json` Application Config

```json
{
  "tools": {
    "ffdec": "C:/ffdec/ffdec.bat",
    "swftools": "C:/swftools/",
    "flash": "C:/Flash/flashplayer_32.exe",
    "ruffle": "C:/ruffle/ruffle.exe"
  },
  "appearance": {
    "theme": "borg",
    "font_family": "Consolas",
    "font_size": 12
  },
  "recent_projects": [],
  "window_state": {
    "width": 1600,
    "height": 1000,
    "maximized": false
  }
}
```

---

## Dependencies

### Python Packages

| Package | Version | Purpose |
|---------|---------|---------|
| customtkinter | ≥5.2.0 | Modern UI framework |
| Pillow | ≥10.0.0 | Image processing |
| py3amf | ≥0.8.0 | AMF/SOL parsing |
| pygments | ≥2.16.0 | Syntax highlighting |

### External Tools

| Tool | Required | Purpose |
|------|----------|---------|
| FFDec | Yes | SWF decompilation |
| Java 8+ | Yes | FFDec runtime |
| SWFTools | Optional | Additional analysis |
| Ruffle | Optional | Flash emulation |
| Flash Player | Optional | Native playback |

---

## Security Considerations

1. **No credential storage** - SOL data is read-only by default
2. **Local operation** - No network calls except for updates
3. **Sandboxed execution** - External tools run in subprocess
4. **User consent** - All file operations require user action

---

## Extending Svony Studio

### Adding New Commands

1. Define method in `main.py`:
```python
def _my_new_command(self):
    """Description of command"""
    # Implementation
```

2. Add to menu in `_create_menus()`:
```python
tools_menu.add_command(label="My Command", command=self._my_new_command)
```

3. Add keyboard shortcut in `_bind_shortcuts()`:
```python
self.bind("<Control-m>", lambda e: self._my_new_command())
```

### Adding New Analysis Modules

1. Create module in `src/evony/`:
```python
# src/evony/my_analyzer.py
class MyAnalyzer:
    def analyze(self, swf_path: str) -> dict:
        # Implementation
        pass
```

2. Import and use in main.py or core modules

---

## Diagrams Reference

See `docs/diagrams/` for visual documentation:

- `studio_layout.svg` - UI component layout
- `architecture.svg` - System architecture
- `data_flow.svg` - Data flow diagram
- `swf_structure.svg` - SWF file format
- `sol_structure.svg` - SOL/AMF format
- `evony_architecture.svg` - Evony client structure
- `network_protocol.svg` - Network communication
- `ffdec_integration.svg` - FFDec integration
- `bot_execution.svg` - Bot script flow
- `menu_structure.svg` - Menu hierarchy
- `keyboard_shortcuts.svg` - Shortcut reference
- `project_structure.svg` - File layout
- `feature_map.svg` - Feature overview

---

*Document Version: 1.0.0 | Last Updated: January 2026*
