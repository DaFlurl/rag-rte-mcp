# Evony Bot Scripting Guide

> **"Automation Protocols"** - Writing Scripts for AutoEvony and RoboEvony

---

## Overview

This guide covers the scripting systems used by Evony automation bots. Understanding these systems helps in reverse engineering, creating custom scripts, and extending bot functionality.

---

## AutoEvony Script Format

AutoEvony uses simple text-based scripts with a line-by-line execution model.

### Basic Syntax

```
// Comments start with double slash
COMMAND argument1 argument2
LOOP count
    // Indented commands (optional)
    COMMAND args
END
```

### Core Commands

#### Attack Commands

| Command | Syntax | Description |
|---------|--------|-------------|
| ATTACK_NPC | `ATTACK_NPC level count` | Attack NPCs of specified level |
| ATTACK_VALLEY | `ATTACK_VALLEY x y` | Attack valley at coordinates |
| SCOUT | `SCOUT x y` | Scout target location |

```
// Example: Farm level 5 NPCs
LOOP 50
    ATTACK_NPC 5 100
    WAIT 120
END
```

#### Army Commands

| Command | Syntax | Description |
|---------|--------|-------------|
| TRAIN | `TRAIN unit_type count` | Train troops |
| RECALL_ALL | `RECALL_ALL` | Recall all marching armies |
| TRANSPORT | `TRANSPORT city resource amount` | Send resources |

```
// Example: Continuous training
LOOP 1000
    TRAIN archer 500
    WAIT 300
END
```

#### Building Commands

| Command | Syntax | Description |
|---------|--------|-------------|
| BUILD | `BUILD type slot` | Construct building |
| UPGRADE | `UPGRADE slot` | Upgrade building at slot |
| RESEARCH | `RESEARCH tech_name` | Start research |

```
// Example: Build barracks
BUILD barracks 5
WAIT 3600
UPGRADE 5
```

#### Control Flow

| Command | Syntax | Description |
|---------|--------|-------------|
| LOOP | `LOOP count ... END` | Repeat block N times |
| IF | `IF condition ... ENDIF` | Conditional execution |
| WAIT | `WAIT seconds` | Pause execution |

```
// Example: Conditional farming
LOOP 100
    IF $troops > 50000
        ATTACK_NPC 10 200
    ENDIF
    WAIT 60
END
```

### Variables

Built-in variables for conditions:

| Variable | Type | Description |
|----------|------|-------------|
| `$gold` | int | Current gold |
| `$food` | int | Current food |
| `$wood` | int | Current wood |
| `$stone` | int | Current stone |
| `$iron` | int | Current iron |
| `$troops` | int | Total troop count |
| `$heroes` | int | Number of heroes |
| `$queues` | int | Active build queues |

### Operators

| Operator | Example | Description |
|----------|---------|-------------|
| `>` | `$gold > 1000000` | Greater than |
| `<` | `$food < 5000` | Less than |
| `==` | `$queues == 0` | Equal to |
| `!=` | `$heroes != 0` | Not equal |
| `AND` | `$gold > 100 AND $food > 100` | Logical AND |
| `OR` | `$troops < 1000 OR $food < 1000` | Logical OR |

---

## RoboEvony Task System

RoboEvony uses a more sophisticated AI-driven task system.

### Task Configuration

Tasks are defined in XML or JSON configuration:

```xml
<task name="FarmNPC" priority="50" enabled="true">
    <trigger>
        <condition type="troops" operator="gt" value="10000"/>
        <condition type="interval" minutes="5"/>
    </trigger>
    <action type="attackNPC">
        <param name="level" value="5"/>
        <param name="waves" value="3"/>
    </action>
</task>
```

### Task Priorities

| Priority | Range | Examples |
|----------|-------|----------|
| Critical | 90-100 | Defend, Emergency recall |
| High | 70-89 | Build queue, Research |
| Normal | 40-69 | Train, Attack NPC |
| Low | 20-39 | Cleanup, Reports |
| Background | 1-19 | Statistics, Logging |

### Built-in Strategies

```
FarmingStrategy     - Maximize NPC farming
GrowthStrategy      - Balanced city development  
DefenseStrategy     - Prioritize defense
AttackStrategy      - Aggressive PvP
ResourceStrategy    - Resource optimization
```

---

## Script Examples

### Complete Farm Script

```
// farm_all_day.txt
// Farms NPCs continuously with resource management

LOOP 9999
    // Check if we have enough troops
    IF $troops > 50000
        // Farm high level NPCs
        ATTACK_NPC 10 100
        WAIT 120
    ENDIF
    
    IF $troops > 20000 AND $troops < 50000
        // Farm medium NPCs
        ATTACK_NPC 5 50
        WAIT 60
    ENDIF
    
    IF $troops < 20000
        // Wait for more troops
        WAIT 300
    ENDIF
    
    // Keep training
    IF $food > 100000
        TRAIN archer 1000
    ENDIF
END
```

### Resource Management Script

```
// resource_balance.txt
// Balances resources between cities

LOOP 100
    // If food is low, transport from alt
    IF $food < 50000
        TRANSPORT alt_city food 100000
        WAIT 600
    ENDIF
    
    // If gold is high, market sell
    IF $gold > 5000000
        // Gold management (custom)
        WAIT 60
    ENDIF
    
    WAIT 300
END
```

### Build Queue Script

```
// auto_build.txt
// Maintains building queue

LOOP 500
    IF $queues == 0
        // Find next upgrade (simplified)
        UPGRADE 1
        WAIT 10
        
        IF $queues == 0
            UPGRADE 2
            WAIT 10
        ENDIF
    ENDIF
    
    WAIT 60
END
```

---

## Svony Studio Integration

### Viewing Bot Scripts

1. Load AutoEvony or RoboEvony SWF
2. Navigate to `autoevony.scripts` or `roboevony.tasks`
3. View decompiled script engine code

### Creating Scripts

1. Open Script Editor tab
2. Create new .txt file
3. Use syntax highlighting for validation
4. Save to scripts folder

### Launching Bots

1. Select account in SOL Manager
2. Click "Launch Bot"
3. Select script file
4. Bot starts with credentials

---

## Best Practices

### Timing

- Always include `WAIT` between actions
- Minimum 30-60 seconds between similar actions
- Longer waits reduce detection risk

### Error Handling

```
// Check before action
IF $troops > 0
    ATTACK_NPC 5 50
ENDIF
// Prevents errors when no troops
```

### Resource Checks

```
// Don't train if no food
IF $food > 10000
    TRAIN archer 500
ENDIF
```

### Loop Management

- Use finite loops when possible
- Include exit conditions
- Monitor script execution

---

## Class Reference

### AutoEvony Classes

```
autoevony.cmds.Commands      // Main command implementations
autoevony.cmds.CityCommands  // City-related commands
autoevony.cmds.ArmyCommands  // Military commands
autoevony.scripts.Script     // Script parser/executor
autoevony.scripts.Context    // Execution context
autoevony.data.Account       // Account management
```

### RoboEvony Classes

```
roboevony.core.Controller    // Main controller
roboevony.core.Scheduler     // Task scheduling
roboevony.tasks.TaskQueue    // Priority queue
roboevony.tasks.Task         // Base task class
roboevony.ai.DecisionMaker   // AI decision engine
roboevony.ai.Strategy        // Strategy base class
```

---

## Related Documentation

- `autoevony_structure.svg` - AutoEvony architecture
- `roboevony_structure.svg` - RoboEvony architecture  
- `bot_execution.svg` - Script execution flow
- `EVONY_PROTOCOL.md` - Network protocol

---

*Document Version: 1.0.0 | For educational purposes only*
