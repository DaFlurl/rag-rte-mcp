# 🔧 IMMEDIATE FIXES REQUIRED - PHASE 0
## Critical Stub Functions and Missing Wiring

---

> **Purpose**: Specific code fixes needed to achieve working functionality
> **Priority**: Complete ALL items in this document FIRST before adding new features
> **Policy**: Every function must DO something real - no more logging without action

---

## 🔴 SECTION 1: STUB FUNCTIONS TO FIX

### Issue #1: Protocol Sniffer Not Connected to Backend
**Location**: `main.py` line ~1890
**Current State**: Creates UI elements but doesn't connect to actual capture

**BEFORE** (UI-only stub):
```python
def _protocol_sniffer(self):
    """Launch protocol sniffer dialog"""
    # ... creates UI but buttons don't do anything
    capture_btn = ctk.CTkButton(btn_frame, text="▶ Start Capture",
                                 fg_color=self.COLORS["accent_green"], text_color="black")
    # No command attached!
```

**AFTER** (Wired to real functionality):
```python
def _protocol_sniffer(self):
    """Launch protocol sniffer dialog"""
    from src.core.protocol_analyzer import get_protocol_analyzer
    
    self.protocol_analyzer = get_protocol_analyzer()
    
    # ... UI creation ...
    
    def start_capture():
        host = host_entry.get() or "game.evony.com"
        port = int(port_entry.get() or "443")
        self.protocol_analyzer.start_capture(host, port, callback=update_packet_list)
        capture_btn.configure(text="⏹ Stop", command=stop_capture)
    
    def stop_capture():
        self.protocol_analyzer.stop_capture()
        capture_btn.configure(text="▶ Start", command=start_capture)
    
    def update_packet_list(packet):
        packet_tree.insert("", "end", values=(
            packet.timestamp.strftime("%H:%M:%S"),
            packet.direction,
            packet.command,
            f"{len(packet.raw_data)} bytes"
        ))
    
    capture_btn = ctk.CTkButton(btn_frame, text="▶ Start Capture",
                                 fg_color=self.COLORS["accent_green"],
                                 command=start_capture)  # ← NOW CONNECTED
```

---

### Issue #2: Running Bots Stop/Restart Not Actually Killing Processes
**Location**: `src/ui/panels/running_bots_panel.py`
**Current State**: Removes from UI list but doesn't terminate actual processes

**FIX** in `_stop_selected()`:
```python
def _stop_selected(self):
    """Stop selected bot - MUST actually kill the process"""
    selection = self.tree.selection()
    if not selection:
        return
    
    for item_id in selection:
        item = self.tree.item(item_id)
        values = item["values"]
        pid = values[1]  # PID is second column
        
        # CRITICAL: Actually terminate the process
        import subprocess
        import platform
        
        if platform.system() == "Windows":
            subprocess.run(["taskkill", "/F", "/PID", str(pid)], 
                          capture_output=True)
        else:
            subprocess.run(["kill", "-9", str(pid)], 
                          capture_output=True)
        
        # Then remove from UI
        self.tree.delete(item_id)
        
        if self.on_stop:
            self.on_stop({"account": values[0], "pid": pid})
```

---

### Issue #3: Tor New Identity Not Calling Tor Control Port
**Location**: `src/ui/panels/tor_status_panel.py`
**Current State**: Callback exists but doesn't actually communicate with Tor

**FIX**:
```python
def _request_new_identity(self):
    """Request new Tor identity - MUST use control port"""
    from src.core.tor_manager import get_tor_manager
    
    tor = get_tor_manager()
    
    try:
        success = tor.new_identity()  # This sends NEWNYM to control port
        if success:
            self._update_status("New identity obtained")
            self._refresh_circuits()
        else:
            self._update_status("Failed to get new identity", error=True)
    except Exception as e:
        self._update_status(f"Tor error: {e}", error=True)
    
    if self.on_new_identity:
        self.on_new_identity()
```

---

### Issue #4: Asset Filter Just Logs
**Location**: `main.py` line ~1655
**Current State**: `_filter_assets()` logs but doesn't actually filter

**Already partially fixed, but ensure this line exists**:
```python
def _filter_assets(self):
    """Filter assets by category"""
    category = self.asset_category.get()
    
    # MUST: Actually filter the displayed assets
    if hasattr(self, 'asset_preview'):
        self.asset_preview.asset_type.set(category)
        self.asset_preview._filter_assets()  # ← Calls real filter
```

---

## 🔴 SECTION 2: MISSING PANEL IMPORTS

### Issue #5: AssetBrowserPanel Not Imported
**Location**: `main.py` imports section

**ADD to imports**:
```python
from src.ui.panels.asset_panel import AssetBrowserPanel
from src.ui.panels.city_panel import CityPanel
from src.ui.panels.hero_panel import HeroPanel
from src.ui.panels.map_panel import MapPanel
from src.ui.panels.army_dialog import ArmyDialog
```

**ADD to _create_assets_tab()**:
```python
def _create_assets_tab(self):
    """Create the assets browser tab"""
    tab = self.tab_view.tab("🎨 Assets")
    
    # USE THE REAL ASSET BROWSER PANEL
    self.asset_browser = AssetBrowserPanel(
        tab,
        on_asset_select=self._on_asset_selected,
        on_export=self._on_asset_export
    )
    self.asset_browser.pack(fill="both", expand=True, padx=5, pady=5)
```

---

## 🔴 SECTION 3: MENU ITEMS NOT WIRED

### Issue #6: Evony Menu Items Just Log
**Location**: `main.py` ~line 400-450

**FIX each menu item**:

```python
# In _create_menu_bar() -> Evony menu:

evony_menu.add_command(
    label="🔍 Find Network Calls",
    command=self._find_network_calls  # ← Must be implemented
)

# Add the implementation:
def _find_network_calls(self):
    """Find network calls in loaded SWF"""
    if not self.current_swf:
        messagebox.showwarning("No SWF", "Load a SWF first")
        return
    
    from src.core.evony_tools import EvonyAnalyzer
    analyzer = EvonyAnalyzer()
    results = analyzer.find_network_calls(self.current_swf)
    
    # Display results in search tab
    self.tab_view.set("🔍 Search")
    self.search_results.delete("1.0", "end")
    self.search_results.insert("1.0", f"Found {len(results)} network calls:\n\n")
    for r in results:
        self.search_results.insert("end", f"📡 {r.class_name}.{r.method_name}\n")
        self.search_results.insert("end", f"   Line {r.line}: {r.code_snippet}\n\n")
```

---

## 🔴 SECTION 4: NEW PANELS TO CREATE

### Panel #1: Crypto Tools Panel
**File**: `src/ui/panels/crypto_panel.py`
**Tab Location**: New "🔐 Crypto" tab

```python
"""
Crypto Tools Panel - Encryption/Decryption utilities for Evony data
"""
import customtkinter as ctk
import tkinter as tk
from typing import Optional, Callable

class CryptoToolsPanel(ctk.CTkFrame):
    """Panel for encryption/decryption tools"""
    
    COLORS = {
        "bg_dark": "#0a0a0a",
        "bg_medium": "#1a1a1a",
        "bg_light": "#2a2a2a",
        "accent_green": "#00ff00",
        "accent_cyan": "#00ffff",
        "text_primary": "#e0e0e0",
        "text_secondary": "#808080",
    }
    
    def __init__(self, parent, **kwargs):
        super().__init__(parent, fg_color=self.COLORS["bg_dark"], **kwargs)
        self._create_ui()
    
    def _create_ui(self):
        """Create the panel UI"""
        # Header
        header = ctk.CTkFrame(self, fg_color=self.COLORS["bg_medium"])
        header.pack(fill="x", padx=5, pady=5)
        
        ctk.CTkLabel(header, text="🔐 ENCRYPTION & DECRYPTION TOOLS",
                     font=ctk.CTkFont(size=16, weight="bold"),
                     text_color=self.COLORS["accent_cyan"]).pack(pady=10)
        
        # Main content frame
        content = ctk.CTkFrame(self, fg_color=self.COLORS["bg_medium"])
        content.pack(fill="both", expand=True, padx=5, pady=5)
        
        # Input section
        input_frame = ctk.CTkFrame(content, fg_color=self.COLORS["bg_light"])
        input_frame.pack(fill="x", padx=10, pady=10)
        
        ctk.CTkLabel(input_frame, text="Input (Hex/Base64/File):",
                     text_color=self.COLORS["text_secondary"]).pack(anchor="w", padx=10, pady=5)
        
        self.input_text = ctk.CTkTextbox(input_frame, height=100,
                                          fg_color=self.COLORS["bg_dark"],
                                          text_color=self.COLORS["accent_green"])
        self.input_text.pack(fill="x", padx=10, pady=5)
        
        # Algorithm selection
        algo_frame = ctk.CTkFrame(content, fg_color=self.COLORS["bg_light"])
        algo_frame.pack(fill="x", padx=10, pady=5)
        
        ctk.CTkLabel(algo_frame, text="Algorithm:",
                     text_color=self.COLORS["text_secondary"]).pack(side="left", padx=10)
        
        self.algorithm = ctk.CTkOptionMenu(algo_frame, 
                                            values=["Auto-Detect", "XOR (0xAA)", "AES-128", 
                                                   "AES-256", "Blowfish", "MD5 Hash"],
                                            fg_color=self.COLORS["bg_dark"])
        self.algorithm.pack(side="left", padx=5)
        
        ctk.CTkLabel(algo_frame, text="Key:",
                     text_color=self.COLORS["text_secondary"]).pack(side="left", padx=10)
        
        self.key_entry = ctk.CTkEntry(algo_frame, width=300,
                                       fg_color=self.COLORS["bg_dark"],
                                       placeholder_text="Leave blank for default Evony keys")
        self.key_entry.pack(side="left", padx=5)
        
        # Action buttons
        btn_frame = ctk.CTkFrame(content, fg_color="transparent")
        btn_frame.pack(fill="x", padx=10, pady=10)
        
        ctk.CTkButton(btn_frame, text="🔓 Decrypt", width=100,
                      fg_color=self.COLORS["accent_green"], text_color="black",
                      command=self._decrypt).pack(side="left", padx=5)
        
        ctk.CTkButton(btn_frame, text="🔒 Encrypt", width=100,
                      fg_color=self.COLORS["accent_cyan"], text_color="black",
                      command=self._encrypt).pack(side="left", padx=5)
        
        ctk.CTkButton(btn_frame, text="📁 Load File", width=100,
                      fg_color=self.COLORS["bg_light"],
                      command=self._load_file).pack(side="left", padx=5)
        
        ctk.CTkButton(btn_frame, text="💾 Save Result", width=100,
                      fg_color=self.COLORS["bg_light"],
                      command=self._save_result).pack(side="left", padx=5)
        
        # Output section
        output_frame = ctk.CTkFrame(content, fg_color=self.COLORS["bg_light"])
        output_frame.pack(fill="both", expand=True, padx=10, pady=10)
        
        ctk.CTkLabel(output_frame, text="Output:",
                     text_color=self.COLORS["text_secondary"]).pack(anchor="w", padx=10, pady=5)
        
        self.output_text = ctk.CTkTextbox(output_frame,
                                           fg_color=self.COLORS["bg_dark"],
                                           text_color=self.COLORS["accent_cyan"])
        self.output_text.pack(fill="both", expand=True, padx=10, pady=5)
        
        # Known keys reference
        keys_frame = ctk.CTkFrame(self, fg_color=self.COLORS["bg_light"])
        keys_frame.pack(fill="x", padx=5, pady=5)
        
        ctk.CTkLabel(keys_frame, text="🔑 Known Evony Keys (click to use):",
                     font=ctk.CTkFont(size=12, weight="bold"),
                     text_color=self.COLORS["accent_green"]).pack(anchor="w", padx=10, pady=5)
        
        keys_text = ctk.CTkTextbox(keys_frame, height=100,
                                    fg_color=self.COLORS["bg_dark"],
                                    text_color=self.COLORS["text_secondary"])
        keys_text.pack(fill="x", padx=10, pady=5)
        keys_text.insert("1.0", """API Key:      9f758e2deccbe6244f734371b9642eda
XOR Key:      0xAA (170)
Game Key:     EvonyGameKey2009
Network Key:  EvonyNetKey2009
Resource Key: EvonyResKey2009
Config Key:   EvonyConfigKey2009
Data Key:     EvonyDataKey2009""")
        keys_text.configure(state="disabled")
    
    def _decrypt(self):
        """Decrypt the input data"""
        from src.tools.crypto.universal_decryptor import UniversalDecryptor
        
        input_data = self.input_text.get("1.0", "end-1c")
        algorithm = self.algorithm.get()
        key = self.key_entry.get() or None
        
        decryptor = UniversalDecryptor()
        
        try:
            # Convert input to bytes
            if input_data.startswith("0x") or all(c in "0123456789abcdefABCDEF " for c in input_data):
                data = bytes.fromhex(input_data.replace("0x", "").replace(" ", ""))
            else:
                import base64
                data = base64.b64decode(input_data)
            
            # Decrypt
            result, method = decryptor.decrypt(data, algorithm=algorithm, key=key)
            
            # Display
            self.output_text.delete("1.0", "end")
            self.output_text.insert("1.0", f"Method: {method}\n\n")
            self.output_text.insert("end", result.decode("utf-8", errors="replace"))
            
        except Exception as e:
            self.output_text.delete("1.0", "end")
            self.output_text.insert("1.0", f"Error: {str(e)}")
    
    def _encrypt(self):
        """Encrypt the input data"""
        # Similar implementation
        pass
    
    def _load_file(self):
        """Load file for processing"""
        from tkinter import filedialog
        path = filedialog.askopenfilename()
        if path:
            with open(path, "rb") as f:
                data = f.read()
            self.input_text.delete("1.0", "end")
            self.input_text.insert("1.0", data.hex())
    
    def _save_result(self):
        """Save result to file"""
        from tkinter import filedialog
        path = filedialog.asksaveasfilename(defaultextension=".bin")
        if path:
            output = self.output_text.get("1.0", "end-1c")
            with open(path, "wb") as f:
                f.write(output.encode())
```

---

## 🔴 SECTION 5: THEME SYSTEM EXPANSION

### Add 4 New Themes to `theme_manager.py`

**Location**: `src/core/theme_manager.py` line ~50

**ADD to ThemePreset enum**:
```python
class ThemePreset(Enum):
    # ... existing ...
    BLOOD_MOON = "blood_moon"         # NEW
    FOREST_NIGHT = "forest_night"     # NEW
    AMBER_ALERT = "amber_alert"       # NEW
    STEEL_GRAY = "steel_gray"         # NEW
```

**ADD to THEME_PRESETS dict**:
```python
# After existing theme definitions, add:

"blood_moon": Theme(
    name="Blood Moon",
    preset=ThemePreset.BLOOD_MOON,
    colors=ColorScheme(
        bg_darkest="#0a0000",
        bg_dark="#150505",
        bg_medium="#251010",
        bg_light="#351818",
        bg_lighter="#452020",
        accent_primary="#cc0000",
        accent_secondary="#ff3333",
        accent_tertiary="#ff6600",
        text_primary="#ffcccc",
        text_secondary="#aa8888",
        text_muted="#664444",
        text_highlight="#ffffff",
        success="#00cc00",
        warning="#ff9900",
        error="#ff0000",
        info="#ff6666",
    )
),

"forest_night": Theme(
    name="Forest Night",
    preset=ThemePreset.FOREST_NIGHT,
    colors=ColorScheme(
        bg_darkest="#000a05",
        bg_dark="#051510",
        bg_medium="#102518",
        bg_light="#183525",
        bg_lighter="#204530",
        accent_primary="#00aa55",
        accent_secondary="#55ffaa",
        accent_tertiary="#88ff88",
        text_primary="#ccffdd",
        text_secondary="#88aa99",
        text_muted="#446655",
        text_highlight="#ffffff",
        success="#00ff55",
        warning="#ff9900",
        error="#ff3333",
        info="#55ffaa",
    )
),

"amber_alert": Theme(
    name="Amber Alert",
    preset=ThemePreset.AMBER_ALERT,
    colors=ColorScheme(
        bg_darkest="#0a0500",
        bg_dark="#151005",
        bg_medium="#252010",
        bg_light="#353018",
        bg_lighter="#454020",
        accent_primary="#ff9900",
        accent_secondary="#ffcc00",
        accent_tertiary="#ffff66",
        text_primary="#fff5cc",
        text_secondary="#aa9955",
        text_muted="#665533",
        text_highlight="#ffffff",
        success="#00cc00",
        warning="#ffcc00",
        error="#ff3333",
        info="#ffaa00",
    )
),

"steel_gray": Theme(
    name="Steel Gray",
    preset=ThemePreset.STEEL_GRAY,
    colors=ColorScheme(
        bg_darkest="#0a0a0f",
        bg_dark="#151520",
        bg_medium="#252535",
        bg_light="#353545",
        bg_lighter="#454560",
        accent_primary="#6688aa",
        accent_secondary="#88aacc",
        accent_tertiary="#aaccee",
        text_primary="#ddeeff",
        text_secondary="#8899aa",
        text_muted="#556677",
        text_highlight="#ffffff",
        success="#55aa55",
        warning="#aaaa55",
        error="#aa5555",
        info="#5588aa",
    )
),
```

---

## ✅ VERIFICATION CHECKLIST

After completing all fixes, verify:

- [ ] Protocol sniffer Start Capture button starts actual capture
- [ ] Stop bot button actually kills the process (check Task Manager)
- [ ] Tor new identity actually changes circuit (verify IP change)
- [ ] Asset filter shows only selected category
- [ ] All Evony menu items do something
- [ ] Crypto panel can decrypt test data
- [ ] All 12 themes appear in Theme menu
- [ ] No functions just log without acting

---

*Complete ALL items in this document before proceeding to Phase 1.*
