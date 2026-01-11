# FFDec Feature Analysis & Svony Studio Implementation Roadmap

## Executive Summary

This document analyzes JPEXS Free Flash Decompiler (FFDec) v23.0.1 capabilities compared to Svony Studio's current implementation, identifying gaps and providing a prioritized implementation roadmap to transform Svony Studio into a comprehensive SWF development environment for Evony Age II automation.

---

## Current State Analysis

### Svony Studio Current Capabilities

| Component | Status | Coverage |
|-----------|--------|----------|
| **FFDecWrapper** | ✅ Implemented | ~20% of FFDec CLI |
| **SWFToolsWrapper** | ✅ Implemented | ~30% of SWFTools |
| **RABCDAsmWrapper** | ✅ Implemented | ~40% of RABCDAsm |
| **RuffleWrapper** | ✅ Implemented | Basic playback only |
| **FlashPlayerManager** | ✅ Implemented | Player detection |
| **FlashCompatibilityChecker** | ✅ Implemented | Basic AS3 checks |
| **AudioPlayer** | ✅ Implemented | System playback |
| **SOLManager** | ✅ Implemented | Basic SOL editing |

### FFDecWrapper Current Methods

```python
# IMPLEMENTED ✅
launch_gui(swf_path)           # Opens FFDec GUI
export_scripts(swf, out, fmt)  # Exports scripts (as, pcode, hex)
export_images(swf, out, fmt)   # Exports images (png, jpg, bmp)
export_sounds(swf, out)        # Exports sounds (mp3, wav)
export_all(swf, out)           # Exports everything
search(swf, pattern, opts)     # Text search in scripts
deobfuscate(swf, out)          # Basic deobfuscation
replace_script(swf, script)    # Script replacement

# MISSING ❌
compress(swf, out, method)     # SWF compression (zlib/lzma)
decompress(swf, out)           # SWF decompression
encrypt(swf, out)              # HARMAN AIR encryption
decrypt(swf, out)              # HARMAN AIR decryption
swf2xml(swf, out)              # Convert to XML
xml2swf(xml, out)              # Convert from XML
swf2exe(swf, mode)             # Create projector/exe
dump_tags(swf)                 # List SWF tags
dump_as2(swf)                  # List AS1/2 scripts
dump_as3(swf)                  # List AS3 scripts
import_scripts(swf, folder)   # Bulk import scripts
import_images(swf, folder)    # Bulk import images
import_sounds(swf, folder)    # Bulk import sounds
replace_image(swf, id, file)  # Replace single image
replace_sound(swf, id, file)  # Replace single sound
set_header(swf, key, value)   # Modify SWF header
abc_merge(swf, out)           # Merge ABC tags
abc_clean(swf, out)           # Clean unused ABC
link_report(swf)              # Generate linker report
enable_debugging(swf, out)    # Inject debug info
deobfuscate_level(swf, lvl)   # Specific deob level
```

---

## Gap Analysis: FFDec vs Svony Studio

### 1. SWF Analysis & Extraction

| FFDec Feature | Svony Status | Priority |
|---------------|--------------|----------|
| Complete SWF tag dump | ❌ Missing | P1 |
| AS3 class listing | ❌ Missing | P1 |
| P-code display | ❌ Missing | P1 |
| Hex dump view | ❌ Missing | P2 |
| Tag tree navigation | ❌ Missing | P2 |
| Binary data extraction | ❌ Missing | P2 |
| Font extraction (TTF/WOFF) | ❌ Missing | P3 |
| Shape/vector export | ❌ Missing | P3 |
| MorphShape export | ❌ Missing | P3 |
| Sprite/button export | ❌ Missing | P3 |
| Video stream export | ❌ Missing | P3 |
| SymbolClass mapping | ❌ Missing | P2 |

### 2. Content Editing

| FFDec Feature | Svony Status | Priority |
|---------------|--------------|----------|
| Direct AS editing | ❌ Missing | P1 |
| P-code editing | ❌ Missing | P1 |
| Image replacement | ⚠️ Partial | P1 |
| Sound replacement | ❌ Missing | P1 |
| Text editing | ❌ Missing | P2 |
| Font modification | ❌ Missing | P3 |
| Shape editing | ❌ Missing | P3 |
| Add/remove tags | ❌ Missing | P2 |
| PlaceObject editing | ❌ Missing | P3 |

### 3. SWF Rebuilding

| FFDec Feature | Svony Status | Priority |
|---------------|--------------|----------|
| Compress/decompress | ⚠️ RABCDAsm | P1 |
| XML round-trip | ❌ Missing | P1 |
| Script import | ❌ Missing | P1 |
| Bulk import | ❌ Missing | P2 |
| Create projector EXE | ❌ Missing | P2 |
| ABC merge/clean | ❌ Missing | P2 |
| Modify header | ❌ Missing | P2 |

### 4. Testing & Validation

| FFDec Feature | Svony Status | Priority |
|---------------|--------------|----------|
| Built-in SWF player | ⚠️ Ruffle | P1 |
| Enable debugging | ❌ Missing | P1 |
| Debug breakpoints | ❌ Missing | P2 |
| Step through code | ❌ Missing | P2 |
| Variable inspection | ❌ Missing | P2 |
| Error validation | ❌ Missing | P2 |

### 5. Advanced Features

| FFDec Feature | Svony Status | Priority |
|---------------|--------------|----------|
| Batch processing | ⚠️ Basic | P2 |
| Deobfuscation levels | ❌ Missing | P1 |
| Memory search | ❌ Missing | P2 |
| ABC Explorer | ❌ Missing | P2 |
| SOL editor | ✅ Basic | P3 |
| FlashPaper to PDF | ❌ Missing | P4 |

---

## Implementation Roadmap

### Phase 1: Core FFDec Integration (Week 1-2)
**Goal:** Complete FFDecWrapper with all essential CLI commands

#### 1.1 SWF Analysis Commands
```python
# New methods to add to FFDecWrapper

def dump_swf(self, swf_path: Path) -> Dict[str, Any]:
    """Get complete SWF structure including all tags."""
    # Uses: ffdec -dumpSWF <swf>

def list_as3_classes(self, swf_path: Path) -> List[str]:
    """List all AS3 classes in the SWF."""
    # Uses: ffdec -dumpAS3 <swf>

def list_as2_scripts(self, swf_path: Path) -> List[str]:
    """List all AS1/2 scripts in the SWF."""
    # Uses: ffdec -dumpAS2 <swf>

def get_symbol_class_map(self, swf_path: Path) -> Dict[str, str]:
    """Get SymbolClass tag mappings."""
    # Parse from dump output
```

#### 1.2 Compression/Encryption
```python
def compress(self, swf_path: Path, output: Path,
             method: Literal["zlib", "lzma"] = "zlib") -> bool:
    """Compress SWF file."""
    # Uses: ffdec -compress <swf> <out>

def decompress(self, swf_path: Path, output: Path) -> bool:
    """Decompress SWF file."""
    # Uses: ffdec -decompress <swf> <out>

def encrypt_harman(self, swf_path: Path, output: Path) -> bool:
    """Encrypt for HARMAN AIR."""
    # Uses: ffdec -encrypt <swf> <out>

def decrypt_harman(self, swf_path: Path, output: Path) -> bool:
    """Decrypt HARMAN AIR SWF."""
    # Uses: ffdec -decrypt <swf> <out>
```

#### 1.3 XML Round-Trip
```python
def swf_to_xml(self, swf_path: Path, output_dir: Path) -> Path:
    """Convert SWF to editable XML format."""
    # Uses: ffdec -swf2xml <swf> <out>

def xml_to_swf(self, xml_path: Path, output: Path) -> bool:
    """Rebuild SWF from XML."""
    # Uses: ffdec -xml2swf <xml> <out>
```

### Phase 2: Content Editing (Week 3-4)
**Goal:** Enable direct content modification

#### 2.1 Script Editing
```python
def import_scripts(self, swf_path: Path, scripts_dir: Path,
                   output: Path) -> bool:
    """Import all scripts from directory."""
    # Uses: ffdec -importScript <swf> <dir> <out>

def replace_pcode(self, swf_path: Path, class_name: str,
                  pcode: str, output: Path) -> bool:
    """Replace P-code for specific class."""
    # Uses: ffdec -replace <swf> <class> <pcode> <out>
```

#### 2.2 Asset Replacement
```python
def replace_image(self, swf_path: Path, tag_id: int,
                  image_path: Path, output: Path) -> bool:
    """Replace specific image by tag ID."""
    # Uses: ffdec -replaceImage <swf> <id> <img> <out>

def replace_sound(self, swf_path: Path, tag_id: int,
                  sound_path: Path, output: Path) -> bool:
    """Replace specific sound by tag ID."""
    # Uses: ffdec -replaceSound <swf> <id> <snd> <out>

def import_images(self, swf_path: Path, images_dir: Path,
                  output: Path) -> bool:
    """Bulk import images from directory."""
    # Uses: ffdec -importImages <swf> <dir> <out>

def import_sounds(self, swf_path: Path, sounds_dir: Path,
                  output: Path) -> bool:
    """Bulk import sounds from directory."""
    # Uses: ffdec -importSounds <swf> <dir> <out>
```

#### 2.3 Text Editing
```python
def export_texts(self, swf_path: Path, output: Path) -> bool:
    """Export all text content."""
    # Uses: ffdec -export text <swf> <out>

def import_texts(self, swf_path: Path, texts_file: Path,
                 output: Path) -> bool:
    """Import modified texts."""
    # Uses: ffdec -importText <swf> <file> <out>
```


### Phase 3: Advanced Analysis (Week 5-6)
**Goal:** Deep SWF analysis and debugging support

#### 3.1 Deobfuscation
```python
def deobfuscate_advanced(self, swf_path: Path, output: Path,
                         level: int = 3) -> bool:
    """Advanced deobfuscation with configurable level.

    Levels:
    1 - Basic renaming
    2 - Control flow simplification
    3 - Full deobfuscation (default)
    """
    # Uses: ffdec -deobfuscate <level> <swf> <out>

def rename_identifiers(self, swf_path: Path, output: Path,
                       prefix: str = "class_") -> bool:
    """Rename obfuscated identifiers with readable names."""
    # Uses: ffdec -renameInvalidIdentifiers <swf> <out>
```

#### 3.2 Debugging Support
```python
def enable_debugging(self, swf_path: Path, output: Path) -> bool:
    """Inject debug information into SWF."""
    # Uses: ffdec -enabledebugging <swf> <out>

def inject_debug_line(self, swf_path: Path, output: Path) -> bool:
    """Inject DebugLine opcodes for line-level debugging."""
    # Uses: ffdec -injectdebugline <swf> <out>
```

#### 3.3 ABC Analysis
```python
def merge_abc_tags(self, swf_path: Path, output: Path) -> bool:
    """Merge multiple ABC tags into one."""
    # Uses: ffdec -abcmerge <swf> <out>

def clean_abc(self, swf_path: Path, output: Path) -> bool:
    """Remove unused ABC code."""
    # Uses: ffdec -abcclean <swf> <out>

def generate_link_report(self, swf_path: Path) -> Dict[str, Any]:
    """Generate linker report showing dependencies."""
    # Uses: ffdec -linkreport <swf>
```

### Phase 4: Build & Distribution (Week 7-8)
**Goal:** Complete build pipeline for modified SWFs

#### 4.1 Projector Creation
```python
def create_projector(self, swf_path: Path, output: Path,
                     platform: Literal["win", "mac", "linux"] = "win",
                     projector_path: Optional[Path] = None) -> bool:
    """Create standalone projector EXE."""
    # Uses: ffdec -swf2exe <swf> <projector> <out>

def create_installer(self, swf_path: Path, output: Path) -> bool:
    """Create installer wrapper for projector."""
    # Uses: ffdec -swf2exe installer <swf> <out>
```

#### 4.2 Header Modification
```python
def set_swf_version(self, swf_path: Path, version: int,
                    output: Path) -> bool:
    """Change SWF version number."""
    # Uses: ffdec -setheader version <ver> <swf> <out>

def set_frame_rate(self, swf_path: Path, fps: float,
                   output: Path) -> bool:
    """Change frame rate."""
    # Uses: ffdec -setheader framerate <fps> <swf> <out>

def set_dimensions(self, swf_path: Path, width: int, height: int,
                   output: Path) -> bool:
    """Change SWF dimensions."""
    # Uses: ffdec -setheader width <w> height <h> <swf> <out>

def set_background_color(self, swf_path: Path, color: str,
                         output: Path) -> bool:
    """Change background color (hex format)."""
    # Uses: ffdec -setheader bgcolor <color> <swf> <out>
```

### Phase 5: Batch Processing (Week 9-10)
**Goal:** Efficient multi-file operations

#### 5.1 Batch Operations
```python
def batch_export(self, swf_files: List[Path], output_dir: Path,
                 export_types: List[str]) -> Dict[Path, bool]:
    """Export from multiple SWF files."""
    # Uses: ffdec -export <types> <swf1> <swf2> ... <out>

def batch_deobfuscate(self, swf_files: List[Path],
                      output_dir: Path) -> Dict[Path, bool]:
    """Deobfuscate multiple SWF files."""

def batch_compress(self, swf_files: List[Path],
                   output_dir: Path,
                   method: str = "zlib") -> Dict[Path, bool]:
    """Compress multiple SWF files."""
```

#### 5.2 Configuration
```python
def set_config(self, key: str, value: str) -> bool:
    """Set FFDec configuration option."""
    # Uses: ffdec -config <key>=<value>

def get_config(self, key: str) -> Optional[str]:
    """Get FFDec configuration value."""

def reset_config(self) -> bool:
    """Reset FFDec to default configuration."""
```

---

## Integration Architecture

### Enhanced FFDecWrapper Class Structure

```python
class FFDecWrapper:
    """Complete FFDec CLI wrapper for Svony Studio."""

    # === Analysis ===
    dump_swf()
    list_as3_classes()
    list_as2_scripts()
    get_symbol_class_map()
    generate_link_report()

    # === Export ===
    export_scripts()      # Existing
    export_images()       # Existing
    export_sounds()       # Existing
    export_all()          # Existing
    export_texts()        # New
    export_fonts()        # New
    export_shapes()       # New
    export_binary()       # New

    # === Import ===
    import_scripts()      # New
    import_images()       # New
    import_sounds()       # New
    import_texts()        # New

    # === Replace ===
    replace_script()      # Existing
    replace_image()       # New
    replace_sound()       # New
    replace_pcode()       # New

    # === Transform ===
    compress()            # New
    decompress()          # New
    encrypt_harman()      # New
    decrypt_harman()      # New
    swf_to_xml()          # New
    xml_to_swf()          # New

    # === Deobfuscation ===
    deobfuscate()         # Existing (basic)
    deobfuscate_advanced()# New
    rename_identifiers()  # New

    # === ABC Operations ===
    merge_abc_tags()      # New
    clean_abc()           # New

    # === Debugging ===
    enable_debugging()    # New
    inject_debug_line()   # New

    # === Build ===
    create_projector()    # New
    create_installer()    # New
    set_swf_version()     # New
    set_frame_rate()      # New
    set_dimensions()      # New
    set_background_color()# New

    # === Batch ===
    batch_export()        # New
    batch_deobfuscate()   # New
    batch_compress()      # New

    # === Config ===
    set_config()          # New
    get_config()          # New
    reset_config()        # New

    # === GUI ===
    launch_gui()          # Existing
    search()              # Existing
```


---

## Evony Age II Specific Use Cases

### 1. Game Client Analysis
| Use Case | FFDec Features Needed | Priority |
|----------|----------------------|----------|
| Extract game protocol classes | dump_swf, list_as3_classes | P1 |
| Find network packet handlers | search, export_scripts | P1 |
| Identify encryption methods | deobfuscate_advanced | P1 |
| Map UI components | get_symbol_class_map | P2 |
| Extract game assets | export_images, export_sounds | P2 |

### 2. Bot Development Support
| Use Case | FFDec Features Needed | Priority |
|----------|----------------------|----------|
| Understand packet structure | export_scripts (pcode) | P1 |
| Find API endpoints | search, deobfuscate | P1 |
| Extract resource IDs | dump_swf, export_texts | P2 |
| Analyze game logic | enable_debugging | P2 |
| Test modified clients | create_projector | P3 |

### 3. Mod Development
| Use Case | FFDec Features Needed | Priority |
|----------|----------------------|----------|
| Replace game graphics | replace_image, import_images | P2 |
| Modify game text | export_texts, import_texts | P2 |
| Inject custom code | replace_script, xml_to_swf | P3 |
| Create custom builds | compress, set_swf_version | P3 |

---

## Implementation Priority Matrix

### P1 - Critical (Weeks 1-4)
Must-have for core Evony automation functionality:

1. **dump_swf** - Understand SWF structure
2. **list_as3_classes** - Find relevant classes
3. **compress/decompress** - Handle SWF formats
4. **swf_to_xml/xml_to_swf** - Enable round-trip editing
5. **import_scripts** - Apply code modifications
6. **deobfuscate_advanced** - Handle obfuscated code
7. **enable_debugging** - Debug modified SWFs

### P2 - Important (Weeks 5-8)
Enhance development workflow:

1. **replace_image/sound** - Asset modification
2. **export_texts/import_texts** - Localization
3. **merge_abc_tags** - Optimize SWFs
4. **set_swf_version** - Compatibility
5. **batch_export** - Efficiency
6. **get_symbol_class_map** - UI analysis

### P3 - Nice to Have (Weeks 9-10)
Additional capabilities:

1. **create_projector** - Standalone testing
2. **export_fonts** - Font extraction
3. **export_shapes** - Vector graphics
4. **inject_debug_line** - Advanced debugging

### P4 - Future
Low priority features:

1. **FlashPaper to PDF** - Document conversion
2. **create_installer** - Distribution

---

## Testing Strategy

### Unit Tests
```python
# tests/test_ffdec_wrapper_extended.py

class TestFFDecAnalysis:
    def test_dump_swf_returns_valid_structure(self)
    def test_list_as3_classes_finds_all_classes(self)
    def test_get_symbol_class_map_correct_mapping(self)

class TestFFDecTransform:
    def test_compress_zlib_reduces_size(self)
    def test_compress_lzma_reduces_size_more(self)
    def test_decompress_restores_original(self)
    def test_xml_roundtrip_preserves_content(self)

class TestFFDecEdit:
    def test_replace_image_updates_correctly(self)
    def test_import_scripts_applies_changes(self)
    def test_import_texts_updates_strings(self)

class TestFFDecBuild:
    def test_create_projector_produces_exe(self)
    def test_set_swf_version_changes_header(self)
```

### Integration Tests
```python
# tests/integration/test_evony_workflow.py

class TestEvonyWorkflow:
    def test_full_extraction_workflow(self)
    def test_modification_and_rebuild(self)
    def test_deobfuscation_pipeline(self)
```

---

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| FFDec CLI coverage | 90% | Methods implemented / Total CLI commands |
| Test coverage | 80% | Lines covered / Total lines |
| Evony SWF compatibility | 100% | SWFs processed successfully |
| Round-trip accuracy | 100% | XML→SWF→XML produces identical output |
| Performance | <5s | Average operation time |

---

## Dependencies

### Required
- FFDec v23.0.1+ (already installed)
- Java 8+ runtime (for FFDec)
- Python 3.10+

### Optional
- Flash Player Projector (for testing)
- Ruffle (for web-based testing)
- RABCDAsm (for low-level ABC editing)

---

## Next Steps

1. **Immediate**: Implement Phase 1 core commands
2. **Week 2**: Add comprehensive tests
3. **Week 3-4**: Implement content editing
4. **Week 5-6**: Add advanced analysis
5. **Week 7-8**: Build pipeline
6. **Week 9-10**: Batch processing and optimization

---

*Document Version: 1.0*
*Created: 2026-01-02*
*Author: Svony Studio Development Team*
