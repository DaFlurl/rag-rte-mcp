#!/usr/bin/env python3
"""
Evony Hub - Batch Operations
Mass file operations: rename, convert, organize, export.
"""

import shutil
import json
from pathlib import Path
from typing import List, Dict, Optional, Callable
from dataclasses import dataclass
from datetime import datetime
import re


@dataclass
class BatchResult:
    """Result of a batch operation."""
    total: int
    success: int
    failed: int
    errors: List[str]


class BatchRenamer:
    """Batch file renaming operations."""
    
    @staticmethod
    def rename_pattern(files: List[Path], pattern: str, replacement: str,
                       dry_run: bool = True) -> BatchResult:
        """
        Rename files using regex pattern.
        
        Args:
            files: List of files to rename
            pattern: Regex pattern to match
            replacement: Replacement string
            dry_run: If True, don't actually rename
        """
        result = BatchResult(total=len(files), success=0, failed=0, errors=[])
        
        for filepath in files:
            try:
                new_name = re.sub(pattern, replacement, filepath.name)
                if new_name != filepath.name:
                    new_path = filepath.parent / new_name
                    if not dry_run:
                        filepath.rename(new_path)
                    result.success += 1
            except Exception as e:
                result.failed += 1
                result.errors.append(f"{filepath.name}: {e}")
        
        return result
    
    @staticmethod
    def add_prefix(files: List[Path], prefix: str, 
                   dry_run: bool = True) -> BatchResult:
        """Add prefix to all filenames."""
        return BatchRenamer.rename_pattern(
            files, r'^', prefix, dry_run
        )
    
    @staticmethod
    def add_suffix(files: List[Path], suffix: str,
                   dry_run: bool = True) -> BatchResult:
        """Add suffix before extension."""
        result = BatchResult(total=len(files), success=0, failed=0, errors=[])
        
        for filepath in files:
            try:
                new_name = f"{filepath.stem}{suffix}{filepath.suffix}"
                new_path = filepath.parent / new_name
                if not dry_run:
                    filepath.rename(new_path)
                result.success += 1
            except Exception as e:
                result.failed += 1
                result.errors.append(f"{filepath.name}: {e}")
        
        return result


class BatchOrganizer:
    """Batch file organization operations."""
    
    @staticmethod
    def organize_by_extension(files: List[Path], target_dir: Path,
                              dry_run: bool = True) -> BatchResult:
        """Organize files into folders by extension."""
        result = BatchResult(total=len(files), success=0, failed=0, errors=[])
        
        for filepath in files:
            try:
                ext = filepath.suffix.lower().lstrip('.') or 'no_extension'
                dest_dir = target_dir / ext
                
                if not dry_run:
                    dest_dir.mkdir(parents=True, exist_ok=True)
                    shutil.copy2(filepath, dest_dir / filepath.name)
                
                result.success += 1
            except Exception as e:
                result.failed += 1
                result.errors.append(f"{filepath.name}: {e}")
        
        return result
    
    @staticmethod
    def organize_by_date(files: List[Path], target_dir: Path,
                         dry_run: bool = True) -> BatchResult:
        """Organize files into folders by modification date."""
        result = BatchResult(total=len(files), success=0, failed=0, errors=[])
        
        for filepath in files:
            try:
                mtime = datetime.fromtimestamp(filepath.stat().st_mtime)
                date_folder = mtime.strftime('%Y-%m')
                dest_dir = target_dir / date_folder
                
                if not dry_run:
                    dest_dir.mkdir(parents=True, exist_ok=True)
                    shutil.copy2(filepath, dest_dir / filepath.name)
                
                result.success += 1
            except Exception as e:
                result.failed += 1
                result.errors.append(f"{filepath.name}: {e}")
        
        return result


class BatchExporter:
    """Batch export operations."""
    
    @staticmethod
    def export_file_list(files: List[Path], output_file: Path,
                         format: str = 'json') -> bool:
        """Export list of files to JSON or text."""
        try:
            if format == 'json':
                data = [
                    {
                        'path': str(f),
                        'name': f.name,
                        'size': f.stat().st_size if f.exists() else 0,
                        'extension': f.suffix,
                    }
                    for f in files
                ]
                with open(output_file, 'w') as f:
                    json.dump(data, f, indent=2)
            else:
                with open(output_file, 'w') as f:
                    for filepath in files:
                        f.write(f"{filepath}\n")
            return True
        except Exception:
            return False
    
    @staticmethod
    def export_scripts(files: List[Path], output_dir: Path,
                       combine: bool = False) -> BatchResult:
        """Export script files, optionally combining them."""
        result = BatchResult(total=len(files), success=0, failed=0, errors=[])
        output_dir.mkdir(parents=True, exist_ok=True)
        
        if combine:
            combined_content = []
            for filepath in files:
                try:
                    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                        combined_content.append(f"// === {filepath.name} ===\n")
                        combined_content.append(f.read())
                        combined_content.append("\n\n")
                    result.success += 1
                except Exception as e:
                    result.failed += 1
                    result.errors.append(f"{filepath.name}: {e}")
            
            combined_file = output_dir / "combined_scripts.txt"
            with open(combined_file, 'w', encoding='utf-8') as f:
                f.write(''.join(combined_content))
        else:
            for filepath in files:
                try:
                    shutil.copy2(filepath, output_dir / filepath.name)
                    result.success += 1
                except Exception as e:
                    result.failed += 1
                    result.errors.append(f"{filepath.name}: {e}")
        
        return result


class BatchProcessor:
    """Generic batch processor with progress callback."""
    
    @staticmethod
    def process(files: List[Path], 
                processor: Callable[[Path], bool],
                progress_callback: Optional[Callable[[int, int], None]] = None
               ) -> BatchResult:
        """
        Process files with custom function.
        
        Args:
            files: Files to process
            processor: Function that takes Path and returns success bool
            progress_callback: Called with (current, total)
        """
        result = BatchResult(total=len(files), success=0, failed=0, errors=[])
        
        for i, filepath in enumerate(files):
            try:
                if processor(filepath):
                    result.success += 1
                else:
                    result.failed += 1
            except Exception as e:
                result.failed += 1
                result.errors.append(f"{filepath.name}: {e}")
            
            if progress_callback:
                progress_callback(i + 1, len(files))
        
        return result


__all__ = [
    'BatchResult', 'BatchRenamer', 'BatchOrganizer', 
    'BatchExporter', 'BatchProcessor'
]
