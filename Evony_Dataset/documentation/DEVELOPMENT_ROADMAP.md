# Svony Studio Development Roadmap

## Complete Evony Reverse Engineering & Bot Development Environment

**Version:** 2.0  
**Date:** January 2, 2026  
**Target Completion:** Q4 2026  

---

## Executive Summary

This roadmap transforms Svony Studio from a basic FFDec wrapper (10.6% feature parity) into a complete, professional-grade Evony reverse engineering and bot development environment. The plan focuses on the **Hybrid Approach** identified in the gap analysis: leveraging existing tools while building Evony-specific value.

### Strategic Goals

1. **Full FFDec Integration** - All 66 features via CLI wrapper
2. **RABCDAsm Integration** - Low-level ABC bytecode manipulation
3. **Professional SOL Management** - Complete SharedObject editing suite
4. **Network Protocol Analysis** - AMF3 traffic capture and analysis
5. **Bot Framework Support** - AutoEvony & RoboEvony integration
6. **Unified Professional UI** - CustomTkinter-based modern interface

### Timeline Overview

| Phase | Duration | Focus | Completion |
|-------|----------|-------|------------|
| **Phase 1** | Months 1-2 | Foundation & FFDec CLI | 25% |
| **Phase 2** | Months 3-4 | RABCDAsm & ABC Tools | 45% |
| **Phase 3** | Months 5-6 | SOL Management Suite | 60% |
| **Phase 4** | Months 7-8 | Network & Protocol Tools | 75% |
| **Phase 5** | Months 9-10 | Bot Framework Integration | 90% |
| **Phase 6** | Months 11-12 | Polish & Production Release | 100% |

---

## Current State Analysis

### Existing Modules (Foundation)

```
src/
├── core/
│   ├── ffdec_extended.py    # ✅ FFDec CLI wrapper (1,195 lines) - 5 phases implemented
│   ├── evony_tools.py       # ✅ Evony analysis (605 lines) - AMF, deobfuscation
│   ├── sol_manager.py       # ⚠️ Basic SOL handling - needs enhancement
│   ├── swf_tools.py         # ⚠️ Basic wrappers - needs expansion
│   ├── search.py            # ✅ Code search engine
│   ├── patches.py           # ✅ SWF patching system
│   ├── build_system.py      # ✅ SWF compilation pipeline
│   ├── bot_launcher.py      # ⚠️ Basic launcher - needs Tor integration
│   └── path_manager.py      # ✅ Bot path configuration
├── evony/
│   ├── class_browser.py     # ✅ AS3 class browser (316 lines)
│   ├── protocol.py          # ✅ Protocol analyzer (262 lines)
│   └── bot_scripts.py       # ✅ Bot script editor (416 lines)
└── ui/
    ├── dialogs/             # ⚠️ Basic dialogs - needs expansion
    ├── panels/              # ⚠️ Basic panels - needs major work
    └── widgets/             # ⚠️ Basic widgets - needs code editor
```

### Gap Summary

| Component | Current | Target | Gap |
|-----------|---------|--------|-----|
| FFDec CLI Coverage | 20% | 95% | 75% |
| RABCDAsm Integration | 40% | 95% | 55% |
| SOL Management | 30% | 100% | 70% |
| Network Tools | 10% | 80% | 70% |
| Bot Framework | 25% | 90% | 65% |
| Professional UI | 40% | 95% | 55% |

---

## Phase 1: Foundation & FFDec CLI Complete (Months 1-2)

### Objective

Complete FFDecExtended wrapper to cover all 66 FFDec features, establishing the core SWF manipulation foundation.

### 1.1 FFDec CLI Commands (Week 1-3)

#### Already Implemented in `ffdec_extended.py`

- ✅ `dump_swf()` - Complete SWF structure dump
- ✅ `list_as3_classes()` / `list_as2_scripts()`
- ✅ `compress()` / `decompress()` - ZLIB/LZMA
- ✅ `swf_to_xml()` / `xml_to_swf()` - Round-trip editing
- ✅ `export_scripts()` / `export_images()` / `export_sounds()`
- ✅ `import_scripts()` / `replace_scripts()`
- ✅ `deobfuscate()` - 3 levels
- ✅ `enable_debugging()` / `inject_debug_line()`
- ✅ `create_projector()` - Windows/Mac/Linux
- ✅ Batch operations

#### Missing Commands to Add

```python
# src/core/ffdec_extended.py - Additions

class FFDecExtended:
    # === Phase 1 Additions ===
    
    def export_fla(self, swf_path: str, output_path: str, 
                   version: str = "CS6") -> bool:
        """Export SWF to FLA format for Adobe Animate."""
        result = self._run(["-swf2fla", swf_path, output_path, "-fla", version])
        return result.returncode == 0
    
    def export_xfl(self, swf_path: str, output_path: str) -> bool:
        """Export SWF to XFL (uncompressed FLA) format."""
        result = self._run(["-swf2fla", swf_path, output_path, "-format", "xfl"])
        return result.returncode == 0
    
    def export_svg(self, swf_path: str, output_dir: str, 
                   tag_ids: List[int] = None) -> bool:
        """Export shapes as SVG vector graphics."""
        args = ["-export", "shape", swf_path, output_dir, "-format", "svg"]
        if tag_ids:
            args.extend(["-select", ",".join(map(str, tag_ids))])
        return self._run(args).returncode == 0
    
    def export_fonts(self, swf_path: str, output_dir: str,
                     format: str = "ttf") -> bool:
        """Export fonts in TTF or WOFF format."""
        return self._run(["-export", "font", swf_path, output_dir,
                         "-format", format]).returncode == 0
    
    def extract_binary_data(self, swf_path: str, output_dir: str,
                            tag_ids: List[int] = None) -> Dict[int, str]:
        """Extract DefineBinaryData tags."""
        # Implementation for binary extraction
        pass
    
    def replace_binary_data(self, swf_path: str, tag_id: int,
                           data_path: str, output_path: str) -> bool:
        """Replace binary data in specific tag."""
        pass
    
    def get_tag_tree(self, swf_path: str) -> Dict[str, Any]:
        """Get complete tag hierarchy for tree view."""
        pass
    
    def get_frame_data(self, swf_path: str, frame: int) -> Dict[str, Any]:
        """Get specific frame information."""
        pass
    
    def modify_tag(self, swf_path: str, tag_id: int,
                   modifications: Dict[str, Any]) -> bool:
        """Modify tag properties directly."""
        pass
```

### 1.2 Enhanced Evony Analysis (Week 4)

```python
# src/core/evony_tools.py - Enhancements

class EvonyTools:
    def deep_analyze_client(self, swf_path: str) -> Dict[str, Any]:
        """Comprehensive Evony client analysis."""
        return {
            "game_version": self._detect_game_version(swf_path),
            "server_list": self._extract_server_list(swf_path),
            "protocol_version": self._detect_protocol_version(swf_path),
            "encryption_type": self._detect_encryption(swf_path),
            "anti_cheat": self._detect_anti_cheat(swf_path),
            "api_endpoints": self._extract_api_endpoints(swf_path),
            "command_handlers": self._map_command_handlers(swf_path),
        }
    
    def generate_bot_skeleton(self, swf_path: str, 
                              framework: str = "roboevony") -> str:
        """Generate bot script skeleton from client analysis."""
        pass
    
    def create_protocol_documentation(self, swf_path: str,
                                       output_path: str) -> bool:
        """Auto-generate protocol documentation."""
        pass
```

### 1.3 UI Integration (Week 5-8)

#### New Panel: SWF Explorer

```python
# src/ui/panels/swf_explorer.py

class SWFExplorerPanel(ctk.CTkFrame):
    """
    Professional SWF tag tree explorer with:
    - Hierarchical tag navigation
    - Tag property inspector
    - Hex view for binary data
    - Preview panel for visual assets
    - Context menu for operations
    """
    
    def __init__(self, parent, ffdec: FFDecExtended):
        self.ffdec = ffdec
        self._create_tag_tree()
        self._create_preview_panel()
        self._create_property_inspector()
        self._create_hex_viewer()
```

### Deliverables - Phase 1

| Deliverable | Description | Effort |
|-------------|-------------|--------|
| `ffdec_extended.py` v2.0 | Complete CLI wrapper | 3 weeks |
| `swf_explorer.py` | Tag tree UI panel | 2 weeks |
| `hex_viewer.py` | Binary data viewer | 1 week |
| FFDec test suite | Unit + integration tests | 2 weeks |

---

## Phase 2: RABCDAsm & ABC Tools (Months 3-4)

### Objective

Integrate RABCDAsm for low-level ABC bytecode manipulation, enabling advanced patching and analysis beyond FFDec's capabilities.

### 2.1 RABCDAsm Wrapper (Week 1-3)

```python
# src/core/rabcdasm.py - Complete Implementation

from pathlib import Path
from typing import Dict, List, Optional, Tuple, Any
import subprocess
import tempfile
import shutil

class RABCDAsm:
    """
    Complete RABCDAsm integration for ABC bytecode manipulation.

    RABCDAsm provides:
    - rabcdasm: Disassemble ABC to human-readable format
    - rabcasm: Assemble back to ABC
    - abcexport: Export ABC blocks from SWF
    - abcreplace: Replace ABC blocks in SWF
    - swfdecompress: Decompress SWF
    """

    def __init__(self, rabcdasm_path: str = None):
        self.rabcdasm_path = rabcdasm_path or self._find_rabcdasm()
        self._validate_installation()

    def _find_rabcdasm(self) -> str:
        """Auto-detect RABCDAsm installation."""
        search_paths = [
            Path("tools/rabcdasm"),
            Path.home() / "rabcdasm",
            Path("/usr/local/bin"),
            Path("C:/Tools/rabcdasm"),
        ]
        for path in search_paths:
            if (path / "rabcdasm.exe").exists() or (path / "rabcdasm").exists():
                return str(path)
        raise FileNotFoundError("RABCDAsm not found")

    def disassemble_abc(self, abc_path: str, output_dir: str = None) -> str:
        """
        Disassemble ABC file to human-readable assembly.

        Returns path to main .asasm file.
        """
        output_dir = output_dir or tempfile.mkdtemp(prefix="rabcdasm_")
        result = subprocess.run(
            [self._get_tool("rabcdasm"), abc_path],
            cwd=output_dir,
            capture_output=True,
            text=True
        )
        if result.returncode != 0:
            raise RuntimeError(f"Disassembly failed: {result.stderr}")

        # Find main .asasm file
        abc_name = Path(abc_path).stem
        return str(Path(output_dir) / f"{abc_name}" / f"{abc_name}.main.asasm")

    def assemble_abc(self, asasm_path: str, output_path: str = None) -> str:
        """
        Assemble .asasm file back to ABC.

        Returns path to generated ABC file.
        """
        output_path = output_path or asasm_path.replace(".asasm", ".abc")
        result = subprocess.run(
            [self._get_tool("rabcasm"), asasm_path],
            capture_output=True,
            text=True
        )
        if result.returncode != 0:
            raise RuntimeError(f"Assembly failed: {result.stderr}")
        return output_path

    def export_abc_blocks(self, swf_path: str, output_dir: str = None) -> List[str]:
        """
        Export all ABC blocks from SWF.

        Returns list of paths to extracted ABC files.
        """
        output_dir = output_dir or tempfile.mkdtemp(prefix="abc_export_")
        result = subprocess.run(
            [self._get_tool("abcexport"), swf_path],
            cwd=output_dir,
            capture_output=True,
            text=True
        )
        if result.returncode != 0:
            raise RuntimeError(f"ABC export failed: {result.stderr}")

        # Find all generated ABC files
        abc_files = list(Path(output_dir).glob("*.abc"))
        return [str(f) for f in abc_files]

    def replace_abc_block(self, swf_path: str, abc_index: int,
                          abc_path: str, output_path: str) -> bool:
        """
        Replace specific ABC block in SWF.

        Args:
            swf_path: Source SWF file
            abc_index: Index of ABC block to replace (0-based)
            abc_path: Path to new ABC file
            output_path: Output SWF path
        """
        result = subprocess.run(
            [self._get_tool("abcreplace"), swf_path, str(abc_index), abc_path],
            capture_output=True,
            text=True
        )
        if result.returncode != 0:
            raise RuntimeError(f"ABC replace failed: {result.stderr}")

        # abcreplace modifies in place, so copy to output
        shutil.copy(swf_path, output_path)
        return True

    def decompress_swf(self, swf_path: str, output_path: str = None) -> str:
        """Decompress SWF file."""
        output_path = output_path or swf_path.replace(".swf", "_decompressed.swf")
        result = subprocess.run(
            [self._get_tool("swfdecompress"), swf_path, output_path],
            capture_output=True,
            text=True
        )
        return output_path

    # === Advanced Operations ===

    def patch_bytecode(self, swf_path: str, patches: List[Dict],
                       output_path: str) -> bool:
        """
        Apply bytecode patches to SWF.

        Args:
            patches: List of patch definitions:
                {
                    "abc_index": 0,
                    "class": "com.evony.client.Main",
                    "method": "checkLicense",
                    "find": "pushfalse\nreturnvalue",
                    "replace": "pushtrue\nreturnvalue"
                }
        """
        with tempfile.TemporaryDirectory() as temp_dir:
            # Export ABC blocks
            abc_files = self.export_abc_blocks(swf_path, temp_dir)

            for patch in patches:
                abc_path = abc_files[patch["abc_index"]]

                # Disassemble
                asasm_path = self.disassemble_abc(abc_path)

                # Find and patch the method
                self._apply_asasm_patch(asasm_path, patch)

                # Reassemble
                new_abc = self.assemble_abc(asasm_path)

                # Replace in SWF
                self.replace_abc_block(swf_path, patch["abc_index"],
                                       new_abc, output_path)

        return True

    def analyze_bytecode(self, abc_path: str) -> Dict[str, Any]:
        """
        Analyze ABC bytecode structure.

        Returns detailed analysis including:
        - Class hierarchy
        - Method signatures
        - Constant pool
        - Metadata
        """
        asasm_path = self.disassemble_abc(abc_path)
        return self._parse_asasm_structure(asasm_path)

    def extract_strings(self, abc_path: str) -> List[str]:
        """Extract all string constants from ABC."""
        analysis = self.analyze_bytecode(abc_path)
        return analysis.get("constant_pool", {}).get("strings", [])

    def find_method_calls(self, abc_path: str,
                          method_name: str) -> List[Dict[str, Any]]:
        """Find all calls to a specific method."""
        pass

    def generate_call_graph(self, abc_path: str) -> Dict[str, List[str]]:
        """Generate method call graph."""
        pass
```

### 2.2 ABC Analysis Tools (Week 4-5)

```python
# src/core/abc_analyzer.py

class ABCAnalyzer:
    """
    Advanced ABC bytecode analysis for Evony reverse engineering.
    """

    def __init__(self, rabcdasm: RABCDAsm, ffdec: FFDecExtended):
        self.rabcdasm = rabcdasm
        self.ffdec = ffdec

    def compare_versions(self, old_swf: str, new_swf: str) -> Dict[str, Any]:
        """
        Compare two Evony client versions.

        Returns:
            - Added classes/methods
            - Removed classes/methods
            - Modified methods (bytecode diff)
            - Protocol changes
        """
        pass

    def find_encryption_routines(self, swf_path: str) -> List[Dict]:
        """
        Identify encryption/decryption methods.

        Looks for:
        - XOR patterns
        - AES/DES usage
        - Custom obfuscation
        """
        pass

    def trace_data_flow(self, swf_path: str,
                        start_method: str) -> Dict[str, Any]:
        """
        Trace data flow from a method.

        Useful for understanding how data is:
        - Received from server
        - Processed
        - Stored locally
        """
        pass

    def generate_protocol_stubs(self, swf_path: str,
                                output_dir: str) -> List[str]:
        """
        Generate Python stubs for Evony protocol handlers.

        Creates ready-to-use Python classes matching
        the ActionScript protocol implementation.
        """
        pass
```

### 2.3 Bytecode Editor UI (Week 6-8)

```python
# src/ui/panels/bytecode_editor.py

class BytecodeEditorPanel(ctk.CTkFrame):
    """
    Professional bytecode editor with:
    - Syntax-highlighted ASASM view
    - Instruction reference sidebar
    - Stack visualization
    - Breakpoint support (for debugging)
    - Diff view for patches
    """

    def __init__(self, parent, rabcdasm: RABCDAsm):
        self.rabcdasm = rabcdasm
        self._create_editor()
        self._create_instruction_reference()
        self._create_stack_visualizer()
```

### Deliverables - Phase 2

| Deliverable | Description | Effort |
|-------------|-------------|--------|
| `rabcdasm.py` | Complete RABCDAsm wrapper | 3 weeks |
| `abc_analyzer.py` | Advanced analysis tools | 2 weeks |
| `bytecode_editor.py` | UI for bytecode editing | 2 weeks |
| RABCDAsm test suite | Comprehensive tests | 1 week |

---

## Phase 3: SOL Management Suite (Months 5-6)

### Objective

Build a professional SharedObject (SOL) management system for Evony save data analysis and modification.

### 3.1 Enhanced SOL Manager (Week 1-3)

```python
# src/core/sol_manager.py - Complete Rewrite

from pathlib import Path
from typing import Dict, List, Any, Optional, Union
import pyamf
from pyamf import sol
import json
import struct
from datetime import datetime

class SOLManager:
    """
    Professional SharedObject (SOL) file manager.

    Features:
    - Read/write SOL files (AMF0 and AMF3)
    - Type-aware editing
    - Backup management
    - Batch operations
    - Evony-specific data structures
    """

    # Evony SOL file locations
    EVONY_SOL_PATHS = {
        "windows": [
            Path.home() / "AppData/Roaming/Macromedia/Flash Player/#SharedObjects",
            Path.home() / "AppData/Local/Google/Chrome/User Data/Default/Pepper Data/Shockwave Flash/WritableRoot/#SharedObjects",
        ],
        "mac": [
            Path.home() / "Library/Preferences/Macromedia/Flash Player/#SharedObjects",
        ],
        "linux": [
            Path.home() / ".macromedia/Flash_Player/#SharedObjects",
        ]
    }

    def __init__(self, backup_dir: str = None):
        self.backup_dir = Path(backup_dir) if backup_dir else Path("backups/sol")
        self.backup_dir.mkdir(parents=True, exist_ok=True)

    def read_sol(self, sol_path: str) -> Dict[str, Any]:
        """
        Read SOL file and return structured data.

        Returns:
            {
                "name": "evony_settings",
                "amf_version": 3,
                "data": {...},
                "metadata": {
                    "file_size": 1234,
                    "modified": "2026-01-02T10:30:00",
                    "encoding": "AMF3"
                }
            }
        """
        with open(sol_path, 'rb') as f:
            sol_data = sol.load(f)

        return {
            "name": sol_data.name,
            "amf_version": self._detect_amf_version(sol_path),
            "data": self._convert_to_python(sol_data),
            "metadata": self._get_file_metadata(sol_path)
        }

    def write_sol(self, sol_path: str, data: Dict[str, Any],
                  create_backup: bool = True) -> bool:
        """
        Write data to SOL file.

        Args:
            sol_path: Output path
            data: Data structure to write
            create_backup: Whether to backup existing file
        """
        if create_backup and Path(sol_path).exists():
            self._create_backup(sol_path)

        sol_obj = sol.SOL(data.get("name", "data"))
        for key, value in data.get("data", {}).items():
            sol_obj[key] = self._convert_from_python(value)

        with open(sol_path, 'wb') as f:
            sol.dump(sol_obj, f)

        return True

    def find_evony_sols(self) -> List[Dict[str, Any]]:
        """
        Find all Evony-related SOL files on the system.

        Returns list of:
            {
                "path": "/path/to/file.sol",
                "name": "evony_settings",
                "size": 1234,
                "modified": "2026-01-02",
                "type": "settings|credentials|cache"
            }
        """
        import platform
        system = platform.system().lower()
        if system == "darwin":
            system = "mac"

        sols = []
        for base_path in self.EVONY_SOL_PATHS.get(system, []):
            if base_path.exists():
                for sol_file in base_path.rglob("*.sol"):
                    if self._is_evony_sol(sol_file):
                        sols.append(self._get_sol_info(sol_file))

        return sols

    def get_value(self, sol_path: str, key_path: str) -> Any:
        """
        Get value from SOL using dot notation.

        Example: get_value("file.sol", "settings.graphics.quality")
        """
        data = self.read_sol(sol_path)
        keys = key_path.split(".")
        value = data["data"]
        for key in keys:
            if isinstance(value, dict):
                value = value.get(key)
            elif isinstance(value, list) and key.isdigit():
                value = value[int(key)]
            else:
                return None
        return value

    def set_value(self, sol_path: str, key_path: str,
                  value: Any, create_backup: bool = True) -> bool:
        """
        Set value in SOL using dot notation.

        Example: set_value("file.sol", "settings.graphics.quality", "high")
        """
        data = self.read_sol(sol_path)
        keys = key_path.split(".")

        # Navigate to parent
        current = data["data"]
        for key in keys[:-1]:
            if key not in current:
                current[key] = {}
            current = current[key]

        # Set value
        current[keys[-1]] = value

        return self.write_sol(sol_path, data, create_backup)

    def export_to_json(self, sol_path: str, json_path: str) -> bool:
        """Export SOL to human-readable JSON."""
        data = self.read_sol(sol_path)
        with open(json_path, 'w') as f:
            json.dump(data, f, indent=2, default=str)
        return True

    def import_from_json(self, json_path: str, sol_path: str) -> bool:
        """Import JSON back to SOL format."""
        with open(json_path, 'r') as f:
            data = json.load(f)
        return self.write_sol(sol_path, data)

    def compare_sols(self, sol1_path: str, sol2_path: str) -> Dict[str, Any]:
        """
        Compare two SOL files.

        Returns:
            {
                "added": {...},
                "removed": {...},
                "modified": {...}
            }
        """
        pass

    def batch_modify(self, sol_paths: List[str],
                     modifications: Dict[str, Any]) -> Dict[str, bool]:
        """
        Apply same modifications to multiple SOL files.

        Useful for applying settings across multiple accounts.
        """
        results = {}
        for sol_path in sol_paths:
            try:
                for key_path, value in modifications.items():
                    self.set_value(sol_path, key_path, value)
                results[sol_path] = True
            except Exception as e:
                results[sol_path] = False
        return results

    # === Evony-Specific Methods ===

    def get_saved_credentials(self, sol_path: str) -> Dict[str, str]:
        """Extract saved login credentials from Evony SOL."""
        pass

    def get_server_list(self, sol_path: str) -> List[Dict[str, Any]]:
        """Extract cached server list."""
        pass

    def get_game_settings(self, sol_path: str) -> Dict[str, Any]:
        """Extract game settings (graphics, sound, etc.)."""
        pass

    def clear_cache(self, sol_path: str) -> bool:
        """Clear cached data while preserving settings."""
        pass
```

### 3.2 SOL Editor UI (Week 4-6)

```python
# src/ui/panels/sol_editor.py

class SOLEditorPanel(ctk.CTkFrame):
    """
    Professional SOL file editor with:
    - Tree view for nested data
    - Type-aware value editors
    - Hex view for binary data
    - JSON import/export
    - Diff viewer
    - Backup management
    """

    def __init__(self, parent, sol_manager: SOLManager):
        self.sol_manager = sol_manager
        self._create_file_browser()
        self._create_data_tree()
        self._create_value_editor()
        self._create_toolbar()
```



### Deliverables - Phase 3

| Deliverable | Description | Effort |
|-------------|-------------|--------|
| `sol_manager.py` v2.0 | Complete SOL management | 3 weeks |
| `sol_editor.py` | Professional UI | 3 weeks |
| SOL documentation | Format documentation | 1 week |
| Test suite | Comprehensive tests | 1 week |

---

## Phase 4: Network & Protocol Tools (Months 7-8)

### Objective

Build comprehensive network analysis tools for capturing, analyzing, and replaying Evony protocol traffic.

### 4.1 AMF3 Protocol Analyzer (Week 1-4)

```python
# src/core/protocol_analyzer.py

from typing import Dict, List, Any, Optional, Callable
import pyamf
from pyamf import remoting
import socket
import ssl
import threading
from dataclasses import dataclass
from datetime import datetime

@dataclass
class ProtocolMessage:
    """Represents a captured protocol message."""
    timestamp: datetime
    direction: str  # "client_to_server" or "server_to_client"
    raw_data: bytes
    decoded_data: Any
    message_type: str
    command_id: Optional[int] = None

class ProtocolAnalyzer:
    """
    Evony protocol analysis and capture tool.

    Features:
    - AMF3 message decoding
    - Traffic capture (proxy mode)
    - Message replay
    - Protocol documentation generation
    """

    def __init__(self):
        self.captured_messages: List[ProtocolMessage] = []
        self.message_handlers: Dict[str, Callable] = {}
        self._proxy_running = False

    def decode_amf(self, data: bytes) -> Any:
        """Decode AMF3 data to Python objects."""
        try:
            return pyamf.decode(data, encoding=pyamf.AMF3)
        except Exception:
            # Try AMF0 fallback
            return pyamf.decode(data, encoding=pyamf.AMF0)

    def encode_amf(self, data: Any, version: int = 3) -> bytes:
        """Encode Python objects to AMF format."""
        encoding = pyamf.AMF3 if version == 3 else pyamf.AMF0
        return pyamf.encode(data, encoding=encoding).getvalue()

    def start_proxy(self, listen_port: int, target_host: str,
                    target_port: int, use_ssl: bool = True) -> bool:
        """
        Start transparent proxy for traffic capture.

        Args:
            listen_port: Local port to listen on
            target_host: Evony server hostname
            target_port: Evony server port
            use_ssl: Whether to use SSL/TLS
        """
        self._proxy_running = True
        self._proxy_thread = threading.Thread(
            target=self._run_proxy,
            args=(listen_port, target_host, target_port, use_ssl)
        )
        self._proxy_thread.start()
        return True

    def stop_proxy(self):
        """Stop the proxy server."""
        self._proxy_running = False

    def _run_proxy(self, listen_port: int, target_host: str,
                   target_port: int, use_ssl: bool):
        """Proxy server main loop."""
        server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        server.bind(('127.0.0.1', listen_port))
        server.listen(5)

        while self._proxy_running:
            try:
                client_sock, addr = server.accept()
                threading.Thread(
                    target=self._handle_connection,
                    args=(client_sock, target_host, target_port, use_ssl)
                ).start()
            except Exception:
                break

    def _handle_connection(self, client_sock: socket.socket,
                           target_host: str, target_port: int,
                           use_ssl: bool):
        """Handle a single proxied connection."""
        # Connect to target
        target_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        if use_ssl:
            context = ssl.create_default_context()
            target_sock = context.wrap_socket(target_sock,
                                              server_hostname=target_host)
        target_sock.connect((target_host, target_port))

        # Bidirectional forwarding with capture
        # ... implementation details

    def analyze_message(self, data: bytes,
                        direction: str) -> ProtocolMessage:
        """Analyze a captured message."""
        decoded = self.decode_amf(data)
        msg_type = self._identify_message_type(decoded)

        return ProtocolMessage(
            timestamp=datetime.now(),
            direction=direction,
            raw_data=data,
            decoded_data=decoded,
            message_type=msg_type,
            command_id=self._extract_command_id(decoded)
        )

    def replay_message(self, message: ProtocolMessage,
                       target_host: str, target_port: int) -> Any:
        """Replay a captured message to the server."""
        pass

    def export_capture(self, output_path: str,
                       format: str = "json") -> bool:
        """Export captured messages."""
        pass

    def import_capture(self, input_path: str) -> List[ProtocolMessage]:
        """Import previously captured messages."""
        pass

    def generate_protocol_docs(self, output_path: str) -> bool:
        """Generate protocol documentation from captures."""
        pass

    # === Evony-Specific Analysis ===

    def identify_command_handlers(self,
                                   messages: List[ProtocolMessage]) -> Dict:
        """Map command IDs to handler names."""
        pass

    def extract_game_state(self,
                           messages: List[ProtocolMessage]) -> Dict:
        """Extract game state from message sequence."""
        pass

    def detect_encryption(self,
                          messages: List[ProtocolMessage]) -> Dict:
        """Detect encryption patterns in messages."""
        pass
```

### 4.2 Network Monitor UI (Week 5-8)

```python
# src/ui/panels/network_monitor.py

class NetworkMonitorPanel(ctk.CTkFrame):
    """
    Professional network traffic monitor with:
    - Real-time message capture display
    - Message filtering and search
    - Hex + decoded view
    - Message replay controls
    - Export/import functionality
    - Protocol statistics
    """

    def __init__(self, parent, analyzer: ProtocolAnalyzer):
        self.analyzer = analyzer
        self._create_capture_controls()
        self._create_message_list()
        self._create_detail_view()
        self._create_statistics_panel()
```

### Deliverables - Phase 4

| Deliverable | Description | Effort |
|-------------|-------------|--------|
| `protocol_analyzer.py` | Complete protocol tools | 4 weeks |
| `network_monitor.py` | Traffic capture UI | 3 weeks |
| Protocol documentation | Evony protocol docs | 1 week |

---

## Phase 5: Bot Framework Integration (Months 9-10)

### Objective

Integrate AutoEvony and RoboEvony bot frameworks with Tor support for anonymous operation.

### 5.1 Enhanced Bot Launcher (Week 1-4)

```python
# src/core/bot_launcher.py - Complete Rewrite

from pathlib import Path
from typing import Dict, List, Optional, Any
import subprocess
import threading
import json
from dataclasses import dataclass
from enum import Enum

class BotFramework(Enum):
    AUTOEVONY = "autoevony"
    ROBOEVONY = "roboevony"
    CUSTOM = "custom"

@dataclass
class BotInstance:
    """Represents a running bot instance."""
    id: str
    framework: BotFramework
    account: str
    server: str
    process: subprocess.Popen
    tor_port: Optional[int] = None
    status: str = "running"

class BotLauncher:
    """
    Professional bot launcher with Tor integration.

    Features:
    - Multi-framework support (AutoEvony, RoboEvony)
    - Tor circuit management
    - Account rotation
    - Health monitoring
    - Crash recovery
    """

    def __init__(self, config_path: str = None):
        self.config = self._load_config(config_path)
        self.instances: Dict[str, BotInstance] = {}
        self.tor_manager = TorManager()

    def launch_bot(self, framework: BotFramework, account: Dict,
                   server: str, use_tor: bool = True,
                   script: str = None) -> BotInstance:
        """
        Launch a bot instance.

        Args:
            framework: Bot framework to use
            account: Account credentials
            server: Target server
            use_tor: Whether to route through Tor
            script: Custom script to run
        """
        # Get Tor circuit if needed
        tor_port = None
        if use_tor:
            tor_port = self.tor_manager.get_circuit()

        # Build launch command
        cmd = self._build_launch_command(framework, account, server,
                                         tor_port, script)

        # Launch process
        process = subprocess.Popen(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            cwd=self._get_framework_path(framework)
        )

        instance = BotInstance(
            id=self._generate_id(),
            framework=framework,
            account=account["username"],
            server=server,
            process=process,
            tor_port=tor_port
        )

        self.instances[instance.id] = instance
        self._start_monitoring(instance)

        return instance

    def stop_bot(self, instance_id: str) -> bool:
        """Stop a running bot instance."""
        if instance_id in self.instances:
            instance = self.instances[instance_id]
            instance.process.terminate()
            if instance.tor_port:
                self.tor_manager.release_circuit(instance.tor_port)
            instance.status = "stopped"
            return True
        return False

    def get_bot_status(self, instance_id: str) -> Dict[str, Any]:
        """Get detailed status of a bot instance."""
        pass

    def get_bot_logs(self, instance_id: str,
                     lines: int = 100) -> List[str]:
        """Get recent log lines from a bot."""
        pass

    def restart_bot(self, instance_id: str) -> BotInstance:
        """Restart a bot with same configuration."""
        pass

    def batch_launch(self, configs: List[Dict]) -> List[BotInstance]:
        """Launch multiple bots from configuration list."""
        pass

    def batch_stop(self, instance_ids: List[str] = None) -> Dict[str, bool]:
        """Stop multiple or all bots."""
        pass


class TorManager:
    """
    Tor circuit management for anonymous bot operation.

    Features:
    - Multiple circuit management
    - Circuit rotation
    - Health checking
    - Automatic recovery
    """

    def __init__(self, tor_path: str = None,
                 control_port: int = 9051):
        self.tor_path = tor_path or self._find_tor()
        self.control_port = control_port
        self.circuits: Dict[int, Dict] = {}

    def start_tor(self) -> bool:
        """Start Tor service."""
        pass

    def stop_tor(self) -> bool:
        """Stop Tor service."""
        pass

    def get_circuit(self) -> int:
        """Get an available SOCKS port for a new circuit."""
        pass

    def release_circuit(self, port: int) -> bool:
        """Release a circuit back to the pool."""
        pass

    def rotate_circuit(self, port: int) -> bool:
        """Force circuit rotation for a specific port."""
        pass

    def check_circuit_health(self, port: int) -> Dict[str, Any]:
        """Check if a circuit is healthy."""
        pass

    def get_exit_ip(self, port: int) -> str:
        """Get the exit node IP for a circuit."""
        pass
```

### 5.2 Bot Management UI (Week 5-8)

```python
# src/ui/panels/bot_manager.py

class BotManagerPanel(ctk.CTkFrame):
    """
    Professional bot management interface with:
    - Instance list with status indicators
    - Launch wizard
    - Log viewer
    - Resource monitoring
    - Tor circuit status
    - Batch operations
    """

    def __init__(self, parent, launcher: BotLauncher):
        self.launcher = launcher
        self._create_instance_list()
        self._create_launch_wizard()
        self._create_log_viewer()
        self._create_tor_status()
```

### Deliverables - Phase 5

| Deliverable | Description | Effort |
|-------------|-------------|--------|
| `bot_launcher.py` v2.0 | Complete bot launcher | 3 weeks |
| `tor_manager.py` | Tor integration | 2 weeks |
| `bot_manager.py` | Management UI | 2 weeks |
| Bot framework docs | Integration guides | 1 week |

---

## Phase 6: Polish & Production Release (Months 11-12)

### 6.1 Professional UI Overhaul (Week 1-4)

```python
# src/ui/main_window.py - Complete Redesign

class MainWindow(ctk.CTk):
    """
    Professional main application window with:
    - Dockable panel system
    - Customizable layouts
    - Theme support (dark/light)
    - Keyboard shortcuts
    - Session persistence
    """

    def __init__(self):
        super().__init__()
        self.title("Svony Studio")
        self.geometry("1600x900")

        self._setup_theme()
        self._create_menu_bar()
        self._create_toolbar()
        self._create_dock_system()
        self._create_status_bar()
        self._restore_session()

    def _create_dock_system(self):
        """Create dockable panel system."""
        self.dock_manager = DockManager(self)

        # Register all panels
        self.dock_manager.register_panel("swf_explorer", SWFExplorerPanel)
        self.dock_manager.register_panel("bytecode_editor", BytecodeEditorPanel)
        self.dock_manager.register_panel("sol_editor", SOLEditorPanel)
        self.dock_manager.register_panel("network_monitor", NetworkMonitorPanel)
        self.dock_manager.register_panel("bot_manager", BotManagerPanel)
        self.dock_manager.register_panel("class_browser", ClassBrowserPanel)
        self.dock_manager.register_panel("protocol_analyzer", ProtocolPanel)
        self.dock_manager.register_panel("script_editor", ScriptEditorPanel)
```

### 6.2 Code Editor Widget (Week 2-3)

```python
# src/ui/widgets/code_editor.py

class CodeEditor(ctk.CTkFrame):
    """
    Professional code editor widget with:
    - Syntax highlighting (AS3, Python, ASASM)
    - Line numbers
    - Code folding
    - Auto-completion
    - Find/replace
    - Multiple cursors
    - Minimap
    """

    LANGUAGES = {
        "actionscript3": AS3Highlighter,
        "python": PythonHighlighter,
        "asasm": ASASMHighlighter,
        "xml": XMLHighlighter,
        "json": JSONHighlighter,
    }

    def __init__(self, parent, language: str = "actionscript3"):
        self.language = language
        self.highlighter = self.LANGUAGES.get(language)()
        self._create_editor()
        self._create_line_numbers()
        self._create_minimap()
        self._setup_keybindings()
```

### 6.3 Testing & Documentation (Week 5-8)

#### Test Coverage Goals

| Module | Current | Target |
|--------|---------|--------|
| `ffdec_extended.py` | 20% | 90% |
| `rabcdasm.py` | 0% | 85% |
| `sol_manager.py` | 15% | 90% |
| `protocol_analyzer.py` | 0% | 80% |
| `bot_launcher.py` | 10% | 85% |
| UI Components | 5% | 70% |

#### Documentation Deliverables

1. **User Guide** - Complete usage documentation
2. **API Reference** - All public APIs documented
3. **Developer Guide** - Architecture and contribution guide
4. **Tutorial Series** - Step-by-step tutorials for common tasks
5. **Video Tutorials** - Screen recordings for complex workflows

### Deliverables - Phase 6

| Deliverable | Description | Effort |
|-------------|-------------|--------|
| UI Overhaul | Professional interface | 4 weeks |
| Code Editor | Full-featured editor | 2 weeks |
| Test Suite | Comprehensive tests | 2 weeks |
| Documentation | Complete docs | 2 weeks |

---

## Architecture Overview

### Module Dependencies

```
┌─────────────────────────────────────────────────────────────────┐
│                         UI Layer                                 │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐           │
│  │SWF       │ │Bytecode  │ │SOL       │ │Network   │           │
│  │Explorer  │ │Editor    │ │Editor    │ │Monitor   │           │
│  └────┬─────┘ └────┬─────┘ └────┬─────┘ └────┬─────┘           │
└───────┼────────────┼────────────┼────────────┼──────────────────┘
        │            │            │            │
┌───────┼────────────┼────────────┼────────────┼──────────────────┐
│       ▼            ▼            ▼            ▼                  │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐           │
│  │FFDec     │ │RABCDAsm  │ │SOL       │ │Protocol  │           │
│  │Extended  │ │Wrapper   │ │Manager   │ │Analyzer  │           │
│  └────┬─────┘ └────┬─────┘ └────┬─────┘ └────┬─────┘           │
│       │            │            │            │                  │
│       ▼            ▼            ▼            ▼                  │
│  ┌─────────────────────────────────────────────────┐           │
│  │              Evony Tools Layer                   │           │
│  │  ┌─────────┐ ┌─────────┐ ┌─────────┐           │           │
│  │  │Deobfusc │ │Protocol │ │Bot      │           │           │
│  │  │ation    │ │Stubs    │ │Scripts  │           │           │
│  │  └─────────┘ └─────────┘ └─────────┘           │           │
│  └─────────────────────────────────────────────────┘           │
│                       Core Layer                                │
└─────────────────────────────────────────────────────────────────┘
        │            │            │            │
        ▼            ▼            ▼            ▼
┌─────────────────────────────────────────────────────────────────┐
│                    External Tools                                │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐           │
│  │FFDec     │ │RABCDAsm  │ │Tor       │ │Bot       │           │
│  │(Java)    │ │(D)       │ │          │ │Frameworks│           │
│  └──────────┘ └──────────┘ └──────────┘ └──────────┘           │
└─────────────────────────────────────────────────────────────────┘
```

### Data Flow

```
SWF File ──► FFDec ──► Decompiled AS3 ──► Analysis
    │                        │
    ▼                        ▼
RABCDAsm ──► ABC Bytecode ──► Patching ──► Modified SWF
    │
    ▼
Protocol Analysis ──► Bot Script Generation ──► Bot Execution
```

---

## Risk Assessment

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| FFDec API changes | High | Low | Version pinning, abstraction layer |
| RABCDAsm compatibility | Medium | Medium | Fallback to FFDec for basic ops |
| Evony protocol changes | High | High | Modular protocol handlers |
| Tor blocking | Medium | Medium | Multiple proxy options |
| Performance issues | Medium | Medium | Async operations, caching |

---

## Success Metrics

### Phase Completion Criteria

| Phase | Criteria |
|-------|----------|
| Phase 1 | 95% FFDec CLI coverage, SWF Explorer functional |
| Phase 2 | RABCDAsm integration complete, bytecode patching works |
| Phase 3 | SOL read/write/edit fully functional |
| Phase 4 | Protocol capture and analysis working |
| Phase 5 | Bot launch with Tor working |
| Phase 6 | All tests passing, documentation complete |

### Quality Gates

- **Code Coverage**: Minimum 80% for core modules
- **Performance**: SWF analysis < 5 seconds for typical files
- **Stability**: No crashes during normal operation
- **Usability**: All features accessible via UI and CLI

---

## Resource Requirements

### Development Team

| Role | Allocation | Phases |
|------|------------|--------|
| Lead Developer | 100% | All |
| UI Developer | 50% | 1, 3, 5, 6 |
| QA Engineer | 25% | All |
| Technical Writer | 25% | 6 |

### Infrastructure

- **Development**: Windows/Mac/Linux workstations
- **Testing**: VM farm for multi-platform testing
- **CI/CD**: GitHub Actions for automated testing
- **Documentation**: MkDocs or Sphinx for docs site

---

## Appendix A: FFDec CLI Reference

### Complete Command List

| Command | Description | Status |
|---------|-------------|--------|
| `-export script` | Export scripts | ✅ Implemented |
| `-export image` | Export images | ✅ Implemented |
| `-export sound` | Export sounds | ✅ Implemented |
| `-export shape` | Export shapes | 🔲 Phase 1 |
| `-export font` | Export fonts | 🔲 Phase 1 |
| `-export binaryData` | Export binary | 🔲 Phase 1 |
| `-import script` | Import scripts | ✅ Implemented |
| `-replace` | Replace assets | ✅ Implemented |
| `-swf2xml` | SWF to XML | ✅ Implemented |
| `-xml2swf` | XML to SWF | ✅ Implemented |
| `-compress` | Compress SWF | ✅ Implemented |
| `-decompress` | Decompress SWF | ✅ Implemented |
| `-deobfuscate` | Deobfuscate | ✅ Implemented |
| `-enabledebugging` | Enable debug | ✅ Implemented |
| `-swf2fla` | Export to FLA | 🔲 Phase 1 |
| `-fla2swf` | Import from FLA | 🔲 Phase 1 |
| `-dump` | Dump structure | ✅ Implemented |
| `-dumpSWF` | Dump SWF info | ✅ Implemented |
| `-dumpAS2` | Dump AS2 | ✅ Implemented |
| `-dumpAS3` | Dump AS3 | ✅ Implemented |

---

## Appendix B: Evony Protocol Commands

### Known Command IDs

| ID | Command | Direction | Description |
|----|---------|-----------|-------------|
| 0x01 | LOGIN | C→S | Login request |
| 0x02 | LOGIN_RESP | S→C | Login response |
| 0x10 | GET_CITY | C→S | Request city data |
| 0x11 | CITY_DATA | S→C | City data response |
| 0x20 | BUILD | C→S | Build structure |
| 0x21 | BUILD_RESP | S→C | Build response |
| ... | ... | ... | ... |

*Note: Command IDs vary by Evony version. Use protocol analyzer to map current version.*

---

## Appendix C: File Formats

### SOL File Structure

```
Offset  Size  Description
0x00    2     Magic (0x00BF)
0x02    4     File size
0x06    10    "TCSO" + padding
0x10    2     Name length
0x12    N     Name (UTF-8)
0x12+N  4     AMF version
0x16+N  ...   AMF data
```

### ABC File Structure

```
Offset  Size  Description
0x00    2     Minor version
0x02    2     Major version
0x04    ...   Constant pool
...     ...   Methods
...     ...   Metadata
...     ...   Classes
...     ...   Scripts
...     ...   Method bodies
```

---

*Document Version: 2.0*
*Last Updated: January 2, 2026*
*Next Review: February 1, 2026*
