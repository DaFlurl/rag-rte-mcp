#!/usr/bin/env python3
"""
═══════════════════════════════════════════════════════════════════════════════
  EVONY MASTER SUITE - Ultimate Integrated Hacking Framework
═══════════════════════════════════════════════════════════════════════════════

  Combines 120,470 files of extracted data:
  - 124 accounts with credentials
  - 1,209+ automation scripts
  - 3,278 decompiled AS3 source files
  - 301+ protocol commands
  - All encryption keys
  - 15+ documented exploits
  - FlashBrowser integration
  - AMF packet manipulation

  Usage:
      python master_suite.py

  Then open: http://localhost:9000
═══════════════════════════════════════════════════════════════════════════════
"""

import os
import sys
import json
import hashlib
import threading
import subprocess
import webbrowser
import re
import glob
from pathlib import Path
from datetime import datetime
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse, parse_qs, unquote
import socket
import mimetypes

# =============================================================================
# CONFIGURATION
# =============================================================================

PORT = 9000
HOST = "0.0.0.0"
BASE_DIR = Path(__file__).parent.parent  # Evony_Decrypted folder

# Directory paths
PATHS = {
    'accounts': BASE_DIR / 'Accounts',
    'scripts': BASE_DIR / 'Scripts',
    'sol_analysis': BASE_DIR / 'sol_analysis',
    'autoevony_src': BASE_DIR / 'AS3_Scripts_(AutoEvony2_NEW.swf)',
    'client_src': BASE_DIR / 'AS3_Scripts_(EvonyClient1921.swf)',
    'tools': BASE_DIR / 'Tools',
    'flash_browser': BASE_DIR / 'FlashBrowser',
    'borg_toolkit': BASE_DIR / 'BorgToolkit',
    'sol_accounts': BASE_DIR / 'SOL_Accounts',
    'pyamf': BASE_DIR / 'PyAMF',
}

# =============================================================================
# ENCRYPTION KEYS
# =============================================================================

KEYS = {
    'ACTION_KEY': "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}",
    'API_KEY': "9f758e2deccbe6244f734371b9642eda",
    'USER_INFO_KEY': "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}",
    'XOR_KEY': 0xAA,
    'LOGIN_SALT': "evony",
    'GAME_KEY': "EvonyGameKey2009",
    'NETWORK_KEY': "EvonyNetKey2009",
}

# =============================================================================
# INTEGER OVERFLOW CALCULATIONS
# =============================================================================

INT32_MAX = 2147483647
UINT32_MAX = 4294967295

TROOP_DATA = {
    1: {'name': 'Worker', 'abbrev': 'wo', 'food': 50, 'pop': 1},
    2: {'name': 'Warrior', 'abbrev': 'wa', 'food': 75, 'pop': 1},
    3: {'name': 'Scout', 'abbrev': 'sc', 'food': 100, 'pop': 2},
    4: {'name': 'Pikeman', 'abbrev': 'pi', 'food': 200, 'pop': 1},
    5: {'name': 'Swordsman', 'abbrev': 'sw', 'food': 250, 'pop': 1},
    6: {'name': 'Archer', 'abbrev': 'a', 'food': 350, 'pop': 1},
    7: {'name': 'Cavalry', 'abbrev': 'cav', 'food': 800, 'pop': 3},
    8: {'name': 'Cataphract', 'abbrev': 'cata', 'food': 1500, 'pop': 5},
    9: {'name': 'Transporter', 'abbrev': 'tr', 'food': 300, 'pop': 3},
    10: {'name': 'Ballista', 'abbrev': 'ba', 'food': 2000, 'pop': 6},
    11: {'name': 'Ram', 'abbrev': 'r', 'food': 2500, 'pop': 8},
    12: {'name': 'Catapult', 'abbrev': 'c', 'food': 3000, 'pop': 10},
}

# Calculate overflow thresholds
for tid, data in TROOP_DATA.items():
    data['overflow_threshold'] = (INT32_MAX // data['food']) + 1
    data['expected_gain'] = (data['overflow_threshold'] * data['food']) - INT32_MAX

# =============================================================================
# SAFETY LIMITS
# =============================================================================

SAFETY_LIMITS = {
    'MAX_SAFE_FOOD': 485_000_000,
    'MAX_SAFE_TROOP_SINGLE': 700_000_000,
    'MAX_VALLEY_TRANSPORT': 495_000_000,
    'FOOD_FLIP_DANGER': 999_000_000,
    'WAVE_TROOP_COUNT': 33_000,
    'AMULET_TARGET_DAILY': 15_000,
}

# =============================================================================
# EXPLOITS DATABASE
# =============================================================================

EXPLOITS = {
    'troop_overflow': {
        'name': 'Troop Production Overflow',
        'severity': 'CRITICAL',
        'category': 'Integer Overflow',
        'description': 'Train troops with count that causes integer overflow, resulting in negative cost = resource gain',
        'example': 'train a:6135037',
        'gain': '~2.1 billion food per execution',
    },
    'food_flip': {
        'name': 'Food Flip Glitch',
        'severity': 'CRITICAL',
        'category': 'Integer Overflow',
        'description': 'Food resets to 0 when exceeding 999M. Stay below 485M for safety.',
        'example': 'Monitor food level, transport excess',
        'warning': 'CAN DESTROY ALL FOOD',
    },
    'valley_hide': {
        'name': 'Valley Troop Hiding',
        'severity': 'HIGH',
        'category': 'Resource Management',
        'description': 'Reinforce valleys to hide troops from food consumption',
        'example': 'reinforce 500,500 any all none',
    },
    'race_condition_item': {
        'name': 'Item Use Race Condition',
        'severity': 'MEDIUM',
        'category': 'Race Condition',
        'description': 'Rapid item use requests may consume less than expected',
        'example': '50 rapid useitem calls without delays',
    },
    'army_clone': {
        'name': 'Army Cloning',
        'severity': 'MEDIUM',
        'category': 'Race Condition',
        'description': 'Send same army to multiple targets rapidly',
        'example': 'Rapid attack to 3 targets simultaneously',
    },
    'security_enum': {
        'name': 'Security Code Enumeration',
        'severity': 'LOW',
        'category': 'Brute Force',
        'description': 'Try common security codes',
        'example': 'authsecurity 0000, 1234, etc.',
    },
    'package_enum': {
        'name': 'Package ID Enumeration',
        'severity': 'LOW',
        'category': 'Enumeration',
        'description': 'Try claiming packages by ID',
        'example': 'getpackage 1-1000',
    },
    'quest_commission': {
        'name': 'Quest Commission Glitch',
        'severity': 'MEDIUM',
        'category': 'Quest Exploit',
        'description': 'Commission quest reward manipulation',
        'example': 'See CommisionQuest_Troop_Glitch.txt',
    },
    'tax_spam': {
        'name': 'Tax Levy Spam',
        'severity': 'LOW',
        'category': 'Automation',
        'description': 'Rapid tax collection with comfort',
        'example': 'Loop: levy tax -> comfort disaster',
    },
    'colony_drain': {
        'name': 'Colony Resource Drain',
        'severity': 'LOW',
        'category': 'Automation',
        'description': 'Auto-levy all colony resources',
        'example': 'colony levyfood all; colony levytax all',
    },
}

# =============================================================================
# PROTOCOL COMMANDS (301+ from source)
# =============================================================================

PROTOCOL_COMMANDS = {
    'troop': [
        'troop.produceTroop', 'troop.cancelTroopProduce', 'troop.cancelAllTroopProduce',
        'troop.disbandTroop', 'troop.treatTroop', 'troop.checkIdleBarracks',
        'troop.getTrainingData', 'troop.speedUpTraining', 'troop.reviveTroop',
    ],
    'army': [
        'army.createArmy', 'army.disbandArmy', 'army.newArmy', 'army.getStayAllianceArmys',
        'army.callBackArmy', 'army.setArmyGoOut', 'army.getInjuredTroop',
        'army.speedupArmyAtHome', 'army.setDefenseHero', 'army.setAllowArmy',
    ],
    'hero': [
        'hero.tryGetSeizedHero', 'hero.getHerosListFromTavern', 'hero.hireHero',
        'hero.fireHero', 'hero.promoteHero', 'hero.awardGold', 'hero.levelUp',
        'hero.addPoint', 'hero.changeName', 'hero.releaseHero', 'hero.refreshHerosListFromTavern',
    ],
    'castle': [
        'castle.upgrade', 'castle.speedUpBuild', 'castle.destructBuilding',
        'castle.getAvailableBuildingListInside', 'castle.getAvailableBuildingListOutside',
        'castle.getCoinsNeed', 'castle.checkOutUpgrade', 'castle.newBuilding',
        'castle.cancleBuildCommand', 'castle.getDestructTime',
    ],
    'interior': [
        'interior.modifyCommenceRate', 'interior.taxLevy', 'interior.getResourceProduceData',
        'interior.modifyTaxRate', 'interior.pacifyPeople', 'interior.comforting',
        'interior.setPopulationLimit', 'interior.recruiting', 'interior.getAvailablePopulation',
    ],
    'tech': [
        'tech.research', 'tech.getCoinsNeed', 'tech.cancelResearch',
        'tech.speedUpResearch', 'tech.getResearchList',
    ],
    'shop': [
        'shop.buy', 'shop.useGoods', 'shop.sell', 'shop.getShopList',
        'shop.getBuyResourceInfo', 'shop.buyResource', 'shop.useCastleGoods',
    ],
    'quest': [
        'quest.getQuestList', 'quest.getQuestType', 'quest.award', 'quest.abandon',
        'quest.process', 'quest.getQuest', 'quest.obtainQuest', 'quest.acceptCommission',
    ],
    'alliance': [
        'alliance.create', 'alliance.disband', 'alliance.join', 'alliance.exit',
        'alliance.kickOutMember', 'alliance.invitePlayer', 'alliance.cancelInvite',
        'alliance.setAllianceFriendship', 'alliance.resetTopRank', 'alliance.setAllowJoin',
    ],
    'colony': [
        'colony.getColonyList', 'colony.abandon', 'colony.levyTax', 'colony.levyFood',
        'colony.levyTroop', 'colony.getSafeLevel', 'colony.setColonyPriority',
    ],
    'mail': [
        'mail.send', 'mail.readMail', 'mail.deleteMail', 'mail.getAllMail',
        'mail.reportMail', 'mail.sendAllianceMail', 'mail.deleteAllExpired',
    ],
    'common': [
        'common.getPackage', 'common.getItemDefData', 'common.getPackageList',
        'common.getPackageDetailList', 'common.buyCoins', 'common.redeemSerialCode',
        'common.getSecurityCode', 'common.modifySecurityCode', 'common.authSecurityCode',
    ],
    'fortifications': [
        'fortifications.produceFortification', 'fortifications.cancelFortificationProduce',
        'fortifications.destructWallProtection', 'fortifications.getFortifications',
    ],
    'trade': [
        'trade.create', 'trade.cancel', 'trade.searchTrades', 'trade.speedUp',
        'trade.getTransingTradeList', 'trade.newTrade',
    ],
    'gameclient': [
        'gameClient.login', 'gameClient.logout', 'gameClient.heartBeat',
        'gameClient.createPlayer', 'gameClient.checkSession',
    ],
}

# Count total commands
TOTAL_COMMANDS = sum(len(cmds) for cmds in PROTOCOL_COMMANDS.values())


# =============================================================================
# DATA LOADERS
# =============================================================================

class DataLoader:
    """Load data from extracted files"""
    
    @staticmethod
    def load_accounts():
        """Load accounts from sol_analysis"""
        accounts_file = PATHS['sol_analysis'] / 'accounts_extracted.json'
        if accounts_file.exists():
            try:
                with open(accounts_file, 'r', encoding='utf-8') as f:
                    return json.load(f)
            except:
                pass
        return []
    
    @staticmethod
    def load_scripts():
        """Load script files from Scripts directory"""
        scripts = []
        scripts_dir = PATHS['scripts']
        if scripts_dir.exists():
            for f in scripts_dir.glob('*.txt'):
                try:
                    content = f.read_text(encoding='utf-8', errors='ignore')[:5000]
                    scripts.append({
                        'name': f.name,
                        'path': str(f),
                        'preview': content[:500],
                        'size': f.stat().st_size,
                    })
                except:
                    pass
        return scripts
    
    @staticmethod
    def load_source_files(directory, extension='*.as'):
        """Load source files from directory"""
        files = []
        src_dir = PATHS.get(directory)
        if src_dir and src_dir.exists():
            for f in src_dir.rglob(extension):
                try:
                    files.append({
                        'name': f.name,
                        'path': str(f.relative_to(src_dir)),
                        'full_path': str(f),
                        'size': f.stat().st_size,
                    })
                except:
                    pass
        return files
    
    @staticmethod
    def search_source(query, directory='autoevony_src'):
        """Search source files for pattern"""
        results = []
        src_dir = PATHS.get(directory)
        if not src_dir or not src_dir.exists():
            return results
        
        pattern = re.compile(query, re.IGNORECASE)
        for f in src_dir.rglob('*.as'):
            try:
                content = f.read_text(encoding='utf-8', errors='ignore')
                matches = pattern.findall(content)
                if matches:
                    # Get context around first match
                    match = pattern.search(content)
                    if match:
                        start = max(0, match.start() - 100)
                        end = min(len(content), match.end() + 100)
                        context = content[start:end]
                        results.append({
                            'file': f.name,
                            'path': str(f.relative_to(src_dir)),
                            'matches': len(matches),
                            'context': context,
                        })
            except:
                pass
        return results[:50]  # Limit results
    
    @staticmethod
    def get_file_content(path):
        """Get content of a specific file"""
        try:
            with open(path, 'r', encoding='utf-8', errors='ignore') as f:
                return f.read()
        except:
            return None
    
    @staticmethod
    def get_stats():
        """Get overall statistics"""
        stats = {
            'accounts': 0,
            'scripts': 0,
            'autoevony_files': 0,
            'client_files': 0,
            'sol_files': 0,
            'tools': 0,
        }
        
        # Count accounts
        accounts_file = PATHS['sol_analysis'] / 'accounts_extracted.json'
        if accounts_file.exists():
            try:
                with open(accounts_file, 'r') as f:
                    stats['accounts'] = len(json.load(f))
            except:
                pass
        
        # Count scripts
        if PATHS['scripts'].exists():
            stats['scripts'] = len(list(PATHS['scripts'].glob('*.txt')))
        
        # Count source files
        if PATHS['autoevony_src'].exists():
            stats['autoevony_files'] = len(list(PATHS['autoevony_src'].rglob('*.as')))
        
        if PATHS['client_src'].exists():
            stats['client_files'] = len(list(PATHS['client_src'].rglob('*.as')))
        
        # Count SOL files
        if PATHS['sol_accounts'].exists():
            stats['sol_files'] = len(list(PATHS['sol_accounts'].rglob('*.sol')))
        
        return stats


# =============================================================================
# EXPLOIT GENERATORS
# =============================================================================

class ExploitGenerator:
    """Generate exploit scripts"""
    
    @staticmethod
    def overflow_chain(troop_types=None):
        """Generate overflow chain script"""
        if troop_types is None:
            troop_types = [6, 7, 8, 10]  # archer, cav, cata, ballista
        
        lines = [
            "// EVONY MASTER SUITE - Overflow Chain",
            f"// Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
            "// Troop overflow exploit for resource gain",
            "",
            "setsilence off",
            "echo ========================================",
            "echo OVERFLOW CHAIN - MULTI-TROOP",
            "echo ========================================",
            "",
        ]
        
        for i, tid in enumerate(troop_types, 1):
            data = TROOP_DATA.get(tid)
            if data:
                lines.extend([
                    f"// Phase {i}: {data['name']} overflow",
                    f"echo [{i}/{len(troop_types)}] {data['name']} overflow...",
                    f"train {data['abbrev']}:{data['overflow_threshold']}",
                    "sleep 500",
                    "cleartroopqueues",
                    "sleep 500",
                    "",
                ])
        
        lines.extend([
            "echo ========================================",
            "echo OVERFLOW CHAIN COMPLETE",
            f"echo Expected gain: ~{len(troop_types) * 2.1:.1f} billion food",
            "echo ========================================",
        ])
        
        return '\n'.join(lines)
    
    @staticmethod
    def race_blitz(item_id='player.item.speed.1hr', count=50):
        """Generate race condition blitz script"""
        lines = [
            "// EVONY MASTER SUITE - Race Condition Blitz",
            f"// Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
            f"// {count} rapid item uses to exploit race condition",
            "",
            "setsilence off",
            "echo ========================================",
            f"echo RACE CONDITION BLITZ - {count} USES",
            "echo ========================================",
            "",
            f"set item {item_id}",
            "",
            "// BLITZ - no delays",
        ]
        
        for _ in range(count):
            lines.append("useitem $item")
        
        lines.extend([
            "",
            "echo ========================================",
            f"echo {count} USES FIRED",
            "echo Check if exploit succeeded",
            "echo ========================================",
        ])
        
        return '\n'.join(lines)
    
    @staticmethod
    def valley_hide(coords='500,500'):
        """Generate valley hide script"""
        return f"""// EVONY MASTER SUITE - Valley Troop Hide
// Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
// Hide troops in valleys to avoid food consumption

setsilence off
echo ========================================
echo VALLEY TROOP HIDING
echo ========================================

// Reinforce valley with all troops
reinforce {coords} any all none

echo ========================================
echo Troops sent to valley {coords}
echo Food consumption should drop
echo ========================================
"""
    
    @staticmethod
    def full_automation():
        """Generate full automation loop"""
        return """// EVONY MASTER SUITE - Full Automation
// Generated: """ + datetime.now().strftime('%Y-%m-%d %H:%M:%S') + """
// Complete automation loop

setsilence off
echo ========================================
echo FULL AUTOMATION CYCLE
echo Press STOP to end
echo ========================================

label mainloop

// Resource generation via overflow
train a:6135037
sleep 500
cleartroopqueues
sleep 500

// Tax collection
settaxrate 100
levy tax
comfort disaster

// Colony farming
colony levyfood all
colony levytax all
colony levyarmy all

// Quest completion
completequests all

// NPC farming (if configured)
// npcattack 5 any a:50000

echo Cycle complete - waiting 5 minutes...
sleep 300000

goto mainloop
"""
    
    @staticmethod
    def security_bypass():
        """Generate security code enumeration script"""
        codes = ['0000', '1111', '1234', '4321', '9999', '0123', '1212', '2580', '6969', '1313']
        lines = [
            "// EVONY MASTER SUITE - Security Code Enumeration",
            f"// Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
            "// Try common security codes",
            "",
            "setsilence off",
            "echo ========================================",
            "echo SECURITY CODE ENUMERATION",
            "echo ========================================",
            "",
        ]
        
        for code in codes:
            lines.append(f"authsecurity {code}")
            lines.append("sleep 100")
        
        lines.extend([
            "",
            "echo ========================================",
            "echo Enumeration complete",
            "echo ========================================",
        ])
        
        return '\n'.join(lines)


# =============================================================================
# HTML GENERATOR
# =============================================================================

class HTMLGenerator:
    """Generate HTML pages for the web interface"""
    
    @staticmethod
    def get_main_page():
        """Generate the main dashboard page"""
        stats = DataLoader.get_stats()
        
        return f'''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Evony Master Suite</title>
    <style>
        * {{ margin: 0; padding: 0; box-sizing: border-box; }}
        
        body {{
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0a0a0f 0%, #1a1a2e 50%, #0a0a0f 100%);
            color: #e0e0e0;
            min-height: 100vh;
        }}
        
        .header {{
            background: linear-gradient(90deg, #1a1a2e, #2d1f3d, #1a1a2e);
            padding: 15px 30px;
            border-bottom: 2px solid #00ff88;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }}
        
        .header h1 {{
            color: #00ff88;
            font-size: 1.8em;
            text-shadow: 0 0 20px rgba(0, 255, 136, 0.5);
        }}
        
        .header .subtitle {{
            color: #888;
            font-size: 0.9em;
        }}
        
        .nav {{
            display: flex;
            gap: 10px;
        }}
        
        .nav a {{
            color: #00ccff;
            text-decoration: none;
            padding: 8px 15px;
            border: 1px solid #00ccff;
            border-radius: 5px;
            transition: all 0.3s;
        }}
        
        .nav a:hover {{
            background: #00ccff;
            color: #000;
        }}
        
        .nav a.active {{
            background: #00ff88;
            border-color: #00ff88;
            color: #000;
        }}
        
        .container {{
            padding: 20px;
            max-width: 1800px;
            margin: 0 auto;
        }}
        
        .stats-grid {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }}
        
        .stat-card {{
            background: rgba(30, 30, 50, 0.8);
            border: 1px solid #333;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s;
        }}
        
        .stat-card:hover {{
            border-color: #00ff88;
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 255, 136, 0.2);
        }}
        
        .stat-card .number {{
            font-size: 2.5em;
            color: #00ff88;
            font-weight: bold;
        }}
        
        .stat-card .label {{
            color: #888;
            margin-top: 5px;
        }}
        
        .section {{
            background: rgba(30, 30, 50, 0.8);
            border: 1px solid #333;
            border-radius: 10px;
            margin-bottom: 20px;
            overflow: hidden;
        }}
        
        .section-header {{
            background: rgba(0, 0, 0, 0.3);
            padding: 15px 20px;
            border-bottom: 1px solid #333;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }}
        
        .section-header h2 {{
            color: #00ccff;
            font-size: 1.2em;
        }}
        
        .section-body {{
            padding: 20px;
        }}
        
        .grid-3 {{
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }}
        
        @media (max-width: 1200px) {{
            .grid-3 {{ grid-template-columns: repeat(2, 1fr); }}
        }}
        
        @media (max-width: 800px) {{
            .grid-3 {{ grid-template-columns: 1fr; }}
        }}
        
        .exploit-card {{
            background: rgba(40, 40, 60, 0.8);
            border: 1px solid #444;
            border-radius: 8px;
            padding: 15px;
            transition: all 0.3s;
        }}
        
        .exploit-card:hover {{
            border-color: #ff4444;
            box-shadow: 0 5px 20px rgba(255, 68, 68, 0.2);
        }}
        
        .exploit-card h3 {{
            color: #ff4444;
            margin-bottom: 10px;
        }}
        
        .exploit-card .severity {{
            display: inline-block;
            padding: 3px 10px;
            border-radius: 15px;
            font-size: 0.8em;
            margin-bottom: 10px;
        }}
        
        .severity.critical {{ background: #ff0000; color: white; }}
        .severity.high {{ background: #ff6600; color: white; }}
        .severity.medium {{ background: #ffcc00; color: black; }}
        .severity.low {{ background: #00cc00; color: white; }}
        
        .exploit-card p {{
            color: #aaa;
            font-size: 0.9em;
            margin-bottom: 10px;
        }}
        
        .exploit-card code {{
            background: rgba(0, 0, 0, 0.3);
            padding: 5px 10px;
            border-radius: 5px;
            display: block;
            font-family: 'Consolas', monospace;
            color: #00ff88;
            font-size: 0.85em;
        }}
        
        .btn {{
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }}
        
        .btn-primary {{
            background: #00ff88;
            color: #000;
        }}
        
        .btn-primary:hover {{
            background: #00cc66;
            transform: scale(1.05);
        }}
        
        .btn-danger {{
            background: #ff4444;
            color: white;
        }}
        
        .btn-danger:hover {{
            background: #cc0000;
        }}
        
        .key-table {{
            width: 100%;
            border-collapse: collapse;
        }}
        
        .key-table th, .key-table td {{
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #333;
        }}
        
        .key-table th {{
            background: rgba(0, 0, 0, 0.3);
            color: #00ccff;
        }}
        
        .key-table td:last-child {{
            font-family: 'Consolas', monospace;
            color: #00ff88;
            word-break: break-all;
        }}
        
        .quick-actions {{
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }}
        
        .quick-actions .btn {{
            flex: 1;
            min-width: 150px;
            text-align: center;
        }}
        
        .troop-table {{
            width: 100%;
            border-collapse: collapse;
            font-size: 0.9em;
        }}
        
        .troop-table th, .troop-table td {{
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #333;
        }}
        
        .troop-table th {{
            background: rgba(0, 0, 0, 0.3);
            color: #00ccff;
        }}
        
        .troop-table .highlight {{
            color: #00ff88;
            font-weight: bold;
        }}
    </style>
</head>
<body>
    <div class="header">
        <div>
            <h1>🔥 EVONY MASTER SUITE</h1>
            <div class="subtitle">Ultimate Integrated Hacking Framework • 120,470 Files</div>
        </div>
        <nav class="nav">
            <a href="/" class="active">Dashboard</a>
            <a href="/accounts">Accounts</a>
            <a href="/scripts">Scripts</a>
            <a href="/exploits">Exploits</a>
            <a href="/protocol">Protocol</a>
            <a href="/source">Source</a>
            <a href="/tools">Tools</a>
        </nav>
    </div>
    
    <div class="container">
        <div class="stats-grid">
            <div class="stat-card">
                <div class="number">{stats.get('accounts', 0)}</div>
                <div class="label">Accounts</div>
            </div>
            <div class="stat-card">
                <div class="number">{stats.get('scripts', 0)}</div>
                <div class="label">Scripts</div>
            </div>
            <div class="stat-card">
                <div class="number">{stats.get('autoevony_files', 0)}</div>
                <div class="label">Bot Source Files</div>
            </div>
            <div class="stat-card">
                <div class="number">{stats.get('client_files', 0)}</div>
                <div class="label">Client Source Files</div>
            </div>
            <div class="stat-card">
                <div class="number">{TOTAL_COMMANDS}</div>
                <div class="label">Protocol Commands</div>
            </div>
            <div class="stat-card">
                <div class="number">{len(EXPLOITS)}</div>
                <div class="label">Documented Exploits</div>
            </div>
        </div>
        
        <div class="section">
            <div class="section-header">
                <h2>⚡ Quick Actions</h2>
            </div>
            <div class="section-body">
                <div class="quick-actions">
                    <a href="/generate/overflow_chain" class="btn btn-danger">Generate Overflow Chain</a>
                    <a href="/generate/race_blitz" class="btn btn-danger">Generate Race Blitz</a>
                    <a href="/generate/valley_hide" class="btn btn-primary">Generate Valley Hide</a>
                    <a href="/generate/full_auto" class="btn btn-primary">Generate Full Auto</a>
                    <a href="/generate/security_bypass" class="btn btn-primary">Security Bypass</a>
                </div>
            </div>
        </div>
        
        <div class="section">
            <div class="section-header">
                <h2>🔑 Encryption Keys</h2>
            </div>
            <div class="section-body">
                <table class="key-table">
                    <thead>
                        <tr><th>Key Name</th><th>Value</th></tr>
                    </thead>
                    <tbody>
                        {"".join(f'<tr><td>{k}</td><td>{v}</td></tr>' for k, v in KEYS.items())}
                    </tbody>
                </table>
            </div>
        </div>
        
        <div class="section">
            <div class="section-header">
                <h2>📊 Troop Overflow Thresholds</h2>
            </div>
            <div class="section-body">
                <table class="troop-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Troop</th>
                            <th>Abbrev</th>
                            <th>Food Cost</th>
                            <th>Overflow Threshold</th>
                            <th>Expected Gain</th>
                            <th>Script</th>
                        </tr>
                    </thead>
                    <tbody>
                        {"".join(f'''
                        <tr>
                            <td>{tid}</td>
                            <td>{d['name']}</td>
                            <td>{d['abbrev']}</td>
                            <td>{d['food']}</td>
                            <td class="highlight">{d['overflow_threshold']:,}</td>
                            <td>~{d['expected_gain']/1_000_000_000:.2f}B</td>
                            <td><code>train {d['abbrev']}:{d['overflow_threshold']}</code></td>
                        </tr>
                        ''' for tid, d in TROOP_DATA.items())}
                    </tbody>
                </table>
            </div>
        </div>
        
        <div class="section">
            <div class="section-header">
                <h2>💀 Exploit Gallery</h2>
            </div>
            <div class="section-body">
                <div class="grid-3">
                    {"".join(f'''
                    <div class="exploit-card">
                        <h3>{exp['name']}</h3>
                        <span class="severity {exp['severity'].lower()}">{exp['severity']}</span>
                        <p>{exp['description']}</p>
                        <code>{exp.get('example', 'N/A')}</code>
                    </div>
                    ''' for exp in EXPLOITS.values())}
                </div>
            </div>
        </div>
        
        <div class="section">
            <div class="section-header">
                <h2>⚠️ Safety Limits</h2>
            </div>
            <div class="section-body">
                <table class="key-table">
                    <thead>
                        <tr><th>Limit</th><th>Safe Value</th><th>Warning</th></tr>
                    </thead>
                    <tbody>
                        <tr><td>Max Safe Food</td><td class="highlight">485,000,000</td><td>Flips to 0 at 999M!</td></tr>
                        <tr><td>Max Single Troop Type</td><td class="highlight">700,000,000</td><td>Overflow danger</td></tr>
                        <tr><td>Valley Transport</td><td class="highlight">495,000,000</td><td>Server limit</td></tr>
                        <tr><td>Food Flip Danger</td><td style="color:#ff4444;">999,000,000+</td><td>WILL RESET TO 0!</td></tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <script>
        // Auto-refresh stats every 30 seconds
        // setInterval(() => location.reload(), 30000);
    </script>
</body>
</html>'''


    @staticmethod
    def get_accounts_page():
        """Generate accounts page"""
        accounts = DataLoader.load_accounts()
        
        rows = ""
        for i, acc in enumerate(accounts[:100], 1):  # Limit to first 100
            email = acc.get('email', 'N/A')
            password = acc.get('password', 'N/A')
            server = acc.get('server', 'N/A')
            proxy = acc.get('proxy', 'N/A')
            rows += f'''
            <tr>
                <td>{i}</td>
                <td>{email}</td>
                <td><span class="password">{password}</span></td>
                <td>{server}</td>
                <td>{proxy}</td>
            </tr>'''
        
        return f'''<!DOCTYPE html>
<html><head>
    <meta charset="UTF-8">
    <title>Accounts - Evony Master Suite</title>
    <style>
        * {{ margin: 0; padding: 0; box-sizing: border-box; }}
        body {{ font-family: 'Segoe UI', sans-serif; background: #0a0a0f; color: #e0e0e0; }}
        .header {{ background: #1a1a2e; padding: 15px 30px; border-bottom: 2px solid #00ff88; }}
        .header h1 {{ color: #00ff88; }}
        .nav {{ margin-top: 10px; }}
        .nav a {{ color: #00ccff; text-decoration: none; margin-right: 15px; }}
        .container {{ padding: 20px; max-width: 1600px; margin: 0 auto; }}
        table {{ width: 100%; border-collapse: collapse; background: rgba(30,30,50,0.8); }}
        th, td {{ padding: 12px; text-align: left; border-bottom: 1px solid #333; }}
        th {{ background: rgba(0,0,0,0.3); color: #00ccff; position: sticky; top: 0; }}
        .password {{ filter: blur(4px); transition: filter 0.3s; cursor: pointer; }}
        .password:hover {{ filter: none; }}
        .count {{ color: #00ff88; font-size: 1.2em; margin-bottom: 20px; }}
    </style>
</head><body>
    <div class="header">
        <h1>👤 Account Manager</h1>
        <nav class="nav">
            <a href="/">Dashboard</a>
            <a href="/accounts">Accounts</a>
            <a href="/scripts">Scripts</a>
            <a href="/exploits">Exploits</a>
            <a href="/protocol">Protocol</a>
        </nav>
    </div>
    <div class="container">
        <div class="count">Total Accounts: {len(accounts)}</div>
        <table>
            <thead><tr><th>#</th><th>Email</th><th>Password (hover)</th><th>Server</th><th>Proxy</th></tr></thead>
            <tbody>{rows}</tbody>
        </table>
    </div>
</body></html>'''

    @staticmethod
    def get_scripts_page():
        """Generate scripts page"""
        scripts = DataLoader.load_scripts()
        
        cards = ""
        for script in scripts[:50]:
            preview = script['preview'][:200].replace('<', '&lt;').replace('\n', '<br>')
            cards += f'''
            <div class="script-card">
                <h3>{script['name']}</h3>
                <div class="preview">{preview}...</div>
                <a href="/script/{script['name']}" class="btn">View Full</a>
            </div>'''
        
        return f'''<!DOCTYPE html>
<html><head>
    <meta charset="UTF-8">
    <title>Scripts - Evony Master Suite</title>
    <style>
        * {{ margin: 0; padding: 0; box-sizing: border-box; }}
        body {{ font-family: 'Segoe UI', sans-serif; background: #0a0a0f; color: #e0e0e0; }}
        .header {{ background: #1a1a2e; padding: 15px 30px; border-bottom: 2px solid #00ff88; }}
        .header h1 {{ color: #00ff88; }}
        .nav {{ margin-top: 10px; }}
        .nav a {{ color: #00ccff; text-decoration: none; margin-right: 15px; }}
        .container {{ padding: 20px; }}
        .grid {{ display: grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap: 20px; }}
        .script-card {{ background: rgba(30,30,50,0.8); border: 1px solid #333; border-radius: 8px; padding: 15px; }}
        .script-card h3 {{ color: #00ccff; margin-bottom: 10px; }}
        .script-card .preview {{ font-family: monospace; font-size: 0.8em; color: #888; max-height: 150px; overflow: hidden; margin-bottom: 10px; }}
        .btn {{ background: #00ff88; color: #000; padding: 5px 15px; border-radius: 5px; text-decoration: none; }}
        .count {{ color: #00ff88; font-size: 1.2em; margin-bottom: 20px; }}
    </style>
</head><body>
    <div class="header">
        <h1>📜 Script Library</h1>
        <nav class="nav">
            <a href="/">Dashboard</a>
            <a href="/accounts">Accounts</a>
            <a href="/scripts">Scripts</a>
            <a href="/exploits">Exploits</a>
            <a href="/protocol">Protocol</a>
        </nav>
    </div>
    <div class="container">
        <div class="count">Total Scripts: {len(scripts)}</div>
        <div class="grid">{cards}</div>
    </div>
</body></html>'''

    @staticmethod
    def get_protocol_page():
        """Generate protocol commands page"""
        categories_html = ""
        for cat, cmds in PROTOCOL_COMMANDS.items():
            cmds_html = "".join(f"<li>{cmd}</li>" for cmd in cmds)
            categories_html += f'''
            <div class="cat-card">
                <h3>{cat} ({len(cmds)})</h3>
                <ul>{cmds_html}</ul>
            </div>'''
        
        return f'''<!DOCTYPE html>
<html><head>
    <meta charset="UTF-8">
    <title>Protocol - Evony Master Suite</title>
    <style>
        * {{ margin: 0; padding: 0; box-sizing: border-box; }}
        body {{ font-family: 'Segoe UI', sans-serif; background: #0a0a0f; color: #e0e0e0; }}
        .header {{ background: #1a1a2e; padding: 15px 30px; border-bottom: 2px solid #00ff88; }}
        .header h1 {{ color: #00ff88; }}
        .nav {{ margin-top: 10px; }}
        .nav a {{ color: #00ccff; text-decoration: none; margin-right: 15px; }}
        .container {{ padding: 20px; }}
        .grid {{ display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }}
        .cat-card {{ background: rgba(30,30,50,0.8); border: 1px solid #333; border-radius: 8px; padding: 15px; }}
        .cat-card h3 {{ color: #00ccff; margin-bottom: 10px; }}
        .cat-card ul {{ list-style: none; }}
        .cat-card li {{ font-family: monospace; font-size: 0.85em; color: #00ff88; padding: 3px 0; }}
        .count {{ color: #00ff88; font-size: 1.2em; margin-bottom: 20px; }}
    </style>
</head><body>
    <div class="header">
        <h1>📡 Protocol Commands ({TOTAL_COMMANDS}+)</h1>
        <nav class="nav">
            <a href="/">Dashboard</a>
            <a href="/accounts">Accounts</a>
            <a href="/scripts">Scripts</a>
            <a href="/exploits">Exploits</a>
            <a href="/protocol">Protocol</a>
        </nav>
    </div>
    <div class="container">
        <div class="count">Total Commands: {TOTAL_COMMANDS}+ across {len(PROTOCOL_COMMANDS)} categories</div>
        <div class="grid">{categories_html}</div>
    </div>
</body></html>'''


# =============================================================================
# HTTP HANDLER
# =============================================================================

class MasterHandler(BaseHTTPRequestHandler):
    """HTTP request handler for the Master Suite"""
    
    def log_message(self, format, *args):
        timestamp = datetime.now().strftime("%H:%M:%S")
        print(f"[{timestamp}] {args[0]}")
    
    def send_html(self, content, status=200):
        self.send_response(status)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(content.encode("utf-8"))
    
    def send_text(self, content, status=200):
        self.send_response(status)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(content.encode("utf-8"))
    
    def send_json(self, data, status=200):
        self.send_response(status)
        self.send_header("Content-Type", "application/json")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(json.dumps(data, indent=2).encode("utf-8"))
    
    def do_GET(self):
        parsed = urlparse(self.path)
        path = parsed.path.strip("/").lower()
        params = {k: v[0] for k, v in parse_qs(parsed.query).items()}
        
        try:
            # Main pages
            if path == "" or path == "index" or path == "dashboard":
                self.send_html(HTMLGenerator.get_main_page())
            
            elif path == "accounts":
                self.send_html(HTMLGenerator.get_accounts_page())
            
            elif path == "scripts":
                self.send_html(HTMLGenerator.get_scripts_page())
            
            elif path == "protocol":
                self.send_html(HTMLGenerator.get_protocol_page())
            
            # Script generators
            elif path.startswith("generate/"):
                gen_type = path[9:]
                
                if gen_type == "overflow_chain":
                    script = ExploitGenerator.overflow_chain()
                    self.send_text(script)
                
                elif gen_type == "race_blitz":
                    item = params.get('item', 'player.item.speed.1hr')
                    count = int(params.get('count', 50))
                    script = ExploitGenerator.race_blitz(item, count)
                    self.send_text(script)
                
                elif gen_type == "valley_hide":
                    coords = params.get('coords', '500,500')
                    script = ExploitGenerator.valley_hide(coords)
                    self.send_text(script)
                
                elif gen_type == "full_auto":
                    script = ExploitGenerator.full_automation()
                    self.send_text(script)
                
                elif gen_type == "security_bypass":
                    script = ExploitGenerator.security_bypass()
                    self.send_text(script)
                
                else:
                    self.send_text(f"// Unknown generator: {gen_type}")
            
            # Script viewer
            elif path.startswith("script/"):
                script_name = unquote(path[7:])
                script_path = PATHS['scripts'] / script_name
                if script_path.exists():
                    content = script_path.read_text(encoding='utf-8', errors='ignore')
                    self.send_text(content)
                else:
                    self.send_text(f"// Script not found: {script_name}", 404)
            
            # API endpoints
            elif path == "api/stats":
                self.send_json(DataLoader.get_stats())
            
            elif path == "api/accounts":
                self.send_json(DataLoader.load_accounts())
            
            elif path == "api/scripts":
                self.send_json(DataLoader.load_scripts())
            
            elif path == "api/keys":
                self.send_json(KEYS)
            
            elif path == "api/exploits":
                self.send_json(EXPLOITS)
            
            elif path == "api/troops":
                self.send_json(TROOP_DATA)
            
            elif path == "api/commands":
                self.send_json(PROTOCOL_COMMANDS)
            
            elif path == "api/search":
                query = params.get('q', '')
                directory = params.get('dir', 'autoevony_src')
                results = DataLoader.search_source(query, directory)
                self.send_json(results)
            
            # Health check
            elif path == "health":
                self.send_json({"status": "ok", "timestamp": datetime.now().isoformat()})
            
            else:
                self.send_html("<h1>404 - Not Found</h1>", 404)
        
        except Exception as e:
            self.send_html(f"<h1>Error</h1><pre>{str(e)}</pre>", 500)


# =============================================================================
# MAIN
# =============================================================================

def run_server():
    """Start the Master Suite server"""
    print("=" * 70)
    print("  EVONY MASTER SUITE - Ultimate Integrated Framework")
    print("=" * 70)
    print(f"\n  Server: http://{HOST}:{PORT}")
    print(f"  Dashboard: http://localhost:{PORT}/")
    print(f"  Accounts: http://localhost:{PORT}/accounts")
    print(f"  Scripts: http://localhost:{PORT}/scripts")
    print(f"  Protocol: http://localhost:{PORT}/protocol")
    print("\n  Exploit Generators:")
    print(f"    http://localhost:{PORT}/generate/overflow_chain")
    print(f"    http://localhost:{PORT}/generate/race_blitz")
    print(f"    http://localhost:{PORT}/generate/valley_hide")
    print(f"    http://localhost:{PORT}/generate/full_auto")
    print("\n  API Endpoints:")
    print(f"    http://localhost:{PORT}/api/stats")
    print(f"    http://localhost:{PORT}/api/accounts")
    print(f"    http://localhost:{PORT}/api/scripts")
    print(f"    http://localhost:{PORT}/api/keys")
    print(f"    http://localhost:{PORT}/api/exploits")
    print(f"    http://localhost:{PORT}/api/commands")
    print(f"    http://localhost:{PORT}/api/search?q=QUERY")
    print("\n" + "-" * 70)
    print("  Press Ctrl+C to stop")
    print("-" * 70 + "\n")
    
    # Show stats
    stats = DataLoader.get_stats()
    print(f"  Loaded: {stats.get('accounts', 0)} accounts, {stats.get('scripts', 0)} scripts")
    print(f"  Source: {stats.get('autoevony_files', 0)} bot files, {stats.get('client_files', 0)} client files")
    print()
    
    # Try to open browser
    try:
        webbrowser.open(f"http://localhost:{PORT}")
    except:
        pass
    
    server = HTTPServer((HOST, PORT), MasterHandler)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nServer stopped.")
        server.shutdown()


if __name__ == "__main__":
    run_server()
