"""
Automation Module - Full Bot Automation for Svony Studio

This module provides comprehensive automation capabilities:
- Script execution engine (RoboEvony .txt scripts)
- Direct AMF command sending
- Multi-account swarm control
- Exploit/glitch automation
- Farming optimization
"""

from .script_engine import (
    ScriptEngine,
    ScriptParser,
    ScriptCommand,
    ScriptContext,
    ScriptState,
    CommandType,
    get_script_engine,
)

from .amf_commander import (
    AMFCommander,
    GameCommand,
    CommandResult,
    ServerConfig,
    get_amf_commander,
)

from .swarm_controller import (
    SwarmController,
    SwarmTask,
    TaskResult,
    TaskType,
    TaskPriority,
    AccountConfig,
    AccountState,
    AccountStatus,
    get_swarm_controller,
)

from .exploit_manager import (
    ExploitManager,
    ExploitType,
    ExploitStatus,
    ExploitConfig,
    ExploitResult,
    get_exploit_manager,
)

from .troop_glitch_manager import (
    TroopGlitchManager,
    TroopType,
    GlitchType,
    TroopGlitchState,
    CityGlitchState,
    get_troop_glitch_manager,
)

from .city_manager import (
    CityAutomationManager,
    CityState,
    AutomationConfig,
    ResourceType,
    BuildingType,
    TaskType,
    get_city_manager,
)

from .account_parser import (
    AccountParser,
    AccountCredential,
    AccountFile,
    get_account_parser,
)

from .realtime_debug import (
    RealTimeDebugPanel,
    DebugEvent,
    EventType,
    BeanWatch,
    AccountStatus,
    get_debug_panel,
)

__all__ = [
    # Script Engine
    "ScriptEngine",
    "ScriptParser",
    "ScriptCommand",
    "ScriptContext",
    "ScriptState",
    "CommandType",
    "get_script_engine",
    # AMF Commander
    "AMFCommander",
    "GameCommand",
    "CommandResult",
    "ServerConfig",
    "get_amf_commander",
    # Swarm Controller
    "SwarmController",
    "SwarmTask",
    "TaskResult",
    "TaskType",
    "TaskPriority",
    "AccountConfig",
    "AccountState",
    "AccountStatus",
    "get_swarm_controller",
    # Exploit Manager
    "ExploitManager",
    "ExploitType",
    "ExploitStatus",
    "ExploitConfig",
    "ExploitResult",
    "get_exploit_manager",
    # Troop Glitch Manager
    "TroopGlitchManager",
    "TroopType",
    "GlitchType",
    "TroopGlitchState",
    "CityGlitchState",
    "get_troop_glitch_manager",
    # City Manager
    "CityAutomationManager",
    "CityState",
    "AutomationConfig",
    "ResourceType",
    "BuildingType",
    "TaskType",
    "get_city_manager",
    # Account Parser
    "AccountParser",
    "AccountCredential",
    "AccountFile",
    "get_account_parser",
    # Real-Time Debug
    "RealTimeDebugPanel",
    "DebugEvent",
    "EventType",
    "BeanWatch",
    "AccountStatus",
    "get_debug_panel",
]
