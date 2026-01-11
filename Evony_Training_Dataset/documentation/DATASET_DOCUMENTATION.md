# Evony Training Dataset Documentation

## Overview

This dataset contains comprehensive training data for an Evony game knowledge model.

## Dataset Contents

### Game Data Files

#### all_bean_classes.json
- total_beans: int
- total_fields: int
- beans: dict

#### all_constants.json
- error_codes: dict
- building_types: dict
- troop_types: dict
- hero_status: dict
- army_missions: dict

#### all_extracted_constants.json
- total_classes: int
- constants: dict

#### all_protocol_commands.json
- total_commands: int
- categories: list
- commands: dict

#### bean_mappings.json
- CastleBean: dict
- HeroBean: dict
- ArmyBean: dict
- PlayerInfoBean: dict
- TroopBean: dict

#### buildings.json
- buildings: dict

#### building_requirements.json
- buildings: dict

#### combat_formulas.json
- damage_formula: dict
- hero_bonus: dict
- wall_defense_bonus: dict
- terrain_modifiers: dict
- range_advantage: dict

#### curation_report.json
- exclude_patterns: list
- duplicates: list
- junk_files: list
- empty_files: list
- quality_files: list

#### exploit_documentation.json
- total_exploits: int
- categories: dict
- exploits: list

#### items.json
- items: dict

#### keys_analysis.json
- total_files: int
- file_types: dict
- categories: dict
- json_accounts: list
- documentation: list

#### npcs.json
- npcs: dict

#### protocol_parameters.json
- commands: dict
- categories: list
- total_commands: int

#### research.json
- research: dict

#### research_tree.json
- research: dict

#### resource_formulas.json
- production_base: dict
- production_formula: str
- research_bonus_per_level: float
- hero_politics_effect: str
- valley_bonus: dict

#### response_handlers.json
- total_handlers: int
- handlers: dict

#### script_analysis.json
- total_scripts: int
- commands_used: dict
- patterns: list
- scripts: dict

#### troops.json
- troops: dict

#### troop_formulas.json
- troops: dict


### Training Data Format

Training examples are in Alpaca format:
```json
{
  "instruction": "Question or task",
  "input": "",
  "output": "Answer or response"
}
```

### Categories Covered

1. **Protocol Commands** - All 400+ Evony protocol commands
2. **Data Model** - 86 Bean classes with 732 fields
3. **Buildings** - 21 building types with requirements and costs
4. **Troops** - 13 troop types with stats and formulas
5. **Research** - Complete tech tree
6. **Error Codes** - 149 error code mappings
7. **Scripting** - AutoEvony script commands
8. **Security** - Encryption keys and signatures
9. **Combat** - Battle formulas and mechanics

### Usage

Load training data:
```python
import json
with open('evony_final_training.json') as f:
    training_data = json.load(f)
```

### Quality Notes

- Duplicates removed
- Junk files excluded (topics.py, mx.*, flash.*)
- Data validated against source code
