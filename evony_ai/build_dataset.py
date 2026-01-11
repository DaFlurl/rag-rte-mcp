"""
Evony Dataset Builder
======================
Deduplicates and organizes all Evony data into a clean training dataset.

This script:
1. Scans all known Evony data locations
2. Hashes file content to identify duplicates
3. Filters for Evony-relevant content only
4. Organizes into a clean dataset structure
5. Generates metadata index
"""

import os
import json
import hashlib
import shutil
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Set, Tuple
from collections import defaultdict
import re

# Files to always skip (not Evony-related or binary)
SKIP_FILES = {
    'License.txt', 'LICENSE', 'LICENSE.md', 'LICENSE.txt',
    'package-lock.json', 'yarn.lock', '.gitignore', '.npmrc',
    'tsconfig.json', 'webpack.config.js', 'babel.config.js',
    'DOWNLOAD_ME.txt', 'sleighArgs.txt', 'CMakeLists.txt',
}

# Directories to completely skip
SKIP_DIRS = {
    'node_modules', '__pycache__', '.git', '.venv', 'venv',
    'Electron_Browser', 'Macromedia', 'TorData', 'Proxifier 4.12',
    'oh-my-logo', 'ASCII_Art_makers', 'FluorineFx-AMF-Library',
    '.idea', '.vscode', 'dist', 'build', '__MACOSX',
}

# Extensions to include
INCLUDE_EXTENSIONS = {
    '.as', '.py', '.js', '.ts', '.txt', '.md', '.json', '.xml',
    '.bat', '.ps1', '.sh', '.yaml', '.yml', '.cfg', '.ini',
}

# Binary/media to skip
SKIP_EXTENSIONS = {
    '.exe', '.dll', '.swf', '.zip', '.rar', '.7z', '.tar', '.gz',
    '.jpg', '.jpeg', '.png', '.gif', '.ico', '.bmp', '.webp',
    '.pdf', '.doc', '.docx', '.xls', '.xlsx', '.ppt', '.pptx',
    '.mp3', '.mp4', '.wav', '.avi', '.mov', '.woff', '.woff2',
    '.ttf', '.eot', '.so', '.dylib', '.o', '.a', '.pyc', '.pyo',
}

# Evony-specific keywords that indicate relevant content
EVONY_KEYWORDS = {
    # Game terms
    'evony', 'autoevony', 'troop', 'castle', 'army', 'hero',
    'prestige', 'alliance', 'barracks', 'embassy', 'tavern',
    'archer', 'cavalry', 'cataphract', 'pikeman', 'swordsman',
    'ballista', 'catapult', 'transporter', 'warrior', 'scout',
    
    # Protocol terms
    'amf', 'actionscript', 'flash', 'swf', 'socket', 'packet',
    
    # Command patterns
    'troop.', 'army.', 'shop.', 'quest.', 'common.', 'castle.',
    'interior.', 'colony.', 'alliance.', 'hero.', 'tech.',
    
    # Exploit terms
    'glitch', 'overflow', 'exploit', 'hack', 'cheat', 'bot',
    
    # Keys/encryption
    'action_key', 'api_key', 'xor', 'md5', 'encrypt', 'decrypt',
    
    # Tool names
    'borgtoolkit', 'borg', 'evonyhub', 'roboevony', 'pyevony',
}

# Dataset categories
CATEGORIES = {
    'source_code': {
        'description': 'AS3/Flash client source code',
        'patterns': [r'\.as$', r'AS3_Scripts', r'EvonyClient'],
    },
    'scripts': {
        'description': 'AutoEvony automation scripts',
        'patterns': [r'script', r'glitch', r'attack', r'\.txt$'],
    },
    'protocol': {
        'description': 'Network protocol documentation',
        'patterns': [r'protocol', r'amf', r'command', r'packet'],
    },
    'exploits': {
        'description': 'Exploits and glitches',
        'patterns': [r'exploit', r'glitch', r'overflow', r'hack'],
    },
    'keys': {
        'description': 'Encryption keys and algorithms',
        'patterns': [r'key', r'encrypt', r'decrypt', r'hash'],
    },
    'documentation': {
        'description': 'Technical documentation',
        'patterns': [r'\.md$', r'docs?/', r'readme'],
    },
    'tools': {
        'description': 'Python/JS analysis tools',
        'patterns': [r'\.py$', r'toolkit', r'analyzer', r'extractor'],
    },
    'game_data': {
        'description': 'Game mechanics data',
        'patterns': [r'troop', r'resource', r'building', r'hero'],
    },
    'accounts': {
        'description': 'Account/SOL data',
        'patterns': [r'account', r'\.sol', r'login', r'password'],
    },
}


class EvonyDatasetBuilder:
    def __init__(self, source_path: str, output_path: str):
        self.source_path = Path(source_path)
        self.output_path = Path(output_path)
        
        # Tracking
        self.content_hashes: Dict[str, List[Path]] = defaultdict(list)
        self.unique_files: Dict[str, dict] = {}
        self.duplicates_found = 0
        self.files_scanned = 0
        self.files_skipped = 0
        
        # Stats
        self.stats = {
            'scan_start': None,
            'scan_end': None,
            'total_scanned': 0,
            'total_skipped': 0,
            'duplicates_removed': 0,
            'unique_files': 0,
            'total_size_bytes': 0,
            'by_category': {},
            'by_extension': {},
        }
    
    def should_skip_path(self, path: Path) -> bool:
        """Check if path should be skipped."""
        path_str = str(path)
        
        # Skip directories
        for skip_dir in SKIP_DIRS:
            if skip_dir in path_str:
                return True
        
        # Skip by filename
        if path.name in SKIP_FILES:
            return True
        
        # Skip by extension
        if path.suffix.lower() in SKIP_EXTENSIONS:
            return True
        
        # Only include specific extensions
        if path.suffix.lower() not in INCLUDE_EXTENSIONS:
            return True
        
        return False
    
    def is_evony_related(self, path: Path, content: str) -> bool:
        """Check if file contains Evony-related content."""
        path_lower = str(path).lower()
        content_lower = content.lower()[:5000]  # Check first 5KB
        
        # Check path for keywords
        for keyword in EVONY_KEYWORDS:
            if keyword in path_lower:
                return True
        
        # Check content for keywords
        keyword_count = 0
        for keyword in EVONY_KEYWORDS:
            if keyword in content_lower:
                keyword_count += 1
                if keyword_count >= 2:  # At least 2 keywords
                    return True
        
        # Special case: AS3 files from Evony source
        if 'AS3_Scripts' in str(path) or 'Evony_Source' in str(path):
            return True
        
        # Special case: Known Evony directories
        evony_dirs = ['BorgToolkit', 'evony_hub', 'EvonyMasterSuite', 
                      'EvonyCommandCenter', 'Scripts', 'Vony', 'SOL_']
        for evony_dir in evony_dirs:
            if evony_dir in str(path):
                return True
        
        return False
    
    def categorize_file(self, path: Path, content: str) -> str:
        """Categorize file into dataset category."""
        path_lower = str(path).lower()
        content_lower = content.lower()[:2000]
        
        for cat_name, cat_info in CATEGORIES.items():
            for pattern in cat_info['patterns']:
                if re.search(pattern, path_lower, re.IGNORECASE):
                    return cat_name
                if re.search(pattern, content_lower, re.IGNORECASE):
                    return cat_name
        
        return 'other'
    
    def hash_content(self, content: str) -> str:
        """Generate content hash for deduplication."""
        # Normalize content (remove whitespace variations)
        normalized = re.sub(r'\s+', ' ', content.strip())
        return hashlib.md5(normalized.encode('utf-8', errors='replace')).hexdigest()
    
    def read_file_safely(self, path: Path) -> Tuple[str, str]:
        """Read file with encoding detection."""
        encodings = ['utf-8', 'latin-1', 'cp1252', 'ascii']
        
        for encoding in encodings:
            try:
                with open(path, 'r', encoding=encoding, errors='strict') as f:
                    content = f.read()
                return content, encoding
            except (UnicodeDecodeError, UnicodeError):
                continue
        
        # Fallback with replacement
        try:
            with open(path, 'r', encoding='utf-8', errors='replace') as f:
                return f.read(), 'utf-8-replace'
        except Exception:
            return None, None
    
    def scan_files(self):
        """Scan all files and identify unique Evony content."""
        print(f"\n{'='*60}")
        print("PHASE 1: SCANNING FILES")
        print(f"{'='*60}")
        print(f"Source: {self.source_path}")
        
        self.stats['scan_start'] = datetime.now().isoformat()
        
        # Gather all files
        all_files = list(self.source_path.rglob('*'))
        total_files = len([f for f in all_files if f.is_file()])
        print(f"Total files found: {total_files:,}")
        
        processed = 0
        for file_path in all_files:
            if not file_path.is_file():
                continue
            
            processed += 1
            if processed % 5000 == 0:
                print(f"  Processed {processed:,} / {total_files:,} files...")
            
            # Skip check
            if self.should_skip_path(file_path):
                self.files_skipped += 1
                continue
            
            # Read content
            content, encoding = self.read_file_safely(file_path)
            if content is None or len(content) < 10:
                self.files_skipped += 1
                continue
            
            # Skip very large files
            if len(content) > 500000:
                self.files_skipped += 1
                continue
            
            # Check if Evony-related
            if not self.is_evony_related(file_path, content):
                self.files_skipped += 1
                continue
            
            self.files_scanned += 1
            
            # Hash for deduplication
            content_hash = self.hash_content(content)
            self.content_hashes[content_hash].append(file_path)
            
            # Track unique files (first occurrence)
            if content_hash not in self.unique_files:
                category = self.categorize_file(file_path, content)
                self.unique_files[content_hash] = {
                    'hash': content_hash,
                    'path': str(file_path.relative_to(self.source_path)),
                    'filename': file_path.name,
                    'extension': file_path.suffix.lower(),
                    'size': len(content),
                    'category': category,
                    'encoding': encoding,
                    'content': content,
                }
                
                # Update stats
                self.stats['by_category'][category] = self.stats['by_category'].get(category, 0) + 1
                ext = file_path.suffix.lower()
                self.stats['by_extension'][ext] = self.stats['by_extension'].get(ext, 0) + 1
                self.stats['total_size_bytes'] += len(content)
        
        # Count duplicates
        for hash_val, paths in self.content_hashes.items():
            if len(paths) > 1:
                self.duplicates_found += len(paths) - 1
        
        self.stats['scan_end'] = datetime.now().isoformat()
        self.stats['total_scanned'] = self.files_scanned
        self.stats['total_skipped'] = self.files_skipped
        self.stats['duplicates_removed'] = self.duplicates_found
        self.stats['unique_files'] = len(self.unique_files)
        
        print(f"\nScan complete!")
        print(f"  Files scanned: {self.files_scanned:,}")
        print(f"  Files skipped: {self.files_skipped:,}")
        print(f"  Duplicates found: {self.duplicates_found:,}")
        print(f"  Unique files: {len(self.unique_files):,}")
        print(f"  Total unique size: {self.stats['total_size_bytes']/1024/1024:.2f} MB")
    
    def organize_dataset(self):
        """Organize unique files into dataset structure."""
        print(f"\n{'='*60}")
        print("PHASE 2: ORGANIZING DATASET")
        print(f"{'='*60}")
        
        # Create output structure
        self.output_path.mkdir(parents=True, exist_ok=True)
        
        for category in CATEGORIES.keys():
            (self.output_path / category).mkdir(exist_ok=True)
        (self.output_path / 'other').mkdir(exist_ok=True)
        
        # Copy unique files
        copied = 0
        for hash_val, file_info in self.unique_files.items():
            category = file_info['category']
            filename = file_info['filename']
            
            # Handle duplicate filenames within category
            dest_path = self.output_path / category / filename
            if dest_path.exists():
                # Add hash prefix to make unique
                stem = dest_path.stem
                suffix = dest_path.suffix
                dest_path = self.output_path / category / f"{stem}_{hash_val[:8]}{suffix}"
            
            # Write file
            with open(dest_path, 'w', encoding='utf-8', errors='replace') as f:
                f.write(file_info['content'])
            
            # Update path in metadata
            file_info['dataset_path'] = str(dest_path.relative_to(self.output_path))
            
            copied += 1
            if copied % 500 == 0:
                print(f"  Copied {copied:,} / {len(self.unique_files):,} files...")
        
        print(f"Copied {copied:,} unique files to dataset")
    
    def generate_index(self):
        """Generate dataset metadata index."""
        print(f"\n{'='*60}")
        print("PHASE 3: GENERATING INDEX")
        print(f"{'='*60}")
        
        # Create index without content (for quick reference)
        index = []
        for hash_val, file_info in self.unique_files.items():
            index.append({
                'hash': file_info['hash'],
                'original_path': file_info['path'],
                'dataset_path': file_info.get('dataset_path', ''),
                'filename': file_info['filename'],
                'extension': file_info['extension'],
                'size': file_info['size'],
                'category': file_info['category'],
            })
        
        # Save index
        index_path = self.output_path / 'index.json'
        with open(index_path, 'w', encoding='utf-8') as f:
            json.dump(index, f, indent=2)
        
        # Save stats
        stats_path = self.output_path / 'stats.json'
        with open(stats_path, 'w', encoding='utf-8') as f:
            json.dump(self.stats, f, indent=2)
        
        # Save duplicate report
        duplicates = []
        for hash_val, paths in self.content_hashes.items():
            if len(paths) > 1:
                duplicates.append({
                    'hash': hash_val,
                    'count': len(paths),
                    'paths': [str(p.relative_to(self.source_path)) for p in paths[:10]]
                })
        
        duplicates.sort(key=lambda x: -x['count'])
        dup_path = self.output_path / 'duplicates_report.json'
        with open(dup_path, 'w', encoding='utf-8') as f:
            json.dump(duplicates[:100], f, indent=2)
        
        print(f"Generated index.json ({len(index)} entries)")
        print(f"Generated stats.json")
        print(f"Generated duplicates_report.json")
    
    def print_summary(self):
        """Print final summary."""
        print(f"\n{'='*60}")
        print("DATASET BUILD COMPLETE")
        print(f"{'='*60}")
        print(f"\nOutput: {self.output_path}")
        print(f"\nStatistics:")
        print(f"  Total unique files: {self.stats['unique_files']:,}")
        print(f"  Duplicates removed: {self.stats['duplicates_removed']:,}")
        print(f"  Total size: {self.stats['total_size_bytes']/1024/1024:.2f} MB")
        
        print(f"\nBy Category:")
        for cat, count in sorted(self.stats['by_category'].items(), key=lambda x: -x[1]):
            print(f"  {cat:20s}: {count:,}")
        
        print(f"\nBy Extension:")
        for ext, count in sorted(self.stats['by_extension'].items(), key=lambda x: -x[1])[:10]:
            print(f"  {ext:10s}: {count:,}")
        
        print(f"\n{'='*60}\n")
    
    def build(self):
        """Run full dataset build pipeline."""
        print("\n" + "="*60)
        print("EVONY DATASET BUILDER")
        print("="*60)
        
        self.scan_files()
        self.organize_dataset()
        self.generate_index()
        self.print_summary()


def main():
    source_path = Path("c:/Users/Admin/Downloads/Evony_Decrypted")
    output_path = source_path / "Evony_Dataset"
    
    builder = EvonyDatasetBuilder(str(source_path), str(output_path))
    builder.build()


if __name__ == "__main__":
    main()
