# Svony Studio - User Guide

> **"Resistance is Futile"** - A Complete Guide to Using Svony Studio

---

## Table of Contents

1. [Getting Started](#getting-started)
2. [Interface Overview](#interface-overview)
3. [Loading SWF Files](#loading-swf-files)
4. [Using the SOL Manager](#using-the-sol-manager)
5. [Borg Mode Analysis](#borg-mode-analysis)
6. [Working with Scripts](#working-with-scripts)
7. [Asset Browser](#asset-browser)
8. [Search Features](#search-features)
9. [Quick Patches](#quick-patches)
10. [Keyboard Shortcuts](#keyboard-shortcuts)
11. [Configuration](#configuration)

---

## Getting Started

### System Requirements

- **OS:** Windows 10/11
- **Python:** 3.10 or higher
- **RAM:** 4GB minimum, 8GB recommended
- **Disk:** 500MB free space

### Required External Tools

| Tool | Purpose | Download |
|------|---------|----------|
| FFDec (JPEXS) | SWF decompilation | [github.com/jindrapetrik/jpexs-decompiler](https://github.com/jindrapetrik/jpexs-decompiler) |
| Java 8+ | FFDec runtime | [java.com](https://www.java.com/) |

### Optional Tools

| Tool | Purpose | Download |
|------|---------|----------|
| SWFTools | Additional analysis | [swftools.org](http://www.swftools.org/) |
| Ruffle | Flash emulation | [ruffle.rs](https://ruffle.rs/) |
| Flash Player | Native playback | [Adobe Archive](https://www.adobe.com/support/flashplayer/debug_downloads.html) |

### Installation

```powershell
# 1. Extract Svony Studio
Expand-Archive svony_studio.zip -DestinationPath D:\EvonyToolKit\

# 2. Navigate to directory
cd D:\EvonyToolKit\svony_studio

# 3. Run the launcher
.\run.ps1
```

The launcher will:
- Create a Python virtual environment
- Install required dependencies
- Launch Svony Studio

---

## Interface Overview

Svony Studio uses a Borg-themed dark interface with the following panels:

```
┌────────────────────────────────────────────────────────────────┐
│  ⬢ Svony Studio - Resistance is Futile              [─][□][×] │
├────────────────────────────────────────────────────────────────┤
│  File  Edit  View  Tools  ⬢ Evony  Help                       │
├────────────────────────────────────────────────────────────────┤
│  [📁][💾][📂] │ [🔧][▶️][🔄][📊] │ [🔑][📜][🎨][🔍] │ [⬢ Borg] │
├──────────────┬─────────────────────────────────┬───────────────┤
│              │                                 │               │
│   Project    │     Overview │ Scripts │ ...   │  SOL Manager  │
│   Explorer   │                                 │               │
│              │  ┌─────────────────────────┐   │  [Scan]       │
│  📁 Project  │  │                         │   │               │
│   └ 📄 swf   │  │    Main Content Area    │   │  Accounts:    │
│   └ 📄 sol   │  │                         │   │  ├ user1      │
│              │  │                         │   │  └ user2      │
│              │  └─────────────────────────┘   │               │
├──────────────┴─────────────────────────────────┴───────────────┤
│  Ready │ EvonyClient.swf │ Mem: 124 MB │ v1.0.0               │
└────────────────────────────────────────────────────────────────┘
```

### Main Panels

| Panel | Location | Purpose |
|-------|----------|---------|
| Project Explorer | Left | Browse project files and SWFs |
| Tab View | Center | Overview, Scripts, Assets, Search, Console |
| SOL Manager | Right | Manage Flash cookies and accounts |
| Status Bar | Bottom | Status, current file, memory usage |

---

## Loading SWF Files

### Method 1: File Menu
1. Click **File → Load SWF** (or press `Ctrl+L`)
2. Navigate to your SWF file
3. Click **Open**

### Method 2: Drag and Drop
- Drag a `.swf` file directly onto the application window

### Method 3: Toolbar
- Click the **📂 Load SWF** button in the toolbar

### After Loading

Once a SWF is loaded, you'll see:
- **Overview Tab:** File info, compression, tag counts
- **Scripts Tab:** Decompiled ActionScript code
- **Assets Tab:** Images, sounds, fonts
- **Console Tab:** Analysis log output

---

## Using the SOL Manager

The SOL Manager helps you find and manage Flash Local Shared Objects (cookies) containing game accounts.

### Scanning for SOL Files

1. Click **Scan** in the SOL Manager panel
2. Svony Studio searches common locations:
   - `%APPDATA%\Macromedia\Flash Player\#SharedObjects\`
   - All subdirectories for Evony domains

### Account List

Found accounts display:
- **Username**
- **Server**
- **Last Login**
- **Status** (active/inactive)

### Account Actions

Right-click an account for options:
- **Edit** - Modify account data
- **Export JSON** - Save as JSON file
- **Copy Username** - Copy to clipboard
- **Copy Password** - Copy to clipboard (use responsibly!)
- **Launch Bot** - Start automation (if bot SWF loaded)

### Account Details

Select an account to view detailed information:
- Server IP/hostname
- Player ID
- Alliance information
- Settings and preferences

---

## Borg Mode Analysis

**Borg Mode** (`Ctrl+B`) is a comprehensive analysis that "assimilates" all information from your SWF file.

### What Borg Mode Does

1. **SharedObject Scanner** - Finds all SOL references
2. **Network Endpoint Extractor** - Lists API calls and server URLs
3. **Crypto Function Mapper** - Identifies encryption/hashing
4. **Class Structure Analysis** - Maps Evony-specific classes
5. **Protocol Documentation** - Documents communication format

### Running Borg Mode

1. Load a SWF file
2. Press `Ctrl+B` or click **Evony → ⬢ Borg Mode**
3. Watch the Console tab for progress
4. Results appear in the Overview tab

### Borg Mode Output

```
⬢ BORG MODE ANALYSIS
────────────────────
Target: EvonyClient.swf
Status: Assimilation Complete

SharedObjects Found: 3
  - cevony_sol (credentials)
  - settings_sol (preferences)
  - cache_sol (game data)

Network Endpoints: 12
  - svr1.evony.com:443 (game server)
  - api.evony.com/login (authentication)
  ...

Crypto Functions: 4
  - MD5 (password hashing)
  - Base64 (encoding)
  ...

⬢ Resistance is Futile
```

---

## Working with Scripts

### Scripts Tab

The Scripts tab displays decompiled ActionScript code from the SWF.

### Script List

- **Package Structure** - Organized by package (com.evony.*, etc.)
- **Search Filter** - Find scripts by name
- **Sort Options** - Alphabetical, by size, by type

### Viewing Scripts

1. Click a script in the list
2. Code displays in the editor pane
3. Syntax highlighting shows:
   - **Green:** Keywords
   - **Cyan:** Strings
   - **Orange:** Functions
   - **Gray:** Comments

### Script Actions

- **Copy** (`Ctrl+C`) - Copy selected code
- **Save** - Export individual script
- **Find** (`Ctrl+F`) - Search within script

---

## Asset Browser

### Accessing Assets

Click the **Assets** tab or press `F4`.

### Asset Categories

| Category | Contents |
|----------|----------|
| Images | PNG, JPG, vector graphics |
| Sounds | MP3, event sounds |
| Fonts | Embedded fonts |
| Binary | XML, config files, nested SWFs |

### Filtering

Use the filter buttons to show only specific types:
- **All** - Show everything
- **Images** - Graphics only
- **Sounds** - Audio only
- **Fonts** - Font definitions
- **Binary** - Data files

### Previewing Assets

- **Images:** Thumbnail preview in grid
- **Sounds:** Click to play (if supported)
- **Fonts:** Sample text preview
- **Binary:** Hex view or text preview

### Exporting Assets

**Single Asset:**
1. Right-click the asset
2. Select **Export**
3. Choose save location

**Batch Export:**
1. **Tools → Export Images** (all images)
2. **Tools → Export Sounds** (all audio)
3. **Tools → Export All** (everything)

---

## Search Features

### Global Search

Press `Ctrl+F` to open the search dialog.

### Search Options

| Option | Description |
|--------|-------------|
| **Text** | Plain text search |
| **Regex** | Regular expression pattern |
| **Case Sensitive** | Match case exactly |
| **Whole Word** | Match complete words only |

### Search Scope

- **Scripts** - ActionScript code
- **Strings** - String constants
- **Class Names** - Class/package names
- **All** - Everything

### Search Results

Results display in the Search tab with:
- File/script name
- Line number
- Matching text (highlighted)

Click a result to jump to that location.

---

## Quick Patches

The **Evony → Quick Patches** menu provides common modifications.

### Available Patches

| Patch | Effect |
|-------|--------|
| **Patch Server URL** | Redirect to custom server |
| **Disable Version Check** | Skip version validation |
| **Enable Debug Mode** | Activate verbose logging |
| **Remove Ads** | Disable advertisement loading |

### Applying a Patch

1. Load the target SWF
2. Select **Evony → Quick Patches → [Patch Name]**
3. Enter required values (if prompted)
4. Save the modified SWF

### Custom Patches

For advanced modifications, use FFDec directly:
1. **Tools → Open in FFDec** (`F5`)
2. Make changes in FFDec
3. Export modified SWF

---

## Keyboard Shortcuts

### File Operations

| Shortcut | Action |
|----------|--------|
| `Ctrl+N` | New Project |
| `Ctrl+O` | Open Project |
| `Ctrl+S` | Save Project |
| `Ctrl+L` | Load SWF |
| `Alt+F4` | Exit |

### Edit Operations

| Shortcut | Action |
|----------|--------|
| `Ctrl+Z` | Undo |
| `Ctrl+Y` | Redo |
| `Ctrl+F` | Find |
| `Ctrl+H` | Replace |
| `Ctrl+A` | Select All |

### View/Navigation

| Shortcut | Action |
|----------|--------|
| `F2` | SOL Manager |
| `F3` | Script Editor |
| `F4` | Asset Browser |
| `F12` | Console |
| `Ctrl+1-5` | Switch tabs |

### Tools

| Shortcut | Action |
|----------|--------|
| `F5` | Open in FFDec |
| `F6` | Run in Flash Player |
| `F7` | Run in Ruffle |
| `F8` | Refresh SWF |
| `F9` | Analyze SWF |

### Evony-Specific

| Shortcut | Action |
|----------|--------|
| `Ctrl+B` | **⬢ Borg Mode** |
| `Ctrl+K` | Scan Accounts |
| `Ctrl+E` | Class Browser |
| `Ctrl+P` | Protocol Docs |
| `Ctrl+M` | Bot Scripts |

---

## Configuration

### Settings Location

Configuration is stored in:
```
%APPDATA%\SvonyStudio\config.json
```

### Configuring Tool Paths

1. Go to **Tools → Configure Tools**
2. Set paths for:
   - FFDec (ffdec.bat)
   - SWFTools directory
   - Flash Player executable
   - Ruffle executable

### Appearance Settings

1. Go to **File → Settings**
2. Adjust:
   - Theme (Borg default)
   - Font family and size
   - Panel layout

### Project Defaults

Configure default settings for new projects:
- Default export directory
- Auto-analyze on load
- Recent project count

---

## Tips & Best Practices

### Performance

- **Large SWFs:** Decompilation may take time; watch the status bar
- **Memory:** Close unused tabs to free memory
- **Batch Operations:** Use FFDec CLI for bulk processing

### Workflow

1. Create a project for each game version
2. Use Borg Mode first to get an overview
3. Export scripts for offline analysis
4. Keep original SWFs backed up

### Security

- SOL files may contain passwords (usually hashed)
- Don't share exported account data
- Use Svony Studio responsibly and ethically

---

*Need more help? Check the [FAQ](FAQ.md) or [Troubleshooting](TROUBLESHOOTING.md) guides.*

*Document Version: 1.0.0 | Last Updated: January 2026*
