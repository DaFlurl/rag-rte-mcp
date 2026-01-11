# Evony RE Hub - Auto Organizer
"""
Automatically organizes files into proper categories.
Handles file movement, deduplication, and category assignment.
"""

import shutil
import hashlib
import re
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional, Tuple, Set

from .config import (
    HUB_ROOT, DATA_INBOX, CATEGORIES, EVONY_KEYWORDS,
    EXTENSION_CATEGORIES
)
from .indexer import EvonyIndexer, IndexEntry


class EvonyOrganizer:
    """Automatically organizes Evony-related files into proper locations."""
    
    def __init__(self, hub_root: Path = HUB_ROOT):
        self.hub_root = hub_root
        self.inbox = DATA_INBOX
        self.indexer = EvonyIndexer(hub_root)
        self.move_log: List[dict] = []
        
        # Ensure category directories exist
        self._ensure_directories()
    
    def _ensure_directories(self):
        """Create all category directories."""
        for cat_name, cat_info in CATEGORIES.items():
            cat_path = self.hub_root / cat_info['path']
            cat_path.mkdir(parents=True, exist_ok=True)
            
            # Create subcategory directories
            for subcat in cat_info.get('subcategories', {}).keys():
                (cat_path / subcat).mkdir(exist_ok=True)
        
        # Create inbox
        self.inbox.mkdir(parents=True, exist_ok=True)
    
    def _compute_hash(self, filepath: Path) -> str:
        """Compute MD5 hash of file."""
        try:
            with open(filepath, 'rb') as f:
                return hashlib.md5(f.read()).hexdigest()
        except:
            return ""
    
    def _is_evony_related(self, filepath: Path, content: str = "") -> bool:
        """Check if file is Evony-related."""
        name_lower = filepath.stem.lower()
        
        # Check filename
        for keyword in EVONY_KEYWORDS:
            if keyword in name_lower:
                return True
        
        # Check content
        content_lower = content.lower()
        evony_matches = sum(1 for kw in EVONY_KEYWORDS if kw in content_lower)
        return evony_matches >= 2  # At least 2 keyword matches
    
    def _read_content_preview(self, filepath: Path) -> str:
        """Read file content for analysis."""
        try:
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                return f.read(20000)
        except:
            return ""
    
    def _determine_category(self, filepath: Path, content: str = "") -> Tuple[str, str]:
        """Determine the best category and subcategory for a file."""
        ext = filepath.suffix.lower()
        name_lower = filepath.stem.lower()
        content_lower = content.lower()[:10000]
        
        best_category = EXTENSION_CATEGORIES.get(ext, "data")
        best_subcategory = ""
        best_score = 0
        
        for cat_name, cat_info in CATEGORIES.items():
            score = 0
            matched_subcat = ""
            
            # Extension match
            if ext in cat_info.get('extensions', []):
                score += 2
            
            # Keyword matches
            for kw in cat_info.get('keywords', []):
                if kw in name_lower:
                    score += 3
                if kw in content_lower:
                    score += 1
            
            # Subcategory matches
            for subcat, subkws in cat_info.get('subcategories', {}).items():
                for kw in subkws:
                    if kw in name_lower:
                        score += 2
                        matched_subcat = subcat
                    if kw in content_lower:
                        score += 0.5
                        if not matched_subcat:
                            matched_subcat = subcat
            
            if score > best_score:
                best_score = score
                best_category = cat_name
                best_subcategory = matched_subcat
        
        return best_category, best_subcategory
    
    def _find_duplicates(self, filepath: Path) -> List[Path]:
        """Find duplicate files in the hub."""
        file_hash = self._compute_hash(filepath)
        duplicates = []
        
        for entry in self.indexer.index.values():
            if entry.hash == file_hash:
                dup_path = self.hub_root / entry.path
                if dup_path.exists() and dup_path != filepath:
                    duplicates.append(dup_path)
        
        return duplicates
    
    def _generate_unique_name(self, target_dir: Path, filename: str) -> Path:
        """Generate unique filename if collision exists."""
        target = target_dir / filename
        if not target.exists():
            return target
        
        stem = Path(filename).stem
        suffix = Path(filename).suffix
        counter = 1
        
        while target.exists():
            new_name = f"{stem}_{counter}{suffix}"
            target = target_dir / new_name
            counter += 1
        
        return target
    
    def organize_file(self, filepath: Path, copy: bool = False, 
                      force: bool = False) -> Optional[Path]:
        """Organize a single file into the proper location."""
        if not filepath.exists():
            return None
        
        # Read content for analysis
        content = self._read_content_preview(filepath)
        
        # Check if Evony-related (if from external source)
        if not filepath.is_relative_to(self.hub_root):
            if not self._is_evony_related(filepath, content):
                return None
        
        # Determine category
        category, subcategory = self._determine_category(filepath, content)
        
        # Build target path
        cat_info = CATEGORIES.get(category, CATEGORIES['data'])
        target_dir = self.hub_root / cat_info['path']
        if subcategory:
            target_dir = target_dir / subcategory
        target_dir.mkdir(parents=True, exist_ok=True)
        
        # Check for duplicates
        if not force:
            duplicates = self._find_duplicates(filepath)
            if duplicates:
                self.move_log.append({
                    'action': 'skipped_duplicate',
                    'source': str(filepath),
                    'duplicates': [str(d) for d in duplicates],
                    'timestamp': datetime.now().isoformat()
                })
                return None
        
        # Generate target path
        target_path = self._generate_unique_name(target_dir, filepath.name)
        
        # Move or copy
        try:
            if copy:
                shutil.copy2(filepath, target_path)
                action = 'copied'
            else:
                shutil.move(str(filepath), str(target_path))
                action = 'moved'
            
            self.move_log.append({
                'action': action,
                'source': str(filepath),
                'target': str(target_path),
                'category': category,
                'subcategory': subcategory,
                'timestamp': datetime.now().isoformat()
            })
            
            # Index the new file
            self.indexer.index_file(target_path)
            
            return target_path
            
        except Exception as e:
            self.move_log.append({
                'action': 'error',
                'source': str(filepath),
                'error': str(e),
                'timestamp': datetime.now().isoformat()
            })
            return None
    
    def organize_directory(self, source_dir: Path, copy: bool = True,
                          recursive: bool = True) -> Dict[str, int]:
        """Organize all files from a directory."""
        stats = {'processed': 0, 'organized': 0, 'skipped': 0, 'errors': 0}
        pattern = "**/*" if recursive else "*"
        
        for filepath in source_dir.glob(pattern):
            if not filepath.is_file():
                continue
            
            # Skip hidden and temp files
            if filepath.name.startswith('.') or filepath.name.startswith('~'):
                continue
            
            stats['processed'] += 1
            result = self.organize_file(filepath, copy=copy)
            
            if result:
                stats['organized'] += 1
            else:
                # Check if it was a duplicate or error
                if self.move_log and self.move_log[-1].get('action') == 'error':
                    stats['errors'] += 1
                else:
                    stats['skipped'] += 1
            
            if stats['processed'] % 50 == 0:
                print(f"Processed {stats['processed']} files...")
        
        # Save index
        self.indexer._save_index()
        
        return stats
    
    def process_inbox(self) -> Dict[str, int]:
        """Process all files in the inbox."""
        if not self.inbox.exists():
            return {'processed': 0}
        
        return self.organize_directory(self.inbox, copy=False, recursive=True)
    
    def reorganize_hub(self) -> Dict[str, int]:
        """Reorganize existing files in the hub."""
        stats = {'checked': 0, 'moved': 0}
        
        for entry in list(self.indexer.index.values()):
            filepath = self.hub_root / entry.path
            if not filepath.exists():
                continue
            
            stats['checked'] += 1
            content = self._read_content_preview(filepath)
            new_cat, new_subcat = self._determine_category(filepath, content)
            
            # Check if needs moving
            if new_cat != entry.category or new_subcat != entry.subcategory:
                cat_info = CATEGORIES.get(new_cat, CATEGORIES['data'])
                target_dir = self.hub_root / cat_info['path']
                if new_subcat:
                    target_dir = target_dir / new_subcat
                
                if not filepath.parent.samefile(target_dir):
                    target_dir.mkdir(parents=True, exist_ok=True)
                    target_path = self._generate_unique_name(target_dir, filepath.name)
                    
                    try:
                        shutil.move(str(filepath), str(target_path))
                        stats['moved'] += 1
                        
                        # Update index
                        del self.indexer.index[entry.path]
                        self.indexer.index_file(target_path)
                    except Exception as e:
                        print(f"Error moving {filepath}: {e}")
        
        self.indexer._save_index()
        return stats
    
    def get_move_log(self) -> List[dict]:
        """Get the move log."""
        return self.move_log
    
    def save_move_log(self, filepath: Path = None):
        """Save move log to file."""
        if filepath is None:
            filepath = self.hub_root / "evony_hub" / "move_log.json"
        
        import json
        filepath.parent.mkdir(parents=True, exist_ok=True)
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(self.move_log, f, indent=2)


def organize_from_source(source: Path, hub_root: Path = HUB_ROOT) -> Dict[str, int]:
    """Convenience function to organize files from an external source."""
    organizer = EvonyOrganizer(hub_root)
    print(f"Organizing from {source}...")
    stats = organizer.organize_directory(source, copy=True)
    organizer.save_move_log()
    print(f"Results: {stats}")
    return stats


if __name__ == "__main__":
    # Process inbox
    organizer = EvonyOrganizer()
    stats = organizer.process_inbox()
    print(f"Inbox processing: {stats}")
