# Evony Data Curation Report

Generated: 2026-01-04 20:20:44

## Summary

| Metric | Count |
|--------|-------|
| Total Scanned | 48,671 |
| Evaluated | 24,044 |
| Skipped | 24,627 |
| **Approved for Training** | **8,957** |
| Rejected | 15,087 |

## Quality Distribution

| Rating | Count | Description |
|--------|-------|-------------|
| EXCELLENT | 1,068 | Perfect for training |
| GOOD | 4,537 | Good quality, include |
| ACCEPTABLE | 3,805 | Usable with minor issues |
| POOR | 3,071 | Low quality, needs review |
| JUNK | 11,563 | Do not include |

## Content Types

| Type | Count |
|------|-------|
| source_code | 19,032 |
| keys | 3,997 |
| script | 521 |
| protocol | 223 |
| exploit | 219 |
| personal_note | 52 |


---

## Files Approved for Training

These files passed quality checks and are recommended for the training dataset:

### ✅ `CLIENT_STRUCTURE.md`
- **Path**: `Docs\CLIENT_STRUCTURE.md`
- **Type**: protocol
- **Training Value**: 1.00
- **Keywords**: gold, attack, swf, quest, troop
- **Preview**: # Evony Age II - Client Structure  > **"Inside the Evony Flash Client"** - Architecture and Component Analysis  ---  ## Overview  The Evony Age II Fla...

### ✅ `mega_toolkit.py`
- **Path**: `EvonyMegaToolkit-backup\mega_toolkit.py`
- **Type**: source_code
- **Training Value**: 1.00
- **Keywords**: commission, swf, quest, troop, resource
- **Preview**: # ============================================================================ # EVONY MEGA TOOLKIT - MAIN GUI # =====================================...

### ✅ `duplicates_report.json`
- **Path**: `Evony_Dataset\metadata\duplicates_report.json`
- **Type**: keys
- **Training Value**: 1.00
- **Keywords**: commission, swf, quest, troop, actionscript
- **Preview**: [   {     "hash": "d41d8cd98f00b204e9800998ecf8427e",     "count": 602,     "kept": "c:\\Users\\Admin\\Downloads\\Evony_Decrypted\\BorgToolkit\\data\\...

### ✅ `bot_integration.py`
- **Path**: `Evony_Dataset\tools\bot_integration.py`
- **Type**: source_code
- **Training Value**: 1.00
- **Keywords**: gold, attack, catapult, troop, hero
- **Preview**: # BORG TOOLKIT - AutoEvony Bot Integration """ Integration module for hooking into AutoEvony bot's existing connection.  Instead of creating our own c...

### ✅ `injection.py`
- **Path**: `Evony_Dataset\tools\injection.py`
- **Type**: source_code
- **Training Value**: 1.00
- **Keywords**: gold, commission, attack, quest, catapult
- **Preview**: # BORG TOOLKIT - Packet Injection Module """ Enterprise-grade packet injection for Evony. Uses extracted encryption keys for authenticated packet forg...

### ✅ `protocol.py`
- **Path**: `Evony_Dataset\tools\protocol.py`
- **Type**: source_code
- **Training Value**: 1.00
- **Keywords**: gold, commission, wall, attack, swf
- **Preview**: # ============================================================================ # EVONY MEGA TOOLKIT - COMPLETE PROTOCOL (246 COMMANDS) # =============...

### ✅ `protocol_commands.py`
- **Path**: `Evony_Dataset\tools\protocol_commands.py`
- **Type**: source_code
- **Training Value**: 1.00
- **Keywords**: troop, hero, archer, alliance, resource
- **Preview**: # BORG TOOLKIT - Complete Protocol Command Registry """ ALL 301+ commands extracted from Evony client source code. These are the raw AMF commands that...

### ✅ `ResponseDispatcher.as`
- **Path**: `Evony_Source\AS3_Scripts_(AutoEvony2_NEW.swf)\com\evony\client\response\ResponseDispatcher.as`
- **Type**: source_code
- **Training Value**: 1.00
- **Keywords**: commission, swf, quest, troop, hero
- **Preview**: ﻿// Decompiled by AS3 Sorcerer 6.78 // www.buraks.com/as3sorcerer  //com.evony.client.response.ResponseDispatcher  package com.evony.client.response {...

### ✅ `ResponseDispatcher.as`
- **Path**: `Evony_Source\AS3_Scripts_(EvonyClient1921.swf)\com\evony\client\response\ResponseDispatcher.as`
- **Type**: source_code
- **Training Value**: 1.00
- **Keywords**: commission, swf, quest, troop, hero
- **Preview**: ﻿// Decompiled by AS3 Sorcerer 6.78 // www.buraks.com/as3sorcerer  //com.evony.client.response.ResponseDispatcher  package com.evony.client.response {...

### ✅ `exploit_discovery.py`
- **Path**: `Svony_Automation\exploit_discovery.py`
- **Type**: source_code
- **Training Value**: 1.00
- **Keywords**: gold, commission, troop, resource, amf
- **Preview**: """ AI Exploit Discovery Engine  Uses AI/ML and pattern analysis to discover new exploits: - Analyze source code for loopholes - Learn from recorded g...

### ✅ `ResponseDispatcher.as`
- **Path**: `Tools\extracted\swf5_contents\scripts\com\evony\client\response\ResponseDispatcher.as`
- **Type**: source_code
- **Training Value**: 1.00
- **Keywords**: commission, wall, swf, quest, troop
- **Preview**: package com.evony.client.response {    import com.evony.client.action.ActionFactory;    import com.evony.common.MouseManager;    import com.evony.comm...

### ✅ `borg_toolkit_export.json`
- **Path**: `evony_hub\borg_toolkit_export.json`
- **Type**: exploit
- **Training Value**: 1.00
- **Keywords**: gold, wall, attack, quest, troop
- **Preview**: {   "version": "1.0",   "generated": "2026-01-03T13:53:43.958790",   "encryption_keys": {     "ACTION_KEY": "TAO_{313-894*&*($*#-FDIU(430}-{facebook_d...

### ✅ `exploit_discovery.py`
- **Path**: `evony_hub\exploit_discovery.py`
- **Type**: source_code
- **Training Value**: 1.00
- **Keywords**: gold, attack, swf, troop, resource
- **Preview**: # Evony RE Hub - Exploit Discovery Engine """ Analyzes decompiled AS3 source code to discover exploits, vulnerabilities, hidden commands, integer over...

### ✅ `analyzers.py`
- **Path**: `evony_hub\features\analyzers.py`
- **Type**: source_code
- **Training Value**: 1.00
- **Keywords**: quest, troop, actionscript, flash, exploit
- **Preview**: #!/usr/bin/env python3 """ Evony Hub - Code and Protocol Analyzers Analysis tools for AS3 source, protocol patterns, and vulnerabilities. """  import ...

### ✅ `glitch_calculator.py`
- **Path**: `evony_hub\glitch_calculator.py`
- **Type**: source_code
- **Training Value**: 1.00
- **Keywords**: gold, catapult, troop, archer, resource
- **Preview**: # Evony RE Hub - Glitch Calculator & Overflow Detector """ Calculates exact overflow points, glitch thresholds, and exploit parameters based on revers...

### ✅ `README.md`
- **Path**: `BorgToolkit\README.md`
- **Type**: protocol
- **Training Value**: 0.97
- **Keywords**: gold, quest, troop, hero, archer
- **Preview**: # BORG TOOLKIT  **Enterprise NSA-Grade Evony Exploitation Framework**  > Complete protocol knowledge • 301+ commands • Automated exploit discovery  --...

### ✅ `run_borg.py`
- **Path**: `BorgToolkit\run_borg.py`
- **Type**: source_code
- **Training Value**: 0.97
- **Keywords**: swf, quest, troop, archer, resource
- **Preview**: #!/usr/bin/env python3 # BORG TOOLKIT - Main Launcher """ Enterprise-grade Evony exploitation framework. Complete toolkit for reverse engineering, pac...

### ✅ `ARCHITECTURE.md`
- **Path**: `EvonyCommandCenter\ARCHITECTURE.md`
- **Type**: protocol
- **Training Value**: 0.97
- **Keywords**: swf, quest, troop, hero, archer
- **Preview**: # Evony Command Center - Architecture  ## System Overview  ``` ┌─────────────────────────────────────────────────────────────────────────────┐ │      ...

### ✅ `protocol_injector.py`
- **Path**: `EvonyMasterSuite\protocol_injector.py`
- **Type**: source_code
- **Training Value**: 0.97
- **Keywords**: attack, catapult, troop, hero, archer
- **Preview**: #!/usr/bin/env python3 """ Protocol Injector - AMF Packet Manipulation ============================================  Create and inject AMF packets for...

### ✅ `README.md`
- **Path**: `EvonyMegaToolkit\README.md`
- **Type**: protocol
- **Training Value**: 0.97
- **Keywords**: commission, wall, attack, swf, quest
- **Preview**: # ╔══════════════════════════════════════════════════════════════════════════╗ # ║                      EVONY MEGA TOOLKIT                            ...

### ✅ `evony_mega_toolkit.py`
- **Path**: `EvonyMegaToolkit\evony_mega_toolkit.py`
- **Type**: source_code
- **Training Value**: 0.97
- **Keywords**: swf, troop, resource, autoevony, exploit
- **Preview**: #!/usr/bin/env python3 """ ================================================================================ EVONY MEGA TOOLKIT - UNIFIED EDITION v3.0....

### ✅ `ADVANCED_RE_FRAMEWORK.md`
- **Path**: `Evony_Dataset\documentation\ADVANCED_RE_FRAMEWORK.md`
- **Type**: protocol
- **Training Value**: 0.97
- **Keywords**: attack, quest, troop, alliance, resource
- **Preview**: # Advanced Reverse Engineering Automation Framework  ## Borg Swarm Agent-Driven Full Extraction System  ---  ## 🎯 Vision Statement  A fully automated,...

### ✅ `EPIC_2026_ROADMAP.md`
- **Path**: `Evony_Dataset\documentation\EPIC_2026_ROADMAP.md`
- **Type**: exploit
- **Training Value**: 0.97
- **Keywords**: attack, quest, hero, alliance, resource
- **Preview**: # BorgToolkit Epic 2026 - Complete Enhancement Roadmap  ## Vision Transform BorgToolkit from a script server into a **complete multi-account automatio...

### ✅ `EXPLOITS.md`
- **Path**: `Evony_Dataset\documentation\EXPLOITS.md`
- **Type**: protocol
- **Training Value**: 0.97
- **Keywords**: gold, commission, attack, swf, quest
- **Preview**: # BORG TOOLKIT - Exploit Documentation  > Complete documentation of all Evony exploits extracted from source analysis  ---  ## 🔴 CRITICAL EXPLOITS  ##...

### ✅ `GLOSSARY.md`
- **Path**: `Evony_Dataset\documentation\GLOSSARY.md`
- **Type**: protocol
- **Training Value**: 0.97
- **Keywords**: attack, swf, catapult, troop, hero
- **Preview**: # Svony Studio - Glossary of Terms  > **Quick Reference** - Common terms and abbreviations used in Svony Studio documentation  ---  ## A  **ABC (Actio...

### ✅ `MISSING_FEATURES_ANALYSIS.md`
- **Path**: `Evony_Dataset\documentation\MISSING_FEATURES_ANALYSIS.md`
- **Type**: exploit
- **Training Value**: 0.97
- **Keywords**: attack, troop, hero, resource, flash
- **Preview**: # 🚨 MISSING FEATURES ANALYSIS - Full Bot Potential  ## What We HAVE (Keys + Source)  | Asset | Location | Status | |-------|----------|--------| | **A...

### ✅ `PROTOCOL.md`
- **Path**: `Evony_Dataset\documentation\PROTOCOL.md`
- **Type**: protocol
- **Training Value**: 0.97
- **Keywords**: gold, attack, swf, quest, catapult
- **Preview**: # BORG TOOLKIT - Protocol Reference  > Complete AMF protocol documentation extracted from Evony client source  ---  ## Protocol Overview  Evony uses *...

### ✅ `REALTIME_RE_VISION.md`
- **Path**: `Evony_Dataset\documentation\REALTIME_RE_VISION.md`
- **Type**: protocol
- **Training Value**: 0.97
- **Keywords**: attack, swf, quest, troop, alliance
- **Preview**: # 🔮 Svony Studio Real-Time Reverse Engineering Vision  ## Executive Summary  **Vision**: Transform Svony Studio into a fully automated, real-time reve...

### ✅ `SOURCE_COMPLETENESS_ANALYSIS.md`
- **Path**: `Evony_Dataset\documentation\SOURCE_COMPLETENESS_ANALYSIS.md`
- **Type**: protocol
- **Training Value**: 0.97
- **Keywords**: swf, troop, hero, actionscript, alliance
- **Preview**: # 🔬 EVONY SOURCE CODE COMPLETENESS ANALYSIS ## DEFINITIVE ASSESSMENT: What You Have vs. What's Possible  ---  > **Analysis Date**: 2026-01-02 > **Work...

### ✅ `architecture_5d385a77.md`
- **Path**: `Evony_Dataset\documentation\architecture_5d385a77.md`
- **Type**: exploit
- **Training Value**: 0.97
- **Keywords**: troop, resource, amf, food, glitch
- **Preview**: # BORG TOOLKIT - Architecture Diagram  ``` ┌─────────────────────────────────────────────────────────────────────────────┐ │                          ...

### ✅ `command_reference_160ea0db.md`
- **Path**: `Evony_Dataset\documentation\command_reference_160ea0db.md`
- **Type**: exploit
- **Training Value**: 0.97
- **Keywords**: commission, attack, quest, catapult, troop
- **Preview**: # BORG TOOLKIT - Command Reference Diagram  > Visual reference for all 301+ protocol commands  ---  ## Command Category Map  ``` ┌────────────────────...

### ✅ `collect_data.py`
- **Path**: `Evony_Dataset\source_code\collect_data.py`
- **Type**: source_code
- **Training Value**: 0.97
- **Keywords**: attack, swf, quest, troop, hero
- **Preview**: """ Evony AI Data Collector ======================== Collects and structures all Evony-related data for training. """  import os import json import ha...

### ✅ `generate_dataset.py`
- **Path**: `Evony_Dataset\source_code\generate_dataset.py`
- **Type**: source_code
- **Training Value**: 0.97
- **Keywords**: quest, catapult, troop, hero, archer
- **Preview**: """ Evony AI Dataset Generator =========================== Generates instruction-following Q&A pairs from collected data. """  import os import json i...

### ✅ `ALL_ENCRYPTION_KEYS.py`
- **Path**: `Keys\ALL_ENCRYPTION_KEYS.py`
- **Type**: source_code
- **Training Value**: 0.97
- **Keywords**: commission, swf, catapult, troop, archer
- **Preview**: """ COMPLETE EVONY ENCRYPTION KEYS ============================== Extracted from EvonyClient1921.swf and AutoEvony2.swf All keys verified and consolid...

### ✅ `ARCHITECTURE.md`
- **Path**: `evony_hub\ARCHITECTURE.md`
- **Type**: exploit
- **Training Value**: 0.97
- **Keywords**: quest, troop, resource, flash, autoevony
- **Preview**: # Evony Hub - Architecture  ## System Overview  ``` ┌─────────────────────────────────────────────────────────────────────────────┐ │                 ...

### ✅ `borg_toolkit.py`
- **Path**: `evony_hub\borg_toolkit.py`
- **Type**: source_code
- **Training Value**: 0.97
- **Keywords**: gold, wall, attack, swf, quest
- **Preview**: # BORG TOOLKIT - Complete Evony Reverse Engineering & Exploitation Framework """ Comprehensive toolkit for Evony reverse engineering, protocol manipul...

### ✅ `gui.py`
- **Path**: `evony_hub\gui.py`
- **Type**: source_code
- **Training Value**: 0.97
- **Keywords**: catapult, troop, archer, flash, autoevony
- **Preview**: #!/usr/bin/env python3 # Evony Master Hub - Unified GUI """ Unified GUI integrating all Evony toolkits into tabbed interface: - Dashboard (status, qui...

### ✅ `protocol_exploiter.py`
- **Path**: `evony_hub\protocol_exploiter.py`
- **Type**: source_code
- **Training Value**: 0.97
- **Keywords**: gold, quest, troop, hero, alliance
- **Preview**: # Evony RE Hub - Protocol Exploitation Toolkit """ Tools for manipulating Evony's AMF protocol to discover and exploit vulnerabilities, inject packets...

### ✅ `run_borg.py`
- **Path**: `evony_hub\run_borg.py`
- **Type**: source_code
- **Training Value**: 0.97
- **Keywords**: swf, quest, catapult, troop, archer
- **Preview**: # BORG TOOLKIT LAUNCHER """ Main launcher for the Borg Toolkit - Complete Evony RE Framework. Run this to access all tools and generate reports. """  ...

### ✅ `amulet.py`
- **Path**: `Scripts\EvonyAmuletSpinner-master\amulet.py`
- **Type**: source_code
- **Training Value**: 0.96
- **Keywords**: quest, medal, war, evony, quest.
- **Preview**: from evony import * import time import os import sys import random from threading import Thread import Queue import string from actionfactory.builder ...

### ✅ `borg_data_viewer_web.py`
- **Path**: `BorgToolkit\borg_data_viewer_web.py`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: quest, catapult, troop, hero, archer
- **Preview**: #!/usr/bin/env python3 """ Borg Account Data Web Viewer Creates a local web server to view all account data in a nice UI """  import json import os fr...

### ✅ `extract_all_game_data.py`
- **Path**: `BorgToolkit\extract_all_game_data.py`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: attack, catapult, troop, hero, archer
- **Preview**: #!/usr/bin/env python3 """ COMPLETE Evony Game Data Extraction - ALL IDs and Structures Extracts 100% of data from the 3.2MB JSON dump """  import jso...

### ✅ `extract_all_ids.py`
- **Path**: `BorgToolkit\extract_all_ids.py`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: gold, wall, quest, catapult, troop
- **Preview**: #!/usr/bin/env python3 """ Extract ALL IDs from Evony game dump for reverse engineering index """  import json import os from collections import defau...

### ✅ `food_glitch_analyzer.py`
- **Path**: `BorgToolkit\food_glitch_analyzer.py`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: gold, catapult, troop, archer, cavalry
- **Preview**: """ Enhanced Food Glitch Analyzer v2.0 Based on Ogliss's FoodGlitchCounterV1.2 script  Features: - Verbose mode (on/off) showing step-by-step calculat...

### ✅ `view_dump.py`
- **Path**: `BorgToolkit\view_dump.py`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: gold, attack, catapult, troop, hero
- **Preview**: """ Evony Dump Viewer - Per-City Resources & Troops Breakdown Based on AutoEvony script display format (Troop_&_RSS_Counter, FoodGlitchCounter) Usage:...

### ✅ `BOT_INTEGRATION.md`
- **Path**: `Docs\BOT_INTEGRATION.md`
- **Type**: protocol
- **Training Value**: 0.95
- **Keywords**: attack, swf, quest, troop, hero
- **Preview**: # Evony Age II - Bot Integration Guide  > **"Bot Framework Integration"** - Connecting Svony Studio with RoboEvony & AutoEvony  ---  ## Overview  This...

### ✅ `API_REFERENCE.md`
- **Path**: `Evony_Dataset\documentation\API_REFERENCE.md`
- **Type**: keys
- **Training Value**: 0.95
- **Keywords**: attack, swf, actionscript, flash, amf
- **Preview**: # Svony Studio - API Reference  > **"Collective Interface Specifications"** - Module and Class Reference  ---  ## Core Modules  ### `src.core.config` ...

### ✅ `FAQ.md`
- **Path**: `Evony_Dataset\documentation\FAQ.md`
- **Type**: keys
- **Training Value**: 0.95
- **Keywords**: attack, swf, quest, troop, hero
- **Preview**: # Svony Studio - Frequently Asked Questions  > **"FAQ"** - Common Questions and Answers  ---  ## General Questions  ### What is Svony Studio?  Svony S...

### ✅ `ROBOEVONY_FEATURE_ANALYSIS.md`
- **Path**: `Evony_Dataset\documentation\ROBOEVONY_FEATURE_ANALYSIS.md`
- **Type**: keys
- **Training Value**: 0.95
- **Keywords**: gold, wall, attack, catapult, troop
- **Preview**: # ROBOEVONY REFERENCE UI ANALYSIS ## Complete Feature Extraction from Screenshots  **Analysis Date:** January 2, 2026   **Source:** 9 RoboEvony/AutoEv...

### ✅ `TUTORIALS.md`
- **Path**: `Evony_Dataset\documentation\TUTORIALS.md`
- **Type**: protocol
- **Training Value**: 0.95
- **Keywords**: attack, swf, quest, troop, hero
- **Preview**: # Svony Studio - Tutorials  > **"Step-by-Step Guides"** - Practical Tutorials for Common Tasks  ---  ## Overview  This document provides step-by-step ...

### ✅ `cheats.py`
- **Path**: `Evony_Dataset\tools\cheats.py`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: gold, catapult, troop, hero, archer
- **Preview**: # BORG TOOLKIT - Automated Cheat Engine """ Enterprise-grade automated cheat engine for Evony. Combines all exploits into automated, repeatable cheat ...

### ✅ `complete_extractor.py`
- **Path**: `Evony_Dataset\tools\complete_extractor.py`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: quest, troop, hero, alliance, fortification
- **Preview**: """ Complete Evony Account Extractor - 1:1 NAND-style Dump Extracts ALL available data from an Evony account  Based on decompiled AutoEvony source fil...

### ✅ `exploit_engine_75f31ea3.py`
- **Path**: `Evony_Dataset\tools\exploit_engine_75f31ea3.py`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: quest, catapult, troop, archer, resource
- **Preview**: # BORG TOOLKIT - Automated Exploit Discovery Engine """ Advanced exploit discovery through: - Parameter fuzzing (negative, overflow, boundary values) ...

### ✅ `exploits.py`
- **Path**: `Evony_Dataset\tools\exploits.py`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: attack, swf, quest, catapult, troop
- **Preview**: # BORG TOOLKIT - Working Exploits Module """ Enterprise-grade working exploits for Evony. Based on reverse engineering of EvonyClient1921.swf source c...

### ✅ `CityConfigs.as`
- **Path**: `Evony_Source\AS3_Scripts_(AutoEvony2_NEW.swf)\autoevony\management\CityConfigs.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: attack, swf, quest, troop, hero
- **Preview**: ﻿// Decompiled by AS3 Sorcerer 6.78 // www.buraks.com/as3sorcerer  //autoevony.management.CityConfigs  package autoevony.management {     import autoe...

### ✅ `Script.as`
- **Path**: `Evony_Source\AS3_Scripts_(AutoEvony2_NEW.swf)\autoevony\scripts\Script.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: swf, quest, flash, autoevony, city
- **Preview**: ﻿// Decompiled by AS3 Sorcerer 6.78 // www.buraks.com/as3sorcerer  //autoevony.scripts.Script  package autoevony.scripts {     import flash.events.Eve...

### ✅ `ActionFactory.as`
- **Path**: `Evony_Source\AS3_Scripts_(AutoEvony2_NEW.swf)\com\evony\client\action\ActionFactory.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: commission, swf, quest, troop, hero
- **Preview**: ﻿// Decompiled by AS3 Sorcerer 6.78 // www.buraks.com/as3sorcerer  //com.evony.client.action.ActionFactory  package com.evony.client.action {     impo...

### ✅ `ArmyCommands.as`
- **Path**: `Evony_Source\AS3_Scripts_(AutoEvony2_NEW.swf)\com\evony\client\action\ArmyCommands.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: wall, attack, swf, troop, alliance
- **Preview**: ﻿// Decompiled by AS3 Sorcerer 6.78 // www.buraks.com/as3sorcerer  //com.evony.client.action.ArmyCommands  package com.evony.client.action {     impor...

### ✅ `CommonCommands.as`
- **Path**: `Evony_Source\AS3_Scripts_(AutoEvony2_NEW.swf)\com\evony\client\action\CommonCommands.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: attack, swf, troop, alliance, autoevony
- **Preview**: ﻿// Decompiled by AS3 Sorcerer 6.78 // www.buraks.com/as3sorcerer  //com.evony.client.action.CommonCommands  package com.evony.client.action {     imp...

### ✅ `CommonConstants.as`
- **Path**: `Evony_Source\AS3_Scripts_(AutoEvony2_NEW.swf)\com\evony\common\constants\CommonConstants.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: gold, commission, swf, quest, troop
- **Preview**: ﻿// Decompiled by AS3 Sorcerer 6.78 // www.buraks.com/as3sorcerer  //com.evony.common.constants.CommonConstants  package com.evony.common.constants { ...

### ✅ `REAddons.as`
- **Path**: `Evony_Source\AS3_Scripts_(AutoEvony2_NEW.swf)\com\rd\REAddons.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: swf, catapult, troop, hero, archer
- **Preview**: ﻿// Decompiled by AS3 Sorcerer 6.78 // www.buraks.com/as3sorcerer  //com.rd.REAddons  package com.rd {     import flash.utils.Timer;     import autoev...

### ✅ `Context.as`
- **Path**: `Evony_Source\AS3_Scripts_(EvonyClient1921.swf)\com\evony\Context.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: swf, quest, troop, hero, fortification
- **Preview**: ﻿// Decompiled by AS3 Sorcerer 6.78 // www.buraks.com/as3sorcerer  //com.evony.Context  package com.evony {     import flash.events.IEventDispatcher; ...

### ✅ `ActionFactory.as`
- **Path**: `Evony_Source\AS3_Scripts_(EvonyClient1921.swf)\com\evony\client\action\ActionFactory.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: commission, swf, quest, troop, hero
- **Preview**: ﻿// Decompiled by AS3 Sorcerer 6.78 // www.buraks.com/as3sorcerer  //com.evony.client.action.ActionFactory  package com.evony.client.action {     impo...

### ✅ `ArmyCommands.as`
- **Path**: `Evony_Source\AS3_Scripts_(EvonyClient1921.swf)\com\evony\client\action\ArmyCommands.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: wall, attack, swf, troop, alliance
- **Preview**: ﻿// Decompiled by AS3 Sorcerer 6.78 // www.buraks.com/as3sorcerer  //com.evony.client.action.ArmyCommands  package com.evony.client.action {     impor...

### ✅ `CommonCommands.as`
- **Path**: `Evony_Source\AS3_Scripts_(EvonyClient1921.swf)\com\evony\client\action\CommonCommands.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: attack, swf, troop, alliance, war
- **Preview**: ﻿// Decompiled by AS3 Sorcerer 6.78 // www.buraks.com/as3sorcerer  //com.evony.client.action.CommonCommands  package com.evony.client.action {     imp...

### ✅ `CommonConstants.as`
- **Path**: `Evony_Source\AS3_Scripts_(EvonyClient1921.swf)\com\evony\common\constants\CommonConstants.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: gold, commission, swf, quest, troop
- **Preview**: ﻿// Decompiled by AS3 Sorcerer 6.78 // www.buraks.com/as3sorcerer  //com.evony.common.constants.CommonConstants  package com.evony.common.constants { ...

### ✅ `SuzerainInfoWin.as`
- **Path**: `Evony_Source\AS3_Scripts_(EvonyClient1921.swf)\view\castleList\SuzerainInfoWin.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: commission, age1, swf, quest, alliance
- **Preview**: ﻿// Decompiled by AS3 Sorcerer 6.78 // www.buraks.com/as3sorcerer  //view.castleList.SuzerainInfoWin  package view.castleList {     import mx.containe...

### ✅ `generatestatus.as`
- **Path**: `Scripts\EvonyCommQuest\REscript\generatestatus.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: gold, wall, attack, quest, catapult
- **Preview**: import autoevony.gui.MainScreen; import flash.events.Event; import autoevony.common.Utils; import autoevony.player.LoginHelper; import com.evony.commo...

### ✅ `troop_operations.as`
- **Path**: `Scripts\Useful_Action_Script\troop_operations.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: troop, archer, cavalry, food, city
- **Preview**: package com.evony.useful {     public class TroopOperations {         // Constants for safe operations         private static const MAX_32BIT:Number =...

### ✅ `swarm_controller.py`
- **Path**: `Svony_Automation\swarm_controller.py`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: attack, quest, troop, archer, resource
- **Preview**: """ Multi-Account Swarm Controller  Coordinates 50+ bot accounts simultaneously with Borg Swarm integration. Enables mass farming, coordinated attacks...

### ✅ `CityConfigs.as`
- **Path**: `Tools\extracted\swf5_contents\scripts\autoevony\management\CityConfigs.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: attack, swf, quest, troop, hero
- **Preview**: package autoevony.management {    import autoevony.common.Utils;        public class CityConfigs    {       public static const CFG_DEBUG:String = "de...

### ✅ `Script.as`
- **Path**: `Tools\extracted\swf5_contents\scripts\autoevony\scripts\Script.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: swf, quest, flash, autoevony, city
- **Preview**: package autoevony.scripts {    import autoevony.common.ScriptError;    import autoevony.common.TechType;    import autoevony.common.Utils;    import a...

### ✅ `ActionFactory.as`
- **Path**: `Tools\extracted\swf5_contents\scripts\com\evony\client\action\ActionFactory.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: commission, swf, quest, troop, hero
- **Preview**: package com.evony.client.action {    import com.evony.client.response.ResponseDispatcher;    import com.evony.common.Sender;        public class Actio...

### ✅ `ArmyCommands.as`
- **Path**: `Tools\extracted\swf5_contents\scripts\com\evony\client\action\ArmyCommands.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: wall, attack, swf, troop, alliance
- **Preview**: package com.evony.client.action {    import com.evony.common.Sender;    import com.evony.common.beans.TroopBean;    import com.evony.common.module.Com...

### ✅ `CommonCommands.as`
- **Path**: `Tools\extracted\swf5_contents\scripts\com\evony\client\action\CommonCommands.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: attack, swf, troop, alliance, war
- **Preview**: package com.evony.client.action {    import com.evony.common.Sender;    import com.evony.common.beans.TroopBean;    import com.evony.common.module.Com...

### ✅ `CommonConstants.as`
- **Path**: `Tools\extracted\swf5_contents\scripts\com\evony\common\constants\CommonConstants.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: gold, commission, swf, quest, troop
- **Preview**: package com.evony.common.constants {    public class CommonConstants    {       public static const INCWOODPRODUCEEFFORTBUFF:String = "IncWoodProduceE...

### ✅ `REAddons.as`
- **Path**: `Tools\extracted\swf5_contents\scripts\com\rd\REAddons.as`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: swf, catapult, troop, hero, archer
- **Preview**: package com.rd {    import autoevony.common.CityStateCommands;    import autoevony.common.CityStateConstants;    import autoevony.event.CityStateRespo...

### ✅ `packet_type_detector.py`
- **Path**: `Tools\packet_type_detector.py`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: attack, quest, troop, hero, alliance
- **Preview**: """ PacketTypeDetector - Classify and Analyze Game Protocol Packets  Identifies packet types from raw/decrypted data: - Command packets (client → serv...

### ✅ `sol_manager_gui.py`
- **Path**: `Tools\sol_manager_gui.py`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: catapult, troop, archer, flash, amf
- **Preview**: #!/usr/bin/env python3 """ ETK SOL Manager - Comprehensive GUI Tool Manages SOL files for 470+ Evony Age II accounts  Features: - View/Edit/Save SOL f...

### ✅ `all_commands.txt`
- **Path**: `all_commands.txt`
- **Type**: keys
- **Training Value**: 0.95
- **Keywords**: commission, wall, attack, quest, troop
- **Preview**: ﻿ALLIANCE_GET_ALLIANCE_ARMY_REPORT|alliance.getAllianceArmyReport ALLIANCE_GET_ALLIANCE_EVENT_LIST|alliance.getAllianceEventList ALLIANCE_GET_ALLIANCE...

### ✅ `evony_client.py`
- **Path**: `sol_manager\extractor\evony_client.py`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: quest, hero, alliance, amf, prestige
- **Preview**: """ ETK Evony Client - Python 3 port of pyEvony Direct connection to Evony servers for account data extraction  Based on sonya75's pyEvony: https://gi...

### ✅ `heroes_tab.py`
- **Path**: `sol_manager\ui\tabs\heroes_tab.py`
- **Type**: source_code
- **Training Value**: 0.95
- **Keywords**: attack, hero, city, war, evony
- **Preview**: """ ETK SOL Manager - Heroes Tab Displays hero data with filtering by type """  import tkinter as tk from tkinter import ttk from typing import Option...

### ✅ `MASTER_RESOURCE_INDEX.md`
- **Path**: `Docs\MASTER_RESOURCE_INDEX.md`
- **Type**: keys
- **Training Value**: 0.94
- **Keywords**: commission, attack, swf, quest, troop
- **Preview**: # 🎮 SVONY STUDIO - MASTER RESOURCE INDEX ## Comprehensive Evony Client, RoboEvony, AutoEvony & Bot Automation Reference  ---  > **Generated**: 2026-01...

### ✅ `evony_command_center.py`
- **Path**: `EvonyCommandCenter\evony_command_center.py`
- **Type**: source_code
- **Training Value**: 0.94
- **Keywords**: gold, commission, wall, swf, quest
- **Preview**: #!/usr/bin/env python3 """ ╔══════════════════════════════════════════════════════════════════════════════╗ ║                    EVONY ULTIMATE COMMAN...

### ✅ `master_suite.py`
- **Path**: `EvonyMasterSuite\master_suite.py`
- **Type**: source_code
- **Training Value**: 0.94
- **Keywords**: gold, commission, attack, swf, quest
- **Preview**: #!/usr/bin/env python3 """ ═══════════════════════════════════════════════════════════════════════════════   EVONY MASTER SUITE - Ultimate Integrated ...

### ✅ `TOOL_IMPLEMENTATION_SPEC.md`
- **Path**: `Evony_Dataset\documentation\TOOL_IMPLEMENTATION_SPEC.md`
- **Type**: protocol
- **Training Value**: 0.94
- **Keywords**: gold, wall, attack, swf, quest
- **Preview**: # 🛠️ COMPREHENSIVE TOOL IMPLEMENTATION SPECIFICATION ## 55+ Tools for Svony Studio Evony Automation Suite  ---  ## 📊 TOOL CATEGORIES OVERVIEW  | Categ...

### ✅ `hub_ultimate.py`
- **Path**: `evony_hub\hub_ultimate.py`
- **Type**: source_code
- **Training Value**: 0.94
- **Keywords**: swf, quest, catapult, troop, hero
- **Preview**: #!/usr/bin/env python3 """ ╔══════════════════════════════════════════════════════════════════════════════════════════════════╗ ║                     ...

### ✅ `evony_hacker_toolkit.py`
- **Path**: `toolkit\evony_hacker_toolkit.py`
- **Type**: source_code
- **Training Value**: 0.94
- **Keywords**: commission, attack, swf, quest, troop
- **Preview**: #!/usr/bin/env python3 """ EVONY HACKER TOOLKIT - AI Exploit Studio ========================================= A comprehensive GUI for Evony script cre...

### ✅ `protocol_flow.md`
- **Path**: `Evony_Dataset\documentation\protocol_flow.md`
- **Type**: protocol
- **Training Value**: 0.93
- **Keywords**: quest, troop, resource, exploit, evony
- **Preview**: # BORG TOOLKIT - Protocol Flow Diagrams  > Visual representation of Evony protocol flows and exploit execution  ---  ## Connection Flow  ``` ┌────────...

### ✅ `Master list.txt`
- **Path**: `Accounts\Master list.txt`
- **Type**: keys
- **Training Value**: 0.92
- **Keywords**: gold, wall, lumber, catapult, troop
- **Preview**: LT           Tarasdbe@yahoo.com bojangles5 (patricia1) - (1.2 Billion Archers)  CRAZYTURK    toygarc@hotmail.com	nailbomb123  LT (60m archers)  feeder...

### ✅ `Master list3.txt`
- **Path**: `Accounts\Master list3.txt`
- **Type**: keys
- **Training Value**: 0.92
- **Keywords**: gold, wall, attack, quest, catapult
- **Preview**: LT           Tarasdbe@yahoo.com bojangles5 security code patricia1(1.2 Billion Archers)  CRAZYTURK    toygarc@hotmail.com	nailbomb123  LT (60m archers...

### ✅ `Master list_backup.txt`
- **Path**: `Accounts\Master list_backup.txt`
- **Type**: keys
- **Training Value**: 0.92
- **Keywords**: gold, wall, lumber, catapult, troop
- **Preview**: LT           Tarasdbe@yahoo.com bojangles5 (1.2 Billion Archers)  CRAZYTURK    toygarc@hotmail.com	nailbomb123  LT (60m archers)  feeder 1bamf: fearme...

### ✅ `README_EPIC_2026.md`
- **Path**: `BorgToolkit\README_EPIC_2026.md`
- **Type**: protocol
- **Training Value**: 0.92
- **Keywords**: quest, troop, hero, resource, autoevony
- **Preview**: # BORG TOOLKIT EPIC 2026  > 🚀 **Complete Multi-Account Evony Automation Platform**  ---  ## Quick Start  ```bash # Option 1: Double-click start_epic.b...

### ✅ `borg_extractor_ui.py`
- **Path**: `BorgToolkit\borg_extractor_ui.py`
- **Type**: source_code
- **Training Value**: 0.92
- **Keywords**: quest, troop, hero, alliance, resource
- **Preview**: #!/usr/bin/env python3 """ BORG TOOLKIT EPIC 2026 - Account Extractor Web UI ==================================================  Web interface for: - ...

### ✅ `borg_master.py`
- **Path**: `BorgToolkit\borg_master.py`
- **Type**: source_code
- **Training Value**: 0.92
- **Keywords**: quest, troop, hero, resource, autoevony
- **Preview**: #!/usr/bin/env python3 """ BORG TOOLKIT EPIC 2026 - Master Server =======================================  Central hub for multi-account management, r...

### ✅ `glitch_calculator_gui.py`
- **Path**: `BorgToolkit\glitch_calculator_gui.py`
- **Type**: source_code
- **Training Value**: 0.92
- **Keywords**: gold, catapult, troop, archer, cavalry
- **Preview**: #!/usr/bin/env python3 """ Glitch Calculator GUI - Optimal Food Glitch Configuration Tool ============================================================...

### ✅ `script_server.py`
- **Path**: `BorgToolkit\script_server.py`
- **Type**: source_code
- **Training Value**: 0.92
- **Keywords**: gold, quest, troop, archer, resource
- **Preview**: #!/usr/bin/env python3 """ BORG TOOLKIT - External Script Server for AutoEvony  AutoEvony can load scripts via 'includeurl http://server/script.txt' T...

### ✅ `AUTOEVONY_VS_CLIENT_ANALYSIS.md`
- **Path**: `Docs\AUTOEVONY_VS_CLIENT_ANALYSIS.md`
- **Type**: keys
- **Training Value**: 0.92
- **Keywords**: gold, commission, attack, swf, quest
- **Preview**: # 🔍 AutoEvony vs EvonyClient - Hidden Features Analysis  > **Cross-reference of AutoEvony.swf tricks, hacks, and hidden commands vs standard EvonyClie...

### ✅ `BATTLE_MECHANICS.md`
- **Path**: `Docs\BATTLE_MECHANICS.md`
- **Type**: keys
- **Training Value**: 0.92
- **Keywords**: wall, attack, catapult, troop, hero
- **Preview**: # Evony Age II - Battle Mechanics  > **"Combat Protocols"** - Reverse-Engineered Battle Formulas and Data  ---  ## Overview  This document contains re...

### ✅ `COMMAND_REFERENCE.md`
- **Path**: `Docs\COMMAND_REFERENCE.md`
- **Type**: protocol
- **Training Value**: 0.92
- **Keywords**: gold, wall, attack, lumber, quest
- **Preview**: # Evony Age II - Complete Command Reference  > **"Protocol Commands"** - Full Command ID Mapping for Bot Development  ---  ## Overview  This document ...


*...and 8857 more approved files*


---

## Files REJECTED (Do Not Train)

These files were rejected due to quality issues:

### ❌ `ResponseDispatcher.as`
- **Path**: `AS3_Scripts_(AutoEvony2_NEW.swf)\com\evony\client\response\ResponseDispatcher.as`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `ResponseDispatcher.as`
- **Path**: `AS3_Scripts_(EvonyClient1921.swf)\com\evony\client\response\ResponseDispatcher.as`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `bot_integration.py`
- **Path**: `BorgToolkit\src\bot_integration.py`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `injection.py`
- **Path**: `BorgToolkit\src\injection.py`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `protocol_commands.py`
- **Path**: `BorgToolkit\src\protocol_commands.py`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `protocol.py`
- **Path**: `EvonyMegaToolkit-backup\src\protocol.py`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `protocol.py`
- **Path**: `EvonyMegaToolkit\src\protocol.py`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `CLIENT_STRUCTURE.md`
- **Path**: `Evony_Dataset\documentation\CLIENT_STRUCTURE.md`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `borg_toolkit_export.json`
- **Path**: `Evony_Dataset\game_data\borg_toolkit_export.json`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `ResponseDispatcher.as`
- **Path**: `Evony_Dataset\source_code\ResponseDispatcher.as`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `ResponseDispatcher_7934e843.as`
- **Path**: `Evony_Dataset\source_code\ResponseDispatcher_7934e843.as`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `ResponseDispatcher_d56461cc.as`
- **Path**: `Evony_Dataset\source_code\ResponseDispatcher_d56461cc.as`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `exploit_discovery.py`
- **Path**: `Evony_Dataset\source_code\exploit_discovery.py`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `exploit_discovery_45927991.py`
- **Path**: `Evony_Dataset\source_code\exploit_discovery_45927991.py`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `glitch_calculator.py`
- **Path**: `Evony_Dataset\source_code\glitch_calculator.py`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `analyzers.py`
- **Path**: `Evony_Dataset\tools\analyzers.py`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `mega_toolkit.py`
- **Path**: `Evony_Dataset\tools\mega_toolkit.py`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `architecture.md`
- **Path**: `BorgToolkit\diagrams\architecture.md`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `command_reference.md`
- **Path**: `BorgToolkit\diagrams\command_reference.md`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `EPIC_2026_ROADMAP.md`
- **Path**: `BorgToolkit\docs\EPIC_2026_ROADMAP.md`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `EXPLOITS.md`
- **Path**: `BorgToolkit\docs\EXPLOITS.md`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `PROTOCOL.md`
- **Path**: `BorgToolkit\docs\PROTOCOL.md`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `ADVANCED_RE_FRAMEWORK.md`
- **Path**: `Docs\svony_docs\ADVANCED_RE_FRAMEWORK.md`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `GLOSSARY.md`
- **Path**: `Docs\svony_docs\GLOSSARY.md`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `MISSING_FEATURES_ANALYSIS.md`
- **Path**: `Docs\svony_docs\MISSING_FEATURES_ANALYSIS.md`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `REALTIME_RE_VISION.md`
- **Path**: `Docs\svony_docs\REALTIME_RE_VISION.md`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `SOURCE_COMPLETENESS_ANALYSIS.md`
- **Path**: `Docs\svony_docs\SOURCE_COMPLETENESS_ANALYSIS.md`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `README.md`
- **Path**: `EvonyMegaToolkit-backup\README.md`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `ARCHITECTURE.md`
- **Path**: `Evony_Dataset\documentation\ARCHITECTURE.md`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `ARCHITECTURE_76f56523.md`
- **Path**: `Evony_Dataset\documentation\ARCHITECTURE_76f56523.md`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `README.md`
- **Path**: `Evony_Dataset\documentation\README.md`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `README_6efeb277.md`
- **Path**: `Evony_Dataset\documentation\README_6efeb277.md`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `ALL_ENCRYPTION_KEYS.py`
- **Path**: `Evony_Dataset\source_code\ALL_ENCRYPTION_KEYS.py`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `gui.py`
- **Path**: `Evony_Dataset\source_code\gui.py`
- **Rating**: ACCEPTABLE
- **Issues**: Multiple low-quality indicators found
- **Flags**: DUPLICATE

### ❌ `protocol_exploiter.py`
- **Path**: `Evony_Dataset\source_code\protocol_exploiter.py`
- **Rating**: ACCEPTABLE
- **Issues**: Multiple low-quality indicators found
- **Flags**: DUPLICATE

### ❌ `protocol_injector.py`
- **Path**: `Evony_Dataset\source_code\protocol_injector.py`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `run_borg.py`
- **Path**: `Evony_Dataset\source_code\run_borg.py`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `borg_toolkit.py`
- **Path**: `Evony_Dataset\tools\borg_toolkit.py`
- **Rating**: ACCEPTABLE
- **Issues**: Multiple low-quality indicators found
- **Flags**: DUPLICATE

### ❌ `evony_mega_toolkit.py`
- **Path**: `Evony_Dataset\tools\evony_mega_toolkit.py`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `run_borg.py`
- **Path**: `Evony_Dataset\tools\run_borg.py`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `collect_data.py`
- **Path**: `evony_ai\scripts\collect_data.py`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `generate_dataset.py`
- **Path**: `evony_ai\scripts\generate_dataset.py`
- **Rating**: ACCEPTABLE
- **Issues**: Junk pattern: ^[^\w\s]{10,}
- **Flags**: DUPLICATE

### ❌ `amulet.py`
- **Path**: `Evony_Dataset\source_code\amulet.py`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `CityConfigs.as`
- **Path**: `AS3_Scripts_(AutoEvony2_NEW.swf)\autoevony\management\CityConfigs.as`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `Script.as`
- **Path**: `AS3_Scripts_(AutoEvony2_NEW.swf)\autoevony\scripts\Script.as`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `ActionFactory.as`
- **Path**: `AS3_Scripts_(AutoEvony2_NEW.swf)\com\evony\client\action\ActionFactory.as`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `ArmyCommands.as`
- **Path**: `AS3_Scripts_(AutoEvony2_NEW.swf)\com\evony\client\action\ArmyCommands.as`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `CommonCommands.as`
- **Path**: `AS3_Scripts_(AutoEvony2_NEW.swf)\com\evony\client\action\CommonCommands.as`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `CommonConstants.as`
- **Path**: `AS3_Scripts_(AutoEvony2_NEW.swf)\com\evony\common\constants\CommonConstants.as`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE

### ❌ `REAddons.as`
- **Path**: `AS3_Scripts_(AutoEvony2_NEW.swf)\com\rd\REAddons.as`
- **Rating**: ACCEPTABLE
- **Issues**: Low relevance
- **Flags**: DUPLICATE



---

## Duplicate Files Report

Files with identical content (only first occurrence kept):

### 24 copies
- `Troop_&_RSS_Counter.txt`
- `Troop_&_RSS_Counter - Copy (2).txt`
- `Troop_&_RSS_Counter - Copy.txt`
- `Troop_&_RSS_Counter.txt`
- `Troop_Counter.txt`
- *...and 19 more*

### 20 copies
- `Version.as`
- `Version.as`
- `Version.as`
- `Version.as`
- `Version.as`
- *...and 15 more*

### 15 copies
- `FoodGlitchCounterV1.2.txt`
- `Food Glitch Counter script v1.2.txt`
- `FoodGlitchCounterV1.2 - Copy.txt`
- `FoodGlitchCounterV1.2.txt`
- `FoodGlitchCounterV1.2.txt`
- *...and 10 more*

### 15 copies
- `crossdomain.xml`
- `crossdomain.xml`
- `crossdomain.xml`
- `crossdomain.xml`
- `crossdomain.xml`
- *...and 10 more*

### 13 copies
- `__init__.py`
- `__init__.py`
- `__init__.py`
- `__init__.py`
- `__init__.py`
- *...and 8 more*

### 9 copies
- `CommissionQuestAcceptor.txt`
- `CommissionQuestAcceptor.txt`
- `CommissionQuestAcceptor.txt`
- `CommissionQuestAcceptor.txt`
- `CommissionQuestAcceptor.txt`
- *...and 4 more*

### 9 copies
- `issuequest.txt`
- `issuequest.txt`
- `issuequest.txt`
- `issuequest.txt`
- `issuequest.txt`
- *...and 4 more*

### 8 copies
- `CommisionQuest_Troop_Glitch.txt`
- `CommisionQuest_Troop_Glitch.txt`
- `CommisionQuest_Troop_Glitch.txt`
- `CommisionQuest_Troop_Glitch.txt`
- `CommisionQuest_Troop_Glitch.txt`
- *...and 3 more*

### 8 copies
- `CommissionQuestAcceptor3.txt`
- `CommissionQuestAcceptor3.txt`
- `CommissionQuestAcceptor3.txt`
- `CommissionQuestAcceptor3.txt`
- `CommissionQuestAcceptor3.txt`
- *...and 3 more*

### 8 copies
- `Comm_Quest_.txt`
- `Comm_Quest_.txt`
- `Comm_Quest_.txt`
- `Comm_Quest_.txt`
- `Comm_Quest_.txt`
- *...and 3 more*

### 8 copies
- `[=]_Comm_Quest_[=].txt`
- `[=]_Comm_Quest_[=].txt`
- `[=]_Comm_Quest_[=].txt`
- `[=]_Comm_Quest_[=].txt`
- `[=]_Comm_Quest_[=].txt`
- *...and 3 more*

### 7 copies
- `Evony Accounts - Copy.txt`
- `Evony Accounts.txt`
- `Evony Accounts - Copy.txt`
- `Evony Accounts.txt`
- `Evony Accounts - Copy.txt`
- *...and 2 more*

### 7 copies
- `acceptquest.txt`
- `acceptquest.txt`
- `acceptquest.txt`
- `acceptquest.txt`
- `acceptquest.txt`
- *...and 2 more*

### 7 copies
- `Khans_Heroes.txt`
- `Khans_Heroes.txt`
- `Khans_Heroes.txt`
- `Khans_Heroes.txt`
- `Khans_Heroes.txt`
- *...and 2 more*

### 7 copies
- `ScanMap2.TXT`
- `ScanMap1.TXT`
- `ScanMap2.TXT`
- `ScanMap2.TXT`
- `ScanMap2.TXT`
- *...and 2 more*

### 7 copies
- `Scripts_LOL.txt`
- `Scripts_LOL.txt`
- `Scripts_LOL.txt`
- `Scripts_LOL.txt`
- `Scripts_LOL.txt`
- *...and 2 more*

### 7 copies
- `spam_script_v13.2_Borg.txt`
- `spam_script_v13.2_Borg.txt`
- `spam_script_v13.2_Borg.txt`
- `spam_script_v13.2_Borg.txt`
- `spam_script_v13.2_Borg.txt`
- *...and 2 more*

### 7 copies
- `spam_script_v13.4_Sonya.txt`
- `spam_script_v13.4_Sonya.txt`
- `spam_script_v13.4_Sonya.txt`
- `spam_script_v13.4_Sonya.txt`
- `spam_script_v13.4_Sonya.txt`
- *...and 2 more*

### 7 copies
- `decimal.license.txt`
- `commons-logging-LICENSE.txt`
- `LICENSE.resolver.txt`
- `LICENSE.serializer.txt`
- `decimal.license.txt`
- *...and 2 more*

### 7 copies
- `manage.py`
- `manage.py`
- `manage.py`
- `manage.py`
- `manage.py`
- *...and 2 more*

### 6 copies
- `Evony Accounts2.txt`
- `Evony Accounts2.txt`
- `Evony Accounts_quit_Alliance_info.txt`
- `Evony Accounts2.txt`
- `Evony Accounts_quit_Alliance_info.txt`
- *...and 1 more*

### 6 copies
- `Amulet_Glitch.TXT`
- `Amulet_Glitch.TXT`
- `Amulet_Glitch.TXT`
- `Amulet_Glitch.TXT`
- `Amulet_Glitch.TXT`
- *...and 1 more*

### 6 copies
- `fastattack(v1).txt`
- `fastattack(v1).txt`
- `fastattack(v1).txt`
- `fastattack(v1).txt`
- `fastattack(v1).txt`
- *...and 1 more*

### 6 copies
- `feeder.txt`
- `feeder.txt`
- `feeder.txt`
- `feeder.txt`
- `feeder.txt`
- *...and 1 more*

### 6 copies
- `Moving_Troops_Borg_Borg_script.txt`
- `Moving_Troops_Borg_Borg_script.txt`
- `Moving_Troops_Borg_Borg_script.txt`
- `Moving_Troops_Borg_Borg_script.txt`
- `Moving_Troops_Borg_Borg_script.txt`
- *...and 1 more*

### 6 copies
- `questaddarmy.txt`
- `questaddarmy.txt`
- `questaddarmy.txt`
- `questaddarmy.txt`
- `questaddarmy.txt`
- *...and 1 more*

### 6 copies
- `scripts.txt`
- `scripts.txt`
- `scripts.txt`
- `scripts.txt`
- `scripts.txt`
- *...and 1 more*

### 6 copies
- `khan_Items.txt`
- `khan_Items.txt`
- `khan_Items.txt`
- `khan_Items.txt`
- `khan_Items.txt`
- *...and 1 more*

### 6 copies
- `Scanmap.txt`
- `Scanmap.txt`
- `Scanmap.txt`
- `Scanmap.txt`
- `Scanmap.txt`
- *...and 1 more*

### 5 copies
- `en_US$collections_properties.as`
- `en_US$collections_properties.as`
- `en_US$collections_properties.as`
- `en_US$collections_properties.as`
- `en_US$collections_properties.as`



---

## Next Steps

1. **Review this report** - Check the approved/rejected files
2. **Override decisions** - Edit the JSON config to include/exclude specific files
3. **Run dataset builder** - Execute with approved files only
4. **Convert to training format** - Generate instruction/response pairs
