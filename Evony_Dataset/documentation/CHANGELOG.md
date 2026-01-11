# BORG TOOLKIT - Changelog

All notable changes to this project are documented in this file.

---

## [1.0.0] - 2026-01-04 - Account Extraction Release

### Added
- **Complete Account Import System**
  - Multi-format import: CSV, TXT, JSON, XLSX, RTF, PDF
  - Auto-scan 4 account directories
  - Deduplication by email
  - 479 accounts with passwords extracted

- **Login Validation with Retry**
  - `src/login_validator.py` - Full validation system
  - 3-5 retry attempts per account
  - SOCKS4/5 proxy support for Tor
  - Failed account export for editing

- **AMF Protocol Integration**
  - `src/amf_commander.py` - Direct server commands
  - Extracted encryption keys
  - Session management
  - Rate limiting

- **Output Formats**
  - `cc2.evony@user:pass` format
  - Plain `user:pass` format
  - CSV with server column
  - JSON complete dump
  - AutoEvony script format
  - Proxy batch files (10 accounts per port)

- **Tor/Proxy Support**
  - SOCKS4 ports 9000-9999
  - 10 accounts per IP limit
  - Automatic rotation
  - Batch file generation

- **Data Models**
  - `src/data_models.py` - Complete 1:1 extraction models
  - `src/output_generator.py` - JSON/CSV/HTML/TXT outputs

### Files Created
- `src/account_importer.py`
- `src/login_validator.py`
- `src/amf_commander.py`
- `src/data_models.py`
- `src/output_generator.py`
- `scan_all_accounts.py`
- `generate_login_files.py`
- `export_accounts.py`
- `test_login.py`

---

## [2.0.0] - 2026-01-03

### Added
- **Advanced Exploit Server** (`advanced_server.py`)
  - HTTP server for dynamic script injection
  - 10+ epic exploit chains
  - Calculator endpoints for overflow values
  - Raw command API

- **Protocol Commands Registry** (`src/protocol_commands.py`)
  - Complete extraction of 301+ protocol commands
  - Command categories and parameters
  - Exploit annotations for vulnerable commands

- **Exploit Discovery Engine** (`src/exploit_engine.py`)
  - Automated exploit generation
  - Integer overflow calculator for all troops
  - Race condition chain generator
  - Fuzzing value generators

- **Discovery Scripts**
  - `scripts/discovery/ultimate_overflow_chain.txt`
  - `scripts/discovery/race_condition_blitz.txt`

- **Comprehensive Documentation**
  - `docs/PROTOCOL.md` - Full protocol reference
  - `docs/SETUP.md` - Installation guide
  - `docs/AUTOEVONY_INTEGRATION.md` - Bot integration
  - `diagrams/protocol_flow.md` - Visual protocol flows
  - `diagrams/command_reference.md` - Command maps
  - `diagrams/exploit_chains.md` - Exploit chain diagrams

### Changed
- Updated `README.md` with all new features
- Enhanced `docs/EXPLOITS.md` with all overflow thresholds
- Updated `docs/ACTION_PLAN.md` with completion status

---

## [1.0.0] - 2026-01-03

### Added
- **Core Modules**
  - `src/connection.py` - Server connection with AMF support
  - `src/injection.py` - Packet forging with encryption keys
  - `src/exploits.py` - Working exploit implementations
  - `src/cheats.py` - Automated cheat sequences
  - `src/bot_integration.py` - AutoEvony script generator
  - `src/client_wrapper.py` - evony_client wrapper

- **Basic Script Server** (`script_server.py`)
  - HTTP server for AutoEvony `includeurl`
  - Basic exploit scripts

- **Ready-to-Use Scripts**
  - `scripts/01_troop_overflow.txt`
  - `scripts/02_valley_hide.txt`
  - `scripts/03_gold_farm.txt`
  - `scripts/04_item_rapid_use.txt`
  - `scripts/05_auto_quest.txt`
  - `scripts/06_amulet_spin.txt`

- **Interactive Launcher** (`run_borg.py`)
  - Command-line interface
  - Exploit selection menu

- **Initial Documentation**
  - `README.md`
  - `docs/ACTION_PLAN.md`
  - `docs/EXPLOITS.md`
  - `diagrams/architecture.md`

---

## Encryption Keys (Extracted)

```
ACTION_KEY = TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}
API_KEY = 9f758e2deccbe6244f734371b9642eda
USER_INFO_KEY = IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}
XOR_KEY = 0xAA
LOGIN_SALT = evony
```

---

## Overflow Thresholds (Calculated)

| Troop | Cost | Threshold |
|-------|------|-----------|
| Worker | 50 | 42,949,673 |
| Warrior | 75 | 28,633,116 |
| Scout | 100 | 21,474,837 |
| Pikeman | 200 | 10,737,419 |
| Swordsman | 250 | 8,589,935 |
| Archer | 350 | 6,135,037 |
| Cavalry | 800 | 2,684,355 |
| Cataphract | 1500 | 1,431,656 |
| Transporter | 300 | 7,158,279 |
| Ballista | 2000 | 1,073,742 |
| Ram | 2500 | 858,994 |
| Catapult | 3000 | 715,828 |

---

## Protocol Commands (301+)

Categories: troop, shop, common, army, castle, city, hero, quest, alliance, colony, trade, tech, equipment, fortifications, interior, report, mail, rank, friend, capital, visit, npcHero, vote, modify, furlough, truce, stratagem, gamblingranking, commission

---

*BORG TOOLKIT - Resistance is Futile*
