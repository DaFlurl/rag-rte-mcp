# Svony Studio - CLI Reference

> **"Command Line Interface"** - Complete CLI Documentation

---

## Overview

Svony Studio provides a comprehensive CLI for automation, scripting, and headless operation. All GUI features are available via command line.

---

## Basic Usage

```bash
python main.py [command] [options] [arguments]
```

### Global Options

| Option | Short | Description |
|--------|-------|-------------|
| `--help` | `-h` | Show help message |
| `--version` | `-v` | Show version |
| `--config` | `-c` | Config file path |
| `--verbose` | `-V` | Verbose output |
| `--quiet` | `-q` | Suppress output |
| `--output` | `-o` | Output directory |

---

## Commands

### Project Commands

#### `project new`

Create a new project.

```bash
python main.py project new <name> [--template <template>]
```

**Options:**
- `--template`: Project template (default, evony, bot)
- `--path`: Project location

**Example:**
```bash
python main.py project new my_evony_project --template evony
```

#### `project open`

Open existing project.

```bash
python main.py project open <path>
```

#### `project list`

List recent projects.

```bash
python main.py project list [--count 10]
```

---

### SWF Commands

#### `swf info`

Display SWF file information.

```bash
python main.py swf info <file.swf>
```

**Output:**
```
File: client.swf
Size: 15.2 MB
Version: 32
Frame Rate: 24 fps
Dimensions: 1024x768
Compression: ZLIB
AS Version: ActionScript 3
Tag Count: 2847
```

#### `swf decompile`

Decompile SWF to scripts.

```bash
python main.py swf decompile <file.swf> [--output <dir>] [--format <format>]
```

**Options:**
- `--output`: Output directory
- `--format`: Output format (as, pcode)
- `--class`: Specific class to decompile
- `--package`: Specific package

**Example:**
```bash
python main.py swf decompile client.swf -o scripts/ --package com.evony
```

#### `swf export`

Export assets from SWF.

```bash
python main.py swf export <file.swf> --type <type> [--output <dir>]
```

**Types:**
- `scripts` - ActionScript files
- `images` - PNG/JPG images
- `sounds` - Audio files
- `fonts` - Font files
- `shapes` - Vector shapes
- `binary` - Binary data
- `all` - Everything

**Example:**
```bash
python main.py swf export client.swf --type images -o assets/
```

#### `swf compress`

Compress/decompress SWF.

```bash
python main.py swf compress <file.swf> --method <method> [--output <file>]
```

**Methods:**
- `zlib` - ZLIB compression
- `lzma` - LZMA compression
- `none` - Remove compression

#### `swf xml`

Convert SWF to/from XML.

```bash
# SWF to XML
python main.py swf xml export <file.swf> -o output.xml

# XML to SWF
python main.py swf xml import <file.xml> -o output.swf
```

#### `swf deobfuscate`

Run deobfuscator on SWF.

```bash
python main.py swf deobfuscate <file.swf> [--level <1-3>] [--output <file>]
```

**Levels:**
- `1` - Basic (rename identifiers)
- `2` - Medium (control flow)
- `3` - Full (all techniques)

---

### SOL Commands

#### `sol scan`

Scan for SOL files.

```bash
python main.py sol scan [--path <path>] [--evony-only]
```

**Example:**
```bash
python main.py sol scan --evony-only
```

**Output:**
```
Found 5 Evony SOL files:
  cevony_sol.sol - 2.3 KB - svr12
  cevony_settings.sol - 1.1 KB
  ...
```

#### `sol read`

Read SOL file contents.

```bash
python main.py sol read <file.sol> [--format <format>]
```

**Formats:**
- `json` - JSON output
- `yaml` - YAML output
- `table` - Table format

**Example:**
```bash
python main.py sol read cevony_sol.sol --format json
```

#### `sol edit`

Edit SOL values.

```bash
python main.py sol edit <file.sol> --key <path> --value <value>
```

**Example:**
```bash
python main.py sol edit cevony_sol.sol --key settings.sound --value false
```

#### `sol export`

Export SOL to file.

```bash
python main.py sol export <file.sol> -o <output.json>
```

#### `sol import`

Import SOL from file.

```bash
python main.py sol import <input.json> -o <file.sol>
```

#### `sol credentials`

Extract saved credentials.

```bash
python main.py sol credentials [--export <file>]
```

---

### Search Commands

#### `search text`

Search for text in files.

```bash
python main.py search text <pattern> [--path <dir>] [--type <filetype>]
```

**Options:**
- `--path`: Search directory
- `--type`: File type filter (as, sol, all)
- `--regex`: Use regex pattern
- `--case`: Case sensitive

**Example:**
```bash
python main.py search text "login" --path scripts/ --type as
```

#### `search class`

Search for class definitions.

```bash
python main.py search class <name> [--path <dir>]
```

#### `search protocol`

Search for protocol commands.

```bash
python main.py search protocol [--pattern <pattern>]
```

---

### Evony Commands

#### `evony analyze`

Analyze Evony client.

```bash
python main.py evony analyze <client.swf> [--deep]
```

**Output:**
```
Evony Client Analysis
=====================
Version: 2.41
Protocol: AMF3
Server Endpoints: 3 found
Command Handlers: 45 found
SharedObject Keys: 12 found
...
```

#### `evony patch`

Apply patches to client.

```bash
python main.py evony patch <client.swf> --patch <patch_name> [--output <file>]
```

**Available Patches:**
- `server_url` - Change server URL
- `version_check` - Disable version check
- `debug_mode` - Enable debug output

**Example:**
```bash
python main.py evony patch client.swf --patch server_url --server "localhost:8080"
```

#### `evony protocol`

Extract protocol information.

```bash
python main.py evony protocol <client.swf> [--output <file>]
```

---

### Bot Commands

#### `bot validate`

Validate bot script syntax.

```bash
python main.py bot validate <script.txt>
```

#### `bot run`

Run bot script (testing mode).

```bash
python main.py bot run <script.txt> [--dry-run]
```

#### `bot convert`

Convert between script formats.

```bash
python main.py bot convert <input> --format <format> -o <output>
```

**Formats:**
- `autoevony` - AutoEvony script
- `roboevony` - RoboEvony script
- `json` - JSON format

---

### Build Commands

#### `build`

Build project.

```bash
python main.py build [--config <file>] [--target <target>]
```

**Targets:**
- `debug` - Debug build
- `release` - Release build
- `package` - Create distribution

#### `build clean`

Clean build artifacts.

```bash
python main.py build clean
```

---

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | General error |
| 2 | Invalid arguments |
| 3 | File not found |
| 4 | Permission denied |
| 5 | Configuration error |
| 10 | FFDec error |
| 11 | Java not found |
| 20 | SWF parse error |
| 21 | SOL parse error |

---

## Configuration File

Commands can use a configuration file:

```yaml
# cli_config.yaml
defaults:
  output_dir: "./output"
  verbose: true
  
swf:
  decompile_format: "as"
  compression: "zlib"
  
sol:
  backup: true
  export_format: "json"
```

Use with:
```bash
python main.py --config cli_config.yaml swf decompile client.swf
```

---

## Scripting Examples

### Batch Decompile

```bash
#!/bin/bash
# batch_decompile.sh

for swf in *.swf; do
    echo "Decompiling $swf..."
    python main.py swf decompile "$swf" -o "output/${swf%.swf}"
done
```

### PowerShell Automation

```powershell
# batch_export.ps1

$swfs = Get-ChildItem -Filter "*.swf"
foreach ($swf in $swfs) {
    python main.py swf export $swf.Name --type all -o "exports/$($swf.BaseName)"
}
```

### Python Integration

```python
import subprocess
import json

def decompile_swf(swf_path, output_dir):
    result = subprocess.run([
        "python", "main.py", "swf", "decompile",
        swf_path, "-o", output_dir, "--quiet"
    ], capture_output=True, text=True)
    return result.returncode == 0

def read_sol(sol_path):
    result = subprocess.run([
        "python", "main.py", "sol", "read",
        sol_path, "--format", "json"
    ], capture_output=True, text=True)
    return json.loads(result.stdout)
```

---

## Environment Variables

| Variable | Description |
|----------|-------------|
| `SVONY_CONFIG` | Default config file |
| `SVONY_OUTPUT` | Default output directory |
| `SVONY_VERBOSE` | Enable verbose mode |
| `SVONY_FFDEC` | FFDec path override |

---

## Related Documentation

- `USER_GUIDE.md` - GUI usage
- `DEVELOPER_GUIDE.md` - Development
- `KEYBOARD_SHORTCUTS.md` - Shortcuts
- `API_REFERENCE.md` - API docs

---

*Document Version: 1.0.0 | CLI Reference*
