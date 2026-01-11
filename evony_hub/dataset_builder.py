"""
Evony Dataset Builder
======================
Comprehensive tool to build a clean, deduplicated training dataset
by consolidating files from all Evony data sources.

Uses existing components:
- ExternalScanner: Scans external locations
- EvonyIndexer: Indexes and categorizes files
- EvonyOrganizer: Organizes files into proper structure
"""

import os
import json
import hashlib
import shutil
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Set, Tuple, Optional
from collections import defaultdict
from dataclasses import dataclass, asdict

from .config import HUB_ROOT, EXTERNAL_SOURCES, CATEGORIES, EVONY_KEYWORDS
from .scanner import ExternalScanner
from .indexer import EvonyIndexer


@dataclass
class FileRecord:
    """Record for a unique file in the dataset."""
    content_hash: str
    original_paths: List[str]
    best_path: str
    filename: str
    extension: str
    category: str
    size: int
    content_preview: str
    keywords_found: List[str]
    selected: bool = True


class EvonyDatasetBuilder:
    """Builds a clean, deduplicated Evony training dataset."""
    
    # Dataset folder structure
    DATASET_STRUCTURE = {
        'source_code': 'ActionScript, Python, batch files',
        'game_data': 'JSON, XML, CSV files with game mechanics',
        'documentation': 'MD files, protocol docs, guides',
        'network_captures': 'AMF packets, protocol samples',
        'scripts': 'Bot scripts, automation scripts',
        'exploits': 'Exploit documentation and code',
        'keys': 'Encryption keys and algorithms',
        'accounts': 'SOL files, account data (anonymized)',
        'tools': 'Analysis tools and utilities',
        'metadata': 'Index files, training labels',
    }
    
    # Extensions to include
    VALID_EXTENSIONS = {
        '.as', '.py', '.js', '.ts', '.txt', '.md', '.json', '.xml',
        '.bat', '.ps1', '.sh', '.yaml', '.yml', '.cfg', '.ini',
        '.csv', '.sol', '.re', '.rob',
    }
    
    # Skip patterns
    SKIP_PATTERNS = {
        'node_modules', '__pycache__', '.git', '.venv', 'venv',
        'Electron_Browser', 'Macromedia', 'TorData', 'Proxifier',
        'oh-my-logo', 'ASCII_Art_makers', 'FluorineFx-AMF-Library',
        '.idea', '.vscode', 'dist', 'build', '__MACOSX',
        'Package-lock', 'yarn.lock',
    }
    
    SKIP_FILENAMES = {
        'License.txt', 'LICENSE', 'LICENSE.md', 'LICENSE.txt',
        'package-lock.json', 'yarn.lock', '.gitignore', '.npmrc',
        'tsconfig.json', 'webpack.config.js', 'babel.config.js',
        'DOWNLOAD_ME.txt', 'sleighArgs.txt', 'CMakeLists.txt',
    }
    
    def __init__(self, output_path: Path = None):
        self.hub_root = HUB_ROOT
        self.output_path = output_path or (HUB_ROOT / "Evony_Dataset")
        
        # File tracking
        self.all_files: Dict[str, FileRecord] = {}  # hash -> FileRecord
        self.duplicate_map: Dict[str, List[str]] = defaultdict(list)  # hash -> list of paths
        
        # Statistics
        self.stats = {
            'scan_start': None,
            'scan_end': None,
            'sources_scanned': [],
            'total_files_found': 0,
            'files_after_extension_filter': 0,
            'files_after_skip_filter': 0,
            'evony_related_files': 0,
            'unique_content_files': 0,
            'duplicates_removed': 0,
            'final_dataset_size_bytes': 0,
            'by_category': {},
            'by_extension': {},
        }
    
    def _should_skip_path(self, path: Path) -> bool:
        """Check if path should be skipped."""
        path_str = str(path)
        for pattern in self.SKIP_PATTERNS:
            if pattern in path_str:
                return True
        if path.name in self.SKIP_FILENAMES:
            return True
        return False
    
    def _compute_content_hash(self, content: str) -> str:
        """Compute hash of normalized content."""
        import re
        normalized = re.sub(r'\s+', ' ', content.strip())
        return hashlib.md5(normalized.encode('utf-8', errors='replace')).hexdigest()
    
    def _read_file_safely(self, path: Path) -> Optional[str]:
        """Read file with encoding detection."""
        if path.stat().st_size > 500000:  # Skip files > 500KB
            return None
        
        encodings = ['utf-8', 'latin-1', 'cp1252']
        for encoding in encodings:
            try:
                with open(path, 'r', encoding=encoding, errors='strict') as f:
                    content = f.read()
                    if '\x00' in content[:1000]:  # Binary check
                        return None
                    return content
            except (UnicodeDecodeError, UnicodeError):
                continue
        return None
    
    def _is_evony_related(self, path: Path, content: str) -> Tuple[bool, List[str]]:
        """Check if file is Evony-related and return found keywords."""
        path_lower = str(path).lower()
        content_lower = content.lower()[:10000]
        
        found_keywords = []
        
        for keyword in EVONY_KEYWORDS:
            if keyword in path_lower or keyword in content_lower:
                found_keywords.append(keyword)
        
        # Also check for Evony-specific patterns
        evony_patterns = [
            'troop.', 'army.', 'shop.', 'quest.', 'common.', 'castle.',
            'action_key', 'api_key', 'amf', 'autoevony', 'roboevony',
            'AS3_Scripts', 'EvonyClient', 'BorgToolkit', 'evony_hub',
        ]
        for pattern in evony_patterns:
            if pattern.lower() in path_lower or pattern.lower() in content_lower:
                if pattern not in found_keywords:
                    found_keywords.append(pattern)
        
        # Need at least 1 keyword
        return len(found_keywords) >= 1, found_keywords
    
    def _categorize_file(self, path: Path, content: str) -> str:
        """Categorize file for dataset organization."""
        ext = path.suffix.lower()
        path_lower = str(path).lower()
        content_lower = content.lower()[:5000]
        
        # ActionScript source
        if ext == '.as' or 'AS3_Scripts' in str(path):
            return 'source_code'
        
        # Python/batch tools
        if ext in ['.py', '.ps1', '.bat', '.sh']:
            if any(kw in path_lower for kw in ['tool', 'analyzer', 'extractor', 'scanner']):
                return 'tools'
            return 'source_code'
        
        # Scripts (bot scripts)
        if ext == '.txt':
            if any(kw in path_lower for kw in ['script', 'glitch', 'attack', 'spam', 'farm']):
                return 'scripts'
            if any(kw in content_lower for kw in ['loop', 'repeat', 'attack', 'train']):
                return 'scripts'
        
        # Documentation
        if ext == '.md':
            return 'documentation'
        
        # Game data
        if ext in ['.json', '.xml', '.csv']:
            if any(kw in path_lower for kw in ['troop', 'building', 'hero', 'resource']):
                return 'game_data'
            return 'game_data'
        
        # Exploits
        if any(kw in path_lower for kw in ['exploit', 'glitch', 'overflow', 'hack']):
            return 'exploits'
        
        # Keys
        if any(kw in path_lower for kw in ['key', 'encrypt', 'decrypt']):
            return 'keys'
        
        # Accounts
        if ext == '.sol' or 'account' in path_lower:
            return 'accounts'
        
        # Protocol/network
        if any(kw in path_lower for kw in ['protocol', 'amf', 'packet', 'network']):
            return 'network_captures'
        
        return 'game_data'  # Default
    
    def _choose_best_filename(self, paths: List[str]) -> str:
        """Choose the most descriptive filename from duplicates."""
        if len(paths) == 1:
            return paths[0]
        
        # Score each path
        scores = []
        for path in paths:
            score = 0
            p = Path(path)
            name = p.stem.lower()
            
            # Prefer longer, more descriptive names
            score += min(len(name), 50)
            
            # Prefer names with Evony keywords
            for kw in EVONY_KEYWORDS:
                if kw in name:
                    score += 10
            
            # Penalize generic names
            if name in ['readme', 'index', 'main', 'test', 'script']:
                score -= 20
            
            # Prefer paths from known good locations
            if 'BorgToolkit' in path or 'evony_hub' in path:
                score += 15
            if 'Scripts' in path:
                score += 10
            
            scores.append((path, score))
        
        # Return highest scoring
        scores.sort(key=lambda x: x[1], reverse=True)
        return scores[0][0]
    
    def scan_all_sources(self):
        """Phase 1: Scan all sources and identify unique content."""
        print("\n" + "="*60)
        print("PHASE 1: SCANNING ALL SOURCES")
        print("="*60)
        
        self.stats['scan_start'] = datetime.now().isoformat()
        
        # All sources to scan - focus on main folder (data already copied here)
        all_sources = [self.hub_root]  # External sources already copied in
        
        for source in all_sources:
            print(f"\nScanning: {source}")
            self.stats['sources_scanned'].append(str(source))
            
            file_count = 0
            evony_count = 0
            
            for file_path in source.rglob('*'):
                if not file_path.is_file():
                    continue
                
                self.stats['total_files_found'] += 1
                
                # Extension filter
                if file_path.suffix.lower() not in self.VALID_EXTENSIONS:
                    continue
                self.stats['files_after_extension_filter'] += 1
                
                # Skip filter
                if self._should_skip_path(file_path):
                    continue
                self.stats['files_after_skip_filter'] += 1
                
                file_count += 1
                if file_count % 1000 == 0:
                    print(f"  Processed {file_count} files...")
                
                # Read content
                content = self._read_file_safely(file_path)
                if content is None:
                    continue
                
                # Check if Evony-related
                is_evony, keywords = self._is_evony_related(file_path, content)
                if not is_evony:
                    continue
                
                evony_count += 1
                self.stats['evony_related_files'] += 1
                
                # Compute content hash
                content_hash = self._compute_content_hash(content)
                
                # Track duplicates
                self.duplicate_map[content_hash].append(str(file_path))
                
                # Create or update record
                if content_hash not in self.all_files:
                    category = self._categorize_file(file_path, content)
                    self.all_files[content_hash] = FileRecord(
                        content_hash=content_hash,
                        original_paths=[str(file_path)],
                        best_path=str(file_path),
                        filename=file_path.name,
                        extension=file_path.suffix.lower(),
                        category=category,
                        size=len(content),
                        content_preview=content[:500],
                        keywords_found=keywords,
                    )
                else:
                    # Add to existing record's paths
                    self.all_files[content_hash].original_paths.append(str(file_path))
            
            print(f"  Found {evony_count} Evony-related files in {file_count} scanned")
        
        # Choose best paths for duplicates
        for hash_val, record in self.all_files.items():
            if len(record.original_paths) > 1:
                record.best_path = self._choose_best_filename(record.original_paths)
                record.filename = Path(record.best_path).name
        
        # Calculate duplicate stats
        for hash_val, paths in self.duplicate_map.items():
            if len(paths) > 1:
                self.stats['duplicates_removed'] += len(paths) - 1
        
        self.stats['unique_content_files'] = len(self.all_files)
        self.stats['scan_end'] = datetime.now().isoformat()
        
        print(f"\n{'='*60}")
        print("SCAN COMPLETE")
        print(f"{'='*60}")
        print(f"Total files scanned: {self.stats['total_files_found']:,}")
        print(f"After filters: {self.stats['files_after_skip_filter']:,}")
        print(f"Evony-related: {self.stats['evony_related_files']:,}")
        print(f"Unique content: {self.stats['unique_content_files']:,}")
        print(f"Duplicates removed: {self.stats['duplicates_removed']:,}")
    
    def create_dataset_structure(self):
        """Phase 2: Create the dataset folder structure."""
        print("\n" + "="*60)
        print("PHASE 2: CREATING DATASET STRUCTURE")
        print("="*60)
        
        # Create main folder
        self.output_path.mkdir(parents=True, exist_ok=True)
        
        # Create category folders
        for folder, description in self.DATASET_STRUCTURE.items():
            folder_path = self.output_path / folder
            folder_path.mkdir(exist_ok=True)
            print(f"  Created: {folder}/ - {description}")
        
        print(f"\nDataset root: {self.output_path}")
    
    def copy_unique_files(self):
        """Phase 3: Copy unique files to dataset structure."""
        print("\n" + "="*60)
        print("PHASE 3: COPYING UNIQUE FILES")
        print("="*60)
        
        copied = 0
        errors = 0
        
        for hash_val, record in self.all_files.items():
            if not record.selected:
                continue
            
            source_path = Path(record.best_path)
            if not source_path.exists():
                # Try other paths
                for alt_path in record.original_paths:
                    if Path(alt_path).exists():
                        source_path = Path(alt_path)
                        break
                else:
                    errors += 1
                    continue
            
            # Determine destination
            dest_folder = self.output_path / record.category
            dest_filename = record.filename
            
            # Handle filename collisions
            dest_path = dest_folder / dest_filename
            if dest_path.exists():
                stem = Path(dest_filename).stem
                suffix = Path(dest_filename).suffix
                dest_path = dest_folder / f"{stem}_{hash_val[:8]}{suffix}"
            
            try:
                # Read and write (ensures consistent encoding)
                content = self._read_file_safely(source_path)
                if content:
                    with open(dest_path, 'w', encoding='utf-8', errors='replace') as f:
                        f.write(content)
                    
                    record.selected = True
                    self.stats['final_dataset_size_bytes'] += len(content)
                    
                    # Update stats
                    cat = record.category
                    self.stats['by_category'][cat] = self.stats['by_category'].get(cat, 0) + 1
                    ext = record.extension
                    self.stats['by_extension'][ext] = self.stats['by_extension'].get(ext, 0) + 1
                    
                    copied += 1
                    if copied % 200 == 0:
                        print(f"  Copied {copied} files...")
            except Exception as e:
                errors += 1
        
        print(f"\nCopied {copied} unique files")
        print(f"Errors: {errors}")
    
    def generate_metadata(self):
        """Phase 4: Generate metadata and index files."""
        print("\n" + "="*60)
        print("PHASE 4: GENERATING METADATA")
        print("="*60)
        
        metadata_dir = self.output_path / "metadata"
        
        # 1. File index
        index = []
        for hash_val, record in self.all_files.items():
            if record.selected:
                index.append({
                    'hash': record.content_hash,
                    'filename': record.filename,
                    'category': record.category,
                    'extension': record.extension,
                    'size': record.size,
                    'keywords': record.keywords_found,
                    'duplicate_count': len(record.original_paths),
                })
        
        index_path = metadata_dir / "file_index.json"
        with open(index_path, 'w', encoding='utf-8') as f:
            json.dump(index, f, indent=2)
        print(f"  Created file_index.json ({len(index)} entries)")
        
        # 2. Duplicate report
        duplicates = []
        for hash_val, paths in self.duplicate_map.items():
            if len(paths) > 1:
                duplicates.append({
                    'hash': hash_val,
                    'count': len(paths),
                    'kept': self.all_files[hash_val].best_path,
                    'removed': [p for p in paths if p != self.all_files[hash_val].best_path][:5]
                })
        duplicates.sort(key=lambda x: -x['count'])
        
        dup_path = metadata_dir / "duplicates_report.json"
        with open(dup_path, 'w', encoding='utf-8') as f:
            json.dump(duplicates[:200], f, indent=2)
        print(f"  Created duplicates_report.json ({len(duplicates)} duplicate groups)")
        
        # 3. Statistics
        stats_path = metadata_dir / "dataset_stats.json"
        with open(stats_path, 'w', encoding='utf-8') as f:
            json.dump(self.stats, f, indent=2)
        print(f"  Created dataset_stats.json")
        
        # 4. README
        readme_content = f"""# Evony Training Dataset

Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}

## Summary
- **Total unique files**: {self.stats['unique_content_files']:,}
- **Duplicates removed**: {self.stats['duplicates_removed']:,}
- **Dataset size**: {self.stats['final_dataset_size_bytes']/1024/1024:.2f} MB

## Sources Scanned
{chr(10).join('- ' + s for s in self.stats['sources_scanned'])}

## Categories
{chr(10).join(f"- **{cat}**: {count:,} files" for cat, count in sorted(self.stats['by_category'].items(), key=lambda x: -x[1]))}

## File Types
{chr(10).join(f"- `{ext}`: {count:,} files" for ext, count in sorted(self.stats['by_extension'].items(), key=lambda x: -x[1])[:10])}

## Structure
```
Evony_Dataset/
├── source_code/       # AS3, Python source files
├── scripts/           # Bot automation scripts
├── documentation/     # Protocol docs, guides
├── exploits/          # Glitch documentation
├── game_data/         # JSON/XML game data
├── keys/              # Encryption keys
├── accounts/          # SOL/account data
├── network_captures/  # Protocol samples
├── tools/             # Analysis utilities
└── metadata/          # Index and stats
```

## Usage
This dataset is ready for AI model fine-tuning focused on:
- Evony protocol understanding
- Bot script generation
- Exploit analysis
- Game mechanics knowledge
"""
        
        readme_path = self.output_path / "README.md"
        with open(readme_path, 'w', encoding='utf-8') as f:
            f.write(readme_content)
        print(f"  Created README.md")
    
    def print_summary(self):
        """Print final summary."""
        print("\n" + "="*60)
        print("DATASET BUILD COMPLETE")
        print("="*60)
        print(f"\nOutput: {self.output_path}")
        print(f"\nFinal Statistics:")
        print(f"  Unique files: {self.stats['unique_content_files']:,}")
        print(f"  Duplicates removed: {self.stats['duplicates_removed']:,}")
        print(f"  Dataset size: {self.stats['final_dataset_size_bytes']/1024/1024:.2f} MB")
        
        print(f"\nBy Category:")
        for cat, count in sorted(self.stats['by_category'].items(), key=lambda x: -x[1]):
            print(f"  {cat:20s}: {count:,}")
        
        print(f"\n{'='*60}\n")
    
    def build(self):
        """Run the complete dataset build pipeline."""
        print("\n" + "="*60)
        print("EVONY DATASET BUILDER")
        print("="*60)
        print(f"Output: {self.output_path}")
        print(f"Sources: {len(EXTERNAL_SOURCES) + 1}")
        
        self.scan_all_sources()
        self.create_dataset_structure()
        self.copy_unique_files()
        self.generate_metadata()
        self.print_summary()
        
        return self.stats


def build_dataset():
    """Convenience function to build the dataset."""
    builder = EvonyDatasetBuilder()
    return builder.build()


if __name__ == "__main__":
    build_dataset()
