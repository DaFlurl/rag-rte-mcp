"""
Enhanced Food Glitch Analyzer v2.0
Based on Ogliss's FoodGlitchCounterV1.2 script

Features:
- Verbose mode (on/off) showing step-by-step calculations
- ASCII progress bars for glitch progress
- Rich colorful HTML output (like original script)
- Clear screen then display final output
- Per-city and account-wide analysis
- Recommendations for achieving food generation

Usage:
  python food_glitch_analyzer.py [dump_file.json] [--verbose] [--mode full|lite] [--html]
"""

import json
import sys
import os
from pathlib import Path
from datetime import datetime
from dataclasses import dataclass
from typing import Dict, List, Optional, Tuple
from enum import Enum

# ═══════════════════════════════════════════════════════════════════════════════
# CONSTANTS (from FoodGlitchCounterV1.2 and Svony_Studio)
# ═══════════════════════════════════════════════════════════════════════════════

INT32_MAX = 2_147_483_647  # 32-bit signed integer max (glitch trigger base)
SAFE_TROOP_LIMIT = 700_000_000  # Safe max per type to avoid 3x flip

# Food consumption per troop per hour
FOOD_PER_TROOP = {
    'peasants': 1,       # Workers
    'militia': 1,        # Warriors  
    'scouter': 2,        # Scouts
    'pikemen': 3,        # Pikemen
    'swordsmen': 3,      # Swordsmen
    'archer': 4,         # Archers
    'lightCavalry': 9,   # Cavalry
    'heavyCavalry': 17,  # Cataphracts
    'carriage': 5,       # Transporters
    'ballista': 25,      # Ballista
    'batteringRam': 50,  # Battering Rams
    'catapult': 125,     # Catapults
}

TROOP_DISPLAY_NAMES = {
    'peasants': 'Workers',
    'militia': 'Warriors',
    'scouter': 'Scouts',
    'pikemen': 'Pikemen',
    'swordsmen': 'Swordsmen',
    'archer': 'Archers',
    'lightCavalry': 'Cavalry',
    'heavyCavalry': 'Cataphracts',
    'carriage': 'Transporters',
    'ballista': 'Ballista',
    'batteringRam': 'Battering Rams',
    'catapult': 'Catapults',
}

TROOP_ABBR = {
    'peasants': 'wo',
    'militia': 'w',
    'scouter': 's',
    'pikemen': 'p',
    'swordsmen': 'sw',
    'archer': 'a',
    'lightCavalry': 'c',
    'heavyCavalry': 'cata',
    'carriage': 't',
    'ballista': 'b',
    'batteringRam': 'r',
    'catapult': 'cp',
}

TROOP_ORDER = ['peasants', 'militia', 'scouter', 'pikemen', 'swordsmen', 'archer',
               'lightCavalry', 'heavyCavalry', 'carriage', 'ballista', 'batteringRam', 'catapult']

# HTML Colors (matching original script)
COLOR_PURPLE = '#CC2EFA'
COLOR_RED = '#FF0000'
COLOR_GREEN = '#008000'
COLOR_BLACK = '#000000'
COLOR_BLUE = '#0000FF'
COLOR_ORANGE = '#FFA500'
COLOR_GOLD = '#FFD700'
COLOR_CYAN = '#00FFFF'

# ═══════════════════════════════════════════════════════════════════════════════
# DATA CLASSES
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class TroopGlitchInfo:
    """Glitch information for a single troop type"""
    troop_type: str
    display_name: str
    city_count: int
    valley_count: int
    food_cost: int
    city_threshold: int      # Troops needed for 1 city glitch
    valley_threshold: int    # Troops needed for 1 valley glitch
    city_glitches: int
    valley_glitches: int
    city_progress: float     # 0-100%
    valley_progress: float   # 0-100%
    city_remaining: int      # Troops toward next city glitch
    valley_remaining: int    # Troops toward next valley glitch
    troops_needed: int       # Troops needed for next glitch
    is_generating: bool      # Odd glitches = food generation
    food_consumed: int       # Food consumed per hour by this type
    
    @property
    def total_glitches(self) -> int:
        return self.city_glitches + self.valley_glitches
    
    @property
    def total_troops(self) -> int:
        return self.city_count + self.valley_count


@dataclass 
class CityGlitchReport:
    """Complete glitch report for a city"""
    city_id: int
    city_name: str
    troops: Dict[str, TroopGlitchInfo]
    total_glitches: int
    generating_types: int
    not_generating_types: int
    not_glitching_types: int
    food_generated: int      # Total food generated from glitches
    food_consumed: int       # Total food consumed by troops
    net_food: int            # Generated - Consumed


# ═══════════════════════════════════════════════════════════════════════════════
# GLITCH CALCULATOR
# ═══════════════════════════════════════════════════════════════════════════════

class FoodGlitchAnalyzer:
    """
    Analyzes food glitch state for Evony cities.
    
    Glitch Mechanics:
    - 32-bit integer overflow at 2,147,483,647
    - City glitch threshold: INT_MAX / food_cost + 1
    - Valley glitch threshold: (INT_MAX / food_cost) / 2 + 1
    - Odd number of glitches = FOOD GENERATION (INT_MAX per hour)
    - Even number = food consumed normally
    """
    
    def __init__(self, verbose: bool = False, mode: str = 'full'):
        self.verbose = verbose
        self.mode = mode.lower()  # 'full' or 'lite'
        self._city_thresholds: Dict[str, int] = {}
        self._valley_thresholds: Dict[str, int] = {}
        self._calculate_thresholds()
        
    def _log(self, msg: str):
        """Print verbose log"""
        if self.verbose:
            print(f"  [VERBOSE] {msg}")
            
    def _calculate_thresholds(self):
        """Pre-calculate glitch thresholds for each troop type"""
        self._log("Calculating glitch thresholds...")
        for troop_type, food_cost in FOOD_PER_TROOP.items():
            # City glitch: INT_MAX / food_cost + 1
            self._city_thresholds[troop_type] = (INT32_MAX // food_cost) + 1
            # Valley glitch: half of city threshold
            self._valley_thresholds[troop_type] = ((INT32_MAX // food_cost) // 2) + 1
            self._log(f"  {TROOP_DISPLAY_NAMES[troop_type]}: City={self._city_thresholds[troop_type]:,}, Valley={self._valley_thresholds[troop_type]:,}")
            
    def analyze_troop_type(self, troop_type: str, city_count: int, valley_count: int = 0) -> TroopGlitchInfo:
        """Analyze glitch state for a single troop type"""
        food_cost = FOOD_PER_TROOP.get(troop_type, 1)
        city_threshold = self._city_thresholds[troop_type]
        valley_threshold = self._valley_thresholds[troop_type]
        
        self._log(f"Analyzing {TROOP_DISPLAY_NAMES[troop_type]}...")
        self._log(f"  City count: {city_count:,}, Valley count: {valley_count:,}")
        
        # Count city glitches
        city_glitches = 0
        remaining_city = city_count
        while remaining_city >= city_threshold:
            city_glitches += 1
            remaining_city -= city_threshold
        
        self._log(f"  City glitches: {city_glitches}, Remaining: {remaining_city:,}")
        
        # Count valley glitches
        valley_glitches = 0
        remaining_valley = valley_count
        while remaining_valley >= valley_threshold:
            valley_glitches += 1
            remaining_valley -= valley_threshold
            
        self._log(f"  Valley glitches: {valley_glitches}, Remaining: {remaining_valley:,}")
        
        total_glitches = city_glitches + valley_glitches
        
        # Odd glitches = food generation!
        is_generating = total_glitches > 0 and (total_glitches % 2 == 1)
        self._log(f"  Total glitches: {total_glitches}, Generating: {is_generating}")
        
        # Progress percentages
        city_progress = (remaining_city / city_threshold * 100) if city_threshold > 0 else 0
        valley_progress = (remaining_valley / valley_threshold * 100) if valley_threshold > 0 else 0
        
        # Troops needed for next city glitch
        troops_needed = city_threshold - remaining_city
        
        # Food consumed by this troop type
        total_troops = city_count + valley_count
        food_consumed = total_troops * food_cost
        
        return TroopGlitchInfo(
            troop_type=troop_type,
            display_name=TROOP_DISPLAY_NAMES.get(troop_type, troop_type),
            city_count=city_count,
            valley_count=valley_count,
            food_cost=food_cost,
            city_threshold=city_threshold,
            valley_threshold=valley_threshold,
            city_glitches=city_glitches,
            valley_glitches=valley_glitches,
            city_progress=city_progress,
            valley_progress=valley_progress,
            city_remaining=remaining_city,
            valley_remaining=remaining_valley,
            troops_needed=troops_needed,
            is_generating=is_generating,
            food_consumed=food_consumed,
        )
        
    def analyze_city(self, city_data: dict, city_id: int = 0, city_name: str = "Unknown") -> CityGlitchReport:
        """Analyze complete glitch state for a city"""
        self._log(f"\n{'='*60}")
        self._log(f"Analyzing city: {city_name} (ID: {city_id})")
        self._log(f"{'='*60}")
        
        troops_info = {}
        total_glitches = 0
        generating_types = 0
        not_generating_types = 0
        not_glitching_types = 0
        total_food_consumed = 0
        
        troop_data = city_data.get('troop', {})
        # Valley troops would come from reinforcements/valleys - for now just city troops
        valley_data = {}  
        
        for troop_type in TROOP_ORDER:
            city_count = int(troop_data.get(troop_type, 0) or 0)
            valley_count = int(valley_data.get(troop_type, 0) or 0)
            
            if city_count > 0 or valley_count > 0 or self.mode == 'full':
                info = self.analyze_troop_type(troop_type, city_count, valley_count)
                troops_info[troop_type] = info
                
                total_glitches += info.total_glitches
                total_food_consumed += info.food_consumed
                
                if info.is_generating:
                    generating_types += 1
                elif info.total_glitches > 0:
                    not_generating_types += 1
                else:
                    not_glitching_types += 1
        
        # Food generated = INT_MAX per generating troop type
        food_generated = generating_types * INT32_MAX
        net_food = food_generated - total_food_consumed
        
        self._log(f"\nCity Summary:")
        self._log(f"  Total glitches: {total_glitches}")
        self._log(f"  Generating types: {generating_types}")
        self._log(f"  Food generated: {food_generated:,}")
        self._log(f"  Food consumed: {total_food_consumed:,}")
        self._log(f"  Net food: {net_food:,}")
        
        return CityGlitchReport(
            city_id=city_id,
            city_name=city_name,
            troops=troops_info,
            total_glitches=total_glitches,
            generating_types=generating_types,
            not_generating_types=not_generating_types,
            not_glitching_types=not_glitching_types,
            food_generated=food_generated,
            food_consumed=total_food_consumed,
            net_food=net_food,
        )


# ═══════════════════════════════════════════════════════════════════════════════
# OUTPUT FORMATTERS
# ═══════════════════════════════════════════════════════════════════════════════

def fmt(n) -> str:
    """Format number with commas"""
    try:
        return f"{float(n):,.0f}"
    except:
        return str(n)

def progress_bar(percent: float, width: int = 20, filled: str = '█', empty: str = '░') -> str:
    """Create ASCII progress bar"""
    percent = max(0, min(100, percent))
    filled_width = int(width * percent / 100)
    return f"{filled * filled_width}{empty * (width - filled_width)} {percent:.1f}%"

def color_progress_bar(percent: float, width: int = 20) -> str:
    """Create colored ASCII progress bar"""
    percent = max(0, min(100, percent))
    filled_width = int(width * percent / 100)
    
    # Color based on progress
    if percent >= 75:
        color = '\033[92m'  # Green
    elif percent >= 50:
        color = '\033[93m'  # Yellow
    elif percent >= 25:
        color = '\033[91m'  # Red
    else:
        color = '\033[90m'  # Gray
    
    reset = '\033[0m'
    bar = '█' * filled_width + '░' * (width - filled_width)
    return f"{color}{bar}{reset} {percent:.1f}%"


def generate_console_output(report: CityGlitchReport, mode: str = 'full') -> str:
    """Generate colorful console output"""
    lines = []
    
    # Header
    lines.append("")
    lines.append("\033[95m" + "═" * 70 + "\033[0m")
    lines.append(f"\033[95m  FOOD GLITCH ANALYSIS - {report.city_name}\033[0m")
    lines.append("\033[95m" + "═" * 70 + "\033[0m")
    
    # Per-troop analysis
    for troop_type in TROOP_ORDER:
        if troop_type not in report.troops:
            continue
            
        info = report.troops[troop_type]
        
        # Skip troops with no glitches in lite mode
        if mode == 'lite' and info.total_glitches == 0:
            continue
        
        lines.append("")
        lines.append(f"\033[95m  ▸ {info.display_name}\033[0m")
        
        if mode == 'full':
            lines.append(f"    City Troops:   {fmt(info.city_count):>20}")
            lines.append(f"    Valley Troops: {fmt(info.valley_count):>20}")
            
        # Glitch counts
        if info.valley_glitches > 0 or (mode == 'full' and info.valley_count > 0):
            lines.append(f"    Valley Glitches: \033[95m{info.valley_glitches}\033[0m")
            if mode == 'full' and info.valley_glitches == 0:
                lines.append(f"      Progress: {color_progress_bar(info.valley_progress)}")
                lines.append(f"      Details:  {fmt(info.valley_remaining)} / {fmt(info.valley_threshold)} (need {fmt(info.valley_threshold - info.valley_remaining)})")
        
        if info.city_glitches > 0 or mode == 'full':
            lines.append(f"    City Glitches:   \033[95m{info.city_glitches}\033[0m")
            if mode == 'full':
                lines.append(f"      Progress: {color_progress_bar(info.city_progress)}")
                lines.append(f"      Details:  {fmt(info.city_remaining)} / {fmt(info.city_threshold)} (need {fmt(info.troops_needed)})")
        
        # Food generation status
        if info.total_glitches > 0:
            if info.is_generating:
                lines.append(f"    \033[92m✓ GENERATING FOOD! ({info.total_glitches} glitches = ODD)\033[0m")
            else:
                lines.append(f"    \033[91m✗ NOT generating (glitches={info.total_glitches} = EVEN)\033[0m")
                lines.append(f"    \033[93m  ↳ Add 1 more glitch to start generating!\033[0m")
    
    # Summary
    lines.append("")
    lines.append("\033[95m" + "─" * 70 + "\033[0m")
    lines.append(f"\033[95m  CITY SUMMARY\033[0m")
    lines.append("\033[95m" + "─" * 70 + "\033[0m")
    
    lines.append(f"  Total Glitches:       \033[95m{report.total_glitches}\033[0m")
    lines.append(f"  Generating Types:     \033[92m{report.generating_types}\033[0m / \033[91m{report.not_generating_types}\033[0m / \033[95m{report.generating_types + report.not_generating_types}\033[0m / {report.not_glitching_types}")
    lines.append(f"                        (generating / not generating / glitching / no glitches)")
    
    if report.generating_types > 0:
        lines.append(f"  Food Generated:       \033[92m+{fmt(report.food_generated)}/hr\033[0m")
    
    lines.append(f"  Food Consumed:        \033[91m-{fmt(report.food_consumed)}/hr\033[0m")
    
    if report.net_food >= 0:
        lines.append(f"  Net Food:             \033[92m+{fmt(report.net_food)}/hr\033[0m")
    else:
        lines.append(f"  Net Food:             \033[91m{fmt(report.net_food)}/hr\033[0m")
    
    lines.append("")
    lines.append("\033[95m" + "═" * 70 + "\033[0m")
    
    return "\n".join(lines)


def generate_html_output(report: CityGlitchReport, mode: str = 'full') -> str:
    """Generate HTML output matching original script style"""
    html = []
    
    # Header (matching original script colors)
    html.append(f"<br><font color='{COLOR_PURPLE}'> ----------</font>")
    html.append(f"<font color='{COLOR_RED}'>Food Glitch Information for {report.city_name}</font>")
    html.append(f"<font color='{COLOR_PURPLE}'> ----------</font>")
    
    # Per-troop analysis
    for troop_type in TROOP_ORDER:
        if troop_type not in report.troops:
            continue
            
        info = report.troops[troop_type]
        
        # Skip in lite mode if no glitches
        if mode == 'lite' and info.total_glitches == 0:
            continue
        
        msg = f"<font color='{COLOR_BLACK}'> Type:</font>"
        msg += f"<font color='{COLOR_PURPLE}'><b> {info.display_name}</b></font>"
        
        if mode == 'lite':
            if info.valley_glitches > 0:
                msg += f"    <font color='{COLOR_BLACK}'>Valley Glitches: </font>"
                msg += f"<font color='{COLOR_PURPLE}'><b>{info.valley_glitches}</b></font>"
            if info.city_glitches > 0:
                msg += f"    <font color='{COLOR_BLACK}'>City Glitches: </font>"
                msg += f"<font color='{COLOR_PURPLE}'><b>{info.city_glitches}</b></font>"
        else:  # Full mode
            if info.valley_count > 0:
                msg += f"<br>    <font color='{COLOR_BLACK}'>Valley Glitches: </font>"
                msg += f"<font color='{COLOR_PURPLE}'><b>{info.valley_glitches}</b></font>"
                if info.valley_glitches == 0:
                    msg += f"<br>      <font color='{COLOR_BLACK}'>Valley Glitch Progress: </font>"
                    msg += f"<font color='{COLOR_PURPLE}'><b>{info.valley_progress:.0f} percent</b></font>"
                    msg += f"<br>      <font color='{COLOR_BLACK}'>Valley Glitch Details: </font>"
                    msg += f"<font color='{COLOR_PURPLE}'><b>{fmt(info.valley_remaining)}</b></font>"
                    msg += f"<font color='{COLOR_BLACK}'> / </font>"
                    msg += f"<font color='{COLOR_PURPLE}'><b>{fmt(info.valley_threshold)}</b></font>"
                    msg += f"<font color='{COLOR_BLACK}'> need </font>"
                    msg += f"<font color='{COLOR_PURPLE}'><b>{fmt(info.valley_threshold - info.valley_remaining)}</b></font>"
            
            if info.city_glitches > 0 or info.valley_glitches > 0 or info.city_count > 0:
                msg += f"<br>    <font color='{COLOR_BLACK}'>City Glitches: </font>"
                msg += f"<font color='{COLOR_PURPLE}'><b>{info.city_glitches}</b></font>"
                msg += f"<br>      <font color='{COLOR_BLACK}'>City Glitch Progress: </font>"
                msg += f"<font color='{COLOR_PURPLE}'><b>{info.city_progress:.0f} percent</b></font>"
                msg += f"<br>      <font color='{COLOR_BLACK}'>City Glitch Details:</font> "
                msg += f"<font color='{COLOR_PURPLE}'><b>{fmt(info.city_remaining)}</b></font>"
                msg += f"<font color='{COLOR_BLACK}'> / </font>"
                msg += f"<font color='{COLOR_PURPLE}'><b>{fmt(info.city_threshold)}</b></font>"
                msg += f"<font color='{COLOR_BLACK}'> need </font>"
                msg += f"<font color='{COLOR_PURPLE}'><b>{fmt(info.troops_needed)}</b></font>"
        
        # Food generation status
        if info.total_glitches > 0:
            msg += "<br>"
            if info.is_generating:
                msg += f"  Food Generation: <font color='{COLOR_PURPLE}'><b>True!</b></font> "
                msg += f"<br><font color='{COLOR_GREEN}'><b>This Troop type Should be generating food!</b></font>"
            else:
                msg += f"  Food Generation: <font color='{COLOR_PURPLE}'><b>False!</b></font> "
                msg += f"<br><font color='{COLOR_RED}'><b>You need an odd number of glitches to generate food!</b></font>"
        
        html.append(f"<br> {msg}")
    
    # Summary
    if report.generating_types > 0:
        html.append(f"<br> <font color='{COLOR_PURPLE}'> ----------</font>")
        html.append(f"<font color='{COLOR_BLACK}'>Total Food Glitch results for {report.city_name}</font>")
        html.append(f"<font color='{COLOR_PURPLE}'> ----------</font>")
        
        html.append(f"<br> <font color='{COLOR_BLACK}'>Total troop glitches: </font>")
        html.append(f"<font color='{COLOR_PURPLE}'><b>{report.total_glitches}</b></font>")
        
        html.append(f"<br> <font color='{COLOR_BLACK}'>Total generating troop types: </font>")
        html.append(f"<font color='{COLOR_GREEN}'><b>{report.generating_types}</b></font>/")
        html.append(f"<font color='{COLOR_RED}'><b>{report.not_generating_types}</b></font>/")
        html.append(f"<font color='{COLOR_PURPLE}'><b>{report.generating_types + report.not_generating_types}</b></font>/")
        html.append(f"<font color='{COLOR_BLACK}'><b>{report.not_glitching_types}</b></font>")
        
        html.append(f"<br><font color='{COLOR_BLACK}'> Total Generated: </font>")
        html.append(f"<font color='{COLOR_GREEN}'><b>{fmt(report.food_generated)}</b></font>")
        
        html.append(f"<br><font color='{COLOR_BLACK}'> Being Used: </font>")
        html.append(f"<font color='{COLOR_RED}'><b>{fmt(report.food_consumed)}</b></font>")
        
        net_color = COLOR_GREEN if report.net_food >= 0 else COLOR_RED
        html.append(f"<br><font color='{COLOR_BLACK}'> Net Food: </font>")
        html.append(f"<font color='{net_color}'><b>{fmt(report.net_food)}</b></font>")
    
    return "".join(html)


# ═══════════════════════════════════════════════════════════════════════════════
# MAIN
# ═══════════════════════════════════════════════════════════════════════════════

def clear_screen():
    """Clear console screen"""
    os.system('cls' if os.name == 'nt' else 'clear')

def analyze_dump_file(dump_path: str, verbose: bool = False, mode: str = 'full', 
                      output_html: bool = False, clear_first: bool = True):
    """Analyze a dump file for food glitches"""
    
    if verbose:
        print(f"\n[VERBOSE] Loading dump file: {dump_path}")
    
    with open(dump_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    login_data = data.get('login_data', {})
    player = login_data.get('player', {})
    player_info = player.get('playerInfo', {})
    castles = player.get('castles', [])
    
    if verbose:
        print(f"[VERBOSE] Player: {player_info.get('userName', 'Unknown')}")
        print(f"[VERBOSE] Cities: {len(castles)}")
    
    analyzer = FoodGlitchAnalyzer(verbose=verbose, mode=mode)
    
    all_reports = []
    all_html = []
    
    # Analyze each city
    for castle in castles:
        city_id = castle.get('id', 0)
        city_name = castle.get('name', f'City {city_id}')
        
        report = analyzer.analyze_city(castle, city_id, city_name)
        all_reports.append(report)
        
        if output_html:
            html = generate_html_output(report, mode)
            all_html.append(html)
    
    # Clear screen before final output
    if clear_first and not verbose:
        clear_screen()
    
    # Output results
    print("\n" + "═" * 80)
    print(f"  FOOD GLITCH ANALYZER v2.0 - Enhanced Edition")
    print(f"  Player: {player_info.get('userName', 'Unknown')}")
    print(f"  Analysis Mode: {mode.upper()}")
    print("═" * 80)
    
    for report in all_reports:
        print(generate_console_output(report, mode))
    
    # Account-wide summary
    total_generated = sum(r.food_generated for r in all_reports)
    total_consumed = sum(r.food_consumed for r in all_reports)
    total_net = total_generated - total_consumed
    total_glitches = sum(r.total_glitches for r in all_reports)
    total_generating = sum(r.generating_types for r in all_reports)
    
    print("\n" + "\033[96m" + "═" * 80 + "\033[0m")
    print(f"\033[96m  ACCOUNT-WIDE SUMMARY\033[0m")
    print("\033[96m" + "═" * 80 + "\033[0m")
    print(f"  Total Cities Analyzed:  {len(all_reports)}")
    print(f"  Total Glitches:         \033[95m{total_glitches}\033[0m")
    print(f"  Generating Troop Types: \033[92m{total_generating}\033[0m")
    print(f"  Total Food Generated:   \033[92m+{fmt(total_generated)}/hr\033[0m")
    print(f"  Total Food Consumed:    \033[91m-{fmt(total_consumed)}/hr\033[0m")
    
    if total_net >= 0:
        print(f"  Account Net Food:       \033[92m+{fmt(total_net)}/hr\033[0m")
    else:
        print(f"  Account Net Food:       \033[91m{fmt(total_net)}/hr\033[0m")
    
    print("\033[96m" + "═" * 80 + "\033[0m\n")
    
    # Save HTML if requested
    if output_html and all_html:
        html_path = dump_path.replace('.json', '_glitch_report.html')
        full_html = f"""<!DOCTYPE html>
<html>
<head>
    <title>Food Glitch Report - {player_info.get('userName', 'Unknown')}</title>
    <style>
        body {{ font-family: Arial, sans-serif; background: #1a1a2e; color: #eee; padding: 20px; }}
        .report {{ background: #16213e; padding: 15px; margin: 10px 0; border-radius: 8px; }}
    </style>
</head>
<body>
    <h1>Food Glitch Report</h1>
    <p>Player: {player_info.get('userName', 'Unknown')}</p>
    <p>Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}</p>
    {"".join(f'<div class="report">{h}</div>' for h in all_html)}
</body>
</html>"""
        with open(html_path, 'w', encoding='utf-8') as f:
            f.write(full_html)
        print(f"  HTML report saved to: {html_path}")
    
    return all_reports


def list_dumps(dump_dir: str = "data/dumps") -> List[Path]:
    """List available dump files"""
    dump_path = Path(dump_dir)
    if not dump_path.exists():
        return []
    return sorted(dump_path.glob("*.json"), key=lambda x: x.stat().st_mtime, reverse=True)


if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="Enhanced Food Glitch Analyzer")
    parser.add_argument('dump_file', nargs='?', help='Path to dump JSON file')
    parser.add_argument('--verbose', '-v', action='store_true', help='Enable verbose mode')
    parser.add_argument('--mode', '-m', choices=['full', 'lite'], default='full', help='Analysis mode')
    parser.add_argument('--html', action='store_true', help='Generate HTML report')
    parser.add_argument('--no-clear', action='store_true', help='Do not clear screen before output')
    
    args = parser.parse_args()
    
    if args.dump_file:
        dump_file = args.dump_file
    else:
        # Auto-select latest dump
        dumps = list_dumps()
        if dumps:
            dump_file = str(dumps[0])
            print(f"Auto-selected latest dump: {dump_file}")
        else:
            print("No dump files found. Run extraction first.")
            sys.exit(1)
    
    analyze_dump_file(
        dump_file,
        verbose=args.verbose,
        mode=args.mode,
        output_html=args.html,
        clear_first=not args.no_clear
    )
