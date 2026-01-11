# Changelog

All notable changes to Svony Studio will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] - 2026-01-02

### 🎉 Initial Release - "Resistance is Futile"

Complete rebrand from "Evony SWF Studio" to **Svony Studio** with Borg-themed UI.

### Added

#### Core Features
- **Borg-themed UI** with dark green color scheme
- **FFDec integration** for SWF decompilation via CLI
- **SWFTools integration** for additional analysis
- **SOL Manager** for Flash cookie scanning and parsing
- **Project system** with `.svony` project files
- **Configuration manager** with persistent settings

#### User Interface
- Modern CustomTkinter-based interface
- Tabbed content area (Overview, Scripts, Assets, Search, Console)
- Project Explorer panel with tree view
- SOL Manager panel with account list
- Toolbar with quick action buttons
- Status bar with file info and memory usage
- Full menu system (File, Edit, View, Tools, Evony, Help)

#### Evony-Specific Features
- **⬢ Borg Mode** - Comprehensive analysis (`Ctrl+B`)
- **Account scanning** - Find Evony accounts in SOL files
- **Quick patches** menu for common modifications
- **Class browser** for Evony-specific classes
- **Protocol documentation** integration
- **Bot script management** placeholder

#### Tools Integration
- Open in FFDec (`F5`)
- Run in Flash Player (`F6`)
- Run in Ruffle (`F7`)
- Export scripts, images, sounds
- Batch decompilation support

#### Documentation
- Comprehensive README.md
- AI art prompts for branding
- Architecture documentation
- Audit roadmap

### Technical Details
- Python 3.10+ with CustomTkinter
- 54KB main.py with full UI implementation
- Modular core architecture (swf_tools, sol_manager, project, config)
- Cross-platform path handling
- Logging system with rotation

### Known Limitations
- 40 placeholder methods awaiting implementation
- Settings dialog not yet functional
- Search engine not yet implemented
- Asset thumbnails not yet rendered
- Script syntax highlighting pending

---

## [Unreleased]

### Planned for v1.1.0
- [ ] Settings dialog implementation
- [ ] Project wizard
- [ ] Search engine with regex support
- [ ] Script viewer with syntax highlighting
- [ ] Asset browser with thumbnails

### Planned for v1.2.0
- [ ] SOL editor dialog
- [ ] Quick patches implementation
- [ ] Evony class browser
- [ ] Protocol analyzer
- [ ] Bot script editor

### Planned for v2.0.0
- [ ] Plugin system
- [ ] Theme customization
- [ ] Multi-language support
- [ ] Advanced debugging tools

---

## Version History Summary

| Version | Date | Codename | Highlights |
|---------|------|----------|------------|
| 1.0.0 | 2026-01-02 | "Resistance is Futile" | Initial Borg-themed release |

---

## Migration Notes

### From Evony SWF Studio

If migrating from the original "Evony SWF Studio":

1. **Project Files:** Old project files are not compatible
2. **Config:** Settings need to be reconfigured
3. **SOL Data:** Re-scan for accounts after migration

### File Extension Change

- Old: `.eswfs` project files
- New: `.svony` project files

---

## Contributors

- **Borg** (Dave) - Creator and maintainer
- **Claude** - AI-assisted development

---

*"We are the Borg. Your SWF files will be assimilated."*
