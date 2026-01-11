# Svony Studio Documentation Index

> **Complete Documentation for Svony Studio**  
> *FFDec-based SWF Analysis and Evony Research Tool*

---

## Quick Links

- [Quick Start Guide](QUICK_START.md) - Get started in 5 minutes
- [Installation Guide](INSTALLATION_GUIDE.md) - Platform-specific setup
- [Features Overview](FEATURES.md) - What Svony Studio can do
- [Keyboard Shortcuts](KEYBOARD_SHORTCUTS.md) - Quick reference
- [Glossary](GLOSSARY.md) - Terms and definitions
- [Codebase Audit](CODEBASE_AUDIT.md) - 1:1 code/docs verification

---

## 📚 User Documentation

### Getting Started
| Document | Description |
|----------|-------------|
| [Quick Start](QUICK_START.md) | 5-minute introduction |
| [Installation Guide](INSTALLATION_GUIDE.md) | Windows, Linux, macOS, Docker |
| [User Guide](USER_GUIDE.md) | Comprehensive usage guide |
| [Features](FEATURES.md) | Complete feature catalog |
| [FAQ](FAQ.md) | Frequently asked questions |
| [Glossary](GLOSSARY.md) | Terms and definitions |

### Reference
| Document | Description |
|----------|-------------|
| [Keyboard Shortcuts](KEYBOARD_SHORTCUTS.md) | All shortcuts reference |
| [CLI Reference](CLI_REFERENCE.md) | Command-line interface |
| [Configuration](CONFIGURATION.md) | Config file options |
| [Troubleshooting](TROUBLESHOOTING.md) | Common issues and fixes |

### Tutorials & Guides
| Document | Description |
|----------|-------------|
| [Tutorials](TUTORIALS.md) | Step-by-step workflows |
| [ABC Explorer Guide](ABC_EXPLORER.md) | Bytecode analysis |
| [AMF Editor Guide](AMF_EDITOR.md) | AMF data editing |
| [Memory Search Guide](MEMORY_SEARCH.md) | Runtime memory analysis |
| [Proxy Tool Guide](PROXY_TOOL.md) | Network traffic capture |

---

## 🎮 Evony-Specific Documentation

### Game Mechanics
| Document | Description |
|----------|-------------|
| [Battle Mechanics](evony/BATTLE_MECHANICS.md) | Combat formulas and data |
| [Troop Data](evony/TROOP_DATA.md) | Complete troop statistics |
| [NPC Farming](evony/NPC_FARMING.md) | Farming strategies and compositions |

### Protocol & Client
| Document | Description |
|----------|-------------|
| [Evony Protocol](evony/EVONY_PROTOCOL.md) | AMF protocol documentation |
| [Command Reference](evony/COMMAND_REFERENCE.md) | All command IDs |
| [Client Structure](evony/CLIENT_STRUCTURE.md) | SWF analysis |

### Bot Development
| Document | Description |
|----------|-------------|
| [Bot Integration](evony/BOT_INTEGRATION.md) | pyEvony, RoboEvony, AutoEvony |
| [Bot Scripting](evony/BOT_SCRIPTING.md) | Script language reference |
| [Resources](evony/RESOURCES.md) | External links and tools |

---

## 🔧 Developer Documentation

### Architecture
| Document | Description |
|----------|-------------|
| [Architecture](ARCHITECTURE.md) | System design overview |
| [API Reference](API_REFERENCE.md) | Python API documentation |
| [Developer Guide](DEVELOPER_GUIDE.md) | Development setup |
| [Codebase Audit](CODEBASE_AUDIT.md) | Code verification report |

### Extending
| Document | Description |
|----------|-------------|
| [Plugin Development](PLUGIN_DEVELOPMENT.md) | Creating plugins |
| [Extending](EXTENDING.md) | Extension points |
| [Contributing](CONTRIBUTING.md) | Contribution guidelines |

### Quality
| Document | Description |
|----------|-------------|
| [Testing Strategy](TESTING_STRATEGY.md) | Testing approach |
| [Performance](PERFORMANCE.md) | Optimization guide |
| [Performance Benchmarks](PERFORMANCE_BENCHMARKS.md) | Detailed benchmarks |
| [Security](SECURITY.md) | Security best practices |

### File Formats
| Document | Description |
|----------|-------------|
| [SWF Format](formats/SWF_FORMAT.md) | SWF structure |
| [SOL Format](formats/SOL_FORMAT.md) | SOL file format |
| [AMF Encoding](formats/AMF_ENCODING.md) | AMF3 specification |
| [Obfuscators](OBFUSCATORS.md) | Deobfuscation support |

---

## 📊 Project Planning

| Document | Description |
|----------|-------------|
| [Development Roadmap](DEVELOPMENT_ROADMAP.md) | Feature timeline |
| [Audit Roadmap](AUDIT_ROADMAP.md) | Code quality plan |
| [Changelog](CHANGELOG.md) | Version history |
| [FFDec Gap Analysis](FFDEC_GAP_ANALYSIS.md) | Feature comparison |
| [FFDec Implementation Roadmap](FFDEC_IMPLEMENTATION_ROADMAP.md) | Implementation plan |

---

## 📐 Diagrams (52 Total)

All diagrams are in `diagrams/` directory as SVG files:

### Architecture & Flow (6 diagrams)
| Diagram | Description |
|---------|-------------|
| architecture.svg | System architecture |
| data_flow.svg | Data flow diagram |
| project_structure.svg | Project layout |
| build_pipeline.svg | Build process |
| complete_workflow.svg | Full user workflow |
| ffdec_integration.svg | FFDec integration |

### Features & UI (12 diagrams)
| Diagram | Description |
|---------|-------------|
| feature_map.svg | Feature overview |
| complete_feature_map.svg | Detailed features |
| studio_layout.svg | Main interface |
| menu_structure.svg | Menu hierarchy |
| toolbar_detail.svg | Toolbar buttons |
| script_editor.svg | Script editor |
| asset_browser.svg | Asset browser |
| sol_manager_panel.svg | SOL manager |
| search_console.svg | Search panel |
| settings_dialog.svg | Settings |
| keyboard_shortcuts.svg | Shortcuts |
| installation_overview.svg | Install guide |

### Evony Analysis (6 diagrams)
| Diagram | Description |
|---------|-------------|
| evony_architecture.svg | Game client structure |
| evony_login_flow.svg | Login sequence |
| evony_map_structure.svg | Map data |
| battle_mechanics.svg | Combat system |
| troop_stats.svg | Troop statistics |
| npc_farming_strategy.svg | Farming flow |

### Protocol & Data (7 diagrams)
| Diagram | Description |
|---------|-------------|
| amf_protocol.svg | AMF format |
| amf_data_types.svg | AMF3 types |
| network_protocol.svg | Network layer |
| protocol_command_flow.svg | Command flow |
| sol_structure.svg | SOL format |
| swf_structure.svg | SWF format |
| flash_assets.svg | Flash assets |

### Bot Development (6 diagrams)
| Diagram | Description |
|---------|-------------|
| bot_execution.svg | Bot execution flow |
| bot_integration_architecture.svg | Integration |
| roboevony_structure.svg | RoboEvony |
| autoevony_structure.svg | AutoEvony |
| credential_extraction.svg | Credential flow |
| proxy_capture.svg | Traffic capture |

### Analysis Tools (8 diagrams)
| Diagram | Description |
|---------|-------------|
| borg_mode.svg | Borg Mode analysis |
| abc_bytecode.svg | ABC structure |
| class_hierarchy.svg | Class browser |
| deobfuscation_flow.svg | Deobfuscation |
| string_extraction.svg | String extraction |
| re_methodology.svg | RE methodology |
| patch_system.svg | Patching system |
| memory_search.svg | Memory search |

### Configuration & System (7 diagrams)
| Diagram | Description |
|---------|-------------|
| plugin_architecture.svg | Plugin system |
| testing_pyramid.svg | Testing strategy |
| security_layers.svg | Security model |
| performance_metrics.svg | Performance data |
| theme_manager.svg | Theme system |
| tor_manager.svg | Tor integration |
| config_system.svg | Configuration |

---

## 📝 Documentation Statistics

| Category | Count | Status |
|----------|-------|--------|
| User Docs | 13 | ✅ Complete |
| Evony Docs | 9 | ✅ Complete |
| Developer Docs | 13 | ✅ Complete |
| Format Docs | 4 | ✅ Complete |
| SVG Diagrams | 52 | ✅ Complete |
| **Total Files** | **91+** | **✅ Complete** |

---

## 🔍 Codebase Module Coverage

| Module Category | Files | Documented |
|-----------------|-------|------------|
| Core (`src/core/`) | 17 | ✅ 100% |
| Evony (`src/evony/`) | 4 | ✅ 100% |
| UI (`src/ui/`) | 14 | ✅ 100% |
| Tests (`tests/`) | 15 | ✅ 100% |

See [CODEBASE_AUDIT.md](CODEBASE_AUDIT.md) for full verification report.

---

## 🔍 Search Tips

- Use `Ctrl+F` in your browser to search this page
- Most documents have internal search with `Ctrl+F`
- CLI: `python main.py docs search "keyword"`

---

*Last Updated: January 2, 2026*  
*Documentation Version: 1.0.0*  
*Audit Status: ✅ VERIFIED*
