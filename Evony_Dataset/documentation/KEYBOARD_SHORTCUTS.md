# Svony Studio - Keyboard Shortcuts Reference

> **"Quick Commands"** - Complete Keyboard Shortcut Guide

---

## Overview

This document lists all keyboard shortcuts available in Svony Studio. Shortcuts are organized by context and functionality.

---

## Global Shortcuts

### File Operations

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+N` | New Project | Create new project |
| `Ctrl+O` | Open | Open SWF or project |
| `Ctrl+S` | Save | Save current project |
| `Ctrl+Shift+S` | Save As | Save with new name |
| `Ctrl+W` | Close Tab | Close current tab |
| `Ctrl+Shift+W` | Close All | Close all tabs |
| `Ctrl+Q` | Quit | Exit application |

### Edit Operations

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+Z` | Undo | Undo last action |
| `Ctrl+Y` | Redo | Redo undone action |
| `Ctrl+X` | Cut | Cut selection |
| `Ctrl+C` | Copy | Copy selection |
| `Ctrl+V` | Paste | Paste clipboard |
| `Ctrl+A` | Select All | Select all text |
| `Ctrl+F` | Find | Open find dialog |
| `Ctrl+H` | Replace | Open find/replace |
| `F3` | Find Next | Find next occurrence |
| `Shift+F3` | Find Previous | Find previous |

### View Operations

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+Tab` | Next Tab | Switch to next tab |
| `Ctrl+Shift+Tab` | Previous Tab | Switch to previous tab |
| `Ctrl+1` | Project Tab | Switch to project tree |
| `Ctrl+2` | Scripts Tab | Switch to script editor |
| `Ctrl+3` | Assets Tab | Switch to asset browser |
| `Ctrl+4` | SOL Tab | Switch to SOL manager |
| `Ctrl+5` | Console Tab | Switch to console |
| `F11` | Fullscreen | Toggle fullscreen |
| `Ctrl++` | Zoom In | Increase font size |
| `Ctrl+-` | Zoom Out | Decrease font size |
| `Ctrl+0` | Reset Zoom | Reset to default size |

---

## Project Tree Shortcuts

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Enter` | Open | Open selected item |
| `Delete` | Delete | Delete selected item |
| `F2` | Rename | Rename selected item |
| `Ctrl+E` | Expand All | Expand all nodes |
| `Ctrl+Shift+E` | Collapse All | Collapse all nodes |
| `Arrow Up/Down` | Navigate | Move selection |
| `Arrow Left` | Collapse | Collapse node |
| `Arrow Right` | Expand | Expand node |

---

## Script Editor Shortcuts

### Navigation

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+G` | Go to Line | Jump to line number |
| `Ctrl+L` | Go to Function | Jump to function |
| `Ctrl+B` | Go to Definition | Jump to definition |
| `Alt+Left` | Back | Previous location |
| `Alt+Right` | Forward | Next location |
| `Ctrl+Home` | Start of File | Jump to beginning |
| `Ctrl+End` | End of File | Jump to end |

### Editing

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Tab` | Indent | Indent selection |
| `Shift+Tab` | Outdent | Remove indent |
| `Ctrl+D` | Duplicate Line | Copy line below |
| `Ctrl+Shift+K` | Delete Line | Remove current line |
| `Alt+Up` | Move Line Up | Swap with line above |
| `Alt+Down` | Move Line Down | Swap with line below |
| `Ctrl+/` | Toggle Comment | Comment/uncomment |
| `Ctrl+Shift+/` | Block Comment | Toggle block comment |

### Selection

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+Shift+L` | Select All Occurrences | Select matching text |
| `Ctrl+D` | Add Selection | Add next occurrence |
| `Alt+Click` | Multi-Cursor | Add cursor at click |
| `Ctrl+Shift+Up/Down` | Add Cursor | Multi-line cursor |

---

## Asset Browser Shortcuts

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+E` | Export Selected | Export selection |
| `Ctrl+Shift+E` | Export All | Export all assets |
| `Space` | Preview | Preview selected asset |
| `Delete` | Delete | Remove from project |
| `Ctrl+F` | Filter | Focus filter input |

---

## SOL Manager Shortcuts

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+R` | Refresh | Rescan SOL files |
| `Ctrl+E` | Export | Export to JSON |
| `Ctrl+I` | Import | Import from JSON |
| `Ctrl+B` | Backup | Create backup |
| `Enter` | Edit | Edit selected value |
| `Delete` | Delete Entry | Remove entry |

---

## Console Shortcuts

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+L` | Clear | Clear console |
| `Ctrl+S` | Save Log | Export log to file |
| `Ctrl+F` | Filter | Filter messages |
| `Escape` | Close | Close search/filter |

---

## FFDec Operations

| Shortcut | Action | Description |
|----------|--------|-------------|
| `F5` | Run | Run SWF in Flash Player |
| `F6` | Run in Ruffle | Open in Ruffle |
| `F7` | Decompile | Decompile selected |
| `F8` | Recompile | Recompile changes |
| `Ctrl+Shift+D` | Deobfuscate | Run deobfuscator |

---

## Bot Script Editor

| Shortcut | Action | Description |
|----------|--------|-------------|
| `F5` | Run Script | Execute script |
| `F6` | Stop Script | Stop execution |
| `F9` | Toggle Breakpoint | Add/remove breakpoint |
| `F10` | Step Over | Debug step over |
| `F11` | Step Into | Debug step into |
| `Ctrl+Shift+V` | Validate | Check syntax |

---

## Search Operations

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+Shift+F` | Global Search | Search all files |
| `Ctrl+Shift+H` | Global Replace | Replace in all files |
| `Alt+Enter` | Replace All | Replace all matches |
| `Escape` | Close Search | Close search panel |

---

## Tool Shortcuts

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+Shift+P` | Command Palette | Open command palette |
| `Ctrl+,` | Settings | Open settings |
| `Ctrl+Shift+T` | Terminal | Open terminal panel |
| `Ctrl+Shift+B` | Build | Run build task |

---

## Customization

### Modifying Shortcuts

1. Open Settings (`Ctrl+,`)
2. Navigate to "Keyboard Shortcuts"
3. Find command to modify
4. Click shortcut field
5. Press new key combination
6. Save changes

### Import/Export Keybindings

```json
// config/keybindings.json
{
    "file.new": "Ctrl+N",
    "file.open": "Ctrl+O",
    "file.save": "Ctrl+S",
    "edit.find": "Ctrl+F",
    "view.fullscreen": "F11"
}
```

---

## Platform-Specific

### Windows

- Uses `Ctrl` as primary modifier
- `Alt+F4` closes application
- `Win+Arrow` for window management

### macOS (Planned)

| Windows | macOS |
|---------|-------|
| `Ctrl` | `Cmd` |
| `Alt` | `Option` |
| `Ctrl+Q` | `Cmd+Q` |

### Linux (Planned)

- Same as Windows
- May vary by desktop environment

---

## Cheat Sheet

### Most Used

```
Ctrl+O      Open file/project
Ctrl+S      Save
Ctrl+F      Find
Ctrl+G      Go to line
Ctrl+/      Toggle comment
F5          Run SWF
```

### Quick Reference Card

```
┌─────────────────────────────────────────────┐
│           SVONY STUDIO SHORTCUTS            │
├─────────────────────────────────────────────┤
│ FILE         │ EDIT         │ VIEW         │
│ Ctrl+N New   │ Ctrl+Z Undo  │ Ctrl+Tab Tab │
│ Ctrl+O Open  │ Ctrl+C Copy  │ F11 Full     │
│ Ctrl+S Save  │ Ctrl+V Paste │ Ctrl+0 Reset │
├─────────────────────────────────────────────┤
│ SEARCH       │ SCRIPT       │ TOOLS        │
│ Ctrl+F Find  │ F5 Run       │ Ctrl+, Set   │
│ F3 Next      │ F9 Break     │ Ctrl+R Refr  │
│ Ctrl+H Repl  │ Ctrl+/ Comm  │ Ctrl+B Build │
└─────────────────────────────────────────────┘
```

---

## Related Documentation

- `USER_GUIDE.md` - General usage
- `QUICK_START.md` - Getting started
- `FAQ.md` - Common questions

---

*Document Version: 1.0.0 | Shortcuts may vary by platform*
