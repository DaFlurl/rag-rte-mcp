# Svony Studio - Tutorials

> **"Step-by-Step Guides"** - Practical Tutorials for Common Tasks

---

## Overview

This document provides step-by-step tutorials for common Svony Studio tasks, from basic SWF analysis to advanced bot development.

---

## Tutorial 1: Your First SWF Decompilation

**Goal**: Open an Evony client SWF and explore its contents.

**Time**: 10 minutes

### Step 1: Launch Svony Studio

```powershell
cd D:\svony_studio
.\run.ps1
```

### Step 2: Open SWF File

1. Click **File → Open** or press `Ctrl+O`
2. Navigate to your Evony client SWF
3. Select `client.swf` and click Open

### Step 3: Explore the Structure

1. In the **Project Tree** (left panel):
   - Expand "Scripts" to see ActionScript packages
   - Expand "Assets" to see images, sounds, fonts

2. View SWF information in the **Console** tab:
   ```
   Loaded: client.swf
   Version: 32, AS3
   Size: 15.2 MB
   Tags: 2847
   ```

### Step 4: View a Script

1. In Project Tree, navigate to:
   ```
   Scripts → com → evony → client → Main.as
   ```
2. Double-click to open in Script Editor
3. The decompiled ActionScript appears

### Step 5: Search for Keywords

1. Press `Ctrl+F` to open Find
2. Search for "login"
3. Review matches in the search results

**Congratulations!** You've completed basic SWF exploration.

---

## Tutorial 2: Extracting Game Assets

**Goal**: Export all images, sounds, and other assets from an Evony SWF.

**Time**: 15 minutes

### Step 1: Open SWF

Open your target SWF file as in Tutorial 1.

### Step 2: Access Asset Browser

1. Click the **Assets** tab (or press `Ctrl+3`)
2. You'll see categories:
   - Images (PNG, JPG)
   - Sounds (MP3, WAV)
   - Fonts (TTF)
   - Shapes (SVG)

### Step 3: Preview Assets

1. Click any asset to preview
2. Use filter dropdown to show specific types
3. Use search box to find by name

### Step 4: Export Single Asset

1. Right-click an asset
2. Select **Export**
3. Choose save location
4. Select format if prompted

### Step 5: Batch Export All Assets

1. Click **Tools → Export → All Assets**
2. Or use keyboard: `Ctrl+Shift+E`
3. Select output directory
4. Choose types to export:
   - ☑ Images
   - ☑ Sounds
   - ☐ Fonts
   - ☑ Shapes
5. Click **Export**

### Step 6: Verify Export

Navigate to output directory:
```
exports/
├── images/
│   ├── sprite_001.png
│   ├── sprite_002.png
│   └── ...
├── sounds/
│   ├── click.mp3
│   └── ...
└── shapes/
    └── ...
```

---

## Tutorial 3: Finding Saved Credentials

**Goal**: Extract saved Evony account credentials from SOL files.

**Time**: 10 minutes

### Step 1: Open SOL Manager

1. Click the **SOL** tab (or press `Ctrl+4`)
2. Or click **Tools → SOL Manager**

### Step 2: Scan for SOL Files

1. Click **Scan** button
2. Studio searches common locations:
   - Flash Player SharedObjects
   - Chrome Pepper Data
   - Firefox Plugin Data

### Step 3: Find Evony SOLs

Look for files named:
- `cevony_sol.sol`
- `cevony_settings.sol`
- `evony_*.sol`

### Step 4: View Credentials

1. Double-click `cevony_sol.sol`
2. In the data tree, expand to find:
   ```
   data
   ├── username: "YourUsername"
   ├── password: "md5_hash_here"
   ├── server: "svr12.evony.com"
   └── autoLogin: true
   ```

### Step 5: Export for Bot Use

1. With SOL selected, click **Export**
2. Save as JSON
3. Use with bot frameworks

**Security Note**: Treat exported credentials carefully!

---

## Tutorial 4: Analyzing the Evony Protocol

**Goal**: Understand how Evony client communicates with servers.

**Time**: 20 minutes

### Step 1: Open Evony Client SWF

Load the client SWF in Svony Studio.

### Step 2: Run Borg Mode Analysis

1. Click **Tools → Evony → Borg Mode Analysis**
2. Wait for deep scan to complete
3. Review the analysis report

### Step 3: Find Network Classes

1. In Project Tree, search for:
   - `Socket`
   - `URLLoader`
   - `NetConnection`

2. Navigate to:
   ```
   com → evony → net → SocketHandler.as
   ```

### Step 4: Identify Command Handlers

1. Search for `sendCommand` or `handleResponse`
2. Find the command routing class
3. Document command IDs and handlers

### Step 5: View Protocol Documentation

1. Click **Help → Protocol Reference**
2. Or open `docs/evony/COMMAND_REFERENCE.md`
3. Cross-reference with discovered commands

### Step 6: Export Protocol Map

1. **Tools → Evony → Export Protocol**
2. Generates JSON with all commands:
   ```json
   {
       "commands": {
           "10001": {"name": "login", "direction": "c2s"},
           "20001": {"name": "getCityInfo", "direction": "c2s"}
       }
   }
   ```

---

## Tutorial 5: Creating a Simple Bot Script

**Goal**: Write a basic NPC farming script for RoboEvony.

**Time**: 30 minutes

### Step 1: Open Script Editor

1. **File → New → Bot Script**
2. Select template: "RoboEvony Basic"
3. Name: `npc_farm.txt`

### Step 2: Write Script Header

```
# NPC Farm Script
# Farms level 5 NPCs continuously
# Created with Svony Studio

# Configuration
set target_level = 5
set min_archers = 3000
set wait_time = 300
```

### Step 3: Add Main Loop

```
# Main farming loop
label main

    # Check if we have enough troops
    IF $archers > $min_archers
        LOG "Starting attack..."
        ATTACK_NPC $target_level 1
        WAIT $wait_time
    ELSE
        LOG "Waiting for troops..."
        WAIT 600
    ENDIF

    GOTO main
```

### Step 4: Validate Script

1. Click **Script → Validate** or `Ctrl+Shift+V`
2. Fix any reported errors
3. Green checkmark = valid syntax

### Step 5: Test in Dry Run

1. Click **Script → Dry Run**
2. Watch simulated execution in console
3. Verify logic is correct

### Step 6: Export for Use

1. **File → Save As**
2. Save to RoboEvony scripts folder:
   ```
   D:\evony_bots\roboevony\scripts\npc_farm.txt
   ```

---

## Tutorial 6: Patching the Client

**Goal**: Modify the Evony client to change server URL.

**Time**: 15 minutes

### Step 1: Open Client SWF

Load `client.swf` in Svony Studio.

### Step 2: Find Server URL

1. Search for server URL patterns:
   - `svr*.evony.com`
   - `api.evony.com`
   - `443` (port)

2. Note the file and location

### Step 3: Apply Quick Patch

1. **Tools → Evony → Quick Patches**
2. Select "Server URL Redirect"
3. Enter new URL: `localhost:8080`
4. Click Apply

### Step 4: Export Patched SWF

1. **File → Export → SWF**
2. Name: `client_patched.swf`
3. Choose compression: ZLIB

### Step 5: Test Patched Client

1. Open patched SWF in Flash Player
2. Monitor network connections
3. Verify it connects to new URL

---

## Tutorial 7: Batch Processing Multiple SWFs

**Goal**: Decompile and analyze multiple SWF files at once.

**Time**: 15 minutes

### Step 1: Prepare Files

Organize SWFs in a folder:
```
D:\evony_swfs\
├── client_v1.swf
├── client_v2.swf
├── client_v3.swf
└── ...
```

### Step 2: Create Batch Job

1. **Tools → Batch Operations**
2. Click "Add Folder"
3. Select `D:\evony_swfs`

### Step 3: Configure Operations

Select operations to perform:
- ☑ Decompile scripts
- ☑ Export images
- ☐ Export sounds
- ☑ Generate reports

### Step 4: Set Output Structure

```
Output: D:\evony_output\
Structure:
  ☑ Separate folders per SWF
  ☐ Combined output
```

### Step 5: Run Batch

1. Click **Start Batch**
2. Monitor progress in console
3. Review results when complete

---

## Tutorial 8: Version Comparison

**Goal**: Compare two versions of Evony client to find changes.

**Time**: 20 minutes

### Step 1: Load Both Versions

1. **File → Compare SWFs**
2. Select old version: `client_v1.swf`
3. Select new version: `client_v2.swf`

### Step 2: Run Comparison

1. Click **Compare**
2. Wait for analysis

### Step 3: Review Changes

The comparison report shows:
- Added classes
- Removed classes
- Modified methods
- Changed constants
- New assets

### Step 4: Export Diff Report

1. **File → Export → Comparison Report**
2. Choose format: Markdown or HTML
3. Save for documentation

---

## Tutorial 9: Setting Up Protocol Capture

**Goal**: Capture live Evony network traffic for analysis.

**Time**: 25 minutes

### Step 1: Configure Proxy

1. **Tools → Protocol → Start Capture**
2. Configure proxy:
   - Listen Port: 8888
   - Target: svr12.evony.com:443
   - SSL: Enabled

### Step 2: Configure Client

Set your system or browser proxy:
- Host: 127.0.0.1
- Port: 8888

### Step 3: Install SSL Certificate

1. Export proxy certificate
2. Install in system trust store
3. Or configure Flash to accept

### Step 4: Capture Traffic

1. Start Evony client
2. Watch packets appear in capture window
3. AMF messages are auto-decoded

### Step 5: Analyze Captures

1. Click any message to decode
2. View request/response pairs
3. Export for documentation

---

## Tutorial 10: Building a Complete Bot Framework

**Goal**: Set up a full bot development environment.

**Time**: 45 minutes

### Step 1: Install Dependencies

```powershell
pip install git+https://github.com/sonya75/pyEvony.git
pip install pysocks stem  # For Tor
```

### Step 2: Configure Accounts

1. Use SOL Manager to extract credentials
2. Create `accounts.yaml`:
   ```yaml
   accounts:
     - username: player1
       password_md5: abc123...
       server: svr12.evony.com
     - username: player2
       ...
   ```

### Step 3: Create Bot Configuration

1. **File → New → Bot Configuration**
2. Set farming parameters
3. Configure timing and safety

### Step 4: Write Bot Logic

Use the Script Editor to create:
- Main farming script
- City management script
- Hero training script

### Step 5: Test with Single Account

1. Enable dry-run mode
2. Monitor console output
3. Verify commands are correct

### Step 6: Deploy Multi-Account

1. Configure Tor rotation
2. Set account delays
3. Launch bot manager

---

## Next Steps

After completing these tutorials:

1. Read `USER_GUIDE.md` for complete reference
2. Explore `DEVELOPER_GUIDE.md` for advanced usage
3. Join community for support
4. Contribute improvements back!

---

## Related Documentation

- `QUICK_START.md` - Fast setup
- `USER_GUIDE.md` - Complete guide
- `BOT_SCRIPTING.md` - Script reference
- `CLI_REFERENCE.md` - Command line

---

*Document Version: 1.0.0 | Tutorials Collection*
