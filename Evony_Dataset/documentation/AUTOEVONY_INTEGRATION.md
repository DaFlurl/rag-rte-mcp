# AutoEvony Bot Integration Guide

## Overview

AutoEvony has a built-in scripting system that can load scripts from:
1. **Local files** - Using `Load File` button or `includefile`
2. **External URLs** - Using `includeurl http://server/script.txt`
3. **Snippets** - Reusable script fragments in the Snippets tab

The Borg Toolkit leverages this to inject exploit scripts.

---

## Method 1: Local Script Files

Copy scripts from `BorgToolkit/scripts/` to AutoEvony:

```
01_troop_overflow.txt   - Food glitch exploit
02_valley_hide.txt      - Stop food consumption
03_gold_farm.txt        - Automated tax collection
04_item_rapid_use.txt   - Race condition item dupe
05_auto_quest.txt       - Complete all quests
06_amulet_spin.txt      - Amulet gambling
```

### Usage
1. In AutoEvony, go to **Script** tab
2. Click **Load File**
3. Select the `.txt` script file
4. Click **Run**

---

## Method 2: External Script Server (Recommended)

The Borg Toolkit includes a Python HTTP server that serves exploit scripts.

### Start the Server
```bash
cd C:\Users\Admin\Downloads\Evony_Decrypted\BorgToolkit
python script_server.py
```

Server runs on `http://localhost:8088`

### Use in AutoEvony

In the Script tab command box or in a script file:

```
includeurl http://localhost:8088/overflow
```

### Available Scripts

| URL Path | Description |
|----------|-------------|
| `/overflow` | Troop overflow food glitch |
| `/valley_hide` | Hide troops to stop food consumption |
| `/item_dupe` | Race condition item duplication |
| `/gold_farm` | Automated tax collection loop |
| `/auto_quest` | Complete all quests |
| `/amulet_spin` | Rapid amulet gambling |
| `/colony_farm` | Colony resource levying |
| `/help` | List all available scripts |

### Example Script Using External Server

```
// Main script that loads exploits from server
includeurl http://localhost:8088/overflow

// Or chain multiple
includeurl http://localhost:8088/valley_hide
sleep 1000
includeurl http://localhost:8088/gold_farm
```

---

## Method 3: Include from Local File

Use `includefile` to load from local filesystem:

```
includefile file:///C:/Users/Admin/Downloads/Evony_Decrypted/BorgToolkit/scripts/01_troop_overflow.txt
```

---

## AutoEvony Script Syntax Reference

### Variables
```
set myVar 123
set name "hello"
echo $myVar
```

### Control Flow
```
label myloop
// ... commands ...
goto myloop

if condition goto label
if %available.food% > 1000000 goto hasFood
```

### Commands

| Command | Usage | Description |
|---------|-------|-------------|
| `train` | `train a:1000` | Train troops (a=archer, w=warrior) |
| `reinforce` | `reinforce 500,500 any all none` | Send troops to coords |
| `recall` | `recall 500,500` | Recall army from coords |
| `transport` | `transport 500,500 t:1000 f:1000000` | Send resources |
| `useitem` | `useitem player.item.id` | Use an item |
| `levy` | `levy tax` | Collect taxes |
| `settaxrate` | `settaxrate 100` | Set tax rate |
| `comfort` | `comfort disaster` | Pacify population |
| `completequests` | `completequests all` | Complete quests |
| `cleartroopqueues` | `cleartroopqueues` | Cancel troop training |
| `sleep` | `sleep 1000` | Wait (milliseconds) |
| `echo` | `echo message` | Print to log |
| `setsilence` | `setsilence off` | Enable/disable output |

### Troop Abbreviations
```
wo  = worker
wa/warr = warrior
sc  = scout
pi  = pikeman
sw  = swordsman
a   = archer
ca/cav = cavalry
ct/cata = cataphract
tr  = transporter
ba  = ballista
r   = ram
c   = catapult
```

---

## Exploit Scripts Explained

### Troop Overflow (Food Glitch)

The exploit works by:
1. Queue troops above INT32_MAX / cost threshold
2. Server calculates negative resource cost
3. Cancel production
4. Negative refund = resource GAIN

**Thresholds:**
- Archer (cost 350): 6,135,037
- Cavalry (cost 800): 2,684,355
- Cataphract (cost 1500): 1,431,656

### Valley Hiding

Troops stationed in valleys or reinforcing other players don't consume food. This is intended game behavior exploited to avoid upkeep.

### Race Condition Duplication

Send multiple item-use packets before server can decrement inventory. If timing is right, item is used but not consumed.

---

## Security Notes

- The script server only runs locally
- For remote access, configure firewall and use authentication
- AutoEvony supports Basic Auth: `includeurl http://user:pass@server/script`

---

## Troubleshooting

### Script won't load from URL
- Check server is running: `python script_server.py`
- Verify URL is correct: `http://localhost:8088/scriptname`
- Check firewall isn't blocking port 8088

### Commands not working
- Some commands require specific conditions (troops, resources)
- Check the Log tab for error messages
- Use `setsilence off` to see command output

### Train command limited
- AutoEvony may have built-in limits on train commands
- For true overflow, may need to inject via ActionFactory directly
