#!/usr/bin/env python3
"""
Evony Hub - File Type Handlers
Parsers and handlers for various Evony-related file types.
"""

import json
import struct
from pathlib import Path
from typing import Dict, Any, Optional, List
from dataclasses import dataclass


@dataclass
class FileInfo:
    """Information about a parsed file."""
    path: Path
    file_type: str
    size: int
    parsed_data: Optional[Dict[str, Any]] = None
    error: Optional[str] = None


class SOLParser:
    """Parser for Flash Shared Object (.sol) files."""
    
    SOL_HEADER = b'\x00\xbf'  # SOL file signature
    
    def parse(self, filepath: Path) -> FileInfo:
        """Parse a SOL file and extract data."""
        info = FileInfo(
            path=filepath,
            file_type='sol',
            size=filepath.stat().st_size if filepath.exists() else 0
        )
        
        try:
            with open(filepath, 'rb') as f:
                data = f.read()
            
            if not data.startswith(self.SOL_HEADER):
                info.error = "Invalid SOL header"
                return info
            
            # Basic SOL structure parsing
            info.parsed_data = {
                'header': data[:2].hex(),
                'size': len(data),
                'raw_preview': data[:100].hex() if len(data) > 100 else data.hex(),
            }
            
        except Exception as e:
            info.error = str(e)
        
        return info


class AS3Parser:
    """Parser for ActionScript 3 (.as) files."""
    
    def parse(self, filepath: Path) -> FileInfo:
        """Parse an AS3 file and extract metadata."""
        info = FileInfo(
            path=filepath,
            file_type='as3',
            size=filepath.stat().st_size if filepath.exists() else 0
        )
        
        try:
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            # Extract basic info
            imports = [line.strip() for line in content.split('\n') 
                      if line.strip().startswith('import ')]
            classes = []
            functions = []
            
            for line in content.split('\n'):
                line = line.strip()
                if 'class ' in line and '{' in line:
                    classes.append(line.split('class ')[1].split()[0])
                if 'function ' in line and '(' in line:
                    func_name = line.split('function ')[1].split('(')[0].strip()
                    if func_name:
                        functions.append(func_name)
            
            info.parsed_data = {
                'imports': imports[:20],  # First 20 imports
                'classes': classes,
                'functions': functions[:50],  # First 50 functions
                'lines': content.count('\n') + 1,
            }
            
        except Exception as e:
            info.error = str(e)
        
        return info


class ScriptParser:
    """Parser for AutoEvony bot scripts (.txt, .re)."""
    
    SCRIPT_COMMANDS = {
        'train', 'attack', 'scout', 'reinforce', 'transport',
        'build', 'research', 'recruit', 'dismiss', 'levy',
        'settaxrate', 'comfort', 'useitem', 'completequests',
        'includeurl', 'includefile', 'sleep', 'echo', 'set',
        'label', 'goto', 'if', 'setsilence', 'cleartroopqueues',
    }
    
    def parse(self, filepath: Path) -> FileInfo:
        """Parse a bot script and extract commands."""
        info = FileInfo(
            path=filepath,
            file_type='script',
            size=filepath.stat().st_size if filepath.exists() else 0
        )
        
        try:
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                lines = f.readlines()
            
            commands_found = []
            variables = []
            labels = []
            
            for line in lines:
                line = line.strip()
                if not line or line.startswith('//'):
                    continue
                
                cmd = line.split()[0].lower() if line.split() else ''
                
                if cmd in self.SCRIPT_COMMANDS:
                    commands_found.append(cmd)
                if cmd == 'set' and len(line.split()) > 1:
                    variables.append(line.split()[1])
                if cmd == 'label' and len(line.split()) > 1:
                    labels.append(line.split()[1])
            
            info.parsed_data = {
                'total_lines': len(lines),
                'command_count': len(commands_found),
                'unique_commands': list(set(commands_found)),
                'variables': variables,
                'labels': labels,
            }
            
        except Exception as e:
            info.error = str(e)
        
        return info


class JSONParser:
    """Parser for JSON data files."""
    
    def parse(self, filepath: Path) -> FileInfo:
        """Parse a JSON file."""
        info = FileInfo(
            path=filepath,
            file_type='json',
            size=filepath.stat().st_size if filepath.exists() else 0
        )
        
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                data = json.load(f)
            
            info.parsed_data = {
                'type': type(data).__name__,
                'keys': list(data.keys())[:20] if isinstance(data, dict) else None,
                'length': len(data) if isinstance(data, (list, dict)) else None,
            }
            
        except Exception as e:
            info.error = str(e)
        
        return info


class FileTypeRegistry:
    """Registry of file type parsers."""
    
    def __init__(self):
        self.parsers = {
            '.sol': SOLParser(),
            '.as': AS3Parser(),
            '.txt': ScriptParser(),
            '.re': ScriptParser(),
            '.rob': ScriptParser(),
            '.json': JSONParser(),
        }
    
    def parse(self, filepath: Path) -> FileInfo:
        """Parse a file using the appropriate parser."""
        ext = filepath.suffix.lower()
        
        if ext in self.parsers:
            return self.parsers[ext].parse(filepath)
        
        return FileInfo(
            path=filepath,
            file_type='unknown',
            size=filepath.stat().st_size if filepath.exists() else 0,
            error=f"No parser for extension: {ext}"
        )


# Convenience instance
file_registry = FileTypeRegistry()


__all__ = [
    'FileInfo', 'SOLParser', 'AS3Parser', 'ScriptParser', 
    'JSONParser', 'FileTypeRegistry', 'file_registry'
]
