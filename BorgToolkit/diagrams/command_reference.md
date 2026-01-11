# BORG TOOLKIT - Command Reference Diagram

> Visual reference for all 301+ protocol commands

---

## Command Category Map

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         EVONY COMMAND CATEGORIES                             │
│                              (301+ Commands)                                 │
└─────────────────────────────────────────────────────────────────────────────┘

                              ┌──────────────┐
                              │   ActionFactory   │
                              │   (Central Hub)   │
                              └────────┬─────────┘
                                       │
       ┌───────────────────────────────┼───────────────────────────────┐
       │               │               │               │               │
       ▼               ▼               ▼               ▼               ▼
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│  TROOP   │    │   SHOP   │    │  COMMON  │    │   ARMY   │    │  CASTLE  │
│ Commands │    │ Commands │    │ Commands │    │ Commands │    │ Commands │
├──────────┤    ├──────────┤    ├──────────┤    ├──────────┤    ├──────────┤
│ produce  │    │ buy      │    │ getPackage│   │ newArmy  │    │ newBuild │
│ cancel   │    │ useGoods │    │ mapInfo  │    │ callBack │    │ upgrade  │
│ disband  │    │ buyRes   │    │ chat     │    │ speedUp  │    │ destruct │
│ getQueue │    │ useDevil │    │ getSecurity   │ exercise │    │ speedUp  │
│ acc      │    │ useAngel │    │ changeName│   │ preset   │    │ cancel   │
└──────────┘    └──────────┘    └──────────┘    └──────────┘    └──────────┘
       │               │               │               │               │
       │               │               │               │               │
       ▼               ▼               ▼               ▼               ▼
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│   CITY   │    │  COLONY  │    │   HERO   │    │  QUEST   │    │ ALLIANCE │
│ Commands │    │ Commands │    │ Commands │    │ Commands │    │ Commands │
├──────────┤    ├──────────┤    ├──────────┤    ├──────────┤    ├──────────┤
│ modifyTax│    │ levyRes  │    │ hireHero │    │ getList  │    │ create   │
│ setCommence   │ levyArmy │    │ fireHero │    │ award    │    │ leave    │
│ setTrade │    │ levyTroop│    │ promote  │    │ getAward │    │ kick     │
│ getRes   │    │ saveTax  │    │ addPoint │    │ getEffort│    │ setInfo  │
│ setWarn  │    │ release  │    │ setMayor │    │          │    │ disband  │
└──────────┘    └──────────┘    └──────────┘    └──────────┘    └──────────┘
       │               │               │               │               │
       │               │               │               │               │
       ▼               ▼               ▼               ▼               ▼
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│ INTERIOR │    │  TRADE   │    │   TECH   │    │  REPORT  │    │   MAIL   │
│ Commands │    │ Commands │    │ Commands │    │ Commands │    │ Commands │
├──────────┤    ├──────────┤    ├──────────┤    ├──────────┤    ├──────────┤
│ taxLevy  │    │ newTrade │    │ research │    │ getList  │    │ send     │
│ comfort  │    │ cancel   │    │ cancel   │    │ read     │    │ read     │
│ getPop   │    │ search   │    │ speedUp  │    │ delete   │    │ delete   │
│ setAuto  │    │ getList  │    │ getList  │    │ share    │    │ report   │
└──────────┘    └──────────┘    └──────────┘    └──────────┘    └──────────┘
       │               │               │               │               │
       └───────────────┴───────────────┴───────────────┴───────────────┘
                                       │
                                       ▼
                         ┌─────────────────────────┐
                         │    MORE CATEGORIES      │
                         ├─────────────────────────┤
                         │ • fortifications.*      │
                         │ • equipment.*           │
                         │ • stratagem.*           │
                         │ • truce.*               │
                         │ • rank.*                │
                         │ • friend.*              │
                         │ • commission.*          │
                         │ • capital.*             │
                         │ • visit.*               │
                         │ • npcHero.*             │
                         │ • vote.*                │
                         │ • modify.*              │
                         │ • furlough.*            │
                         │ • gamblingranking.*     │
                         └─────────────────────────┘
```

---

## Exploitable Commands

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        EXPLOIT TARGET COMMANDS                               │
└─────────────────────────────────────────────────────────────────────────────┘

                         ┌───────────────────┐
                         │  EXPLOIT TARGETS  │
                         └─────────┬─────────┘
                                   │
     ┌─────────────────────────────┼─────────────────────────────┐
     │                             │                             │
     ▼                             ▼                             ▼
┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
│  🔴 OVERFLOW     │      │  🟡 RACE COND   │      │  🟢 NEGATIVE    │
│                 │      │                 │      │                 │
│ troop.produce   │      │ shop.useGoods   │      │ shop.buy        │
│ fort.produce    │      │ quest.award     │      │ troop.disband   │
│                 │      │ hero.awardHero  │      │ trade.newTrade  │
│ Param: num      │      │ commission.*    │      │                 │
│ Value: >INT32/c │      │                 │      │ Param: num/amt  │
└─────────────────┘      │ Method: Parallel│      │ Value: negative │
                         └─────────────────┘      └─────────────────┘
         │                        │                        │
         │                        │                        │
         ▼                        ▼                        ▼
┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
│  OVERFLOW CALC  │      │  RACE ATTACK    │      │  NEG INJECTION  │
│                 │      │                 │      │                 │
│ threshold =     │      │ 1. Create 10+   │      │ 1. Send num=-1  │
│ INT32_MAX /     │      │    threads      │      │ 2. Server may   │
│ resource_cost   │      │ 2. Fire all at  │      │    subtract     │
│                 │      │    once         │      │    negative     │
│ Example:        │      │ 3. Some pass    │      │ 3. = Addition   │
│ Archer=6135037  │      │    validation   │      │                 │
└─────────────────┘      └─────────────────┘      └─────────────────┘
```

---

## AutoEvony Script Commands

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      AUTOEVONY SCRIPT COMMAND MAP                            │
└─────────────────────────────────────────────────────────────────────────────┘

┌───────────────────────────────────────────────────────────────────────────┐
│ TROOP COMMANDS                                                            │
├───────────────────────────────────────────────────────────────────────────┤
│ train <type>:<amount>         │ Train troops                             │
│ cleartroopqueues              │ Cancel all training                      │
│ disband <type> <amount>       │ Disband troops                           │
│                               │                                          │
│ Type abbreviations:           │                                          │
│   wo=worker, wa=warrior, sc=scout, pi=pikeman, sw=swordsman              │
│   a=archer, cav=cavalry, cata=cataphract, tr=transporter                 │
│   ba=ballista, r=ram, c=catapult                                         │
└───────────────────────────────────────────────────────────────────────────┘

┌───────────────────────────────────────────────────────────────────────────┐
│ ARMY COMMANDS                                                             │
├───────────────────────────────────────────────────────────────────────────┤
│ attack <x>,<y> <hero> <troops> <waves>                                   │
│ reinforce <x>,<y> <hero> <troops> <resources>                            │
│ scout <x>,<y> <hero> <scouts>                                            │
│ transport <x>,<y> <resources>                                            │
│ recall <x>,<y>                │ Recall army from coords                  │
└───────────────────────────────────────────────────────────────────────────┘

┌───────────────────────────────────────────────────────────────────────────┐
│ RESOURCE COMMANDS                                                         │
├───────────────────────────────────────────────────────────────────────────┤
│ levy tax                      │ Collect taxes                            │
│ levy food                     │ Collect food                             │
│ settaxrate <0-100>            │ Set tax rate                             │
│ comfort <type>                │ Pacify population                        │
│ colony levyfood <id>          │ Levy colony food                         │
│ colony levytax <id>           │ Levy colony taxes                        │
│ colony levyarmy <id>          │ Levy colony troops                       │
└───────────────────────────────────────────────────────────────────────────┘

┌───────────────────────────────────────────────────────────────────────────┐
│ ITEM COMMANDS                                                             │
├───────────────────────────────────────────────────────────────────────────┤
│ useitem <itemId>              │ Use an item                              │
│ getpackage <ruleId> <serial>  │ Claim a package                          │
│ completequests all            │ Complete all quests                      │
└───────────────────────────────────────────────────────────────────────────┘

┌───────────────────────────────────────────────────────────────────────────┐
│ CONTROL FLOW                                                              │
├───────────────────────────────────────────────────────────────────────────┤
│ label <name>                  │ Define jump target                       │
│ goto <name>                   │ Jump to label                            │
│ if <condition> goto <label>   │ Conditional jump                         │
│ set <var> <value>             │ Set variable                             │
│ sleep <ms>                    │ Wait milliseconds                        │
│ echo <message>                │ Print message                            │
│ setsilence on|off             │ Enable/disable output                    │
└───────────────────────────────────────────────────────────────────────────┘

┌───────────────────────────────────────────────────────────────────────────┐
│ EXTERNAL LOADING                                                          │
├───────────────────────────────────────────────────────────────────────────┤
│ includeurl http://server/script.txt    │ Load from HTTP URL              │
│ includefile file:///C:/path/script.txt │ Load from local file            │
│                                                                           │
│ Supports basic auth: includeurl http://user:pass@server/script            │
└───────────────────────────────────────────────────────────────────────────┘
```

---

## Overflow Threshold Quick Reference

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                     OVERFLOW THRESHOLDS (INT32_MAX / COST)                   │
└─────────────────────────────────────────────────────────────────────────────┘

    TROOP          COST       THRESHOLD         SCRIPT COMMAND
    ─────────────────────────────────────────────────────────────────────────
    Worker          50       42,949,673        train wo:42949673
    Warrior         75       28,633,116        train wa:28633116
    Scout          100       21,474,837        train sc:21474837
    Pikeman        200       10,737,419        train pi:10737419
    Swordsman      250        8,589,935        train sw:8589935
    Archer         350        6,135,037        train a:6135037      ◄ COMMON
    Cavalry        800        2,684,355        train cav:2684355
    Cataphract    1500        1,431,656        train cata:1431656
    Transporter    300        7,158,279        train tr:7158279
    Ballista      2000        1,073,742        train ba:1073742
    Ram           2500          858,994        train r:858994
    Catapult      3000          715,828        train c:715828
    ─────────────────────────────────────────────────────────────────────────

    Formula: threshold = (2147483647 / food_cost) + 1

    After queuing, immediately run: cleartroopqueues
    
    Expected gain per overflow: ~2.1 billion resources
```

---

## Server Endpoints Quick Reference

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    BORG SCRIPT SERVER ENDPOINTS                              │
└─────────────────────────────────────────────────────────────────────────────┘

    BASE URL: http://localhost:8088

    EPIC EXPLOITS:
    ─────────────────────────────────────────────────────────────────────────
    /epic/overflow_chain       All 12 troop overflows in sequence
    /epic/infinite_resources   Valley hide + overflow + tax + colony
    /epic/race_blitz           50 rapid item uses (no delays)
    /epic/full_auto            Complete automation loop
    /epic/security_bypass      Common security code enumeration
    /epic/army_clone           Army duplication attempt
    /epic/package_enum         Hidden package discovery
    /epic/help                 List all available scripts
    ─────────────────────────────────────────────────────────────────────────

    CALCULATORS (JSON):
    ─────────────────────────────────────────────────────────────────────────
    /calc/overflow?troop=6     Calculate overflow for troop type
    /calc/all_thresholds       Get all overflow thresholds
    /calc/signature?data=x     Generate packet signature
    ─────────────────────────────────────────────────────────────────────────

    RAW COMMANDS:
    ─────────────────────────────────────────────────────────────────────────
    /api/troop.produceTroop?num=6135037
    /api/shop.useGoods?itemId=player.item.x
    /api/interior.taxLevy
    ─────────────────────────────────────────────────────────────────────────

    OTHER:
    ─────────────────────────────────────────────────────────────────────────
    /keys                      Show encryption keys
    /                          Show index page
    ─────────────────────────────────────────────────────────────────────────
```

---

*Last Updated: 2026-01-03*
*BORG TOOLKIT v2.0*
