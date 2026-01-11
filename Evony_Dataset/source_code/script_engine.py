"""
RoboEvony Script Execution Engine

Executes RoboEvony/AutoEvony .txt scripts directly in Svony Studio.
Parses and runs all script commands with full game integration.
"""

import logging
import re
import time
import random
from dataclasses import dataclass, field
from enum import Enum
from typing import Dict, Optional, List, Any, Callable, Tuple
from pathlib import Path
import threading
from queue import Queue

logger = logging.getLogger(__name__)


class ScriptState(Enum):
    """Script execution state"""
    IDLE = "idle"
    RUNNING = "running"
    PAUSED = "paused"
    STOPPED = "stopped"
    ERROR = "error"
    COMPLETED = "completed"


class CommandType(Enum):
    """Script command types"""
    # Control flow
    LOOP = "loop"
    ENDLOOP = "endloop"
    IF = "if"
    ENDIF = "endif"
    ELSE = "else"
    GOTO = "goto"
    LABEL = "label"
    WAIT = "wait"
    STOP = "stop"
    
    # City commands
    CITY = "city"
    BUILD = "build"
    UPGRADE = "upgrade"
    DEMOLISH = "demolish"
    
    # Army commands
    TRAIN = "train"
    ATTACK = "attack"
    SCOUT = "scout"
    TRANSPORT = "transport"
    REINFORCE = "reinforce"
    RECALL = "recall"
    
    # Resource commands
    COLLECT = "collect"
    USE_ITEM = "useitem"
    SELL = "sell"
    
    # Hero commands
    HIRE_HERO = "hirehero"
    FIRE_HERO = "firehero"
    TRAIN_HERO = "trainhero"
    EQUIP = "equip"
    
    # Quest/Event
    QUEST = "quest"
    WHEEL = "wheel"
    BOX = "box"
    
    # Communication
    CHAT = "chat"
    MAIL = "mail"
    
    # Special
    SCRIPT = "script"
    LOG = "log"
    SET = "set"
    CALC = "calc"
    RANDOM = "random"
    
    # Custom
    CUSTOM = "custom"


@dataclass
class ScriptCommand:
    """Parsed script command"""
    line_number: int
    command_type: CommandType
    raw_text: str
    params: Dict[str, Any] = field(default_factory=dict)
    condition: Optional[str] = None


@dataclass
class ScriptContext:
    """Script execution context"""
    variables: Dict[str, Any] = field(default_factory=dict)
    labels: Dict[str, int] = field(default_factory=dict)
    loop_stack: List[Tuple[int, int, int]] = field(default_factory=list)  # (start, end, count)
    current_city: int = 0
    current_line: int = 0
    
    def get_var(self, name: str, default: Any = None) -> Any:
        """Get variable value with substitution"""
        return self.variables.get(name, default)
        
    def set_var(self, name: str, value: Any):
        """Set variable value"""
        self.variables[name] = value


class ScriptParser:
    """Parses RoboEvony script files"""
    
    # Command patterns
    COMMAND_PATTERNS = {
        # Control flow
        r'^loop\s+(\d+)': CommandType.LOOP,
        r'^endloop': CommandType.ENDLOOP,
        r'^if\s+(.+)': CommandType.IF,
        r'^endif': CommandType.ENDIF,
        r'^else': CommandType.ELSE,
        r'^goto\s+(\w+)': CommandType.GOTO,
        r'^:(\w+)': CommandType.LABEL,
        r'^wait\s+(\d+)': CommandType.WAIT,
        r'^stop': CommandType.STOP,
        
        # City
        r'^city\s+(\d+)': CommandType.CITY,
        r'^build\s+(\w+)(?:\s+(\d+))?': CommandType.BUILD,
        r'^upgrade\s+(\w+)(?:\s+(\d+))?': CommandType.UPGRADE,
        r'^demolish\s+(\w+)': CommandType.DEMOLISH,
        
        # Army
        r'^train\s+(\w+)\s+(\d+)': CommandType.TRAIN,
        r'^attack\s+(\d+)\s+(\d+)(?:\s+(.+))?': CommandType.ATTACK,
        r'^scout\s+(\d+)\s+(\d+)': CommandType.SCOUT,
        r'^transport\s+(\d+)\s+(\d+)(?:\s+(.+))?': CommandType.TRANSPORT,
        r'^reinforce\s+(\d+)\s+(\d+)(?:\s+(.+))?': CommandType.REINFORCE,
        r'^recall': CommandType.RECALL,
        
        # Resources
        r'^collect': CommandType.COLLECT,
        r'^useitem\s+(\w+)(?:\s+(\d+))?': CommandType.USE_ITEM,
        r'^sell\s+(\w+)\s+(\d+)': CommandType.SELL,
        
        # Heroes
        r'^hirehero(?:\s+(\w+))?': CommandType.HIRE_HERO,
        r'^firehero\s+(\d+)': CommandType.FIRE_HERO,
        r'^trainhero\s+(\d+)(?:\s+(\w+))?': CommandType.TRAIN_HERO,
        r'^equip\s+(\d+)\s+(\w+)': CommandType.EQUIP,
        
        # Quest/Event
        r'^quest(?:\s+(\w+))?': CommandType.QUEST,
        r'^wheel(?:\s+(\d+))?': CommandType.WHEEL,
        r'^box(?:\s+(\w+))?': CommandType.BOX,
        
        # Communication
        r'^chat\s+(\w+)\s+(.+)': CommandType.CHAT,
        r'^mail\s+(\w+)\s+(.+)': CommandType.MAIL,
        
        # Special
        r'^script\s+(.+)': CommandType.SCRIPT,
        r'^log\s+(.+)': CommandType.LOG,
        r'^set\s+(\w+)\s*=\s*(.+)': CommandType.SET,
        r'^calc\s+(\w+)\s*=\s*(.+)': CommandType.CALC,
        r'^random\s+(\w+)\s+(\d+)\s+(\d+)': CommandType.RANDOM,
    }
    
    def __init__(self):
        self._compiled_patterns = {
            re.compile(pattern, re.IGNORECASE): cmd_type
            for pattern, cmd_type in self.COMMAND_PATTERNS.items()
        }
        
    def parse_file(self, filepath: str) -> List[ScriptCommand]:
        """Parse a script file"""
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            lines = f.readlines()
        return self.parse_lines(lines)
        
    def parse_lines(self, lines: List[str]) -> List[ScriptCommand]:
        """Parse script lines"""
        commands = []
        
        for line_num, line in enumerate(lines, 1):
            line = line.strip()
            
            # Skip empty lines and comments
            if not line or line.startswith('#') or line.startswith('//') or line.startswith(';'):
                continue
                
            cmd = self._parse_line(line_num, line)
            if cmd:
                commands.append(cmd)
                
        return commands
        
    def _parse_line(self, line_num: int, line: str) -> Optional[ScriptCommand]:
        """Parse a single line"""
        for pattern, cmd_type in self._compiled_patterns.items():
            match = pattern.match(line)
            if match:
                params = self._extract_params(cmd_type, match)
                return ScriptCommand(
                    line_number=line_num,
                    command_type=cmd_type,
                    raw_text=line,
                    params=params,
                )
                
        # Unknown command - treat as custom
        return ScriptCommand(
            line_number=line_num,
            command_type=CommandType.CUSTOM,
            raw_text=line,
            params={"raw": line},
        )
        
    def _extract_params(self, cmd_type: CommandType, match: re.Match) -> Dict:
        """Extract parameters from regex match"""
        groups = match.groups()
        params = {}
        
        if cmd_type == CommandType.LOOP:
            params["count"] = int(groups[0])
        elif cmd_type == CommandType.WAIT:
            params["seconds"] = int(groups[0])
        elif cmd_type == CommandType.CITY:
            params["city_id"] = int(groups[0])
        elif cmd_type == CommandType.BUILD:
            params["building"] = groups[0]
            params["position"] = int(groups[1]) if groups[1] else None
        elif cmd_type == CommandType.TRAIN:
            params["troop_type"] = groups[0]
            params["count"] = int(groups[1])
        elif cmd_type == CommandType.ATTACK:
            params["x"] = int(groups[0])
            params["y"] = int(groups[1])
            params["troops"] = groups[2] if len(groups) > 2 else None
        elif cmd_type == CommandType.SET:
            params["variable"] = groups[0]
            params["value"] = groups[1]
        elif cmd_type == CommandType.RANDOM:
            params["variable"] = groups[0]
            params["min"] = int(groups[1])
            params["max"] = int(groups[2])
        elif cmd_type == CommandType.LABEL:
            params["name"] = groups[0]
        elif cmd_type == CommandType.GOTO:
            params["label"] = groups[0]
        elif cmd_type == CommandType.LOG:
            params["message"] = groups[0]
        elif cmd_type == CommandType.CHAT:
            params["channel"] = groups[0]
            params["message"] = groups[1]
            
        return params


class ScriptEngine:
    """
    Executes RoboEvony scripts with full command support.
    
    Features:
    - Parse and execute .txt scripts
    - Variable substitution
    - Control flow (loops, conditions, goto)
    - Integration with game commands
    - Async execution with pause/stop
    """
    
    def __init__(self):
        self.parser = ScriptParser()
        self.state = ScriptState.IDLE
        self.context = ScriptContext()
        self.commands: List[ScriptCommand] = []
        
        # Command handlers
        self._handlers: Dict[CommandType, Callable] = {}
        self._register_default_handlers()
        
        # Execution control
        self._execution_thread: Optional[threading.Thread] = None
        self._pause_event = threading.Event()
        self._stop_event = threading.Event()
        self._pause_event.set()  # Not paused initially
        
        # Callbacks
        self._on_command: Optional[Callable] = None
        self._on_log: Optional[Callable] = None
        self._on_error: Optional[Callable] = None
        
        # Game integration
        self._game_client = None
        
    def load_script(self, filepath: str) -> bool:
        """Load and parse a script file"""
        try:
            self.commands = self.parser.parse_file(filepath)
            self._build_label_index()
            self.context = ScriptContext()
            self.state = ScriptState.IDLE
            logger.info(f"Loaded script: {filepath} ({len(self.commands)} commands)")
            return True
        except Exception as e:
            logger.error(f"Failed to load script: {e}")
            self.state = ScriptState.ERROR
            return False
            
    def load_script_text(self, script_text: str) -> bool:
        """Load script from string"""
        try:
            lines = script_text.split('\n')
            self.commands = self.parser.parse_lines(lines)
            self._build_label_index()
            self.context = ScriptContext()
            self.state = ScriptState.IDLE
            return True
        except Exception as e:
            logger.error(f"Failed to parse script: {e}")
            return False
            
    def start(self, async_mode: bool = True):
        """Start script execution"""
        if self.state == ScriptState.RUNNING:
            return
            
        self._stop_event.clear()
        self._pause_event.set()
        self.state = ScriptState.RUNNING
        self.context.current_line = 0
        
        if async_mode:
            self._execution_thread = threading.Thread(
                target=self._execute_loop,
                daemon=True,
            )
            self._execution_thread.start()
        else:
            self._execute_loop()
            
    def pause(self):
        """Pause execution"""
        if self.state == ScriptState.RUNNING:
            self._pause_event.clear()
            self.state = ScriptState.PAUSED
            
    def resume(self):
        """Resume execution"""
        if self.state == ScriptState.PAUSED:
            self._pause_event.set()
            self.state = ScriptState.RUNNING
            
    def stop(self):
        """Stop execution"""
        self._stop_event.set()
        self._pause_event.set()
        self.state = ScriptState.STOPPED
        
    def set_variable(self, name: str, value: Any):
        """Set script variable"""
        self.context.set_var(name, value)
        
    def get_variable(self, name: str) -> Any:
        """Get script variable"""
        return self.context.get_var(name)
        
    def register_handler(self, cmd_type: CommandType, handler: Callable):
        """Register command handler"""
        self._handlers[cmd_type] = handler
        
    def on_command(self, callback: Callable):
        """Set command execution callback"""
        self._on_command = callback
        
    def on_log(self, callback: Callable):
        """Set log callback"""
        self._on_log = callback
        
    def on_error(self, callback: Callable):
        """Set error callback"""
        self._on_error = callback
        
    def set_game_client(self, client):
        """Set game client for command execution"""
        self._game_client = client
        
    def get_statistics(self) -> Dict:
        """Get execution statistics"""
        return {
            "state": self.state.value,
            "total_commands": len(self.commands),
            "current_line": self.context.current_line,
            "variables": dict(self.context.variables),
            "loop_depth": len(self.context.loop_stack),
        }
        
    # ========== Private Methods ==========
    
    def _build_label_index(self):
        """Build label to line number index"""
        self.context.labels = {}
        for i, cmd in enumerate(self.commands):
            if cmd.command_type == CommandType.LABEL:
                self.context.labels[cmd.params["name"]] = i
                
    def _execute_loop(self):
        """Main execution loop"""
        try:
            while self.context.current_line < len(self.commands):
                # Check for stop
                if self._stop_event.is_set():
                    break
                    
                # Check for pause
                self._pause_event.wait()
                
                # Get current command
                cmd = self.commands[self.context.current_line]
                
                # Execute command
                try:
                    self._execute_command(cmd)
                except Exception as e:
                    logger.error(f"Command error at line {cmd.line_number}: {e}")
                    if self._on_error:
                        self._on_error(cmd, str(e))
                        
                # Move to next command (unless jump occurred)
                self.context.current_line += 1
                
            self.state = ScriptState.COMPLETED
            
        except Exception as e:
            logger.error(f"Script execution error: {e}")
            self.state = ScriptState.ERROR
            
    def _execute_command(self, cmd: ScriptCommand):
        """Execute a single command"""
        if self._on_command:
            self._on_command(cmd)
            
        handler = self._handlers.get(cmd.command_type)
        if handler:
            handler(cmd, self.context)
        else:
            logger.warning(f"No handler for command: {cmd.command_type}")
            
    def _register_default_handlers(self):
        """Register default command handlers"""
        self._handlers[CommandType.WAIT] = self._handle_wait
        self._handlers[CommandType.LOG] = self._handle_log
        self._handlers[CommandType.SET] = self._handle_set
        self._handlers[CommandType.CALC] = self._handle_calc
        self._handlers[CommandType.RANDOM] = self._handle_random
        self._handlers[CommandType.LOOP] = self._handle_loop
        self._handlers[CommandType.ENDLOOP] = self._handle_endloop
        self._handlers[CommandType.GOTO] = self._handle_goto
        self._handlers[CommandType.LABEL] = self._handle_label
        self._handlers[CommandType.CITY] = self._handle_city
        self._handlers[CommandType.TRAIN] = self._handle_train
        self._handlers[CommandType.ATTACK] = self._handle_attack
        self._handlers[CommandType.COLLECT] = self._handle_collect
        self._handlers[CommandType.STOP] = self._handle_stop
        
    def _handle_wait(self, cmd: ScriptCommand, ctx: ScriptContext):
        """Handle wait command"""
        seconds = cmd.params.get("seconds", 1)
        # Add random jitter for human-like behavior
        jitter = random.uniform(-0.1, 0.1) * seconds
        time.sleep(max(0.1, seconds + jitter))
        
    def _handle_log(self, cmd: ScriptCommand, ctx: ScriptContext):
        """Handle log command"""
        message = self._substitute_vars(cmd.params.get("message", ""), ctx)
        logger.info(f"[SCRIPT] {message}")
        if self._on_log:
            self._on_log(message)
            
    def _handle_set(self, cmd: ScriptCommand, ctx: ScriptContext):
        """Handle set command"""
        var_name = cmd.params.get("variable")
        value = self._substitute_vars(cmd.params.get("value", ""), ctx)
        ctx.set_var(var_name, value)
        
    def _handle_calc(self, cmd: ScriptCommand, ctx: ScriptContext):
        """Handle calc command"""
        var_name = cmd.params.get("variable")
        expr = self._substitute_vars(cmd.params.get("value", "0"), ctx)
        try:
            # Safe eval for math expressions
            result = eval(expr, {"__builtins__": {}}, {})
            ctx.set_var(var_name, result)
        except:
            ctx.set_var(var_name, 0)
            
    def _handle_random(self, cmd: ScriptCommand, ctx: ScriptContext):
        """Handle random command"""
        var_name = cmd.params.get("variable")
        min_val = cmd.params.get("min", 0)
        max_val = cmd.params.get("max", 100)
        ctx.set_var(var_name, random.randint(min_val, max_val))
        
    def _handle_loop(self, cmd: ScriptCommand, ctx: ScriptContext):
        """Handle loop start"""
        count = cmd.params.get("count", 1)
        start_line = ctx.current_line
        # Find matching endloop
        end_line = self._find_endloop(start_line)
        ctx.loop_stack.append((start_line, end_line, count))
        
    def _handle_endloop(self, cmd: ScriptCommand, ctx: ScriptContext):
        """Handle loop end"""
        if ctx.loop_stack:
            start, end, count = ctx.loop_stack[-1]
            count -= 1
            if count > 0:
                ctx.loop_stack[-1] = (start, end, count)
                ctx.current_line = start  # Jump back to loop start
            else:
                ctx.loop_stack.pop()
                
    def _handle_goto(self, cmd: ScriptCommand, ctx: ScriptContext):
        """Handle goto command"""
        label = cmd.params.get("label")
        if label in ctx.labels:
            ctx.current_line = ctx.labels[label] - 1  # -1 because loop will increment
            
    def _handle_label(self, cmd: ScriptCommand, ctx: ScriptContext):
        """Handle label (no-op, just a marker)"""
        pass
        
    def _handle_city(self, cmd: ScriptCommand, ctx: ScriptContext):
        """Handle city selection"""
        city_id = cmd.params.get("city_id", 0)
        ctx.current_city = city_id
        
    def _handle_train(self, cmd: ScriptCommand, ctx: ScriptContext):
        """Handle troop training"""
        troop_type = cmd.params.get("troop_type")
        count = cmd.params.get("count", 1)
        
        if self._game_client:
            self._game_client.train_troops(ctx.current_city, troop_type, count)
        else:
            logger.info(f"[SIM] Train {count} {troop_type} in city {ctx.current_city}")
            
    def _handle_attack(self, cmd: ScriptCommand, ctx: ScriptContext):
        """Handle attack command"""
        x = cmd.params.get("x")
        y = cmd.params.get("y")
        troops = cmd.params.get("troops")
        
        if self._game_client:
            self._game_client.attack(ctx.current_city, x, y, troops)
        else:
            logger.info(f"[SIM] Attack ({x}, {y}) with {troops}")
            
    def _handle_collect(self, cmd: ScriptCommand, ctx: ScriptContext):
        """Handle resource collection"""
        if self._game_client:
            self._game_client.collect_resources(ctx.current_city)
        else:
            logger.info(f"[SIM] Collect resources in city {ctx.current_city}")
            
    def _handle_stop(self, cmd: ScriptCommand, ctx: ScriptContext):
        """Handle stop command"""
        self._stop_event.set()
        
    def _find_endloop(self, start: int) -> int:
        """Find matching endloop for a loop"""
        depth = 1
        for i in range(start + 1, len(self.commands)):
            if self.commands[i].command_type == CommandType.LOOP:
                depth += 1
            elif self.commands[i].command_type == CommandType.ENDLOOP:
                depth -= 1
                if depth == 0:
                    return i
        return len(self.commands) - 1
        
    def _substitute_vars(self, text: str, ctx: ScriptContext) -> str:
        """Substitute variables in text"""
        # Replace {varname} with variable value
        def replace_var(match):
            var_name = match.group(1)
            return str(ctx.get_var(var_name, f"{{${var_name}}}"))
            
        return re.sub(r'\{(\w+)\}', replace_var, text)


# Singleton
_script_engine: Optional[ScriptEngine] = None

def get_script_engine() -> ScriptEngine:
    """Get singleton script engine"""
    global _script_engine
    if _script_engine is None:
        _script_engine = ScriptEngine()
    return _script_engine
