# Svony Studio - Quick Start Guide

> **"Resistance is Futile"** - Get Assimilated in 5 Minutes

---

## Prerequisites

Before starting, ensure you have:

- **Windows 10/11** (64-bit)
- **Python 3.10+** ([Download](https://python.org))
- **Java 8+** ([Download](https://adoptium.net)) - Required for FFDec
- **FFDec** ([Download](https://github.com/jindrapetrik/jpexs-decompiler)) - Flash decompiler

---

## Installation

### 1. Download Svony Studio

```powershell
# Option A: Clone from GitHub
git clone https://github.com/Ghenghis/Svony-Studio.git
cd Svony-Studio

# Option B: Download ZIP and extract
# Extract to D:\svony_studio
```

### 2. Install Dependencies

```powershell
# Create virtual environment
python -m venv .venv

# Activate it
.\.venv\Scripts\activate

# Install requirements
pip install -r requirements.txt
```

### 3. Run Svony Studio

```powershell
# Using the run script
.\run.ps1

# Or directly
python main.py
```

---

## First Launch

### Configure Tools

On first launch, configure paths to external tools:

1. **File → Settings** (or press `Ctrl+,`)
2. Set **FFDec Path**: `C:\Program Files\FFDec\ffdec.bat`
3. Set **Java Path**: `C:\Program Files\Java\jdk-21\bin\java.exe`
4. Click **Save**

### Create a Project

1. **File → New Project** (`Ctrl+N`)
2. Enter project name: `MyEvonyAnalysis`
3. Select location: `D:\Projects\`
4. Click **Create**

---

## Loading SWF Files

### Method 1: Drag and Drop

Simply drag any `.swf` file onto the main window.

### Method 2: Menu

1. **File → Load SWF** (`Ctrl+L`)
2. Navigate to your SWF file
3. Select and click **Open**

### Supported Files

- `EvonyClient.swf` - Main game client
- `AutoEvony2_NEW.swf` - AutoEvony bot
- `RoboEvony.swf` - RoboEvony bot

---

## Quick Tasks

### Scan for Accounts (SOL)

1. Press `F2` or **View → SOL Manager**
2. Click **⟳ Scan**
3. View discovered accounts
4. Click an account to see details

### View Decompiled Scripts

1. Press `F3` or **View → Script Editor**
2. Browse the class tree on the left
3. Click a script to view its code
4. Use `Ctrl+F` to search within scripts

### Export Assets

1. **Tools → Export Images** (or Sounds, Scripts)
2. Select output directory
3. Click **Export**
4. Find files in your project's `exports/` folder

---

## Borg Mode (Full Analysis)

For comprehensive analysis:

1. Press `Ctrl+B` or click **⬢ Borg** button
2. Wait for analysis to complete
3. Review the assimilation report in console

Borg Mode automatically:
- Scans all SOL files for accounts
- Decompiles loaded SWF files
- Extracts all strings and constants
- Maps network endpoints
- Identifies crypto patterns
- Generates full report

---

## Common Workflows

### Workflow 1: Account Recovery

```
1. Launch Svony Studio
2. Press F2 (SOL Manager)
3. Click "Scan"
4. Select account
5. Click "Export JSON" or "Copy Login"
```

### Workflow 2: Client Analysis

```
1. File → Load SWF (EvonyClient.swf)
2. View → Script Editor (F3)
3. Search for "SharedObject"
4. Analyze credential handling
```

### Workflow 3: Bot Script Viewing

```
1. File → Load SWF (AutoEvony2_NEW.swf)
2. View → Script Editor (F3)
3. Navigate to autoevony.cmds
4. View command implementations
```

---

## Keyboard Shortcuts

| Action | Shortcut |
|--------|----------|
| New Project | `Ctrl+N` |
| Open Project | `Ctrl+O` |
| Save Project | `Ctrl+S` |
| Load SWF | `Ctrl+L` |
| Borg Mode | `Ctrl+B` |
| SOL Manager | `F2` |
| Script Editor | `F3` |
| Asset Browser | `F4` |
| Open in FFDec | `F5` |
| Run Flash Player | `F6` |
| Run Ruffle | `F7` |
| Console | `F12` |
| Settings | `Ctrl+,` |
| Find | `Ctrl+F` |

---

## Troubleshooting

### "FFDec not found"

1. Download FFDec from the official site
2. Install/extract to a known location
3. Set path in Settings → Tools → FFDec Path

### "Java not found"

1. Install Java 8 or later
2. Set JAVA_HOME environment variable
3. Or set path in Settings → Tools → Java Path

### "No accounts found"

- Ensure Flash Player was used with Evony
- Check default SOL paths in Settings
- Try manual path: `%APPDATA%\Macromedia\Flash Player\#SharedObjects\`

### Application won't start

```powershell
# Check Python version
python --version  # Should be 3.10+

# Reinstall dependencies
pip install -r requirements.txt --force-reinstall
```

---

## Next Steps

- Read the **USER_GUIDE.md** for detailed features
- Explore **ARCHITECTURE.md** for technical details
- Check **docs/evony/** for Evony-specific info
- View **docs/diagrams/** for visual references

---

## Getting Help

- **GitHub Issues**: Report bugs or request features
- **Console Output**: Check `F12` for error messages
- **Log Files**: Check `logs/` directory

---

*Welcome to the Collective. Your distinctiveness will be added to our own.*
