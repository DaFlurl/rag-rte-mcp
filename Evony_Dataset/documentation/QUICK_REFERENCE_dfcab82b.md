# BORG TOOLKIT - Quick Reference

> Cheat sheet for common operations

---

## Start Exploit Server

```bash
cd C:\Users\Admin\Downloads\Evony_Decrypted\BorgToolkit
python advanced_server.py
```

---

## AutoEvony Commands

### Load from Server
```
includeurl http://localhost:8088/epic/overflow_chain
includeurl http://localhost:8088/epic/infinite_resources
includeurl http://localhost:8088/epic/race_blitz
includeurl http://localhost:8088/epic/full_auto
```

### Manual Overflow
```
train a:6135037
sleep 500
cleartroopqueues
```

### Valley Hide
```
reinforce 500,500 any all none
```

### Gold Farm
```
settaxrate 100
levy tax
comfort disaster
```

---

## Overflow Thresholds

| Troop | Command |
|-------|---------|
| Worker | `train wo:42949673` |
| Warrior | `train wa:28633116` |
| Scout | `train sc:21474837` |
| Pikeman | `train pi:10737419` |
| Swordsman | `train sw:8589935` |
| **Archer** | `train a:6135037` |
| Cavalry | `train cav:2684355` |
| Cataphract | `train cata:1431656` |
| Transporter | `train tr:7158279` |
| Ballista | `train ba:1073742` |
| Ram | `train r:858994` |
| Catapult | `train c:715828` |

**After each:** `cleartroopqueues`

---

## Server Endpoints

| Endpoint | Description |
|----------|-------------|
| `/epic/overflow_chain` | All 12 troop overflows |
| `/epic/infinite_resources` | Combined exploits |
| `/epic/race_blitz` | 50 rapid item uses |
| `/epic/full_auto` | Automation loop |
| `/calc/overflow?troop=6` | Calculate threshold |
| `/keys` | Show encryption keys |

---

## Script Syntax

```
// Comments
set variable value
label name
goto name
if condition goto name
sleep milliseconds
echo message
setsilence on|off
```

---

## Troop Abbreviations

| Abbrev | Troop |
|--------|-------|
| wo | Worker |
| wa | Warrior |
| sc | Scout |
| pi | Pikeman |
| sw | Swordsman |
| a | Archer |
| cav | Cavalry |
| cata | Cataphract |
| tr | Transporter |
| ba | Ballista |
| r | Ram |
| c | Catapult |

---

## Encryption Keys

```
ACTION_KEY = TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}
API_KEY = 9f758e2deccbe6244f734371b9642eda
```

---

## Files

| File | Purpose |
|------|---------|
| `advanced_server.py` | Epic exploit server |
| `src/protocol_commands.py` | 301+ commands |
| `src/exploit_engine.py` | Exploit discovery |
| `scripts/discovery/*.txt` | Discovery scripts |

---

*Last Updated: 2026-01-03*
