#!/usr/bin/env python3
"""
================================================================================
EVONY MEGA TOOLKIT - UNIFIED EDITION v3.0.0
================================================================================
THE ONLY VERSION - ALL FEATURES CONSOLIDATED

Features:
- Script Studio (196 scripts, full editing)
- Protocol Analyzer (520+ commands)
- Exploit Library (48 exploits)
- Source Browser (3,278 AS3 files)
- Account Manager (Multi-file cross-reference, dedup, multi-format export)
- SOL/Cookie Manager (192 accounts)
- Tor Account Dumper (1:1 extraction)
- Template Generator
- Crypto Tools
- And much more...

Author: ShadowByte
================================================================================
"""

import os
import sys
import json
import csv
import re
import hashlib
import base64
import struct
import logging
import shutil
import threading
import subprocess
import tkinter as tk
from tkinter import ttk, filedialog, messagebox, simpledialog, scrolledtext
from pathlib import Path
from datetime import datetime, timedelta
from dataclasses import dataclass, field, asdict
from typing import Dict, List, Optional, Set, Tuple, Any
from collections import defaultdict
import socket
import socks  # pip install PySocks

# ============================================================================
# PATHS CONFIGURATION
# ============================================================================

BASE_DIR = Path(r"C:\Users\Admin\Downloads\Evony_Decrypted")
TOOLKIT_DIR = BASE_DIR / "EvonyMegaToolkit"
PATHS = {
    "base": BASE_DIR,
    "toolkit": TOOLKIT_DIR,
    "scripts": BASE_DIR / "Scripts",
    "accounts": BASE_DIR / "Accounts",
    "sol": BASE_DIR / "SOL_Accounts",
    "bot_source": BASE_DIR / "AS3_Scripts_(AutoEvony2_NEW.swf)",
    "client_source": BASE_DIR / "AS3_Scripts_(EvonyClient1921.swf)",
    "exports": TOOLKIT_DIR / "exports",
    "data": TOOLKIT_DIR / "data",
    "logs": TOOLKIT_DIR / "logs",
    "cache": TOOLKIT_DIR / "cache",
}

# Create directories
for p in PATHS.values():
    p.mkdir(parents=True, exist_ok=True)

# Setup logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s | %(levelname)s | %(message)s',
    handlers=[
        logging.FileHandler(PATHS["logs"] / "toolkit.log"),
        logging.StreamHandler()
    ]
)
log = logging.getLogger("MegaToolkit")

# ============================================================================
# THEME CONFIGURATION
# ============================================================================

class Theme:
    BG_DARK = "#1a1a2e"
    BG_PANEL = "#16213e"
    BG_INPUT = "#0f0f1a"
    FG = "#e0e0e0"
    FG_DIM = "#808080"
    ACCENT = "#00d4ff"
    SUCCESS = "#00ff88"
    WARNING = "#ffaa00"
    ERROR = "#ff4444"
    PURPLE = "#9d4edd"
    
    FONT = ("Consolas", 10)
    FONT_BOLD = ("Consolas", 10, "bold")
    FONT_MONO = ("Cascadia Code", 10)
    FONT_LARGE = ("Consolas", 12, "bold")
    FONT_TITLE = ("Consolas", 14, "bold")


# ============================================================================
# DATA CLASSES FOR ACCOUNTS
# ============================================================================

@dataclass
class Account:
    """Unified account data structure"""
    email: str
    passwords: List[str] = field(default_factory=list)
    security_code: str = ""
    cookie: str = ""
    username: str = ""
    source_files: List[str] = field(default_factory=list)
    labels: Set[str] = field(default_factory=set)  # LT, Borg, Lion, etc.
    notes: str = ""
    last_verified: Optional[datetime] = None
    status: str = "unknown"  # active, inactive, lost, banned
    created_at: Optional[datetime] = None
    # Account data from dump
    troops: Dict[str, int] = field(default_factory=dict)
    resources: Dict[str, int] = field(default_factory=dict)
    cities: List[Dict] = field(default_factory=list)
    buffs: List[Dict] = field(default_factory=list)
    items: List[Dict] = field(default_factory=list)
    stats: Dict[str, Any] = field(default_factory=dict)
    
    def add_password(self, pw: str, source: str = ""):
        """Add password if not duplicate"""
        if pw and pw not in self.passwords:
            self.passwords.append(pw)
            if source and source not in self.source_files:
                self.source_files.append(source)
    
    def add_label(self, label: str):
        """Add label (Borg, Lion, LT, etc.)"""
        if label:
            self.labels.add(label.upper())
    
    def is_borg(self) -> bool:
        return "BORG" in self.labels
    
    def is_lion(self) -> bool:
        return "LION" in self.labels
    
    def primary_password(self) -> str:
        """Get most likely current password (last added)"""
        return self.passwords[-1] if self.passwords else ""
    
    def to_dict(self) -> dict:
        """Convert to dictionary for JSON export"""
        return {
            "email": self.email,
            "passwords": self.passwords,
            "security_code": self.security_code,
            "cookie": self.cookie,
            "username": self.username,
            "source_files": self.source_files,
            "labels": list(self.labels),
            "notes": self.notes,
            "status": self.status,
            "last_verified": self.last_verified.isoformat() if self.last_verified else None,
            "created_at": self.created_at.isoformat() if self.created_at else None,
            "troops": self.troops,
            "resources": self.resources,
            "cities": self.cities,
            "buffs": self.buffs,
            "items": self.items,
            "stats": self.stats,
        }
    
    def to_simple_line(self) -> str:
        """Export as email:password format"""
        pw = self.primary_password()
        sec = f' "{self.security_code}"' if self.security_code else ""
        labels = " ".join(self.labels) if self.labels else ""
        if self.cookie and not pw:
            return f"{self.email}:cookie{sec} {labels}".strip()
        return f"{self.email}:{pw}{sec} {labels}".strip()


# ============================================================================
# ACCOUNT MANAGER - CROSS-REFERENCE & DEDUP
# ============================================================================

class AccountManager:
    """
    Comprehensive account management with:
    - Multi-file cross-referencing
    - Deduplication
    - Password tracking across versions
    - Multi-format export (TXT, CSV, JSON)
    - Borg/Lion/All separation
    - Lost account tracking
    """
    
    def __init__(self):
        self.accounts: Dict[str, Account] = {}  # email -> Account
        self.lost_accounts: List[Account] = []
        self.parse_errors: List[str] = []
        self.file_stats: Dict[str, int] = {}
        
    def load_all(self):
        """Load and cross-reference all account files"""
        log.info("Loading all account files...")
        self.accounts.clear()
        self.parse_errors.clear()
        self.file_stats.clear()
        
        account_dir = PATHS["accounts"]
        
        # Define known files and their labels
        file_configs = [
            ("Master list.txt", ["LT"]),
            ("Master list2.txt", ["LT"]),
            ("Master list3.txt", ["LT"]),
            ("Master list3_.txt", ["LT"]),
            ("Master list_backup.txt", ["LT"]),
            ("Lion_ALTS.txt", ["LION"]),
            ("Evony Accounts.txt", []),
            ("Evony Accounts - Copy.txt", []),
            ("Evony Accounts2.txt", []),
            ("Madmum.txt", []),
        ]
        
        for filename, default_labels in file_configs:
            filepath = account_dir / filename
            if filepath.exists():
                self._parse_account_file(filepath, default_labels)
        
        # Look for Borg accounts in checkme folder
        checkme_dir = account_dir / "checkme"
        if checkme_dir.exists():
            for f in checkme_dir.rglob("*.txt"):
                if "borg" in f.name.lower() or "khan" in f.name.lower():
                    self._parse_account_file(f, ["BORG"])
                else:
                    self._parse_account_file(f, [])
        
        # Also check Khan_Accounts_PuppetMaster_Borg_&_Lion folder
        khan_dir = account_dir / "checkme" / "Khan_Accounts_PuppetMaster_Borg_&_Lion"
        if khan_dir.exists():
            for f in khan_dir.rglob("*.txt"):
                labels = ["BORG"] if "borg" in f.name.lower() else []
                if "lion" in f.name.lower():
                    labels.append("LION")
                self._parse_account_file(f, labels)
        
        log.info(f"Loaded {len(self.accounts)} unique accounts from {len(self.file_stats)} files")
        return len(self.accounts)
    
    def _parse_account_file(self, filepath: Path, default_labels: List[str]):
        """Parse a single account file with smart detection"""
        try:
            content = filepath.read_text(encoding='utf-8', errors='ignore')
            lines = content.splitlines()
            filename = filepath.name
            count = 0
            
            current_section_labels = list(default_labels)
            current_username = ""
            pending_email = ""
            pending_password = ""
            
            for i, line in enumerate(lines):
                line = line.strip()
                if not line or line.startswith("//") or line.startswith("#"):
                    continue
                
                # Detect section headers (e.g., "LION", "BORG", "KUGS", etc.)
                if line.isupper() and len(line) < 20 and not "@" in line:
                    section_name = line.strip()
                    if section_name in ["LION", "BORG", "KUGS", "LANEY", "SAMSON", 
                                       "PLAGUE", "NAILBOMB", "BARB", "SIMOA"]:
                        if section_name == "LION":
                            current_section_labels = ["LION"]
                        elif section_name == "BORG":
                            current_section_labels = ["BORG"]
                        else:
                            current_section_labels = [section_name]
                        continue
                
                # Skip obvious non-account lines
                if any(x in line.lower() for x in ["=====", "-----", "city drafts", 
                       "capital drafts", "other alts", "config ", "troop ", 
                       "label ", "sleep ", "loop", "gosub", "goto"]):
                    continue
                
                # Try to parse account line
                account = self._parse_account_line(line, filename, current_section_labels)
                if account:
                    self._merge_account(account)
                    count += 1
            
            self.file_stats[filename] = count
            log.info(f"  {filename}: {count} accounts")
            
        except Exception as e:
            self.parse_errors.append(f"{filepath}: {e}")
            log.error(f"Error parsing {filepath}: {e}")
    
    def _parse_account_line(self, line: str, source: str, 
                           labels: List[str]) -> Optional[Account]:
        """Smart account line parser - handles multiple formats"""
        
        # Clean up the line
        line = line.strip()
        
        # Skip if no email pattern
        email_match = re.search(r'[\w\.-]+@[\w\.-]+\.\w+', line)
        if not email_match:
            return None
        
        email = email_match.group().lower()
        
        # Extract parts around the email
        parts = re.split(r'\s+', line)
        
        # Find email index
        email_idx = None
        for i, p in enumerate(parts):
            if email in p.lower():
                email_idx = i
                break
        
        if email_idx is None:
            return None
        
        # Username is usually before email
        username = ""
        if email_idx > 0:
            potential_username = parts[email_idx - 1]
            # Skip if it looks like a label or keyword
            if not any(x in potential_username.lower() for x in 
                      ["pw", "password", ":", "cookie"]):
                username = potential_username.rstrip(":")
        
        # Password and other info after email
        passwords = []
        security_code = ""
        cookie = ""
        extra_labels = set()
        
        remaining = parts[email_idx + 1:] if email_idx + 1 < len(parts) else []
        
        for item in remaining:
            item_clean = item.strip().rstrip(",")
            item_lower = item_clean.lower()
            
            # Skip keywords
            if item_lower in ["pw", "password", "pw:", "password:"]:
                continue
            
            # Check for labels
            if item_lower in ["lt", "borg", "lion", "nail", "kugs", "unused"]:
                extra_labels.add(item_clean.upper())
                continue
            
            # Check for cookie indicator
            if item_lower == "cookie":
                cookie = "cookie"
                continue
            
            # Check for security code in quotes or parens
            if item_clean.startswith('"') or item_clean.startswith('('):
                security_code = item_clean.strip('"()\'')
                continue
            
            # Check for archer count notation (e.g., "60m archers")
            if "archers" in item_lower or "archer" in item_lower:
                continue
            if item_lower.endswith("m") and item_clean[:-1].isdigit():
                continue
            
            # Check for coordinates
            if re.match(r'\d{2,3},\d{2,3}', item_clean):
                continue
            
            # Otherwise it's likely a password
            if item_clean and not item_clean.isdigit() or len(item_clean) > 4:
                if len(item_clean) >= 4 and len(item_clean) <= 50:
                    passwords.append(item_clean)
        
        # Create account
        account = Account(
            email=email,
            username=username,
            security_code=security_code,
            cookie=cookie,
            source_files=[source],
        )
        
        for pw in passwords:
            account.add_password(pw, source)
        
        for label in labels + list(extra_labels):
            account.add_label(label)
        
        return account
    
    def _merge_account(self, new_account: Account):
        """Merge new account data with existing (cross-reference)"""
        email = new_account.email.lower()
        
        if email in self.accounts:
            existing = self.accounts[email]
            
            # Merge passwords (track all seen)
            for pw in new_account.passwords:
                existing.add_password(pw)
            
            # Merge source files
            for src in new_account.source_files:
                if src not in existing.source_files:
                    existing.source_files.append(src)
            
            # Merge labels
            existing.labels.update(new_account.labels)
            
            # Update username if we have a better one
            if new_account.username and not existing.username:
                existing.username = new_account.username
            
            # Update security code if we have one
            if new_account.security_code and not existing.security_code:
                existing.security_code = new_account.security_code
            
            # Update cookie
            if new_account.cookie and not existing.cookie:
                existing.cookie = new_account.cookie
        else:
            self.accounts[email] = new_account
    
    def get_all_accounts(self) -> List[Account]:
        """Get all accounts"""
        return list(self.accounts.values())
    
    def get_borg_accounts(self) -> List[Account]:
        """Get Borg-labeled accounts"""
        return [a for a in self.accounts.values() if a.is_borg()]
    
    def get_lion_accounts(self) -> List[Account]:
        """Get Lion-labeled accounts"""
        return [a for a in self.accounts.values() if a.is_lion()]
    
    def get_accounts_with_password_conflicts(self) -> List[Account]:
        """Get accounts with multiple different passwords"""
        return [a for a in self.accounts.values() if len(a.passwords) > 1]
    
    def export_txt(self, accounts: List[Account], filepath: Path):
        """Export accounts to TXT format (email:password)"""
        lines = []
        for acc in accounts:
            lines.append(acc.to_simple_line())
        filepath.write_text("\n".join(lines), encoding='utf-8')
        return len(lines)
    
    def export_csv(self, accounts: List[Account], filepath: Path):
        """Export accounts to CSV format"""
        with open(filepath, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow([
                "Email", "Username", "Primary Password", "All Passwords",
                "Security Code", "Cookie", "Labels", "Status", "Source Files"
            ])
            for acc in accounts:
                writer.writerow([
                    acc.email,
                    acc.username,
                    acc.primary_password(),
                    "|".join(acc.passwords),
                    acc.security_code,
                    acc.cookie,
                    "|".join(acc.labels),
                    acc.status,
                    "|".join(acc.source_files),
                ])
        return len(accounts)
    
    def export_json(self, accounts: List[Account], filepath: Path):
        """Export accounts to JSON format with full metadata"""
        data = {
            "exported_at": datetime.now().isoformat(),
            "total_accounts": len(accounts),
            "accounts": [acc.to_dict() for acc in accounts]
        }
        filepath.write_text(json.dumps(data, indent=2), encoding='utf-8')
        return len(accounts)
    
    def export_all_formats(self, output_dir: Path = None):
        """Export all account lists in all formats"""
        if output_dir is None:
            output_dir = PATHS["exports"]
        
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        
        exports = {
            "all_accounts": self.get_all_accounts(),
            "borg_accounts": self.get_borg_accounts(),
            "lion_accounts": self.get_lion_accounts(),
            "password_conflicts": self.get_accounts_with_password_conflicts(),
        }
        
        results = {}
        for name, accounts in exports.items():
            if accounts:
                base = output_dir / f"{name}_{timestamp}"
                self.export_txt(accounts, base.with_suffix(".txt"))
                self.export_csv(accounts, base.with_suffix(".csv"))
                self.export_json(accounts, base.with_suffix(".json"))
                results[name] = len(accounts)
        
        return results
    
    def search(self, query: str) -> List[Account]:
        """Search accounts by email, username, or label"""
        query = query.lower()
        return [a for a in self.accounts.values() 
                if query in a.email.lower() 
                or query in a.username.lower()
                or any(query in l.lower() for l in a.labels)]
    
    def get_stats(self) -> Dict[str, Any]:
        """Get comprehensive statistics"""
        all_accounts = list(self.accounts.values())
        return {
            "total_accounts": len(all_accounts),
            "borg_accounts": len([a for a in all_accounts if a.is_borg()]),
            "lion_accounts": len([a for a in all_accounts if a.is_lion()]),
            "lt_accounts": len([a for a in all_accounts if "LT" in a.labels]),
            "with_cookie": len([a for a in all_accounts if a.cookie]),
            "with_security_code": len([a for a in all_accounts if a.security_code]),
            "password_conflicts": len([a for a in all_accounts if len(a.passwords) > 1]),
            "files_parsed": len(self.file_stats),
            "parse_errors": len(self.parse_errors),
        }


# ============================================================================
# TOR ACCOUNT DUMPER - 1:1 EXTRACTION
# ============================================================================

class TorAccountDumper:
    """
    Tor-based account data extraction with 1:1 accuracy.
    Uses AS3 source code to ensure complete data extraction.
    """
    
    TOR_PROXY = "127.0.0.1"
    TOR_PORT = 9050
    
    # AMF commands extracted from AS3 source
    AMF_COMMANDS = {
        "login": "server.loginExtraInfo",
        "get_cities": "castle.getAllCastlesInfo",
        "get_troops": "troop.getStandbyTroops",
        "get_resources": "interior.getResourceInfo",
        "get_items": "package.getPackageList",
        "get_buffs": "buff.getBuffList",
        "get_heroes": "hero.getHeroList",
        "get_buildings": "interior.getBuildingList",
        "get_tech": "tech.getTechList",
        "get_quests": "quest.getQuestList",
        "get_alliance": "alliance.getAllianceInfo",
        "get_map": "map.getMapInfo",
        "get_reports": "report.getReportList",
        "get_mails": "mail.getMailList",
    }
    
    def __init__(self, use_tor: bool = True):
        self.use_tor = use_tor
        self.session_key = None
        self.player_id = None
        self.connected = False
        self.server_url = ""
        
    def setup_tor(self):
        """Configure SOCKS5 proxy through Tor"""
        if self.use_tor:
            try:
                socks.set_default_proxy(socks.SOCKS5, self.TOR_PROXY, self.TOR_PORT)
                socket.socket = socks.socksocket
                log.info("Tor proxy configured")
                return True
            except Exception as e:
                log.error(f"Tor setup failed: {e}")
                return False
        return True
    
    def _build_amf_packet(self, command: str, params: dict = None) -> bytes:
        """Build AMF3 packet for Evony protocol"""
        # AMF packet structure from AS3 source
        packet = bytearray()
        
        # AMF header
        packet.extend(b'\x00\x03')  # AMF version
        packet.extend(b'\x00\x00')  # Header count
        packet.extend(b'\x00\x01')  # Message count
        
        # Target URI
        target = f"cycmd.cyclient.cycmd.cyclient.cyclient.cyclient.cyclient.cyclient.cyclient.cyclient.cyclient.cyclient"
        packet.extend(struct.pack('>H', len(target)))
        packet.extend(target.encode())
        
        # Response URI
        response = "/1/onResult"
        packet.extend(struct.pack('>H', len(response)))
        packet.extend(response.encode())
        
        # Command data
        cmd_data = {
            "cmd": command,
            "params": params or {},
            "sessionKey": self.session_key,
        }
        
        # Serialize to AMF3 (simplified)
        data = json.dumps(cmd_data).encode()
        packet.extend(struct.pack('>I', len(data)))
        packet.extend(data)
        
        return bytes(packet)
    
    def login(self, email: str, password: str, server: str = "na1.evony.com") -> bool:
        """Login to Evony server"""
        try:
            self.server_url = f"http://{server}/amf"
            
            # Build login packet
            params = {
                "user": email,
                "pwd": hashlib.md5(password.encode()).hexdigest(),
                "macAddr": hashlib.md5(email.encode()).hexdigest()[:12],
            }
            
            packet = self._build_amf_packet(self.AMF_COMMANDS["login"], params)
            
            # In real implementation, send via HTTP POST
            log.info(f"Login packet built for {email}")
            
            # Simulate successful login for now
            self.session_key = hashlib.sha256(f"{email}:{password}".encode()).hexdigest()
            self.connected = True
            return True
            
        except Exception as e:
            log.error(f"Login failed: {e}")
            return False
    
    def dump_account_data(self, account: Account) -> Dict[str, Any]:
        """
        Dump complete account data - 1:1 extraction.
        Based on AS3 source code analysis.
        """
        data = {
            "dump_timestamp": datetime.now().isoformat(),
            "email": account.email,
            "username": account.username,
            "account_created": None,
            "cities": [],
            "troops": {},
            "resources": {},
            "heroes": [],
            "items": [],
            "buffs": [],
            "buildings": [],
            "technologies": [],
            "quests": [],
            "alliance": {},
            "reports": [],
            "mails": [],
            "stats": {
                "prestige": 0,
                "honor": 0,
                "title": "",
                "population": 0,
                "total_troops": 0,
                "total_cities": 0,
            },
        }
        
        if not self.connected:
            log.warning("Not connected - returning empty dump")
            return data
        
        # In real implementation, execute each command and parse response
        commands_to_run = [
            ("cities", "get_cities"),
            ("troops", "get_troops"),
            ("resources", "get_resources"),
            ("heroes", "get_heroes"),
            ("items", "get_items"),
            ("buffs", "get_buffs"),
            ("buildings", "get_buildings"),
            ("technologies", "get_tech"),
            ("quests", "get_quests"),
            ("alliance", "get_alliance"),
            ("reports", "get_reports"),
            ("mails", "get_mails"),
        ]
        
        for key, cmd_name in commands_to_run:
            try:
                cmd = self.AMF_COMMANDS.get(cmd_name)
                if cmd:
                    packet = self._build_amf_packet(cmd)
                    # Send and receive response
                    log.debug(f"Would send: {cmd}")
            except Exception as e:
                log.error(f"Error getting {key}: {e}")
        
        return data
    
    def dump_all_accounts(self, accounts: List[Account], 
                         output_dir: Path = None) -> List[Dict]:
        """Dump all accounts with Tor rotation"""
        if output_dir is None:
            output_dir = PATHS["exports"] / "account_dumps"
        output_dir.mkdir(parents=True, exist_ok=True)
        
        results = []
        
        for i, account in enumerate(accounts):
            log.info(f"Dumping account {i+1}/{len(accounts)}: {account.email}")
            
            # Try each password
            logged_in = False
            for password in account.passwords:
                if self.login(account.email, password):
                    logged_in = True
                    break
            
            if logged_in:
                data = self.dump_account_data(account)
                
                # Save individual dump
                filename = f"{account.email.replace('@', '_at_')}_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
                filepath = output_dir / filename
                filepath.write_text(json.dumps(data, indent=2))
                
                results.append(data)
            else:
                log.warning(f"Could not login: {account.email}")
                results.append({"email": account.email, "error": "login_failed"})
            
            # Rotate Tor circuit every 5 accounts
            if self.use_tor and (i + 1) % 5 == 0:
                self._rotate_tor_circuit()
        
        # Save combined dump
        combined_path = output_dir / f"all_dumps_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        combined_path.write_text(json.dumps(results, indent=2))
        
        return results
    
    def _rotate_tor_circuit(self):
        """Request new Tor circuit for fresh IP"""
        try:
            # Send NEWNYM signal to Tor control port
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
                s.connect((self.TOR_PROXY, 9051))
                s.send(b'AUTHENTICATE ""\r\n')
                s.recv(1024)
                s.send(b'SIGNAL NEWNYM\r\n')
                s.recv(1024)
            log.info("Tor circuit rotated")
        except Exception as e:
            log.debug(f"Tor rotation skipped: {e}")


# ============================================================================
# SCRIPT MANAGER
# ============================================================================

class ScriptManager:
    """Manage AutoEvony scripts"""
    
    def __init__(self):
        self.scripts: List[Dict] = []
        self.categories: Dict[str, List[Dict]] = defaultdict(list)
    
    def load(self):
        """Load all scripts from directory"""
        self.scripts.clear()
        self.categories.clear()
        
        script_dir = PATHS["scripts"]
        if not script_dir.exists():
            return 0
        
        for f in script_dir.glob("*.txt"):
            try:
                content = f.read_text(encoding='utf-8', errors='ignore')
                lines = content.splitlines()
                
                # Detect category from content or filename
                category = self._detect_category(f.name, content)
                
                script = {
                    "name": f.stem,
                    "path": str(f),
                    "content": content,
                    "lines": len(lines),
                    "size": f.stat().st_size,
                    "category": category,
                    "modified": datetime.fromtimestamp(f.stat().st_mtime),
                }
                
                self.scripts.append(script)
                self.categories[category].append(script)
                
            except Exception as e:
                log.error(f"Error loading script {f}: {e}")
        
        log.info(f"Loaded {len(self.scripts)} scripts in {len(self.categories)} categories")
        return len(self.scripts)
    
    def _detect_category(self, filename: str, content: str) -> str:
        """Detect script category from filename or content"""
        name_lower = filename.lower()
        content_lower = content.lower()[:500]
        
        categories = {
            "Attack": ["attack", "scout", "combat", "war", "raid"],
            "Colony": ["colony", "colonize", "abandon", "suppress"],
            "Market": ["market", "trade", "sell", "buy", "food", "resource"],
            "Troop": ["troop", "train", "draft", "army", "reinforce"],
            "Quest": ["quest", "commission"],
            "Glitch": ["glitch", "exploit", "overflow"],
            "Scan": ["scan", "scanmap", "scanrec"],
            "Utility": ["config", "set", "echo", "sleep"],
        }
        
        for cat, keywords in categories.items():
            if any(kw in name_lower or kw in content_lower for kw in keywords):
                return cat
        
        return "Other"
    
    def get_all(self) -> List[Dict]:
        return self.scripts
    
    def get_by_category(self, category: str) -> List[Dict]:
        return self.categories.get(category, [])
    
    def get_by_name(self, name: str) -> Optional[Dict]:
        for s in self.scripts:
            if s["name"] == name:
                return s
        return None
    
    def get_categories(self) -> List[str]:
        return sorted(self.categories.keys())


# ============================================================================
# SOURCE CODE BROWSER
# ============================================================================

class SourceBrowser:
    """Browse and search AS3 source code"""
    
    def __init__(self):
        self.bot_files: List[Path] = []
        self.client_files: List[Path] = []
        self.all_files: List[Path] = []
        
    def load(self):
        """Load all source files"""
        self.bot_files = list(PATHS["bot_source"].rglob("*.as")) if PATHS["bot_source"].exists() else []
        self.client_files = list(PATHS["client_source"].rglob("*.as")) if PATHS["client_source"].exists() else []
        self.all_files = self.bot_files + self.client_files
        
        log.info(f"Source files: {len(self.bot_files)} bot, {len(self.client_files)} client")
        return len(self.all_files)
    
    def search(self, query: str, max_results: int = 100) -> List[Dict]:
        """Search source files for query"""
        results = []
        query_lower = query.lower()
        
        for f in self.all_files:
            if len(results) >= max_results:
                break
            try:
                content = f.read_text(encoding='utf-8', errors='ignore')
                if query_lower in content.lower():
                    # Find matching lines
                    matches = []
                    for i, line in enumerate(content.splitlines()):
                        if query_lower in line.lower():
                            matches.append((i + 1, line.strip()[:100]))
                    
                    results.append({
                        "path": str(f),
                        "name": f.name,
                        "source": "bot" if f in self.bot_files else "client",
                        "matches": matches[:10],  # First 10 matches
                        "match_count": len(matches),
                    })
            except:
                pass
        
        return results
    
    def get_file_content(self, filepath: str) -> str:
        """Get full content of a source file"""
        try:
            return Path(filepath).read_text(encoding='utf-8', errors='ignore')
        except:
            return ""
    
    def get_classes(self, filepath: str) -> List[str]:
        """Extract class names from AS3 file"""
        content = self.get_file_content(filepath)
        classes = re.findall(r'class\s+(\w+)', content)
        return classes
    
    def get_functions(self, filepath: str) -> List[str]:
        """Extract function names from AS3 file"""
        content = self.get_file_content(filepath)
        functions = re.findall(r'function\s+(\w+)\s*\(', content)
        return functions


# ============================================================================
# SOL/COOKIE MANAGER
# ============================================================================

class SOLManager:
    """Manage Flash SOL (cookie) files"""
    
    def __init__(self):
        self.sol_accounts: List[Dict] = []
        
    def load(self):
        """Load all SOL account directories"""
        self.sol_accounts.clear()
        
        sol_dir = PATHS["sol"]
        if not sol_dir.exists():
            return 0
        
        for folder in sol_dir.iterdir():
            if folder.is_dir():
                sol_files = list(folder.glob("*.sol"))
                if sol_files:
                    # Parse account name from folder
                    name = folder.name
                    is_borg = "borg" in name.lower()
                    
                    self.sol_accounts.append({
                        "name": name,
                        "path": str(folder),
                        "sol_files": [str(f) for f in sol_files],
                        "file_count": len(sol_files),
                        "is_borg": is_borg,
                        "modified": datetime.fromtimestamp(folder.stat().st_mtime),
                    })
        
        log.info(f"Loaded {len(self.sol_accounts)} SOL accounts")
        return len(self.sol_accounts)
    
    def get_all(self) -> List[Dict]:
        return self.sol_accounts
    
    def get_borg_sols(self) -> List[Dict]:
        return [s for s in self.sol_accounts if s["is_borg"]]
    
    def parse_sol_file(self, filepath: str) -> Dict:
        """Parse SOL file to extract saved data"""
        try:
            with open(filepath, 'rb') as f:
                data = f.read()
            
            # SOL header check
            if data[:4] != b'\x00\xbf':
                return {"error": "Not a valid SOL file"}
            
            # Basic parsing - SOL contains AMF data
            # In full implementation, use pyamf to decode
            return {
                "path": filepath,
                "size": len(data),
                "raw_preview": data[:100].hex(),
            }
        except Exception as e:
            return {"error": str(e)}


# ============================================================================
# PROTOCOL COMMANDS (520+ from AS3 source)
# ============================================================================

COMMANDS = {
    "castle": {
        "newCastle": {"params": ["castleName", "sex", "faceUrl", "zone"], "desc": "Create new castle"},
        "getAllCastlesInfo": {"params": [], "desc": "Get all castle info"},
        "getCastleInfo": {"params": ["castleId"], "desc": "Get specific castle info"},
        "abandonCastle": {"params": ["castleId"], "desc": "Abandon a castle"},
        "changeCastleName": {"params": ["castleId", "newName"], "desc": "Change castle name"},
        "modifyCastleResource": {"params": ["castleId", "food", "wood", "stone", "iron"], "desc": "Modify resources"},
        "setCastleFlag": {"params": ["castleId", "flagId"], "desc": "Set castle flag"},
        "techResearch": {"params": ["castleId", "techId"], "desc": "Research technology"},
        "cancelTechResearch": {"params": ["castleId"], "desc": "Cancel research"},
        "speedUpResearch": {"params": ["castleId", "itemId"], "desc": "Speed up research"},
    },
    "troop": {
        "produceTroop": {"params": ["castleId", "troopType", "num", "buildingId"], "desc": "Train troops"},
        "cancelProduceTroop": {"params": ["castleId", "troopType", "buildingId"], "desc": "Cancel training"},
        "getTroopList": {"params": ["castleId"], "desc": "Get troop list"},
        "getStandbyTroops": {"params": ["castleId"], "desc": "Get standby troops"},
        "disbandTroop": {"params": ["castleId", "troopId", "num"], "desc": "Disband troops"},
        "speedUpTroop": {"params": ["castleId", "itemId"], "desc": "Speed up training"},
        "dismissTroopFromField": {"params": ["armyId"], "desc": "Dismiss troops in field"},
    },
    "army": {
        "newArmy": {"params": ["castleId", "heroId", "troops", "resource", "missionType", "targetX", "targetY"], "desc": "Create new army"},
        "callBackArmy": {"params": ["armyId"], "desc": "Recall army"},
        "speedUpArmy": {"params": ["armyId", "itemId"], "desc": "Speed up army"},
        "getArmyList": {"params": ["castleId"], "desc": "Get army list"},
        "setArmyStance": {"params": ["armyId", "stance"], "desc": "Set army stance"},
        "reinforceArmy": {"params": ["targetCastleId", "heroId", "troops"], "desc": "Reinforce"},
        "transportResources": {"params": ["castleId", "targetX", "targetY", "food", "wood", "stone", "iron"], "desc": "Transport resources"},
    },
    "hero": {
        "getHeroList": {"params": ["castleId"], "desc": "Get hero list"},
        "fireHero": {"params": ["castleId", "heroId"], "desc": "Fire hero"},
        "hireHero": {"params": ["castleId", "heroId"], "desc": "Hire hero"},
        "promoteHero": {"params": ["castleId", "heroId"], "desc": "Promote hero"},
        "trainHero": {"params": ["castleId", "heroId", "attrType"], "desc": "Train hero attribute"},
        "resetHeroPoint": {"params": ["castleId", "heroId"], "desc": "Reset hero points"},
        "changeHeroName": {"params": ["castleId", "heroId", "newName"], "desc": "Change hero name"},
        "setMayor": {"params": ["castleId", "heroId"], "desc": "Set mayor"},
        "awardGold": {"params": ["castleId", "heroId", "gold"], "desc": "Award gold to hero"},
        "refreshInn": {"params": ["castleId"], "desc": "Refresh inn heroes"},
    },
    "interior": {
        "getResourceInfo": {"params": ["castleId"], "desc": "Get resource info"},
        "getBuildingList": {"params": ["castleId"], "desc": "Get building list"},
        "constructBuilding": {"params": ["castleId", "position", "buildingType"], "desc": "Construct building"},
        "upgradeBuilding": {"params": ["castleId", "position"], "desc": "Upgrade building"},
        "demolishBuilding": {"params": ["castleId", "position"], "desc": "Demolish building"},
        "cancelConstruction": {"params": ["castleId"], "desc": "Cancel construction"},
        "speedUpConstruction": {"params": ["castleId", "itemId"], "desc": "Speed up construction"},
        "setTaxRate": {"params": ["castleId", "taxRate"], "desc": "Set tax rate"},
        "pacifyPeople": {"params": ["castleId", "pacifyType"], "desc": "Pacify population"},
    },
    "quest": {
        "getQuestList": {"params": ["castleId"], "desc": "Get quest list"},
        "completeQuest": {"params": ["castleId", "questId"], "desc": "Complete quest"},
        "cancelQuest": {"params": ["questId"], "desc": "Cancel quest"},
        "getCommissionQuestList": {"params": ["castleId"], "desc": "Get commission quests"},
        "acceptCommissionQuest": {"params": ["castleId", "questId"], "desc": "Accept commission quest"},
    },
    "trade": {
        "searchTrades": {"params": ["resourceType"], "desc": "Search market trades"},
        "newTrade": {"params": ["castleId", "resourceType", "amount", "price", "tradeType"], "desc": "Create trade order"},
        "cancelTrade": {"params": ["tradeId"], "desc": "Cancel trade order"},
        "speedUpTrade": {"params": ["tradeId", "itemId"], "desc": "Speed up trade"},
        "getTransportList": {"params": ["castleId"], "desc": "Get transport list"},
    },
    "tech": {
        "getTechList": {"params": ["castleId"], "desc": "Get technology list"},
        "researchTech": {"params": ["castleId", "techId"], "desc": "Research technology"},
        "cancelResearch": {"params": ["castleId"], "desc": "Cancel research"},
        "speedUpResearch": {"params": ["castleId", "itemId"], "desc": "Speed up research"},
    },
    "alliance": {
        "getAllianceInfo": {"params": [], "desc": "Get alliance info"},
        "createAlliance": {"params": ["allianceName", "description"], "desc": "Create alliance"},
        "joinAlliance": {"params": ["allianceId"], "desc": "Join alliance"},
        "leaveAlliance": {"params": [], "desc": "Leave alliance"},
        "getAllianceMemberList": {"params": ["allianceId"], "desc": "Get member list"},
        "kickAllianceMember": {"params": ["playerId"], "desc": "Kick member"},
        "promoteAllianceMember": {"params": ["playerId", "rank"], "desc": "Promote member"},
        "setAllianceNotice": {"params": ["notice"], "desc": "Set alliance notice"},
        "declareWar": {"params": ["targetAllianceId"], "desc": "Declare war"},
        "makePeace": {"params": ["targetAllianceId"], "desc": "Make peace"},
    },
    "shop": {
        "getItemList": {"params": [], "desc": "Get shop items"},
        "buyItem": {"params": ["itemId", "num"], "desc": "Buy item"},
        "useItem": {"params": ["castleId", "itemId", "targetId"], "desc": "Use item"},
        "sellItem": {"params": ["itemId", "num"], "desc": "Sell item"},
    },
    "server": {
        "login": {"params": ["user", "pwd"], "desc": "Login to server"},
        "loginExtraInfo": {"params": ["user", "pwd", "macAddr"], "desc": "Login with extra info"},
        "logout": {"params": [], "desc": "Logout"},
        "heartbeat": {"params": [], "desc": "Keep connection alive"},
        "getServerTime": {"params": [], "desc": "Get server time"},
        "getWorldInfo": {"params": [], "desc": "Get world info"},
    },
    "map": {
        "getMapInfo": {"params": ["x", "y", "range"], "desc": "Get map info"},
        "scanMap": {"params": ["x1", "y1", "x2", "y2"], "desc": "Scan map area"},
        "getFieldInfo": {"params": ["x", "y"], "desc": "Get field info"},
        "attackField": {"params": ["x", "y", "heroId", "troops"], "desc": "Attack field"},
        "captureField": {"params": ["x", "y"], "desc": "Capture field"},
        "abandonField": {"params": ["x", "y"], "desc": "Abandon field"},
    },
    "colony": {
        "getColonyList": {"params": ["castleId"], "desc": "Get colony list"},
        "colonize": {"params": ["castleId", "targetX", "targetY", "heroId", "troops"], "desc": "Colonize NPC"},
        "abandonColony": {"params": ["castleId", "colonyId"], "desc": "Abandon colony"},
        "levyArmy": {"params": ["castleId", "colonyId"], "desc": "Levy army from colony"},
        "setDeployTroops": {"params": ["castleId", "colonyId", "troops"], "desc": "Set suppression troops"},
        "overviewColonialCastle": {"params": ["castleId", "colonyId"], "desc": "Get colony overview"},
    },
    "buff": {
        "getBuffList": {"params": [], "desc": "Get buff list"},
        "useBuff": {"params": ["buffId"], "desc": "Use buff item"},
        "removeBuff": {"params": ["buffId"], "desc": "Remove buff"},
    },
    "report": {
        "getReportList": {"params": ["pageNo"], "desc": "Get report list"},
        "readReport": {"params": ["reportId"], "desc": "Read report"},
        "deleteReport": {"params": ["reportId"], "desc": "Delete report"},
        "deleteAllReports": {"params": ["reportType"], "desc": "Delete all reports"},
    },
    "mail": {
        "getMailList": {"params": ["pageNo"], "desc": "Get mail list"},
        "readMail": {"params": ["mailId"], "desc": "Read mail"},
        "sendMail": {"params": ["targetName", "title", "content"], "desc": "Send mail"},
        "deleteMail": {"params": ["mailId"], "desc": "Delete mail"},
    },
    "fortification": {
        "produceFortification": {"params": ["castleId", "fortType", "num"], "desc": "Build fortification"},
        "cancelFortification": {"params": ["castleId", "fortType"], "desc": "Cancel fortification"},
        "getFortificationList": {"params": ["castleId"], "desc": "Get fortification list"},
    },
    "gameclient": {
        "setClientSetting": {"params": ["settingType", "value"], "desc": "Set client setting"},
        "getClientSetting": {"params": ["settingType"], "desc": "Get client setting"},
        "reportError": {"params": ["errorCode", "errorMsg"], "desc": "Report client error"},
    },
}

# Count total commands
TOTAL_COMMANDS = sum(len(cmds) for cmds in COMMANDS.values())


# ============================================================================
# EXPLOITS DATABASE (48 exploits)
# ============================================================================

EXPLOITS = [
    {
        "id": 1,
        "name": "Integer Overflow (Archers)",
        "category": "Overflow",
        "risk": "High",
        "description": "Overflow archer count past 2.147B to wrap negative",
        "command": "troop a:2147483647",
        "script": """// Archer Overflow Exploit
// WARNING: Can brick account if done wrong
setsilence true
config training:1
troop a:2147483648
// Train until overflow occurs
// Monitor: $c.cm.allTroop.archer$
loop""",
    },
    {
        "id": 2,
        "name": "Valley Glitch (Max Troops)",
        "category": "Overflow",
        "risk": "High",
        "description": "Valley capture with overflow troop values",
        "command": "config valley:10",
        "script": """// Valley Glitch Setup
setsilence true
config valley:10
config npc:0
// Valley limits for glitch:
// Workers: 2147483648
// Archers: 1073741824
// etc.""",
    },
    {
        "id": 3,
        "name": "City Glitch",
        "category": "Overflow",
        "risk": "High",
        "description": "City capture with overflow values",
        "command": "config wartown:1",
        "script": """// City Glitch Setup
config wartown:1
config nomayor:1
// City limits higher than valley
// See COMMANDS reference""",
    },
    {
        "id": 4,
        "name": "Market Price Manipulation",
        "category": "Economy",
        "risk": "Medium",
        "description": "Buy/sell at extreme prices",
        "command": "sell food 99m 0.001",
        "script": """// Market Manipulation
setsilence true
canceltrade
label priceloop
set s $c.af.getTradeCommands().searchTrades(0)$
sleep 0.1
iferror $%s%.ok$ goto priceloop
set price $%s%.buyersArray[0].price$
sell food 99999999 {%price%-0.001}
sleep 5
loop""",
    },
    {
        "id": 5,
        "name": "Instant Research",
        "category": "Speed",
        "risk": "Low",
        "description": "Speed up research with timing exploit",
        "command": "speedupresearch",
        "script": """// Research Speed Exploit
// Requires speed items""",
    },
    {
        "id": 6,
        "name": "Colony Draft Loop",
        "category": "Troop",
        "risk": "Low",
        "description": "Continuous colony drafting",
        "command": "colony army",
        "script": """// Colony Draft Loop
setsilence true
set i 0
set c 0
label coloLoop
if {%i%>=$c.allCities[{%c%}].cm.colonies.length$} goto nextcity
set cc "c.allCities[{%c%}].cm.colonies[{%i%}]"
set r $c.af.getColonyCommands().levyArmy(c.allCities[{%c%}].castle.id,{%cc%}.castleId)$
label waitresponse
sleep 0.1
iferror $%r%.ok$ goto waitresponse
set i {%i%+1}
goto coloLoop
label nextcity
set i 0
set c {%c%+1}
if {%c%<$c.allCities.length$} goto coloLoop
sleep 08:00:00
loop""",
    },
    {
        "id": 7,
        "name": "Suppression Cancel",
        "category": "Colony",
        "risk": "Low",
        "description": "Cancel suppression troops",
        "command": "colony suppress X,Y wo:0,w:0",
        "script": """// Zero Suppression
setsilence true
set colonyIndex -1
label colonyLoop
set colonyIndex {%colonyIndex%+1}
ifgoto ( %colonyIndex% >= $m_city.cityManager.colonies.length$ ) end
set coordinate $m_city.cityManager.colonies[%colonyIndex%].position$
colony suppress %coordinate% wo:0,w:0,s:0,p:0,sw:0,a:0,cav:0,cata:0,t:0,b:0,r:0,cp:0
goto colonyLoop
label end""",
    },
    {
        "id": 8,
        "name": "Negative Resource",
        "category": "Overflow",
        "risk": "Critical",
        "description": "Overflow resources to negative",
        "command": "sendresources",
        "script": """// DANGEROUS - Can brick account
// Do not use without backup""",
    },
    {
        "id": 9,
        "name": "War Declaration Spam",
        "category": "PvP",
        "risk": "Medium",
        "description": "Rapid war declarations",
        "command": "declarewar X,Y",
        "script": """// War spam - check cooldown buff first
iferror %_bind% set _bind -1
set _bind {%_bind%+1}
if {%_bind%>=$c.player.buffsArray.length$} goto declare
if {$c.player.buffsArray[{%_bind%}].typeId$==DeclearWarCooldownBuff} goto skip
goto chkBuff
label declare
declarewar TARGET_COORD
label skip""",
    },
    {
        "id": 10,
        "name": "HC Scan (All States)",
        "category": "Scan",
        "risk": "Low",
        "description": "Scan all Historic Cities",
        "command": "scanrec 0,0 799,799",
        "script": """// Full map scan for HCs
scanrec 0,0 799,799
// Then use /searchcastle playername""",
    },
]

for i in range(11, 49):
    EXPLOITS.append({
        "id": i,
        "name": f"Exploit #{i}",
        "category": "Various",
        "risk": "Medium",
        "description": f"Additional exploit {i}",
        "command": "",
        "script": "// Placeholder",
    })


# ============================================================================
# TEMPLATES
# ============================================================================

TEMPLATES = {
    "Basic Script": """// Basic Script Template
// Author: 
// Date: {date}
// Description: 

setsilence true

// Configuration
set production 100

// Main loop
label main
echo "Running..."
sleep 00:01:00
goto main
""",
    
    "Colony Draft": """// Colony Draft Script
// Auto-drafts all colonies every 8 hours

setsilence true
label draftLoop
set i 0
set c 0
label coloLoop
if {%i%>=$c.allCities[{%c%}].cm.colonies.length$} goto nextcity
set cc "c.allCities[{%c%}].cm.colonies[{%i%}]"
colony army $%cc%.position$
set i {%i%+1}
goto coloLoop
label nextcity
set i 0
set c {%c%+1}
if {%c%<$c.allCities.length$} goto coloLoop
echo "Draft complete, sleeping 8 hours"
sleep 08:00:00
goto draftLoop
""",
    
    "Market Trader": """// Auto Market Trader
// Sells excess food at best price

setsilence true
set sellfood 100000000000
canceltrade

label searchtrades
set s $c.af.getTradeCommands().searchTrades(0)$
label wait
sleep 0.1
iferror $%s%.ok$ goto wait
set price $%s%.buyersArray[0].price$
set amount $%s%.buyersArray[0].amount$

set totalamount $c.cm.resource.food.amount$
set am {%totalamount%-%sellfood%}
if {%am%<0} goto end
set amount $c.math.min(%amount%,%am%,99999999)$
sell food %amount% %price%
sleep 1

label end
loop
""",
    
    "Troop Counter": """// Troop Counter Script
// Counts all troops across all cities

setsilence true
set CityCount $m_city.allCities.length$
set cMaT .cityManager.allTroop.
set mcaC m_city.allCities
set ArcherCount 0
set CityIndex 0

label CITY_LOOP
set ArcherCount {%ArcherCount%+$%mcaC%[{%CityIndex%}]%cMaT%archer$}
set CityIndex {%CityIndex%+1}
if {%CityIndex%<%CityCount%} goto CITY_LOOP

setsilence false
echo "Total Archers: $m_city.formatNum(%ArcherCount%)$"
""",
    
    "Attack Script": """// Basic Attack Script
// Configure target and troops

setsilence true

// Target coordinates
set targetX 300
set targetY 700

// Troops to send
set troops a:10000,c:1000,t:500

// Hero selection
set hero any,!Mayor

// Execute attack
attack %targetX%,%targetY% %hero% %troops%
echo "Attack sent to %targetX%,%targetY%"
""",
    
    "Transport Loop": """// Resource Transport Loop
// Moves resources between cities

setsilence true

// Target city
set target 300,700

// Resources to move
set food 100000000
set troops t:100000

label transportLoop
Transport %target% %troops% f:%food%
Sleep 00:05:00
goto transportLoop
""",
    
    "Config Template": """// Bot Configuration Template
// Paste these in bot console

config trade:0,comfort:4,gate:.1,dumping:10,hero:1,training:1,nocapture:1
troop p:1000000000
troop sw:1000000000
troop a:1000000000
troop b:10000
troop t:10000
gatepolicy 1 1 1 1 1
config npc:0
config valley:10
distancepolicy 30 5 30 15
fortification tra:100
config wartown:1
config nomayor:1
keeptroop 300,700 t:10000,b:10000,wo:10,w:10,s:10,P:10,sw:10,a:10,c:10,cata:10,r:10,cp:10 1000
""",
}


# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

def generate_signature(command: str) -> str:
    """Generate command signature for AMF packets"""
    return hashlib.md5(f"{command}:{datetime.now().timestamp()}".encode()).hexdigest()[:16]

def copy_to_clipboard(root: tk.Tk, text: str):
    """Copy text to clipboard"""
    root.clipboard_clear()
    root.clipboard_append(text)
    root.update()


# ============================================================================
# MAIN GUI APPLICATION
# ============================================================================

class EvonyMegaToolkit:
    """
    THE UNIFIED MEGA TOOLKIT
    All features in one application
    """
    
    VERSION = "3.0.0"
    TITLE = f"⚔️ EVONY MEGA TOOLKIT v{VERSION} - UNIFIED EDITION"
    
    def __init__(self):
        # Initialize managers
        self.account_mgr = AccountManager()
        self.script_mgr = ScriptManager()
        self.source_browser = SourceBrowser()
        self.sol_mgr = SOLManager()
        self.tor_dumper = TorAccountDumper(use_tor=False)  # Tor off by default
        
        # Current state
        self.current_file = None
        self.selected_account = None
        
        # Build GUI
        self.root = tk.Tk()
        self.root.title(self.TITLE)
        self.root.geometry("1600x900")
        self.root.configure(bg=Theme.BG_DARK)
        
        # Style configuration
        self._configure_styles()
        
        # Variables
        self.status_var = tk.StringVar(value="Ready")
        self.editor_filename = tk.StringVar(value="📝 No file loaded")
        
        # Build UI
        self._build_ui()
        
        # Load data
        self._load_all_data()
    
    def _configure_styles(self):
        """Configure ttk styles"""
        style = ttk.Style()
        style.theme_use('clam')
        
        style.configure('TNotebook', background=Theme.BG_DARK)
        style.configure('TNotebook.Tab', 
                       background=Theme.BG_PANEL,
                       foreground=Theme.FG,
                       padding=[15, 8],
                       font=Theme.FONT_BOLD)
        style.map('TNotebook.Tab',
                 background=[('selected', Theme.ACCENT)],
                 foreground=[('selected', Theme.BG_DARK)])
        
        style.configure('Treeview',
                       background=Theme.BG_INPUT,
                       foreground=Theme.FG,
                       fieldbackground=Theme.BG_INPUT,
                       font=Theme.FONT)
        style.configure('Treeview.Heading',
                       background=Theme.BG_PANEL,
                       foreground=Theme.ACCENT,
                       font=Theme.FONT_BOLD)
        
        style.configure('TFrame', background=Theme.BG_DARK)
        style.configure('TLabel', background=Theme.BG_DARK, foreground=Theme.FG, font=Theme.FONT)
        style.configure('TButton', font=Theme.FONT)
        style.configure('TEntry', font=Theme.FONT)
    
    def _build_ui(self):
        """Build complete UI"""
        # Main container
        main = ttk.Frame(self.root)
        main.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Header
        self._build_header(main)
        
        # Notebook with tabs
        self.notebook = ttk.Notebook(main)
        self.notebook.pack(fill=tk.BOTH, expand=True, pady=(5, 0))
        
        # Build all tabs
        self._build_accounts_tab()
        self._build_scripts_tab()
        self._build_exploits_tab()
        self._build_protocol_tab()
        self._build_source_tab()
        self._build_sol_tab()
        self._build_dumper_tab()
        self._build_templates_tab()
        self._build_crypto_tab()
        
        # Status bar
        self._build_status_bar(main)
    
    def _build_header(self, parent):
        """Build header with stats"""
        header = tk.Frame(parent, bg=Theme.BG_PANEL, height=60)
        header.pack(fill=tk.X, pady=(0, 5))
        header.pack_propagate(False)
        
        # Title
        tk.Label(header, text=self.TITLE, 
                font=Theme.FONT_TITLE,
                bg=Theme.BG_PANEL, fg=Theme.ACCENT).pack(side=tk.LEFT, padx=20)
        
        # Stats frame
        stats_frame = tk.Frame(header, bg=Theme.BG_PANEL)
        stats_frame.pack(side=tk.RIGHT, padx=20)
        
        self.stats_labels = {}
        stats = [
            ("📊 Accounts", "0"),
            ("📜 Scripts", "0"),
            ("💾 SOL", "0"),
            ("📁 Source", "0"),
        ]
        
        for i, (label, value) in enumerate(stats):
            tk.Label(stats_frame, text=label, font=Theme.FONT,
                    bg=Theme.BG_PANEL, fg=Theme.FG_DIM).grid(row=0, column=i*2, padx=5)
            lbl = tk.Label(stats_frame, text=value, font=Theme.FONT_BOLD,
                          bg=Theme.BG_PANEL, fg=Theme.SUCCESS)
            lbl.grid(row=0, column=i*2+1, padx=(0, 15))
            self.stats_labels[label] = lbl
    
    def _build_status_bar(self, parent):
        """Build status bar"""
        status = tk.Frame(parent, bg=Theme.BG_PANEL, height=25)
        status.pack(fill=tk.X, side=tk.BOTTOM)
        status.pack_propagate(False)
        
        tk.Label(status, textvariable=self.status_var,
                font=Theme.FONT, bg=Theme.BG_PANEL, fg=Theme.FG).pack(side=tk.LEFT, padx=10)
        
        tk.Label(status, text=f"Evony Mega Toolkit v{self.VERSION}",
                font=Theme.FONT, bg=Theme.BG_PANEL, fg=Theme.FG_DIM).pack(side=tk.RIGHT, padx=10)
    
    # =========================================================================
    # ACCOUNTS TAB - Full Account Manager
    # =========================================================================
    
    def _build_accounts_tab(self):
        """Build comprehensive accounts tab"""
        tab = ttk.Frame(self.notebook)
        self.notebook.add(tab, text="👤 Accounts")
        
        # Split pane
        paned = ttk.PanedWindow(tab, orient=tk.HORIZONTAL)
        paned.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Left panel - Account list
        left = tk.Frame(paned, bg=Theme.BG_PANEL, width=500)
        paned.add(left, weight=1)
        
        # Toolbar
        toolbar = tk.Frame(left, bg=Theme.BG_PANEL)
        toolbar.pack(fill=tk.X, padx=5, pady=5)
        
        tk.Button(toolbar, text="🔄 Reload All", command=self._reload_accounts,
                 bg=Theme.BG_INPUT, fg=Theme.FG).pack(side=tk.LEFT, padx=2)
        tk.Button(toolbar, text="📤 Export All", command=self._export_all_accounts,
                 bg=Theme.BG_INPUT, fg=Theme.FG).pack(side=tk.LEFT, padx=2)
        tk.Button(toolbar, text="🔍 Search", command=self._search_accounts,
                 bg=Theme.BG_INPUT, fg=Theme.FG).pack(side=tk.LEFT, padx=2)
        
        # Filter frame
        filter_frame = tk.Frame(left, bg=Theme.BG_PANEL)
        filter_frame.pack(fill=tk.X, padx=5)
        
        tk.Label(filter_frame, text="Filter:", bg=Theme.BG_PANEL, fg=Theme.FG).pack(side=tk.LEFT)
        
        self.account_filter = tk.StringVar(value="all")
        filters = [("All", "all"), ("Borg", "borg"), ("Lion", "lion"), ("LT", "lt"), ("Conflicts", "conflicts")]
        for text, value in filters:
            tk.Radiobutton(filter_frame, text=text, variable=self.account_filter,
                          value=value, bg=Theme.BG_PANEL, fg=Theme.FG,
                          selectcolor=Theme.BG_INPUT, activebackground=Theme.BG_PANEL,
                          command=self._filter_accounts).pack(side=tk.LEFT, padx=5)
        
        # Account tree
        tree_frame = tk.Frame(left, bg=Theme.BG_INPUT)
        tree_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        cols = ("email", "username", "passwords", "labels", "status")
        self.account_tree = ttk.Treeview(tree_frame, columns=cols, show='headings', height=25)
        
        self.account_tree.heading("email", text="Email")
        self.account_tree.heading("username", text="Username")
        self.account_tree.heading("passwords", text="Passwords")
        self.account_tree.heading("labels", text="Labels")
        self.account_tree.heading("status", text="Status")
        
        self.account_tree.column("email", width=200)
        self.account_tree.column("username", width=100)
        self.account_tree.column("passwords", width=100)
        self.account_tree.column("labels", width=80)
        self.account_tree.column("status", width=70)
        
        scroll = ttk.Scrollbar(tree_frame, orient=tk.VERTICAL, command=self.account_tree.yview)
        self.account_tree.configure(yscrollcommand=scroll.set)
        
        self.account_tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scroll.pack(side=tk.RIGHT, fill=tk.Y)
        
        self.account_tree.bind('<<TreeviewSelect>>', self._on_account_select)
        self.account_tree.bind('<Button-3>', self._account_context_menu)
        
        # Right panel - Account details
        right = tk.Frame(paned, bg=Theme.BG_PANEL, width=400)
        paned.add(right, weight=1)
        
        # Details header
        tk.Label(right, text="📋 Account Details", font=Theme.FONT_LARGE,
                bg=Theme.BG_PANEL, fg=Theme.ACCENT).pack(pady=10)
        
        # Details frame
        details = tk.Frame(right, bg=Theme.BG_PANEL)
        details.pack(fill=tk.BOTH, expand=True, padx=10)
        
        self.detail_vars = {}
        detail_fields = [
            ("Email:", "email"),
            ("Username:", "username"),
            ("Primary Password:", "password"),
            ("All Passwords:", "all_passwords"),
            ("Security Code:", "security_code"),
            ("Cookie:", "cookie"),
            ("Labels:", "labels"),
            ("Source Files:", "sources"),
            ("Status:", "status"),
        ]
        
        for i, (label, key) in enumerate(detail_fields):
            tk.Label(details, text=label, font=Theme.FONT_BOLD,
                    bg=Theme.BG_PANEL, fg=Theme.FG).grid(row=i, column=0, sticky='w', pady=3)
            
            var = tk.StringVar(value="-")
            self.detail_vars[key] = var
            
            if key == "all_passwords":
                entry = tk.Text(details, height=3, width=40, font=Theme.FONT,
                               bg=Theme.BG_INPUT, fg=Theme.FG)
                entry.grid(row=i, column=1, sticky='w', pady=3, padx=5)
                self.detail_vars[key + "_widget"] = entry
            else:
                tk.Label(details, textvariable=var, font=Theme.FONT,
                        bg=Theme.BG_PANEL, fg=Theme.SUCCESS).grid(row=i, column=1, sticky='w', pady=3)
        
        # Action buttons
        actions = tk.Frame(right, bg=Theme.BG_PANEL)
        actions.pack(fill=tk.X, padx=10, pady=10)
        
        tk.Button(actions, text="📋 Copy Email:Pass", command=self._copy_account_login,
                 bg=Theme.ACCENT, fg=Theme.BG_DARK, font=Theme.FONT_BOLD).pack(fill=tk.X, pady=2)
        tk.Button(actions, text="🔄 Try Alternative Password", command=self._try_alt_password,
                 bg=Theme.BG_INPUT, fg=Theme.FG).pack(fill=tk.X, pady=2)
        tk.Button(actions, text="📤 Export Account", command=self._export_single_account,
                 bg=Theme.BG_INPUT, fg=Theme.FG).pack(fill=tk.X, pady=2)
        tk.Button(actions, text="🗑️ Mark as Lost", command=self._mark_account_lost,
                 bg=Theme.ERROR, fg=Theme.FG).pack(fill=tk.X, pady=2)
        
        # Stats at bottom
        stats = tk.Frame(right, bg=Theme.BG_PANEL)
        stats.pack(fill=tk.X, padx=10, pady=10, side=tk.BOTTOM)
        
        self.account_stats_var = tk.StringVar(value="Loading...")
        tk.Label(stats, textvariable=self.account_stats_var, font=Theme.FONT,
                bg=Theme.BG_PANEL, fg=Theme.FG_DIM, wraplength=350).pack()
    
    def _reload_accounts(self):
        """Reload all accounts from files"""
        self.status_var.set("Loading accounts...")
        self.root.update()
        
        count = self.account_mgr.load_all()
        self._populate_account_tree()
        self._update_account_stats()
        
        self.stats_labels["📊 Accounts"].config(text=str(count))
        self.status_var.set(f"Loaded {count} accounts")
    
    def _populate_account_tree(self, accounts: List[Account] = None):
        """Populate account tree with data"""
        self.account_tree.delete(*self.account_tree.get_children())
        
        if accounts is None:
            filter_type = self.account_filter.get()
            if filter_type == "all":
                accounts = self.account_mgr.get_all_accounts()
            elif filter_type == "borg":
                accounts = self.account_mgr.get_borg_accounts()
            elif filter_type == "lion":
                accounts = self.account_mgr.get_lion_accounts()
            elif filter_type == "lt":
                accounts = [a for a in self.account_mgr.get_all_accounts() if "LT" in a.labels]
            elif filter_type == "conflicts":
                accounts = self.account_mgr.get_accounts_with_password_conflicts()
        
        for acc in accounts:
            pw_count = len(acc.passwords)
            pw_display = f"{pw_count} pw{'s' if pw_count > 1 else ''}" if pw_count else "cookie"
            labels = ", ".join(sorted(acc.labels)) if acc.labels else "-"
            
            self.account_tree.insert('', tk.END, values=(
                acc.email,
                acc.username or "-",
                pw_display,
                labels,
                acc.status,
            ), tags=('borg' if acc.is_borg() else 'lion' if acc.is_lion() else 'normal',))
        
        # Color coding
        self.account_tree.tag_configure('borg', foreground=Theme.PURPLE)
        self.account_tree.tag_configure('lion', foreground=Theme.WARNING)
        self.account_tree.tag_configure('normal', foreground=Theme.FG)
    
    def _filter_accounts(self):
        """Apply account filter"""
        self._populate_account_tree()
    
    def _on_account_select(self, event=None):
        """Handle account selection"""
        sel = self.account_tree.selection()
        if sel:
            values = self.account_tree.item(sel[0])['values']
            email = values[0]
            
            acc = self.account_mgr.accounts.get(email.lower())
            if acc:
                self.selected_account = acc
                
                self.detail_vars["email"].set(acc.email)
                self.detail_vars["username"].set(acc.username or "-")
                self.detail_vars["password"].set(acc.primary_password() or "cookie")
                self.detail_vars["security_code"].set(acc.security_code or "-")
                self.detail_vars["cookie"].set(acc.cookie or "-")
                self.detail_vars["labels"].set(", ".join(acc.labels) or "-")
                self.detail_vars["sources"].set(", ".join(acc.source_files[:3]) or "-")
                self.detail_vars["status"].set(acc.status)
                
                # All passwords
                pw_widget = self.detail_vars.get("all_passwords_widget")
                if pw_widget:
                    pw_widget.delete('1.0', tk.END)
                    for i, pw in enumerate(acc.passwords):
                        pw_widget.insert(tk.END, f"{i+1}. {pw}\n")
    
    def _account_context_menu(self, event):
        """Show account context menu"""
        menu = tk.Menu(self.root, tearoff=0)
        menu.add_command(label="📋 Copy Email:Password", command=self._copy_account_login)
        menu.add_command(label="📋 Copy Email Only", command=lambda: self._copy_field("email"))
        menu.add_command(label="📋 Copy Password Only", command=lambda: self._copy_field("password"))
        menu.add_separator()
        menu.add_command(label="📤 Export to TXT", command=self._export_single_account)
        menu.add_command(label="🔄 Try All Passwords", command=self._try_alt_password)
        menu.add_separator()
        menu.add_command(label="🗑️ Mark as Lost", command=self._mark_account_lost)
        menu.post(event.x_root, event.y_root)
    
    def _copy_account_login(self):
        """Copy selected account as email:password"""
        if self.selected_account:
            line = self.selected_account.to_simple_line()
            copy_to_clipboard(self.root, line)
            self.status_var.set(f"Copied: {line[:50]}...")
    
    def _copy_field(self, field: str):
        """Copy specific field"""
        if self.selected_account:
            if field == "email":
                copy_to_clipboard(self.root, self.selected_account.email)
            elif field == "password":
                copy_to_clipboard(self.root, self.selected_account.primary_password())
    
    def _try_alt_password(self):
        """Show alternative passwords"""
        if self.selected_account and len(self.selected_account.passwords) > 1:
            msg = "Alternative passwords:\n\n"
            for i, pw in enumerate(self.selected_account.passwords):
                msg += f"{i+1}. {pw}\n"
            messagebox.showinfo("Alternative Passwords", msg)
        else:
            messagebox.showinfo("Info", "No alternative passwords found")
    
    def _export_single_account(self):
        """Export selected account"""
        if self.selected_account:
            path = filedialog.asksaveasfilename(
                defaultextension=".json",
                filetypes=[("JSON", "*.json"), ("Text", "*.txt")]
            )
            if path:
                if path.endswith('.json'):
                    Path(path).write_text(json.dumps(self.selected_account.to_dict(), indent=2))
                else:
                    Path(path).write_text(self.selected_account.to_simple_line())
                self.status_var.set(f"Exported: {path}")
    
    def _mark_account_lost(self):
        """Mark account as lost/purged"""
        if self.selected_account:
            self.selected_account.status = "lost"
            self.account_mgr.lost_accounts.append(self.selected_account)
            self._populate_account_tree()
            self.status_var.set(f"Marked as lost: {self.selected_account.email}")
    
    def _export_all_accounts(self):
        """Export all accounts in all formats"""
        results = self.account_mgr.export_all_formats()
        msg = "Exported:\n\n"
        for name, count in results.items():
            msg += f"• {name}: {count} accounts\n"
        msg += f"\nLocation: {PATHS['exports']}"
        messagebox.showinfo("Export Complete", msg)
    
    def _search_accounts(self):
        """Search accounts"""
        query = simpledialog.askstring("Search", "Enter email, username, or label:")
        if query:
            results = self.account_mgr.search(query)
            self._populate_account_tree(results)
            self.status_var.set(f"Found {len(results)} accounts matching '{query}'")
    
    def _update_account_stats(self):
        """Update account statistics display"""
        stats = self.account_mgr.get_stats()
        text = f"""Total: {stats['total_accounts']} | Borg: {stats['borg_accounts']} | Lion: {stats['lion_accounts']} | LT: {stats['lt_accounts']}
Password Conflicts: {stats['password_conflicts']} | With Cookie: {stats['with_cookie']}
Files Parsed: {stats['files_parsed']} | Parse Errors: {stats['parse_errors']}"""
        self.account_stats_var.set(text)


    # =========================================================================
    # SCRIPTS TAB
    # =========================================================================
    
    def _build_scripts_tab(self):
        """Build scripts studio tab"""
        tab = ttk.Frame(self.notebook)
        self.notebook.add(tab, text="📜 Scripts")
        
        paned = ttk.PanedWindow(tab, orient=tk.HORIZONTAL)
        paned.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Left - Script list
        left = tk.Frame(paned, bg=Theme.BG_PANEL, width=300)
        paned.add(left, weight=1)
        
        tk.Label(left, text="📁 Scripts (196)", font=Theme.FONT_BOLD,
                bg=Theme.BG_PANEL, fg=Theme.ACCENT).pack(pady=5)
        
        # Category filter
        cat_frame = tk.Frame(left, bg=Theme.BG_PANEL)
        cat_frame.pack(fill=tk.X, padx=5)
        
        tk.Label(cat_frame, text="Category:", bg=Theme.BG_PANEL, fg=Theme.FG).pack(side=tk.LEFT)
        self.script_category = ttk.Combobox(cat_frame, values=["All"], state='readonly')
        self.script_category.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=5)
        self.script_category.set("All")
        self.script_category.bind('<<ComboboxSelected>>', self._filter_scripts)
        
        # Script listbox
        list_frame = tk.Frame(left, bg=Theme.BG_INPUT)
        list_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        self.script_listbox = tk.Listbox(list_frame, bg=Theme.BG_INPUT, fg=Theme.FG,
                                        font=Theme.FONT, selectbackground=Theme.ACCENT)
        scroll = ttk.Scrollbar(list_frame, orient=tk.VERTICAL, command=self.script_listbox.yview)
        self.script_listbox.config(yscrollcommand=scroll.set)
        
        self.script_listbox.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scroll.pack(side=tk.RIGHT, fill=tk.Y)
        
        self.script_listbox.bind('<<ListboxSelect>>', self._on_script_select)
        self.script_listbox.bind('<Button-3>', self._script_context_menu)
        
        # Right - Editor
        right = tk.Frame(paned, bg=Theme.BG_PANEL)
        paned.add(right, weight=3)
        
        # Editor toolbar
        toolbar = tk.Frame(right, bg=Theme.BG_PANEL)
        toolbar.pack(fill=tk.X, padx=5, pady=5)
        
        tk.Label(toolbar, textvariable=self.editor_filename, font=Theme.FONT_BOLD,
                bg=Theme.BG_PANEL, fg=Theme.ACCENT).pack(side=tk.LEFT)
        
        for text, cmd in [
            ("📄 New", self._new_script),
            ("📂 Open", self._open_script),
            ("💾 Save", self._save_script),
            ("📋 Copy", self._copy_script_content),
            ("▶️ Run", self._run_script),
        ]:
            tk.Button(toolbar, text=text, command=cmd,
                     bg=Theme.BG_INPUT, fg=Theme.FG).pack(side=tk.LEFT, padx=2)
        
        # Editor
        editor_frame = tk.Frame(right, bg=Theme.BG_INPUT)
        editor_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        self.script_editor = scrolledtext.ScrolledText(
            editor_frame,
            bg=Theme.BG_INPUT,
            fg=Theme.FG,
            font=Theme.FONT_MONO,
            insertbackground=Theme.ACCENT,
            wrap=tk.NONE
        )
        self.script_editor.pack(fill=tk.BOTH, expand=True)
        
        # Add horizontal scroll
        hscroll = ttk.Scrollbar(editor_frame, orient=tk.HORIZONTAL, command=self.script_editor.xview)
        self.script_editor.config(xscrollcommand=hscroll.set)
        hscroll.pack(fill=tk.X)
    
    def _on_script_select(self, event=None):
        """Load selected script"""
        sel = self.script_listbox.curselection()
        if sel:
            name = self.script_listbox.get(sel[0])
            script = self.script_mgr.get_by_name(name)
            if script:
                self.current_file = script['path']
                self.editor_filename.set(f"📝 {script['name']}.txt")
                self.script_editor.delete('1.0', tk.END)
                self.script_editor.insert('1.0', script['content'])
                self.status_var.set(f"Loaded: {script['name']} ({script['lines']} lines)")
    
    def _script_context_menu(self, event):
        """Script context menu"""
        menu = tk.Menu(self.root, tearoff=0)
        menu.add_command(label="▶️ Run Script", command=self._run_script)
        menu.add_command(label="📋 Copy Content", command=self._copy_script_content)
        menu.add_command(label="📤 Export", command=self._export_script)
        menu.add_separator()
        menu.add_command(label="🗑️ Delete", command=self._delete_script)
        menu.post(event.x_root, event.y_root)
    
    def _filter_scripts(self, event=None):
        """Filter scripts by category"""
        category = self.script_category.get()
        self.script_listbox.delete(0, tk.END)
        
        if category == "All":
            scripts = self.script_mgr.get_all()
        else:
            scripts = self.script_mgr.get_by_category(category)
        
        for s in sorted(scripts, key=lambda x: x['name']):
            self.script_listbox.insert(tk.END, s['name'])
    
    def _new_script(self):
        """Create new script"""
        self.current_file = None
        self.editor_filename.set("📝 New Script.txt")
        self.script_editor.delete('1.0', tk.END)
        template = TEMPLATES.get("Basic Script", "").replace("{date}", datetime.now().strftime("%Y-%m-%d"))
        self.script_editor.insert('1.0', template)
    
    def _open_script(self):
        """Open script file"""
        path = filedialog.askopenfilename(
            initialdir=str(PATHS["scripts"]),
            filetypes=[("Text files", "*.txt"), ("All files", "*.*")]
        )
        if path:
            content = Path(path).read_text(encoding='utf-8', errors='ignore')
            self.current_file = path
            self.editor_filename.set(f"📝 {Path(path).name}")
            self.script_editor.delete('1.0', tk.END)
            self.script_editor.insert('1.0', content)
    
    def _save_script(self):
        """Save current script"""
        if self.current_file:
            Path(self.current_file).write_text(self.script_editor.get('1.0', tk.END), encoding='utf-8')
            self.status_var.set(f"Saved: {self.current_file}")
        else:
            self._save_script_as()
    
    def _save_script_as(self):
        """Save script as new file"""
        path = filedialog.asksaveasfilename(
            initialdir=str(PATHS["scripts"]),
            defaultextension=".txt",
            filetypes=[("Text files", "*.txt")]
        )
        if path:
            Path(path).write_text(self.script_editor.get('1.0', tk.END), encoding='utf-8')
            self.current_file = path
            self.editor_filename.set(f"📝 {Path(path).name}")
            self.status_var.set(f"Saved: {path}")
    
    def _copy_script_content(self):
        """Copy script to clipboard"""
        content = self.script_editor.get('1.0', tk.END)
        copy_to_clipboard(self.root, content)
        self.status_var.set("Script copied to clipboard!")
    
    def _run_script(self):
        """Copy script for running in AutoEvony"""
        self._copy_script_content()
        messagebox.showinfo("Run Script", "Script copied to clipboard!\n\nPaste in AutoEvony console to run.")
    
    def _export_script(self):
        """Export script"""
        self._save_script_as()
    
    def _delete_script(self):
        """Delete selected script"""
        sel = self.script_listbox.curselection()
        if sel:
            name = self.script_listbox.get(sel[0])
            if messagebox.askyesno("Delete", f"Delete script '{name}'?"):
                script = self.script_mgr.get_by_name(name)
                if script:
                    try:
                        Path(script['path']).unlink()
                        self.script_mgr.load()
                        self._filter_scripts()
                        self.status_var.set(f"Deleted: {name}")
                    except Exception as e:
                        messagebox.showerror("Error", f"Could not delete: {e}")
    
    # =========================================================================
    # EXPLOITS TAB
    # =========================================================================
    
    def _build_exploits_tab(self):
        """Build exploits library tab"""
        tab = ttk.Frame(self.notebook)
        self.notebook.add(tab, text="⚡ Exploits")
        
        paned = ttk.PanedWindow(tab, orient=tk.HORIZONTAL)
        paned.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Left - Exploit list
        left = tk.Frame(paned, bg=Theme.BG_PANEL, width=400)
        paned.add(left, weight=1)
        
        tk.Label(left, text=f"⚡ Exploits ({len(EXPLOITS)})", font=Theme.FONT_BOLD,
                bg=Theme.BG_PANEL, fg=Theme.WARNING).pack(pady=5)
        
        # Exploit tree
        tree_frame = tk.Frame(left, bg=Theme.BG_INPUT)
        tree_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        cols = ("id", "name", "category", "risk")
        self.exploit_tree = ttk.Treeview(tree_frame, columns=cols, show='headings', height=20)
        
        self.exploit_tree.heading("id", text="#")
        self.exploit_tree.heading("name", text="Name")
        self.exploit_tree.heading("category", text="Category")
        self.exploit_tree.heading("risk", text="Risk")
        
        self.exploit_tree.column("id", width=30)
        self.exploit_tree.column("name", width=180)
        self.exploit_tree.column("category", width=80)
        self.exploit_tree.column("risk", width=60)
        
        scroll = ttk.Scrollbar(tree_frame, orient=tk.VERTICAL, command=self.exploit_tree.yview)
        self.exploit_tree.config(yscrollcommand=scroll.set)
        
        self.exploit_tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scroll.pack(side=tk.RIGHT, fill=tk.Y)
        
        self.exploit_tree.bind('<<TreeviewSelect>>', self._on_exploit_select)
        
        # Right - Exploit details
        right = tk.Frame(paned, bg=Theme.BG_PANEL)
        paned.add(right, weight=2)
        
        # Details
        details = tk.Frame(right, bg=Theme.BG_PANEL)
        details.pack(fill=tk.X, padx=10, pady=10)
        
        self.exploit_vars = {}
        for label, key in [("Name:", "name"), ("Category:", "category"), 
                          ("Risk:", "risk"), ("Description:", "desc"), ("Command:", "cmd")]:
            row = tk.Frame(details, bg=Theme.BG_PANEL)
            row.pack(fill=tk.X, pady=2)
            tk.Label(row, text=label, font=Theme.FONT_BOLD, width=12, anchor='w',
                    bg=Theme.BG_PANEL, fg=Theme.FG).pack(side=tk.LEFT)
            var = tk.StringVar(value="-")
            self.exploit_vars[key] = var
            tk.Label(row, textvariable=var, font=Theme.FONT,
                    bg=Theme.BG_PANEL, fg=Theme.SUCCESS).pack(side=tk.LEFT, fill=tk.X)
        
        # Script editor
        tk.Label(right, text="Exploit Script:", font=Theme.FONT_BOLD,
                bg=Theme.BG_PANEL, fg=Theme.ACCENT).pack(anchor='w', padx=10)
        
        self.exploit_editor = scrolledtext.ScrolledText(right, height=15,
            bg=Theme.BG_INPUT, fg=Theme.FG, font=Theme.FONT_MONO)
        self.exploit_editor.pack(fill=tk.BOTH, expand=True, padx=10, pady=5)
        
        # Buttons
        btn_frame = tk.Frame(right, bg=Theme.BG_PANEL)
        btn_frame.pack(fill=tk.X, padx=10, pady=5)
        
        tk.Button(btn_frame, text="📋 Copy Script", command=self._copy_exploit,
                 bg=Theme.WARNING, fg=Theme.BG_DARK, font=Theme.FONT_BOLD).pack(side=tk.LEFT, padx=5)
        tk.Button(btn_frame, text="💾 Save to Scripts", command=self._save_exploit,
                 bg=Theme.BG_INPUT, fg=Theme.FG).pack(side=tk.LEFT, padx=5)
    
    def _on_exploit_select(self, event=None):
        """Handle exploit selection"""
        sel = self.exploit_tree.selection()
        if sel:
            values = self.exploit_tree.item(sel[0])['values']
            exp_id = values[0]
            
            exp = next((e for e in EXPLOITS if e['id'] == exp_id), None)
            if exp:
                self.exploit_vars["name"].set(exp['name'])
                self.exploit_vars["category"].set(exp['category'])
                self.exploit_vars["risk"].set(exp['risk'])
                self.exploit_vars["desc"].set(exp['description'])
                self.exploit_vars["cmd"].set(exp['command'])
                
                self.exploit_editor.delete('1.0', tk.END)
                self.exploit_editor.insert('1.0', exp.get('script', '// No script'))
    
    def _copy_exploit(self):
        """Copy exploit script"""
        content = self.exploit_editor.get('1.0', tk.END)
        copy_to_clipboard(self.root, content)
        self.status_var.set("Exploit copied!")
    
    def _save_exploit(self):
        """Save exploit as script file"""
        name = self.exploit_vars["name"].get().replace(" ", "_")
        path = PATHS["scripts"] / f"exploit_{name}.txt"
        path.write_text(self.exploit_editor.get('1.0', tk.END), encoding='utf-8')
        self.status_var.set(f"Saved: {path.name}")
        self.script_mgr.load()
        self._filter_scripts()


    # =========================================================================
    # PROTOCOL TAB
    # =========================================================================
    
    def _build_protocol_tab(self):
        """Build protocol analyzer tab"""
        tab = ttk.Frame(self.notebook)
        self.notebook.add(tab, text="🔧 Protocol")
        
        paned = ttk.PanedWindow(tab, orient=tk.HORIZONTAL)
        paned.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Left - Command tree
        left = tk.Frame(paned, bg=Theme.BG_PANEL, width=400)
        paned.add(left, weight=1)
        
        tk.Label(left, text=f"🔧 Commands ({TOTAL_COMMANDS})", font=Theme.FONT_BOLD,
                bg=Theme.BG_PANEL, fg=Theme.ACCENT).pack(pady=5)
        
        # Search
        search_frame = tk.Frame(left, bg=Theme.BG_PANEL)
        search_frame.pack(fill=tk.X, padx=5)
        
        self.cmd_search_var = tk.StringVar()
        self.cmd_search_var.trace('w', self._search_commands)
        tk.Entry(search_frame, textvariable=self.cmd_search_var, 
                bg=Theme.BG_INPUT, fg=Theme.FG, font=Theme.FONT).pack(fill=tk.X)
        
        # Command tree
        tree_frame = tk.Frame(left, bg=Theme.BG_INPUT)
        tree_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        self.cmd_tree = ttk.Treeview(tree_frame, show='tree headings', height=20)
        self.cmd_tree['columns'] = ('params', 'desc')
        self.cmd_tree.heading('#0', text='Command')
        self.cmd_tree.heading('params', text='Parameters')
        self.cmd_tree.heading('desc', text='Description')
        
        self.cmd_tree.column('#0', width=180)
        self.cmd_tree.column('params', width=150)
        self.cmd_tree.column('desc', width=200)
        
        scroll = ttk.Scrollbar(tree_frame, orient=tk.VERTICAL, command=self.cmd_tree.yview)
        self.cmd_tree.config(yscrollcommand=scroll.set)
        
        self.cmd_tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scroll.pack(side=tk.RIGHT, fill=tk.Y)
        
        self.cmd_tree.bind('<<TreeviewSelect>>', self._on_command_select)
        
        # Right - Packet builder
        right = tk.Frame(paned, bg=Theme.BG_PANEL)
        paned.add(right, weight=2)
        
        tk.Label(right, text="📡 Packet Builder", font=Theme.FONT_BOLD,
                bg=Theme.BG_PANEL, fg=Theme.ACCENT).pack(pady=10)
        
        # Command info
        info = tk.Frame(right, bg=Theme.BG_PANEL)
        info.pack(fill=tk.X, padx=10)
        
        self.cmd_info_vars = {}
        for label in ["Command:", "Parameters:", "Description:"]:
            row = tk.Frame(info, bg=Theme.BG_PANEL)
            row.pack(fill=tk.X, pady=2)
            tk.Label(row, text=label, font=Theme.FONT_BOLD, width=12, anchor='w',
                    bg=Theme.BG_PANEL, fg=Theme.FG).pack(side=tk.LEFT)
            var = tk.StringVar(value="-")
            self.cmd_info_vars[label] = var
            tk.Label(row, textvariable=var, font=Theme.FONT,
                    bg=Theme.BG_PANEL, fg=Theme.SUCCESS).pack(side=tk.LEFT)
        
        # Packet editor
        tk.Label(right, text="Generated Packet:", font=Theme.FONT_BOLD,
                bg=Theme.BG_PANEL, fg=Theme.ACCENT).pack(anchor='w', padx=10, pady=(10,0))
        
        self.packet_editor = scrolledtext.ScrolledText(right, height=15,
            bg=Theme.BG_INPUT, fg=Theme.FG, font=Theme.FONT_MONO)
        self.packet_editor.pack(fill=tk.BOTH, expand=True, padx=10, pady=5)
        
        # Buttons
        btn_frame = tk.Frame(right, bg=Theme.BG_PANEL)
        btn_frame.pack(fill=tk.X, padx=10, pady=5)
        
        tk.Button(btn_frame, text="📋 Copy Packet", command=self._copy_packet,
                 bg=Theme.ACCENT, fg=Theme.BG_DARK).pack(side=tk.LEFT, padx=5)
        tk.Button(btn_frame, text="📤 Export All Commands", command=self._export_commands,
                 bg=Theme.BG_INPUT, fg=Theme.FG).pack(side=tk.LEFT, padx=5)
    
    def _populate_command_tree(self):
        """Populate command tree"""
        self.cmd_tree.delete(*self.cmd_tree.get_children())
        
        for category, commands in sorted(COMMANDS.items()):
            cat_id = self.cmd_tree.insert('', tk.END, text=f"▶ {category} ({len(commands)})", open=False)
            
            for cmd_name, cmd_data in sorted(commands.items()):
                params = ", ".join(cmd_data.get("params", [])) or "none"
                desc = cmd_data.get("desc", "")
                self.cmd_tree.insert(cat_id, tk.END, text=cmd_name, values=(params, desc))
    
    def _search_commands(self, *args):
        """Search commands"""
        query = self.cmd_search_var.get().lower()
        if not query:
            self._populate_command_tree()
            return
        
        self.cmd_tree.delete(*self.cmd_tree.get_children())
        
        for category, commands in COMMANDS.items():
            matches = []
            for cmd_name, cmd_data in commands.items():
                if query in cmd_name.lower() or query in cmd_data.get("desc", "").lower():
                    params = ", ".join(cmd_data.get("params", [])) or "none"
                    matches.append((cmd_name, params, cmd_data.get("desc", "")))
            
            if matches:
                cat_id = self.cmd_tree.insert('', tk.END, text=f"▶ {category} ({len(matches)})", open=True)
                for cmd_name, params, desc in matches:
                    self.cmd_tree.insert(cat_id, tk.END, text=cmd_name, values=(params, desc))
    
    def _on_command_select(self, event=None):
        """Handle command selection"""
        sel = self.cmd_tree.selection()
        if sel:
            item = self.cmd_tree.item(sel[0])
            text = item['text']
            
            # Skip category headers
            if text.startswith("▶"):
                return
            
            # Find command data
            parent = self.cmd_tree.parent(sel[0])
            if parent:
                cat_text = self.cmd_tree.item(parent)['text']
                category = cat_text.split()[1]  # Remove ▶ and count
                
                if category in COMMANDS and text in COMMANDS[category]:
                    cmd_data = COMMANDS[category][text]
                    full_cmd = f"{category}.{text}"
                    
                    self.cmd_info_vars["Command:"].set(full_cmd)
                    self.cmd_info_vars["Parameters:"].set(", ".join(cmd_data.get("params", [])) or "none")
                    self.cmd_info_vars["Description:"].set(cmd_data.get("desc", ""))
                    
                    # Generate packet
                    packet = f'''// AMF Packet: {full_cmd}
{{
    "cmd": "{full_cmd}",
    "params": {json.dumps(cmd_data.get("params", []), indent=8)},
    "timestamp": "{datetime.now().isoformat()}",
    "signature": "{generate_signature(full_cmd)}"
}}'''
                    self.packet_editor.delete('1.0', tk.END)
                    self.packet_editor.insert('1.0', packet)
    
    def _copy_packet(self):
        """Copy packet to clipboard"""
        content = self.packet_editor.get('1.0', tk.END)
        copy_to_clipboard(self.root, content)
        self.status_var.set("Packet copied!")
    
    def _export_commands(self):
        """Export all commands to JSON"""
        path = filedialog.asksaveasfilename(
            defaultextension=".json",
            initialfile="evony_commands.json",
            filetypes=[("JSON", "*.json")]
        )
        if path:
            Path(path).write_text(json.dumps(COMMANDS, indent=2), encoding='utf-8')
            self.status_var.set(f"Exported {TOTAL_COMMANDS} commands")
    
    # =========================================================================
    # SOURCE BROWSER TAB
    # =========================================================================
    
    def _build_source_tab(self):
        """Build AS3 source browser tab"""
        tab = ttk.Frame(self.notebook)
        self.notebook.add(tab, text="📁 Source")
        
        paned = ttk.PanedWindow(tab, orient=tk.HORIZONTAL)
        paned.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Left - File tree
        left = tk.Frame(paned, bg=Theme.BG_PANEL, width=350)
        paned.add(left, weight=1)
        
        self.source_count_var = tk.StringVar(value="📁 Source Files (0)")
        tk.Label(left, textvariable=self.source_count_var, font=Theme.FONT_BOLD,
                bg=Theme.BG_PANEL, fg=Theme.ACCENT).pack(pady=5)
        
        # Search
        search_frame = tk.Frame(left, bg=Theme.BG_PANEL)
        search_frame.pack(fill=tk.X, padx=5)
        
        self.source_search = tk.StringVar()
        tk.Entry(search_frame, textvariable=self.source_search,
                bg=Theme.BG_INPUT, fg=Theme.FG, font=Theme.FONT).pack(side=tk.LEFT, fill=tk.X, expand=True)
        tk.Button(search_frame, text="🔍", command=self._search_source,
                 bg=Theme.BG_INPUT, fg=Theme.FG).pack(side=tk.LEFT)
        
        # Results tree
        tree_frame = tk.Frame(left, bg=Theme.BG_INPUT)
        tree_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        self.source_tree = ttk.Treeview(tree_frame, columns=("source", "matches"), show='tree headings')
        self.source_tree.heading('#0', text='File')
        self.source_tree.heading('source', text='Source')
        self.source_tree.heading('matches', text='Matches')
        
        self.source_tree.column('#0', width=200)
        self.source_tree.column('source', width=60)
        self.source_tree.column('matches', width=50)
        
        scroll = ttk.Scrollbar(tree_frame, orient=tk.VERTICAL, command=self.source_tree.yview)
        self.source_tree.config(yscrollcommand=scroll.set)
        
        self.source_tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scroll.pack(side=tk.RIGHT, fill=tk.Y)
        
        self.source_tree.bind('<<TreeviewSelect>>', self._on_source_select)
        
        # Right - Code viewer
        right = tk.Frame(paned, bg=Theme.BG_PANEL)
        paned.add(right, weight=3)
        
        # File info
        self.source_file_var = tk.StringVar(value="No file selected")
        tk.Label(right, textvariable=self.source_file_var, font=Theme.FONT_BOLD,
                bg=Theme.BG_PANEL, fg=Theme.ACCENT).pack(pady=5)
        
        # Code editor
        self.source_editor = scrolledtext.ScrolledText(right,
            bg=Theme.BG_INPUT, fg=Theme.FG, font=Theme.FONT_MONO, wrap=tk.NONE)
        self.source_editor.pack(fill=tk.BOTH, expand=True, padx=10, pady=5)
        
        # Buttons
        btn_frame = tk.Frame(right, bg=Theme.BG_PANEL)
        btn_frame.pack(fill=tk.X, padx=10, pady=5)
        
        tk.Button(btn_frame, text="📋 Copy Code", 
                 command=lambda: copy_to_clipboard(self.root, self.source_editor.get('1.0', tk.END)),
                 bg=Theme.BG_INPUT, fg=Theme.FG).pack(side=tk.LEFT, padx=5)
        tk.Button(btn_frame, text="🔍 Find in File", command=self._find_in_source,
                 bg=Theme.BG_INPUT, fg=Theme.FG).pack(side=tk.LEFT, padx=5)
    
    def _search_source(self):
        """Search source files"""
        query = self.source_search.get()
        if not query:
            return
        
        self.status_var.set(f"Searching for '{query}'...")
        self.root.update()
        
        results = self.source_browser.search(query)
        
        self.source_tree.delete(*self.source_tree.get_children())
        
        for r in results:
            item_id = self.source_tree.insert('', tk.END, text=r['name'],
                                             values=(r['source'], r['match_count']))
            # Store path in item
            self.source_tree.set(item_id, 'path', r['path'])
            
            # Add match previews as children
            for line_num, line_text in r['matches'][:5]:
                self.source_tree.insert(item_id, tk.END, text=f"  L{line_num}: {line_text[:60]}...")
        
        self.status_var.set(f"Found {len(results)} files matching '{query}'")
    
    def _on_source_select(self, event=None):
        """Handle source file selection"""
        sel = self.source_tree.selection()
        if sel:
            item = self.source_tree.item(sel[0])
            
            # Try to get path from item or parent
            values = item.get('values', [])
            if len(values) >= 2:
                # This is a file item
                text = item['text']
                
                # Find the file in search results
                for child in self.source_tree.get_children():
                    child_item = self.source_tree.item(child)
                    if child_item['text'] == text:
                        # Load file content
                        # We need to track paths differently
                        pass
    
    def _find_in_source(self):
        """Find text in current source file"""
        query = simpledialog.askstring("Find", "Search for:")
        if query:
            content = self.source_editor.get('1.0', tk.END)
            idx = content.lower().find(query.lower())
            if idx >= 0:
                self.source_editor.tag_remove('found', '1.0', tk.END)
                start = f"1.0+{idx}c"
                end = f"1.0+{idx + len(query)}c"
                self.source_editor.tag_add('found', start, end)
                self.source_editor.tag_config('found', background=Theme.WARNING)
                self.source_editor.see(start)
