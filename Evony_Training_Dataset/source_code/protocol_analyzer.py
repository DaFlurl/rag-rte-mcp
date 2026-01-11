"""
Protocol Analyzer - Map Command Structures and Validation Rules

Analyzes game protocol to discover:
- Command parameters and types
- Response structures
- Validation rules and constraints
- Error codes and messages
"""

import logging
import time
import json
import re
from dataclasses import dataclass, field
from enum import Enum
from typing import Dict, Optional, List, Any, Set, Tuple
from collections import defaultdict
import threading

logger = logging.getLogger(__name__)


class ParameterType(Enum):
    """Parameter data types"""
    INT = "int"
    FLOAT = "float"
    STRING = "string"
    BOOLEAN = "boolean"
    ARRAY = "array"
    OBJECT = "object"
    BYTES = "bytes"
    UNKNOWN = "unknown"


class ValidationRuleType(Enum):
    """Types of validation rules"""
    REQUIRED = "required"
    MIN_VALUE = "min_value"
    MAX_VALUE = "max_value"
    MIN_LENGTH = "min_length"
    MAX_LENGTH = "max_length"
    PATTERN = "pattern"
    ENUM = "enum"
    RANGE = "range"
    RATE_LIMIT = "rate_limit"
    CUSTOM = "custom"


@dataclass
class ParameterDefinition:
    """Definition of a command parameter"""
    name: str
    param_type: ParameterType
    required: bool = True
    default_value: Any = None
    min_value: Optional[float] = None
    max_value: Optional[float] = None
    allowed_values: Optional[List] = None
    description: str = ""
    
    def to_dict(self) -> Dict:
        return {
            "name": self.name,
            "type": self.param_type.value,
            "required": self.required,
            "default": self.default_value,
            "min": self.min_value,
            "max": self.max_value,
            "allowed": self.allowed_values,
            "description": self.description,
        }


@dataclass
class ValidationRule:
    """A validation rule for a command"""
    rule_type: ValidationRuleType
    parameter: str
    value: Any
    error_code: Optional[int] = None
    error_message: str = ""
    
    def to_dict(self) -> Dict:
        return {
            "type": self.rule_type.value,
            "parameter": self.parameter,
            "value": self.value,
            "error_code": self.error_code,
            "error_message": self.error_message,
        }
        
    def validate(self, params: Dict) -> Tuple[bool, str]:
        """Validate parameters against this rule"""
        param_value = params.get(self.parameter)
        
        if self.rule_type == ValidationRuleType.REQUIRED:
            if param_value is None:
                return False, f"Missing required parameter: {self.parameter}"
                
        elif self.rule_type == ValidationRuleType.MIN_VALUE:
            if param_value is not None and param_value < self.value:
                return False, f"{self.parameter} must be >= {self.value}"
                
        elif self.rule_type == ValidationRuleType.MAX_VALUE:
            if param_value is not None and param_value > self.value:
                return False, f"{self.parameter} must be <= {self.value}"
                
        elif self.rule_type == ValidationRuleType.ENUM:
            if param_value is not None and param_value not in self.value:
                return False, f"{self.parameter} must be one of {self.value}"
                
        elif self.rule_type == ValidationRuleType.RANGE:
            if param_value is not None:
                min_val, max_val = self.value
                if not (min_val <= param_value <= max_val):
                    return False, f"{self.parameter} must be in range [{min_val}, {max_val}]"
                    
        return True, ""


@dataclass
class CommandDefinition:
    """Definition of a game command"""
    command_id: int
    command_name: str
    category: str
    direction: str  # "c2s" or "s2c"
    parameters: List[ParameterDefinition] = field(default_factory=list)
    validation_rules: List[ValidationRule] = field(default_factory=list)
    response_command_id: Optional[int] = None
    description: str = ""
    sample_count: int = 0
    last_seen: float = field(default_factory=time.time)
    
    def to_dict(self) -> Dict:
        return {
            "command_id": hex(self.command_id),
            "command_name": self.command_name,
            "category": self.category,
            "direction": self.direction,
            "parameters": [p.to_dict() for p in self.parameters],
            "validation_rules": [r.to_dict() for r in self.validation_rules],
            "response_command_id": hex(self.response_command_id) if self.response_command_id else None,
            "description": self.description,
            "sample_count": self.sample_count,
        }
        
    def validate(self, params: Dict) -> Tuple[bool, List[str]]:
        """Validate parameters against all rules"""
        errors = []
        for rule in self.validation_rules:
            valid, error = rule.validate(params)
            if not valid:
                errors.append(error)
        return len(errors) == 0, errors


@dataclass
class ErrorDefinition:
    """Definition of a server error"""
    error_code: int
    error_name: str
    message: str
    category: str = "general"
    causes: List[str] = field(default_factory=list)
    
    def to_dict(self) -> Dict:
        return {
            "code": self.error_code,
            "name": self.error_name,
            "message": self.message,
            "category": self.category,
            "causes": self.causes,
        }


class ProtocolAnalyzer:
    """
    Analyzes game protocol to discover command structures.
    
    Features:
    - Auto-discover parameters from packet samples
    - Infer validation rules from errors
    - Map request-response pairs
    - Track error codes and causes
    """
    
    # Known validation patterns from error messages
    ERROR_PATTERNS = [
        (r"not enough (\w+)", ValidationRuleType.MIN_VALUE),
        (r"maximum (\w+)", ValidationRuleType.MAX_VALUE),
        (r"invalid (\w+)", ValidationRuleType.ENUM),
        (r"required", ValidationRuleType.REQUIRED),
        (r"rate limit", ValidationRuleType.RATE_LIMIT),
    ]
    
    def __init__(self):
        self._commands: Dict[int, CommandDefinition] = {}
        self._errors: Dict[int, ErrorDefinition] = {}
        self._request_response_map: Dict[int, int] = {}
        self._lock = threading.RLock()
        
        # Sample storage for learning
        self._samples: Dict[int, List[Dict]] = defaultdict(list)
        self._max_samples = 100
        
        # Statistics
        self._stats = defaultdict(int)
        
        # Initialize with known commands
        self._init_known_commands()
        
    def analyze_packet(self, command_id: int, payload: Dict, 
                       direction: str = "c2s") -> Optional[CommandDefinition]:
        """Analyze a packet and update command definition"""
        with self._lock:
            # Get or create command definition
            if command_id not in self._commands:
                self._commands[command_id] = CommandDefinition(
                    command_id=command_id,
                    command_name=f"CMD_{hex(command_id)}",
                    category="unknown",
                    direction=direction,
                )
                
            cmd = self._commands[command_id]
            cmd.sample_count += 1
            cmd.last_seen = time.time()
            
            # Store sample
            if len(self._samples[command_id]) < self._max_samples:
                self._samples[command_id].append(payload)
                
            # Analyze parameters
            self._analyze_parameters(cmd, payload)
            
            self._stats["packets_analyzed"] += 1
            
            return cmd
            
    def analyze_error(self, error_code: int, error_message: str,
                      command_id: Optional[int] = None,
                      params: Optional[Dict] = None) -> Optional[ValidationRule]:
        """Analyze error to discover validation rules"""
        with self._lock:
            # Store error definition
            if error_code not in self._errors:
                self._errors[error_code] = ErrorDefinition(
                    error_code=error_code,
                    error_name=f"ERROR_{error_code}",
                    message=error_message,
                )
                
            # Try to infer validation rule from error message
            rule = self._infer_validation_rule(error_message, params)
            
            if rule and command_id and command_id in self._commands:
                self._commands[command_id].validation_rules.append(rule)
                
            self._stats["errors_analyzed"] += 1
            
            return rule
            
    def map_request_response(self, request_cmd: int, response_cmd: int):
        """Map a request command to its response"""
        with self._lock:
            self._request_response_map[request_cmd] = response_cmd
            
            if request_cmd in self._commands:
                self._commands[request_cmd].response_command_id = response_cmd
                
    def get_command(self, command_id: int) -> Optional[CommandDefinition]:
        """Get command definition"""
        return self._commands.get(command_id)
        
    def get_all_commands(self) -> List[CommandDefinition]:
        """Get all discovered commands"""
        return list(self._commands.values())
        
    def get_commands_by_category(self, category: str) -> List[CommandDefinition]:
        """Get commands by category"""
        return [c for c in self._commands.values() if c.category == category]
        
    def get_error(self, error_code: int) -> Optional[ErrorDefinition]:
        """Get error definition"""
        return self._errors.get(error_code)
        
    def get_all_errors(self) -> List[ErrorDefinition]:
        """Get all discovered errors"""
        return list(self._errors.values())
        
    def validate_command(self, command_id: int, params: Dict) -> Tuple[bool, List[str]]:
        """Validate parameters for a command"""
        cmd = self.get_command(command_id)
        if cmd:
            return cmd.validate(params)
        return True, []
        
    def get_statistics(self) -> Dict:
        """Get analyzer statistics"""
        return {
            "discovered_commands": len(self._commands),
            "discovered_errors": len(self._errors),
            "request_response_pairs": len(self._request_response_map),
            **dict(self._stats),
        }
        
    def export_protocol(self, path: str):
        """Export protocol definitions to JSON"""
        with self._lock:
            data = {
                "commands": {hex(k): v.to_dict() for k, v in self._commands.items()},
                "errors": {str(k): v.to_dict() for k, v in self._errors.items()},
                "request_response_map": {hex(k): hex(v) for k, v in self._request_response_map.items()},
            }
            with open(path, "w") as f:
                json.dump(data, f, indent=2)
                
    def import_protocol(self, path: str):
        """Import protocol definitions from JSON"""
        with open(path, "r") as f:
            data = json.load(f)
            
        # Import commands
        for cmd_id_hex, cmd_data in data.get("commands", {}).items():
            cmd_id = int(cmd_id_hex, 16)
            self._commands[cmd_id] = self._dict_to_command(cmd_id, cmd_data)
            
    # ========== Private Methods ==========
    
    def _init_known_commands(self):
        """Initialize with known command definitions"""
        known_commands = [
            # Login
            CommandDefinition(
                command_id=0x0001,
                command_name="LOGIN_REQUEST",
                category="login",
                direction="c2s",
                parameters=[
                    ParameterDefinition("username", ParameterType.STRING),
                    ParameterDefinition("password_hash", ParameterType.STRING),
                    ParameterDefinition("server_id", ParameterType.INT),
                ],
                description="Login to game server",
            ),
            # Attack
            CommandDefinition(
                command_id=0x0010,
                command_name="ATTACK_SEND",
                category="army",
                direction="c2s",
                parameters=[
                    ParameterDefinition("city_id", ParameterType.INT),
                    ParameterDefinition("target_x", ParameterType.INT, min_value=0, max_value=800),
                    ParameterDefinition("target_y", ParameterType.INT, min_value=0, max_value=800),
                    ParameterDefinition("troops", ParameterType.OBJECT),
                    ParameterDefinition("hero_id", ParameterType.INT, required=False),
                ],
                validation_rules=[
                    ValidationRule(ValidationRuleType.REQUIRED, "city_id", True),
                    ValidationRule(ValidationRuleType.RANGE, "target_x", (0, 800)),
                    ValidationRule(ValidationRuleType.RANGE, "target_y", (0, 800)),
                ],
                response_command_id=0x8010,
                description="Send attack march",
            ),
            # Build
            CommandDefinition(
                command_id=0x0101,
                command_name="CITY_BUILD",
                category="city",
                direction="c2s",
                parameters=[
                    ParameterDefinition("city_id", ParameterType.INT),
                    ParameterDefinition("building_type", ParameterType.INT),
                    ParameterDefinition("slot", ParameterType.INT),
                ],
                response_command_id=0x8101,
                description="Build a building",
            ),
            # Train troops
            CommandDefinition(
                command_id=0x0301,
                command_name="TROOP_TRAIN",
                category="army",
                direction="c2s",
                parameters=[
                    ParameterDefinition("city_id", ParameterType.INT),
                    ParameterDefinition("troop_type", ParameterType.INT),
                    ParameterDefinition("amount", ParameterType.INT, min_value=1),
                ],
                validation_rules=[
                    ValidationRule(ValidationRuleType.MIN_VALUE, "amount", 1),
                ],
                response_command_id=0x8301,
                description="Train troops",
            ),
        ]
        
        for cmd in known_commands:
            self._commands[cmd.command_id] = cmd
            
    def _analyze_parameters(self, cmd: CommandDefinition, payload: Dict):
        """Analyze parameters from payload"""
        existing_params = {p.name for p in cmd.parameters}
        
        for key, value in payload.items():
            if key not in existing_params:
                # Infer parameter type
                param_type = self._infer_type(value)
                
                param = ParameterDefinition(
                    name=key,
                    param_type=param_type,
                    required=True,  # Assume required until we see it missing
                )
                
                # Infer constraints from value
                if param_type == ParameterType.INT:
                    param.min_value = 0  # Assume non-negative
                    
                cmd.parameters.append(param)
                existing_params.add(key)
                
        # Update value ranges based on samples
        for param in cmd.parameters:
            values = [s.get(param.name) for s in self._samples[cmd.command_id] if param.name in s]
            if values and param.param_type == ParameterType.INT:
                int_values = [v for v in values if isinstance(v, int)]
                if int_values:
                    current_min = min(int_values)
                    current_max = max(int_values)
                    if param.min_value is None or current_min < param.min_value:
                        param.min_value = current_min
                    if param.max_value is None or current_max > param.max_value:
                        param.max_value = current_max
                        
    def _infer_type(self, value: Any) -> ParameterType:
        """Infer parameter type from value"""
        if isinstance(value, bool):
            return ParameterType.BOOLEAN
        elif isinstance(value, int):
            return ParameterType.INT
        elif isinstance(value, float):
            return ParameterType.FLOAT
        elif isinstance(value, str):
            return ParameterType.STRING
        elif isinstance(value, list):
            return ParameterType.ARRAY
        elif isinstance(value, dict):
            return ParameterType.OBJECT
        elif isinstance(value, bytes):
            return ParameterType.BYTES
        else:
            return ParameterType.UNKNOWN
            
    def _infer_validation_rule(self, error_message: str, 
                                params: Optional[Dict]) -> Optional[ValidationRule]:
        """Infer validation rule from error message"""
        error_lower = error_message.lower()
        
        for pattern, rule_type in self.ERROR_PATTERNS:
            match = re.search(pattern, error_lower)
            if match:
                param_name = match.group(1) if match.lastindex else "unknown"
                
                return ValidationRule(
                    rule_type=rule_type,
                    parameter=param_name,
                    value=None,  # Would need more context to determine
                    error_message=error_message,
                )
                
        return None
        
    def _dict_to_command(self, cmd_id: int, data: Dict) -> CommandDefinition:
        """Convert dict to CommandDefinition"""
        params = []
        for p in data.get("parameters", []):
            params.append(ParameterDefinition(
                name=p["name"],
                param_type=ParameterType(p["type"]),
                required=p.get("required", True),
                default_value=p.get("default"),
                min_value=p.get("min"),
                max_value=p.get("max"),
                allowed_values=p.get("allowed"),
            ))
            
        rules = []
        for r in data.get("validation_rules", []):
            rules.append(ValidationRule(
                rule_type=ValidationRuleType(r["type"]),
                parameter=r["parameter"],
                value=r["value"],
                error_code=r.get("error_code"),
                error_message=r.get("error_message", ""),
            ))
            
        return CommandDefinition(
            command_id=cmd_id,
            command_name=data.get("command_name", f"CMD_{hex(cmd_id)}"),
            category=data.get("category", "unknown"),
            direction=data.get("direction", "c2s"),
            parameters=params,
            validation_rules=rules,
            response_command_id=int(data["response_command_id"], 16) if data.get("response_command_id") else None,
            description=data.get("description", ""),
        )


# Singleton
_analyzer: Optional[ProtocolAnalyzer] = None

def get_protocol_analyzer() -> ProtocolAnalyzer:
    """Get singleton protocol analyzer"""
    global _analyzer
    if _analyzer is None:
        _analyzer = ProtocolAnalyzer()
    return _analyzer
