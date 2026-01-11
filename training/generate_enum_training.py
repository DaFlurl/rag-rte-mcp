#!/usr/bin/env python3
"""
Generate Enum Training Data for Evony/AutoEvony
Target: 950+ examples covering all constants, bugs, and usage patterns
"""

import json
import re
from pathlib import Path

SCRIPT_DIR = Path(__file__).parent
OUTPUT_FILE = SCRIPT_DIR / "train_enums.jsonl"

SYSTEM_PROMPT = """You are an expert in Evony game internals, ActionScript 3 programming, and the AutoEvony bot framework. You have complete knowledge of:
- All enum constants and their values
- Known bugs and typos in constant definitions
- Correct usage patterns for each constant type
- Cross-references between related constants

Provide accurate, technical responses with exact constant values."""

def create_example(question, answer):
    return {
        "messages": [
            {"role": "system", "content": SYSTEM_PROMPT},
            {"role": "user", "content": question},
            {"role": "assistant", "content": answer}
        ]
    }

examples = []

# ============================================================================
# ERROR CODES (ErrorCode.as) - 200+ codes
# ============================================================================

error_codes = {
    -1: ("RESOURCE_NOT_ENOUGH", "Generic resource insufficient error. Note: This is overly generic and masks specific failures."),
    -3: ("BUILD_UNIQUE_BUILDING_EXIST", "Unique building already exists in this city."),
    -4: ("BUILD_POSITION_NOT_IDLE", "Build position is already occupied."),
    -5: ("UPDATE_PROCESSING", "An update is already in progress."),
    -8: ("NO_DEPEND_BUILDING", "Missing prerequisite building required for this action."),
    -9: ("NO_DEPEND_TECH", "Missing prerequisite technology required for this action."),
    -10: ("NOT_ENOUGH_PEOPLE", "Insufficient population for this action."),
    -11: ("ACCOUNT_HAS_EXIST", "Account already exists."),
    -12: ("ACCOUNT_NOT_EXIST", "Account does not exist."),
    -19: ("GIVE_UP_CASTLE_FAIL", "Failed to abandon castle."),
    -20: ("ILLEGAL_FIELD_STATUS", "Invalid field state for this operation."),
    -21: ("ILLEGAL_MAIL_ACTION", "Invalid mail action attempted."),
    -45: ("INVALID_BUILDING_STATUS", "Building is in an invalid state."),
    -46: ("INVALID_BUILDING_TYPE", "Invalid building type specified."),
    -47: ("ITEM_NOT_ENOUGH", "Insufficient items for this action."),
    -48: ("TOWNHALL_LEVEL_UNSUPPORT", "Town Hall level does not support this action. Note: Typo - should be UNSUPPORTED."),
    -49: ("UPDATE_LEVEL_OUT_OF_RANGE", "Upgrade level is out of valid range."),
    -50: ("INVALID_PASSWORD", "Password validation failed."),
    -52: ("ALLIANCE_NOT_FOUND", "Alliance does not exist. BUG: SUPPORT_NOT_ZERO also uses -52!"),
    -53: ("NOBILITY_NOT_ENOUGH", "Insufficient nobility rank."),
    -54: ("RESEARCH_NOT_IN_UPGRADE", "Research is not currently upgrading."),
    -55: ("NO_UPGRADING_RESEARCH_IN_ACADEMY", "No research in progress at academy."),
    -57: ("BUILDING_REACH_MAX_LEVEL", "Building has reached maximum level."),
    -58: ("ALREADY_UPGRADING_RESEARCH_IN_ACADEMY", "Research already in progress."),
    -59: ("ILLEGAL_TECH_TYPE", "Invalid technology type."),
    -77: ("ARMY_EXIST_WHEN_MOVE_CASTLE", "Cannot move castle with armies present."),
    -78: ("ALLIANCE_ARMY_EXIST_WHEN_MOVE_CASTLE", "Cannot move castle with alliance reinforcements."),
    -79: ("FIELD_NOT_GOT", "Field is not owned."),
    -157: ("SILENCETIMEEXCEPTION", "Silence time violation."),
    -158: ("SILENCESAMEPLAYEREXCEPTION", "Cannot silence same player."),
    -159: ("NOVOTEINDAYEXCEPTION", "No vote allowed today."),
    -165: ("NOITEMDROP", "No item dropped from this action."),
    -200: ("NEED_SECURITY_CODE_ERROR", "Security code required. Note: Missing retry mechanism."),
    -201: ("BUILDING_QUEUE_ERROR", "Building queue error."),
}

for code, (name, desc) in error_codes.items():
    examples.append(create_example(
        f"What is ErrorCode {code} in Evony?",
        f"ErrorCode {code} is `{name}`: {desc}"
    ))
    examples.append(create_example(
        f"What does ErrorCode.{name} mean?",
        f"`ErrorCode.{name}` = {code}. {desc}"
    ))

# Bug examples
examples.append(create_example(
    "What is the duplicate error code bug in ErrorCode.as?",
    "There is a CRITICAL bug where error code -52 is used for BOTH `ALLIANCE_NOT_FOUND` and `SUPPORT_NOT_ZERO`. This causes incorrect error handling as two different error conditions return the same code. Fix: Assign `SUPPORT_NOT_ZERO` to a new unique code like -60."
))

examples.append(create_example(
    "Why is ErrorCode -1 problematic?",
    "`ErrorCode.RESOURCE_NOT_ENOUGH = -1` is problematic because it's too generic. It masks specific resource failures (food, wood, stone, iron, gold). Better practice: Split into specific codes like `FOOD_NOT_ENOUGH`, `WOOD_NOT_ENOUGH`, etc."
))

# ============================================================================
# TROOP CONSTANTS (TFConstants.as)
# ============================================================================

troop_types = {
    2: ("T_PEASANTS", "Workers/Peasants - basic resource gatherers"),
    3: ("T_MILITIA", "Militia/Warriors - basic infantry"),
    4: ("T_SCOUTER", "Scouts - reconnaissance units"),
    5: ("T_PIKEMAN", "Pikemen - anti-cavalry infantry"),
    6: ("T_SWORDSMAN", "Swordsmen - standard infantry"),
    7: ("T_ARCHER", "Archers - ranged infantry"),
    8: ("T_CAVALRY", "Light Cavalry - fast mounted units"),
    9: ("T_CATAPHRACT", "Cataphracts - heavy cavalry"),
    10: ("T_TRANSPORTER", "Transporters - cargo carriers"),
    11: ("T_BALLISTA", "Ballistas - siege ranged"),
    12: ("T_RAM", "Battering Rams - gate breakers"),
    13: ("T_CATAPULT", "Catapults - siege weapons"),
}

fort_types = {
    20: ("F_TRAP", "Traps - hidden ground defense"),
    21: ("F_ABATIS", "Abatis - cavalry defense"),
    22: ("F_ARCHER_TOWER", "Archer Towers - ranged defense"),
    23: ("F_ROLLING_LOGS", "Rolling Logs - wall defense"),
    24: ("F_DEFENSIVE_TREBUCHE", "Defensive Trebuchets - siege defense"),
    25: ("F_ROCKFALL", "Rockfall - area defense"),
}

for tid, (name, desc) in troop_types.items():
    examples.append(create_example(
        f"What is TFConstants.{name}?",
        f"`TFConstants.{name}` = {tid}. {desc}. Note: Troop IDs start at 2, with 0-1 reserved (possibly for None/Hero)."
    ))

for fid, (name, desc) in fort_types.items():
    examples.append(create_example(
        f"What is TFConstants.{name}?",
        f"`TFConstants.{name}` = {fid}. {desc}. Note: Fortification IDs start at 20, creating a gap from troop IDs (2-13)."
    ))

examples.append(create_example(
    "Why do troop IDs in TFConstants start at 2?",
    "Troop IDs start at 2 (T_PEASANTS) rather than 0. IDs 0 and 1 are likely reserved:\n- 0 = None/Empty slot\n- 1 = Hero (heroes lead armies but aren't troops)\n\nThis is a common pattern but causes array indexing confusion. Always use `troopId - 2` when indexing troop arrays."
))

examples.append(create_example(
    "What is the gap between troops and fortifications in TFConstants?",
    "There's a gap between troop IDs (2-13) and fortification IDs (20-25). IDs 14-19 are unused. This separation allows:\n1. Easy category detection: `id < 20` = troop, `id >= 20` = fort\n2. Room for future troop types (14-19)\n3. Clean array separation\n\nBut it can cause issues if iterating sequentially."
))

# ============================================================================
# HERO CONSTANTS (HeroConstants.as)
# ============================================================================

hero_status = {
    0: ("HERO_FREE_STATU", "Hero is available in city. Note: Typo - should be STATUS."),
    1: ("HERO_CHIEF_STATU", "Hero is appointed as mayor/castellan."),
    2: ("HERO_DEFEND_STATU", "Hero is defending (in garrison). DUPLICATE in CityStateConstants!"),
    3: ("HERO_MARCH_STATU", "Hero is on march with an army."),
    4: ("HERO_SEIZED_STATU", "Hero is captured by enemy."),
    5: ("HERO_BACK_STATU", "Hero is returning from battle."),
    6: ("HERO_FLEE_STATU", "Hero is fleeing from battle."),
    7: ("HERO_FLEE_STATU2", "Hero fleeing (variant). BUG: Why two flee states?"),
}

for sid, (name, desc) in hero_status.items():
    examples.append(create_example(
        f"What is HeroConstants.{name}?",
        f"`HeroConstants.{name}` = {sid}. {desc}"
    ))

examples.append(create_example(
    "What is the HERO_FLEE_STATU vs HERO_FLEE_STATU2 bug?",
    "HeroConstants defines TWO flee states:\n- `HERO_FLEE_STATU = 6`\n- `HERO_FLEE_STATU2 = 7`\n\nThis is a BUG/unclear design. Possible explanations:\n1. Different flee conditions (voluntary vs forced)\n2. Flee phase 1 vs phase 2\n3. Copy-paste error\n\nRecommendation: Investigate usage and either document the difference or merge into single `HERO_STATUS_FLEEING`."
))

examples.append(create_example(
    "What is the HeroConstants duplication bug with CityStateConstants?",
    "Hero status constants are defined in BOTH files:\n\n**HeroConstants.as:**\n```\nHERO_DEFEND_STATU = 2\nHERO_MARCH_STATU = 3\nHERO_SEIZED_STATU = 4\n```\n\n**CityStateConstants.as:**\n```\nHERO_STATUS_DEFEND = 2\nHERO_STATUS_MARCH = 3\nHERO_STATUS_CAPTIVE = 4\n```\n\nThis creates maintenance nightmares. Fix: Consolidate all hero constants to HeroConstants.as only."
))

# ============================================================================
# FIELD CONSTANTS (FieldConstants.as)
# ============================================================================

field_types = {
    1: ("TYPE_FOREST", "Forest valley - Wood production"),
    2: ("TYPE_DESERT", "Desert valley - Stone production"),
    3: ("TYPE_HILL", "Hill valley - Iron production"),
    4: ("TYPE_SWAMP", "Swamp valley - Food production"),
    5: ("TYPE_GRASSLAND", "Grassland valley - Food production"),
    6: ("TYPE_LAKE", "Lake valley - Food production"),
    10: ("TYPE_FLAT", "Flat land - Can build city"),
    11: ("TYPE_CASTLE", "Castle location"),
    12: ("TYPE_NPC", "NPC city location"),
}

field_status = {
    0: ("STATUS_FREE", "Field is unclaimed/available"),
    2: ("STAUTS_OCCUPIED", "Field is occupied. TYPO: Should be STATUS_OCCUPIED!"),
    3: ("STAUTS_CASTLE", "Field has a castle. TYPO: Should be STATUS_CASTLE!"),
}

for fid, (name, desc) in field_types.items():
    examples.append(create_example(
        f"What is FieldConstants.{name}?",
        f"`FieldConstants.{name}` = {fid}. {desc}"
    ))

for sid, (name, desc) in field_status.items():
    examples.append(create_example(
        f"What is FieldConstants.{name}?",
        f"`FieldConstants.{name}` = {sid}. {desc}"
    ))

examples.append(create_example(
    "What are the typos in FieldConstants.as?",
    "FieldConstants has multiple TYPOS:\n\n1. `STAUTS_OCCUPIED` should be `STATUS_OCCUPIED`\n2. `STAUTS_CASTLE` should be `STATUS_CASTLE`\n3. `PRODUCE_SWAP_BASE` should be `PRODUCE_SWAMP_BASE`\n4. `PRODUCE_SWAP_RATE` should be `PRODUCE_SWAMP_RATE`\n\nThese typos can cause comparison failures if code uses correct spelling."
))

examples.append(create_example(
    "What is the missing field status in FieldConstants?",
    "FieldConstants has a gap in status values:\n- `STATUS_FREE = 0`\n- (Missing status 1)\n- `STAUTS_OCCUPIED = 2`\n- `STAUTS_CASTLE = 3`\n\nStatus 1 is undefined. Possible meanings:\n- `STATUS_PENDING` - Claim in progress\n- `STATUS_CONTESTED` - Under attack\n- Reserved for future use\n\nRecommendation: Add `STATUS_PENDING = 1` with documentation."
))

# ============================================================================
# ARMY CONSTANTS (ArmyConstants.as)
# ============================================================================

army_direction = {
    1: ("ARMY_FORWARD", "Army is marching outward"),
    2: ("ARMY_BACKWARD", "Army is returning"),
    3: ("ARMY_STAY", "Army is stationed/defending"),
}

army_mission = {
    1: ("ARMY_MISSION_TRANS", "Transport resources"),
    2: ("ARMY_MISSION_SEND", "Reinforce ally"),
    3: ("ARMY_MISSION_OCCUPY", "Occupy valley"),
    4: ("ARMY_MISSION_SCOUT", "Scout target"),
    5: ("ARMY_MISSION_ATTACK", "Attack target"),
}

for aid, (name, desc) in army_direction.items():
    examples.append(create_example(
        f"What is ArmyConstants.{name}?",
        f"`ArmyConstants.{name}` = {aid}. {desc}"
    ))

for mid, (name, desc) in army_mission.items():
    examples.append(create_example(
        f"What is ObjConstants.{name}?",
        f"`ObjConstants.{name}` = {mid}. {desc}"
    ))

examples.append(create_example(
    "What error codes are missing in ArmyConstants?",
    "ArmyConstants has a gap between CAN_SEND_ARMY (0) and CANT_COLONIZE_SUZERAIN_ALLIANCE (17). Codes 1-16 are missing but likely exist:\n\n```\nCAN_SEND_ARMY = 0\nCANT_SEND_NO_HERO = 1 (likely)\nCANT_SEND_NO_TROOPS = 2 (likely)\nCANT_SEND_ATTACK_FRESHMAN = 3 (likely)\n...\nCANT_COLONIZE_SUZERAIN_ALLIANCE = 17\n```\n\nRecommendation: Search codebase for army send error handling to document all codes."
))

# ============================================================================
# OBJ CONSTANTS (ObjConstants.as)
# ============================================================================

package_status = {
    2: ("PACKAGE_STATUS_AVAIBLE", "Package available. TYPO: Should be AVAILABLE!"),
    3: ("PACKAGE_STATUS_NOT_MET", "Package requirements not met"),
    4: ("PACKAGE_STATUS_HAD_GOT", "Package already claimed"),
    5: ("PACKAGE_STATUS_USED", "Package already used"),
}

for pid, (name, desc) in package_status.items():
    examples.append(create_example(
        f"What is ObjConstants.{name}?",
        f"`ObjConstants.{name}` = {pid}. {desc}"
    ))

examples.append(create_example(
    "What is the ObjConstants.PACKAGE_STATUS_AVAIBLE typo?",
    "`PACKAGE_STATUS_AVAIBLE` is a typo - should be `PACKAGE_STATUS_AVAILABLE`.\n\nThis typo can cause:\n1. IDE autocomplete failures\n2. String comparisons failing\n3. Confusion for developers\n\nFix: Rename to `PACKAGE_STATUS_AVAILABLE` and update all references."
))

# ============================================================================
# NPC HERO CONSTANTS (NpcHeroBean.as) - CRITICAL INCONSISTENCY
# ============================================================================

examples.append(create_example(
    "What is the NpcHeroBean version inconsistency bug?",
    "NpcHeroBean has THREE different versions with INCONSISTENT constants:\n\n**NpcHeroBean.as:**\n```\nCATCH_STATUS = 1\nGENERAL_NPC_HERO = 0\nHIRED_STATUS = 2\n```\n\n**NpcHeroBean_1.as:**\n```\nFREE_STATUS = 0\nCATCH_STATUS = 1\nHIRED_STATUS = 2\n```\n\n**NpcHeroBean_2.as:**\n```\nFREE_STATUS = 0\nHIRED_STATUS = 2\n// MISSING CATCH_STATUS!\n```\n\nFix: Consolidate to ONE file with complete constants."
))

examples.append(create_example(
    "What is the GENERAL_NPC_HERO vs FREE_STATUS conflict?",
    "Both `GENERAL_NPC_HERO` and `FREE_STATUS` equal 0, but mean different things:\n\n- `GENERAL_NPC_HERO = 0` - This is a TYPE (hero classification)\n- `FREE_STATUS = 0` - This is a STATUS (hero availability)\n\nFix: Separate into clear namespaces:\n```\n// Status\nSTATUS_FREE = 0\nSTATUS_CAPTURED = 1\nSTATUS_HIRED = 2\n\n// Type\nTYPE_GENERAL = 0\nTYPE_SPECIAL = 1\n```"
))

# ============================================================================
# COMMON CONSTANTS (CommonConstants.as)
# ============================================================================

examples.append(create_example(
    "What is the CommonConstants.UNFURL_ACHIEVMENT typo?",
    "`UNFURL_ACHIEVMENT = 115` should be `UNFURL_ACHIEVEMENT` (missing 'E').\n\nThis typo affects:\n1. Achievement system string matching\n2. Code readability\n3. API consistency\n\nFix: Rename to `UNFURL_ACHIEVEMENT` and update all references."
))

# ============================================================================
# COLONY CONSTANTS (ColonyConstants.as)
# ============================================================================

examples.append(create_example(
    "What are the ColonyConstants typos?",
    "ColonyConstants has ABANDON spelled as ABADON:\n\n```\nABADON_REASON_OCCUPY = 1  // Should be ABANDON_REASON_OCCUPY\nABADON_REASON_GIVEUP = 2  // Should be ABANDON_REASON_GIVEUP\n```\n\nFix: Rename with correct spelling."
))

# ============================================================================
# ANIMATION CONSTANTS (EvonyAnimation.as) - 250+ constants
# ============================================================================

examples.append(create_example(
    "How are animation constants organized in EvonyAnimation.as?",
    "EvonyAnimation.as contains 250+ animation type constants organized by building:\n\n```\n// Cottage animations\nTYPE_CottageCLv1 = 0\nTYPE_CottageStructCLv1 = 1\nTYPE_CottageCLv2 = 2\n...\n\n// Barracks animations  \nTYPE_BarracksStructCLv1 = 81\nTYPE_BarracksCLv2 = 82\n...\n\n// Town Hall animations\nTYPE_TownhallCLv4 = 126\nTYPE_TownhallStructCLv4 = 127\n```\n\nPattern: `TYPE_{Building}{Struct?}CLv{Level}`\n- CLv = Construction Level\n- Struct = Building phase animation"
))

# ============================================================================
# CROSS-REFERENCE EXAMPLES
# ============================================================================

examples.append(create_example(
    "How do TFConstants relate to army operations?",
    "TFConstants troop IDs are used throughout army operations:\n\n```actionscript\n// Building troops\nbarracks.train(TFConstants.T_ARCHER, 100);\n\n// Army composition\narmy.setTroops(TFConstants.T_CAVALRY, 500);\n\n// Battle calculations\nif (troopType == TFConstants.T_CATAPHRACT) {\n    // Heavy cavalry bonus\n}\n```\n\nNote: Always check ID ranges (2-13 for troops, 20-25 for forts)."
))

examples.append(create_example(
    "How should error codes be handled in Evony?",
    "Error handling best practices:\n\n```actionscript\nswitch (response.errorCode) {\n    case ErrorCode.RESOURCE_NOT_ENOUGH:\n        // Check which resource\n        break;\n    case ErrorCode.NO_DEPEND_BUILDING:\n        showBuildingRequirements();\n        break;\n    case ErrorCode.ALLIANCE_NOT_FOUND:\n        // BUG: Also matches SUPPORT_NOT_ZERO!\n        // Needs context to differentiate\n        break;\n    default:\n        log(\"Unknown error: \" + response.errorCode);\n}\n```\n\nNote: Always handle the -52 duplicate case by checking context."
))

# ============================================================================
# SUMMARY EXAMPLES
# ============================================================================

examples.append(create_example(
    "What are all the enum bugs in AutoEvony?",
    """**CRITICAL BUGS (3):**
1. ErrorCode -52 duplicate (ALLIANCE_NOT_FOUND & SUPPORT_NOT_ZERO)
2. NpcHeroBean 3 versions with inconsistent constants
3. GENERAL_NPC_HERO vs FREE_STATUS conflict

**HIGH SEVERITY (9):**
1. FieldConstants STAUTS_OCCUPIED typo
2. FieldConstants STAUTS_CASTLE typo
3. ObjConstants PACKAGE_STATUS_AVAIBLE typo
4. HeroConstants HERO_FLEE_STATU/FLEE_STATU2 duplicate
5. CityStateConstants HERO_STATUS duplicate
6. TFConstants ID gaps (0-1, 14-19)
7. ErrorCode generic -1
8. FieldConstants missing STATUS=1
9. NpcHeroBean missing CATCH_STATUS in v3

**MEDIUM SEVERITY (8):**
- ColonyConstants ABADON typos
- CommonConstants ACHIEVMENT typo
- FieldConstants PRODUCE_SWAP typos
- HeroConstants *_STATU suffix typos
- ArmyConstants missing codes 1-16
- TechConstants HARRY_SKILL unclear
- ErrorCode missing -56
- ErrorCode UNSUPPORT grammar

**LOW SEVERITY (7):**
- Various naming inconsistencies
- Missing optional constants
- Non-sequential IDs"""
))

examples.append(create_example(
    "List all constant files in AutoEvony",
    """**Constant Definition Files:**

1. `ErrorCode.as` - Error codes (200+)
2. `TFConstants.as` - Troop/Fortification types
3. `HeroConstants.as` - Hero status values
4. `FieldConstants.as` - Field/valley types
5. `ObjConstants.as` - Object/mission types
6. `ArmyConstants.as` - Army directions/status
7. `BuildingConstants.as` - Building types (40+)
8. `TechConstants.as` - Technology IDs
9. `CommonConstants.as` - Quest/effort types
10. `ColonyConstants.as` - Colony status
11. `CityStateConstants.as` - City state values
12. `MailConstants.as` - Mail types
13. `TradeConstants.as` - Trade resource types
14. `NpcHeroBean.as` - NPC hero constants
15. `EvonyAnimation.as` - Animation types (250+)

**Total:** 15 files, 500+ constants"""
))

# ============================================================================
# SAVE OUTPUT
# ============================================================================

print(f"Generated {len(examples)} enum training examples")

with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
    for ex in examples:
        f.write(json.dumps(ex) + '\n')

print(f"Saved to: {OUTPUT_FILE}")
print(f"Size: {OUTPUT_FILE.stat().st_size / 1024:.2f} KB")
