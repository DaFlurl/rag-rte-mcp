# Svony Studio - Developer Guide

> **"Extending the Collective"** - Guide for Contributors and Developers

---

## Development Setup

### Prerequisites

- Python 3.10+
- Git
- Java 8+ (for FFDec)
- FFDec (JPEXS Flash Decompiler)

### Clone and Install

```powershell
# Clone repository
git clone https://github.com/Ghenghis/Svony-Studio.git
cd Svony-Studio

# Create virtual environment
python -m venv .venv
.\.venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Install development dependencies
pip install -r requirements-dev.txt
```

### Development Dependencies

```
# requirements-dev.txt
pytest>=7.0.0
pytest-cov>=4.0.0
black>=23.0.0
ruff>=0.1.0
mypy>=1.0.0
pre-commit>=3.0.0
```

---

## Project Structure

```
svony_studio/
├── main.py                 # Application entry point
├── src/
│   ├── __init__.py
│   ├── core/              # Core business logic
│   │   ├── config.py      # Configuration management
│   │   ├── project.py     # Project file handling
│   │   ├── sol_manager.py # SOL file operations
│   │   ├── swf_tools.py   # FFDec/SWFTools wrappers
│   │   ├── search.py      # Code search engine
│   │   └── patches.py     # SWF patching system
│   ├── ui/                # User interface components
│   │   ├── dialogs/       # Modal dialogs
│   │   ├── panels/        # Main panels
│   │   └── widgets/       # Reusable widgets
│   └── evony/             # Evony-specific modules
│       ├── class_browser.py
│       ├── protocol.py
│       └── bot_scripts.py
├── docs/                   # Documentation
│   ├── diagrams/          # SVG diagrams
│   ├── evony/             # Evony-specific docs
│   └── formats/           # File format specs
├── tests/                  # Test suite
├── assets/                 # Application assets
└── scripts/               # Build/utility scripts
```

---

## Core Modules

### `config.py` - Configuration Manager

```python
class Config:
    """Application configuration management."""
    
    CONFIG_DIR = Path(os.getenv('APPDATA')) / 'SvonyStudio'
    CONFIG_FILE = CONFIG_DIR / 'config.json'
    
    def __init__(self):
        self.data = self._load()
    
    def get(self, key: str, default=None) -> Any:
        """Get configuration value."""
        return self.data.get(key, default)
    
    def set(self, key: str, value: Any) -> None:
        """Set configuration value."""
        self.data[key] = value
        self._save()
```

### `swf_tools.py` - SWF Analysis

```python
class FFDecWrapper:
    """Wrapper for FFDec CLI."""
    
    def __init__(self, ffdec_path: str):
        self.ffdec_path = Path(ffdec_path)
        self._validate()
    
    def export_scripts(self, swf_path: str, output_dir: str) -> bool:
        """Export ActionScript from SWF."""
        cmd = [
            str(self.ffdec_path),
            '-export', 'script',
            output_dir,
            swf_path
        ]
        result = subprocess.run(cmd, capture_output=True)
        return result.returncode == 0
    
    def get_swf_info(self, swf_path: str) -> dict:
        """Get SWF metadata."""
        # Implementation...
```

### `sol_manager.py` - SOL Operations

```python
class SOLManager:
    """Flash SharedObject management."""
    
    EVONY_PATTERNS = ['evony.com', 'cevony', 'localhost']
    
    def scan_directories(self) -> list[Path]:
        """Find all Evony SOL files."""
        base = Path(os.getenv('APPDATA')) / 'Macromedia'
        sols = []
        for pattern in self.EVONY_PATTERNS:
            sols.extend(base.rglob(f'*{pattern}*.sol'))
        return sols
    
    def parse_sol(self, path: Path) -> dict:
        """Parse SOL file contents."""
        import py3amf.sol
        with open(path, 'rb') as f:
            return py3amf.sol.decode(f)
```

---

## UI Development

### CustomTkinter Basics

```python
import customtkinter as ctk

class MyPanel(ctk.CTkFrame):
    """Custom panel example."""
    
    def __init__(self, parent, **kwargs):
        super().__init__(parent, **kwargs)
        self._setup_ui()
    
    def _setup_ui(self):
        # Title
        self.title = ctk.CTkLabel(
            self,
            text="Panel Title",
            font=("Consolas", 14, "bold"),
            text_color="#00ff00"
        )
        self.title.pack(pady=10)
        
        # Content
        self.content = ctk.CTkFrame(self, fg_color="#1a1a1a")
        self.content.pack(fill="both", expand=True, padx=10, pady=10)
```

### Adding New Panels

1. Create panel class in `src/ui/panels/`
2. Import in `main.py`
3. Add to tab view or panel container
4. Connect event handlers

```python
# src/ui/panels/my_panel.py
class MyPanel(ctk.CTkFrame):
    def __init__(self, parent, app):
        super().__init__(parent)
        self.app = app  # Reference to main app
        self._setup_ui()
```

### Theme Colors

```python
BORG_THEME = {
    "bg_dark": "#0a0a0a",
    "bg_medium": "#1a1a1a",
    "bg_light": "#2a2a2a",
    "accent_green": "#00ff00",
    "accent_cyan": "#00ffff",
    "accent_orange": "#ff6600",
    "text_primary": "#e0e0e0",
    "text_secondary": "#808080",
    "text_disabled": "#606060",
}
```

---

## Adding Features

### 1. New Menu Command

```python
# In main.py _create_menus()
tools_menu.add_command(
    label="My Feature",
    command=self._my_feature,
    accelerator="Ctrl+M"
)

# Add keyboard binding
self.bind("<Control-m>", lambda e: self._my_feature())

# Implement handler
def _my_feature(self):
    """Handle my feature."""
    self._log("Executing my feature...")
    # Implementation
```

### 2. New Dialog

```python
# src/ui/dialogs/my_dialog.py
class MyDialog(ctk.CTkToplevel):
    def __init__(self, parent, title="My Dialog"):
        super().__init__(parent)
        self.title(title)
        self.geometry("400x300")
        self.transient(parent)
        self.grab_set()
        
        self._setup_ui()
        self.result = None
    
    def _setup_ui(self):
        # Dialog content...
        
        # Buttons
        btn_frame = ctk.CTkFrame(self)
        btn_frame.pack(fill="x", pady=10)
        
        ctk.CTkButton(
            btn_frame, text="OK",
            command=self._on_ok
        ).pack(side="left", padx=5)
        
        ctk.CTkButton(
            btn_frame, text="Cancel",
            command=self.destroy
        ).pack(side="right", padx=5)
    
    def _on_ok(self):
        self.result = "ok"
        self.destroy()
```

### 3. New Core Module

```python
# src/core/my_module.py
"""My new module for X functionality."""

from typing import Optional
from pathlib import Path
import logging

logger = logging.getLogger(__name__)


class MyModule:
    """Description of module purpose."""
    
    def __init__(self, config: dict):
        self.config = config
        self._initialized = False
    
    def initialize(self) -> bool:
        """Initialize the module."""
        try:
            # Setup...
            self._initialized = True
            logger.info("MyModule initialized")
            return True
        except Exception as e:
            logger.error(f"Failed to initialize: {e}")
            return False
    
    def process(self, input_data: dict) -> Optional[dict]:
        """Process input and return results."""
        if not self._initialized:
            raise RuntimeError("Module not initialized")
        
        # Processing...
        return {"status": "success"}
```

---

## Testing

### Running Tests

```bash
# Run all tests
pytest

# With coverage
pytest --cov=src --cov-report=html

# Specific test file
pytest tests/test_sol_manager.py -v
```

### Writing Tests

```python
# tests/test_sol_manager.py
import pytest
from src.core.sol_manager import SOLManager


class TestSOLManager:
    @pytest.fixture
    def manager(self):
        return SOLManager()
    
    def test_scan_directories(self, manager):
        """Test SOL directory scanning."""
        sols = manager.scan_directories()
        assert isinstance(sols, list)
    
    def test_parse_sol(self, manager, tmp_path):
        """Test SOL file parsing."""
        # Create test SOL file...
        sol_path = tmp_path / "test.sol"
        # ...
        
        data = manager.parse_sol(sol_path)
        assert 'username' in data
```

---

## Code Style

### Formatting

```bash
# Format with black
black src/ tests/

# Lint with ruff
ruff check src/ tests/

# Type check with mypy
mypy src/
```

### Style Guide

- Use type hints for all functions
- Docstrings for all public methods
- Private methods prefixed with `_`
- Constants in UPPER_CASE
- Classes in PascalCase
- Functions/variables in snake_case

---

## Building

### Windows Executable

```powershell
# Install PyInstaller
pip install pyinstaller

# Build
pyinstaller --name "Svony Studio" `
    --onefile `
    --windowed `
    --icon=assets/icon.ico `
    main.py
```

### Creating Release

```powershell
# scripts/build.ps1
$version = "1.0.0"

# Clean
Remove-Item -Recurse -Force dist, build -ErrorAction SilentlyContinue

# Build
pyinstaller svony_studio.spec

# Package
Compress-Archive -Path "dist/*" -DestinationPath "svony_studio_v$version.zip"
```

---

## Documentation

### Generating Docs

```bash
# Build documentation (if using Sphinx)
cd docs
sphinx-build -b html . _build/html
```

### Diagram Guidelines

- Use SVG format for diagrams
- Borg theme colors
- Include in `docs/diagrams/`
- Reference in markdown files

---

## Contributing Workflow

1. Fork repository
2. Create feature branch: `git checkout -b feature/my-feature`
3. Make changes
4. Run tests: `pytest`
5. Format code: `black .`
6. Commit: `git commit -m "Add my feature"`
7. Push: `git push origin feature/my-feature`
8. Create Pull Request

---

*Document Version: 1.0.0 | See CONTRIBUTING.md for more details*
