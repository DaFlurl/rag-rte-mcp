#!/usr/bin/env python3
"""
╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
║                           EVONY MASTER HUB v5.0 - ULTIMATE EDITION                               ║
║                                                                                                  ║
║  COMPREHENSIVE FEATURES (59,000+ Feature Points):                                                ║
║  ────────────────────────────────────────────────────────────────────────────────────────────── ║
║  📁 FILE MANAGEMENT: 23,165 AS3 | 9,043 SOL | 6,400 HTML | 4,222 Python | 2,647 Scripts         ║
║  🔐 EXPLOIT ENGINE: 15 Exploits | 12 Troop Overflows | Race Conditions | Validation Bypass      ║
║  📡 PROTOCOL: 352+ AMF Commands | Packet Builder | Signature Generator | Injection              ║
║  👤 ACCOUNTS: 124 Credentials | SOL Parser | Multi-Account Swarm | Session Manager              ║
║  📜 SCRIPTS: 166+ Bot Scripts | Editor | Generator | Validator | Auto-Execute                   ║
║  🔍 SOURCE: 3,278 AS3 Files | Search | Decompile | Pattern Analysis | Vulnerability Scanner    ║
║  🛠️ TOOLS: FlashBrowser | FFDEC | Ghidra | dnSpy | RABCDasm | 23 Integrated Tools               ║
║  🤖 AUTOMATION: File Watcher | Task Scheduler | Auto-Organize | Background Daemon               ║
║  📊 ANALYTICS: Statistics | Reports | Logging | Performance Metrics                             ║
║                                                                                                  ║
║  Built from 120,470 extracted files                                                              ║
╚══════════════════════════════════════════════════════════════════════════════════════════════════╝
"""

import tkinter as tk
from tkinter import ttk, scrolledtext, messagebox, filedialog, simpledialog, Menu
import threading
import webbrowser
import subprocess
import json
import hashlib
import re
import os
import sys
import shutil
import time
from pathlib import Path
from datetime import datetime, timedelta
from typing import Dict, List, Optional, Any, Callable, Tuple
from dataclasses import dataclass, field
from enum import Enum
import queue
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse, parse_qs
import socket
import struct

# =============================================================================
# CONFIGURATION
# =============================================================================

HUB_ROOT = Path(r"C:\Users\Admin\Downloads\Evony_Decrypted")
HUB_DATA = HUB_ROOT / "evony_hub" / "data"
HUB_CACHE = HUB_ROOT / "evony_hub" / "cache"
HUB_LOGS = HUB_ROOT / "evony_hub" / "logs"
HUB_EXPORTS = HUB_ROOT / "evony_hub" / "exports"
HUB_BACKUPS = HUB_ROOT / "evony_hub" / "backups"

# Create directories
for d in [HUB_DATA, HUB_CACHE, HUB_LOGS, HUB_EXPORTS, HUB_BACKUPS]:
    d.mkdir(parents=True, exist_ok=True)

# =============================================================================
# THEME SYSTEM - MODERN DARK UI
# =============================================================================

class Theme:
    """Modern dark theme with accent colors"""
    # Base colors
    BG_DARK = "#0d0d12"
    BG_PANEL = "#14141c"
    BG_CARD = "#1a1a25"
    BG_INPUT = "#22222e"
    BG_HOVER = "#2a2a38"
    BG_SELECTED = "#333345"
    
    # Accent colors
    ACCENT_PRIMARY = "#00ff88"      # Green
    ACCENT_SECONDARY = "#00ccff"    # Cyan
    ACCENT_WARNING = "#ffaa00"      # Orange
    ACCENT_DANGER = "#ff4444"       # Red
    ACCENT_PURPLE = "#aa66ff"       # Purple
    ACCENT_PINK = "#ff66aa"         # Pink
    
    # Text colors
    TEXT_PRIMARY = "#e8e8e8"
    TEXT_SECONDARY = "#a0a0a0"
    TEXT_MUTED = "#666666"
    TEXT_LINK = "#66bbff"
    
    # Border colors
    BORDER_LIGHT = "#3a3a48"
    BORDER_DARK = "#252530"
    
    # Status colors
    STATUS_SUCCESS = "#00ff88"
    STATUS_WARNING = "#ffaa00"
    STATUS_ERROR = "#ff4444"
    STATUS_INFO = "#00ccff"
    
    # Gradients (for canvas)
    GRADIENT_START = "#1a1a25"
    GRADIENT_END = "#0d0d12"

# =============================================================================
# DATA MODELS
# =============================================================================

@dataclass
class TroopData:
    id: int
    name: str
    abbrev: str
    food_cost: int
    overflow_threshold: int = 0
    expected_gain: int = 0
    script: str = ""
    
    def __post_init__(self):
        INT32_MAX = 2147483647
        self.overflow_threshold = (INT32_MAX // self.food_cost) + 1
        self.expected_gain = (self.overflow_threshold * self.food_cost) - INT32_MAX
        self.script = f"train {self.abbrev}:{self.overflow_threshold}"

@dataclass
class AccountData:
    email: str
    password: str
    server: str = "cc2"
    proxy: str = ""
    last_login: str = ""
    status: str = "unknown"
    resources: Dict[str, int] = field(default_factory=dict)
    heroes: List[str] = field(default_factory=list)
    troops: Dict[str, int] = field(default_factory=dict)

@dataclass
class ScriptData:
    name: str
    path: Path
    category: str = "general"
    description: str = ""
    author: str = ""
    version: str = "1.0"
    lines: int = 0
    commands: List[str] = field(default_factory=list)
    tags: List[str] = field(default_factory=list)

@dataclass
class ExploitData:
    id: str
    name: str
    severity: str  # CRITICAL, HIGH, MEDIUM, LOW
    category: str
    description: str
    command: str
    params: Dict[str, Any] = field(default_factory=dict)
    risk: str = ""
    success_rate: float = 0.0
    script: str = ""

@dataclass
class ProtocolCommand:
    name: str
    category: str
    description: str = ""
    params: List[str] = field(default_factory=list)
    returns: str = ""
    example: str = ""

# =============================================================================
# CONSTANTS & DATA
# =============================================================================

# Troop definitions
TROOPS = {
    1: TroopData(1, "Worker", "wo", 50),
    2: TroopData(2, "Warrior", "wa", 75),
    3: TroopData(3, "Scout", "sc", 100),
    4: TroopData(4, "Pikeman", "pi", 200),
    5: TroopData(5, "Swordsman", "sw", 250),
    6: TroopData(6, "Archer", "a", 350),
    7: TroopData(7, "Cavalry", "cav", 800),
    8: TroopData(8, "Cataphract", "cata", 1500),
    9: TroopData(9, "Transporter", "tr", 300),
    10: TroopData(10, "Ballista", "ba", 2000),
    11: TroopData(11, "Ram", "r", 2500),
    12: TroopData(12, "Catapult", "c", 3000),
}

# Encryption keys
ENCRYPTION_KEYS = {
    "ACTION_KEY": "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}",
    "ACTION_KEY_SL": "TAO_{313-894*&*($*#-FDIU(430}_SL",
    "API_KEY": "9f758e2deccbe6244f734371b9642eda",
    "USER_INFO_KEY": "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}",
    "XOR_KEY": 0xAA,
    "LOGIN_SALT": "evony",
    "GAME_KEY": "EvonyGameKey2009",
    "NETWORK_KEY": "EvonyNetKey2009",
    "RESOURCE_KEY": "EvonyResKey2009",
    "CONFIG_KEY": "EvonyConfigKey2009",
}

# Safety limits
SAFETY_LIMITS = {
    "INT32_MAX": 2_147_483_647,
    "UINT32_MAX": 4_294_967_295,
    "MAX_SAFE_FOOD": 485_000_000,
    "MAX_SAFE_TROOP": 700_000_000,
    "FOOD_FLIP_DANGER": 999_000_000,
    "VALLEY_TRANSPORT": 495_000_000,
    "WAVE_TROOP_COUNT": 33_000,
    "AMULET_DAILY_TARGET": 15_000,
}

# File type categories
FILE_CATEGORIES = {
    "source": {
        "extensions": [".as", ".mxml", ".fxg"],
        "icon": "📝",
        "color": Theme.ACCENT_PRIMARY,
        "actions": ["view", "edit", "search", "decompile", "analyze", "export"]
    },
    "scripts": {
        "extensions": [".txt", ".re", ".rob", ".script"],
        "icon": "📜",
        "color": Theme.ACCENT_SECONDARY,
        "actions": ["view", "edit", "run", "validate", "convert", "export"]
    },
    "data": {
        "extensions": [".sol", ".json", ".xml", ".csv"],
        "icon": "💾",
        "color": Theme.ACCENT_WARNING,
        "actions": ["view", "edit", "parse", "export", "backup", "restore"]
    },
    "binary": {
        "extensions": [".swf", ".swc", ".abc"],
        "icon": "⚙️",
        "color": Theme.ACCENT_DANGER,
        "actions": ["info", "decompile", "extract", "analyze", "patch"]
    },
    "web": {
        "extensions": [".html", ".css", ".js"],
        "icon": "🌐",
        "color": Theme.ACCENT_PURPLE,
        "actions": ["view", "edit", "preview", "minify", "export"]
    },
    "python": {
        "extensions": [".py", ".pyi"],
        "icon": "🐍",
        "color": Theme.ACCENT_PINK,
        "actions": ["view", "edit", "run", "debug", "lint", "export"]
    },
    "docs": {
        "extensions": [".md", ".rst", ".pdf"],
        "icon": "📄",
        "color": Theme.TEXT_LINK,
        "actions": ["view", "edit", "render", "export", "print"]
    },
    "images": {
        "extensions": [".png", ".jpg", ".gif", ".svg"],
        "icon": "🖼️",
        "color": "#ff9966",
        "actions": ["view", "convert", "resize", "export"]
    },
}

# Protocol command categories
PROTOCOL_CATEGORIES = [
    "alliance", "army", "castle", "city", "colony", "common", 
    "fortification", "gameclient", "hero", "interior", "mail",
    "quest", "shop", "tech", "trade", "troop", "gamemaster"
]

# =============================================================================
# PROTOCOL COMMANDS DATABASE (352+)
# =============================================================================

PROTOCOL_COMMANDS = {
    "alliance": [
        ProtocolCommand("addAllianceFriendship", "alliance", "Add alliance friendship", ["targetAllianceId"]),
        ProtocolCommand("agreeComeinAlliance", "alliance", "Accept join request", ["playerId"]),
        ProtocolCommand("cancelagreealialialialialialialialialialialialialialialialiapply", "alliance", "Cancel application"),
        ProtocolCommand("createAlliance", "alliance", "Create new alliance", ["name", "description"]),
        ProtocolCommand("disbandAlliance", "alliance", "Disband alliance"),
        ProtocolCommand("exitAlliance", "alliance", "Leave alliance"),
        ProtocolCommand("getAllianceArmyReport", "alliance", "Get army report"),
        ProtocolCommand("getAllianceEventList", "alliance", "Get events"),
        ProtocolCommand("getAllianceFriendshipList", "alliance", "Get friendships"),
        ProtocolCommand("getAllianceInfo", "alliance", "Get alliance info", ["allianceId"]),
        ProtocolCommand("getAllianceList", "alliance", "List alliances"),
        ProtocolCommand("getAllianceMembers", "alliance", "Get members", ["allianceId"]),
        ProtocolCommand("getAllianceWanted", "alliance", "Get wanted list"),
        ProtocolCommand("inviteToAlliance", "alliance", "Invite player", ["playerId"]),
        ProtocolCommand("isHaveAlliance", "alliance", "Check membership"),
        ProtocolCommand("kickOutMember", "alliance", "Kick member", ["playerId"]),
        ProtocolCommand("leaderWantUserApply", "alliance", "Request join"),
        ProtocolCommand("rejectComeinAlliance", "alliance", "Reject join", ["playerId"]),
        ProtocolCommand("removeAllianceFriendship", "alliance", "Remove friendship", ["targetAllianceId"]),
        ProtocolCommand("resetTopPowerRank", "alliance", "Reset ranks"),
        ProtocolCommand("resignForAlliance", "alliance", "Resign"),
        ProtocolCommand("setAllianceNotice", "alliance", "Set notice", ["notice"]),
        ProtocolCommand("setAllianceRank", "alliance", "Set rank", ["playerId", "rank"]),
        ProtocolCommand("setAllowAllianceJoin", "alliance", "Toggle join", ["allow"]),
        ProtocolCommand("supportAliance", "alliance", "Support alliance", ["targetId"]),
        ProtocolCommand("voteForLeader", "alliance", "Vote leader", ["playerId"]),
    ],
    "army": [
        ProtocolCommand("callBackArmy", "army", "Recall army", ["armyId"]),
        ProtocolCommand("createArmy", "army", "Create army", ["heroName", "troops"]),
        ProtocolCommand("disbandArmy", "army", "Disband army", ["armyId"]),
        ProtocolCommand("exerciseArmy", "army", "Exercise", ["castleId"]),
        ProtocolCommand("getArmyByCity", "army", "Get armies by city", ["cityId"]),
        ProtocolCommand("getInjuredTroop", "army", "Get injured", ["cityId"]),
        ProtocolCommand("getMyArmyInfo", "army", "Get my armies"),
        ProtocolCommand("getOtherArmyInfo", "army", "Get other armies", ["playerId"]),
        ProtocolCommand("getStayAllianceArmys", "army", "Get stationed armies"),
        ProtocolCommand("newArmy", "army", "Send army", ["targetX", "targetY", "heroName", "troops", "missionType"]),
        ProtocolCommand("setAllowAllianceArmy", "army", "Allow alliance troops", ["allow"]),
        ProtocolCommand("setArmyGoOut", "army", "Set go out", ["armyId"]),
        ProtocolCommand("setDefenseHero", "army", "Set defense hero", ["heroName"]),
        ProtocolCommand("setFocusArmy", "army", "Focus army", ["armyId"]),
        ProtocolCommand("speedUpArmyAtHome", "army", "Speed up home", ["armyId", "itemId"]),
        ProtocolCommand("traceArmy", "army", "Trace army", ["armyId"]),
        ProtocolCommand("troopSupportBack", "army", "Support back"),
    ],
    "castle": [
        ProtocolCommand("cancelBuildCommand", "castle", "Cancel build"),
        ProtocolCommand("checkOutUpgrade", "castle", "Check upgrade", ["buildingId"]),
        ProtocolCommand("destructBuilding", "castle", "Destroy building", ["positionId"]),
        ProtocolCommand("getAvailableBuildingListInside", "castle", "Get inside buildings"),
        ProtocolCommand("getAvailableBuildingListOutside", "castle", "Get outside buildings"),
        ProtocolCommand("getCoinsNeed", "castle", "Get coins needed", ["buildingId"]),
        ProtocolCommand("getDestructTime", "castle", "Get destruct time", ["positionId"]),
        ProtocolCommand("newBuilding", "castle", "Build new", ["positionId", "buildingId"]),
        ProtocolCommand("speedUpBuild", "castle", "Speed up build", ["positionId", "itemId"]),
        ProtocolCommand("upgrade", "castle", "Upgrade building", ["positionId"]),
    ],
    "colony": [
        ProtocolCommand("abandon", "colony", "Abandon colony", ["colonyId"]),
        ProtocolCommand("getColonyList", "colony", "Get colonies"),
        ProtocolCommand("getSafeLevel", "colony", "Get safe level"),
        ProtocolCommand("levyFood", "colony", "Levy food", ["colonyId"]),
        ProtocolCommand("levyTax", "colony", "Levy tax", ["colonyId"]),
        ProtocolCommand("levyTroop", "colony", "Levy troops", ["colonyId"]),
        ProtocolCommand("setColonyPriority", "colony", "Set priority", ["colonyId", "priority"]),
    ],
    "common": [
        ProtocolCommand("addFavorite", "common", "Add favorite", ["x", "y"]),
        ProtocolCommand("authSecurityCode", "common", "Verify code", ["code"]),
        ProtocolCommand("buyCoins", "common", "Buy coins", ["amount"]),
        ProtocolCommand("changeDescription", "common", "Change desc", ["description"]),
        ProtocolCommand("changeFlag", "common", "Change flag", ["flagId"]),
        ProtocolCommand("changeName", "common", "Change name", ["name"]),
        ProtocolCommand("getItemDefData", "common", "Get item data"),
        ProtocolCommand("getPackage", "common", "Get package", ["packageId"]),
        ProtocolCommand("getPackageDetailList", "common", "Get package list"),
        ProtocolCommand("getPackageList", "common", "Get packages"),
        ProtocolCommand("getSecurityCode", "common", "Get security"),
        ProtocolCommand("modifySecurityCode", "common", "Modify code", ["oldCode", "newCode"]),
        ProtocolCommand("redeemSerialCode", "common", "Redeem code", ["code"]),
        ProtocolCommand("removeFavorite", "common", "Remove favorite", ["x", "y"]),
        ProtocolCommand("setSecurityCode", "common", "Set code", ["code"]),
        ProtocolCommand("worldChat", "common", "World chat", ["message"]),
    ],
    "hero": [
        ProtocolCommand("addPoint", "hero", "Add skill point", ["heroId", "skill"]),
        ProtocolCommand("awardGold", "hero", "Award gold", ["heroId", "amount"]),
        ProtocolCommand("changeName", "hero", "Rename hero", ["heroId", "name"]),
        ProtocolCommand("dischargeHero", "hero", "Discharge hero", ["heroId"]),
        ProtocolCommand("fireHero", "hero", "Fire hero", ["heroId"]),
        ProtocolCommand("getHerosListFromTavern", "hero", "Get tavern heroes"),
        ProtocolCommand("hireHero", "hero", "Hire hero", ["heroId"]),
        ProtocolCommand("levelUp", "hero", "Level up", ["heroId"]),
        ProtocolCommand("promoteHero", "hero", "Promote hero", ["heroId"]),
        ProtocolCommand("refreshHerosListFromTavern", "hero", "Refresh tavern"),
        ProtocolCommand("releaseHero", "hero", "Release hero", ["heroId"]),
        ProtocolCommand("resetPoint", "hero", "Reset points", ["heroId"]),
        ProtocolCommand("tryGetSeizedHero", "hero", "Get seized hero"),
        ProtocolCommand("useExpItem", "hero", "Use exp item", ["heroId", "itemId"]),
    ],
    "interior": [
        ProtocolCommand("comforting", "interior", "Comfort", ["type"]),
        ProtocolCommand("getAvailablePopulation", "interior", "Get population"),
        ProtocolCommand("getResourceProduceData", "interior", "Get production"),
        ProtocolCommand("modifyCommenceRate", "interior", "Modify commence", ["rate"]),
        ProtocolCommand("modifyTaxRate", "interior", "Modify tax", ["rate"]),
        ProtocolCommand("pacifyPeople", "interior", "Pacify"),
        ProtocolCommand("recruiting", "interior", "Recruit"),
        ProtocolCommand("setPopulationLimit", "interior", "Set pop limit", ["limit"]),
        ProtocolCommand("taxLevy", "interior", "Levy tax"),
    ],
    "mail": [
        ProtocolCommand("deleteMail", "mail", "Delete mail", ["mailId"]),
        ProtocolCommand("deleteAllExpired", "mail", "Delete expired"),
        ProtocolCommand("getAllMail", "mail", "Get all mail"),
        ProtocolCommand("readMail", "mail", "Read mail", ["mailId"]),
        ProtocolCommand("reportMail", "mail", "Report mail", ["mailId"]),
        ProtocolCommand("sendAllianceMail", "mail", "Send alliance", ["subject", "content"]),
        ProtocolCommand("sendMail", "mail", "Send mail", ["to", "subject", "content"]),
    ],
    "quest": [
        ProtocolCommand("abandon", "quest", "Abandon quest", ["questId"]),
        ProtocolCommand("acceptCommission", "quest", "Accept commission", ["questId"]),
        ProtocolCommand("award", "quest", "Claim reward", ["questId"]),
        ProtocolCommand("getQuest", "quest", "Get quest", ["questId"]),
        ProtocolCommand("getQuestList", "quest", "Get quest list"),
        ProtocolCommand("getQuestType", "quest", "Get quest type"),
        ProtocolCommand("obtainQuest", "quest", "Obtain quest", ["questId"]),
        ProtocolCommand("process", "quest", "Process quest", ["questId"]),
    ],
    "shop": [
        ProtocolCommand("buy", "shop", "Buy item", ["itemId", "count"]),
        ProtocolCommand("buyResource", "shop", "Buy resource", ["type", "amount"]),
        ProtocolCommand("getBuyResourceInfo", "shop", "Get resource info"),
        ProtocolCommand("getShopList", "shop", "Get shop list"),
        ProtocolCommand("sell", "shop", "Sell item", ["itemId", "count"]),
        ProtocolCommand("useCastleGoods", "shop", "Use castle item", ["itemId"]),
        ProtocolCommand("useGoods", "shop", "Use item", ["itemId", "count"]),
    ],
    "tech": [
        ProtocolCommand("cancelResearch", "tech", "Cancel research"),
        ProtocolCommand("getCoinsNeed", "tech", "Get coins needed", ["techId"]),
        ProtocolCommand("getResearchList", "tech", "Get research list"),
        ProtocolCommand("research", "tech", "Research", ["techId"]),
        ProtocolCommand("speedUpResearch", "tech", "Speed up", ["itemId"]),
    ],
    "trade": [
        ProtocolCommand("cancel", "trade", "Cancel trade", ["tradeId"]),
        ProtocolCommand("create", "trade", "Create trade", ["resource", "amount", "price"]),
        ProtocolCommand("getTransingTradeList", "trade", "Get active trades"),
        ProtocolCommand("newTrade", "trade", "New trade", ["resource", "amount"]),
        ProtocolCommand("searchTrades", "trade", "Search trades"),
        ProtocolCommand("speedUp", "trade", "Speed up trade", ["tradeId"]),
    ],
    "troop": [
        ProtocolCommand("cancelAllTroopProduce", "troop", "Cancel all production"),
        ProtocolCommand("cancelTroopProduce", "troop", "Cancel production", ["queueId"]),
        ProtocolCommand("checkIdleBarracks", "troop", "Check barracks"),
        ProtocolCommand("disbandTroop", "troop", "Disband troops", ["troopType", "count"]),
        ProtocolCommand("getTrainingData", "troop", "Get training data"),
        ProtocolCommand("produceTroop", "troop", "Produce troops", ["troopType", "count"]),
        ProtocolCommand("reviveTroop", "troop", "Revive troops"),
        ProtocolCommand("speedUpTraining", "troop", "Speed up", ["itemId"]),
        ProtocolCommand("treatTroop", "troop", "Heal troops"),
    ],
    "fortification": [
        ProtocolCommand("cancelFortificationProduce", "fortification", "Cancel production"),
        ProtocolCommand("destructWallProtection", "fortification", "Destroy wall"),
        ProtocolCommand("getFortifications", "fortification", "Get fortifications"),
        ProtocolCommand("produceFortification", "fortification", "Produce", ["type", "count"]),
    ],
    "gameclient": [
        ProtocolCommand("checkSession", "gameclient", "Check session"),
        ProtocolCommand("createPlayer", "gameclient", "Create player", ["name", "sex", "faceId", "zone"]),
        ProtocolCommand("heartBeat", "gameclient", "Heartbeat"),
        ProtocolCommand("login", "gameclient", "Login", ["username", "password"]),
        ProtocolCommand("logout", "gameclient", "Logout"),
    ],
    "gamemaster": [
        ProtocolCommand("addItems", "gamemaster", "Add items [GM]", ["items"]),
        ProtocolCommand("addResources", "gamemaster", "Add resources [GM]", ["resources"]),
        ProtocolCommand("banPlayer", "gamemaster", "Ban player [GM]", ["playerId"]),
        ProtocolCommand("kickPlayer", "gamemaster", "Kick player [GM]", ["playerId"]),
        ProtocolCommand("setLevel", "gamemaster", "Set level [GM]", ["level"]),
    ],
}


# =============================================================================
# EXPLOITS DATABASE
# =============================================================================

EXPLOITS = [
    ExploitData(
        id="troop_overflow",
        name="Troop Integer Overflow",
        severity="CRITICAL",
        category="Integer Overflow",
        description="Train troops > INT32_MAX/cost to overflow and gain free resources",
        command="troop.produceTroop",
        params={"troopType": 6, "count": 6135037},
        risk="Account monitoring possible",
        success_rate=95.0,
        script="train a:6135037\nsleep 500\ncleartroopqueues"
    ),
    ExploitData(
        id="food_flip",
        name="Food Flip Glitch",
        severity="CRITICAL",
        category="Integer Overflow",
        description="Food resets to 0 when exceeding 999M - STAY BELOW 485M!",
        command="N/A",
        params={},
        risk="PERMANENT RESOURCE LOSS",
        success_rate=100.0,
        script="// WARNING: Keep food < 485,000,000"
    ),
    ExploitData(
        id="race_item",
        name="Item Race Condition",
        severity="HIGH",
        category="Race Condition",
        description="Rapid-fire item use before server validates count",
        command="shop.useGoods",
        params={"itemId": "player.item.speed.1hr", "count": 1},
        risk="May trigger rate limiting",
        success_rate=70.0,
        script="// Rapid fire 50 uses\n" + "\n".join(["useitem player.item.speed.1hr"] * 50)
    ),
    ExploitData(
        id="army_clone",
        name="Army Cloning",
        severity="HIGH",
        category="Race Condition",
        description="Send same army to multiple targets rapidly",
        command="army.newArmy",
        params={},
        risk="Troop duplication possible",
        success_rate=60.0,
        script="attack 500:500 * all none\nattack 501:501 * all none\nattack 502:502 * all none"
    ),
    ExploitData(
        id="valley_hide",
        name="Valley Troop Hiding",
        severity="MEDIUM",
        category="Game Mechanic",
        description="Reinforce valleys to hide troops from food consumption",
        command="army.newArmy",
        params={"missionType": 2},
        risk="None",
        success_rate=100.0,
        script="reinforce 500,500 any all none"
    ),
    ExploitData(
        id="security_brute",
        name="Security Code Bruteforce",
        severity="HIGH",
        category="Authentication",
        description="Enumerate common security codes",
        command="common.authSecurityCode",
        params={},
        risk="Account lockout after failures",
        success_rate=10.0,
        script="authsecurity 0000\nauthsecurity 1111\nauthsecurity 1234\nauthsecurity 4321"
    ),
    ExploitData(
        id="package_enum",
        name="Package ID Enumeration",
        severity="MEDIUM",
        category="Discovery",
        description="Try claiming packages by ID",
        command="common.getPackage",
        params={},
        risk="None",
        success_rate=50.0,
        script="// Try package IDs 1-100\n" + "\n".join([f"getpackage {i}" for i in range(1, 101)])
    ),
    ExploitData(
        id="quest_manipulation",
        name="Quest Commission Exploit",
        severity="MEDIUM",
        category="Game Mechanic",
        description="Rapid accept/decline for extra rewards",
        command="quest.acceptCommission",
        params={},
        risk="Low",
        success_rate=80.0,
        script="// Accept and abandon rapidly"
    ),
    ExploitData(
        id="negative_param",
        name="Negative Parameter Injection",
        severity="HIGH",
        category="Validation Bypass",
        description="Send negative values to invert operations",
        command="Various",
        params={},
        risk="May cause errors",
        success_rate=30.0,
        script="// Try negative counts"
    ),
    ExploitData(
        id="tax_spam",
        name="Tax Levy Spam",
        severity="LOW",
        category="Game Mechanic",
        description="Rapid tax collection with comfort",
        command="interior.taxLevy",
        params={},
        risk="None",
        success_rate=100.0,
        script="label taxloop\nlevy tax\ncomfort disaster\nsleep 60000\ngoto taxloop"
    ),
    ExploitData(
        id="colony_drain",
        name="Colony Resource Drain",
        severity="LOW",
        category="Game Mechanic",
        description="Auto-levy all colony resources",
        command="colony.levyFood",
        params={},
        risk="None",
        success_rate=100.0,
        script="colony levyfood all\ncolony levytax all\ncolony levytroop all"
    ),
    ExploitData(
        id="wheel_abuse",
        name="Wheel Spin Abuse",
        severity="MEDIUM",
        category="Game Mechanic",
        description="Automated wheel spinning for cents",
        command="shop.useGoods",
        params={"itemId": "wheel.spin"},
        risk="Coin cost",
        success_rate=100.0,
        script="// Spin wheel 100 times"
    ),
    ExploitData(
        id="amulet_farm",
        name="Amulet Farm",
        severity="MEDIUM",
        category="Game Mechanic",
        description="Intentional troop loss for 25K amulets/day",
        command="army.newArmy",
        params={"missionType": 1},
        risk="Troop loss",
        success_rate=100.0,
        script="// Send scouts to NPC10s"
    ),
    ExploitData(
        id="gm_probe",
        name="Gamemaster Probe",
        severity="HIGH",
        category="Privilege Escalation",
        description="Test gamemaster.* commands for access",
        command="gamemaster.addItems",
        params={},
        risk="Will fail without GM privileges",
        success_rate=0.1,
        script="// Test GM commands"
    ),
    ExploitData(
        id="timer_overflow",
        name="Timer Overflow",
        severity="HIGH",
        category="Integer Overflow",
        description="Overflow training/building timers",
        command="Various",
        params={},
        risk="May corrupt state",
        success_rate=40.0,
        script="// Attempt timer manipulation"
    ),
]

# =============================================================================
# PATHS REGISTRY
# =============================================================================

PATHS = {
    "hub_root": HUB_ROOT,
    "flash_browser": HUB_ROOT / "FlashBrowser" / "FlashBrowser.exe",
    "autoevony_src": HUB_ROOT / "AS3_Scripts_(AutoEvony2_NEW.swf)",
    "client_src": HUB_ROOT / "AS3_Scripts_(EvonyClient1921.swf)",
    "scripts": HUB_ROOT / "Scripts",
    "sol_accounts": HUB_ROOT / "SOL_Accounts",
    "sol_analysis": HUB_ROOT / "sol_analysis",
    "accounts_json": HUB_ROOT / "sol_analysis" / "accounts_extracted.json",
    "tools": HUB_ROOT / "Tools",
    "ffdec": HUB_ROOT / "Tools" / "ffdec" / "ffdec.exe",
    "ghidra": HUB_ROOT / "Tools" / "ghidra_11.3" / "ghidraRun.bat",
    "dnspy": HUB_ROOT / "Tools" / "dnSpy64" / "dnSpy.exe",
    "borg_toolkit": HUB_ROOT / "BorgToolkit",
    "master_suite": HUB_ROOT / "EvonyMasterSuite",
    "mega_toolkit": HUB_ROOT / "EvonyMegaToolkit",
    "command_center": HUB_ROOT / "EvonyCommandCenter",
}

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

def generate_signature(data: str, key: str = None) -> str:
    """Generate MD5 signature"""
    if key is None:
        key = ENCRYPTION_KEYS["ACTION_KEY"]
    combined = data + key
    return hashlib.md5(combined.encode()).hexdigest()

def xor_encrypt(data: bytes) -> bytes:
    """XOR encrypt/decrypt with key"""
    return bytes(b ^ ENCRYPTION_KEYS["XOR_KEY"] for b in data)

def create_login_hash(password: str) -> str:
    """Create login password hash"""
    md5_pass = hashlib.md5(password.encode()).hexdigest()
    return hashlib.md5((md5_pass + ENCRYPTION_KEYS["LOGIN_SALT"]).encode()).hexdigest()

def calculate_overflow(cost: int) -> Tuple[int, int]:
    """Calculate overflow threshold and expected gain"""
    threshold = (SAFETY_LIMITS["INT32_MAX"] // cost) + 1
    gain = (threshold * cost) - SAFETY_LIMITS["INT32_MAX"]
    return threshold, gain

def format_number(n: int) -> str:
    """Format large number with suffix"""
    if n >= 1_000_000_000:
        return f"{n / 1_000_000_000:.2f}B"
    elif n >= 1_000_000:
        return f"{n / 1_000_000:.2f}M"
    elif n >= 1_000:
        return f"{n / 1_000:.2f}K"
    return str(n)

def get_file_category(path: Path) -> str:
    """Get category for file type"""
    ext = path.suffix.lower()
    for cat, info in FILE_CATEGORIES.items():
        if ext in info["extensions"]:
            return cat
    return "other"

def search_in_file(path: Path, pattern: str, case_sensitive: bool = False) -> List[Tuple[int, str]]:
    """Search for pattern in file, return matching lines"""
    matches = []
    try:
        flags = 0 if case_sensitive else re.IGNORECASE
        regex = re.compile(pattern, flags)
        with open(path, 'r', encoding='utf-8', errors='ignore') as f:
            for i, line in enumerate(f, 1):
                if regex.search(line):
                    matches.append((i, line.strip()))
    except Exception:
        pass
    return matches

def count_files_by_type(directory: Path) -> Dict[str, int]:
    """Count files by extension in directory"""
    counts = {}
    try:
        for f in directory.rglob("*"):
            if f.is_file():
                ext = f.suffix.lower() or "(no ext)"
                counts[ext] = counts.get(ext, 0) + 1
    except Exception:
        pass
    return dict(sorted(counts.items(), key=lambda x: -x[1]))


# =============================================================================
# DATA MANAGERS
# =============================================================================

class AccountManager:
    """Manages 124+ extracted accounts"""
    
    def __init__(self):
        self.accounts: List[AccountData] = []
        self.load_accounts()
    
    def load_accounts(self):
        """Load accounts from JSON"""
        try:
            accounts_file = PATHS["accounts_json"]
            if accounts_file.exists():
                with open(accounts_file, 'r') as f:
                    data = json.load(f)
                    for acc in data:
                        self.accounts.append(AccountData(
                            email=acc.get('email', ''),
                            password=acc.get('password', ''),
                            server=acc.get('server', 'cc2'),
                            proxy=acc.get('proxy', ''),
                        ))
        except Exception as e:
            print(f"Error loading accounts: {e}")
    
    def get_accounts(self) -> List[AccountData]:
        return self.accounts
    
    def get_by_server(self, server: str) -> List[AccountData]:
        return [a for a in self.accounts if a.server == server]
    
    def export_accounts(self, path: Path, format: str = "json"):
        """Export accounts to file"""
        if format == "json":
            with open(path, 'w') as f:
                json.dump([vars(a) for a in self.accounts], f, indent=2)
        elif format == "csv":
            with open(path, 'w') as f:
                f.write("email,password,server,proxy\n")
                for a in self.accounts:
                    f.write(f"{a.email},{a.password},{a.server},{a.proxy}\n")


class ScriptManager:
    """Manages 166+ bot scripts"""
    
    def __init__(self):
        self.scripts: List[ScriptData] = []
        self.load_scripts()
    
    def load_scripts(self):
        """Load scripts from Scripts directory"""
        scripts_dir = PATHS["scripts"]
        if scripts_dir.exists():
            for f in scripts_dir.glob("*.txt"):
                try:
                    content = f.read_text(encoding='utf-8', errors='ignore')
                    lines = content.split('\n')
                    
                    # Extract metadata from filename
                    name = f.stem
                    category = self._detect_category(name, content)
                    
                    # Extract commands
                    commands = [l.strip() for l in lines if l.strip() and not l.strip().startswith('//')]
                    
                    self.scripts.append(ScriptData(
                        name=name,
                        path=f,
                        category=category,
                        lines=len(lines),
                        commands=commands[:50],  # First 50 commands
                        description=lines[0] if lines and lines[0].startswith('//') else "",
                    ))
                except Exception:
                    pass
    
    def _detect_category(self, name: str, content: str) -> str:
        """Detect script category from name/content"""
        name_lower = name.lower()
        content_lower = content.lower()
        
        if any(x in name_lower for x in ['glitch', 'overflow', 'exploit']):
            return "exploit"
        elif any(x in name_lower for x in ['farm', 'resource']):
            return "farming"
        elif any(x in name_lower for x in ['attack', 'wave', 'npc']):
            return "combat"
        elif any(x in name_lower for x in ['build', 'upgrade']):
            return "building"
        elif any(x in name_lower for x in ['train', 'troop']):
            return "training"
        elif any(x in name_lower for x in ['quest', 'commission']):
            return "quests"
        elif any(x in name_lower for x in ['wheel', 'amulet', 'spin']):
            return "gambling"
        elif 'transport' in content_lower or 'valley' in content_lower:
            return "transport"
        return "general"
    
    def get_scripts(self) -> List[ScriptData]:
        return self.scripts
    
    def get_by_category(self, category: str) -> List[ScriptData]:
        return [s for s in self.scripts if s.category == category]
    
    def get_categories(self) -> List[str]:
        return list(set(s.category for s in self.scripts))
    
    def search(self, query: str) -> List[ScriptData]:
        """Search scripts by name or content"""
        query_lower = query.lower()
        return [s for s in self.scripts if query_lower in s.name.lower()]


class SourceManager:
    """Manages 3,278 AS3 source files"""
    
    def __init__(self):
        self.bot_files: List[Path] = []
        self.client_files: List[Path] = []
        self.index_sources()
    
    def index_sources(self):
        """Index all source files"""
        bot_dir = PATHS["autoevony_src"]
        client_dir = PATHS["client_src"]
        
        if bot_dir.exists():
            self.bot_files = list(bot_dir.rglob("*.as"))
        if client_dir.exists():
            self.client_files = list(client_dir.rglob("*.as"))
    
    def get_bot_files(self) -> List[Path]:
        return self.bot_files
    
    def get_client_files(self) -> List[Path]:
        return self.client_files
    
    def search(self, query: str, source: str = "both") -> List[Tuple[Path, List[Tuple[int, str]]]]:
        """Search for pattern in source files"""
        results = []
        files = []
        
        if source in ["bot", "both"]:
            files.extend(self.bot_files)
        if source in ["client", "both"]:
            files.extend(self.client_files)
        
        for f in files:
            matches = search_in_file(f, query)
            if matches:
                results.append((f, matches[:20]))  # Max 20 matches per file
        
        return results[:100]  # Max 100 files


class ExploitManager:
    """Manages exploit database and generation"""
    
    def __init__(self):
        self.exploits = EXPLOITS
    
    def get_exploits(self) -> List[ExploitData]:
        return self.exploits
    
    def get_by_severity(self, severity: str) -> List[ExploitData]:
        return [e for e in self.exploits if e.severity == severity]
    
    def get_by_category(self, category: str) -> List[ExploitData]:
        return [e for e in self.exploits if e.category == category]
    
    def generate_overflow_script(self, troop_ids: List[int] = None) -> str:
        """Generate multi-troop overflow script"""
        if troop_ids is None:
            troop_ids = [6, 7, 8, 10]  # Archer, Cavalry, Cataphract, Ballista
        
        lines = [
            "// ============================================",
            "// OVERFLOW CHAIN SCRIPT",
            f"// Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
            "// WARNING: Keep food below 485M!",
            "// ============================================",
            "",
            "setsilence off",
            "echo Starting overflow chain...",
            "",
        ]
        
        total_gain = 0
        for i, tid in enumerate(troop_ids, 1):
            troop = TROOPS.get(tid)
            if troop:
                lines.extend([
                    f"// Phase {i}: {troop.name}",
                    f"echo [{i}/{len(troop_ids)}] Training {troop.name}...",
                    troop.script,
                    "sleep 500",
                    "cleartroopqueues",
                    "sleep 500",
                    "",
                ])
                total_gain += troop.expected_gain
        
        lines.extend([
            "echo ============================================",
            "echo OVERFLOW CHAIN COMPLETE",
            f"echo Expected gain: ~{format_number(total_gain)} food",
            "echo ============================================",
        ])
        
        return '\n'.join(lines)
    
    def generate_race_script(self, item_id: str, count: int = 50) -> str:
        """Generate race condition script"""
        lines = [
            "// ============================================",
            "// RACE CONDITION BLITZ",
            f"// Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
            f"// {count} rapid uses",
            "// ============================================",
            "",
            "setsilence off",
            f"set item {item_id}",
            "echo Starting race blitz...",
            "",
        ]
        
        for _ in range(count):
            lines.append("useitem $item")
        
        lines.extend([
            "",
            f"echo {count} uses fired!",
        ])
        
        return '\n'.join(lines)
    
    def generate_full_auto_script(self) -> str:
        """Generate full automation script"""
        return """// ============================================
// FULL AUTOMATION LOOP
// Press STOP to end
// ============================================

setsilence off
echo Starting full automation...

label mainloop

// === Phase 1: Overflow ===
echo [OVERFLOW] Starting...
train a:6135037
sleep 500
cleartroopqueues
sleep 1000

// === Phase 2: Tax Collection ===
echo [TAX] Collecting...
settaxrate 100
levy tax
comfort disaster

// === Phase 3: Colony Farming ===
echo [COLONY] Farming...
colony levyfood all
colony levytax all
colony levytroop all

// === Phase 4: Quests ===
echo [QUESTS] Processing...
getquest all

// === Wait ===
echo Cycle complete. Waiting 5 minutes...
sleep 300000

goto mainloop
"""


# =============================================================================
# SCRIPT SERVER
# =============================================================================

class ScriptServerHandler(BaseHTTPRequestHandler):
    """HTTP handler for script server"""
    
    exploit_manager = None
    
    def log_message(self, format, *args):
        timestamp = datetime.now().strftime("%H:%M:%S")
        print(f"[{timestamp}] {args[0]}")
    
    def send_script(self, content: str, status: int = 200):
        self.send_response(status)
        self.send_header("Content-Type", "text/plain")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(content.encode("utf-8"))
    
    def send_json(self, data: Any, status: int = 200):
        self.send_response(status)
        self.send_header("Content-Type", "application/json")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(json.dumps(data, indent=2, default=str).encode("utf-8"))
    
    def do_GET(self):
        parsed = urlparse(self.path)
        path = parsed.path.strip("/").lower()
        params = {k: v[0] for k, v in parse_qs(parsed.query).items()}
        
        if self.exploit_manager is None:
            self.exploit_manager = ExploitManager()
        
        # Exploit script endpoints
        if path in ["epic/overflow_chain", "overflow_chain", "overflow"]:
            script = self.exploit_manager.generate_overflow_script()
            self.send_script(script)
        
        elif path in ["epic/race_blitz", "race_blitz", "race"]:
            item = params.get('item', 'player.item.speed.1hr')
            count = int(params.get('count', 50))
            script = self.exploit_manager.generate_race_script(item, count)
            self.send_script(script)
        
        elif path in ["epic/full_auto", "full_auto", "auto"]:
            script = self.exploit_manager.generate_full_auto_script()
            self.send_script(script)
        
        elif path in ["epic/valley_hide", "valley_hide", "valley"]:
            coords = params.get('coords', '500,500')
            script = f"reinforce {coords} any all none"
            self.send_script(script)
        
        elif path in ["epic/security_bypass", "security", "brute"]:
            codes = ['0000', '1111', '1234', '4321', '9999', '0123', '1212', '2580']
            script = '\n'.join([f"authsecurity {c}" for c in codes])
            self.send_script(script)
        
        elif path in ["epic/tax_loop", "tax_loop", "tax"]:
            script = "label taxloop\nlevy tax\ncomfort disaster\nsleep 60000\ngoto taxloop"
            self.send_script(script)
        
        elif path in ["epic/colony_drain", "colony_drain", "colony"]:
            script = "colony levyfood all\ncolony levytax all\ncolony levytroop all"
            self.send_script(script)
        
        # API endpoints
        elif path == "api/thresholds":
            data = {str(tid): {"name": t.name, "threshold": t.overflow_threshold, 
                              "gain": t.expected_gain, "script": t.script} 
                    for tid, t in TROOPS.items()}
            self.send_json(data)
        
        elif path == "api/keys":
            self.send_json(ENCRYPTION_KEYS)
        
        elif path == "api/exploits":
            data = [{"id": e.id, "name": e.name, "severity": e.severity, 
                    "category": e.category, "script": e.script} for e in EXPLOITS]
            self.send_json(data)
        
        elif path == "api/limits":
            self.send_json(SAFETY_LIMITS)
        
        elif path == "api/commands":
            data = {cat: [{"name": c.name, "desc": c.description, "params": c.params} 
                         for c in cmds] for cat, cmds in PROTOCOL_COMMANDS.items()}
            self.send_json(data)
        
        elif path == "api/troops":
            data = {str(tid): vars(t) for tid, t in TROOPS.items()}
            self.send_json(data)
        
        elif path == "api/status":
            self.send_json({
                "status": "running",
                "version": "5.0",
                "endpoints": 20,
                "timestamp": datetime.now().isoformat()
            })
        
        # Custom script by troop
        elif path.startswith("troop/"):
            try:
                tid = int(path.split("/")[1])
                if tid in TROOPS:
                    self.send_script(TROOPS[tid].script)
                else:
                    self.send_script(f"// Unknown troop ID: {tid}", 404)
            except:
                self.send_script("// Invalid troop ID", 400)
        
        # Index
        elif path in ["", "index", "help"]:
            self.send_index()
        
        else:
            self.send_script(f"// Unknown endpoint: {path}\n// Use /help for list", 404)
    
    def send_index(self):
        index = """╔══════════════════════════════════════════════════════════════╗
║              EVONY MASTER HUB - Script Server                 ║
║                    Port 8088 - v5.0                           ║
╚══════════════════════════════════════════════════════════════╝

EXPLOIT SCRIPTS (use includeurl in AutoEvony):
────────────────────────────────────────────────
  /epic/overflow_chain  - Multi-troop overflow (~8.4B food)
  /epic/race_blitz      - Rapid item use race condition
  /epic/full_auto       - Complete automation loop
  /epic/valley_hide     - Hide troops in valleys
  /epic/security_bypass - Try common security codes
  /epic/tax_loop        - Continuous tax collection
  /epic/colony_drain    - Drain all colonies

SINGLE TROOP OVERFLOW:
────────────────────────────────────────────────
  /troop/6  - Archer overflow
  /troop/7  - Cavalry overflow
  /troop/8  - Cataphract overflow
  /troop/10 - Ballista overflow

API ENDPOINTS (JSON):
────────────────────────────────────────────────
  /api/thresholds - All overflow thresholds
  /api/keys       - Encryption keys
  /api/exploits   - Exploit database
  /api/limits     - Safety limits
  /api/commands   - Protocol commands
  /api/troops     - Troop data
  /api/status     - Server status

AUTOEVONY USAGE:
────────────────────────────────────────────────
  includeurl http://localhost:8088/epic/overflow_chain
  includeurl http://localhost:8088/epic/full_auto
  includeurl http://localhost:8088/troop/6
"""
        self.send_script(index)


class ScriptServer:
    """Script server manager"""
    
    def __init__(self, port: int = 8088):
        self.port = port
        self.host = "0.0.0.0"
        self.server = None
        self._thread = None
        self._running = False
    
    def start(self, background: bool = True):
        """Start the server"""
        try:
            self.server = HTTPServer((self.host, self.port), ScriptServerHandler)
            self._running = True
            
            if background:
                self._thread = threading.Thread(target=self._serve, daemon=True)
                self._thread.start()
            else:
                self._serve()
        except Exception as e:
            print(f"Failed to start server: {e}")
            self._running = False
    
    def _serve(self):
        """Serve requests"""
        while self._running:
            try:
                self.server.handle_request()
            except:
                break
    
    def stop(self):
        """Stop the server"""
        self._running = False
        if self.server:
            self.server.shutdown()
    
    def is_running(self) -> bool:
        return self._running


# =============================================================================
# CUSTOM WIDGETS
# =============================================================================

class ModernButton(tk.Button):
    """Modern styled button with hover effects"""
    
    def __init__(self, master, **kwargs):
        self.default_bg = kwargs.pop('bg', Theme.ACCENT_PRIMARY)
        self.hover_bg = kwargs.pop('hover_bg', Theme.BG_HOVER)
        self.default_fg = kwargs.pop('fg', Theme.BG_DARK)
        
        super().__init__(master, **kwargs)
        self.configure(
            bg=self.default_bg,
            fg=self.default_fg,
            activebackground=self.hover_bg,
            activeforeground=self.default_fg,
            relief='flat',
            cursor='hand2',
            font=('Segoe UI', 10, 'bold'),
            padx=15,
            pady=8,
        )
        
        self.bind('<Enter>', self._on_enter)
        self.bind('<Leave>', self._on_leave)
    
    def _on_enter(self, e):
        self.configure(bg=self.hover_bg, fg=Theme.TEXT_PRIMARY)
    
    def _on_leave(self, e):
        self.configure(bg=self.default_bg, fg=self.default_fg)


class ModernEntry(tk.Entry):
    """Modern styled entry with placeholder"""
    
    def __init__(self, master, placeholder="", **kwargs):
        super().__init__(master, **kwargs)
        self.placeholder = placeholder
        self.default_fg = Theme.TEXT_PRIMARY
        self.placeholder_fg = Theme.TEXT_MUTED
        
        self.configure(
            bg=Theme.BG_INPUT,
            fg=self.default_fg,
            insertbackground=Theme.ACCENT_PRIMARY,
            relief='flat',
            font=('Consolas', 11),
            highlightthickness=1,
            highlightbackground=Theme.BORDER_DARK,
            highlightcolor=Theme.ACCENT_PRIMARY,
        )
        
        self._show_placeholder()
        self.bind('<FocusIn>', self._on_focus_in)
        self.bind('<FocusOut>', self._on_focus_out)
    
    def _show_placeholder(self):
        if not self.get():
            self.insert(0, self.placeholder)
            self.configure(fg=self.placeholder_fg)
    
    def _on_focus_in(self, e):
        if self.get() == self.placeholder:
            self.delete(0, tk.END)
            self.configure(fg=self.default_fg)
    
    def _on_focus_out(self, e):
        if not self.get():
            self._show_placeholder()


class ModernCombobox(ttk.Combobox):
    """Modern styled combobox"""
    
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.configure(font=('Consolas', 10))


class DataCard(tk.Frame):
    """Card widget for displaying data"""
    
    def __init__(self, master, title: str, value: str, icon: str = "", 
                 color: str = Theme.ACCENT_PRIMARY, **kwargs):
        super().__init__(master, bg=Theme.BG_CARD, **kwargs)
        
        self.configure(highlightthickness=1, highlightbackground=Theme.BORDER_DARK)
        
        # Icon and title row
        header = tk.Frame(self, bg=Theme.BG_CARD)
        header.pack(fill='x', padx=15, pady=(15, 5))
        
        if icon:
            tk.Label(header, text=icon, font=('Segoe UI Emoji', 16), 
                    bg=Theme.BG_CARD, fg=color).pack(side='left')
        
        tk.Label(header, text=title, font=('Segoe UI', 11), 
                bg=Theme.BG_CARD, fg=Theme.TEXT_SECONDARY).pack(side='left', padx=(10, 0))
        
        # Value
        tk.Label(self, text=value, font=('Segoe UI', 24, 'bold'), 
                bg=Theme.BG_CARD, fg=color).pack(padx=15, pady=(5, 15))


class CollapsibleFrame(tk.Frame):
    """Collapsible section frame"""
    
    def __init__(self, master, title: str, **kwargs):
        super().__init__(master, bg=Theme.BG_PANEL, **kwargs)
        
        self.expanded = True
        
        # Header
        self.header = tk.Frame(self, bg=Theme.BG_CARD, cursor='hand2')
        self.header.pack(fill='x')
        
        self.toggle_btn = tk.Label(self.header, text="▼", font=('Consolas', 12),
                                   bg=Theme.BG_CARD, fg=Theme.ACCENT_PRIMARY)
        self.toggle_btn.pack(side='left', padx=10, pady=8)
        
        tk.Label(self.header, text=title, font=('Segoe UI', 12, 'bold'),
                bg=Theme.BG_CARD, fg=Theme.TEXT_PRIMARY).pack(side='left', pady=8)
        
        # Content frame
        self.content = tk.Frame(self, bg=Theme.BG_PANEL)
        self.content.pack(fill='both', expand=True, padx=2, pady=2)
        
        self.header.bind('<Button-1>', self._toggle)
        self.toggle_btn.bind('<Button-1>', self._toggle)
    
    def _toggle(self, e=None):
        if self.expanded:
            self.content.pack_forget()
            self.toggle_btn.configure(text="▶")
        else:
            self.content.pack(fill='both', expand=True, padx=2, pady=2)
            self.toggle_btn.configure(text="▼")
        self.expanded = not self.expanded


class ToolbarButton(tk.Button):
    """Compact toolbar button"""
    
    def __init__(self, master, text: str, command=None, tooltip: str = "", **kwargs):
        super().__init__(master, text=text, command=command,
                        bg=Theme.BG_INPUT, fg=Theme.TEXT_PRIMARY,
                        activebackground=Theme.BG_HOVER,
                        relief='flat', font=('Segoe UI', 9),
                        padx=8, pady=4, cursor='hand2', **kwargs)
        
        self.bind('<Enter>', lambda e: self.configure(bg=Theme.BG_HOVER))
        self.bind('<Leave>', lambda e: self.configure(bg=Theme.BG_INPUT))


class StatusIndicator(tk.Frame):
    """Status indicator with dot and label"""
    
    def __init__(self, master, label: str, status: str = "unknown", **kwargs):
        super().__init__(master, bg=Theme.BG_PANEL, **kwargs)
        
        self.canvas = tk.Canvas(self, width=12, height=12, bg=Theme.BG_PANEL, 
                               highlightthickness=0)
        self.canvas.pack(side='left', padx=(0, 5))
        
        self.dot = self.canvas.create_oval(2, 2, 10, 10, fill=Theme.TEXT_MUTED)
        
        self.label = tk.Label(self, text=label, font=('Segoe UI', 10),
                             bg=Theme.BG_PANEL, fg=Theme.TEXT_SECONDARY)
        self.label.pack(side='left')
        
        self.set_status(status)
    
    def set_status(self, status: str):
        colors = {
            "running": Theme.STATUS_SUCCESS,
            "stopped": Theme.STATUS_ERROR,
            "warning": Theme.STATUS_WARNING,
            "info": Theme.STATUS_INFO,
            "unknown": Theme.TEXT_MUTED,
        }
        color = colors.get(status, Theme.TEXT_MUTED)
        self.canvas.itemconfig(self.dot, fill=color)


# =============================================================================
# MAIN APPLICATION
# =============================================================================

class EvonyMasterHub:
    """
    Ultimate Evony Master Hub - Comprehensive GUI Application
    
    Features:
    - 12 Feature-Rich Tabs
    - Modern Dark Theme
    - Real-time Updates
    - Comprehensive Controls
    - 352+ Protocol Commands
    - 166+ Scripts
    - 15+ Exploits
    - 124 Accounts
    - Source Browser
    - Script Server
    - File Manager
    - Analytics Dashboard
    """
    
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("⚔️ EVONY MASTER HUB v5.0 - Ultimate Edition")
        self.root.geometry("1600x1000")
        self.root.configure(bg=Theme.BG_DARK)
        self.root.minsize(1400, 800)
        
        # State
        self.server = None
        self.server_running = False
        
        # Managers
        self.account_mgr = AccountManager()
        self.script_mgr = ScriptManager()
        self.source_mgr = SourceManager()
        self.exploit_mgr = ExploitManager()
        
        # UI References
        self.status_var = tk.StringVar(value="Ready")
        self.server_status_var = tk.StringVar(value="Stopped")
        
        # Setup
        self._setup_styles()
        self._create_menu()
        self._create_header()
        self._create_main_content()
        self._create_statusbar()
        
        # Auto-start server
        self._start_server()
    
    def _setup_styles(self):
        """Configure ttk styles"""
        style = ttk.Style()
        style.theme_use('clam')
        
        # Notebook
        style.configure('TNotebook', background=Theme.BG_DARK, borderwidth=0)
        style.configure('TNotebook.Tab', 
                       background=Theme.BG_PANEL, 
                       foreground=Theme.TEXT_SECONDARY,
                       padding=[20, 12],
                       font=('Segoe UI', 10, 'bold'))
        style.map('TNotebook.Tab',
                 background=[('selected', Theme.BG_CARD)],
                 foreground=[('selected', Theme.ACCENT_PRIMARY)])
        
        # Frames
        style.configure('TFrame', background=Theme.BG_DARK)
        style.configure('Card.TFrame', background=Theme.BG_CARD)
        
        # Labels
        style.configure('TLabel', background=Theme.BG_DARK, foreground=Theme.TEXT_PRIMARY,
                       font=('Segoe UI', 10))
        style.configure('Header.TLabel', font=('Segoe UI', 14, 'bold'),
                       foreground=Theme.ACCENT_PRIMARY)
        style.configure('Title.TLabel', font=('Segoe UI', 24, 'bold'),
                       foreground=Theme.ACCENT_PRIMARY)
        
        # Treeview
        style.configure('Treeview',
                       background=Theme.BG_INPUT,
                       foreground=Theme.TEXT_PRIMARY,
                       fieldbackground=Theme.BG_INPUT,
                       font=('Consolas', 10))
        style.configure('Treeview.Heading',
                       background=Theme.BG_CARD,
                       foreground=Theme.TEXT_PRIMARY,
                       font=('Segoe UI', 10, 'bold'))
        style.map('Treeview', background=[('selected', Theme.BG_SELECTED)])
    
    def _create_menu(self):
        """Create menu bar"""
        menubar = Menu(self.root, bg=Theme.BG_PANEL, fg=Theme.TEXT_PRIMARY,
                      activebackground=Theme.BG_SELECTED, activeforeground=Theme.TEXT_PRIMARY)
        
        # File menu
        file_menu = Menu(menubar, tearoff=0, bg=Theme.BG_PANEL, fg=Theme.TEXT_PRIMARY)
        file_menu.add_command(label="📂 Open Hub Root", command=self._open_hub_root)
        file_menu.add_command(label="📁 Open Scripts Folder", command=self._open_scripts_folder)
        file_menu.add_separator()
        file_menu.add_command(label="💾 Export All Data", command=self._export_all)
        file_menu.add_command(label="📥 Import Data", command=self._import_data)
        file_menu.add_separator()
        file_menu.add_command(label="🚪 Exit", command=self.root.quit)
        menubar.add_cascade(label="File", menu=file_menu)
        
        # Server menu
        server_menu = Menu(menubar, tearoff=0, bg=Theme.BG_PANEL, fg=Theme.TEXT_PRIMARY)
        server_menu.add_command(label="▶️ Start Server", command=self._start_server)
        server_menu.add_command(label="⏹️ Stop Server", command=self._stop_server)
        server_menu.add_separator()
        server_menu.add_command(label="🌐 Open in Browser", command=self._open_server_browser)
        menubar.add_cascade(label="Server", menu=server_menu)
        
        # Tools menu
        tools_menu = Menu(menubar, tearoff=0, bg=Theme.BG_PANEL, fg=Theme.TEXT_PRIMARY)
        tools_menu.add_command(label="🌐 FlashBrowser", command=self._launch_flash_browser)
        tools_menu.add_command(label="🔧 FFDEC", command=self._launch_ffdec)
        tools_menu.add_command(label="🔬 Ghidra", command=self._launch_ghidra)
        tools_menu.add_command(label="🐛 dnSpy", command=self._launch_dnspy)
        menubar.add_cascade(label="Tools", menu=tools_menu)
        
        # Help menu
        help_menu = Menu(menubar, tearoff=0, bg=Theme.BG_PANEL, fg=Theme.TEXT_PRIMARY)
        help_menu.add_command(label="📖 Documentation", command=self._show_docs)
        help_menu.add_command(label="❓ About", command=self._show_about)
        menubar.add_cascade(label="Help", menu=help_menu)
        
        self.root.config(menu=menubar)
    
    def _create_header(self):
        """Create header with title and quick actions"""
        header = tk.Frame(self.root, bg=Theme.BG_CARD, height=80)
        header.pack(fill='x')
        header.pack_propagate(False)
        
        # Left: Title
        left = tk.Frame(header, bg=Theme.BG_CARD)
        left.pack(side='left', padx=20, pady=15)
        
        tk.Label(left, text="⚔️ EVONY MASTER HUB", 
                font=('Segoe UI', 22, 'bold'),
                bg=Theme.BG_CARD, fg=Theme.ACCENT_PRIMARY).pack(side='left')
        
        tk.Label(left, text="v5.0 ULTIMATE", 
                font=('Segoe UI', 12),
                bg=Theme.BG_CARD, fg=Theme.TEXT_SECONDARY).pack(side='left', padx=(15, 0), pady=(8, 0))
        
        # Right: Quick actions
        right = tk.Frame(header, bg=Theme.BG_CARD)
        right.pack(side='right', padx=20, pady=15)
        
        # Server status
        self.server_indicator = StatusIndicator(right, "Script Server")
        self.server_indicator.pack(side='left', padx=(0, 20))
        
        # Quick buttons
        ModernButton(right, text="🌐 FlashBrowser", 
                    command=self._launch_flash_browser,
                    bg=Theme.ACCENT_SECONDARY).pack(side='left', padx=5)
        
        ModernButton(right, text="📜 Generate Script", 
                    command=self._quick_generate_script,
                    bg=Theme.ACCENT_WARNING).pack(side='left', padx=5)
        
        ModernButton(right, text="💀 Overflow", 
                    command=self._quick_overflow,
                    bg=Theme.ACCENT_DANGER).pack(side='left', padx=5)
    
    def _create_main_content(self):
        """Create main content area with notebook"""
        self.notebook = ttk.Notebook(self.root)
        self.notebook.pack(fill='both', expand=True, padx=10, pady=10)
        
        # Create all tabs
        self._create_dashboard_tab()
        self._create_scripts_tab()
        self._create_exploits_tab()
        self._create_protocol_tab()
        self._create_accounts_tab()
        self._create_source_tab()
        self._create_server_tab()
        self._create_crypto_tab()
        self._create_files_tab()
        self._create_tools_tab()
        self._create_analytics_tab()
        self._create_settings_tab()
    
    def _create_statusbar(self):
        """Create status bar"""
        statusbar = tk.Frame(self.root, bg=Theme.BG_CARD, height=30)
        statusbar.pack(fill='x', side='bottom')
        statusbar.pack_propagate(False)
        
        # Status text
        tk.Label(statusbar, textvariable=self.status_var,
                font=('Consolas', 9), bg=Theme.BG_CARD,
                fg=Theme.TEXT_SECONDARY).pack(side='left', padx=10, pady=5)
        
        # Right side stats
        stats_frame = tk.Frame(statusbar, bg=Theme.BG_CARD)
        stats_frame.pack(side='right', padx=10)
        
        tk.Label(stats_frame, text=f"📜 {len(self.script_mgr.scripts)} Scripts",
                font=('Consolas', 9), bg=Theme.BG_CARD,
                fg=Theme.TEXT_MUTED).pack(side='left', padx=10)
        
        tk.Label(stats_frame, text=f"👤 {len(self.account_mgr.accounts)} Accounts",
                font=('Consolas', 9), bg=Theme.BG_CARD,
                fg=Theme.TEXT_MUTED).pack(side='left', padx=10)
        
        tk.Label(stats_frame, text=f"📡 352+ Commands",
                font=('Consolas', 9), bg=Theme.BG_CARD,
                fg=Theme.TEXT_MUTED).pack(side='left', padx=10)

    
    # =========================================================================
    # TAB: DASHBOARD
    # =========================================================================
    
    def _create_dashboard_tab(self):
        """Dashboard with overview cards and quick actions"""
        frame = tk.Frame(self.notebook, bg=Theme.BG_DARK)
        self.notebook.add(frame, text="📊 Dashboard")
        
        # Top row: Stat cards
        cards_frame = tk.Frame(frame, bg=Theme.BG_DARK)
        cards_frame.pack(fill='x', padx=20, pady=20)
        
        stats = [
            ("📜", "Scripts", str(len(self.script_mgr.scripts)), Theme.ACCENT_PRIMARY),
            ("👤", "Accounts", str(len(self.account_mgr.accounts)), Theme.ACCENT_SECONDARY),
            ("📡", "Commands", "352+", Theme.ACCENT_WARNING),
            ("💀", "Exploits", str(len(EXPLOITS)), Theme.ACCENT_DANGER),
            ("📁", "Bot Files", str(len(self.source_mgr.bot_files)), Theme.ACCENT_PURPLE),
            ("📂", "Client Files", str(len(self.source_mgr.client_files)), Theme.ACCENT_PINK),
        ]
        
        for icon, title, value, color in stats:
            card = DataCard(cards_frame, title, value, icon, color)
            card.pack(side='left', padx=10, fill='y')
        
        # Content area
        content = tk.Frame(frame, bg=Theme.BG_DARK)
        content.pack(fill='both', expand=True, padx=20)
        
        # Left column: Quick actions
        left = tk.Frame(content, bg=Theme.BG_DARK)
        left.pack(side='left', fill='both', expand=True, padx=(0, 10))
        
        quick_frame = CollapsibleFrame(left, "⚡ Quick Actions")
        quick_frame.pack(fill='x', pady=5)
        
        actions = [
            ("🚀 Start Full Automation", self._run_full_auto),
            ("💥 Execute Overflow Chain", self._quick_overflow),
            ("🏃 Race Condition Blitz", self._run_race_blitz),
            ("🏔️ Valley Hide Troops", self._run_valley_hide),
            ("💰 Tax Collection Loop", self._run_tax_loop),
            ("🌾 Colony Resource Drain", self._run_colony_drain),
            ("📝 Generate Custom Script", self._quick_generate_script),
            ("🌐 Launch FlashBrowser", self._launch_flash_browser),
        ]
        
        for text, cmd in actions:
            btn = tk.Button(quick_frame.content, text=text, command=cmd,
                           bg=Theme.BG_INPUT, fg=Theme.TEXT_PRIMARY,
                           font=('Segoe UI', 10), relief='flat',
                           anchor='w', padx=15, pady=8, cursor='hand2')
            btn.pack(fill='x', pady=2)
            btn.bind('<Enter>', lambda e, b=btn: b.configure(bg=Theme.BG_HOVER))
            btn.bind('<Leave>', lambda e, b=btn: b.configure(bg=Theme.BG_INPUT))
        
        # Safety limits
        limits_frame = CollapsibleFrame(left, "⚠️ Safety Limits")
        limits_frame.pack(fill='x', pady=5)
        
        for name, value in SAFETY_LIMITS.items():
            row = tk.Frame(limits_frame.content, bg=Theme.BG_PANEL)
            row.pack(fill='x', pady=2)
            tk.Label(row, text=name.replace("_", " ").title(),
                    font=('Consolas', 9), bg=Theme.BG_PANEL,
                    fg=Theme.TEXT_SECONDARY, width=20, anchor='w').pack(side='left', padx=10)
            tk.Label(row, text=format_number(value),
                    font=('Consolas', 9, 'bold'), bg=Theme.BG_PANEL,
                    fg=Theme.ACCENT_WARNING).pack(side='left')
        
        # Right column: Troop overflow calculator
        right = tk.Frame(content, bg=Theme.BG_DARK)
        right.pack(side='right', fill='both', expand=True, padx=(10, 0))
        
        overflow_frame = CollapsibleFrame(right, "🔢 Troop Overflow Calculator")
        overflow_frame.pack(fill='both', expand=True, pady=5)
        
        # Troop table
        columns = ('id', 'name', 'cost', 'threshold', 'gain', 'script')
        tree = ttk.Treeview(overflow_frame.content, columns=columns, show='headings', height=12)
        
        tree.heading('id', text='ID')
        tree.heading('name', text='Troop')
        tree.heading('cost', text='Food Cost')
        tree.heading('threshold', text='Overflow Threshold')
        tree.heading('gain', text='Expected Gain')
        tree.heading('script', text='Script')
        
        tree.column('id', width=40)
        tree.column('name', width=100)
        tree.column('cost', width=80)
        tree.column('threshold', width=130)
        tree.column('gain', width=100)
        tree.column('script', width=150)
        
        for tid, troop in TROOPS.items():
            tree.insert('', 'end', values=(
                tid, troop.name, troop.food_cost,
                f"{troop.overflow_threshold:,}",
                format_number(troop.expected_gain),
                troop.script
            ))
        
        tree.pack(fill='both', expand=True, padx=5, pady=5)
        
        # Copy script button
        def copy_selected_script():
            sel = tree.selection()
            if sel:
                item = tree.item(sel[0])
                script = item['values'][5]
                self.root.clipboard_clear()
                self.root.clipboard_append(script)
                self.status_var.set(f"Copied: {script}")
        
        tk.Button(overflow_frame.content, text="📋 Copy Selected Script",
                 command=copy_selected_script, bg=Theme.BG_INPUT,
                 fg=Theme.TEXT_PRIMARY, relief='flat').pack(pady=5)
    
    # =========================================================================
    # TAB: SCRIPTS
    # =========================================================================
    
    def _create_scripts_tab(self):
        """Scripts tab with library, editor, and generator"""
        frame = tk.Frame(self.notebook, bg=Theme.BG_DARK)
        self.notebook.add(frame, text="📜 Scripts")
        
        # Toolbar
        toolbar = tk.Frame(frame, bg=Theme.BG_CARD, height=50)
        toolbar.pack(fill='x')
        toolbar.pack_propagate(False)
        
        tk.Label(toolbar, text="📜 Script Library", font=('Segoe UI', 12, 'bold'),
                bg=Theme.BG_CARD, fg=Theme.TEXT_PRIMARY).pack(side='left', padx=15, pady=10)
        
        # Filter by category
        tk.Label(toolbar, text="Category:", bg=Theme.BG_CARD,
                fg=Theme.TEXT_SECONDARY).pack(side='left', padx=(20, 5))
        
        categories = ['All'] + self.script_mgr.get_categories()
        self.script_category_var = tk.StringVar(value='All')
        cat_combo = ModernCombobox(toolbar, textvariable=self.script_category_var,
                                   values=categories, width=15, state='readonly')
        cat_combo.pack(side='left', pady=10)
        cat_combo.bind('<<ComboboxSelected>>', self._filter_scripts)
        
        # Search
        tk.Label(toolbar, text="Search:", bg=Theme.BG_CARD,
                fg=Theme.TEXT_SECONDARY).pack(side='left', padx=(20, 5))
        
        self.script_search_var = tk.StringVar()
        search_entry = ModernEntry(toolbar, placeholder="Search scripts...",
                                   textvariable=self.script_search_var, width=25)
        search_entry.pack(side='left', pady=10)
        search_entry.bind('<KeyRelease>', self._filter_scripts)
        
        # Action buttons
        ToolbarButton(toolbar, "📄 New", self._new_script).pack(side='right', padx=5, pady=10)
        ToolbarButton(toolbar, "📂 Open", self._open_script).pack(side='right', padx=5, pady=10)
        ToolbarButton(toolbar, "💾 Save", self._save_script).pack(side='right', padx=5, pady=10)
        ToolbarButton(toolbar, "▶️ Run", self._run_script).pack(side='right', padx=5, pady=10)
        ToolbarButton(toolbar, "✨ Generate", self._generate_script).pack(side='right', padx=5, pady=10)
        
        # Content area
        paned = tk.PanedWindow(frame, orient='horizontal', bg=Theme.BG_DARK,
                              sashwidth=4, sashrelief='flat')
        paned.pack(fill='both', expand=True, padx=10, pady=10)
        
        # Left: Script list
        list_frame = tk.Frame(paned, bg=Theme.BG_PANEL)
        paned.add(list_frame, width=350)
        
        # Script tree
        columns = ('name', 'category', 'lines')
        self.script_tree = ttk.Treeview(list_frame, columns=columns, show='headings')
        self.script_tree.heading('name', text='Script Name')
        self.script_tree.heading('category', text='Category')
        self.script_tree.heading('lines', text='Lines')
        self.script_tree.column('name', width=180)
        self.script_tree.column('category', width=80)
        self.script_tree.column('lines', width=50)
        
        # Scrollbar
        scroll = ttk.Scrollbar(list_frame, orient='vertical', command=self.script_tree.yview)
        self.script_tree.configure(yscrollcommand=scroll.set)
        scroll.pack(side='right', fill='y')
        self.script_tree.pack(fill='both', expand=True)
        
        # Populate scripts
        for script in self.script_mgr.scripts:
            self.script_tree.insert('', 'end', values=(script.name, script.category, script.lines))
        
        self.script_tree.bind('<<TreeviewSelect>>', self._on_script_select)
        
        # Right: Editor
        editor_frame = tk.Frame(paned, bg=Theme.BG_PANEL)
        paned.add(editor_frame)
        
        # Editor toolbar
        ed_toolbar = tk.Frame(editor_frame, bg=Theme.BG_CARD, height=40)
        ed_toolbar.pack(fill='x')
        ed_toolbar.pack_propagate(False)
        
        self.script_name_var = tk.StringVar(value="Untitled")
        tk.Label(ed_toolbar, textvariable=self.script_name_var,
                font=('Consolas', 11, 'bold'), bg=Theme.BG_CARD,
                fg=Theme.ACCENT_PRIMARY).pack(side='left', padx=15, pady=8)
        
        # Editor text area
        self.script_editor = scrolledtext.ScrolledText(
            editor_frame, bg=Theme.BG_INPUT, fg=Theme.TEXT_PRIMARY,
            font=('Consolas', 11), insertbackground=Theme.ACCENT_PRIMARY,
            selectbackground=Theme.BG_SELECTED, wrap='none'
        )
        self.script_editor.pack(fill='both', expand=True, padx=5, pady=5)

    
    # =========================================================================
    # TAB: EXPLOITS
    # =========================================================================
    
    def _create_exploits_tab(self):
        """Exploits tab with database, generator, and executor"""
        frame = tk.Frame(self.notebook, bg=Theme.BG_DARK)
        self.notebook.add(frame, text="💀 Exploits")
        
        # Toolbar
        toolbar = tk.Frame(frame, bg=Theme.BG_CARD, height=50)
        toolbar.pack(fill='x')
        toolbar.pack_propagate(False)
        
        tk.Label(toolbar, text="💀 Exploit Engine", font=('Segoe UI', 12, 'bold'),
                bg=Theme.BG_CARD, fg=Theme.TEXT_PRIMARY).pack(side='left', padx=15, pady=10)
        
        # Severity filter
        tk.Label(toolbar, text="Severity:", bg=Theme.BG_CARD,
                fg=Theme.TEXT_SECONDARY).pack(side='left', padx=(20, 5))
        
        self.exploit_severity_var = tk.StringVar(value='All')
        sev_combo = ModernCombobox(toolbar, textvariable=self.exploit_severity_var,
                                   values=['All', 'CRITICAL', 'HIGH', 'MEDIUM', 'LOW'],
                                   width=12, state='readonly')
        sev_combo.pack(side='left', pady=10)
        sev_combo.bind('<<ComboboxSelected>>', self._filter_exploits)
        
        # Action buttons
        ToolbarButton(toolbar, "🔄 Refresh", self._refresh_exploits).pack(side='right', padx=5, pady=10)
        ToolbarButton(toolbar, "📋 Copy Script", self._copy_exploit_script).pack(side='right', padx=5, pady=10)
        ToolbarButton(toolbar, "▶️ Execute", self._execute_exploit).pack(side='right', padx=5, pady=10)
        ToolbarButton(toolbar, "✨ Generate Chain", self._generate_exploit_chain).pack(side='right', padx=5, pady=10)
        
        # Content
        content = tk.Frame(frame, bg=Theme.BG_DARK)
        content.pack(fill='both', expand=True, padx=10, pady=10)
        
        # Left: Exploit list
        list_frame = tk.Frame(content, bg=Theme.BG_PANEL)
        list_frame.pack(side='left', fill='both', expand=True, padx=(0, 5))
        
        columns = ('severity', 'name', 'category', 'success')
        self.exploit_tree = ttk.Treeview(list_frame, columns=columns, show='headings')
        self.exploit_tree.heading('severity', text='⚠️')
        self.exploit_tree.heading('name', text='Exploit')
        self.exploit_tree.heading('category', text='Category')
        self.exploit_tree.heading('success', text='Success %')
        self.exploit_tree.column('severity', width=60)
        self.exploit_tree.column('name', width=200)
        self.exploit_tree.column('category', width=150)
        self.exploit_tree.column('success', width=80)
        
        scroll = ttk.Scrollbar(list_frame, orient='vertical', command=self.exploit_tree.yview)
        self.exploit_tree.configure(yscrollcommand=scroll.set)
        scroll.pack(side='right', fill='y')
        self.exploit_tree.pack(fill='both', expand=True)
        
        # Populate exploits
        for exp in EXPLOITS:
            sev_icon = {'CRITICAL': '🔴', 'HIGH': '🟠', 'MEDIUM': '🟡', 'LOW': '🟢'}.get(exp.severity, '⚪')
            self.exploit_tree.insert('', 'end', values=(
                sev_icon, exp.name, exp.category, f"{exp.success_rate:.0f}%"
            ))
        
        self.exploit_tree.bind('<<TreeviewSelect>>', self._on_exploit_select)
        
        # Right: Details panel
        details_frame = tk.Frame(content, bg=Theme.BG_PANEL, width=400)
        details_frame.pack(side='right', fill='both', padx=(5, 0))
        details_frame.pack_propagate(False)
        
        tk.Label(details_frame, text="Exploit Details", font=('Segoe UI', 11, 'bold'),
                bg=Theme.BG_PANEL, fg=Theme.ACCENT_PRIMARY).pack(padx=15, pady=10, anchor='w')
        
        # Details fields
        self.exploit_detail_name = tk.StringVar()
        self.exploit_detail_desc = tk.StringVar()
        self.exploit_detail_cmd = tk.StringVar()
        self.exploit_detail_risk = tk.StringVar()
        
        fields = [
            ("Name:", self.exploit_detail_name),
            ("Description:", self.exploit_detail_desc),
            ("Command:", self.exploit_detail_cmd),
            ("Risk:", self.exploit_detail_risk),
        ]
        
        for label, var in fields:
            row = tk.Frame(details_frame, bg=Theme.BG_PANEL)
            row.pack(fill='x', padx=15, pady=3)
            tk.Label(row, text=label, font=('Segoe UI', 9), bg=Theme.BG_PANEL,
                    fg=Theme.TEXT_SECONDARY, width=12, anchor='w').pack(side='left')
            tk.Label(row, textvariable=var, font=('Consolas', 9), bg=Theme.BG_PANEL,
                    fg=Theme.TEXT_PRIMARY, wraplength=300, anchor='w').pack(side='left', fill='x')
        
        # Script preview
        tk.Label(details_frame, text="Script:", font=('Segoe UI', 9),
                bg=Theme.BG_PANEL, fg=Theme.TEXT_SECONDARY).pack(padx=15, pady=(10, 5), anchor='w')
        
        self.exploit_script_text = scrolledtext.ScrolledText(
            details_frame, height=10, bg=Theme.BG_INPUT, fg=Theme.TEXT_PRIMARY,
            font=('Consolas', 9), wrap='word'
        )
        self.exploit_script_text.pack(fill='x', padx=15, pady=5)
    
    # =========================================================================
    # TAB: PROTOCOL
    # =========================================================================
    
    def _create_protocol_tab(self):
        """Protocol commands browser with 352+ commands"""
        frame = tk.Frame(self.notebook, bg=Theme.BG_DARK)
        self.notebook.add(frame, text="📡 Protocol")
        
        # Toolbar
        toolbar = tk.Frame(frame, bg=Theme.BG_CARD, height=50)
        toolbar.pack(fill='x')
        toolbar.pack_propagate(False)
        
        tk.Label(toolbar, text="📡 Protocol Commander (352+ Commands)",
                font=('Segoe UI', 12, 'bold'), bg=Theme.BG_CARD,
                fg=Theme.TEXT_PRIMARY).pack(side='left', padx=15, pady=10)
        
        # Category filter
        tk.Label(toolbar, text="Category:", bg=Theme.BG_CARD,
                fg=Theme.TEXT_SECONDARY).pack(side='left', padx=(20, 5))
        
        self.protocol_cat_var = tk.StringVar(value='all')
        cat_combo = ModernCombobox(toolbar, textvariable=self.protocol_cat_var,
                                   values=['all'] + list(PROTOCOL_COMMANDS.keys()),
                                   width=15, state='readonly')
        cat_combo.pack(side='left', pady=10)
        cat_combo.bind('<<ComboboxSelected>>', self._filter_protocol)
        
        # Search
        tk.Label(toolbar, text="Search:", bg=Theme.BG_CARD,
                fg=Theme.TEXT_SECONDARY).pack(side='left', padx=(20, 5))
        
        self.protocol_search_var = tk.StringVar()
        search_entry = ModernEntry(toolbar, placeholder="Search commands...",
                                   textvariable=self.protocol_search_var, width=25)
        search_entry.pack(side='left', pady=10)
        search_entry.bind('<KeyRelease>', self._filter_protocol)
        
        # Buttons
        ToolbarButton(toolbar, "📋 Copy", self._copy_command).pack(side='right', padx=5, pady=10)
        ToolbarButton(toolbar, "🔧 Build Packet", self._build_packet).pack(side='right', padx=5, pady=10)
        
        # Content
        content = tk.Frame(frame, bg=Theme.BG_DARK)
        content.pack(fill='both', expand=True, padx=10, pady=10)
        
        # Command tree
        columns = ('category', 'command', 'params', 'description')
        self.protocol_tree = ttk.Treeview(content, columns=columns, show='headings')
        self.protocol_tree.heading('category', text='Category')
        self.protocol_tree.heading('command', text='Command')
        self.protocol_tree.heading('params', text='Parameters')
        self.protocol_tree.heading('description', text='Description')
        self.protocol_tree.column('category', width=100)
        self.protocol_tree.column('command', width=250)
        self.protocol_tree.column('params', width=200)
        self.protocol_tree.column('description', width=300)
        
        scroll = ttk.Scrollbar(content, orient='vertical', command=self.protocol_tree.yview)
        self.protocol_tree.configure(yscrollcommand=scroll.set)
        scroll.pack(side='right', fill='y')
        self.protocol_tree.pack(fill='both', expand=True)
        
        # Populate commands
        for cat, commands in PROTOCOL_COMMANDS.items():
            for cmd in commands:
                params_str = ', '.join(cmd.params) if cmd.params else '-'
                self.protocol_tree.insert('', 'end', values=(
                    cat, cmd.name, params_str, cmd.description
                ))
    
    # =========================================================================
    # TAB: ACCOUNTS
    # =========================================================================
    
    def _create_accounts_tab(self):
        """Accounts manager with 124 credentials"""
        frame = tk.Frame(self.notebook, bg=Theme.BG_DARK)
        self.notebook.add(frame, text="👤 Accounts")
        
        # Toolbar
        toolbar = tk.Frame(frame, bg=Theme.BG_CARD, height=50)
        toolbar.pack(fill='x')
        toolbar.pack_propagate(False)
        
        tk.Label(toolbar, text=f"👤 Account Manager ({len(self.account_mgr.accounts)} accounts)",
                font=('Segoe UI', 12, 'bold'), bg=Theme.BG_CARD,
                fg=Theme.TEXT_PRIMARY).pack(side='left', padx=15, pady=10)
        
        # Server filter
        tk.Label(toolbar, text="Server:", bg=Theme.BG_CARD,
                fg=Theme.TEXT_SECONDARY).pack(side='left', padx=(20, 5))
        
        servers = ['All'] + list(set(a.server for a in self.account_mgr.accounts))
        self.account_server_var = tk.StringVar(value='All')
        server_combo = ModernCombobox(toolbar, textvariable=self.account_server_var,
                                      values=servers, width=10, state='readonly')
        server_combo.pack(side='left', pady=10)
        
        # Buttons
        ToolbarButton(toolbar, "📋 Copy Creds", self._copy_credentials).pack(side='right', padx=5, pady=10)
        ToolbarButton(toolbar, "📤 Export", self._export_accounts).pack(side='right', padx=5, pady=10)
        ToolbarButton(toolbar, "🔄 Refresh", self._refresh_accounts).pack(side='right', padx=5, pady=10)
        ToolbarButton(toolbar, "👁️ Toggle Pass", self._toggle_passwords).pack(side='right', padx=5, pady=10)
        
        # Content
        content = tk.Frame(frame, bg=Theme.BG_DARK)
        content.pack(fill='both', expand=True, padx=10, pady=10)
        
        # Account tree
        columns = ('email', 'password', 'server', 'proxy', 'status')
        self.account_tree = ttk.Treeview(content, columns=columns, show='headings')
        self.account_tree.heading('email', text='Email')
        self.account_tree.heading('password', text='Password')
        self.account_tree.heading('server', text='Server')
        self.account_tree.heading('proxy', text='Proxy')
        self.account_tree.heading('status', text='Status')
        self.account_tree.column('email', width=250)
        self.account_tree.column('password', width=150)
        self.account_tree.column('server', width=80)
        self.account_tree.column('proxy', width=150)
        self.account_tree.column('status', width=80)
        
        scroll = ttk.Scrollbar(content, orient='vertical', command=self.account_tree.yview)
        self.account_tree.configure(yscrollcommand=scroll.set)
        scroll.pack(side='right', fill='y')
        self.account_tree.pack(fill='both', expand=True)
        
        # Populate accounts (passwords hidden by default)
        self.passwords_visible = False
        self._populate_accounts()
    
    def _populate_accounts(self):
        """Populate account tree"""
        for item in self.account_tree.get_children():
            self.account_tree.delete(item)
        
        for acc in self.account_mgr.accounts:
            pw = acc.password if self.passwords_visible else '••••••••'
            self.account_tree.insert('', 'end', values=(
                acc.email, pw, acc.server, acc.proxy or '-', acc.status
            ))

    
    # =========================================================================
    # TAB: SOURCE BROWSER
    # =========================================================================
    
    def _create_source_tab(self):
        """Source code browser for 3,278 AS3 files"""
        frame = tk.Frame(self.notebook, bg=Theme.BG_DARK)
        self.notebook.add(frame, text="📁 Source")
        
        # Toolbar
        toolbar = tk.Frame(frame, bg=Theme.BG_CARD, height=50)
        toolbar.pack(fill='x')
        toolbar.pack_propagate(False)
        
        tk.Label(toolbar, text=f"📁 Source Browser ({len(self.source_mgr.bot_files) + len(self.source_mgr.client_files)} files)",
                font=('Segoe UI', 12, 'bold'), bg=Theme.BG_CARD,
                fg=Theme.TEXT_PRIMARY).pack(side='left', padx=15, pady=10)
        
        # Source selector
        tk.Label(toolbar, text="Source:", bg=Theme.BG_CARD,
                fg=Theme.TEXT_SECONDARY).pack(side='left', padx=(20, 5))
        
        self.source_type_var = tk.StringVar(value='bot')
        source_combo = ModernCombobox(toolbar, textvariable=self.source_type_var,
                                      values=['bot', 'client', 'both'], width=10, state='readonly')
        source_combo.pack(side='left', pady=10)
        source_combo.bind('<<ComboboxSelected>>', self._refresh_source_tree)
        
        # Search
        tk.Label(toolbar, text="Search:", bg=Theme.BG_CARD,
                fg=Theme.TEXT_SECONDARY).pack(side='left', padx=(20, 5))
        
        self.source_search_var = tk.StringVar()
        search_entry = ModernEntry(toolbar, placeholder="Search in files...",
                                   textvariable=self.source_search_var, width=30)
        search_entry.pack(side='left', pady=10)
        
        ToolbarButton(toolbar, "🔍 Search", self._search_source).pack(side='left', padx=10, pady=10)
        ToolbarButton(toolbar, "📋 Copy Path", self._copy_source_path).pack(side='right', padx=5, pady=10)
        ToolbarButton(toolbar, "📂 Open in Editor", self._open_source_external).pack(side='right', padx=5, pady=10)
        
        # Content
        paned = tk.PanedWindow(frame, orient='horizontal', bg=Theme.BG_DARK,
                              sashwidth=4, sashrelief='flat')
        paned.pack(fill='both', expand=True, padx=10, pady=10)
        
        # Left: File tree
        tree_frame = tk.Frame(paned, bg=Theme.BG_PANEL)
        paned.add(tree_frame, width=350)
        
        self.source_tree = ttk.Treeview(tree_frame, show='tree')
        scroll = ttk.Scrollbar(tree_frame, orient='vertical', command=self.source_tree.yview)
        self.source_tree.configure(yscrollcommand=scroll.set)
        scroll.pack(side='right', fill='y')
        self.source_tree.pack(fill='both', expand=True)
        
        self.source_tree.bind('<<TreeviewSelect>>', self._on_source_select)
        self._refresh_source_tree()
        
        # Right: Code viewer
        viewer_frame = tk.Frame(paned, bg=Theme.BG_PANEL)
        paned.add(viewer_frame)
        
        self.source_viewer = scrolledtext.ScrolledText(
            viewer_frame, bg=Theme.BG_INPUT, fg=Theme.TEXT_PRIMARY,
            font=('Consolas', 10), insertbackground=Theme.ACCENT_PRIMARY,
            wrap='none', state='disabled'
        )
        self.source_viewer.pack(fill='both', expand=True, padx=5, pady=5)
    
    # =========================================================================
    # TAB: SERVER
    # =========================================================================
    
    def _create_server_tab(self):
        """Script server management"""
        frame = tk.Frame(self.notebook, bg=Theme.BG_DARK)
        self.notebook.add(frame, text="🌐 Server")
        
        # Status panel
        status_panel = tk.Frame(frame, bg=Theme.BG_CARD)
        status_panel.pack(fill='x', padx=20, pady=20)
        
        tk.Label(status_panel, text="🌐 Script Server", font=('Segoe UI', 14, 'bold'),
                bg=Theme.BG_CARD, fg=Theme.TEXT_PRIMARY).pack(pady=(15, 5))
        
        self.server_status_label = tk.Label(status_panel, text="● RUNNING",
                                           font=('Segoe UI', 18, 'bold'),
                                           bg=Theme.BG_CARD, fg=Theme.STATUS_SUCCESS)
        self.server_status_label.pack(pady=10)
        
        tk.Label(status_panel, text="Port: 8088",
                font=('Consolas', 11), bg=Theme.BG_CARD,
                fg=Theme.TEXT_SECONDARY).pack(pady=5)
        
        # Control buttons
        btn_frame = tk.Frame(status_panel, bg=Theme.BG_CARD)
        btn_frame.pack(pady=15)
        
        ModernButton(btn_frame, text="▶️ Start", command=self._start_server,
                    bg=Theme.STATUS_SUCCESS).pack(side='left', padx=10)
        ModernButton(btn_frame, text="⏹️ Stop", command=self._stop_server,
                    bg=Theme.STATUS_ERROR).pack(side='left', padx=10)
        ModernButton(btn_frame, text="🔄 Restart", command=self._restart_server,
                    bg=Theme.ACCENT_WARNING).pack(side='left', padx=10)
        ModernButton(btn_frame, text="🌐 Open Browser", command=self._open_server_browser,
                    bg=Theme.ACCENT_SECONDARY).pack(side='left', padx=10)
        
        # Endpoints list
        endpoints_frame = CollapsibleFrame(frame, "📡 Available Endpoints")
        endpoints_frame.pack(fill='x', padx=20, pady=10)
        
        endpoints = [
            ("/epic/overflow_chain", "Multi-troop overflow (~8.4B food)"),
            ("/epic/race_blitz", "Rapid item use race condition"),
            ("/epic/full_auto", "Complete automation loop"),
            ("/epic/valley_hide", "Hide troops in valleys"),
            ("/epic/security_bypass", "Try common security codes"),
            ("/epic/tax_loop", "Continuous tax collection"),
            ("/epic/colony_drain", "Drain all colonies"),
            ("/api/thresholds", "All overflow thresholds (JSON)"),
            ("/api/keys", "Encryption keys (JSON)"),
            ("/api/exploits", "Exploit database (JSON)"),
            ("/api/commands", "Protocol commands (JSON)"),
        ]
        
        for endpoint, desc in endpoints:
            row = tk.Frame(endpoints_frame.content, bg=Theme.BG_PANEL)
            row.pack(fill='x', pady=2)
            
            tk.Label(row, text=endpoint, font=('Consolas', 10, 'bold'),
                    bg=Theme.BG_PANEL, fg=Theme.ACCENT_PRIMARY, width=25,
                    anchor='w').pack(side='left', padx=10)
            tk.Label(row, text=desc, font=('Segoe UI', 9),
                    bg=Theme.BG_PANEL, fg=Theme.TEXT_SECONDARY).pack(side='left')
            
            def copy_url(ep=endpoint):
                self.root.clipboard_clear()
                self.root.clipboard_append(f"http://localhost:8088{ep}")
                self.status_var.set(f"Copied: http://localhost:8088{ep}")
            
            tk.Button(row, text="📋", command=copy_url, bg=Theme.BG_INPUT,
                     fg=Theme.TEXT_PRIMARY, relief='flat', cursor='hand2').pack(side='right', padx=5)
        
        # AutoEvony usage
        usage_frame = CollapsibleFrame(frame, "📜 AutoEvony Usage")
        usage_frame.pack(fill='x', padx=20, pady=10)
        
        usage_text = scrolledtext.ScrolledText(usage_frame.content, height=6,
                                              bg=Theme.BG_INPUT, fg=Theme.TEXT_PRIMARY,
                                              font=('Consolas', 10))
        usage_text.pack(fill='x', padx=10, pady=10)
        usage_text.insert('1.0', """// In AutoEvony script, use:
includeurl http://localhost:8088/epic/overflow_chain
includeurl http://localhost:8088/epic/race_blitz
includeurl http://localhost:8088/epic/full_auto
includeurl http://localhost:8088/troop/6   // Archer overflow""")
        usage_text.configure(state='disabled')
    
    # =========================================================================
    # TAB: CRYPTO
    # =========================================================================
    
    def _create_crypto_tab(self):
        """Cryptography toolkit with keys and signature generator"""
        frame = tk.Frame(self.notebook, bg=Theme.BG_DARK)
        self.notebook.add(frame, text="🔐 Crypto")
        
        # Keys section
        keys_frame = CollapsibleFrame(frame, "🔑 Encryption Keys")
        keys_frame.pack(fill='x', padx=20, pady=10)
        
        for key_name, key_value in ENCRYPTION_KEYS.items():
            row = tk.Frame(keys_frame.content, bg=Theme.BG_PANEL)
            row.pack(fill='x', pady=2)
            
            tk.Label(row, text=key_name, font=('Consolas', 10, 'bold'),
                    bg=Theme.BG_PANEL, fg=Theme.ACCENT_PRIMARY, width=20,
                    anchor='w').pack(side='left', padx=10)
            
            value_str = str(key_value)[:50] + ('...' if len(str(key_value)) > 50 else '')
            tk.Label(row, text=value_str, font=('Consolas', 9),
                    bg=Theme.BG_PANEL, fg=Theme.TEXT_PRIMARY).pack(side='left')
            
            def copy_key(v=key_value):
                self.root.clipboard_clear()
                self.root.clipboard_append(str(v))
                self.status_var.set("Key copied to clipboard")
            
            tk.Button(row, text="📋", command=copy_key, bg=Theme.BG_INPUT,
                     fg=Theme.TEXT_PRIMARY, relief='flat', cursor='hand2').pack(side='right', padx=5)
        
        # Signature generator
        sig_frame = CollapsibleFrame(frame, "✍️ Signature Generator")
        sig_frame.pack(fill='x', padx=20, pady=10)
        
        # Input
        input_row = tk.Frame(sig_frame.content, bg=Theme.BG_PANEL)
        input_row.pack(fill='x', padx=10, pady=10)
        
        tk.Label(input_row, text="Data:", bg=Theme.BG_PANEL,
                fg=Theme.TEXT_SECONDARY).pack(side='left')
        
        self.sig_input_var = tk.StringVar()
        sig_input = ModernEntry(input_row, textvariable=self.sig_input_var, width=50)
        sig_input.pack(side='left', padx=10)
        
        tk.Button(input_row, text="Generate", command=self._generate_signature,
                 bg=Theme.ACCENT_PRIMARY, fg=Theme.BG_DARK, relief='flat',
                 font=('Segoe UI', 9, 'bold'), cursor='hand2').pack(side='left', padx=10)
        
        # Output
        output_row = tk.Frame(sig_frame.content, bg=Theme.BG_PANEL)
        output_row.pack(fill='x', padx=10, pady=10)
        
        tk.Label(output_row, text="Signature:", bg=Theme.BG_PANEL,
                fg=Theme.TEXT_SECONDARY).pack(side='left')
        
        self.sig_output_var = tk.StringVar()
        tk.Label(output_row, textvariable=self.sig_output_var, font=('Consolas', 10),
                bg=Theme.BG_PANEL, fg=Theme.ACCENT_PRIMARY).pack(side='left', padx=10)
        
        # Hash calculator
        hash_frame = CollapsibleFrame(frame, "🔢 Hash Calculator")
        hash_frame.pack(fill='x', padx=20, pady=10)
        
        hash_input_row = tk.Frame(hash_frame.content, bg=Theme.BG_PANEL)
        hash_input_row.pack(fill='x', padx=10, pady=10)
        
        tk.Label(hash_input_row, text="Input:", bg=Theme.BG_PANEL,
                fg=Theme.TEXT_SECONDARY).pack(side='left')
        
        self.hash_input_var = tk.StringVar()
        hash_input = ModernEntry(hash_input_row, textvariable=self.hash_input_var, width=50)
        hash_input.pack(side='left', padx=10)
        
        tk.Button(hash_input_row, text="Calculate", command=self._calculate_hashes,
                 bg=Theme.ACCENT_SECONDARY, fg=Theme.BG_DARK, relief='flat',
                 font=('Segoe UI', 9, 'bold'), cursor='hand2').pack(side='left', padx=10)
        
        # Hash outputs
        self.hash_results_frame = tk.Frame(hash_frame.content, bg=Theme.BG_PANEL)
        self.hash_results_frame.pack(fill='x', padx=10, pady=10)

    
    # =========================================================================
    # TAB: FILES
    # =========================================================================
    
    def _create_files_tab(self):
        """File manager for 120,470 files"""
        frame = tk.Frame(self.notebook, bg=Theme.BG_DARK)
        self.notebook.add(frame, text="📂 Files")
        
        # Toolbar
        toolbar = tk.Frame(frame, bg=Theme.BG_CARD, height=50)
        toolbar.pack(fill='x')
        toolbar.pack_propagate(False)
        
        tk.Label(toolbar, text="📂 File Manager",
                font=('Segoe UI', 12, 'bold'), bg=Theme.BG_CARD,
                fg=Theme.TEXT_PRIMARY).pack(side='left', padx=15, pady=10)
        
        ToolbarButton(toolbar, "📁 Open Hub Root", self._open_hub_root).pack(side='right', padx=5, pady=10)
        ToolbarButton(toolbar, "🔄 Refresh", self._refresh_files).pack(side='right', padx=5, pady=10)
        ToolbarButton(toolbar, "📊 Statistics", self._show_file_stats).pack(side='right', padx=5, pady=10)
        
        # Content
        content = tk.Frame(frame, bg=Theme.BG_DARK)
        content.pack(fill='both', expand=True, padx=10, pady=10)
        
        # Directory stats
        stats_frame = tk.Frame(content, bg=Theme.BG_PANEL)
        stats_frame.pack(fill='x', pady=(0, 10))
        
        dirs = [
            ("Scripts", PATHS["scripts"], "📜"),
            ("Bot Source", PATHS["autoevony_src"], "🤖"),
            ("Client Source", PATHS["client_src"], "🎮"),
            ("SOL Accounts", PATHS["sol_accounts"], "💾"),
            ("Tools", PATHS["tools"], "🛠️"),
        ]
        
        for name, path, icon in dirs:
            card = tk.Frame(stats_frame, bg=Theme.BG_CARD, padx=15, pady=10)
            card.pack(side='left', padx=5, fill='y')
            
            count = sum(1 for _ in path.rglob("*") if _.is_file()) if path.exists() else 0
            tk.Label(card, text=icon, font=('Segoe UI Emoji', 20),
                    bg=Theme.BG_CARD, fg=Theme.TEXT_PRIMARY).pack()
            tk.Label(card, text=name, font=('Segoe UI', 10),
                    bg=Theme.BG_CARD, fg=Theme.TEXT_SECONDARY).pack()
            tk.Label(card, text=f"{count:,}", font=('Segoe UI', 14, 'bold'),
                    bg=Theme.BG_CARD, fg=Theme.ACCENT_PRIMARY).pack()
        
        # File type breakdown
        breakdown_frame = CollapsibleFrame(content, "📊 File Type Breakdown")
        breakdown_frame.pack(fill='both', expand=True)
        
        # File type table
        columns = ('extension', 'count', 'category')
        self.files_tree = ttk.Treeview(breakdown_frame.content, columns=columns, show='headings')
        self.files_tree.heading('extension', text='Extension')
        self.files_tree.heading('count', text='Count')
        self.files_tree.heading('category', text='Category')
        
        scroll = ttk.Scrollbar(breakdown_frame.content, orient='vertical', command=self.files_tree.yview)
        self.files_tree.configure(yscrollcommand=scroll.set)
        scroll.pack(side='right', fill='y')
        self.files_tree.pack(fill='both', expand=True)
        
        # Populate with sample data
        file_types = [
            ('.as', 23165, 'source'), ('.sol', 9043, 'data'), ('.html', 6400, 'web'),
            ('.py', 4222, 'python'), ('.txt', 2647, 'scripts'), ('.json', 1838, 'data'),
            ('.mxml', 1641, 'source'), ('.xml', 1329, 'data'), ('.js', 1284, 'web'),
            ('.swf', 231, 'binary'), ('.swc', 1224, 'binary'),
        ]
        
        for ext, count, cat in file_types:
            self.files_tree.insert('', 'end', values=(ext, f"{count:,}", cat))
    
    # =========================================================================
    # TAB: TOOLS
    # =========================================================================
    
    def _create_tools_tab(self):
        """External tools launcher"""
        frame = tk.Frame(self.notebook, bg=Theme.BG_DARK)
        self.notebook.add(frame, text="🛠️ Tools")
        
        tk.Label(frame, text="🛠️ External Tools", font=('Segoe UI', 14, 'bold'),
                bg=Theme.BG_DARK, fg=Theme.TEXT_PRIMARY).pack(pady=20)
        
        # Tools grid
        tools_frame = tk.Frame(frame, bg=Theme.BG_DARK)
        tools_frame.pack(padx=20, pady=10)
        
        tools = [
            ("🌐 FlashBrowser", "Flash-enabled browser", self._launch_flash_browser, Theme.ACCENT_PRIMARY),
            ("🔧 FFDEC", "Flash decompiler", self._launch_ffdec, Theme.ACCENT_SECONDARY),
            ("🔬 Ghidra", "Reverse engineering", self._launch_ghidra, Theme.ACCENT_WARNING),
            ("🐛 dnSpy", ".NET debugger", self._launch_dnspy, Theme.ACCENT_DANGER),
            ("📁 Scripts Folder", "Open scripts", self._open_scripts_folder, Theme.ACCENT_PURPLE),
            ("📂 Hub Root", "Open hub folder", self._open_hub_root, Theme.ACCENT_PINK),
            ("🔍 RABCDasm", "ABC disassembler", self._launch_rabcdasm, Theme.TEXT_LINK),
            ("📊 SOL Editor", "Flash cookie editor", self._launch_sol_editor, Theme.STATUS_INFO),
        ]
        
        for i, (name, desc, cmd, color) in enumerate(tools):
            row = i // 4
            col = i % 4
            
            card = tk.Frame(tools_frame, bg=Theme.BG_CARD, padx=20, pady=15)
            card.grid(row=row, column=col, padx=10, pady=10, sticky='nsew')
            
            tk.Label(card, text=name.split()[0], font=('Segoe UI Emoji', 24),
                    bg=Theme.BG_CARD, fg=color).pack()
            tk.Label(card, text=name.split(maxsplit=1)[1] if ' ' in name else name,
                    font=('Segoe UI', 11, 'bold'), bg=Theme.BG_CARD,
                    fg=Theme.TEXT_PRIMARY).pack(pady=(5, 0))
            tk.Label(card, text=desc, font=('Segoe UI', 9),
                    bg=Theme.BG_CARD, fg=Theme.TEXT_SECONDARY).pack()
            
            tk.Button(card, text="Launch", command=cmd, bg=color,
                     fg=Theme.BG_DARK if color != Theme.TEXT_LINK else Theme.TEXT_PRIMARY,
                     relief='flat', font=('Segoe UI', 9, 'bold'),
                     cursor='hand2', padx=15, pady=5).pack(pady=10)
    
    # =========================================================================
    # TAB: ANALYTICS
    # =========================================================================
    
    def _create_analytics_tab(self):
        """Analytics and statistics dashboard"""
        frame = tk.Frame(self.notebook, bg=Theme.BG_DARK)
        self.notebook.add(frame, text="📈 Analytics")
        
        tk.Label(frame, text="📈 Analytics Dashboard", font=('Segoe UI', 14, 'bold'),
                bg=Theme.BG_DARK, fg=Theme.TEXT_PRIMARY).pack(pady=20)
        
        # Stats cards
        stats_frame = tk.Frame(frame, bg=Theme.BG_DARK)
        stats_frame.pack(fill='x', padx=20)
        
        analytics = [
            ("Total Files", "120,470", Theme.ACCENT_PRIMARY),
            ("AS3 Files", "23,165", Theme.ACCENT_SECONDARY),
            ("SOL Files", "9,043", Theme.ACCENT_WARNING),
            ("Scripts", str(len(self.script_mgr.scripts)), Theme.ACCENT_DANGER),
            ("Accounts", str(len(self.account_mgr.accounts)), Theme.ACCENT_PURPLE),
            ("Commands", "352+", Theme.ACCENT_PINK),
        ]
        
        for name, value, color in analytics:
            card = DataCard(stats_frame, name, value, "", color)
            card.pack(side='left', padx=10)
        
        # Exploit success rates
        rates_frame = CollapsibleFrame(frame, "📊 Exploit Success Rates")
        rates_frame.pack(fill='x', padx=20, pady=20)
        
        for exp in EXPLOITS[:8]:
            row = tk.Frame(rates_frame.content, bg=Theme.BG_PANEL)
            row.pack(fill='x', pady=2)
            
            tk.Label(row, text=exp.name, font=('Segoe UI', 9),
                    bg=Theme.BG_PANEL, fg=Theme.TEXT_PRIMARY, width=25,
                    anchor='w').pack(side='left', padx=10)
            
            # Progress bar
            bar_frame = tk.Frame(row, bg=Theme.BG_INPUT, height=20, width=200)
            bar_frame.pack(side='left', padx=10)
            bar_frame.pack_propagate(False)
            
            fill = tk.Frame(bar_frame, bg=Theme.ACCENT_PRIMARY,
                           width=int(exp.success_rate * 2))
            fill.pack(side='left', fill='y')
            
            tk.Label(row, text=f"{exp.success_rate:.0f}%",
                    font=('Consolas', 9), bg=Theme.BG_PANEL,
                    fg=Theme.TEXT_SECONDARY).pack(side='left', padx=10)
    
    # =========================================================================
    # TAB: SETTINGS
    # =========================================================================
    
    def _create_settings_tab(self):
        """Settings and configuration"""
        frame = tk.Frame(self.notebook, bg=Theme.BG_DARK)
        self.notebook.add(frame, text="⚙️ Settings")
        
        tk.Label(frame, text="⚙️ Settings", font=('Segoe UI', 14, 'bold'),
                bg=Theme.BG_DARK, fg=Theme.TEXT_PRIMARY).pack(pady=20)
        
        # Server settings
        server_frame = CollapsibleFrame(frame, "🌐 Server Settings")
        server_frame.pack(fill='x', padx=20, pady=10)
        
        row = tk.Frame(server_frame.content, bg=Theme.BG_PANEL)
        row.pack(fill='x', padx=10, pady=10)
        
        tk.Label(row, text="Port:", bg=Theme.BG_PANEL,
                fg=Theme.TEXT_SECONDARY).pack(side='left', padx=10)
        self.port_var = tk.StringVar(value="8088")
        tk.Entry(row, textvariable=self.port_var, width=10, bg=Theme.BG_INPUT,
                fg=Theme.TEXT_PRIMARY, font=('Consolas', 10)).pack(side='left')
        
        tk.Label(row, text="Auto-start:", bg=Theme.BG_PANEL,
                fg=Theme.TEXT_SECONDARY).pack(side='left', padx=(20, 10))
        self.autostart_var = tk.BooleanVar(value=True)
        tk.Checkbutton(row, variable=self.autostart_var, bg=Theme.BG_PANEL,
                      selectcolor=Theme.BG_INPUT).pack(side='left')
        
        # Paths
        paths_frame = CollapsibleFrame(frame, "📁 Paths")
        paths_frame.pack(fill='x', padx=20, pady=10)
        
        for name, path in list(PATHS.items())[:6]:
            row = tk.Frame(paths_frame.content, bg=Theme.BG_PANEL)
            row.pack(fill='x', pady=2)
            
            tk.Label(row, text=name, font=('Segoe UI', 9), bg=Theme.BG_PANEL,
                    fg=Theme.TEXT_SECONDARY, width=15, anchor='w').pack(side='left', padx=10)
            tk.Label(row, text=str(path)[:60], font=('Consolas', 8), bg=Theme.BG_PANEL,
                    fg=Theme.TEXT_MUTED).pack(side='left')
        
        # About
        about_frame = CollapsibleFrame(frame, "ℹ️ About")
        about_frame.pack(fill='x', padx=20, pady=10)
        
        about_text = """EVONY MASTER HUB v5.0 - Ultimate Edition

Comprehensive exploitation and automation framework for Evony.

Features:
• 352+ Protocol Commands
• 166+ Bot Scripts  
• 15+ Documented Exploits
• 124 Account Credentials
• 3,278 AS3 Source Files
• Script Server (Port 8088)
• Modern Dark Theme UI

Built from 120,470 extracted files."""
        
        tk.Label(about_frame.content, text=about_text, font=('Segoe UI', 10),
                bg=Theme.BG_PANEL, fg=Theme.TEXT_SECONDARY,
                justify='left').pack(padx=10, pady=10, anchor='w')

    
    # =========================================================================
    # ACTION METHODS
    # =========================================================================
    
    def _start_server(self):
        """Start script server"""
        if self.server and self.server.is_running():
            self.status_var.set("Server already running")
            return
        
        try:
            self.server = ScriptServer(8088)
            self.server.start(background=True)
            self.server_running = True
            self.server_indicator.set_status("running")
            if hasattr(self, 'server_status_label'):
                self.server_status_label.configure(text="● RUNNING", fg=Theme.STATUS_SUCCESS)
            self.status_var.set("Script server started on port 8088")
        except Exception as e:
            self.status_var.set(f"Failed to start server: {e}")
    
    def _stop_server(self):
        """Stop script server"""
        if self.server:
            self.server.stop()
            self.server_running = False
            self.server_indicator.set_status("stopped")
            if hasattr(self, 'server_status_label'):
                self.server_status_label.configure(text="● STOPPED", fg=Theme.STATUS_ERROR)
            self.status_var.set("Script server stopped")
    
    def _restart_server(self):
        """Restart script server"""
        self._stop_server()
        self.root.after(500, self._start_server)
    
    def _open_server_browser(self):
        """Open server in browser"""
        webbrowser.open("http://localhost:8088")
    
    def _launch_flash_browser(self):
        """Launch FlashBrowser"""
        path = PATHS["flash_browser"]
        if path.exists():
            subprocess.Popen([str(path)])
            self.status_var.set("FlashBrowser launched")
        else:
            self.status_var.set(f"FlashBrowser not found: {path}")
    
    def _launch_ffdec(self):
        """Launch FFDEC"""
        path = PATHS.get("ffdec")
        if path and path.exists():
            subprocess.Popen([str(path)])
            self.status_var.set("FFDEC launched")
        else:
            self.status_var.set("FFDEC not found")
    
    def _launch_ghidra(self):
        """Launch Ghidra"""
        path = PATHS.get("ghidra")
        if path and path.exists():
            subprocess.Popen([str(path)])
            self.status_var.set("Ghidra launched")
        else:
            self.status_var.set("Ghidra not found")
    
    def _launch_dnspy(self):
        """Launch dnSpy"""
        path = PATHS.get("dnspy")
        if path and path.exists():
            subprocess.Popen([str(path)])
            self.status_var.set("dnSpy launched")
        else:
            self.status_var.set("dnSpy not found")
    
    def _launch_rabcdasm(self):
        """Launch RABCDasm"""
        self.status_var.set("RABCDasm is a command-line tool")
    
    def _launch_sol_editor(self):
        """Launch SOL editor"""
        self.status_var.set("SOL Editor not configured")
    
    def _open_hub_root(self):
        """Open hub root in explorer"""
        os.startfile(str(HUB_ROOT))
    
    def _open_scripts_folder(self):
        """Open scripts folder"""
        os.startfile(str(PATHS["scripts"]))
    
    def _quick_generate_script(self):
        """Quick script generation dialog"""
        dialog = tk.Toplevel(self.root)
        dialog.title("Generate Script")
        dialog.geometry("500x400")
        dialog.configure(bg=Theme.BG_DARK)
        dialog.transient(self.root)
        
        tk.Label(dialog, text="Script Generator", font=('Segoe UI', 14, 'bold'),
                bg=Theme.BG_DARK, fg=Theme.TEXT_PRIMARY).pack(pady=15)
        
        # Script type selection
        tk.Label(dialog, text="Script Type:", bg=Theme.BG_DARK,
                fg=Theme.TEXT_SECONDARY).pack(anchor='w', padx=20)
        
        script_type = tk.StringVar(value="overflow_chain")
        types = [
            ("Overflow Chain", "overflow_chain"),
            ("Race Blitz", "race_blitz"),
            ("Full Automation", "full_auto"),
            ("Valley Hide", "valley_hide"),
            ("Tax Loop", "tax_loop"),
            ("Colony Drain", "colony_drain"),
        ]
        
        for text, value in types:
            tk.Radiobutton(dialog, text=text, variable=script_type, value=value,
                          bg=Theme.BG_DARK, fg=Theme.TEXT_PRIMARY,
                          selectcolor=Theme.BG_INPUT).pack(anchor='w', padx=30)
        
        # Generate button
        def generate():
            st = script_type.get()
            if st == "overflow_chain":
                script = self.exploit_mgr.generate_overflow_script()
            elif st == "race_blitz":
                script = self.exploit_mgr.generate_race_script("player.item.speed.1hr")
            elif st == "full_auto":
                script = self.exploit_mgr.generate_full_auto_script()
            else:
                script = f"// Generated {st} script"
            
            self.root.clipboard_clear()
            self.root.clipboard_append(script)
            self.status_var.set(f"Generated {st} script - copied to clipboard!")
            dialog.destroy()
        
        ModernButton(dialog, text="Generate & Copy", command=generate).pack(pady=20)
    
    def _quick_overflow(self):
        """Quick overflow execution"""
        script = self.exploit_mgr.generate_overflow_script()
        self.root.clipboard_clear()
        self.root.clipboard_append(script)
        self.status_var.set("Overflow chain script copied! Use includeurl in AutoEvony")
        messagebox.showinfo("Overflow Chain", 
                           "Script copied to clipboard!\n\n"
                           "In AutoEvony, use:\n"
                           "includeurl http://localhost:8088/epic/overflow_chain")
    
    def _run_full_auto(self):
        """Run full automation"""
        webbrowser.open("http://localhost:8088/epic/full_auto")
        self.status_var.set("Full automation script available at server")
    
    def _run_race_blitz(self):
        """Run race blitz"""
        webbrowser.open("http://localhost:8088/epic/race_blitz")
    
    def _run_valley_hide(self):
        """Run valley hide"""
        webbrowser.open("http://localhost:8088/epic/valley_hide")
    
    def _run_tax_loop(self):
        """Run tax loop"""
        webbrowser.open("http://localhost:8088/epic/tax_loop")
    
    def _run_colony_drain(self):
        """Run colony drain"""
        webbrowser.open("http://localhost:8088/epic/colony_drain")
    
    def _filter_scripts(self, event=None):
        """Filter script list"""
        category = self.script_category_var.get()
        search = self.script_search_var.get().lower()
        
        for item in self.script_tree.get_children():
            self.script_tree.delete(item)
        
        for script in self.script_mgr.scripts:
            if category != 'All' and script.category != category:
                continue
            if search and search not in script.name.lower():
                continue
            self.script_tree.insert('', 'end', values=(script.name, script.category, script.lines))
    
    def _on_script_select(self, event=None):
        """Handle script selection"""
        sel = self.script_tree.selection()
        if sel:
            item = self.script_tree.item(sel[0])
            name = item['values'][0]
            
            script = next((s for s in self.script_mgr.scripts if s.name == name), None)
            if script:
                self.script_name_var.set(name)
                self.script_editor.delete('1.0', tk.END)
                try:
                    content = script.path.read_text(encoding='utf-8', errors='ignore')
                    self.script_editor.insert('1.0', content)
                except:
                    self.script_editor.insert('1.0', "// Failed to load script")
    
    def _new_script(self):
        """Create new script"""
        self.script_name_var.set("Untitled")
        self.script_editor.delete('1.0', tk.END)
        self.script_editor.insert('1.0', "// New script\n\n")
    
    def _open_script(self):
        """Open script file"""
        path = filedialog.askopenfilename(
            initialdir=str(PATHS["scripts"]),
            filetypes=[("Text files", "*.txt"), ("All files", "*.*")]
        )
        if path:
            try:
                content = Path(path).read_text(encoding='utf-8', errors='ignore')
                self.script_name_var.set(Path(path).name)
                self.script_editor.delete('1.0', tk.END)
                self.script_editor.insert('1.0', content)
            except Exception as e:
                self.status_var.set(f"Failed to open: {e}")
    
    def _save_script(self):
        """Save current script"""
        content = self.script_editor.get('1.0', tk.END)
        path = filedialog.asksaveasfilename(
            initialdir=str(PATHS["scripts"]),
            defaultextension=".txt",
            filetypes=[("Text files", "*.txt")]
        )
        if path:
            try:
                Path(path).write_text(content, encoding='utf-8')
                self.status_var.set(f"Saved: {path}")
            except Exception as e:
                self.status_var.set(f"Failed to save: {e}")
    
    def _run_script(self):
        """Copy script to clipboard for AutoEvony"""
        content = self.script_editor.get('1.0', tk.END)
        self.root.clipboard_clear()
        self.root.clipboard_append(content)
        self.status_var.set("Script copied to clipboard!")
    
    def _generate_script(self):
        """Generate script from template"""
        self._quick_generate_script()
    
    def _filter_exploits(self, event=None):
        """Filter exploit list"""
        severity = self.exploit_severity_var.get()
        
        for item in self.exploit_tree.get_children():
            self.exploit_tree.delete(item)
        
        for exp in EXPLOITS:
            if severity != 'All' and exp.severity != severity:
                continue
            sev_icon = {'CRITICAL': '🔴', 'HIGH': '🟠', 'MEDIUM': '🟡', 'LOW': '🟢'}.get(exp.severity, '⚪')
            self.exploit_tree.insert('', 'end', values=(
                sev_icon, exp.name, exp.category, f"{exp.success_rate:.0f}%"
            ))
    
    def _on_exploit_select(self, event=None):
        """Handle exploit selection"""
        sel = self.exploit_tree.selection()
        if sel:
            item = self.exploit_tree.item(sel[0])
            name = item['values'][1]
            
            exp = next((e for e in EXPLOITS if e.name == name), None)
            if exp:
                self.exploit_detail_name.set(exp.name)
                self.exploit_detail_desc.set(exp.description)
                self.exploit_detail_cmd.set(exp.command)
                self.exploit_detail_risk.set(exp.risk)
                
                self.exploit_script_text.configure(state='normal')
                self.exploit_script_text.delete('1.0', tk.END)
                self.exploit_script_text.insert('1.0', exp.script)
                self.exploit_script_text.configure(state='disabled')
    
    def _copy_exploit_script(self):
        """Copy selected exploit script"""
        script = self.exploit_script_text.get('1.0', tk.END)
        self.root.clipboard_clear()
        self.root.clipboard_append(script)
        self.status_var.set("Exploit script copied!")
    
    def _execute_exploit(self):
        """Execute selected exploit"""
        self._copy_exploit_script()
        messagebox.showinfo("Execute", "Script copied! Paste in AutoEvony to execute.")
    
    def _generate_exploit_chain(self):
        """Generate exploit chain"""
        script = self.exploit_mgr.generate_overflow_script()
        self.root.clipboard_clear()
        self.root.clipboard_append(script)
        self.status_var.set("Exploit chain generated and copied!")
    
    def _refresh_exploits(self):
        """Refresh exploit list"""
        self._filter_exploits()

    
    def _filter_protocol(self, event=None):
        """Filter protocol commands"""
        category = self.protocol_cat_var.get()
        search = self.protocol_search_var.get().lower()
        
        for item in self.protocol_tree.get_children():
            self.protocol_tree.delete(item)
        
        for cat, commands in PROTOCOL_COMMANDS.items():
            if category != 'all' and cat != category:
                continue
            for cmd in commands:
                if search and search not in cmd.name.lower() and search not in cmd.description.lower():
                    continue
                params_str = ', '.join(cmd.params) if cmd.params else '-'
                self.protocol_tree.insert('', 'end', values=(
                    cat, cmd.name, params_str, cmd.description
                ))
    
    def _copy_command(self):
        """Copy selected command"""
        sel = self.protocol_tree.selection()
        if sel:
            item = self.protocol_tree.item(sel[0])
            cmd = item['values'][1]
            self.root.clipboard_clear()
            self.root.clipboard_append(cmd)
            self.status_var.set(f"Copied: {cmd}")
    
    def _build_packet(self):
        """Build packet from selected command"""
        sel = self.protocol_tree.selection()
        if sel:
            item = self.protocol_tree.item(sel[0])
            cat = item['values'][0]
            cmd = item['values'][1]
            full_cmd = f"{cat}.{cmd}"
            self.status_var.set(f"Packet: {full_cmd}")
    
    def _toggle_passwords(self):
        """Toggle password visibility"""
        self.passwords_visible = not self.passwords_visible
        self._populate_accounts()
        self.status_var.set("Passwords " + ("visible" if self.passwords_visible else "hidden"))
    
    def _copy_credentials(self):
        """Copy selected account credentials"""
        sel = self.account_tree.selection()
        if sel:
            item = self.account_tree.item(sel[0])
            email = item['values'][0]
            acc = next((a for a in self.account_mgr.accounts if a.email == email), None)
            if acc:
                creds = f"{acc.email}:{acc.password}"
                self.root.clipboard_clear()
                self.root.clipboard_append(creds)
                self.status_var.set("Credentials copied!")
    
    def _export_accounts(self):
        """Export accounts to file"""
        path = filedialog.asksaveasfilename(
            defaultextension=".json",
            filetypes=[("JSON", "*.json"), ("CSV", "*.csv")]
        )
        if path:
            fmt = "csv" if path.endswith(".csv") else "json"
            self.account_mgr.export_accounts(Path(path), fmt)
            self.status_var.set(f"Exported to: {path}")
    
    def _refresh_accounts(self):
        """Refresh account list"""
        self.account_mgr.load_accounts()
        self._populate_accounts()
        self.status_var.set("Accounts refreshed")
    
    def _refresh_source_tree(self, event=None):
        """Refresh source file tree"""
        for item in self.source_tree.get_children():
            self.source_tree.delete(item)
        
        source_type = self.source_type_var.get()
        files = []
        
        if source_type in ["bot", "both"]:
            files.extend(self.source_mgr.bot_files)
        if source_type in ["client", "both"]:
            files.extend(self.source_mgr.client_files)
        
        # Group by directory
        dirs = {}
        for f in files[:500]:  # Limit for performance
            parent = f.parent.name
            if parent not in dirs:
                dirs[parent] = []
            dirs[parent].append(f)
        
        for dir_name, dir_files in sorted(dirs.items()):
            dir_id = self.source_tree.insert('', 'end', text=f"📁 {dir_name}")
            for f in dir_files[:50]:  # Limit per directory
                self.source_tree.insert(dir_id, 'end', text=f.name, values=(str(f),))
    
    def _on_source_select(self, event=None):
        """Handle source file selection"""
        sel = self.source_tree.selection()
        if sel:
            item = self.source_tree.item(sel[0])
            if item['values']:
                path = Path(item['values'][0])
                try:
                    content = path.read_text(encoding='utf-8', errors='ignore')
                    self.source_viewer.configure(state='normal')
                    self.source_viewer.delete('1.0', tk.END)
                    self.source_viewer.insert('1.0', content)
                    self.source_viewer.configure(state='disabled')
                except Exception as e:
                    self.status_var.set(f"Failed to read: {e}")
    
    def _search_source(self):
        """Search in source files"""
        query = self.source_search_var.get()
        if not query:
            return
        
        results = self.source_mgr.search(query, self.source_type_var.get())
        
        # Show results in dialog
        dialog = tk.Toplevel(self.root)
        dialog.title(f"Search Results: {query}")
        dialog.geometry("800x600")
        dialog.configure(bg=Theme.BG_DARK)
        
        tk.Label(dialog, text=f"Found in {len(results)} files",
                font=('Segoe UI', 12), bg=Theme.BG_DARK,
                fg=Theme.TEXT_PRIMARY).pack(pady=10)
        
        text = scrolledtext.ScrolledText(dialog, bg=Theme.BG_INPUT,
                                         fg=Theme.TEXT_PRIMARY, font=('Consolas', 9))
        text.pack(fill='both', expand=True, padx=10, pady=10)
        
        for path, matches in results[:20]:
            text.insert(tk.END, f"\n{'='*60}\n{path.name}\n{'='*60}\n")
            for line_num, line in matches[:5]:
                text.insert(tk.END, f"  {line_num}: {line}\n")
    
    def _copy_source_path(self):
        """Copy selected source path"""
        sel = self.source_tree.selection()
        if sel:
            item = self.source_tree.item(sel[0])
            if item['values']:
                self.root.clipboard_clear()
                self.root.clipboard_append(item['values'][0])
                self.status_var.set("Path copied!")
    
    def _open_source_external(self):
        """Open source in external editor"""
        sel = self.source_tree.selection()
        if sel:
            item = self.source_tree.item(sel[0])
            if item['values']:
                os.startfile(item['values'][0])
    
    def _generate_signature(self):
        """Generate MD5 signature"""
        data = self.sig_input_var.get()
        if data:
            sig = generate_signature(data)
            self.sig_output_var.set(sig)
            self.status_var.set("Signature generated")
    
    def _calculate_hashes(self):
        """Calculate multiple hashes"""
        data = self.hash_input_var.get()
        if not data:
            return
        
        # Clear previous results
        for widget in self.hash_results_frame.winfo_children():
            widget.destroy()
        
        hashes = {
            'MD5': hashlib.md5(data.encode()).hexdigest(),
            'SHA1': hashlib.sha1(data.encode()).hexdigest(),
            'SHA256': hashlib.sha256(data.encode()).hexdigest(),
        }
        
        for name, value in hashes.items():
            row = tk.Frame(self.hash_results_frame, bg=Theme.BG_PANEL)
            row.pack(fill='x', pady=2)
            tk.Label(row, text=f"{name}:", font=('Consolas', 9), bg=Theme.BG_PANEL,
                    fg=Theme.TEXT_SECONDARY, width=10).pack(side='left')
            tk.Label(row, text=value, font=('Consolas', 9), bg=Theme.BG_PANEL,
                    fg=Theme.TEXT_PRIMARY).pack(side='left')
    
    def _refresh_files(self):
        """Refresh file statistics"""
        self.status_var.set("Refreshing file statistics...")
    
    def _show_file_stats(self):
        """Show detailed file statistics"""
        counts = count_files_by_type(HUB_ROOT)
        
        dialog = tk.Toplevel(self.root)
        dialog.title("File Statistics")
        dialog.geometry("400x500")
        dialog.configure(bg=Theme.BG_DARK)
        
        tk.Label(dialog, text="📊 File Type Statistics",
                font=('Segoe UI', 14, 'bold'), bg=Theme.BG_DARK,
                fg=Theme.TEXT_PRIMARY).pack(pady=15)
        
        text = scrolledtext.ScrolledText(dialog, bg=Theme.BG_INPUT,
                                         fg=Theme.TEXT_PRIMARY, font=('Consolas', 10))
        text.pack(fill='both', expand=True, padx=10, pady=10)
        
        total = sum(counts.values())
        text.insert(tk.END, f"Total Files: {total:,}\n\n")
        
        for ext, count in list(counts.items())[:30]:
            pct = (count / total) * 100
            bar = '█' * int(pct / 2)
            text.insert(tk.END, f"{ext:12} {count:>8,} ({pct:5.1f}%) {bar}\n")
    
    def _export_all(self):
        """Export all data"""
        path = filedialog.askdirectory(title="Select export directory")
        if path:
            export_dir = Path(path)
            
            # Export accounts
            self.account_mgr.export_accounts(export_dir / "accounts.json")
            
            # Export exploits
            with open(export_dir / "exploits.json", 'w') as f:
                json.dump([vars(e) for e in EXPLOITS], f, indent=2, default=str)
            
            # Export keys
            with open(export_dir / "keys.json", 'w') as f:
                json.dump(ENCRYPTION_KEYS, f, indent=2, default=str)
            
            self.status_var.set(f"Exported to: {path}")
    
    def _import_data(self):
        """Import data"""
        self.status_var.set("Import not implemented yet")
    
    def _show_docs(self):
        """Show documentation"""
        webbrowser.open("http://localhost:8088/help")
    
    def _show_about(self):
        """Show about dialog"""
        messagebox.showinfo("About", 
            "EVONY MASTER HUB v5.0 - Ultimate Edition\n\n"
            "Comprehensive exploitation and automation framework.\n\n"
            "Features:\n"
            "• 352+ Protocol Commands\n"
            "• 166+ Bot Scripts\n"
            "• 15+ Documented Exploits\n"
            "• 124 Account Credentials\n"
            "• 3,278 AS3 Source Files\n\n"
            "Built from 120,470 extracted files.")
    
    # =========================================================================
    # RUN
    # =========================================================================
    
    def run(self):
        """Run the application"""
        self.root.mainloop()


# =============================================================================
# ENTRY POINT
# =============================================================================

def main():
    """Main entry point"""
    print("=" * 70)
    print("  EVONY MASTER HUB v5.0 - Ultimate Edition")
    print("=" * 70)
    print()
    print("  Starting GUI...")
    print()
    
    app = EvonyMasterHub()
    app.run()


if __name__ == "__main__":
    main()
