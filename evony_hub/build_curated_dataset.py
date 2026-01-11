"""
Evony Curated Dataset Builder
==============================
Builds the final training dataset using only approved files
from the data curation report.
"""

import os
import json
import shutil
from pathlib import Path
from datetime import datetime
from typing import Dict, List

from .config import HUB_ROOT


# Dataset structure
DATASET_CATEGORIES = {
    'source_code': 'AS3/Python/JS source files',
    'documentation': 'Protocol docs, guides, README files',
    'exploits': 'Glitch documentation and exploit code',
    'scripts': 'Bot automation scripts',
    'keys': 'Encryption keys and algorithms',
    'protocol': 'Protocol specifications and commands',
    'game_data': 'Game mechanics data',
    'tools': 'Analysis and utility tools',
}


class CuratedDatasetBuilder:
    """Builds dataset from approved files only."""
    
    def __init__(self, source_path: Path = HUB_ROOT):
        self.source_path = source_path
        self.output_path = source_path / "Evony_Training_Dataset"
        self.curation_report = source_path / "DATA_CURATION_REPORT.json"
        
        self.approved_files: List[dict] = []
        self.stats = {
            'files_copied': 0,
            'files_failed': 0,
            'total_size': 0,
            'by_category': {},
            'by_quality': {},
        }
    
    def load_approved_files(self) -> int:
        """Load approved files from curation report."""
        if not self.curation_report.exists():
            raise FileNotFoundError(f"Curation report not found: {self.curation_report}")
        
        with open(self.curation_report, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        self.approved_files = data.get('approved', [])
        print(f"Loaded {len(self.approved_files)} approved files from curation report")
        return len(self.approved_files)
    
    def create_structure(self):
        """Create dataset folder structure."""
        # Clean existing dataset folder
        if self.output_path.exists():
            shutil.rmtree(self.output_path)
        
        self.output_path.mkdir(parents=True)
        
        for category, description in DATASET_CATEGORIES.items():
            (self.output_path / category).mkdir()
            self.stats['by_category'][category] = 0
        
        print(f"Created dataset structure at: {self.output_path}")
    
    def _map_content_type_to_category(self, content_type: str) -> str:
        """Map content type to dataset category."""
        mapping = {
            'source_code': 'source_code',
            'documentation': 'documentation',
            'protocol': 'protocol',
            'exploit': 'exploits',
            'script': 'scripts',
            'keys': 'keys',
            'game_data': 'game_data',
            'tool': 'tools',
            'unknown': 'source_code',
        }
        return mapping.get(content_type, 'source_code')
    
    def _read_file_safely(self, path: Path) -> str:
        """Read file with encoding detection."""
        for encoding in ['utf-8', 'latin-1', 'cp1252']:
            try:
                with open(path, 'r', encoding=encoding, errors='strict') as f:
                    return f.read()
            except (UnicodeDecodeError, UnicodeError):
                continue
        
        with open(path, 'r', encoding='utf-8', errors='replace') as f:
            return f.read()
    
    def copy_approved_files(self):
        """Copy all approved files to dataset."""
        print(f"\nCopying {len(self.approved_files)} approved files...")
        
        copied = 0
        failed = 0
        
        for file_info in self.approved_files:
            rel_path = file_info['path']
            source_file = self.source_path / rel_path
            
            if not source_file.exists():
                failed += 1
                continue
            
            # Determine category
            content_type = file_info.get('content_type', 'source_code')
            category = self._map_content_type_to_category(content_type)
            
            # Generate unique filename
            filename = source_file.name
            dest_dir = self.output_path / category
            dest_file = dest_dir / filename
            
            # Handle duplicates
            if dest_file.exists():
                stem = source_file.stem
                suffix = source_file.suffix
                counter = 1
                while dest_file.exists():
                    dest_file = dest_dir / f"{stem}_{counter}{suffix}"
                    counter += 1
            
            try:
                # Read and write with consistent encoding
                content = self._read_file_safely(source_file)
                with open(dest_file, 'w', encoding='utf-8', errors='replace') as f:
                    f.write(content)
                
                copied += 1
                self.stats['total_size'] += len(content)
                self.stats['by_category'][category] = self.stats['by_category'].get(category, 0) + 1
                
                quality = file_info.get('quality_rating', 'UNKNOWN')
                self.stats['by_quality'][quality] = self.stats['by_quality'].get(quality, 0) + 1
                
                if copied % 500 == 0:
                    print(f"  Copied {copied} files...")
                    
            except Exception as e:
                failed += 1
        
        self.stats['files_copied'] = copied
        self.stats['files_failed'] = failed
        
        print(f"\nCopied {copied} files, {failed} failed")
    
    def generate_manifest(self):
        """Generate dataset manifest and README."""
        # Manifest JSON
        manifest = {
            'name': 'Evony Training Dataset',
            'version': '1.0',
            'created': datetime.now().isoformat(),
            'description': 'Curated, deduplicated dataset for Evony AI training',
            'stats': self.stats,
            'categories': DATASET_CATEGORIES,
        }
        
        manifest_path = self.output_path / "manifest.json"
        with open(manifest_path, 'w', encoding='utf-8') as f:
            json.dump(manifest, f, indent=2)
        
        # README
        readme = f"""# Evony Training Dataset

**Generated**: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}

## Summary

| Metric | Value |
|--------|-------|
| Total Files | {self.stats['files_copied']:,} |
| Total Size | {self.stats['total_size']/1024/1024:.2f} MB |
| Failed | {self.stats['files_failed']} |

## Quality Distribution

| Rating | Count |
|--------|-------|
"""
        for rating, count in sorted(self.stats['by_quality'].items(), key=lambda x: -x[1]):
            readme += f"| {rating} | {count:,} |\n"
        
        readme += """
## Categories

| Category | Files | Description |
|----------|-------|-------------|
"""
        for cat, count in sorted(self.stats['by_category'].items(), key=lambda x: -x[1]):
            desc = DATASET_CATEGORIES.get(cat, '')
            readme += f"| {cat} | {count:,} | {desc} |\n"
        
        readme += """
## Structure

```
Evony_Training_Dataset/
├── source_code/      # AS3/Python source files
├── documentation/    # Protocol docs, guides
├── exploits/         # Glitch documentation
├── scripts/          # Bot scripts
├── keys/             # Encryption keys
├── protocol/         # Protocol specs
├── game_data/        # Game mechanics
├── tools/            # Analysis tools
├── manifest.json     # Dataset metadata
└── README.md         # This file
```

## Usage

This dataset is ready for conversion to training format:
- Instruction/response pairs for fine-tuning
- Code completion training
- Protocol understanding

## Data Quality

All files in this dataset have been:
- ✅ Evaluated for Evony relevance
- ✅ Checked for completeness
- ✅ Deduplicated by content hash
- ✅ Filtered for quality (ACCEPTABLE or higher)
- ✅ Screened for personal notes/junk
"""
        
        readme_path = self.output_path / "README.md"
        with open(readme_path, 'w', encoding='utf-8') as f:
            f.write(readme)
        
        print(f"Generated manifest.json and README.md")
    
    def print_summary(self):
        """Print final summary."""
        print("\n" + "="*60)
        print("CURATED DATASET BUILD COMPLETE")
        print("="*60)
        print(f"\nOutput: {self.output_path}")
        print(f"\nFiles copied: {self.stats['files_copied']:,}")
        print(f"Total size: {self.stats['total_size']/1024/1024:.2f} MB")
        
        print(f"\nBy Category:")
        for cat, count in sorted(self.stats['by_category'].items(), key=lambda x: -x[1]):
            if count > 0:
                print(f"  {cat:15s}: {count:,}")
        
        print(f"\nBy Quality:")
        for rating, count in sorted(self.stats['by_quality'].items(), key=lambda x: -x[1]):
            print(f"  {rating:12s}: {count:,}")
        
        print(f"\n{'='*60}\n")
    
    def build(self):
        """Run the full build pipeline."""
        print("\n" + "="*60)
        print("BUILDING CURATED EVONY TRAINING DATASET")
        print("="*60)
        
        self.load_approved_files()
        self.create_structure()
        self.copy_approved_files()
        self.generate_manifest()
        self.print_summary()
        
        return self.stats


def build_curated_dataset():
    """Build the curated dataset."""
    builder = CuratedDatasetBuilder()
    return builder.build()


if __name__ == "__main__":
    build_curated_dataset()
