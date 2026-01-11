# Svony Studio - Obfuscation Support

> **"Deobfuscation Guide"** - Understanding and Defeating SWF Obfuscation

---

## Overview

SWF files are frequently obfuscated to protect intellectual property. Svony Studio (via FFDec) supports detection and removal of various obfuscation techniques.

---

## Supported Obfuscators

### Fully Supported

| Obfuscator | Detection | Deobfuscation | Notes |
|------------|-----------|---------------|-------|
| **secureSWF** | ✅ Auto | ✅ Full | Most common commercial |
| **DoSWF** | ✅ Auto | ✅ Full | String encryption |
| **Amayeta SWF Encrypt** | ✅ Auto | ⚠️ Partial | Older versions only |
| **SWF Protector** | ✅ Auto | ✅ Full | Basic protection |
| **Kindi** | ⚠️ Manual | ⚠️ Partial | Rare, complex |

### Partially Supported

| Obfuscator | Detection | Deobfuscation | Notes |
|------------|-----------|---------------|-------|
| **irrFuscator** | ⚠️ Manual | ⚠️ Limited | Advanced control flow |
| **SWF Encrypt** | ✅ Auto | ⚠️ Partial | Heavy encryption |
| **Mochi Encryption** | ⚠️ Manual | ⚠️ Partial | Game-specific |

### Not Supported

| Obfuscator | Reason |
|------------|--------|
| Custom VM protectors | Requires manual RE |
| Heavy packing | Must unpack first |
| Hardware dongles | External dependency |

---

## Obfuscation Techniques

### 1. Identifier Renaming

**Description**: Replaces meaningful names with random characters.

**Before:**
```actionscript
public function loginUser(username:String, password:String):void {
    sendRequest("login", {user: username, pass: password});
}
```

**After (Obfuscated):**
```actionscript
public function a(b:String, c:String):void {
    d("login", {e: b, f: c});
}
```

**Deobfuscation**: Automatic renaming with pattern detection.

### 2. String Encryption

**Description**: Encrypts string literals, decrypts at runtime.

**Obfuscated:**
```actionscript
var url:String = _decrypt("\x45\x76\x6f\x6e\x79");  // "Evony"
```

**Deobfuscation**: FFDec detects decryption routines and inlines results.

### 3. Control Flow Obfuscation

**Description**: Adds fake branches, loops, and dead code.

**Obfuscated:**
```actionscript
var x:int = 1;
if (x > 0) {
    if (x < 2) {
        // real code here
    }
}
// Unreachable fake code
while (false) {
    fakeFunction();
}
```

**Deobfuscation**: Dead code elimination, branch simplification.

### 4. Opaque Predicates

**Description**: Conditions that always evaluate the same way.

**Example:**
```actionscript
var a:int = 5;
var b:int = 3;
if ((a * b) % 2 == 1) {  // Always true: 15 % 2 == 1
    realFunction();
} else {
    fakeFunction();  // Never executed
}
```

**Deobfuscation**: Constant propagation, predicate analysis.

### 5. Code Flattening

**Description**: Converts structured code to state machine.

**Before:**
```actionscript
function process():void {
    step1();
    step2();
    step3();
}
```

**After (Flattened):**
```actionscript
function process():void {
    var state:int = 0;
    while (true) {
        switch (state) {
            case 0: step1(); state = 1; break;
            case 1: step2(); state = 2; break;
            case 2: step3(); return;
        }
    }
}
```

**Deobfuscation**: State machine reconstruction (limited support).

---

## Using Deobfuscation

### GUI Method

1. Open SWF in Svony Studio
2. **Tools → Deobfuscate**
3. Select deobfuscation level:
   - **Level 1**: Identifier renaming only
   - **Level 2**: + String decryption
   - **Level 3**: + Control flow simplification
4. Click **Apply**
5. Review results

### CLI Method

```bash
# Basic deobfuscation
python main.py swf deobfuscate client.swf -o client_deob.swf

# Specify level
python main.py swf deobfuscate client.swf --level 3 -o client_deob.swf

# With specific techniques
python main.py swf deobfuscate client.swf \
    --rename-identifiers \
    --decrypt-strings \
    --remove-dead-code \
    -o client_deob.swf
```

### FFDec Direct

```bash
ffdec -deobfuscate level3 client.swf client_deob.swf
```

---

## Deobfuscation Levels

### Level 1: Basic

- Rename single-character identifiers
- Rename numeric identifiers
- Basic cleanup

**Use when**: Quick analysis, minimal changes needed

### Level 2: Standard

- All Level 1 features
- String decryption
- Simple dead code removal
- Basic constant propagation

**Use when**: Most obfuscated files

### Level 3: Aggressive

- All Level 2 features
- Control flow reconstruction
- Opaque predicate removal
- Advanced dead code elimination
- Loop optimization

**Use when**: Heavily obfuscated files

**Warning**: May alter program behavior in edge cases

---

## Evony-Specific Obfuscation

### Observed Patterns

Evony clients typically use:

1. **Identifier Obfuscation**: All internal classes renamed
2. **String Encryption**: Server URLs, command names encrypted
3. **Light Control Flow**: Some fake branches

### Recommended Approach

```bash
# Step 1: Level 2 deobfuscation
python main.py swf deobfuscate evony_client.swf --level 2 -o step1.swf

# Step 2: Extract and analyze strings
python main.py swf export step1.swf --type strings -o strings.txt

# Step 3: Identify key patterns
grep -E "(server|login|password|cmd)" strings.txt

# Step 4: Targeted analysis on interesting classes
python main.py swf decompile step1.swf --class com.evony.net.Socket
```

### Known Evony Obfuscation

| Version | Obfuscation Type | Difficulty |
|---------|------------------|------------|
| 1.x | Light (renaming only) | Easy |
| 2.x | Medium (+ string encryption) | Medium |
| Age II | Medium-Heavy | Medium |

---

## Manual Deobfuscation

When automatic fails, manual techniques:

### Pattern Recognition

```python
# Find encryption functions
def find_decrypt_functions(scripts):
    patterns = [
        r"function\s+\w+\(.*?\):String",  # Returns String
        r"charCodeAt|fromCharCode",        # Char manipulation
        r"split|join",                      # String operations
        r"\^\s*0x[0-9a-f]+",               # XOR operations
    ]
    # Search and analyze
```

### Rename Strategy

```
Original    → Meaningful Name
a           → socket
b           → sendCommand
c           → responseHandler
_0x1234     → loginHandler
```

### String Analysis

1. Find all encrypted strings
2. Locate decryption function
3. Extract key/algorithm
4. Batch decrypt

---

## Limitations

### Cannot Deobfuscate

- **Custom VM**: Code runs in custom interpreter
- **External Decryption**: Keys stored server-side
- **Dynamic Loading**: Code downloaded at runtime
- **Native Extensions**: ANE/SWC with native code

### May Produce Incorrect Results

- Complex control flow
- Self-modifying code
- Anti-debugging tricks
- Timing-dependent code

---

## Best Practices

### Before Deobfuscation

1. **Backup original** file
2. **Check legality** of deobfuscation in your jurisdiction
3. **Document** original state

### During Deobfuscation

1. Start with **lowest level** that works
2. **Compare** before/after behavior
3. **Test** deobfuscated file runs correctly
4. **Iterate** if needed

### After Deobfuscation

1. **Verify** key functionality preserved
2. **Document** changes made
3. **Keep** original for reference

---

## Related Documentation

- `formats/SWF_FORMAT.md` - SWF structure
- `formats/AMF_ENCODING.md` - AMF data format
- `evony/CLIENT_STRUCTURE.md` - Evony client analysis
- `ABC_EXPLORER.md` - ABC bytecode analysis

---

*Document Version: 1.0.0 | Deobfuscation Guide*
