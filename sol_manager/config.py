"""
ETK SOL Manager - Configuration Module
Central configuration for paths, constants, and SOL type definitions
"""

from pathlib import Path
from typing import Dict, Any

# ============================================================================
# PATH CONFIGURATION (Portable - auto-detects project root)
# ============================================================================
def _get_project_root() -> Path:
    """Auto-detect project root for portability"""
    current = Path(__file__).resolve().parent
    # Go up from sol_manager to project root
    if current.name == 'sol_manager':
        return current.parent
    # Fallback markers
    for marker in ['SOL_Manager_Pro.bat', 'Botfile', 'run_sol_manager.py']:
        if (current / marker).exists():
            return current
        if (current.parent / marker).exists():
            return current.parent
    return current.parent

ETK_ROOT = _get_project_root()
MACROMEDIA_PATH = ETK_ROOT / "Macromedia" / "Flash Player" / "#SharedObjects"
BACKUP_PATH = ETK_ROOT / "sol_backups_managed"
CONFIG_FILE = ETK_ROOT / "tools" / "sol_manager_config.json"
TAGS_FILE = ETK_ROOT / "tools" / "account_tags.json"

# System Macromedia path (for syncing)
import os
SYSTEM_APPDATA = Path(os.environ.get('APPDATA', ''))
SYSTEM_MACROMEDIA_PATH = SYSTEM_APPDATA / "Macromedia" / "Flash Player" / "#SharedObjects"

# ============================================================================
# TOR NODE CONFIGURATION
# ============================================================================
TOTAL_TOR_NODES = 50
TOR_PORT_BASE = 9999  # Port = 9999 - node_number
MAX_ACCOUNTS_PER_NODE = 10  # Strict 10 accounts per node limit

# ============================================================================
# BACKUP CONFIGURATION
# ============================================================================
MAX_BACKUPS_PER_ACCOUNT = 10
AUTO_BACKUP_ENABLED = True

# ============================================================================
# SOL FILE TYPE DOCUMENTATION
# ============================================================================
SOL_TYPES: Dict[str, Dict[str, Any]] = {
    "config.sol": {
        "description": "Account Login & Settings",
        "location": "RoboEvony > Settings",
        "icon": "⚙️",
        "fields": {
            "username": "Email address for Evony login",
            "password": "Account password",
            "server": "Server code (e.g., cc2)",
            "serverIP": "Server IP address",
            "strserverAlias": "Server display name (e.g., Parapet)",
            "sid": "Server ID number",
            "proxyHost": "Proxy server address (127.0.0.1 for Tor)",
            "proxyPort": "Tor node port (9949-9999)",
            "proxyType": "Proxy type (ss5 = SOCKS5)",
            "autoLogin": "Auto-login on start",
            "autoRun": "Auto-run scripts on login",
            "autoScript": "Auto-execute scripts",
            "theme": "RoboEvony theme name",
            "loginType": "Login method (ev = Evony direct)",
        }
    },
    "goals.sol": {
        "description": "Automation Goals & Scripts",
        "location": "RoboEvony > Goals Window",
        "icon": "🎯",
        "fields": {
            "now": "Current active goal script",
            "goals": "List of saved goal scripts",
            "scripts": "Script text content",
            "sindex": "Selected script index",
        }
    },
    "newArmyTroopCfgs.sol": {
        "description": "Troop Army Configurations",
        "location": "RoboEvony > Army Presets",
        "icon": "⚔️",
        "fields": {
            "troopCfg": "Troop composition string (a=archers, w=warriors, etc.)",
            "label": "Preset name (wave1, bighitter, etc.)",
        }
    },
    "citydata.sol": {
        "description": "City Management Data",
        "location": "RoboEvony > City View",
        "icon": "🏰",
        "fields": {
            "cities": "City configurations",
            "index": "Selected city index",
            "goals": "City-specific goals",
        }
    },
    "settings.sol": {
        "description": "Application Settings",
        "location": "Flash Player Settings",
        "icon": "🔧",
        "fields": {
            "bandwidth": "Bandwidth settings",
            "defaultcamera": "Camera permissions",
            "defaultmicrophone": "Microphone permissions",
        }
    }
}

# ============================================================================
# TROOP TYPE CODES
# ============================================================================
TROOP_CODES: Dict[str, str] = {
    "wo": "Workers",
    "w": "Warriors", 
    "s": "Scouts",
    "p": "Pikemen",
    "sw": "Swordsmen",
    "a": "Archers",
    "c": "Cavalry",
    "cata": "Cataphracts",
    "t": "Transporters",
    "r": "Ram",
    "b": "Ballista",
    "cp": "Catapult"
}

# ============================================================================
# SERVER LIST
# ============================================================================
SERVERS: Dict[str, str] = {
    "cc2": "Parapet",
    "na1": "North America 1",
    "na2": "North America 2",
    "eu1": "Europe 1",
    "eu2": "Europe 2",
}
