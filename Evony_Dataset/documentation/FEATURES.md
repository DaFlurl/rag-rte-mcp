# Svony Studio - Features

> **"Complete Feature Catalog"** - All Capabilities at a Glance

---

## Overview

Svony Studio is a specialized reverse engineering environment for Evony Age II, built on FFDec integration with additional tools for SOL management, protocol analysis, and bot development.

---

## Feature Status Legend

- ✅ **Implemented** - Fully functional
- ⚠️ **Partial** - Basic implementation
- 🔄 **Planned** - On roadmap
- ❌ **Not Planned** - Out of scope

---

## SWF Analysis Features

| Feature | Status | Description |
|---------|--------|-------------|
| SWF Loading | ✅ | Open and parse SWF files |
| SWF Info Display | ✅ | Version, compression, frame rate |
| Tag Tree Navigation | ⚠️ | Browse SWF tag structure |
| Hex Dump View | 🔄 | Raw binary inspection |
| SWF Header Display | ✅ | File metadata |
| Compression Detection | ✅ | ZLIB/LZMA/None |
| Frame Analysis | 🔄 | Timeline inspection |

---

## Decompilation Features

| Feature | Status | Description |
|---------|--------|-------------|
| ActionScript 3 Decompilation | ✅ | Via FFDec CLI |
| ActionScript 2 Decompilation | ✅ | Via FFDec CLI |
| P-Code View | 🔄 | Raw bytecode display |
| Constant Pool Display | 🔄 | String/number constants |
| Class Hierarchy | ✅ | Package/class tree |
| Method Listing | ✅ | Function browser |
| Cross-Reference | 🔄 | Find usages |

---

## Script Editing Features

| Feature | Status | Description |
|---------|--------|-------------|
| Script Viewing | ✅ | Read decompiled code |
| Script Editing | ⚠️ | Modify and save |
| Syntax Highlighting | 🔄 | ActionScript colors |
| Auto-Complete | 🔄 | Code suggestions |
| Error Checking | 🔄 | Compile-time errors |
| Script Search | ✅ | Find in scripts |
| Bulk Export | ✅ | Export all scripts |

---

## Asset Management Features

| Feature | Status | Description |
|---------|--------|-------------|
| Image Export | ✅ | PNG, JPG, BMP, GIF |
| Sound Export | ✅ | MP3, WAV, FLV |
| Font Export | ⚠️ | TTF, WOFF |
| Shape Export | ⚠️ | SVG, PNG |
| Binary Data Export | ⚠️ | Raw extraction |
| Asset Preview | ⚠️ | Thumbnail view |
| Asset Search | ✅ | Filter by type |
| Batch Export | ✅ | Export all assets |

---

## Import/Replace Features

| Feature | Status | Description |
|---------|--------|-------------|
| Script Import | ✅ | Replace ActionScript |
| Image Replace | ⚠️ | Swap graphics |
| Sound Replace | 🔄 | Swap audio |
| Binary Replace | 🔄 | Raw data swap |
| Bulk Import | 🔄 | Multiple files |
| Change Tracking | 🔄 | Modification log |

---

## SOL (SharedObject) Features

| Feature | Status | Description |
|---------|--------|-------------|
| SOL Scanning | ✅ | Find Evony SOL files |
| SOL Reading | ✅ | Parse AMF data |
| SOL Editing | ⚠️ | Modify values |
| SOL Export | ✅ | JSON export |
| SOL Import | ⚠️ | JSON import |
| Credential Extraction | ✅ | Find saved logins |
| Server List Extract | ✅ | Cached servers |
| Batch Operations | 🔄 | Multi-file editing |
| Backup Management | ✅ | Auto-backup |

---

## Evony-Specific Features

| Feature | Status | Description |
|---------|--------|-------------|
| Borg Mode Analysis | ✅ | Deep client scan |
| Network Call Finder | ✅ | Protocol extraction |
| Account Extraction | ✅ | From SOL files |
| Class Browser | ✅ | Evony class explorer |
| Protocol Documentation | ✅ | Command reference |
| Server URL Patching | ⚠️ | Redirect server |
| Version Check Bypass | ⚠️ | Skip updates |
| Quick Patches Menu | 🔄 | Common modifications |
| Bot Script Editor | ✅ | AutoEvony/RoboEvony |

---

## Bot Development Features

| Feature | Status | Description |
|---------|--------|-------------|
| Script Syntax Support | ✅ | AutoEvony/RoboEvony |
| Script Validation | ✅ | Error checking |
| Script Templates | ✅ | Common patterns |
| Bot Launcher | ⚠️ | Start bot instances |
| Account Manager | ⚠️ | Multi-account |
| Tor Integration | 🔄 | Anonymous operation |
| Protocol Capture | 🔄 | Traffic recording |

---

## Search Features

| Feature | Status | Description |
|---------|--------|-------------|
| Text Search | ✅ | Find in scripts |
| Regex Search | ✅ | Pattern matching |
| Cross-File Search | ✅ | Entire project |
| Replace | ⚠️ | Find and replace |
| Search History | 🔄 | Recent searches |
| Bookmarks | 🔄 | Save locations |

---

## Project Management Features

| Feature | Status | Description |
|---------|--------|-------------|
| Project Creation | ✅ | New project wizard |
| Project Loading | ✅ | Open existing |
| Project Saving | ✅ | Persist state |
| Recent Projects | ✅ | Quick access |
| Project Tree | ✅ | File browser |
| File Watching | 🔄 | Auto-refresh |

---

## Build System Features

| Feature | Status | Description |
|---------|--------|-------------|
| SWF Compression | ✅ | ZLIB/LZMA |
| SWF Decompression | ✅ | Unpack SWF |
| XML Round-Trip | ✅ | SWF ↔ XML |
| Projector Creation | ✅ | Standalone EXE |
| FLA Export | ⚠️ | Adobe format |
| Deobfuscation | ✅ | Multiple levels |

---

## Protocol Analysis Features

| Feature | Status | Description |
|---------|--------|-------------|
| AMF3 Decoding | ✅ | Parse messages |
| AMF3 Encoding | ✅ | Create messages |
| Traffic Capture | 🔄 | Proxy mode |
| Message Replay | 🔄 | Resend packets |
| Protocol Documentation | ✅ | Command reference |

---

## UI Features

| Feature | Status | Description |
|---------|--------|-------------|
| Dark Theme | ✅ | Borg-inspired |
| Tab Interface | ✅ | Multiple panels |
| Toolbar | ✅ | Quick actions |
| Status Bar | ✅ | Status display |
| Keyboard Shortcuts | ⚠️ | Key bindings |
| Settings Dialog | ⚠️ | Configuration |
| Console Output | ✅ | Log display |

---

## Comparison with FFDec

| Feature | FFDec | Svony Studio |
|---------|-------|--------------|
| SWF Editing | ✅ Full | ⚠️ Via FFDec |
| GUI Editor | ✅ Full | ⚠️ Basic |
| ABC Editing | ✅ Full | 🔄 Planned |
| Debugging | ✅ Yes | 🔄 Planned |
| SOL Editing | ❌ No | ✅ Yes |
| Evony-Specific | ❌ No | ✅ Yes |
| Bot Integration | ❌ No | ✅ Yes |
| Protocol Analysis | ❌ No | ⚠️ Partial |

---

## Platform Support

| Platform | Status |
|----------|--------|
| Windows 11 | ✅ Primary |
| Windows 10 | ✅ Supported |
| Linux (Ubuntu) | 🔄 Planned |
| macOS | 🔄 Planned |

---

## Future Features (Roadmap)

### Phase 1 (Q1 2026)
- Complete FFDec CLI integration
- Full SOL editor UI
- Protocol analyzer basics

### Phase 2 (Q2 2026)
- RABCDAsm integration
- ABC bytecode editor
- Advanced search

### Phase 3 (Q3 2026)
- Bot framework integration
- Tor support
- Plugin system

### Phase 4 (Q4 2026)
- Visual SWF editor
- Debugging support
- Performance optimization

---

## Related Documentation

- `USER_GUIDE.md` - Usage instructions
- `DEVELOPER_GUIDE.md` - Development setup
- `AUDIT_ROADMAP.md` - Implementation status
- `DEVELOPMENT_ROADMAP.md` - Future plans

---

*Document Version: 1.0.0 | Feature Status as of January 2026*
