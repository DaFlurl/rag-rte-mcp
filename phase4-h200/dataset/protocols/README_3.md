# Evony Master Hub - Unified Exploitation Framework

> **All toolkits merged into one seamless interface with GUI, automation, and AutoEvony integration**

## ⚡ QUICK START

### Option 1: Double-click launcher
```
RUN_EVONY_HUB.bat
```

### Option 2: GUI Mode (Recommended)
```bash
python -m evony_hub.gui
```

### Option 3: Script Server Only
```bash
python -m evony_hub.server
```

### Option 4: Full Automation
```bash
python -m evony_hub.automation
```

---

## 🎯 Integrated Toolkits

| Toolkit | Status | Features |
|---------|--------|----------|
| **evony_hub** | ✅ Core | Automation, organization, indexing |
| **BorgToolkit** | ✅ Merged | Script server, exploits, 301+ commands |
| **EvonyCommandCenter** | ✅ Linked | 352 commands, script studio |
| **EvonyMasterSuite** | ✅ Linked | Browser controller, protocol injector |
| **EvonyMegaToolkit** | ✅ Linked | Script server, GUI toolkit |
| **FlashBrowser** | ✅ Linked | Flash-enabled browser |
| **flash_toolkit_v2** | ✅ Linked | Analysis tools, diagrams |

---

## 🖥️ GUI Tabs

| Tab | Description |
|-----|-------------|
| 📊 Dashboard | Status, quick launch, keys |
| 🚀 Script Server | Start server, AutoEvony commands |
| 💀 Exploits | Overflow calculator, all thresholds |
| 📡 Protocol | 352+ command reference |
| 📜 Scripts | 166+ bot scripts |
| 🔐 Crypto | Encryption keys, signatures |
| 🔧 Tools | Launch external tools |

---

## 📁 File Structure

```
evony_hub/
├── gui.py              ← Unified GUI (7 tabs)
├── server.py           ← Script server (port 8088)
├── automation.py       ← Full automation controller
├── scheduler.py        ← Task scheduling
├── main.py             ← Console menu
├── borg_toolkit.py     ← 301+ protocol commands
├── exploit_discovery.py ← Exploit scanner
├── glitch_calculator.py ← Overflow calculator
├── watcher.py          ← File watcher
├── indexer.py          ← File indexing
├── organizer.py        ← Auto-organization
├── config.py           ← Configuration
└── diagrams/
    └── ARCHITECTURE.md ← System diagram
```

---

## Components

| Module | Purpose |
|--------|---------|
| `gui.py` | **Unified GUI** with Dashboard, Server, Exploits, Protocol, Scripts, Crypto, Tools tabs |
| `server.py` | Integrated script server for AutoEvony (port 8088) |
| `main.py` | Unified entry point with interactive menu |
| `automation.py` | Full automation controller |
| `scheduler.py` | Task scheduling for periodic operations |
| `watcher.py` | File watcher for auto-organization |
| `borg_toolkit.py` | Core exploitation toolkit |
| `exploit_discovery.py` | Automated exploit scanner |
| `glitch_calculator.py` | Integer overflow calculator |
| `protocol_exploiter.py` | Protocol manipulation |
| `indexer.py` | File indexing system |
| `organizer.py` | Auto file organization |
| `scanner.py` | Directory scanner |
| `config.py` | Central configuration |

---

## Automation Features

### File Watcher
- Monitors `data/` inbox folder
- Auto-organizes new files by category
- Runs continuously in background

### Task Scheduler
- Periodic re-indexing (hourly)
- Auto-organize inbox (every 5 min)
- Report generation (every 6 hours)

### Script Server
- HTTP server on port 8088
- Serves exploit scripts to AutoEvony
- Dynamic script generation

---

## Usage Modes

### 1. Interactive Menu
```bash
python -m evony_hub.main
```
Provides menu for:
- Show hub status
- Start/stop services
- Run scans
- Generate reports
- Overflow calculator

### 2. Full Automation
```bash
python -m evony_hub.automation
```
Starts all services:
- File watcher
- Task scheduler
- Script server

### 3. Server Only
```bash
python -m evony_hub.main --server
```
Just the script server for AutoEvony.

### 4. Background Daemon
```bash
python -m evony_hub.main --daemon
```
Run as background service.

### 5. Generate Report
```bash
python -m evony_hub.main --report
```
Generate exploitation report.

### 6. Run Scan
```bash
python -m evony_hub.main --scan
```
Run exploit discovery scan.

---

## AutoEvony Integration

When script server is running:

```
includeurl http://localhost:8088/epic/overflow_chain
includeurl http://localhost:8088/epic/infinite_resources
includeurl http://localhost:8088/epic/race_blitz
includeurl http://localhost:8088/epic/full_auto
```

---

## File Organization

Drop files in `data/` folder - they will be auto-organized:

| Category | Extensions | Keywords |
|----------|------------|----------|
| Docs | .md, .txt, .pdf | guide, doc, readme |
| Scripts | .txt, .re, .rob | script, glitch, farm |
| Tools | .py, .ps1, .bat | tool, analyzer |
| Source | .as, .swf | source, decompiled |
| Exploits | .py, .txt | exploit, glitch, vuln |
| Data | .json, .xml, .csv | data, config |

---

## Configuration

Edit `config.py`:

```python
HUB_ROOT = Path(r"c:\Users\Admin\Downloads\Evony_Decrypted")
DATA_INBOX = HUB_ROOT / "data"

EXTERNAL_SOURCES = [
    Path(r"D:\Svony_Studio"),
    # Add more paths to scan
]
```

---

## Reports Generated

| Report | Location |
|--------|----------|
| Exploit Report | `evony_hub/exploit_report.json` |
| Full Report | `evony_hub/full_report.json` |
| Scheduler Report | `evony_hub/scheduler_report.json` |
| Toolkit Export | `evony_hub/borg_toolkit_export.json` |

---

## Requirements

```bash
pip install schedule  # For scheduler
```

Optional:
```bash
pip install pyamf     # For AMF protocol
pip install colorama  # For colored output
```

---

*Evony Hub v2.0 - Complete Automation Framework*
