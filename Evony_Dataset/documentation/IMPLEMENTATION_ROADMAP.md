# SVONY STUDIO - IMPLEMENTATION ROADMAP
## Complete Code Fixes for 100% Completion

**Version:** 2.0 FINAL  
**Date:** January 2, 2026  

---

## 🎯 PHASE 1: CRITICAL IMPORTS (Day 1)

### Fix 1: Add Missing Imports to main.py

**Location:** main.py, line ~51

**ADD these imports:**
```python
# ADD after line 51:
from src.ui.panels.asset_panel import AssetBrowserPanel
from src.ui.widgets.code_editor import CodeEditor
from src.ui.widgets.console import ConsoleWidget
from src.ui.widgets.tree_view import FilterableTreeView
```

---

## 🎯 PHASE 2: FIX STUB FUNCTIONS (Days 1-3)

### Fix 2: _deobfuscate_swf() - Line 1531

**REPLACE:**
```python
def _deobfuscate_swf(self):
    """Deobfuscate current SWF"""
    if self.current_swf:
        self._log_console("Running deobfuscation...")
```

**WITH:**
```python
def _deobfuscate_swf(self):
    """Deobfuscate current SWF with progress dialog"""
    if not self.current_swf:
        messagebox.showwarning("No Target", "Load a SWF file first")
        return
    
    # Create progress dialog
    progress = ctk.CTkToplevel(self)
    progress.title("Deobfuscating...")
    progress.geometry("400x150")
    progress.transient(self)
    progress.grab_set()
    progress.configure(fg_color=self.COLORS["bg_dark"])
    
    ctk.CTkLabel(progress, text="⬢ DEOBFUSCATING SWF", 
                 font=ctk.CTkFont(size=16, weight="bold"),
                 text_color=self.COLORS["accent_green"]).pack(pady=10)
    
    progress_bar = ctk.CTkProgressBar(progress, width=350)
    progress_bar.pack(pady=10)
    progress_bar.set(0)
    
    status_label = ctk.CTkLabel(progress, text="Starting...",
                                text_color=self.COLORS["text_secondary"])
    status_label.pack(pady=5)
    
    def run_deobfuscation():
        try:
            status_label.configure(text="Analyzing obfuscation patterns...")
            progress_bar.set(0.2)
            progress.update()
            
            # Create output path
            output_path = self.current_swf.replace('.swf', '_deobfuscated.swf')
            
            status_label.configure(text="Running FFDec deobfuscation...")
            progress_bar.set(0.5)
            progress.update()
            
            # Call FFDec deobfuscation
            result = self.ffdec.deobfuscate(self.current_swf, output_path)
            
            progress_bar.set(0.9)
            status_label.configure(text="Finalizing...")
            progress.update()
            
            if result and result.returncode == 0:
                progress_bar.set(1.0)
                self._log_console(f"✓ Deobfuscation complete: {output_path}")
                messagebox.showinfo("Success", f"Deobfuscated SWF saved to:\n{output_path}")
            else:
                self._log_console(f"✗ Deobfuscation failed")
                messagebox.showerror("Error", "Deobfuscation failed. Check console for details.")
                
        except Exception as e:
            self._log_console(f"✗ Error: {str(e)}")
            messagebox.showerror("Error", f"Deobfuscation error: {str(e)}")
        finally:
            progress.destroy()
    
    # Run in thread to keep UI responsive
    threading.Thread(target=run_deobfuscation, daemon=True).start()
```

---

### Fix 3: _batch_decompile() - Line 1536

**REPLACE:**
```python
def _batch_decompile(self):
    """Batch decompile multiple SWFs"""
    files = filedialog.askopenfilenames(
        title="Select SWF Files",
        filetypes=[("SWF files", "*.swf")]
    )
    if files:
        self._log_console(f"Batch processing {len(files)} files...")
```

**WITH:**
```python
def _batch_decompile(self):
    """Batch decompile multiple SWFs with progress tracking"""
    files = filedialog.askopenfilenames(
        title="Select SWF Files",
        filetypes=[("SWF files", "*.swf")]
    )
    if not files:
        return
    
    output_dir = filedialog.askdirectory(title="Select Output Directory")
    if not output_dir:
        return
    
    # Create progress dialog
    progress = ctk.CTkToplevel(self)
    progress.title("Batch Decompile")
    progress.geometry("500x250")
    progress.transient(self)
    progress.grab_set()
    progress.configure(fg_color=self.COLORS["bg_dark"])
    
    ctk.CTkLabel(progress, text="⬢ BATCH DECOMPILE", 
                 font=ctk.CTkFont(size=16, weight="bold"),
                 text_color=self.COLORS["accent_green"]).pack(pady=10)
    
    progress_bar = ctk.CTkProgressBar(progress, width=450)
    progress_bar.pack(pady=10)
    progress_bar.set(0)
    
    file_label = ctk.CTkLabel(progress, text="",
                              text_color=self.COLORS["text_primary"])
    file_label.pack(pady=5)
    
    status_label = ctk.CTkLabel(progress, text=f"Processing 0/{len(files)}",
                                text_color=self.COLORS["text_secondary"])
    status_label.pack(pady=5)
    
    # Results tracking
    results = {"success": 0, "failed": 0, "errors": []}
    cancel_flag = [False]
    
    def cancel_batch():
        cancel_flag[0] = True
    
    cancel_btn = ctk.CTkButton(progress, text="Cancel", width=100,
                               fg_color=self.COLORS["error"],
                               command=cancel_batch)
    cancel_btn.pack(pady=10)
    
    def run_batch():
        for i, swf_path in enumerate(files):
            if cancel_flag[0]:
                self._log_console("Batch decompile cancelled by user")
                break
            
            filename = os.path.basename(swf_path)
            file_label.configure(text=f"Processing: {filename}")
            status_label.configure(text=f"File {i+1}/{len(files)}")
            progress_bar.set((i + 0.5) / len(files))
            progress.update()
            
            try:
                # Create output subdirectory
                swf_output = os.path.join(output_dir, os.path.splitext(filename)[0])
                os.makedirs(swf_output, exist_ok=True)
                
                # Export all content
                self.ffdec.export_scripts(swf_path, os.path.join(swf_output, "scripts"))
                self.ffdec.export_images(swf_path, os.path.join(swf_output, "images"))
                self.ffdec.export_sounds(swf_path, os.path.join(swf_output, "sounds"))
                
                results["success"] += 1
                self._log_console(f"✓ Exported: {filename}")
                
            except Exception as e:
                results["failed"] += 1
                results["errors"].append(f"{filename}: {str(e)}")
                self._log_console(f"✗ Failed: {filename} - {str(e)}")
            
            progress_bar.set((i + 1) / len(files))
            progress.update()
        
        # Show results
        progress.destroy()
        result_msg = f"Batch Complete!\n\nSuccess: {results['success']}\nFailed: {results['failed']}"
        if results["errors"]:
            result_msg += f"\n\nErrors:\n" + "\n".join(results["errors"][:5])
        messagebox.showinfo("Batch Decompile", result_msg)
    
    threading.Thread(target=run_batch, daemon=True).start()
```

---

### Fix 4: _protocol_sniffer() - Line 1545

**REPLACE:**
```python
def _protocol_sniffer(self):
    """Launch protocol sniffer"""
    self._log_console("Protocol sniffer not yet implemented")
```

**WITH:**
```python
def _protocol_sniffer(self):
    """Launch protocol sniffer with full UI"""
    from src.core.protocol_analyzer import get_protocol_analyzer
    
    dialog = ctk.CTkToplevel(self)
    dialog.title("Protocol Sniffer")
    dialog.geometry("800x600")
    dialog.transient(self)
    dialog.configure(fg_color=self.COLORS["bg_dark"])
    
    # Header
    header = ctk.CTkFrame(dialog, fg_color=self.COLORS["bg_medium"])
    header.pack(fill="x", padx=10, pady=10)
    
    ctk.CTkLabel(header, text="⬢ PROTOCOL SNIFFER", 
                 font=ctk.CTkFont(size=18, weight="bold"),
                 text_color=self.COLORS["accent_green"]).pack(side="left", padx=10)
    
    # Configuration
    config_frame = ctk.CTkFrame(dialog, fg_color=self.COLORS["bg_medium"])
    config_frame.pack(fill="x", padx=10, pady=5)
    
    ctk.CTkLabel(config_frame, text="Listen Port:").pack(side="left", padx=10)
    port_entry = ctk.CTkEntry(config_frame, width=80)
    port_entry.insert(0, "8080")
    port_entry.pack(side="left", padx=5)
    
    ctk.CTkLabel(config_frame, text="Target Host:").pack(side="left", padx=10)
    host_entry = ctk.CTkEntry(config_frame, width=200)
    host_entry.insert(0, "evony.com")
    host_entry.pack(side="left", padx=5)
    
    # Control buttons
    control_frame = ctk.CTkFrame(dialog, fg_color="transparent")
    control_frame.pack(fill="x", padx=10, pady=5)
    
    analyzer = get_protocol_analyzer()
    is_running = [False]
    
    def start_capture():
        if not is_running[0]:
            port = int(port_entry.get())
            host = host_entry.get()
            analyzer.start_proxy(port, host)
            is_running[0] = True
            start_btn.configure(text="⏹ Stop", fg_color=self.COLORS["error"])
            self._log_console(f"Protocol capture started on port {port}")
        else:
            analyzer.stop_proxy()
            is_running[0] = False
            start_btn.configure(text="▶ Start", fg_color=self.COLORS["accent_green"])
            self._log_console("Protocol capture stopped")
    
    start_btn = ctk.CTkButton(control_frame, text="▶ Start", width=100,
                              fg_color=self.COLORS["accent_green"],
                              command=start_capture)
    start_btn.pack(side="left", padx=5)
    
    clear_btn = ctk.CTkButton(control_frame, text="Clear", width=80,
                              fg_color=self.COLORS["bg_light"],
                              command=lambda: message_list.delete(0, tk.END))
    clear_btn.pack(side="left", padx=5)
    
    export_btn = ctk.CTkButton(control_frame, text="Export", width=80,
                               fg_color=self.COLORS["bg_light"],
                               command=lambda: self._export_protocol_session(analyzer))
    export_btn.pack(side="left", padx=5)
    
    # Message list
    list_frame = ctk.CTkFrame(dialog, fg_color=self.COLORS["bg_medium"])
    list_frame.pack(fill="both", expand=True, padx=10, pady=10)
    
    columns = ("Time", "Direction", "Type", "Size", "Preview")
    message_tree = ttk.Treeview(list_frame, columns=columns, show="headings", height=15)
    for col in columns:
        message_tree.heading(col, text=col)
        message_tree.column(col, width=100 if col != "Preview" else 300)
    message_tree.pack(fill="both", expand=True, padx=5, pady=5)
    
    # Detail panel
    detail_frame = ctk.CTkFrame(dialog, fg_color=self.COLORS["bg_medium"], height=150)
    detail_frame.pack(fill="x", padx=10, pady=5)
    detail_frame.pack_propagate(False)
    
    detail_text = tk.Text(detail_frame, bg=self.COLORS["bg_light"], 
                          fg=self.COLORS["text_primary"], height=6)
    detail_text.pack(fill="both", expand=True, padx=5, pady=5)
    
    # Update loop
    def update_messages():
        if is_running[0]:
            messages = analyzer.get_captured_messages()
            for msg in messages:
                message_tree.insert("", 0, values=(
                    msg.get("time", ""),
                    msg.get("direction", ""),
                    msg.get("type", ""),
                    f"{msg.get('size', 0)} bytes",
                    str(msg.get("preview", ""))[:50]
                ))
        dialog.after(500, update_messages)
    
    update_messages()
```

---

### Fix 5: _patch_server_url() - Line 1596

**REPLACE:**
```python
def _patch_server_url(self):
    """Patch server URL in SWF"""
    if self.current_swf:
        self._log_console("Server URL patching...")
```

**WITH:**
```python
def _patch_server_url(self):
    """Patch server URL in SWF with dialog"""
    if not self.current_swf:
        messagebox.showwarning("No Target", "Load a SWF file first")
        return
    
    dialog = ctk.CTkToplevel(self)
    dialog.title("Patch Server URL")
    dialog.geometry("500x300")
    dialog.transient(self)
    dialog.grab_set()
    dialog.configure(fg_color=self.COLORS["bg_dark"])
    
    ctk.CTkLabel(dialog, text="⬢ PATCH SERVER URL", 
                 font=ctk.CTkFont(size=16, weight="bold"),
                 text_color=self.COLORS["accent_green"]).pack(pady=10)
    
    # Current URL
    ctk.CTkLabel(dialog, text="Current Server URL Pattern:",
                 text_color=self.COLORS["text_secondary"]).pack(pady=(10,2))
    
    current_entry = ctk.CTkEntry(dialog, width=400)
    current_entry.insert(0, "evony.com")
    current_entry.pack(pady=5)
    
    # New URL
    ctk.CTkLabel(dialog, text="New Server URL:",
                 text_color=self.COLORS["text_secondary"]).pack(pady=(10,2))
    
    new_entry = ctk.CTkEntry(dialog, width=400)
    new_entry.insert(0, "localhost:8080")
    new_entry.pack(pady=5)
    
    # Backup option
    backup_var = ctk.BooleanVar(value=True)
    ctk.CTkCheckBox(dialog, text="Create backup before patching",
                    variable=backup_var, 
                    text_color=self.COLORS["text_primary"]).pack(pady=10)
    
    def apply_patch():
        old_url = current_entry.get()
        new_url = new_entry.get()
        
        if not old_url or not new_url:
            messagebox.showwarning("Input Required", "Both URLs are required")
            return
        
        if backup_var.get():
            backup_path = self.current_swf + ".backup"
            shutil.copy2(self.current_swf, backup_path)
            self._log_console(f"Backup created: {backup_path}")
        
        patcher = get_patcher()
        result = patcher.patch_string(self.current_swf, old_url, new_url)
        
        if result.success:
            self._log_console(f"✓ Patched {result.replacements} occurrences")
            messagebox.showinfo("Success", f"Patched {result.replacements} URLs")
            dialog.destroy()
        else:
            self._log_console(f"✗ Patch failed: {result.error}")
            messagebox.showerror("Error", f"Patch failed: {result.error}")
    
    btn_frame = ctk.CTkFrame(dialog, fg_color="transparent")
    btn_frame.pack(pady=20)
    
    ctk.CTkButton(btn_frame, text="Apply Patch", width=120,
                  fg_color=self.COLORS["accent_green"],
                  command=apply_patch).pack(side="left", padx=10)
    
    ctk.CTkButton(btn_frame, text="Cancel", width=100,
                  fg_color=self.COLORS["bg_light"],
                  command=dialog.destroy).pack(side="left", padx=10)
```

---

### Fix 6: _on_tree_right_click() - Line 1365

**REPLACE:**
```python
def _on_tree_right_click(self, event):
    """Handle right-click on project tree"""
    pass
```

**WITH:**
```python
def _on_tree_right_click(self, event):
    """Handle right-click on project tree with context menu"""
    item = self.project_tree.identify_row(event.y)
    if not item:
        return
    
    self.project_tree.selection_set(item)
    item_text = self.project_tree.item(item, "text")
    item_values = self.project_tree.item(item, "values")
    
    # Create context menu
    menu = tk.Menu(self, tearoff=0, 
                   bg=self.COLORS["bg_medium"],
                   fg=self.COLORS["text_primary"],
                   activebackground=self.COLORS["accent_green"])
    
    # Determine item type
    is_swf = item_text.lower().endswith('.swf')
    is_script = item_text.lower().endswith(('.as', '.p'))
    is_image = item_text.lower().endswith(('.png', '.jpg', '.gif'))
    is_folder = "📁" in str(item_values) or not "." in item_text
    
    if is_swf:
        menu.add_command(label="📂 Open in FFDec", 
                        command=lambda: self._open_ffdec_item(item_text))
        menu.add_command(label="▶ Run SWF", 
                        command=lambda: self._run_swf_item(item_text))
        menu.add_separator()
        menu.add_command(label="📤 Export Scripts", 
                        command=lambda: self._export_scripts_item(item_text))
        menu.add_command(label="🖼 Export Images", 
                        command=lambda: self._export_images_item(item_text))
        menu.add_command(label="🔊 Export Sounds", 
                        command=lambda: self._export_sounds_item(item_text))
        menu.add_separator()
        menu.add_command(label="🔧 Deobfuscate", 
                        command=lambda: self._deobfuscate_item(item_text))
    
    elif is_script:
        menu.add_command(label="📝 Edit Script", 
                        command=lambda: self._edit_script_item(item_text))
        menu.add_command(label="🔍 Search in Script", 
                        command=lambda: self._search_in_script(item_text))
        menu.add_separator()
        menu.add_command(label="📋 Copy Path", 
                        command=lambda: self._copy_path(item_text))
    
    elif is_image:
        menu.add_command(label="👁 Preview Image", 
                        command=lambda: self._preview_image(item_text))
        menu.add_command(label="📤 Export Image", 
                        command=lambda: self._export_single_image(item_text))
        menu.add_command(label="🔄 Replace Image", 
                        command=lambda: self._replace_image(item_text))
    
    elif is_folder:
        menu.add_command(label="📂 Expand All", 
                        command=lambda: self._expand_all(item))
        menu.add_command(label="📁 Collapse All", 
                        command=lambda: self._collapse_all(item))
        menu.add_separator()
        menu.add_command(label="📤 Export Folder", 
                        command=lambda: self._export_folder(item_text))
    
    # Common options
    menu.add_separator()
    menu.add_command(label="📋 Copy Name", 
                    command=lambda: self.clipboard_clear() or 
                                   self.clipboard_append(item_text))
    menu.add_command(label="🔄 Refresh", command=self._refresh_tree)
    
    menu.post(event.x_root, event.y_root)
```

---

## 🎯 PHASE 3: CONNECT PANELS (Days 3-5)

### Fix 7: Connect AssetBrowserPanel

**Location:** main.py, `_create_assets_tab()` method (~line 593)

**REPLACE the inline implementation with:**

```python
def _create_assets_tab(self, parent):
    """Create assets browser tab using AssetBrowserPanel"""
    from src.ui.panels.asset_panel import AssetBrowserPanel
    
    # Use the proper panel component
    self.asset_browser = AssetBrowserPanel(
        parent,
        colors=self.COLORS,
        on_asset_select=self._on_asset_selected,
        on_asset_export=self._export_asset,
        on_asset_preview=self._preview_asset
    )
    self.asset_browser.pack(fill="both", expand=True)
    
    # Connect to SWF loading
    def update_assets():
        if self.current_swf:
            self.asset_browser.load_swf(self.current_swf)
    
    # Store reference for updates
    self._update_asset_browser = update_assets
```

---

### Fix 8: Connect Protocol Panel

**Location:** main.py, in the bots tab creation

**ADD to _create_bots_tab():**

```python
# Add Protocol sub-tab
protocol_tab = ctk.CTkFrame(self.bot_notebook)
self.bot_notebook.add(protocol_tab, text="Protocol")

self.protocol_panel = ProtocolAnalyzerPanel(
    protocol_tab,
    colors=self.COLORS,
    on_message_select=self._on_protocol_message_select
)
self.protocol_panel.pack(fill="both", expand=True)
```

---

## 🎯 PHASE 4: DOCKER & CI/CD (Day 5)

### Docker files created:
- ✅ `docker/Dockerfile`
- ✅ `docker/docker-compose.yml`

### CI/CD Enhancement:

Update `.github/workflows/ci-cd.yml` with Docker build.

---

## 📊 COMPLETION TRACKING

After implementing all fixes:

| Phase | Task | Status |
|-------|------|--------|
| Phase 1 | Add missing imports | ⬜ TODO |
| Phase 2 | Fix _deobfuscate_swf() | ⬜ TODO |
| Phase 2 | Fix _batch_decompile() | ⬜ TODO |
| Phase 2 | Fix _protocol_sniffer() | ⬜ TODO |
| Phase 2 | Fix _patch_server_url() | ⬜ TODO |
| Phase 2 | Fix _on_tree_right_click() | ⬜ TODO |
| Phase 3 | Connect AssetBrowserPanel | ⬜ TODO |
| Phase 3 | Connect ProtocolPanel | ⬜ TODO |
| Phase 4 | Docker configuration | ✅ DONE |

---

**Expected Result After All Fixes:**
- Completion: 37% → 85%
- Working Features: 96 → 550+
- User-Accessible: 22% → 80%
