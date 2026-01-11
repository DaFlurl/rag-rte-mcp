# ⬢ Extending Svony Doc Viewer

> **Guide for Adding New Documentation and Diagrams**

This guide explains how to add, modify, and extend the documentation content in Svony Doc Viewer.

---

## 📁 Content Structure

```
content/
├── docs/                    # Markdown documents
│   ├── *.md                 # Top-level docs
│   ├── evony/               # Evony-specific docs
│   │   └── *.md
│   └── formats/             # Format specifications
│       └── *.md
└── diagrams/                # SVG diagram files
    └── *.svg
```

---

## 📄 Adding a New Document

### Step 1: Create the Markdown File

Create your `.md` file in the appropriate location:

```
content/docs/YOUR_DOC.md           # General doc
content/docs/evony/YOUR_DOC.md     # Evony-specific
content/docs/formats/YOUR_DOC.md   # Format spec
```

### Step 2: Register in Content Mapping

Edit `src/main.py` and add to `CONTENT_MAPPING`:

```python
CONTENT_MAPPING = {
    # ... existing entries ...
    
    "YOUR_DOC.md": {
        "title": "Your Document Title",
        "category": "Technical",  # Choose: Getting Started, Technical, Evony, Formats, Reference
        "diagrams": ["related_diagram.svg", "another_diagram.svg"],
        "description": "Brief description of this document",
        "order": 50,  # Controls sort order within category (lower = earlier)
    },
    
    # For subdirectory docs:
    "evony/YOUR_DOC.md": {
        "title": "Evony Feature",
        "category": "Evony",
        "diagrams": ["evony_related.svg"],
        "description": "Description",
        "order": 15,
    },
}
```

### Category Options

| Category | Description | Order Range |
|----------|-------------|-------------|
| Getting Started | Tutorials, quick starts | 1-9 |
| Technical | Architecture, APIs | 10-19 |
| Evony | Game-specific docs | 20-29 |
| Formats | File format specs | 30-39 |
| Reference | FAQ, troubleshooting | 40-50 |

---

## 📊 Adding a New Diagram

### Step 1: Create the SVG File

Place your `.svg` file in:

```
content/diagrams/your_diagram.svg
```

**SVG Guidelines:**
- Use viewBox for responsive scaling
- Match the Borg theme colors:
  - Background: `#0a0a0a`, `#1a1a1a`, `#2a2a2a`
  - Primary: `#00ff00`
  - Secondary: `#00ffff`
  - Tertiary: `#ff6600`
  - Text: `#e0e0e0`, `#808080`
- Include title text in SVG

### Step 2: Register in Diagram Info

Edit `src/main.py` and add to `DIAGRAM_INFO`:

```python
DIAGRAM_INFO = {
    # ... existing entries ...
    
    "your_diagram.svg": {
        "title": "Your Diagram Title",
        "category": "Features",  # Choose: Interface, Panels, System, Features, Evony, Bots, Formats, Tools
    },
}
```

### Step 3: Link to Documents

Add the diagram to related documents in `CONTENT_MAPPING`:

```python
"RELATED_DOC.md": {
    "title": "Related Document",
    "diagrams": ["existing.svg", "your_diagram.svg"],  # Add here
    # ...
},
```

---

## 🎨 Adding a New Theme

Edit `src/main.py` and add to `THEMES`:

```python
THEMES = {
    # ... existing themes ...
    
    "your_theme": {
        "name": "Your Theme Name",
        "bg_dark": "#0a0a0a",      # Darkest background
        "bg_medium": "#1a1a1a",    # Medium background
        "bg_light": "#2a2a2a",     # Light background
        "accent_primary": "#00ff00",    # Main accent (buttons, highlights)
        "accent_secondary": "#00ffff",  # Secondary accent
        "accent_tertiary": "#ff6600",   # Tertiary accent (warnings)
        "text_primary": "#e0e0e0",      # Main text
        "text_secondary": "#808080",    # Secondary text
        "text_muted": "#606060",        # Muted/disabled text
        "border": "#333333",            # Border color
        "highlight": "#00ff0033",       # Selection highlight (with alpha)
        "error": "#ff0000",             # Error color
        "success": "#00ff00",           # Success color
        "warning": "#ff6600",           # Warning color
    },
}
```

---

## 📂 Creating New Categories

### Document Categories

1. Add category to `CONTENT_MAPPING` entries
2. Update `cat_order` list in `load_content_index()`:

```python
cat_order = ["Getting Started", "Technical", "Evony", "Formats", "Reference", "Your Category"]
```

### Diagram Categories

1. Add category to `DIAGRAM_INFO` entries
2. Categories are automatically grouped in navigation

---

## 🔄 Batch Import

For bulk content import, create a JSON file and load it:

### content_import.json

```json
{
    "documents": [
        {
            "file": "new_doc.md",
            "title": "New Document",
            "category": "Technical",
            "diagrams": ["related.svg"],
            "description": "Description",
            "order": 25
        }
    ],
    "diagrams": [
        {
            "file": "new_diagram.svg",
            "title": "New Diagram",
            "category": "Features"
        }
    ]
}
```

Then update mappings programmatically.

---

## ✅ Content Checklist

When adding new content, ensure:

- [ ] File is in correct directory
- [ ] Entry added to `CONTENT_MAPPING` (docs) or `DIAGRAM_INFO` (diagrams)
- [ ] Related diagrams linked in document entry
- [ ] Category and order are appropriate
- [ ] Description is clear and concise
- [ ] SVG follows theme color guidelines
- [ ] Test navigation and display

---

## 🔍 Troubleshooting

### Document Not Showing

1. Check file exists in `content/docs/`
2. Verify entry in `CONTENT_MAPPING`
3. Check file path matches exactly

### Diagram Not Loading

1. Check file exists in `content/diagrams/`
2. Verify entry in `DIAGRAM_INFO`
3. Ensure SVG is valid
4. Install `cairosvg` for PNG conversion

### Theme Not Applying

1. Verify all color keys are present
2. Use valid hex colors
3. Restart application

---

## 📚 Examples

### Minimal Document

```python
"simple.md": {
    "title": "Simple Doc",
    "category": "Reference",
    "diagrams": [],
    "description": "A simple document",
    "order": 99,
},
```

### Full Featured Document

```python
"complex.md": {
    "title": "Complex Feature Guide",
    "category": "Technical",
    "diagrams": [
        "architecture.svg",
        "data_flow.svg",
        "class_hierarchy.svg"
    ],
    "description": "Comprehensive guide to complex features with multiple related diagrams",
    "order": 5,
},
```

---

*For questions, refer to the main README.md or check the source code in src/main.py*
