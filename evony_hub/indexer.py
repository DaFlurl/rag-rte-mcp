# Evony RE Hub - Indexer System
"""
Automated indexing system that catalogs all Evony-related resources.
Maintains a searchable index with tags, categories, and relationships.
"""

import json
import hashlib
import os
import re
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional, Set, Tuple
from dataclasses import dataclass, asdict, field

from .config import (
    HUB_ROOT, INDEX_DB, CATEGORIES, EVONY_KEYWORDS,
    EXTENSION_CATEGORIES
)


@dataclass
class IndexEntry:
    """Single indexed file entry."""
    path: str
    filename: str
    category: str
    subcategory: str
    tags: List[str]
    size: int
    hash: str
    modified: str
    indexed: str
    description: str = ""
    related: List[str] = field(default_factory=list)
    
    def to_dict(self) -> dict:
        return asdict(self)
    
    @classmethod
    def from_dict(cls, data: dict) -> "IndexEntry":
        return cls(**data)


class EvonyIndexer:
    """Main indexing system for Evony RE resources."""
    
    def __init__(self, hub_root: Path = HUB_ROOT):
        self.hub_root = hub_root
        self.index_file = INDEX_DB
        self.index: Dict[str, IndexEntry] = {}
        self.tag_index: Dict[str, Set[str]] = {}  # tag -> set of paths
        self.category_index: Dict[str, Set[str]] = {}  # category -> set of paths
        self._load_index()
    
    def _load_index(self):
        """Load existing index from disk."""
        if self.index_file.exists():
            try:
                with open(self.index_file, 'r', encoding='utf-8') as f:
                    data = json.load(f)
                    for path, entry_data in data.get('entries', {}).items():
                        self.index[path] = IndexEntry.from_dict(entry_data)
                    self._rebuild_secondary_indexes()
            except Exception as e:
                print(f"Warning: Could not load index: {e}")
                self.index = {}
    
    def _save_index(self):
        """Save index to disk."""
        self.index_file.parent.mkdir(parents=True, exist_ok=True)
        data = {
            'version': '1.0',
            'updated': datetime.now().isoformat(),
            'total_entries': len(self.index),
            'entries': {path: entry.to_dict() for path, entry in self.index.items()}
        }
        with open(self.index_file, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2)
    
    def _rebuild_secondary_indexes(self):
        """Rebuild tag and category indexes from main index."""
        self.tag_index.clear()
        self.category_index.clear()
        
        for path, entry in self.index.items():
            # Tag index
            for tag in entry.tags:
                if tag not in self.tag_index:
                    self.tag_index[tag] = set()
                self.tag_index[tag].add(path)
            
            # Category index
            if entry.category not in self.category_index:
                self.category_index[entry.category] = set()
            self.category_index[entry.category].add(path)
    
    def _compute_hash(self, filepath: Path) -> str:
        """Compute MD5 hash of file."""
        try:
            with open(filepath, 'rb') as f:
                return hashlib.md5(f.read()).hexdigest()
        except:
            return ""
    
    def _extract_tags(self, filepath: Path, content: str = "") -> List[str]:
        """Extract relevant tags from filename and content."""
        tags = set()
        name_lower = filepath.stem.lower()
        
        # Check for Evony keywords
        for keyword in EVONY_KEYWORDS:
            if keyword in name_lower or keyword in content.lower():
                tags.add(keyword)
        
        # Check category keywords
        for cat_name, cat_info in CATEGORIES.items():
            for kw in cat_info.get('keywords', []):
                if kw in name_lower:
                    tags.add(kw)
            for subcat, subkws in cat_info.get('subcategories', {}).items():
                for kw in subkws:
                    if kw in name_lower:
                        tags.add(subcat)
        
        # Add extension-based tag
        ext = filepath.suffix.lower()
        if ext:
            tags.add(ext[1:])  # Remove dot
        
        return sorted(tags)
    
    def _determine_category(self, filepath: Path, content: str = "") -> Tuple[str, str]:
        """Determine category and subcategory for a file."""
        ext = filepath.suffix.lower()
        name_lower = filepath.stem.lower()
        
        # First check by extension
        base_category = EXTENSION_CATEGORIES.get(ext, "data")
        
        # Refine by content/filename analysis
        for cat_name, cat_info in CATEGORIES.items():
            # Check keywords
            for kw in cat_info.get('keywords', []):
                if kw in name_lower or kw in content.lower()[:5000]:
                    base_category = cat_name
                    break
            
            # Check subcategories
            for subcat, subkws in cat_info.get('subcategories', {}).items():
                for kw in subkws:
                    if kw in name_lower:
                        return cat_name, subcat
        
        return base_category, ""
    
    def _read_file_preview(self, filepath: Path, max_bytes: int = 10000) -> str:
        """Read beginning of file for content analysis."""
        try:
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                return f.read(max_bytes)
        except:
            return ""
    
    def index_file(self, filepath: Path, force: bool = False) -> Optional[IndexEntry]:
        """Index a single file."""
        if not filepath.exists() or not filepath.is_file():
            return None
        
        path_str = str(filepath.relative_to(self.hub_root) if filepath.is_relative_to(self.hub_root) else filepath)
        
        # Check if already indexed and unchanged
        if not force and path_str in self.index:
            existing = self.index[path_str]
            current_hash = self._compute_hash(filepath)
            if existing.hash == current_hash:
                return existing
        
        # Read content preview for analysis
        content = self._read_file_preview(filepath)
        
        # Determine category
        category, subcategory = self._determine_category(filepath, content)
        
        # Extract tags
        tags = self._extract_tags(filepath, content)
        
        # Create entry
        entry = IndexEntry(
            path=path_str,
            filename=filepath.name,
            category=category,
            subcategory=subcategory,
            tags=tags,
            size=filepath.stat().st_size,
            hash=self._compute_hash(filepath),
            modified=datetime.fromtimestamp(filepath.stat().st_mtime).isoformat(),
            indexed=datetime.now().isoformat(),
        )
        
        self.index[path_str] = entry
        return entry
    
    def index_directory(self, directory: Path, recursive: bool = True) -> int:
        """Index all files in a directory."""
        count = 0
        pattern = "**/*" if recursive else "*"
        
        for filepath in directory.glob(pattern):
            if filepath.is_file():
                # Skip certain files
                if filepath.name.startswith('.') or filepath.suffix in ['.pyc', '.pyo']:
                    continue
                
                entry = self.index_file(filepath)
                if entry:
                    count += 1
                    if count % 100 == 0:
                        print(f"Indexed {count} files...")
        
        self._rebuild_secondary_indexes()
        self._save_index()
        return count
    
    def search(self, query: str, category: str = None, tags: List[str] = None) -> List[IndexEntry]:
        """Search the index."""
        results = []
        query_lower = query.lower()
        
        for path, entry in self.index.items():
            # Category filter
            if category and entry.category != category:
                continue
            
            # Tag filter
            if tags and not all(t in entry.tags for t in tags):
                continue
            
            # Query match
            if query_lower:
                if (query_lower in entry.filename.lower() or
                    query_lower in entry.path.lower() or
                    any(query_lower in t for t in entry.tags)):
                    results.append(entry)
            else:
                results.append(entry)
        
        return results
    
    def get_by_category(self, category: str) -> List[IndexEntry]:
        """Get all entries in a category."""
        paths = self.category_index.get(category, set())
        return [self.index[p] for p in paths if p in self.index]
    
    def get_by_tag(self, tag: str) -> List[IndexEntry]:
        """Get all entries with a specific tag."""
        paths = self.tag_index.get(tag, set())
        return [self.index[p] for p in paths if p in self.index]
    
    def get_related(self, entry: IndexEntry, max_results: int = 10) -> List[IndexEntry]:
        """Find related entries based on tags."""
        scores: Dict[str, int] = {}
        
        for tag in entry.tags:
            for path in self.tag_index.get(tag, []):
                if path != entry.path:
                    scores[path] = scores.get(path, 0) + 1
        
        # Sort by score
        sorted_paths = sorted(scores.keys(), key=lambda p: scores[p], reverse=True)
        return [self.index[p] for p in sorted_paths[:max_results]]
    
    def get_statistics(self) -> dict:
        """Get index statistics."""
        stats = {
            'total_files': len(self.index),
            'total_size': sum(e.size for e in self.index.values()),
            'categories': {},
            'top_tags': {},
        }
        
        for cat, paths in self.category_index.items():
            stats['categories'][cat] = len(paths)
        
        tag_counts = [(tag, len(paths)) for tag, paths in self.tag_index.items()]
        tag_counts.sort(key=lambda x: x[1], reverse=True)
        stats['top_tags'] = dict(tag_counts[:20])
        
        return stats
    
    def remove_missing(self) -> int:
        """Remove entries for files that no longer exist."""
        removed = 0
        to_remove = []
        
        for path in self.index:
            full_path = self.hub_root / path
            if not full_path.exists():
                to_remove.append(path)
        
        for path in to_remove:
            del self.index[path]
            removed += 1
        
        if removed:
            self._rebuild_secondary_indexes()
            self._save_index()
        
        return removed


def build_full_index() -> EvonyIndexer:
    """Build complete index of the hub."""
    indexer = EvonyIndexer()
    print(f"Indexing {HUB_ROOT}...")
    count = indexer.index_directory(HUB_ROOT)
    print(f"Indexed {count} files")
    stats = indexer.get_statistics()
    print(f"Categories: {stats['categories']}")
    return indexer


if __name__ == "__main__":
    build_full_index()
