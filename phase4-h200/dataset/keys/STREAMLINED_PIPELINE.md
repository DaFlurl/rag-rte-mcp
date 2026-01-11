# STREAMLINED SWF DEVELOPMENT & TESTING PIPELINE
## Real-Time Edit → Build → Test → Debug Workflow

**Purpose:** Zero-friction workflow for modifying, testing, and debugging SWF/Bot features  
**Goal:** Edit code, see results instantly, no manual rebuild steps

---

## 🔄 THE IDEAL WORKFLOW

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         SVONY STUDIO PIPELINE                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐              │
│  │  UNPACK  │───▶│   EDIT   │───▶│  BUILD   │───▶│   TEST   │              │
│  │   SWF    │    │   CODE   │    │   SWF    │    │   LIVE   │              │
│  └──────────┘    └──────────┘    └──────────┘    └──────────┘              │
│       │              │  ▲            │              │                       │
│       │              │  │            │              │                       │
│       ▼              ▼  │            ▼              ▼                       │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐              │
│  │ AUTO     │    │ HOT      │    │ AUTO     │    │ DEBUG    │              │
│  │ DECOMPILE│    │ RELOAD   │◀───│ REPACK   │    │ PROXY    │              │
│  └──────────┘    └──────────┘    └──────────┘    └──────────┘              │
│                                                                              │
│  ◀════════════════ ONE-CLICK AUTOMATION ══════════════════▶                │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 🛠️ PIPELINE COMPONENTS TO IMPLEMENT

### Component 1: Auto-Unpack System

```python
class SWFAutoUnpacker:
    """
    Automatically decompile SWF when loaded into project.
    Watches for file changes and re-decompiles if source SWF modified.
    """
    
    def __init__(self, ffdec: FFDecExtended):
        self.ffdec = ffdec
        self.cache_dir = Path("cache/decompiled")
        self.file_watcher = FileWatcher()
        
    def auto_unpack(self, swf_path: str) -> ProjectStructure:
        """
        One-click unpack:
        1. Decompress if LZMA/ZLIB
        2. Extract all scripts to /scripts
        3. Extract all images to /images  
        4. Extract all sounds to /sounds
        5. Extract all shapes to /shapes
        6. Generate tag tree structure
        7. Create edit manifest
        """
        # Check cache first
        cache_key = self._get_cache_key(swf_path)
        if self._is_cached(cache_key):
            return self._load_from_cache(cache_key)
        
        # Full decompile
        project = ProjectStructure()
        
        # Step 1: Decompress
        decompressed = self.ffdec.decompress(swf_path)
        
        # Step 2-5: Export all content
        project.scripts = self.ffdec.export_scripts(decompressed, self.cache_dir / "scripts")
        project.images = self.ffdec.export_images(decompressed, self.cache_dir / "images")
        project.sounds = self.ffdec.export_sounds(decompressed, self.cache_dir / "sounds")
        project.shapes = self.ffdec.export_shapes(decompressed, self.cache_dir / "shapes")
        
        # Step 6: Build tag tree
        project.tag_tree = self.ffdec.get_tag_tree(decompressed)
        
        # Step 7: Create manifest
        project.manifest = self._create_manifest(project)
        
        # Cache for next time
        self._save_to_cache(cache_key, project)
        
        return project
        
    def watch_for_changes(self, swf_path: str, callback: Callable):
        """Watch source SWF for changes and auto-reload"""
        self.file_watcher.watch(swf_path, lambda: self._on_swf_changed(swf_path, callback))
```

---

### Component 2: Hot Reload Editor

```python
class HotReloadEditor:
    """
    Edit decompiled code with instant preview.
    Changes are applied without full rebuild.
    """
    
    def __init__(self, project: ProjectStructure):
        self.project = project
        self.pending_changes = []
        self.original_state = {}
        
    def edit_script(self, script_path: str, new_content: str):
        """
        Edit a script file with hot reload:
        1. Validate syntax
        2. Track change in pending_changes
        3. If validation passes, apply to memory
        4. Trigger preview update
        """
        # Validate
        errors = self._validate_actionscript(new_content)
        if errors:
            return {"success": False, "errors": errors}
        
        # Track original
        if script_path not in self.original_state:
            self.original_state[script_path] = self._read_current(script_path)
        
        # Apply change
        self.pending_changes.append({
            "type": "script",
            "path": script_path,
            "content": new_content,
            "timestamp": time.time()
        })
        
        # Trigger preview
        self._update_preview()
        
        return {"success": True, "preview_ready": True}
    
    def get_diff(self) -> str:
        """Show all pending changes as unified diff"""
        diffs = []
        for change in self.pending_changes:
            original = self.original_state.get(change["path"], "")
            diffs.append(unified_diff(original, change["content"]))
        return "\n".join(diffs)
    
    def rollback(self, script_path: str = None):
        """Rollback changes (single file or all)"""
        if script_path:
            self.pending_changes = [c for c in self.pending_changes if c["path"] != script_path]
        else:
            self.pending_changes = []
        self._update_preview()
```

---

### Component 3: Auto-Repack System

```python
class SWFAutoRepacker:
    """
    One-click rebuild of modified SWF.
    Applies all pending changes and creates new SWF.
    """
    
    def __init__(self, ffdec: FFDecExtended, editor: HotReloadEditor):
        self.ffdec = ffdec
        self.editor = editor
        
    def rebuild(self, output_path: str = None) -> str:
        """
        One-click rebuild:
        1. Apply all pending script changes
        2. Apply all pending asset changes
        3. Recompile ABC tags
        4. Repack into SWF
        5. Compress (optional)
        6. Return path to new SWF
        """
        if not output_path:
            output_path = self._generate_output_path()
        
        # Get base SWF
        base_swf = self.editor.project.source_swf
        
        # Apply script changes
        for change in self.editor.pending_changes:
            if change["type"] == "script":
                self.ffdec.replace_script(base_swf, change["path"], change["content"])
        
        # Recompile and repack
        self.ffdec.recompile_abc(base_swf)
        self.ffdec.repack(base_swf, output_path)
        
        # Clear pending changes
        self.editor.pending_changes = []
        
        return output_path
    
    def quick_rebuild(self) -> str:
        """
        Optimized rebuild for testing:
        - Skip unchanged components
        - Use incremental compilation
        - Output to temp location
        """
        return self.rebuild(output_path=f"temp/test_{int(time.time())}.swf")
```

---

### Component 4: Live Test Launcher

```python
class LiveTestLauncher:
    """
    Launch modified SWF for testing with server connection.
    Supports multiple test environments.
    """
    
    def __init__(self, proxy: ProtocolProxy):
        self.proxy = proxy
        self.ruffle_path = None
        self.flash_projector_path = None
        self.active_tests = []
        
    def launch_in_ruffle(self, swf_path: str, connect_to_server: bool = True):
        """
        Launch SWF in Ruffle emulator:
        1. Configure proxy if connecting to server
        2. Set environment variables
        3. Launch Ruffle with SWF
        4. Return process handle for monitoring
        """
        env = {}
        
        if connect_to_server:
            # Start proxy
            proxy_port = self.proxy.start()
            env["HTTP_PROXY"] = f"http://localhost:{proxy_port}"
            env["HTTPS_PROXY"] = f"http://localhost:{proxy_port}"
        
        # Launch Ruffle
        process = subprocess.Popen(
            [self.ruffle_path, swf_path],
            env={**os.environ, **env}
        )
        
        test_session = TestSession(
            process=process,
            swf_path=swf_path,
            proxy_port=proxy_port if connect_to_server else None
        )
        self.active_tests.append(test_session)
        
        return test_session
    
    def launch_in_flash_projector(self, swf_path: str, connect_to_server: bool = True):
        """Launch in standalone Flash Player Projector"""
        # Similar to Ruffle but uses Flash Projector
        pass
    
    def launch_with_bot(self, swf_path: str, bot_config: dict):
        """
        Launch SWF with bot automation attached:
        1. Start SWF in player
        2. Inject bot hooks
        3. Connect bot controller
        4. Return combined session
        """
        pass
```

---

### Component 5: Debug Proxy

```python
class DebugProxy:
    """
    MITM proxy for inspecting and modifying game traffic.
    Real-time visibility into client-server communication.
    """
    
    def __init__(self):
        self.captured_messages = []
        self.breakpoints = []
        self.request_interceptors = []
        self.response_interceptors = []
        
    def start(self, listen_port: int = 8888) -> int:
        """Start proxy server"""
        self.server = ProxyServer(listen_port)
        self.server.on_request = self._handle_request
        self.server.on_response = self._handle_response
        self.server.start()
        return listen_port
    
    def _handle_request(self, request: AMFRequest) -> AMFRequest:
        """
        Intercept outgoing request:
        1. Log to captured messages
        2. Check breakpoints
        3. Allow modification
        4. Forward (or block)
        """
        # Log
        self.captured_messages.append({
            "direction": "outgoing",
            "timestamp": time.time(),
            "data": request.to_dict()
        })
        
        # Check breakpoints
        for bp in self.breakpoints:
            if bp.matches(request):
                self._pause_at_breakpoint(bp, request)
        
        # Run interceptors
        for interceptor in self.request_interceptors:
            request = interceptor(request)
        
        return request
    
    def _handle_response(self, response: AMFResponse) -> AMFResponse:
        """Intercept incoming response"""
        # Similar to request handling
        pass
    
    def add_breakpoint(self, condition: str):
        """Add breakpoint on message matching condition"""
        self.breakpoints.append(Breakpoint(condition))
    
    def modify_next_request(self, modifier: Callable):
        """One-time request modifier"""
        self.request_interceptors.append(modifier)
    
    def replay_message(self, message_index: int):
        """Replay a captured message"""
        message = self.captured_messages[message_index]
        # Re-send to server
        pass
```

---

### Component 6: Script Debugger

```python
class BotScriptDebugger:
    """
    Debug bot scripts with breakpoints, stepping, and variable inspection.
    """
    
    def __init__(self, script_engine: ScriptEngine):
        self.engine = script_engine
        self.breakpoints = set()
        self.watches = []
        self.call_stack = []
        self.paused = False
        self.current_line = 0
        
    def set_breakpoint(self, line: int):
        """Set breakpoint at line number"""
        self.breakpoints.add(line)
    
    def add_watch(self, variable_name: str):
        """Watch a variable for changes"""
        self.watches.append(variable_name)
    
    def step_over(self):
        """Execute current line and pause at next"""
        if self.paused:
            self.engine.execute_single_line()
            self._check_breakpoints()
    
    def step_into(self):
        """Step into function call"""
        if self.paused:
            self.engine.execute_step_into()
            self._check_breakpoints()
    
    def continue_execution(self):
        """Continue until next breakpoint"""
        self.paused = False
        while not self.paused:
            self.engine.execute_single_line()
            self._check_breakpoints()
    
    def get_variables(self) -> dict:
        """Get current variable state"""
        return self.engine.get_all_variables()
    
    def evaluate(self, expression: str):
        """Evaluate expression in current context"""
        return self.engine.evaluate(expression)
    
    def inject_command(self, command: str):
        """Inject command into running script"""
        self.engine.execute_immediate(command)
```

---

## 🎮 INTEGRATED UI PANEL

### Pipeline Control Panel

```python
class PipelineControlPanel(ttk.Frame):
    """
    Unified control panel for the entire development pipeline.
    One-click access to all operations.
    """
    
    def __init__(self, parent, pipeline: DevelopmentPipeline):
        super().__init__(parent)
        self.pipeline = pipeline
        self._create_ui()
    
    def _create_ui(self):
        # === TOP: Quick Actions ===
        actions_frame = ttk.LabelFrame(self, text="Quick Actions")
        actions_frame.pack(fill="x", padx=5, pady=5)
        
        ttk.Button(actions_frame, text="🔓 Unpack SWF", 
                   command=self._unpack).pack(side="left", padx=2)
        ttk.Button(actions_frame, text="📦 Rebuild", 
                   command=self._rebuild).pack(side="left", padx=2)
        ttk.Button(actions_frame, text="▶️ Test", 
                   command=self._test).pack(side="left", padx=2)
        ttk.Button(actions_frame, text="🔄 Unpack→Rebuild→Test", 
                   command=self._full_cycle).pack(side="left", padx=2)
        
        # === MIDDLE: Status ===
        status_frame = ttk.LabelFrame(self, text="Pipeline Status")
        status_frame.pack(fill="x", padx=5, pady=5)
        
        self.status_labels = {}
        for stage in ["Unpack", "Edit", "Build", "Test"]:
            frame = ttk.Frame(status_frame)
            frame.pack(fill="x")
            ttk.Label(frame, text=f"{stage}:").pack(side="left")
            label = ttk.Label(frame, text="Ready", foreground="green")
            label.pack(side="left", padx=10)
            self.status_labels[stage] = label
        
        # === BOTTOM: Pending Changes ===
        changes_frame = ttk.LabelFrame(self, text="Pending Changes")
        changes_frame.pack(fill="both", expand=True, padx=5, pady=5)
        
        self.changes_tree = ttk.Treeview(changes_frame, columns=["file", "type", "time"])
        self.changes_tree.heading("file", text="File")
        self.changes_tree.heading("type", text="Change Type")
        self.changes_tree.heading("time", text="Time")
        self.changes_tree.pack(fill="both", expand=True)
        
        # Buttons
        btn_frame = ttk.Frame(changes_frame)
        btn_frame.pack(fill="x")
        ttk.Button(btn_frame, text="View Diff", command=self._view_diff).pack(side="left")
        ttk.Button(btn_frame, text="Rollback All", command=self._rollback).pack(side="left")
        ttk.Button(btn_frame, text="Apply & Test", command=self._apply_test).pack(side="right")
    
    def _full_cycle(self):
        """One-click: Unpack → Edit (current) → Rebuild → Test"""
        self._update_status("Unpack", "Running...")
        self.pipeline.unpack()
        self._update_status("Unpack", "Done", "green")
        
        self._update_status("Build", "Running...")
        output = self.pipeline.rebuild()
        self._update_status("Build", "Done", "green")
        
        self._update_status("Test", "Launching...")
        self.pipeline.launch_test(output)
        self._update_status("Test", "Running", "blue")
```

---

## 📊 FEATURE IMPLEMENTATION PRIORITY

| Feature | Complexity | Impact | Priority |
|---------|------------|--------|----------|
| Auto-Unpack | Medium | High | P0 |
| Auto-Rebuild | Medium | High | P0 |
| One-Click Test Launch | Low | High | P0 |
| Hot Reload Editor | High | Very High | P0 |
| Debug Proxy | High | Very High | P0 |
| Breakpoints | Medium | High | P1 |
| Variable Watch | Medium | Medium | P1 |
| Protocol Replay | Medium | High | P1 |
| Request/Response Editor | Medium | High | P1 |
| Script Debugger | High | High | P2 |
| Step Execution | High | Medium | P2 |

---

## 🚀 IMPLEMENTATION ROADMAP

### Week 1: Core Pipeline
- [ ] SWFAutoUnpacker class
- [ ] SWFAutoRepacker class  
- [ ] Basic file watching
- [ ] Pipeline control panel UI

### Week 2: Live Testing
- [ ] LiveTestLauncher class
- [ ] Ruffle integration
- [ ] Flash Projector integration
- [ ] Test session management

### Week 3: Debug Proxy
- [ ] DebugProxy class
- [ ] AMF message capture
- [ ] Request/response logging
- [ ] Message replay

### Week 4: Advanced Debugging
- [ ] Breakpoint system
- [ ] Variable watching
- [ ] Request modification
- [ ] Script debugger integration

---

**This pipeline enables the seamless Edit→Build→Test workflow needed for efficient SWF development and bot testing.**
