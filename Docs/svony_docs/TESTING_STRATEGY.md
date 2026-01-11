# Svony Studio - Testing Strategy

> **"Quality Assurance"** - Testing Approach and Guidelines

---

## Overview

This document outlines the testing strategy for Svony Studio, including unit tests, integration tests, and end-to-end testing approaches.

---

## Testing Philosophy

### Principles

1. **Test behavior, not implementation** - Tests should verify outcomes
2. **Fast feedback** - Unit tests should run in seconds
3. **Reliable tests** - No flaky tests allowed
4. **Meaningful coverage** - Quality over quantity
5. **Documentation** - Tests document expected behavior

### Coverage Goals

| Component | Target | Current |
|-----------|--------|---------|
| Core modules | 85% | TBD |
| Evony modules | 75% | TBD |
| UI components | 50% | TBD |
| Integration | 80% | TBD |
| **Overall** | **75%** | TBD |

---

## Test Types

### Unit Tests

Test individual functions and classes in isolation.

```python
# tests/unit/test_amf_decoder.py
import pytest
from svony.core.amf import AMFDecoder

class TestAMFDecoder:
    def test_decode_integer(self):
        """Test decoding AMF3 integer."""
        decoder = AMFDecoder()
        data = bytes([0x04, 0x10])  # Integer marker + value
        
        result = decoder.decode(data)
        
        assert result == 16
    
    def test_decode_string(self):
        """Test decoding AMF3 string."""
        decoder = AMFDecoder()
        data = bytes([0x06, 0x0B, 0x68, 0x65, 0x6C, 0x6C, 0x6F])
        
        result = decoder.decode(data)
        
        assert result == "hello"
    
    def test_decode_invalid_marker(self):
        """Test error handling for invalid marker."""
        decoder = AMFDecoder()
        data = bytes([0xFF])  # Invalid marker
        
        with pytest.raises(ValueError):
            decoder.decode(data)
```

### Integration Tests

Test components working together.

```python
# tests/integration/test_ffdec_integration.py
import pytest
from svony.core.ffdec_extended import FFDecIntegration
from pathlib import Path

class TestFFDecIntegration:
    @pytest.fixture
    def ffdec(self):
        return FFDecIntegration()
    
    @pytest.fixture
    def sample_swf(self, tmp_path):
        """Create minimal test SWF."""
        swf_path = tmp_path / "test.swf"
        # Write minimal valid SWF
        swf_path.write_bytes(b'CWS\x00...')
        return swf_path
    
    def test_decompile_scripts(self, ffdec, sample_swf, tmp_path):
        """Test script decompilation pipeline."""
        output_dir = tmp_path / "output"
        
        result = ffdec.export_scripts(sample_swf, output_dir)
        
        assert result.success
        assert output_dir.exists()
        assert len(list(output_dir.glob("*.as"))) > 0
    
    def test_export_assets(self, ffdec, sample_swf, tmp_path):
        """Test asset export pipeline."""
        output_dir = tmp_path / "assets"
        
        result = ffdec.export_assets(sample_swf, output_dir, ["images"])
        
        assert result.success
```

### End-to-End Tests

Test complete workflows.

```python
# tests/e2e/test_workflows.py
import pytest
from svony.main import Application

class TestWorkflows:
    @pytest.fixture
    def app(self):
        app = Application(headless=True)
        yield app
        app.cleanup()
    
    def test_open_and_decompile_swf(self, app, evony_test_swf):
        """Test complete decompilation workflow."""
        # Open SWF
        app.open_file(evony_test_swf)
        assert app.current_project is not None
        
        # Decompile
        result = app.decompile_all()
        assert result.success
        
        # Verify scripts extracted
        scripts = app.get_script_list()
        assert len(scripts) > 0
        assert any("com.evony" in s for s in scripts)
    
    def test_sol_extraction_workflow(self, app, sample_sol):
        """Test SOL extraction and editing."""
        # Load SOL
        app.open_sol(sample_sol)
        
        # Read data
        data = app.get_sol_data()
        assert "username" in data
        
        # Modify
        app.set_sol_value("username", "test_user")
        
        # Verify
        new_data = app.get_sol_data()
        assert new_data["username"] == "test_user"
```

---

## Test Fixtures

### Sample Files

```python
# tests/conftest.py
import pytest
from pathlib import Path

@pytest.fixture(scope="session")
def test_data_dir():
    """Path to test data directory."""
    return Path(__file__).parent / "test_data"

@pytest.fixture(scope="session")
def sample_swf(test_data_dir):
    """Sample SWF for testing."""
    path = test_data_dir / "sample.swf"
    if not path.exists():
        pytest.skip("Sample SWF not available")
    return path

@pytest.fixture(scope="session")
def sample_sol(test_data_dir):
    """Sample SOL for testing."""
    path = test_data_dir / "sample.sol"
    if not path.exists():
        pytest.skip("Sample SOL not available")
    return path

@pytest.fixture
def temp_project(tmp_path):
    """Create temporary project directory."""
    project_dir = tmp_path / "test_project"
    project_dir.mkdir()
    
    # Create standard structure
    (project_dir / "src").mkdir()
    (project_dir / "output").mkdir()
    (project_dir / "config").mkdir()
    
    return project_dir
```

### Mock Objects

```python
# tests/mocks/mock_ffdec.py
from unittest.mock import MagicMock

class MockFFDec:
    """Mock FFDec for testing without Java."""
    
    def __init__(self):
        self.calls = []
    
    def export_scripts(self, swf_path, output_dir):
        self.calls.append(("export_scripts", swf_path, output_dir))
        return MagicMock(success=True, scripts=["Main.as"])
    
    def deobfuscate(self, swf_path, level):
        self.calls.append(("deobfuscate", swf_path, level))
        return MagicMock(success=True)

@pytest.fixture
def mock_ffdec(monkeypatch):
    """Provide mock FFDec."""
    mock = MockFFDec()
    monkeypatch.setattr("svony.core.ffdec_extended.FFDec", mock)
    return mock
```

---

## Running Tests

### Quick Start

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=svony --cov-report=html

# Run specific test file
pytest tests/unit/test_amf_decoder.py

# Run specific test
pytest tests/unit/test_amf_decoder.py::TestAMFDecoder::test_decode_integer

# Run with verbose output
pytest -v

# Run only fast tests
pytest -m "not slow"
```

### Test Categories

```python
# Mark slow tests
@pytest.mark.slow
def test_large_file_processing():
    ...

# Mark integration tests
@pytest.mark.integration
def test_ffdec_integration():
    ...

# Mark tests requiring external resources
@pytest.mark.external
def test_download_from_server():
    ...
```

### Configuration

```ini
# pytest.ini
[pytest]
testpaths = tests
python_files = test_*.py
python_classes = Test*
python_functions = test_*

markers =
    slow: marks tests as slow
    integration: marks tests as integration tests
    external: marks tests requiring external resources

addopts = 
    --strict-markers
    -ra
    --tb=short
```

---

## Test Data Management

### Sensitive Data

```python
# Never commit real credentials
# tests/test_data/README.md
"""
Test Data Directory

This directory contains test fixtures. 
DO NOT commit:
- Real SOL files with credentials
- Actual game client SWFs
- Personal data

Use anonymized/synthetic data only.
"""
```

### Generating Test Data

```python
# tests/generators/generate_test_swf.py
def create_minimal_swf(output_path):
    """Create minimal valid SWF for testing."""
    # SWF header
    header = b'FWS'  # Uncompressed
    header += b'\x09'  # Version 9
    header += b'\x00\x00\x00\x17'  # File length
    
    # Minimal rect and frame data
    body = b'\x00'  # Empty rect
    body += b'\x00\x00'  # Frame rate
    body += b'\x01\x00'  # Frame count
    
    # End tag
    body += b'\x00\x00'
    
    with open(output_path, 'wb') as f:
        f.write(header + body)
```

---

## Continuous Integration

### GitHub Actions

```yaml
# .github/workflows/test.yml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest]
        python-version: ['3.11', '3.12']
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}
      
      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          pip install -r requirements-dev.txt
      
      - name: Run tests
        run: pytest --cov=svony --cov-report=xml
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage.xml
```

### Pre-commit Hooks

```yaml
# .pre-commit-config.yaml
repos:
  - repo: local
    hooks:
      - id: pytest
        name: pytest
        entry: pytest tests/unit -x
        language: system
        pass_filenames: false
        always_run: true
```

---

## Test Patterns

### Testing Exceptions

```python
def test_invalid_input_raises():
    """Test that invalid input raises appropriate exception."""
    with pytest.raises(ValueError) as excinfo:
        process_invalid_data(None)
    
    assert "cannot be None" in str(excinfo.value)
```

### Testing File Operations

```python
def test_file_creation(tmp_path):
    """Test file creation in temporary directory."""
    output_file = tmp_path / "output.txt"
    
    create_output(output_file, "content")
    
    assert output_file.exists()
    assert output_file.read_text() == "content"
```

### Testing Async Code

```python
import pytest

@pytest.mark.asyncio
async def test_async_operation():
    """Test asynchronous operation."""
    result = await fetch_data_async()
    
    assert result is not None
    assert result["status"] == "success"
```

### Parameterized Tests

```python
@pytest.mark.parametrize("input_val,expected", [
    (0, "zero"),
    (1, "one"),
    (2, "two"),
    (-1, "negative"),
])
def test_number_to_word(input_val, expected):
    """Test number conversion with multiple inputs."""
    assert number_to_word(input_val) == expected
```

---

## Mocking Best Practices

### External Services

```python
@pytest.fixture
def mock_network(monkeypatch):
    """Mock all network calls."""
    def mock_get(*args, **kwargs):
        return MockResponse(200, b'{"status": "ok"}')
    
    monkeypatch.setattr("requests.get", mock_get)
```

### Time-Dependent Code

```python
from freezegun import freeze_time

@freeze_time("2026-01-02 12:00:00")
def test_time_based_logic():
    """Test time-dependent functionality."""
    result = get_current_timestamp()
    assert result == "2026-01-02T12:00:00"
```

### File System

```python
def test_with_fake_fs(fs):  # pyfakefs fixture
    """Test with fake filesystem."""
    fs.create_file("/test/file.txt", contents="data")
    
    result = read_file("/test/file.txt")
    assert result == "data"
```

---

## Coverage Reports

### Generate Reports

```bash
# HTML report
pytest --cov=svony --cov-report=html
# Open htmlcov/index.html

# Terminal report
pytest --cov=svony --cov-report=term-missing

# XML for CI
pytest --cov=svony --cov-report=xml
```

### Coverage Configuration

```ini
# .coveragerc
[run]
source = svony
omit = 
    */tests/*
    */__pycache__/*
    */migrations/*

[report]
exclude_lines =
    pragma: no cover
    def __repr__
    raise NotImplementedError
    if TYPE_CHECKING:
```

---

## Related Documentation

- `DEVELOPER_GUIDE.md` - Development setup
- `CONTRIBUTING.md` - Contribution guidelines
- `CI_CD.md` - CI/CD pipeline
- `PERFORMANCE.md` - Performance testing

---

*Document Version: 1.0.0 | Testing Strategy*
