# Svony Studio - ABC Explorer Guide

> **"ABC Bytecode Analysis"** - Understanding ActionScript Bytecode

---

## Overview

ABC (ActionScript Byte Code) is the compiled form of ActionScript 3. Understanding ABC enables low-level analysis and modification of SWF behavior.

---

## What is ABC?

### ABC Structure

```
ABC File
├── Version Info (minor, major)
├── Constant Pool
│   ├── Integers
│   ├── Unsigned Integers
│   ├── Doubles
│   ├── Strings
│   ├── Namespaces
│   ├── Namespace Sets
│   └── Multinames
├── Methods
│   ├── Method Signatures
│   └── Method Bodies
├── Metadata
├── Classes
│   ├── Instance Info
│   └── Class Info
├── Scripts
└── Method Bodies
    ├── Instructions
    ├── Exception Handlers
    └── Traits
```

### ABC vs P-Code

| Level | Format | Use Case |
|-------|--------|----------|
| Source | ActionScript 3 | Human readable |
| P-Code | Text mnemonics | Debugging |
| ABC | Binary bytecode | Execution |

---

## ABC Explorer Interface

### Opening ABC Explorer

1. Open SWF in Svony Studio
2. **View → ABC Explorer** (or `Ctrl+Shift+A`)
3. Select ABC tag from dropdown

### Interface Layout

```
┌─────────────────────────────────────────────────┐
│ ABC Explorer                              [x]   │
├─────────────────────────────────────────────────┤
│ ABC Tag: [DoABC: frame1 ▼]                      │
├────────────────┬────────────────────────────────┤
│ Structure      │ Details                        │
│ ┌────────────┐ │ ┌────────────────────────────┐ │
│ │ Constants  │ │ │ Selected Item Details      │ │
│ │ ├─ Ints    │ │ │                            │ │
│ │ ├─ Strings │ │ │ Type: String               │ │
│ │ ├─ ...     │ │ │ Index: 42                  │ │
│ │ Methods    │ │ │ Value: "login"             │ │
│ │ Classes    │ │ │ References: 3              │ │
│ │ Scripts    │ │ │                            │ │
│ └────────────┘ │ └────────────────────────────┘ │
├────────────────┴────────────────────────────────┤
│ [Export] [Search] [Edit] [Refresh]              │
└─────────────────────────────────────────────────┘
```

---

## Constant Pool Analysis

### Integer Pool

```python
# Example constant pool integers
Integers: [
    0: 0,
    1: 1,
    2: -1,
    3: 100,
    4: 443,      # Port number?
    5: 10001,    # Command ID?
]
```

### String Pool

```python
# Example constant pool strings
Strings: [
    0: "",
    1: "Object",
    2: "flash.display",
    3: "Sprite",
    4: "login",           # <- Interesting!
    5: "sendCommand",     # <- Interesting!
    6: "svr12.evony.com", # <- Server URL!
]
```

### Finding Interesting Strings

```bash
# Export string pool
python main.py abc strings client.swf -o strings.txt

# Search for patterns
grep -i "login\|password\|server\|api" strings.txt
```

---

## Method Analysis

### Method Structure

```
Method {
    name: "sendCommand"
    return_type: "void"
    param_types: ["String", "Object"]
    flags: NEED_ACTIVATION | NEED_REST
    body: MethodBody {
        max_stack: 5
        local_count: 4
        init_scope_depth: 1
        max_scope_depth: 2
        code: [bytes...]
        exceptions: []
        traits: []
    }
}
```

### Method Flags

| Flag | Meaning |
|------|---------|
| `NEED_ARGUMENTS` | Uses `arguments` object |
| `NEED_ACTIVATION` | Uses activation object |
| `NEED_REST` | Has rest parameter (...args) |
| `HAS_OPTIONAL` | Has optional parameters |
| `SET_DXNS` | Sets default XML namespace |
| `HAS_PARAM_NAMES` | Has debug parameter names |

---

## Bytecode Instructions

### Common Instructions

| Opcode | Name | Stack | Description |
|--------|------|-------|-------------|
| 0x24 | pushbyte | → value | Push byte |
| 0x2C | pushstring | → string | Push string |
| 0x2D | pushint | → int | Push integer |
| 0x30 | pushscope | object → | Push to scope |
| 0x46 | callproperty | obj, args → result | Call method |
| 0x4F | callpropvoid | obj, args → | Call, ignore result |
| 0x60 | getlex | → value | Get lexical binding |
| 0x66 | getproperty | obj → value | Get property |
| 0x68 | initproperty | obj, value → | Initialize property |
| 0xD0 | getlocal0 | → value | Get local 0 (this) |
| 0x47 | returnvoid | → | Return void |
| 0x48 | returnvalue | value → | Return value |

### P-Code Example

```
; Method: sendCommand(cmd:String, data:Object):void
getlocal0           ; push this
pushscope           ; push to scope stack
getlocal0           ; push this
getlex Socket       ; get Socket class
getlocal1           ; push cmd parameter
getlocal2           ; push data parameter
callpropvoid send 2 ; call send with 2 args
returnvoid          ; return
```

---

## Class Analysis

### Class Structure

```
Class {
    name: "LoginHandler"
    super_name: "EventDispatcher"
    flags: SEALED | FINAL
    interfaces: ["IHandler"]
    
    instance: {
        traits: [
            {name: "socket", type: "Socket"},
            {name: "sessionId", type: "String"},
            {name: "login", type: "Function"}
        ]
    }
    
    class: {
        traits: [
            {name: "INSTANCE", type: "LoginHandler"}
        ]
    }
}
```

### Class Flags

| Flag | Meaning |
|------|---------|
| `SEALED` | No dynamic properties |
| `FINAL` | Cannot be subclassed |
| `INTERFACE` | Is an interface |
| `PROTECTED_NS` | Has protected namespace |

---

## Practical Analysis

### Finding Network Code

```python
# Search for network-related patterns
patterns = {
    "socket_create": "new Socket",
    "connect": "connect(",
    "send": "send(",
    "receive": "readObject",
    "amf": "AMF",
}

# In ABC Explorer:
# 1. Search strings for "Socket", "URLLoader"
# 2. Find methods that use these strings
# 3. Trace call hierarchy
```

### Finding Command Handlers

```python
# Look for command dispatch patterns
# Usually: switch statement on command ID

# In P-Code, look for:
# lookupswitch <cases>
# or series of:
# pushint <cmd_id>
# ifeq <handler>
```

### Finding Encryption

```python
# Search for crypto indicators
crypto_patterns = [
    "MD5",
    "SHA",
    "AES",
    "encrypt",
    "decrypt",
    "key",
    "cipher",
    "XOR",
]
```

---

## Editing ABC

### Simple Modifications

**Change String Constant:**

1. Open ABC Explorer
2. Navigate to Strings in Constant Pool
3. Find target string
4. Click **Edit**
5. Enter new value
6. Save changes

**Example:** Change server URL
```
Before: "svr12.evony.com"
After:  "localhost"
```

### Method Modification

**Warning:** Modifying bytecode can break the SWF.

1. Export method P-Code
2. Edit instructions
3. Reassemble
4. Test thoroughly

**Example:** Skip version check
```
; Original
getproperty version
pushstring "2.41"
ifne skip_login

; Modified (NOP out check)
nop
nop
nop
jump continue_login
```

---

## Using RABCDAsm

For low-level ABC editing, use RABCDAsm:

### Export ABC to Text

```bash
# Extract ABC from SWF
abcexport client.swf

# Disassemble ABC
rabcdasm client-0.abc
```

### Edit and Reassemble

```bash
# Edit the .main.asasm file
notepad client-0/client-0.main.asasm

# Reassemble
rabcasm client-0/client-0.main.asasm

# Replace in SWF
abcreplace client.swf 0 client-0/client-0.main.abc
```

---

## Evony-Specific ABC Analysis

### Key Classes to Find

| Class | Purpose | Look For |
|-------|---------|----------|
| `SocketHandler` | Network I/O | Socket, connect |
| `CommandFactory` | Command creation | createCommand |
| `ResponseParser` | Parse responses | parseResponse |
| `SessionManager` | Session state | sessionId, token |
| `CryptoUtil` | Encryption | MD5, encrypt |

### Command ID Mapping

```python
# In ABC, find the command dispatch
# Usually in a class like CommandManager

# Look for constant integers that match:
LOGIN = 10001
CITY_INFO = 20001
ARMY_MARCH = 30020
# etc.
```

---

## Export Options

### Export Formats

| Format | Use Case |
|--------|----------|
| P-Code | Human readable |
| Raw ABC | Binary editing |
| JSON | Structured analysis |
| XML | Interchange |

### Export Commands

```bash
# Export P-Code
python main.py abc export client.swf --format pcode -o pcode/

# Export structure as JSON
python main.py abc export client.swf --format json -o structure.json

# Export specific class
python main.py abc export client.swf --class LoginHandler -o login.pcode
```

---

## Best Practices

### Analysis Workflow

1. **Start broad**: Export all strings, find interesting ones
2. **Trace references**: Find what uses interesting strings
3. **Map structure**: Identify key classes and relationships
4. **Deep dive**: Analyze specific methods in detail
5. **Document**: Record findings as you go

### Modification Safety

1. **Always backup** original SWF
2. **Make minimal changes** at a time
3. **Test after each change**
4. **Keep change log**

---

## Related Documentation

- `OBFUSCATORS.md` - Deobfuscation techniques
- `formats/SWF_FORMAT.md` - SWF structure
- `evony/CLIENT_STRUCTURE.md` - Evony analysis
- `DEVELOPER_GUIDE.md` - Development info

---

*Document Version: 1.0.0 | ABC Bytecode Guide*
