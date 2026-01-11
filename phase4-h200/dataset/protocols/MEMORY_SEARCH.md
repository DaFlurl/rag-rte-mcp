# Svony Studio - Memory Search Tool

> **"Runtime Memory Analysis"** - Finding and Modifying Game Data in Memory

---

## Overview

The Memory Search tool allows inspection and modification of Flash Player runtime memory, useful for understanding game state, finding hidden values, and research purposes.

---

## When to Use Memory Search

| Use Case | Memory Search | Alternative |
|----------|---------------|-------------|
| Find current resource values | ✓ Best | - |
| Locate encrypted data | ✓ Best | - |
| Discover hidden game state | ✓ Best | - |
| Modify client-side values | ✓ Best | - |
| Protocol analysis | Partial | Proxy Tool |
| Static code analysis | No | SWF Decompiler |

---

## Interface

### Memory Search Panel

```
┌─────────────────────────────────────────────────────┐
│ Memory Search                                 [x]   │
├─────────────────────────────────────────────────────┤
│ Process: [Flash Player (PID: 12345) ▼] [Attach]     │
├─────────────────────────────────────────────────────┤
│ Search Type: [Integer ▼]  Value: [_______] [Search] │
│ ○ Exact  ○ Range  ○ Changed  ○ Unchanged           │
├─────────────────────────────────────────────────────┤
│ Results: 1,234 addresses found                      │
│ ┌─────────────────────────────────────────────────┐ │
│ │ Address     │ Value    │ Previous │ Type       │ │
│ │ 0x12345678 │ 50000    │ 49500    │ Int32      │ │
│ │ 0x12345AAC │ 50000    │ 50000    │ Int32      │ │
│ │ 0x12346100 │ 50000    │ 48000    │ Int32      │ │
│ └─────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────┤
│ [Next Scan] [New Scan] [Modify] [Add to Watchlist]  │
└─────────────────────────────────────────────────────┘
```

### Watchlist Panel

```
┌─────────────────────────────────────────────────────┐
│ Watchlist                                           │
├─────────────────────────────────────────────────────┤
│ Label       │ Address    │ Type   │ Value │ Frozen │
│ Gold        │ 0x12345678 │ Int32  │ 50000 │ □      │
│ Food        │ 0x12346AAC │ Int32  │ 75000 │ □      │
│ Wood        │ 0x12347100 │ Int32  │ 60000 │ □      │
└─────────────────────────────────────────────────────┘
```

---

## Search Types

### Numeric Types

| Type | Size | Range | Use For |
|------|------|-------|---------|
| **Byte** | 1 byte | 0-255 | Small counters |
| **Int16** | 2 bytes | -32768 to 32767 | Medium values |
| **Int32** | 4 bytes | ±2 billion | Resources, IDs |
| **Int64** | 8 bytes | Large numbers | Timestamps |
| **Float** | 4 bytes | Decimal | Coordinates |
| **Double** | 8 bytes | Precise decimal | Calculations |

### String Types

| Type | Encoding | Use For |
|------|----------|---------|
| **ASCII** | 1 byte/char | Simple strings |
| **UTF-8** | Variable | General text |
| **UTF-16** | 2 bytes/char | Flash strings |

### Pattern Types

| Type | Description | Example |
|------|-------------|---------|
| **Byte Array** | Raw bytes | `45 76 6F 6E 79` |
| **Wildcard** | Partial match | `45 ?? ?? 6E 79` |

---

## Search Workflow

### Finding a Value

**Step 1: Initial Search**
```
1. Attach to Flash Player process
2. Note current in-game value (e.g., Gold: 50000)
3. Select "Integer" type
4. Enter value: 50000
5. Click "Search"
→ Results: ~1,234 addresses
```

**Step 2: Narrow Down**
```
1. Change the value in-game (spend/gain resources)
2. New in-game value: 49500
3. Enter new value: 49500
4. Click "Next Scan"
→ Results: ~12 addresses
```

**Step 3: Identify Correct Address**
```
1. Repeat step 2 several times
2. Eventually: 1-3 addresses remain
3. Test by modifying value
4. If game reflects change, found it!
```

### Search Operators

| Operator | Description | Use Case |
|----------|-------------|----------|
| **Exact** | Value equals X | Known values |
| **Range** | X ≤ Value ≤ Y | Approximate values |
| **Greater** | Value > previous | Increasing values |
| **Less** | Value < previous | Decreasing values |
| **Changed** | Value ≠ previous | Any change |
| **Unchanged** | Value = previous | Static values |

---

## Evony Memory Patterns

### Common Data Structures

**City Resources:**
```
Offset   Type    Field
0x00     Int32   Gold
0x04     Int32   Food
0x08     Int32   Wood
0x0C     Int32   Stone
0x10     Int32   Iron
0x14     Int32   Population
```

**Troop Counts:**
```
Offset   Type    Field
0x00     Int32   Worker
0x04     Int32   Warrior
0x08     Int32   Scout
0x0C     Int32   Pikeman
0x10     Int32   Swordsman
0x14     Int32   Archer
0x18     Int32   Cavalry
0x1C     Int32   Cataphract
0x20     Int32   Transporter
0x24     Int32   Ballista
0x28     Int32   Ram
0x2C     Int32   Catapult
```

### Finding Structures

```python
# Once you find one value (e.g., Gold at 0x12345678)
# Other resources are likely nearby

base_address = 0x12345678
offsets = {
    "gold": 0x00,
    "food": 0x04,
    "wood": 0x08,
    "stone": 0x0C,
    "iron": 0x10,
}

for name, offset in offsets.items():
    addr = base_address + offset
    value = read_memory(addr, 4)  # Read Int32
    print(f"{name}: {value} @ {hex(addr)}")
```

---

## Python API

### Basic Usage

```python
from svony.tools.memory import MemoryScanner

# Attach to process
scanner = MemoryScanner()
scanner.attach("flashplayer.exe")

# Initial search
results = scanner.search(50000, type="int32")
print(f"Found {len(results)} addresses")

# Narrow down
scanner.next_scan(49500)
print(f"Narrowed to {len(scanner.results)} addresses")

# Read value
addr = scanner.results[0]
value = scanner.read(addr, "int32")
print(f"Value at {hex(addr)}: {value}")

# Modify value
scanner.write(addr, 999999, "int32")
```

### Watchlist Management

```python
# Add to watchlist
scanner.watchlist.add("Gold", addr, "int32")

# Update values
scanner.watchlist.refresh()

# Freeze value
scanner.watchlist.freeze("Gold", 999999)

# Export watchlist
scanner.watchlist.export("evony_addresses.json")

# Import watchlist
scanner.watchlist.import_("evony_addresses.json")
```

### Pattern Search

```python
# Search for byte pattern
pattern = bytes.fromhex("45 76 6F 6E 79")  # "Evony"
results = scanner.search_pattern(pattern)

# Wildcard search (? = any byte)
pattern = "45 ?? ?? 6E 79"
results = scanner.search_pattern(pattern, wildcard=True)
```

---

## CLI Commands

```bash
# Attach to process
python main.py memory attach --process "flashplayer.exe"

# Search for value
python main.py memory search --value 50000 --type int32

# Next scan
python main.py memory next --value 49500

# Read address
python main.py memory read --address 0x12345678 --type int32

# Write value
python main.py memory write --address 0x12345678 --value 999999 --type int32

# Export results
python main.py memory export --output addresses.json
```

---

## Limitations

### Technical Limitations

| Limitation | Description | Workaround |
|------------|-------------|------------|
| Process access | Requires admin | Run as administrator |
| ASLR | Addresses change | Re-search each session |
| Packed values | Encrypted/compressed | Find encryption routine |
| Server validation | Server-side checks | Client visual only |

### Evony-Specific

- Resource changes validated server-side
- Modified values reset on server sync
- Useful for research, not cheating
- Troop counts server-authoritative

---

## Best Practices

### Research Workflow

1. **Document everything** - Keep notes on addresses found
2. **Use watchlists** - Track important addresses
3. **Correlate with decompiled code** - Understand data structures
4. **Test carefully** - One change at a time
5. **Backup saves** - Before modifications

### Finding Hidden Data

```python
# Strategy: Search for unknown values by change
# 1. Trigger an in-game event
# 2. Search for "Changed" values
# 3. Trigger opposite event
# 4. Search for "Changed" again
# 5. Intersect results
```

---

## Security Notes

- Memory modification may violate ToS
- Server-side validation prevents most exploits
- Use for research and learning only
- Some antivirus may flag memory tools

---

## Related Documentation

- `PROXY_TOOL.md` - Network analysis
- `evony/EVONY_PROTOCOL.md` - Protocol details
- `ABC_EXPLORER.md` - Code analysis
- `SECURITY.md` - Security considerations

---

*Document Version: 1.0.0 | Memory Search Guide*
