# Svony Studio - API Reference

> **"Collective Interface Specifications"** - Module and Class Reference

---

## Core Modules

### `src.core.config`

Configuration management for the application.

```python
from src.core.config import Config

class Config:
    """Application configuration management."""
    
    CONFIG_DIR: Path      # %APPDATA%/SvonyStudio
    CONFIG_FILE: Path     # config.json location
    
    def __init__(self) -> None:
        """Initialize config, load from file."""
    
    def get(self, key: str, default: Any = None) -> Any:
        """
        Get configuration value.
        
        Args:
            key: Configuration key (dot notation supported)
            default: Default value if key not found
        
        Returns:
            Configuration value or default
        
        Example:
            >>> config.get('tools.ffdec_path')
            'C:/Program Files/FFDec/ffdec.bat'
        """
    
    def set(self, key: str, value: Any) -> None:
        """
        Set configuration value and save.
        
        Args:
            key: Configuration key
            value: Value to set
        """
    
    def save(self) -> None:
        """Save configuration to disk."""
    
    def load(self) -> None:
        """Load configuration from disk."""
```

---

### `src.core.project`

Project file management.

```python
from src.core.project import SvonyProject

class SvonyProject:
    """Svony Studio project management."""
    
    name: str           # Project name
    path: Path          # Project directory
    swf_files: list     # Loaded SWF files
    sol_paths: list     # SOL search paths
    settings: dict      # Project-specific settings
    notes: str          # User notes
    
    @classmethod
    def create(cls, name: str, path: Path) -> 'SvonyProject':
        """
        Create a new project.
        
        Args:
            name: Project name
            path: Directory to create project in
        
        Returns:
            New SvonyProject instance
        """
    
    @classmethod
    def load(cls, project_file: Path) -> 'SvonyProject':
        """
        Load existing project from .svony file.
        
        Args:
            project_file: Path to .svony file
        
        Returns:
            Loaded SvonyProject instance
        """
    
    def save(self) -> None:
        """Save project to .svony file."""
    
    def add_swf(self, swf_path: Path) -> dict:
        """
        Add SWF file to project.
        
        Args:
            swf_path: Path to SWF file
        
        Returns:
            SWF metadata dict
        """
    
    def export_path(self, category: str) -> Path:
        """
        Get export directory for category.
        
        Args:
            category: 'scripts', 'images', 'sounds', etc.
        
        Returns:
            Path to export directory
        """
```

---

### `src.core.swf_tools`

SWF file analysis and manipulation.

```python
from src.core.swf_tools import FFDecWrapper, SWFToolsWrapper

class FFDecWrapper:
    """Wrapper for JPEXS FFDec CLI."""
    
    def __init__(self, ffdec_path: str) -> None:
        """
        Initialize FFDec wrapper.
        
        Args:
            ffdec_path: Path to ffdec.bat
        
        Raises:
            FileNotFoundError: If FFDec not found
        """
    
    def get_swf_info(self, swf_path: str) -> dict:
        """
        Get SWF file metadata.
        
        Returns:
            {
                'version': int,
                'compression': str,
                'width': int,
                'height': int,
                'frame_count': int,
                'frame_rate': float,
                'file_size': int
            }
        """
    
    def export_scripts(self, swf_path: str, output_dir: str) -> bool:
        """Export ActionScript to directory."""
    
    def export_images(self, swf_path: str, output_dir: str) -> bool:
        """Export images to directory."""
    
    def export_sounds(self, swf_path: str, output_dir: str) -> bool:
        """Export sounds to directory."""
    
    def export_all(self, swf_path: str, output_dir: str) -> bool:
        """Export all assets."""
    
    def decompile(self, swf_path: str) -> str:
        """
        Decompile SWF and return script content.
        
        Returns:
            Concatenated ActionScript source
        """
    
    def dump_tags(self, swf_path: str) -> list:
        """
        Get list of SWF tags.
        
        Returns:
            List of tag dicts with id, type, size
        """


class SWFToolsWrapper:
    """Wrapper for SWFTools utilities."""
    
    def swfdump(self, swf_path: str) -> str:
        """Dump SWF structure as text."""
    
    def swfstrings(self, swf_path: str) -> list:
        """Extract all strings from SWF."""
```

---

### `src.core.sol_manager`

Flash SharedObject (SOL) file management.

```python
from src.core.sol_manager import SOLManager

class SOLManager:
    """Flash SharedObject manager."""
    
    EVONY_PATTERNS: list = ['evony.com', 'cevony', 'localhost']
    
    def __init__(self) -> None:
        """Initialize SOL manager."""
    
    def scan_directories(self) -> list[Path]:
        """
        Find all Evony-related SOL files.
        
        Returns:
            List of discovered SOL file paths
        """
    
    def parse_sol(self, sol_path: Path) -> dict:
        """
        Parse SOL file contents.
        
        Args:
            sol_path: Path to .sol file
        
        Returns:
            Decoded SOL data dictionary
        """
    
    def extract_account(self, sol_path: Path) -> dict:
        """
        Extract account credentials from SOL.
        
        Returns:
            {
                'username': str,
                'password': str (MD5),
                'server': str,
                'last_login': datetime,
                'auto_login': bool
            }
        """
    
    def export_json(self, sol_data: dict, output_path: Path) -> None:
        """Export SOL data as JSON file."""
    
    def write_sol(self, sol_path: Path, data: dict) -> None:
        """
        Write data to SOL file.
        
        Args:
            sol_path: Output path
            data: Data to write
        """
```

---

### `src.core.search`

Code search functionality.

```python
from src.core.search import SearchEngine

class SearchEngine:
    """Code and content search engine."""
    
    def __init__(self) -> None:
        """Initialize search engine."""
    
    def search(
        self, 
        query: str, 
        paths: list[Path],
        case_sensitive: bool = False,
        regex: bool = False,
        whole_word: bool = False
    ) -> list[SearchResult]:
        """
        Search for pattern in files.
        
        Args:
            query: Search pattern
            paths: Paths to search
            case_sensitive: Match case
            regex: Use regular expressions
            whole_word: Match whole words only
        
        Returns:
            List of SearchResult objects
        """
    
    def search_strings(
        self,
        swf_path: Path,
        pattern: str
    ) -> list[StringMatch]:
        """Search string constants in SWF."""


class SearchResult:
    """Search result container."""
    
    file: Path          # Source file
    line: int           # Line number
    column: int         # Column number
    content: str        # Matching line content
    match: str          # Matched text
```

---

### `src.core.patches`

SWF patching system.

```python
from src.core.patches import PatchManager

class PatchManager:
    """SWF patch manager."""
    
    PATCHES: dict = {
        'server_url': {...},
        'version_check': {...},
        'debug_mode': {...},
        'remove_ads': {...}
    }
    
    def __init__(self, swf_path: Path) -> None:
        """Initialize with target SWF."""
    
    def apply_patch(
        self,
        patch_name: str,
        params: dict = None
    ) -> bool:
        """
        Apply named patch.
        
        Args:
            patch_name: Patch identifier
            params: Patch parameters
        
        Returns:
            Success status
        """
    
    def custom_patch(
        self,
        search: bytes,
        replace: bytes,
        backup: bool = True
    ) -> bool:
        """
        Apply custom binary patch.
        
        Args:
            search: Byte pattern to find
            replace: Replacement bytes
            backup: Create .bak file
        
        Returns:
            Success status
        """
    
    def revert(self, backup_path: Path = None) -> bool:
        """Revert to backup."""
```

---

## Evony Modules

### `src.evony.class_browser`

Evony class analysis.

```python
from src.evony.class_browser import ClassBrowser

class ClassBrowser:
    """Evony client class browser."""
    
    def __init__(self, script_dir: Path) -> None:
        """Initialize with decompiled scripts."""
    
    def get_packages(self) -> list[str]:
        """Get list of packages (com.evony.*, etc.)."""
    
    def get_classes(self, package: str) -> list[str]:
        """Get classes in package."""
    
    def get_class_info(self, full_name: str) -> ClassInfo:
        """
        Get detailed class information.
        
        Returns:
            ClassInfo with methods, properties, inheritance
        """
    
    def find_class(self, pattern: str) -> list[str]:
        """Search for class by name pattern."""
```

### `src.evony.protocol`

Evony network protocol.

```python
from src.evony.protocol import EvonyProtocol

class EvonyProtocol:
    """Evony protocol documentation and utilities."""
    
    COMMANDS: dict = {
        'login.login': {...},
        'city.build': {...},
        'army.attack': {...},
        # ...
    }
    
    @staticmethod
    def decode_packet(data: bytes) -> dict:
        """Decode AMF3 packet."""
    
    @staticmethod
    def encode_packet(cmd: str, params: dict) -> bytes:
        """Encode command as AMF3 packet."""
    
    @staticmethod
    def get_command_info(cmd: str) -> dict:
        """Get command documentation."""
```

### `src.evony.bot_scripts`

Bot script utilities.

```python
from src.evony.bot_scripts import ScriptManager

class ScriptManager:
    """Bot script management."""
    
    def __init__(self) -> None:
        """Initialize script manager."""
    
    def parse_script(self, content: str) -> list[Command]:
        """Parse AutoEvony script."""
    
    def validate_script(self, content: str) -> list[str]:
        """Validate script, return errors."""
    
    def get_commands(self) -> dict:
        """Get available commands with docs."""
```

---

## UI Modules

### `src.ui.dialogs`

Dialog windows.

```python
# Available dialogs
from src.ui.dialogs import (
    NewProjectDialog,
    OpenProjectDialog,
    SettingsDialog,
    AboutDialog,
    ExportDialog,
    SearchDialog
)
```

### `src.ui.panels`

Main UI panels.

```python
# Available panels
from src.ui.panels import (
    ProjectPanel,
    ScriptEditorPanel,
    SOLManagerPanel,
    AssetBrowserPanel,
    ConsolePanel,
    SearchPanel
)
```

---

## Event System

```python
from src.core.events import EventBus

# Subscribe to events
EventBus.on('project.loaded', handler)
EventBus.on('swf.analyzed', handler)
EventBus.on('sol.scanned', handler)

# Emit events
EventBus.emit('project.loaded', project)

# Available events
EVENTS = [
    'project.created',
    'project.loaded',
    'project.saved',
    'swf.loaded',
    'swf.analyzed',
    'sol.scanned',
    'sol.parsed',
    'search.complete',
    'export.complete',
    'borg.complete'
]
```

---

## Utility Functions

```python
from src.core.utils import (
    md5_hash,
    format_size,
    format_timestamp,
    ensure_dir,
    safe_filename
)

# MD5 hash
md5_hash("password")  # "5f4dcc3b..."

# Format file size
format_size(1048576)  # "1.00 MB"

# Format timestamp
format_timestamp(1704212400)  # "2024-01-02 14:00:00"

# Ensure directory exists
ensure_dir(Path("output/scripts"))

# Safe filename
safe_filename("file<>name")  # "file_name"
```

---

## Configuration Schema

```json
{
    "tools": {
        "ffdec_path": "string",
        "java_path": "string", 
        "flash_player_path": "string",
        "ruffle_path": "string"
    },
    "appearance": {
        "theme": "borg",
        "font_size": 12,
        "window_size": [1400, 900]
    },
    "sol": {
        "search_paths": ["string"],
        "auto_scan": true
    },
    "recent_projects": ["string"],
    "logging": {
        "level": "INFO",
        "to_file": true
    }
}
```

---

*Document Version: 1.0.0*
