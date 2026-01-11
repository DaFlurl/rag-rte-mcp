"""
Evony AI Data Collector
========================
Collects and structures all Evony-related data for training.
"""

import os
import json
import hashlib
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional
import chardet
from tqdm import tqdm

# Data categories
CATEGORIES = {
    'source_code': {
        'extensions': ['.as', '.py', '.js', '.ts'],
        'description': 'ActionScript, Python, JavaScript source code'
    },
    'scripts': {
        'extensions': ['.txt'],
        'patterns': ['script', 'glitch', 'attack', 'troop'],
        'description': 'AutoEvony automation scripts'
    },
    'documentation': {
        'extensions': ['.md', '.rst', '.html'],
        'description': 'Technical documentation'
    },
    'protocol': {
        'patterns': ['protocol', 'command', 'amf', 'packet'],
        'description': 'Network protocol data'
    },
    'exploits': {
        'patterns': ['exploit', 'glitch', 'overflow', 'hack'],
        'description': 'Exploit and glitch information'
    },
    'keys': {
        'patterns': ['key', 'encrypt', 'decrypt', 'hash', 'signature'],
        'description': 'Encryption keys and algorithms'
    },
    'game_data': {
        'patterns': ['troop', 'resource', 'building', 'hero', 'quest'],
        'description': 'Game mechanics data'
    }
}

class EvonyDataCollector:
    def __init__(self, base_path: str, output_path: str):
        self.base_path = Path(base_path)
        self.output_path = Path(output_path)
        self.output_path.mkdir(parents=True, exist_ok=True)
        
        self.stats = {
            'total_files': 0,
            'processed_files': 0,
            'skipped_files': 0,
            'categories': {cat: 0 for cat in CATEGORIES},
            'total_size_bytes': 0,
            'errors': []
        }
        
        self.collected_data = []
    
    def detect_encoding(self, file_path: Path) -> str:
        """Detect file encoding."""
        try:
            with open(file_path, 'rb') as f:
                raw = f.read(10000)
                result = chardet.detect(raw)
                return result.get('encoding', 'utf-8') or 'utf-8'
        except:
            return 'utf-8'
    
    def read_file_safely(self, file_path: Path) -> Optional[str]:
        """Read file with encoding detection."""
        try:
            encoding = self.detect_encoding(file_path)
            with open(file_path, 'r', encoding=encoding, errors='replace') as f:
                return f.read()
        except Exception as e:
            self.stats['errors'].append(f"{file_path}: {str(e)}")
            return None
    
    def categorize_file(self, file_path: Path, content: str) -> List[str]:
        """Categorize file based on extension, path, and content."""
        categories = []
        ext = file_path.suffix.lower()
        path_lower = str(file_path).lower()
        content_lower = content.lower() if content else ''
        
        for cat_name, cat_info in CATEGORIES.items():
            # Check extension
            if 'extensions' in cat_info and ext in cat_info['extensions']:
                categories.append(cat_name)
                continue
            
            # Check path/content patterns
            if 'patterns' in cat_info:
                for pattern in cat_info['patterns']:
                    if pattern in path_lower or pattern in content_lower[:2000]:
                        categories.append(cat_name)
                        break
        
        return categories if categories else ['other']
    
    def extract_metadata(self, file_path: Path, content: str) -> Dict:
        """Extract useful metadata from file."""
        metadata = {
            'path': str(file_path.relative_to(self.base_path)),
            'filename': file_path.name,
            'extension': file_path.suffix,
            'size_bytes': file_path.stat().st_size,
            'lines': content.count('\n') + 1 if content else 0,
            'hash': hashlib.md5(content.encode()).hexdigest() if content else None
        }
        
        # Extract specific patterns for Evony data
        if content:
            # Look for command patterns
            if 'troop.' in content or 'army.' in content or 'shop.' in content:
                metadata['has_commands'] = True
            
            # Look for encryption keys
            if 'ACTION_KEY' in content or 'API_KEY' in content:
                metadata['has_keys'] = True
            
            # Look for glitch data
            if 'overflow' in content.lower() or 'glitch' in content.lower():
                metadata['has_exploits'] = True
        
        return metadata
    
    def should_skip(self, file_path: Path) -> bool:
        """Check if file should be skipped."""
        skip_patterns = [
            '__pycache__', 'node_modules', '.git', '.venv',
            'Electron_Browser', 'Macromedia', '.exe', '.dll',
            '.swf', '.zip', '.rar', '.xlsx', '.xls', '.docx',
            '.pdf', '.jpg', '.png', '.gif', '.ico', '.woff'
        ]
        path_str = str(file_path)
        return any(pattern in path_str for pattern in skip_patterns)
    
    def collect_all(self):
        """Collect all relevant data from the base path."""
        print(f"\n{'='*60}")
        print("EVONY AI DATA COLLECTOR")
        print(f"{'='*60}")
        print(f"Source: {self.base_path}")
        print(f"Output: {self.output_path}")
        print(f"{'='*60}\n")
        
        # Gather all files first
        all_files = []
        for file_path in self.base_path.rglob('*'):
            if file_path.is_file() and not self.should_skip(file_path):
                all_files.append(file_path)
        
        self.stats['total_files'] = len(all_files)
        print(f"Found {len(all_files)} files to process\n")
        
        # Process files with progress bar
        for file_path in tqdm(all_files, desc="Processing files"):
            content = self.read_file_safely(file_path)
            
            if content is None:
                self.stats['skipped_files'] += 1
                continue
            
            # Skip very large or binary-looking files
            if len(content) > 500000 or '\x00' in content[:1000]:
                self.stats['skipped_files'] += 1
                continue
            
            categories = self.categorize_file(file_path, content)
            metadata = self.extract_metadata(file_path, content)
            
            record = {
                'id': self.stats['processed_files'],
                'categories': categories,
                'metadata': metadata,
                'content': content
            }
            
            self.collected_data.append(record)
            self.stats['processed_files'] += 1
            self.stats['total_size_bytes'] += metadata['size_bytes']
            
            for cat in categories:
                if cat in self.stats['categories']:
                    self.stats['categories'][cat] += 1
        
        self.save_data()
        self.print_summary()
    
    def save_data(self):
        """Save collected data to output directory."""
        # Save raw data in chunks (avoid memory issues)
        chunk_size = 1000
        for i in range(0, len(self.collected_data), chunk_size):
            chunk = self.collected_data[i:i+chunk_size]
            chunk_file = self.output_path / f"raw_data_{i//chunk_size:04d}.json"
            with open(chunk_file, 'w', encoding='utf-8') as f:
                json.dump(chunk, f, indent=2, ensure_ascii=False)
        
        # Save stats
        stats_file = self.output_path / "collection_stats.json"
        self.stats['collection_time'] = datetime.now().isoformat()
        with open(stats_file, 'w', encoding='utf-8') as f:
            json.dump(self.stats, f, indent=2)
        
        # Save category index
        index = {}
        for record in self.collected_data:
            for cat in record['categories']:
                if cat not in index:
                    index[cat] = []
                index[cat].append({
                    'id': record['id'],
                    'path': record['metadata']['path']
                })
        
        index_file = self.output_path / "category_index.json"
        with open(index_file, 'w', encoding='utf-8') as f:
            json.dump(index, f, indent=2)
    
    def print_summary(self):
        """Print collection summary."""
        print(f"\n{'='*60}")
        print("COLLECTION SUMMARY")
        print(f"{'='*60}")
        print(f"Total files found:     {self.stats['total_files']:,}")
        print(f"Files processed:       {self.stats['processed_files']:,}")
        print(f"Files skipped:         {self.stats['skipped_files']:,}")
        print(f"Total size:            {self.stats['total_size_bytes']/1024/1024:.2f} MB")
        print(f"\nCategory breakdown:")
        for cat, count in sorted(self.stats['categories'].items(), key=lambda x: -x[1]):
            if count > 0:
                print(f"  {cat:20s}: {count:,}")
        print(f"\nErrors: {len(self.stats['errors'])}")
        print(f"{'='*60}\n")


def main():
    base_path = Path(__file__).parent.parent.parent  # Evony_Decrypted
    output_path = Path(__file__).parent.parent / "data" / "raw"
    
    collector = EvonyDataCollector(str(base_path), str(output_path))
    collector.collect_all()
    
    print("Data collection complete!")
    print(f"Output saved to: {output_path}")


if __name__ == "__main__":
    main()
