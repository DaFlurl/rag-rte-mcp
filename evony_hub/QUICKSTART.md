# Evony Master Hub - Quick Start Guide

## 🚀 Fastest Way to Start

### Option 1: GUI
```bash
cd C:\Users\Admin\Downloads\Evony_Decrypted
python -m evony_hub.gui
```

### Option 2: Double-click
```
RUN_EVONY_HUB.bat → Select "1. GUI Mode"
```

---

## 📡 Start Script Server for AutoEvony

```bash
python -m evony_hub.server
```

Then in AutoEvony Script tab:
```
includeurl http://localhost:8088/epic/overflow_chain
```

---

## 💀 Quick Exploits

### Archer Overflow (Most Common)
```
train a:6135037
sleep 500
cleartroopqueues
```

### All Troops Overflow
```
includeurl http://localhost:8088/epic/overflow_chain
```

### Full Automation Loop
```
includeurl http://localhost:8088/epic/full_auto
```

---

## 🔑 Key Values

| Key | Value |
|-----|-------|
| ACTION_KEY | `TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}` |
| API_KEY | `9f758e2deccbe6244f734371b9642eda` |
| XOR_KEY | `0xAA` (170) |

---

## 📊 Overflow Thresholds

| Troop | Threshold | Script |
|-------|-----------|--------|
| Archer | 6,135,037 | `train a:6135037` |
| Worker | 42,949,673 | `train wo:42949673` |
| Catapult | 715,828 | `train c:715828` |

**After each:** `cleartroopqueues`

---

## 🔧 Launch Other Tools

From GUI Tools tab or manually:

| Tool | Command |
|------|---------|
| FlashBrowser | `FlashBrowser\FlashBrowser.exe` |
| Command Center | `python EvonyCommandCenter\evony_command_center.py` |
| Master Suite | `python EvonyMasterSuite\master_suite.py` |

---

## 📁 Key Locations

```
C:\Users\Admin\Downloads\Evony_Decrypted\
├── RUN_EVONY_HUB.bat     ← Main launcher
├── evony_hub\            ← Master hub
├── BorgToolkit\          ← Scripts & docs
├── FlashBrowser\         ← Flash browser
└── Scripts\              ← Bot scripts
```

---

*For full documentation see `README.md` and `diagrams/ARCHITECTURE.md`*
