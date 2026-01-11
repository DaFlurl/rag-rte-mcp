# Svony Studio - Plugin Development Guide

> **"Extending Svony Studio"** - Creating Custom Plugins and Extensions

---

## Overview

Svony Studio supports a plugin architecture allowing developers to extend functionality with custom analyzers, exporters, UI panels, and more.

---

## Plugin Architecture

### Plugin Types

| Type | Purpose | Example |
|------|---------|---------|
| **Analyzer** | Custom SWF analysis | Protocol mapper |
| **Exporter** | New export formats | Excel exporter |
| **Importer** | New import formats | JSON importer |
| **Panel** | UI extensions | Custom dashboard |
| **Tool** | Standalone tools | Batch processor |
| **Theme** | UI customization | Dark theme variant |

### Plugin Structure

```
my_plugin/
├── plugin.json          # Plugin manifest
├── __init__.py          # Entry point
├── main.py              # Main logic
├── ui/                  # UI components (optional)
│   └── panel.py
├── resources/           # Assets (optional)
│   └── icon.png
├── tests/               # Tests (optional)
│   └── test_plugin.py
└── README.md           # Documentation
```

---

## Plugin Manifest

### plugin.json

```json
{
    "name": "my-awesome-plugin",
    "display_name": "My Awesome Plugin",
    "version": "1.0.0",
    "description": "Does awesome things with SWF files",
    "author": "Your Name",
    "email": "you@example.com",
    "homepage": "https://github.com/you/my-plugin",
    
    "type": "analyzer",
    "entry_point": "main:MyPlugin",
    
    "svony_version": ">=1.0.0",
    "python_version": ">=3.11",
    
    "dependencies": [
        "pandas>=2.0.0",
        "openpyxl>=3.0.0"
    ],
    
    "permissions": [
        "file_read",
        "file_write",
        "network"
    ],
    
    "menu": {
        "path": "Tools/My Plugin",
        "shortcut": "Ctrl+Shift+M"
    },
    
    "settings": {
        "output_format": {
            "type": "choice",
            "options": ["json", "csv", "excel"],
            "default": "json"
        },
        "include_metadata": {
            "type": "boolean",
            "default": true
        }
    }
}
```

---

## Creating Your First Plugin

### Step 1: Setup

```bash
# Create plugin directory
mkdir my_plugin
cd my_plugin

# Create basic structure
touch plugin.json __init__.py main.py README.md
```

### Step 2: Plugin Manifest

```json
{
    "name": "string-finder",
    "display_name": "String Finder",
    "version": "1.0.0",
    "description": "Find and export all strings from SWF",
    "type": "analyzer",
    "entry_point": "main:StringFinderPlugin"
}
```

### Step 3: Implementation

```python
# main.py
from svony.plugin import PluginBase, register_plugin
from svony.core.swf import SWFFile

@register_plugin
class StringFinderPlugin(PluginBase):
    """Find and export strings from SWF files."""
    
    def __init__(self, context):
        super().__init__(context)
        self.name = "String Finder"
    
    def activate(self):
        """Called when plugin is loaded."""
        self.log.info("String Finder activated")
        
        # Register menu item
        self.register_menu("Tools/String Finder", self.run)
        
        # Register context menu
        self.register_context_menu(
            "swf_file",
            "Find Strings",
            self.run
        )
    
    def deactivate(self):
        """Called when plugin is unloaded."""
        self.log.info("String Finder deactivated")
    
    def run(self, swf_path=None):
        """Main plugin functionality."""
        # Get current file if not specified
        if swf_path is None:
            swf_path = self.context.current_file
        
        if not swf_path:
            self.show_error("No SWF file open")
            return
        
        # Load SWF
        swf = SWFFile(swf_path)
        
        # Extract strings
        strings = self.extract_strings(swf)
        
        # Show results
        self.show_results(strings)
    
    def extract_strings(self, swf):
        """Extract all strings from SWF."""
        strings = []
        
        for tag in swf.tags:
            if hasattr(tag, 'strings'):
                strings.extend(tag.strings)
        
        # Deduplicate and sort
        strings = sorted(set(strings))
        
        return strings
    
    def show_results(self, strings):
        """Display results to user."""
        # Create result panel
        panel = self.create_panel("String Results")
        
        # Add list view
        list_view = panel.add_list(strings)
        
        # Add export button
        panel.add_button("Export", lambda: self.export(strings))
        
        panel.show()
    
    def export(self, strings):
        """Export strings to file."""
        output_path = self.show_save_dialog(
            "Export Strings",
            filters=[("Text Files", "*.txt"), ("JSON", "*.json")]
        )
        
        if output_path:
            if output_path.endswith('.json'):
                import json
                with open(output_path, 'w') as f:
                    json.dump(strings, f, indent=2)
            else:
                with open(output_path, 'w') as f:
                    f.write('\n'.join(strings))
            
            self.show_info(f"Exported {len(strings)} strings")
```

### Step 4: Install Plugin

```bash
# Copy to plugins directory
cp -r my_plugin ~/.svony_studio/plugins/

# Or install via CLI
python main.py plugin install ./my_plugin
```

---

## Plugin API Reference

### PluginBase Class

```python
class PluginBase:
    """Base class for all plugins."""
    
    # Properties
    context: PluginContext    # Access to Svony Studio
    log: Logger               # Plugin logger
    settings: dict            # Plugin settings
    
    # Lifecycle Methods
    def activate(self): ...     # Called on load
    def deactivate(self): ...   # Called on unload
    
    # Registration Methods
    def register_menu(self, path, callback): ...
    def register_context_menu(self, target, label, callback): ...
    def register_shortcut(self, shortcut, callback): ...
    def register_file_handler(self, extension, handler): ...
    
    # UI Methods
    def create_panel(self, title) -> Panel: ...
    def show_dialog(self, title, content) -> bool: ...
    def show_info(self, message): ...
    def show_warning(self, message): ...
    def show_error(self, message): ...
    def show_save_dialog(self, title, filters) -> str: ...
    def show_open_dialog(self, title, filters) -> str: ...
    
    # Data Access
    def get_current_swf(self) -> SWFFile: ...
    def get_current_selection(self) -> Any: ...
    def get_project(self) -> Project: ...
```

### PluginContext Class

```python
class PluginContext:
    """Context provided to plugins."""
    
    # Current State
    current_file: str          # Current open file
    current_project: Project   # Current project
    selection: Any             # Current selection
    
    # Services
    ffdec: FFDecIntegration    # FFDec access
    sol_manager: SOLManager    # SOL file access
    protocol: ProtocolAnalyzer # Protocol tools
    
    # Events
    def on(self, event, callback): ...
    def emit(self, event, data): ...
```

### Events

| Event | Data | Description |
|-------|------|-------------|
| `file.open` | `{path}` | File opened |
| `file.close` | `{path}` | File closed |
| `file.save` | `{path}` | File saved |
| `project.open` | `{project}` | Project opened |
| `selection.change` | `{item}` | Selection changed |
| `decompile.start` | `{path}` | Decompilation started |
| `decompile.complete` | `{path, result}` | Decompilation finished |

---

## UI Components

### Creating Panels

```python
def create_custom_panel(self):
    panel = self.create_panel("My Panel")
    
    # Add widgets
    panel.add_label("Welcome to My Plugin")
    
    input_field = panel.add_input("Enter value:")
    
    panel.add_button("Process", lambda: self.process(input_field.value))
    
    # Add table
    table = panel.add_table(columns=["Name", "Value", "Type"])
    table.add_row(["gold", "50000", "int"])
    table.add_row(["food", "75000", "int"])
    
    # Add tree view
    tree = panel.add_tree()
    root = tree.add_node("Root")
    root.add_child("Child 1")
    root.add_child("Child 2")
    
    return panel
```

### Dialog Windows

```python
def show_settings_dialog(self):
    dialog = self.create_dialog("Settings")
    
    dialog.add_checkbox("Enable feature", self.settings.get("enabled", True))
    dialog.add_dropdown("Format", ["json", "csv", "xml"], "json")
    dialog.add_number("Limit", 100, min=1, max=1000)
    
    if dialog.show():
        # User clicked OK
        self.settings["enabled"] = dialog.get("Enable feature")
        self.settings["format"] = dialog.get("Format")
        self.settings["limit"] = dialog.get("Limit")
        self.save_settings()
```

---

## Working with SWF Data

### Accessing Tags

```python
def analyze_swf(self, swf):
    # Iterate all tags
    for tag in swf.tags:
        print(f"Tag: {tag.tag_type} - {tag.name}")
    
    # Find specific tags
    doabc_tags = swf.find_tags("DoABC")
    for tag in doabc_tags:
        print(f"ABC: {tag.name}, {len(tag.data)} bytes")
    
    # Access by type
    images = swf.get_images()
    sounds = swf.get_sounds()
    scripts = swf.get_scripts()
```

### Modifying Content

```python
def modify_swf(self, swf):
    # Find and modify string
    for tag in swf.find_tags("DefineText"):
        if "server.evony.com" in tag.text:
            tag.text = tag.text.replace(
                "server.evony.com",
                "localhost"
            )
    
    # Save modified SWF
    swf.save("modified.swf")
```

---

## Analyzer Plugins

### Custom Analyzer

```python
@register_plugin
class ProtocolMapperPlugin(PluginBase):
    """Map Evony protocol commands."""
    
    def run(self):
        swf = self.get_current_swf()
        
        # Find command classes
        commands = []
        for script in swf.get_scripts():
            if self.is_command_class(script):
                cmd = self.parse_command(script)
                commands.append(cmd)
        
        # Generate documentation
        self.generate_docs(commands)
    
    def is_command_class(self, script):
        return "Command" in script.name or "Handler" in script.name
    
    def parse_command(self, script):
        return {
            "name": script.name,
            "id": self.find_command_id(script),
            "params": self.find_params(script),
        }
```

---

## Exporter Plugins

### Custom Exporter

```python
@register_plugin
class ExcelExporterPlugin(PluginBase):
    """Export analysis to Excel."""
    
    def activate(self):
        self.register_exporter("excel", self.export_excel)
    
    def export_excel(self, data, output_path):
        import pandas as pd
        
        # Convert to DataFrame
        df = pd.DataFrame(data)
        
        # Write Excel
        with pd.ExcelWriter(output_path) as writer:
            df.to_excel(writer, sheet_name="Data", index=False)
            
            # Add summary sheet
            summary = self.create_summary(df)
            summary.to_excel(writer, sheet_name="Summary")
        
        return True
```

---

## Testing Plugins

### Unit Tests

```python
# tests/test_plugin.py
import pytest
from my_plugin.main import StringFinderPlugin

class TestStringFinderPlugin:
    @pytest.fixture
    def plugin(self, mock_context):
        return StringFinderPlugin(mock_context)
    
    def test_extract_strings(self, plugin, sample_swf):
        strings = plugin.extract_strings(sample_swf)
        
        assert len(strings) > 0
        assert "Evony" in strings
    
    def test_export_json(self, plugin, tmp_path):
        strings = ["test1", "test2"]
        output = tmp_path / "strings.json"
        
        plugin.export(strings, str(output))
        
        assert output.exists()
```

### Running Tests

```bash
pytest my_plugin/tests/ -v
```

---

## Publishing Plugins

### Package Plugin

```bash
# Create distribution
cd my_plugin
zip -r my_plugin_v1.0.0.zip .
```

### Plugin Registry

```yaml
# Submit to registry
# https://svony-studio.github.io/plugins/

name: string-finder
version: 1.0.0
download: https://github.com/you/string-finder/releases/v1.0.0
checksum: sha256:abc123...
```

---

## Best Practices

1. **Follow naming conventions** - Use lowercase, hyphens
2. **Include documentation** - README.md for users
3. **Handle errors gracefully** - Don't crash the host
4. **Request minimal permissions** - Only what's needed
5. **Test thoroughly** - Unit and integration tests
6. **Version properly** - Semantic versioning

---

## Related Documentation

- `API_REFERENCE.md` - Full API documentation
- `DEVELOPER_GUIDE.md` - Development setup
- `EXTENDING.md` - Extension points
- `TESTING_STRATEGY.md` - Testing guidelines

---

*Document Version: 1.0.0 | Plugin Development Guide*
