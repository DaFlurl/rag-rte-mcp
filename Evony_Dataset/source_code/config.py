# Evony RE Hub Configuration
"""
Central configuration for the Evony RE Hub organization system.
Defines categories, file patterns, and organization rules.
"""

import os
from pathlib import Path
from typing import Dict, List, Set

# Base paths
HUB_ROOT = Path(r"c:\Users\Admin\Downloads\Evony_Decrypted")
DATA_INBOX = HUB_ROOT / "data"  # Drop files here for auto-organization
INDEX_DB = HUB_ROOT / "evony_hub" / "index.json"
CATALOG_FILE = HUB_ROOT / "CATALOG.md"

# External source locations to scan
EXTERNAL_SOURCES: List[Path] = [
    Path(r"D:\Svony_Studio"),
    Path(r"D:\Users\Admin\Desktop\evony_2024"),
    Path(r"G:\Evony_CentOS"),
    Path(r"G:\Local-Games-Projects\evony_scripts_collection"),
    Path(r"c:\Users\Admin\Documents\Windsurf_Projects\EvonyTools"),
]

# Category definitions with file patterns and keywords
CATEGORIES: Dict[str, dict] = {
    "docs": {
        "path": "Docs",
        "description": "Documentation, guides, and references",
        "extensions": [".md", ".txt", ".docx", ".pdf", ".rst"],
        "keywords": ["guide", "doc", "readme", "manual", "reference", "tutorial", "howto"],
        "subcategories": {
            "guides": ["guide", "tutorial", "howto", "walkthrough"],
            "protocols": ["protocol", "amf", "api", "spec"],
            "architecture": ["architecture", "design", "structure"],
            "analysis": ["analysis", "audit", "report", "review"],
        }
    },
    "scripts": {
        "path": "Scripts",
        "description": "Bot scripts, automation scripts, RoboEvony scripts",
        "extensions": [".txt", ".re", ".rob"],
        "keywords": ["script", "glitch", "attack", "spam", "farm", "quest", "troop"],
        "subcategories": {
            "glitch": ["glitch", "exploit", "overflow", "dupe"],
            "attack": ["attack", "spam", "raid", "war"],
            "farming": ["farm", "npc", "valley", "resource"],
            "automation": ["auto", "bot", "quest", "build"],
            "utility": ["util", "helper", "tool", "scan"],
        }
    },
    "tools": {
        "path": "Tools",
        "description": "RE tools, decompilers, analyzers, utilities",
        "extensions": [".py", ".ps1", ".bat", ".exe", ".jar"],
        "keywords": ["tool", "decompiler", "analyzer", "extractor", "decoder"],
        "subcategories": {
            "decompilers": ["decompil", "ffdec", "rabcdasm", "jpex"],
            "analyzers": ["analyz", "inspect", "parse", "decode"],
            "network": ["packet", "proxy", "intercept", "capture", "wireshark"],
            "memory": ["memory", "scan", "dump", "inject"],
            "crypto": ["crypto", "encrypt", "decrypt", "key", "hash"],
        }
    },
    "source": {
        "path": "Source",
        "description": "Decompiled source code, AS3, client code",
        "extensions": [".as", ".abc", ".swf", ".p", ".ps"],
        "keywords": ["source", "decompiled", "client", "as3", "actionscript"],
        "subcategories": {
            "client": ["client", "evonyclient", "game"],
            "bot": ["autoevony", "roboevony", "svony"],
            "libraries": ["lib", "util", "common", "shared"],
        }
    },
    "exploits": {
        "path": "Exploits",
        "description": "Exploits, glitches, vulnerabilities, bypasses",
        "extensions": [".py", ".txt", ".md", ".json"],
        "keywords": ["exploit", "glitch", "vuln", "bypass", "hack", "cheat"],
        "subcategories": {
            "troop_glitches": ["troop", "army", "soldier"],
            "resource_glitches": ["resource", "food", "gold", "lumber"],
            "protocol_exploits": ["protocol", "amf", "packet", "command"],
            "client_exploits": ["client", "memory", "injection"],
        }
    },
    "accounts": {
        "path": "Accounts",
        "description": "Account data, credentials, SOL files",
        "extensions": [".sol", ".json", ".txt", ".csv"],
        "keywords": ["account", "login", "credential", "session", "auth"],
        "subcategories": {
            "sol_files": [".sol"],
            "credentials": ["login", "pass", "cred", "auth"],
            "sessions": ["session", "cookie", "token"],
        }
    },
    "diagrams": {
        "path": "Diagrams",
        "description": "SVG diagrams, flowcharts, architecture visuals",
        "extensions": [".svg", ".png", ".jpg", ".gif", ".drawio", ".mermaid"],
        "keywords": ["diagram", "flowchart", "chart", "visual", "graph", "architecture"],
        "subcategories": {
            "architecture": ["architect", "structure", "system"],
            "protocol": ["protocol", "flow", "sequence"],
            "ui": ["ui", "screen", "interface", "mockup"],
        }
    },
    "keys": {
        "path": "Keys",
        "description": "Encryption keys, signatures, secrets",
        "extensions": [".py", ".json", ".txt", ".key"],
        "keywords": ["key", "secret", "encrypt", "signature", "hash", "xor"],
        "subcategories": {}
    },
    "data": {
        "path": "Data",
        "description": "Game data, configs, extracted assets",
        "extensions": [".json", ".xml", ".csv", ".xlsx", ".xls"],
        "keywords": ["data", "config", "asset", "map", "coord"],
        "subcategories": {
            "game_data": ["game", "troop", "building", "hero"],
            "maps": ["map", "coord", "location"],
            "configs": ["config", "setting", "option"],
        }
    },
    "libraries": {
        "path": "Libraries",
        "description": "AMF libraries, protocol libraries, utilities",
        "extensions": [".py", ".js", ".dll", ".jar"],
        "keywords": ["amf", "pyamf", "fluorine", "library", "lib"],
        "subcategories": {
            "amf": ["amf", "pyamf", "py3amf", "fluorine"],
            "network": ["socket", "http", "websocket"],
            "crypto": ["crypto", "cipher", "hash"],
        }
    },
    "bots": {
        "path": "Bots",
        "description": "Bot clients, automation frameworks",
        "extensions": [".py", ".exe", ".swf", ".js"],
        "keywords": ["bot", "autoevony", "roboevony", "svony", "automation"],
        "subcategories": {
            "clients": ["client", "gui", "interface"],
            "engines": ["engine", "core", "runtime"],
            "modules": ["module", "plugin", "extension"],
        }
    },
}

# File type mappings for quick categorization
EXTENSION_CATEGORIES: Dict[str, str] = {
    ".md": "docs",
    ".docx": "docs",
    ".pdf": "docs",
    ".txt": "scripts",  # Default, will be reclassified by content
    ".py": "tools",
    ".ps1": "tools",
    ".bat": "tools",
    ".exe": "tools",
    ".jar": "tools",
    ".as": "source",
    ".swf": "source",
    ".sol": "accounts",
    ".svg": "diagrams",
    ".png": "diagrams",
    ".json": "data",
    ".xml": "data",
    ".csv": "data",
    ".xlsx": "data",
}

# Keywords that indicate Evony-related content
EVONY_KEYWORDS: Set[str] = {
    "evony", "svony", "autoevony", "roboevony", "tkr", "tka",
    "age1", "age2", "troop", "archer", "cavalry", "catapult",
    "city", "valley", "npc", "barbarian", "hero", "mayor",
    "prestige", "medal", "alliance", "war", "attack", "defend",
    "glitch", "exploit", "amf", "actionscript", "flash", "swf",
    "food", "lumber", "stone", "iron", "gold", "resource",
    "quest", "commission", "gate", "fortification", "wall",
}

# Tools to download if missing
ESSENTIAL_TOOLS: Dict[str, dict] = {
    "ffdec": {
        "name": "JPEXS Free Flash Decompiler",
        "url": "https://github.com/jindrapetrik/jpexs-decompiler/releases",
        "description": "SWF decompiler and editor",
    },
    "rabcdasm": {
        "name": "RABCDAsm",
        "url": "https://github.com/ponysh/rabcdasm/releases",
        "description": "ActionScript 3 bytecode assembler/disassembler",
    },
    "ghidra": {
        "name": "Ghidra",
        "url": "https://ghidra-sre.org/",
        "description": "NSA reverse engineering framework",
    },
    "wireshark": {
        "name": "Wireshark",
        "url": "https://www.wireshark.org/download.html",
        "description": "Network protocol analyzer",
    },
    "dnspy": {
        "name": "dnSpy",
        "url": "https://github.com/dnSpy/dnSpy/releases",
        "description": ".NET debugger and assembly editor",
    },
}
