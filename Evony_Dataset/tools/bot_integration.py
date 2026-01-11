# BORG TOOLKIT - AutoEvony Bot Integration
"""
Integration module for hooking into AutoEvony bot's existing connection.

Instead of creating our own connection, we:
1. Generate scripts that AutoEvony can execute
2. Use the bot's ActionFactory and Connection
3. Inject exploit commands through the scripting system

AutoEvony Script Commands (from CityState.as):
- train [troop] - Train troops
- useitem [itemId] - Use item
- attack [coords] [hero] [troop] - Attack target
- transport [coords] [troop] [resource] - Send resources
- recall [coords] - Recall army
- etc.

The bot handles all handshaking, authentication, and packet formatting.
We just provide the commands.
"""

import json
import time
from pathlib import Path
from typing import Dict, List, Any, Optional
from dataclasses import dataclass, field
from datetime import datetime

# Path to AutoEvony scripts folder (configurable)
AUTOEVONY_SCRIPTS_PATH = Path(r"C:\AutoEvony\scripts")
BORG_SCRIPTS_PATH = Path(__file__).parent.parent / "scripts"


@dataclass
class BotScript:
    """Generated script for AutoEvony"""
    name: str
    description: str
    commands: List[str] = field(default_factory=list)
    variables: Dict[str, Any] = field(default_factory=dict)
    
    def add_command(self, cmd: str):
        """Add command to script"""
        self.commands.append(cmd)
    
    def add_comment(self, comment: str):
        """Add comment"""
        self.commands.append(f"// {comment}")
    
    def add_label(self, label: str):
        """Add label for goto/loops"""
        self.commands.append(f"label {label}")
    
    def add_goto(self, label: str):
        """Add goto command"""
        self.commands.append(f"goto {label}")
    
    def add_sleep(self, seconds: float):
        """Add sleep command"""
        self.commands.append(f"sleep {int(seconds * 1000)}")
    
    def add_if(self, condition: str, then_cmd: str):
        """Add conditional command"""
        self.commands.append(f"if {condition} {then_cmd}")
    
    def set_variable(self, name: str, value: Any):
        """Set script variable"""
        self.variables[name] = value
        if isinstance(value, str):
            self.commands.append(f'set {name} "{value}"')
        else:
            self.commands.append(f"set {name} {value}")
    
    def to_script(self) -> str:
        """Convert to AutoEvony script format"""
        lines = [
            f"// BORG TOOLKIT - {self.name}",
            f"// {self.description}",
            f"// Generated: {datetime.now().isoformat()}",
            "",
        ]
        lines.extend(self.commands)
        return "\n".join(lines)
    
    def save(self, path: Path = None) -> Path:
        """Save script to file"""
        if path is None:
            path = BORG_SCRIPTS_PATH / f"{self.name.lower().replace(' ', '_')}.txt"
        
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(self.to_script())
        return path


class ExploitScriptGenerator:
    """
    Generate AutoEvony scripts for exploits.
    
    These scripts run through the bot's connection, so:
    - No need for our own authentication
    - Packets are properly formatted
    - Server responses handled automatically
    """
    
    def __init__(self):
        self.scripts: List[BotScript] = []
    
    # =========================================================================
    # TROOP EXPLOIT SCRIPTS
    # =========================================================================
    
    def troop_overflow_script(self, troop_type: str = "archer",
                               overflow_num: int = 6135037) -> BotScript:
        """
        Generate troop overflow exploit script.
        
        Uses the 'train' command to queue overflow troops,
        then cancels to get resource gain.
        
        Note: AutoEvony's train command has built-in limits.
        For true overflow, we need raw ActionFactory access.
        """
        script = BotScript(
            name="Troop Overflow Exploit",
            description=f"Queue {overflow_num:,} {troop_type}s then cancel for resource gain"
        )
        
        script.add_comment("TROOP OVERFLOW EXPLOIT")
        script.add_comment(f"This attempts to queue {overflow_num:,} troops")
        script.add_comment("Cancel production to trigger negative refund")
        script.add_comment("")
        
        # Set variables
        script.set_variable("overflowNum", overflow_num)
        script.set_variable("troopType", troop_type)
        
        # Build troop string for AutoEvony format
        # Format: "archer:6135037" or "a:6135037"
        troop_abbrev = {
            'worker': 'wo', 'warrior': 'wa', 'scout': 'sc', 'pikeman': 'pi',
            'swordsman': 'sw', 'archer': 'a', 'cavalry': 'ca', 'cataphract': 'ct',
            'transporter': 'tr', 'ballista': 'ba', 'ram': 'r', 'catapult': 'c'
        }
        abbrev = troop_abbrev.get(troop_type, troop_type[0])
        
        script.add_comment("Queue troops (may fail if bot has limits)")
        script.add_command(f"train {abbrev}:{overflow_num}")
        
        script.add_comment("Wait for server to process")
        script.add_sleep(1.0)
        
        script.add_comment("Cancel all troop queues")
        script.add_command("cleartroopqueues")
        
        script.add_comment("Check result")
        script.add_command("echo Food glitch attempt complete - check resources")
        
        self.scripts.append(script)
        return script
    
    def valley_hide_script(self, valley_coords: str = "500,500",
                           hero: str = "any") -> BotScript:
        """
        Generate valley hiding script to avoid food consumption.
        
        Sends all troops to a distant valley where they don't consume food.
        """
        script = BotScript(
            name="Valley Troop Hide",
            description=f"Hide troops in valley {valley_coords} to avoid food consumption"
        )
        
        script.add_comment("VALLEY TROOP HIDING - Stop Food Consumption")
        script.add_comment(f"Target: {valley_coords}")
        script.add_comment("")
        
        # Get all available troops and send them
        script.add_comment("Send all troops to valley")
        script.add_command(f"reinforce {valley_coords} {hero} all none")
        
        script.add_comment("Troops now don't consume food!")
        script.add_command(f"echo Troops sent to {valley_coords} - no more food consumption")
        
        self.scripts.append(script)
        return script
    
    # =========================================================================
    # ITEM EXPLOIT SCRIPTS  
    # =========================================================================
    
    def item_dupe_script(self, item_id: str,
                          rapid_count: int = 10) -> BotScript:
        """
        Generate item duplication script via rapid use.
        
        Sends multiple 'useitem' commands as fast as possible
        to trigger race condition.
        """
        script = BotScript(
            name="Item Duplication",
            description=f"Rapid use {item_id} x{rapid_count} for race condition"
        )
        
        script.add_comment("ITEM DUPLICATION via Race Condition")
        script.add_comment(f"Item: {item_id}")
        script.add_comment(f"Rapid uses: {rapid_count}")
        script.add_comment("")
        
        # Create loop to rapidly use item
        script.add_command(f"set itemId {item_id}")
        script.add_command(f"set count {rapid_count}")
        script.add_command("set i 0")
        
        script.add_label("useloop")
        script.add_command(f"useitem {item_id}")
        # Minimal delay
        script.add_sleep(0.01)
        script.add_command("set i i+1")
        script.add_if("i < count", "goto useloop")
        
        script.add_command("echo Item dupe attempt complete")
        
        self.scripts.append(script)
        return script
    
    def chest_open_script(self, chest_type: str = "gold",
                           count: int = 10) -> BotScript:
        """
        Generate chest opening script.
        """
        chest_ids = {
            'bronze': 'player.box.1',
            'silver': 'player.box.2', 
            'gold': 'player.box.3',
        }
        item_id = chest_ids.get(chest_type, chest_type)
        
        script = BotScript(
            name="Chest Opening",
            description=f"Open {count} {chest_type} chests"
        )
        
        script.add_comment(f"Open {count} {chest_type} chests")
        
        for i in range(count):
            script.add_command(f"useitem {item_id}")
            script.add_sleep(0.5)
        
        self.scripts.append(script)
        return script
    
    # =========================================================================
    # RESOURCE SCRIPTS
    # =========================================================================
    
    def gold_farm_script(self) -> BotScript:
        """
        Generate gold farming script.
        Tax collection + pacify loop.
        """
        script = BotScript(
            name="Gold Farm",
            description="Automated gold farming via tax collection"
        )
        
        script.add_comment("GOLD FARMING LOOP")
        script.add_comment("Sets 100% tax, collects, pacifies, repeats")
        script.add_comment("")
        
        script.add_label("goldloop")
        
        # Set high tax
        script.add_command("settaxrate 100")
        script.add_sleep(0.5)
        
        # Levy (collect tax)
        script.add_command("levy tax")
        script.add_sleep(0.5)
        
        # Pacify to restore loyalty
        script.add_command("comfort disaster")
        script.add_sleep(300)  # Wait 5 minutes
        
        script.add_command("goto goldloop")
        
        self.scripts.append(script)
        return script
    
    def colony_farm_script(self, colony_coords: str) -> BotScript:
        """
        Generate colony farming script.
        Rapid levy from colonies.
        """
        script = BotScript(
            name="Colony Farm",
            description=f"Farm resources from colony at {colony_coords}"
        )
        
        script.add_comment("COLONY FARMING")
        script.add_label("colonyloop")
        
        # Levy all resources from colony
        script.add_command(f"colony levyfood {colony_coords}")
        script.add_sleep(0.5)
        script.add_command(f"colony levytax {colony_coords}")
        script.add_sleep(0.5)
        script.add_command(f"colony levyarmy {colony_coords}")
        script.add_sleep(300)
        
        script.add_command("goto colonyloop")
        
        self.scripts.append(script)
        return script
    
    # =========================================================================
    # AUTOMATION SCRIPTS
    # =========================================================================
    
    def auto_quest_script(self) -> BotScript:
        """
        Generate auto quest completion script.
        """
        script = BotScript(
            name="Auto Quest",
            description="Automatically complete all available quests"
        )
        
        script.add_comment("AUTO QUEST COMPLETION")
        script.add_command("completequests all")
        
        self.scripts.append(script)
        return script
    
    def auto_build_script(self, building: str, target_level: int = 10) -> BotScript:
        """
        Generate auto building script.
        """
        script = BotScript(
            name=f"Auto Build {building}",
            description=f"Upgrade {building} to level {target_level}"
        )
        
        script.add_comment(f"AUTO BUILD {building.upper()} TO LEVEL {target_level}")
        
        for level in range(1, target_level + 1):
            script.add_command(f"upgrade {building}")
            script.add_command("waitnobuilding")
        
        script.add_command(f"echo {building} upgraded to level {target_level}")
        
        self.scripts.append(script)
        return script


class RawCommandInjector:
    """
    For when we need to bypass AutoEvony's command system
    and inject raw ActionFactory commands.
    
    This requires modifying AutoEvony or using a proxy.
    """
    
    # Raw commands that map directly to ActionFactory
    RAW_COMMANDS = {
        # Troop commands
        'produceTroop': 'ActionFactory.getInstance().getTroopCommands().produceTroop',
        'cancelTroopProduce': 'ActionFactory.getInstance().getTroopCommands().cancelTroopProduce',
        'disbandTroop': 'ActionFactory.getInstance().getTroopCommands().disbandTroop',
        
        # Shop commands
        'useGoods': 'ActionFactory.getInstance().getShopCommands().useGoods',
        'buy': 'ActionFactory.getInstance().getShopCommands().buy',
        'sellItem': 'ActionFactory.getInstance().getShopCommands().sellItem',
        
        # Quest commands
        'award': 'ActionFactory.getInstance().getQuestCommands().award',
        
        # Army commands
        'newArmy': 'ActionFactory.getInstance().getArmyCommands().newArmy',
        'callBackArmy': 'ActionFactory.getInstance().getArmyCommands().callBackArmy',
    }
    
    @staticmethod
    def generate_as3_injection(command: str, params: Dict) -> str:
        """
        Generate AS3 code to inject into bot.
        
        This would need to be executed through AutoEvony's
        scripting system or a modified client.
        """
        if command not in RawCommandInjector.RAW_COMMANDS:
            return f"// Unknown command: {command}"
        
        action_call = RawCommandInjector.RAW_COMMANDS[command]
        param_str = ", ".join(str(v) for v in params.values())
        
        return f"{action_call}({param_str});"
    
    @staticmethod
    def generate_overflow_injection(castle_id: int, position_id: int,
                                     troop_type: int, num: int) -> str:
        """
        Generate AS3 injection for troop overflow.
        
        This bypasses AutoEvony's input validation.
        """
        return f"""
// BORG TOOLKIT - Troop Overflow Injection
// Injects directly into ActionFactory to bypass limits
ActionFactory.getInstance().getTroopCommands().produceTroop(
    {castle_id},   // castleId
    {position_id}, // positionId
    {troop_type},  // troopType (6=archer)
    {num},         // num (OVERFLOW VALUE)
    false,         // isShare
    true           // toIdle
);
"""


class BotConnectionHook:
    """
    Hook into existing bot connection.
    
    Methods:
    1. File-based: Drop command files that bot picks up
    2. IPC: Inter-process communication with bot
    3. Proxy: MITM the bot's connection
    """
    
    def __init__(self, method: str = "file"):
        self.method = method
        self.command_queue: List[Dict] = []
    
    def queue_command(self, command: str, params: Dict):
        """Queue command for injection"""
        self.command_queue.append({
            'timestamp': datetime.now().isoformat(),
            'command': command,
            'params': params,
        })
    
    def write_command_file(self, filepath: Path = None) -> Path:
        """
        Write commands to file for bot to pick up.
        
        Bot can be configured to watch a folder and execute
        any scripts that appear.
        """
        if filepath is None:
            filepath = BORG_SCRIPTS_PATH / "inject_commands.json"
        
        filepath.parent.mkdir(parents=True, exist_ok=True)
        filepath.write_text(json.dumps(self.command_queue, indent=2))
        
        self.command_queue.clear()
        return filepath
    
    def generate_trigger_script(self) -> BotScript:
        """
        Generate a script that triggers command injection.
        
        This script reads from inject_commands.json and executes.
        """
        script = BotScript(
            name="Command Injector",
            description="Reads and executes injected commands"
        )
        
        script.add_comment("BORG TOOLKIT - Command Injection Trigger")
        script.add_comment("Place this script in AutoEvony and run it")
        script.add_comment("It will execute commands from inject_commands.json")
        script.add_comment("")
        
        # AutoEvony can download and execute snippets
        script.add_command("snippet file:///C:/BorgToolkit/scripts/inject_commands.json")
        
        return script


def generate_all_exploit_scripts():
    """Generate all exploit scripts"""
    gen = ExploitScriptGenerator()
    
    scripts = [
        gen.troop_overflow_script('archer', 6135037),
        gen.valley_hide_script('500,500', 'any'),
        gen.item_dupe_script('player.item.speed.1hr', 10),
        gen.gold_farm_script(),
        gen.auto_quest_script(),
    ]
    
    output_dir = BORG_SCRIPTS_PATH
    output_dir.mkdir(parents=True, exist_ok=True)
    
    print("=" * 60)
    print("BORG TOOLKIT - Bot Integration Scripts")
    print("=" * 60)
    
    for script in scripts:
        path = script.save()
        print(f"\n[+] {script.name}")
        print(f"    Saved to: {path}")
        print(f"    Commands: {len(script.commands)}")
    
    print(f"\n[*] {len(scripts)} scripts generated in {output_dir}")
    print("\nTo use:")
    print("  1. Copy scripts to AutoEvony scripts folder")
    print("  2. Load script in bot")
    print("  3. Run script")
    
    return scripts


if __name__ == "__main__":
    generate_all_exploit_scripts()
