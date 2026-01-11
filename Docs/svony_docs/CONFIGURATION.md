# Svony Studio - Configuration Reference

> **"Configuration Guide"** - Complete Configuration Options

---

## Overview

Svony Studio uses YAML configuration files for settings. The primary config file is `config/settings.yaml`.

---

## Configuration Files

| File | Purpose |
|------|---------|
| `config/settings.yaml` | Main application settings |
| `config/keybindings.yaml` | Keyboard shortcuts |
| `config/themes.yaml` | UI theme definitions |
| `config/bot_config.yaml` | Bot automation settings |
| `.env` | Environment variables (secrets) |

---

## Main Configuration (settings.yaml)

### Full Example

```yaml
# Svony Studio Configuration
# Version: 1.0.0

#===============================================================================
# APPLICATION SETTINGS
#===============================================================================

app:
  name: "Svony Studio"
  version: "1.0.0"
  language: "en"
  
  # Window settings
  window:
    width: 1600
    height: 900
    maximized: false
    remember_position: true
    
  # Startup behavior
  startup:
    check_updates: true
    restore_session: true
    show_tips: true
    
#===============================================================================
# PATHS
#===============================================================================

paths:
  # Project storage
  projects_dir: "D:/svony_studio/projects"
  
  # Temporary files
  temp_dir: "D:/svony_studio/temp"
  
  # Log files
  logs_dir: "D:/svony_studio/logs"
  
  # Cache directory
  cache_dir: "D:/svony_studio/cache"
  
  # Backup directory
  backup_dir: "D:/svony_studio/backups"

#===============================================================================
# EXTERNAL TOOLS
#===============================================================================

tools:
  # FFDec (JPEXS Free Flash Decompiler)
  ffdec_path: "C:/Program Files (x86)/FFDec"
  ffdec_jar: ""  # Auto-detect if empty
  
  # Java Runtime
  java_path: ""  # Auto-detect if empty
  java_options: "-Xmx4g"
  
  # RABCDAsm (optional)
  rabcdasm_path: ""
  
  # Flash Player (for testing)
  flash_player_path: ""
  
  # Ruffle (Flash emulator)
  ruffle_path: ""

#===============================================================================
# DECOMPILATION SETTINGS
#===============================================================================

decompile:
  # Output format
  format: "as"  # as, pcode, both
  
  # Parallel processing
  parallel: true
  max_threads: 4
  
  # Deobfuscation
  deobfuscate: true
  deobfuscate_level: 2  # 1-3
  
  # Code formatting
  indent_size: 4
  use_tabs: false
  
  # Comments
  include_line_numbers: true
  include_addresses: false

#===============================================================================
# EXPORT SETTINGS
#===============================================================================

export:
  # Image export
  images:
    format: "png"  # png, jpg, bmp, gif
    quality: 95
    scale: 1.0
    
  # Sound export
  sounds:
    format: "mp3"  # mp3, wav, flv
    
  # Script export
  scripts:
    format: "as"
    single_file: false
    include_imports: true
    
  # Binary export
  binary:
    include_tags: true

#===============================================================================
# SOL SETTINGS
#===============================================================================

sol:
  # Scan locations
  scan_paths:
    - "%APPDATA%/Macromedia/Flash Player/#SharedObjects"
    - "%LOCALAPPDATA%/Google/Chrome/User Data"
    - "%APPDATA%/Mozilla/Firefox/Profiles"
    
  # Auto-backup before edit
  auto_backup: true
  backup_count: 5
  
  # Export format
  export_format: "json"  # json, yaml

#===============================================================================
# EVONY SETTINGS
#===============================================================================

evony:
  # Default server
  default_server: "svr12.evony.com"
  default_port: 443
  
  # Client analysis
  borg_mode:
    deep_scan: true
    extract_protocol: true
    find_credentials: true
    
  # Protocol
  protocol:
    timeout: 30
    retry_count: 3
    
#===============================================================================
# BOT SETTINGS
#===============================================================================

bot:
  # Script directories
  scripts_dir: "D:/svony_studio/scripts"
  
  # Default settings
  defaults:
    wait_time: 300
    random_delay: true
    delay_range: [0.8, 1.2]
    
  # Tor integration
  tor:
    enabled: false
    proxy_port: 9050
    control_port: 9051
    rotate_interval: 300
    
  # Rate limiting
  rate_limit:
    enabled: true
    requests_per_minute: 60

#===============================================================================
# UI SETTINGS
#===============================================================================

ui:
  # Theme
  theme: "dark"  # dark, light, borg
  
  # Font
  font_family: "Consolas"
  font_size: 12
  
  # Editor
  editor:
    show_line_numbers: true
    highlight_current_line: true
    word_wrap: false
    auto_indent: true
    
  # Panels
  panels:
    show_toolbar: true
    show_statusbar: true
    show_console: true
    console_height: 200
    
  # Tree view
  tree:
    show_icons: true
    sort_alphabetically: true
    expand_depth: 2

#===============================================================================
# LOGGING
#===============================================================================

logging:
  # Log level: DEBUG, INFO, WARNING, ERROR, CRITICAL
  level: "INFO"
  
  # Log file settings
  file:
    enabled: true
    max_size_mb: 10
    backup_count: 5
    
  # Console logging
  console:
    enabled: true
    colored: true

#===============================================================================
# PERFORMANCE
#===============================================================================

performance:
  # Memory limits
  max_memory_mb: 4096
  
  # Cache settings
  cache:
    enabled: true
    max_size_mb: 500
    ttl_hours: 24
    
  # File watching
  file_watch:
    enabled: true
    debounce_ms: 500

#===============================================================================
# NETWORK
#===============================================================================

network:
  # Proxy settings
  proxy:
    enabled: false
    type: "socks5"  # http, socks4, socks5
    host: "127.0.0.1"
    port: 9050
    
  # Timeouts
  connect_timeout: 10
  read_timeout: 30
  
  # SSL/TLS
  ssl:
    verify: true
    ca_bundle: ""

#===============================================================================
# SECURITY
#===============================================================================

security:
  # Credential handling
  credentials:
    encrypt_storage: true
    auto_clear: false
    
  # File access
  sandbox:
    enabled: false
    allowed_paths: []
```

---

## Environment Variables

Create `.env` file for sensitive values:

```ini
# .env - Environment Variables
# DO NOT COMMIT TO VERSION CONTROL

# API Keys (if using cloud services)
OPENAI_API_KEY=sk-...
ANTHROPIC_API_KEY=sk-ant-...

# Evony Credentials (optional)
EVONY_USERNAME=
EVONY_PASSWORD_HASH=

# Tor Control Password
TOR_CONTROL_PASSWORD=

# Database (if using)
DB_CONNECTION_STRING=

# Custom FFDec Path
FFDEC_PATH=C:/Program Files (x86)/FFDec
```

---

## Keybindings Configuration

```yaml
# config/keybindings.yaml

# File operations
file.new: "Ctrl+N"
file.open: "Ctrl+O"
file.save: "Ctrl+S"
file.save_as: "Ctrl+Shift+S"
file.close: "Ctrl+W"
file.quit: "Ctrl+Q"

# Edit operations
edit.undo: "Ctrl+Z"
edit.redo: "Ctrl+Y"
edit.cut: "Ctrl+X"
edit.copy: "Ctrl+C"
edit.paste: "Ctrl+V"
edit.find: "Ctrl+F"
edit.replace: "Ctrl+H"
edit.find_next: "F3"

# View operations
view.fullscreen: "F11"
view.zoom_in: "Ctrl+Plus"
view.zoom_out: "Ctrl+Minus"
view.zoom_reset: "Ctrl+0"

# Navigation
nav.go_to_line: "Ctrl+G"
nav.go_to_definition: "Ctrl+B"
nav.back: "Alt+Left"
nav.forward: "Alt+Right"

# Tools
tools.run: "F5"
tools.validate: "Ctrl+Shift+V"
tools.decompile: "F7"
tools.recompile: "F8"

# Custom
custom.borg_mode: "Ctrl+Shift+B"
```

---

## Theme Configuration

```yaml
# config/themes.yaml

themes:
  dark:
    name: "Dark"
    colors:
      background: "#1E1E1E"
      foreground: "#D4D4D4"
      accent: "#007ACC"
      error: "#F44336"
      warning: "#FF9800"
      success: "#4CAF50"
      
      # Editor colors
      editor_bg: "#1E1E1E"
      editor_fg: "#D4D4D4"
      line_numbers: "#858585"
      selection: "#264F78"
      current_line: "#2D2D2D"
      
      # Syntax highlighting
      syntax:
        keyword: "#569CD6"
        string: "#CE9178"
        number: "#B5CEA8"
        comment: "#6A9955"
        function: "#DCDCAA"
        class: "#4EC9B0"
        operator: "#D4D4D4"
        
  light:
    name: "Light"
    colors:
      background: "#FFFFFF"
      foreground: "#000000"
      accent: "#0066CC"
      # ... etc
      
  borg:
    name: "Borg"
    colors:
      background: "#0A0A0A"
      foreground: "#00FF00"
      accent: "#00CC00"
      # Matrix-style green theme
```

---

## Bot Configuration

```yaml
# config/bot_config.yaml

# Account definitions
accounts:
  - id: account1
    username: "player1"
    server: "svr12.evony.com"
    enabled: true
    script: "npc_farm"
    
  - id: account2
    username: "player2"
    server: "svr12.evony.com"
    enabled: true
    script: "build_queue"

# Script definitions
scripts:
  npc_farm:
    target_level: 10
    min_archers: 90000
    interval: 300
    hero_min_attack: 150
    
  build_queue:
    auto_upgrade: true
    priority:
      - "barracks"
      - "forge"
      - "academy"
    max_queue: 2

# Scheduling
schedule:
  enabled: true
  active_hours:
    start: "08:00"
    end: "22:00"
  timezone: "America/Phoenix"
  
# Safety
safety:
  max_actions_per_hour: 100
  random_delays: true
  pause_on_attack: true
```

---

## Configuration Priority

Settings are loaded in order (later overrides earlier):

1. Default values (built-in)
2. `config/settings.yaml`
3. Environment variables
4. Command-line arguments

Example override:
```powershell
# Override via command line
python main.py --config custom.yaml --verbose

# Override via environment
$env:SVONY_LOG_LEVEL = "DEBUG"
python main.py
```

---

## Validation

### Validate Configuration

```powershell
python scripts/validate_config.py
```

### Check Specific Settings

```powershell
python -c "
from svony.config import Config
config = Config.load()
print(config.validate())
"
```

---

## Reset to Defaults

```powershell
# Backup current
Copy-Item config/settings.yaml config/settings.yaml.backup

# Reset
Copy-Item config/settings.yaml.example config/settings.yaml
```

---

## Related Documentation

- `INSTALLATION_GUIDE.md` - Initial setup
- `CLI_REFERENCE.md` - Command line options
- `TROUBLESHOOTING.md` - Config issues
- `SECURITY.md` - Security settings

---

*Document Version: 1.0.0 | Configuration Reference*
