# Evony RE Hub - External Scanner
"""
Scans external drives and locations for Evony-related content.
Identifies files that should be copied to the hub.
"""

import os
import json
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Set, Optional
from concurrent.futures import ThreadPoolExecutor, as_completed

from .config import HUB_ROOT, EXTERNAL_SOURCES, EVONY_KEYWORDS, CATEGORIES


class ExternalScanner:
    """Scans external locations for Evony-related content."""
    
    def __init__(self, hub_root: Path = HUB_ROOT):
        self.hub_root = hub_root
        self.scan_results: List[dict] = []
        self.evony_files: List[Path] = []
        
        # File extensions to scan
        self.scan_extensions = {
            '.py', '.ps1', '.bat', '.sh',  # Scripts
            '.md', '.txt', '.docx', '.pdf',  # Docs
            '.json', '.xml', '.csv', '.xlsx',  # Data
            '.as', '.swf', '.abc',  # Flash/AS3
            '.sol',  # Shared objects
            '.svg', '.png', '.jpg', '.gif',  # Graphics
            '.exe', '.jar', '.dll',  # Tools
        }
        
        # Directories to skip
        self.skip_dirs = {
            'node_modules', '.git', '__pycache__', '.venv', 'venv',
            'AppData', 'Windows', 'Program Files', 'Program Files (x86)',
            '$Recycle.Bin', 'System Volume Information',
        }
    
    def _is_evony_related(self, filepath: Path) -> tuple:
        """Check if file is Evony-related. Returns (is_related, keywords_found)."""
        name_lower = filepath.stem.lower()
        path_lower = str(filepath).lower()
        
        found_keywords = []
        
        # Check path and filename
        for keyword in EVONY_KEYWORDS:
            if keyword in name_lower or keyword in path_lower:
                found_keywords.append(keyword)
        
        # If filename matches, check content for more keywords
        if found_keywords or filepath.suffix.lower() in ['.py', '.md', '.txt', '.as']:
            try:
                with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                    content = f.read(50000).lower()
                    for keyword in EVONY_KEYWORDS:
                        if keyword in content and keyword not in found_keywords:
                            found_keywords.append(keyword)
            except:
                pass
        
        # Need at least 1 keyword in filename or 2+ in content
        is_related = len(found_keywords) >= 1
        return is_related, found_keywords
    
    def _should_skip_dir(self, dirpath: Path) -> bool:
        """Check if directory should be skipped."""
        name = dirpath.name
        if name.startswith('.') or name.startswith('$'):
            return True
        if name in self.skip_dirs:
            return True
        return False
    
    def scan_path(self, source_path: Path, max_depth: int = 10) -> List[dict]:
        """Scan a single path for Evony-related files."""
        results = []
        
        if not source_path.exists():
            print(f"  Path does not exist: {source_path}")
            return results
        
        print(f"  Scanning: {source_path}")
        file_count = 0
        
        try:
            for root, dirs, files in os.walk(source_path):
                root_path = Path(root)
                
                # Check depth
                try:
                    depth = len(root_path.relative_to(source_path).parts)
                    if depth > max_depth:
                        dirs.clear()
                        continue
                except:
                    pass
                
                # Filter directories
                dirs[:] = [d for d in dirs if not self._should_skip_dir(root_path / d)]
                
                for filename in files:
                    filepath = root_path / filename
                    
                    # Check extension
                    if filepath.suffix.lower() not in self.scan_extensions:
                        continue
                    
                    file_count += 1
                    if file_count % 500 == 0:
                        print(f"    Scanned {file_count} files...")
                    
                    # Check if Evony-related
                    is_related, keywords = self._is_evony_related(filepath)
                    
                    if is_related:
                        try:
                            stat = filepath.stat()
                            results.append({
                                'path': str(filepath),
                                'filename': filename,
                                'size': stat.st_size,
                                'modified': datetime.fromtimestamp(stat.st_mtime).isoformat(),
                                'keywords': keywords,
                                'source': str(source_path),
                            })
                        except:
                            pass
        
        except PermissionError:
            print(f"  Permission denied: {source_path}")
        except Exception as e:
            print(f"  Error scanning {source_path}: {e}")
        
        print(f"  Found {len(results)} Evony-related files in {file_count} scanned")
        return results
    
    def scan_all_sources(self) -> List[dict]:
        """Scan all configured external sources."""
        all_results = []
        
        print("Scanning external sources for Evony content...")
        
        for source in EXTERNAL_SOURCES:
            results = self.scan_path(source)
            all_results.extend(results)
        
        self.scan_results = all_results
        self.evony_files = [Path(r['path']) for r in all_results]
        
        return all_results
    
    def scan_drive(self, drive_letter: str, max_depth: int = 8) -> List[dict]:
        """Scan an entire drive for Evony content."""
        drive_path = Path(f"{drive_letter}:\\")
        
        if not drive_path.exists():
            print(f"Drive {drive_letter}: not found")
            return []
        
        print(f"Scanning drive {drive_letter}:...")
        return self.scan_path(drive_path, max_depth)
    
    def scan_all_drives(self) -> List[dict]:
        """Scan all available drives."""
        import string
        all_results = []
        
        for letter in string.ascii_uppercase:
            drive_path = Path(f"{letter}:\\")
            if drive_path.exists():
                try:
                    # Quick check if drive is accessible
                    list(drive_path.iterdir())
                    results = self.scan_drive(letter)
                    all_results.extend(results)
                except:
                    continue
        
        self.scan_results = all_results
        return all_results
    
    def get_summary(self) -> dict:
        """Get scan summary."""
        if not self.scan_results:
            return {'total': 0}
        
        summary = {
            'total': len(self.scan_results),
            'total_size': sum(r['size'] for r in self.scan_results),
            'by_source': {},
            'by_extension': {},
            'top_keywords': {},
        }
        
        for result in self.scan_results:
            # By source
            source = result['source']
            if source not in summary['by_source']:
                summary['by_source'][source] = 0
            summary['by_source'][source] += 1
            
            # By extension
            ext = Path(result['filename']).suffix.lower()
            if ext not in summary['by_extension']:
                summary['by_extension'][ext] = 0
            summary['by_extension'][ext] += 1
            
            # Keywords
            for kw in result['keywords']:
                if kw not in summary['top_keywords']:
                    summary['top_keywords'][kw] = 0
                summary['top_keywords'][kw] += 1
        
        return summary
    
    def save_results(self, filepath: Path = None):
        """Save scan results to file."""
        if filepath is None:
            filepath = self.hub_root / "evony_hub" / "scan_results.json"
        
        filepath.parent.mkdir(parents=True, exist_ok=True)
        
        data = {
            'scan_time': datetime.now().isoformat(),
            'summary': self.get_summary(),
            'files': self.scan_results,
        }
        
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2)
        
        print(f"Scan results saved to: {filepath}")
    
    def load_results(self, filepath: Path = None) -> List[dict]:
        """Load previous scan results."""
        if filepath is None:
            filepath = self.hub_root / "evony_hub" / "scan_results.json"
        
        if filepath.exists():
            with open(filepath, 'r', encoding='utf-8') as f:
                data = json.load(f)
                self.scan_results = data.get('files', [])
                return self.scan_results
        
        return []
    
    def filter_not_in_hub(self) -> List[dict]:
        """Filter results to files not already in hub."""
        from .indexer import EvonyIndexer
        
        indexer = EvonyIndexer(self.hub_root)
        existing_hashes = {e.hash for e in indexer.index.values()}
        
        import hashlib
        not_in_hub = []
        
        for result in self.scan_results:
            filepath = Path(result['path'])
            if filepath.exists():
                try:
                    with open(filepath, 'rb') as f:
                        file_hash = hashlib.md5(f.read()).hexdigest()
                    if file_hash not in existing_hashes:
                        result['hash'] = file_hash
                        not_in_hub.append(result)
                except:
                    pass
        
        return not_in_hub


def scan_and_report():
    """Scan all sources and generate report."""
    scanner = ExternalScanner()
    
    # Scan configured sources
    results = scanner.scan_all_sources()
    
    # Get files not in hub
    new_files = scanner.filter_not_in_hub()
    
    # Save results
    scanner.save_results()
    
    # Print summary
    summary = scanner.get_summary()
    print(f"\n=== Scan Summary ===")
    print(f"Total Evony-related files found: {summary['total']}")
    print(f"New files (not in hub): {len(new_files)}")
    print(f"\nBy source:")
    for source, count in summary['by_source'].items():
        print(f"  {source}: {count}")
    print(f"\nTop keywords:")
    sorted_kw = sorted(summary['top_keywords'].items(), key=lambda x: x[1], reverse=True)[:10]
    for kw, count in sorted_kw:
        print(f"  {kw}: {count}")
    
    return new_files


if __name__ == "__main__":
    scan_and_report()
