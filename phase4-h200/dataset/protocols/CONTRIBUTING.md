# Contributing to Svony Studio

> **⬢ Join the Collective** - How to Contribute

Thank you for your interest in contributing to Svony Studio! This document provides guidelines for contributing.

---

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on the code, not the person
- Help newcomers feel welcome

---

## Ways to Contribute

### 🐛 Reporting Bugs

1. **Search existing issues** first to avoid duplicates
2. Create a new issue with:
   - Clear, descriptive title
   - Steps to reproduce
   - Expected vs actual behavior
   - System information
   - Screenshots/logs if applicable

### 💡 Suggesting Features

1. Check if the feature is already planned (see AUDIT_ROADMAP.md)
2. Create a feature request issue with:
   - Clear description of the feature
   - Use case / why it's needed
   - Possible implementation approach
   - Mockups if applicable

### 📖 Improving Documentation

- Fix typos and grammar
- Add missing information
- Create tutorials or guides
- Improve code comments
- Add examples

### 💻 Contributing Code

See the Development Setup section below.

---

## Development Setup

### Prerequisites

- Python 3.10+
- Git
- FFDec (for testing)
- VS Code or similar IDE

### Clone and Setup

```powershell
# Clone the repository
git clone https://github.com/Ghenghis/Svony-Studio.git
cd Svony-Studio

# Create virtual environment
python -m venv .venv
.\.venv\Scripts\Activate.ps1

# Install dependencies
pip install -r requirements.txt

# Install dev dependencies
pip install black ruff mypy pytest
```

### Project Structure

```
svony_studio/
├── main.py              # Main application (UI)
├── src/
│   ├── core/            # Core modules
│   │   ├── config.py    # Configuration
│   │   ├── project.py   # Project management
│   │   ├── sol_manager.py # SOL handling
│   │   └── swf_tools.py # SWF analysis
│   ├── ui/              # UI components (planned)
│   └── evony/           # Evony-specific (planned)
├── docs/                # Documentation
├── assets/              # App assets
└── tests/               # Tests (planned)
```

### Running the Application

```powershell
# Activate environment
.\.venv\Scripts\Activate.ps1

# Run directly
python main.py

# Or use the launcher
.\run.ps1
```

---

## Coding Standards

### Python Style

We follow PEP 8 with some modifications:

```python
# Good
def analyze_swf(self, swf_path: str) -> dict:
    """
    Analyze a SWF file and return metadata.
    
    Args:
        swf_path: Path to the SWF file
        
    Returns:
        Dictionary containing SWF metadata
    """
    pass

# Use type hints
def process_accounts(accounts: list[Account]) -> int:
    pass

# Constants in UPPER_CASE
MAX_RECENT_FILES = 10
DEFAULT_THEME = "borg"
```

### Code Formatting

```powershell
# Format with black
black main.py src/

# Check with ruff
ruff check main.py src/

# Type check with mypy
mypy main.py src/
```

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Classes | PascalCase | `SvonyProject` |
| Functions | snake_case | `load_swf_file()` |
| Constants | UPPER_SNAKE | `MAX_FILE_SIZE` |
| Private | _leading_underscore | `_internal_method()` |

### Comments

```python
# Single line for brief explanations
x = x + 1  # Increment counter

# Multi-line for complex logic
# This algorithm processes the SWF in two passes:
# First pass: Identify all tag types
# Second pass: Extract tag contents

def complex_function():
    """
    Docstring for public functions.
    
    Describe what it does, parameters, and return value.
    """
    pass
```

---

## Making Changes

### Branch Naming

```
feature/description    # New features
bugfix/issue-number   # Bug fixes
docs/description      # Documentation
refactor/description  # Code refactoring
```

### Commit Messages

Follow conventional commits:

```
feat: Add SOL editor dialog
fix: Resolve crash when loading large SWF
docs: Update installation instructions
refactor: Split UI components into modules
test: Add tests for sol_manager
```

### Pull Request Process

1. **Create a branch** from `main`
   ```powershell
   git checkout -b feature/my-feature
   ```

2. **Make your changes**
   - Follow coding standards
   - Add/update tests if applicable
   - Update documentation

3. **Test your changes**
   ```powershell
   # Run the app
   python main.py
   
   # Run tests (when available)
   pytest
   
   # Check formatting
   black --check .
   ruff check .
   ```

4. **Commit and push**
   ```powershell
   git add .
   git commit -m "feat: Add my feature"
   git push origin feature/my-feature
   ```

5. **Create Pull Request**
   - Clear description of changes
   - Reference related issues
   - Screenshots for UI changes

---

## Testing

### Current Status

Testing infrastructure is planned but not yet implemented.

### Test Guidelines (Future)

```python
# tests/test_sol_manager.py
import pytest
from src.core.sol_manager import SOLManager

def test_parse_sol_valid():
    """Test parsing a valid SOL file."""
    manager = SOLManager()
    result = manager.parse_sol("test_data/valid.sol")
    assert result is not None
    assert "username" in result

def test_parse_sol_invalid():
    """Test handling of invalid SOL file."""
    manager = SOLManager()
    with pytest.raises(ValueError):
        manager.parse_sol("test_data/invalid.sol")
```

---

## Documentation

### Writing Documentation

- Use clear, simple language
- Include code examples
- Add screenshots for UI features
- Keep formatting consistent

### Documentation Files

| File | Purpose |
|------|---------|
| README.md | Project overview |
| ARCHITECTURE.md | Technical design |
| USER_GUIDE.md | End-user manual |
| FAQ.md | Common questions |
| TROUBLESHOOTING.md | Problem solutions |
| CHANGELOG.md | Version history |

### Diagrams

SVG diagrams are in `docs/diagrams/`. To create new diagrams:
- Use consistent styling (Borg theme colors)
- Include legends and labels
- Keep file sizes reasonable

---

## Priority Areas

### High Priority
- Implementing placeholder methods
- Settings dialog
- Search functionality
- Unit tests

### Medium Priority
- Asset browser improvements
- Script syntax highlighting
- SOL editor

### Lower Priority (Future)
- Plugin system
- Multi-language support
- Advanced protocol analyzer

See [AUDIT_ROADMAP.md](AUDIT_ROADMAP.md) for detailed roadmap.

---

## Recognition

Contributors will be recognized in:
- CHANGELOG.md
- README.md Contributors section
- GitHub Contributors page

---

## Questions?

- Create a GitHub issue for questions
- Tag with "question" label
- Check existing issues and FAQ first

---

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

*"Your contributions will be assimilated. Resistance is futile... but very welcome!"*
