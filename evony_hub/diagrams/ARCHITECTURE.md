# Evony Master Hub - Architecture Diagram

## Unified System Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        EVONY MASTER HUB                                      │
│                   Unified Exploitation Framework                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                         GUI (gui.py)                                  │   │
│  │  ┌─────────┬─────────┬─────────┬─────────┬─────────┬─────────┬─────┐│   │
│  │  │Dashboard│ Server  │Exploits │Protocol │ Scripts │ Crypto  │Tools││   │
│  │  │   📊    │   🚀    │   💀    │   📡    │   📜    │   🔐    │ 🔧  ││   │
│  │  └─────────┴─────────┴─────────┴─────────┴─────────┴─────────┴─────┘│   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                    │                                         │
│                                    ▼                                         │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                      CORE MODULES                                     │   │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐               │   │
│  │  │  server.py   │  │automation.py │  │ scheduler.py │               │   │
│  │  │  Port 8088   │  │ Full Control │  │ Task Cron    │               │   │
│  │  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘               │   │
│  │         │                 │                 │                        │   │
│  │         ▼                 ▼                 ▼                        │   │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐               │   │
│  │  │borg_toolkit  │  │  watcher.py  │  │  indexer.py  │               │   │
│  │  │ 301+ cmds    │  │ File Monitor │  │ File Index   │               │   │
│  │  └──────────────┘  └──────────────┘  └──────────────┘               │   │
│  │                                                                       │   │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐               │   │
│  │  │exploit_disc  │  │glitch_calc   │  │ organizer.py │               │   │
│  │  │ Vuln Scan    │  │ Overflow     │  │ Auto-Org     │               │   │
│  │  └──────────────┘  └──────────────┘  └──────────────┘               │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
└──────────────────────────────────┬──────────────────────────────────────────┘
                                   │
                                   ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                        LINKED TOOLKITS                                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │   BorgToolkit   │  │EvonyCommandCtr  │  │EvonyMasterSuite │             │
│  │  Scripts/Docs   │  │  352 Commands   │  │Browser Control  │             │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘             │
│                                                                              │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │EvonyMegaToolkit │  │  FlashBrowser   │  │ flash_toolkit   │             │
│  │  Alt GUI        │  │  .exe Browser   │  │  Analysis       │             │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘             │
│                                                                              │
└──────────────────────────────────┬──────────────────────────────────────────┘
                                   │
                                   ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                         AUTOEVONY BOT                                        │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  includeurl http://localhost:8088/epic/overflow_chain                       │
│  includeurl http://localhost:8088/epic/infinite_resources                   │
│  includeurl http://localhost:8088/epic/race_blitz                           │
│  includeurl http://localhost:8088/epic/full_auto                            │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Data Flow

```
┌──────────────┐     HTTP      ┌──────────────┐     AMF      ┌──────────────┐
│  AutoEvony   │◄─────────────►│ Script Server│◄────────────►│ Evony Server │
│     Bot      │  Port 8088    │  (server.py) │   Protocol   │   (Game)     │
└──────────────┘               └──────────────┘               └──────────────┘
       │                              │
       │ includeurl                   │ Exploit Scripts
       ▼                              ▼
┌──────────────┐               ┌──────────────┐
│  Script Tab  │               │   Exploits   │
│  in Bot      │               │ overflow_chain│
└──────────────┘               │ infinite_res │
                               │ race_blitz   │
                               └──────────────┘
```

---

## File Structure

```
c:\Users\Admin\Downloads\Evony_Decrypted\
│
├── RUN_EVONY_HUB.bat          ← Main launcher
│
├── evony_hub/                  ← MASTER HUB
│   ├── __init__.py
│   ├── __main__.py
│   ├── gui.py                  ← Unified GUI (7 tabs)
│   ├── server.py               ← Script server (port 8088)
│   ├── automation.py           ← Full automation
│   ├── scheduler.py            ← Task scheduling
│   ├── main.py                 ← Console menu
│   ├── borg_toolkit.py         ← 301+ protocol commands
│   ├── exploit_discovery.py    ← Exploit scanner
│   ├── glitch_calculator.py    ← Overflow calculator
│   ├── watcher.py              ← File watcher
│   ├── indexer.py              ← File indexing
│   ├── organizer.py            ← Auto-organization
│   ├── config.py               ← Configuration
│   ├── README.md
│   ├── run_gui.bat
│   └── diagrams/
│       └── ARCHITECTURE.md     ← This file
│
├── BorgToolkit/                ← Original toolkit
│   ├── scripts/
│   ├── docs/
│   ├── diagrams/
│   └── advanced_server.py
│
├── EvonyCommandCenter/         ← 352 commands GUI
├── EvonyMasterSuite/           ← Browser integration
├── EvonyMegaToolkit/           ← Alternative GUI
├── FlashBrowser/               ← Flash browser exe
├── flash_toolkit_v2/           ← Analysis tools
│
├── AS3_Scripts_(EvonyClient1921.swf)/   ← Client source
├── AS3_Scripts_(AutoEvony2_NEW.swf)/    ← Bot source
├── Scripts/                     ← 166+ bot scripts
├── Tools/                       ← FFDEC, Ghidra, etc.
└── SOL_Accounts/               ← Flash cookies
```

---

## Launch Options

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          LAUNCH OPTIONS                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  1. RUN_EVONY_HUB.bat                                                       │
│     └─► Menu: GUI / Server / Automation / Console                           │
│                                                                              │
│  2. python -m evony_hub.gui                                                 │
│     └─► Full graphical interface with 7 tabs                                │
│                                                                              │
│  3. python -m evony_hub.server                                              │
│     └─► Script server only (port 8088)                                      │
│                                                                              │
│  4. python -m evony_hub.automation                                          │
│     └─► Watcher + Server + Scheduler                                        │
│                                                                              │
│  5. python -m evony_hub.main                                                │
│     └─► Interactive console menu                                            │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Encryption Keys

```
ACTION_KEY    = TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}
API_KEY       = 9f758e2deccbe6244f734371b9642eda
USER_INFO_KEY = IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}
XOR_KEY       = 0xAA (170)
LOGIN_SALT    = evony
GAME_KEY      = EvonyGameKey2009
NETWORK_KEY   = EvonyNetKey2009
```

---

## Overflow Thresholds

```
INT32_MAX = 2,147,483,647

Troop        Cost    Threshold      Script
─────────────────────────────────────────────
Worker        50    42,949,673     train wo:42949673
Warrior       75    28,633,116     train wa:28633116
Scout        100    21,474,837     train sc:21474837
Pikeman      200    10,737,419     train pi:10737419
Swordsman    250     8,589,935     train sw:8589935
Archer       350     6,135,037     train a:6135037
Cavalry      800     2,684,355     train cav:2684355
Cataphract  1500     1,431,656     train cata:1431656
Transporter  300     7,158,279     train tr:7158279
Ballista    2000     1,073,742     train ba:1073742
Ram         2500       858,994     train r:858994
Catapult    3000       715,828     train c:715828
```

---

*Last Updated: 2026-01-03*
