#!/usr/bin/env python3
"""
Comprehensive Dataset Audit - ALL Folders
Identifies and removes non-Evony content from the entire dataset
"""

import os
import re
import json
import shutil
from pathlib import Path
from collections import defaultdict

BASE_DIR = Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\phase4-h200\dataset")
TRASH_DIR = BASE_DIR / "trash_comprehensive"

# EVONY-RELATED KEYWORDS (files containing these are KEPT)
EVONY_KEYWORDS = {
    # Game-specific
    'evony', 'autoevony', 'roboevony', 'borg', 'svony',
    'troop', 'hero', 'castle', 'city', 'alliance', 'quest',
    'attack', 'defend', 'march', 'rally', 'scout', 'garrison',
    'barracks', 'forge', 'academy', 'warehouse', 'embassy', 'wall',
    'archer', 'cavalry', 'infantry', 'catapult', 'ballista', 'pikeman',
    'warrior', 'swordsman', 'worker', 'transporter',
    'food', 'gold', 'lumber', 'iron', 'stone', 'resource',
    'prestige', 'honor', 'might', 'power',
    
    # Technical - Flash/AS3
    'actionscript', 'as3', 'swf', 'amf', 'flash', 'flex',
    'bytearray', 'socket', 'netconnection', 'urlloader',
    'sprite', 'movieclip', 'displayobject', 'eventdispatcher',
    'bitmap', 'bitmapdata',
    
    # Protocol/Network  
    'protocol', 'packet', 'serialize', 'deserialize',
    'gamemodule', 'gamedata', 'gamemanager', 'gameclient',
    'playermanager', 'citymanager', 'armymanager', 'alliancemanager',
    'com.evony', 'modcmd', 'cycmd', 'cyclient',
    
    # Bot/Exploit specific
    'glitch', 'exploit', 'cheat', 'bot', 'automation',
    'foodglitch', 'troopoverflow', 'valleyhide', 'rapiduse',
    'commission', 'commquest',
    
    # File patterns
    '.sol', 'config.sol', 'evonyclient', 'evonycommquest',
}

# JUNK PATTERNS - Files matching these are TRASHED
JUNK_PATTERNS = {
    # Virus/malware docs
    r'virus', r'virii', r'vx_', r'malware',
    r'trojan', r'worm', r'ransomware',
    
    # Generic tools unrelated to Evony
    r'ghidra', r'dnspy', r'ida_', r'ollydbg',
    r'kubernetes', r'docker', r'aws', r'azure', r'gcp',
    r'tensorflow', r'pytorch', r'neural',
    r'blockchain', r'bitcoin', r'ethereum', r'crypto',
    r'wordpress', r'drupal', r'joomla', r'magento',
    r'react\s*native', r'flutter', r'swift', r'kotlin',
    r'minecraft', r'fortnite', r'roblox',
}

# EXACT JUNK FILENAMES
JUNK_FILENAMES = {
    # Generic Python
    '__init__.py', 'setup.py', 'manage.py', 'settings.py',
    'urls.py', 'wsgi.py', 'asgi.py', 'conftest.py',
    
    # Web junk
    'jquery.js', 'jquery.min.js', 'mootools.js', 'prototype.js',
    'angular.js', 'react.js', 'vue.js',
    
    # Config junk
    '.gitignore', '.gitattributes', '.editorconfig',
    'package.json', 'package-lock.json', 'yarn.lock',
    'tsconfig.json', 'webpack.config.js',
    '.eslintrc', '.prettierrc', '.babelrc',
    
    # License files
    'LICENSE', 'LICENSE.txt', 'LICENSE.md',
    'COPYING', 'COPYING.txt',
}

# FILE EXTENSIONS TO SKIP (binary/media)
SKIP_EXTENSIONS = {'.pyc', '.pyo', '.exe', '.dll', '.so', '.dylib',
                   '.jpg', '.jpeg', '.png', '.gif', '.bmp', '.ico',
                   '.mp3', '.mp4', '.wav', '.avi', '.mov',
                   '.zip', '.tar', '.gz', '.rar', '.7z'}

stats = defaultdict(int)
trash_reasons = defaultdict(list)

def is_evony_related(file_path: Path) -> tuple:
    """Check if file is Evony-related"""
    name_lower = file_path.name.lower()
    
    # Skip binary files
    if file_path.suffix.lower() in SKIP_EXTENSIONS:
        return True, "binary_skip"
    
    # Check exact junk filenames
    if file_path.name in JUNK_FILENAMES:
        return False, "junk_filename"
    
    # Check filename for Evony keywords
    for kw in EVONY_KEYWORDS:
        if kw in name_lower:
            return True, f"keyword_in_name:{kw}"
    
    # Check parent path for Evony context
    path_str = str(file_path).lower()
    for kw in ['evony', 'autoevony', 'borg', 'roboevony', 'svony']:
        if kw in path_str:
            return True, f"keyword_in_path:{kw}"
    
    # For text files, check content
    try:
        if file_path.suffix.lower() in {'.py', '.as', '.txt', '.md', '.json', '.jsonl', '.php', '.xml'}:
            content = file_path.read_text(encoding='utf-8', errors='ignore')[:5000].lower()
            
            # Check for junk patterns
            for pattern in JUNK_PATTERNS:
                if re.search(pattern, content):
                    return False, f"junk_content:{pattern}"
            
            # Check for Evony keywords in content
            evony_hits = sum(1 for kw in EVONY_KEYWORDS if kw in content)
            if evony_hits >= 2:
                return True, f"content_keywords:{evony_hits}"
            
            # Single keyword might be coincidental
            if evony_hits == 1:
                return True, "content_single_keyword"
                
    except Exception as e:
        return True, f"read_error:{e}"
    
    # Default: keep if in an Evony-related folder structure
    return True, "default_keep"

def audit_folder(folder_name: str):
    """Audit a specific folder"""
    folder_path = BASE_DIR / folder_name
    if not folder_path.exists():
        print(f"  Folder not found: {folder_name}")
        return
    
    print(f"\n{'='*60}")
    print(f"Auditing: {folder_name}")
    print('='*60)
    
    kept = 0
    trashed = 0
    
    for file_path in folder_path.rglob("*"):
        if file_path.is_dir():
            continue
            
        is_evony, reason = is_evony_related(file_path)
        
        if is_evony:
            kept += 1
            stats['kept'] += 1
        else:
            trashed += 1
            stats['trashed'] += 1
            trash_reasons[reason].append(file_path.name)
            
            # Move to trash
            rel_path = file_path.relative_to(BASE_DIR)
            trash_dest = TRASH_DIR / rel_path
            trash_dest.parent.mkdir(parents=True, exist_ok=True)
            try:
                shutil.move(str(file_path), str(trash_dest))
            except Exception as e:
                print(f"  Error moving {file_path.name}: {e}")
    
    print(f"  Kept: {kept}, Trashed: {trashed}")

def audit_jsonl_files():
    """Audit JSONL training files for non-Evony entries"""
    print(f"\n{'='*60}")
    print("Auditing JSONL Training Files")
    print('='*60)
    
    jsonl_files = list(BASE_DIR.rglob("*.jsonl"))
    
    for jsonl_path in jsonl_files:
        valid_entries = []
        removed = 0
        
        try:
            with open(jsonl_path, 'r', encoding='utf-8', errors='ignore') as f:
                for line in f:
                    line = line.strip()
                    if not line:
                        continue
                    
                    try:
                        entry = json.loads(line)
                        entry_str = json.dumps(entry).lower()
                        
                        # Check for Evony keywords
                        has_evony = any(kw in entry_str for kw in EVONY_KEYWORDS)
                        
                        # Check for junk
                        has_junk = any(re.search(p, entry_str) for p in JUNK_PATTERNS)
                        
                        if has_evony and not has_junk:
                            valid_entries.append(entry)
                        else:
                            removed += 1
                            
                    except json.JSONDecodeError:
                        removed += 1
                        
        except Exception as e:
            print(f"  Error reading {jsonl_path.name}: {e}")
            continue
        
        if removed > 0:
            # Rewrite with only valid entries
            with open(jsonl_path, 'w', encoding='utf-8') as f:
                for entry in valid_entries:
                    f.write(json.dumps(entry, ensure_ascii=False) + '\n')
            
            print(f"  {jsonl_path.name}: kept {len(valid_entries)}, removed {removed}")
            stats['jsonl_kept'] += len(valid_entries)
            stats['jsonl_removed'] += removed
        else:
            print(f"  {jsonl_path.name}: {len(valid_entries)} entries (all valid)")
            stats['jsonl_kept'] += len(valid_entries)

def main():
    print("="*60)
    print("COMPREHENSIVE DATASET AUDIT")
    print("Evony/AutoEvony/RE Content Verification")
    print("="*60)
    
    # Create trash directory
    TRASH_DIR.mkdir(parents=True, exist_ok=True)
    
    # Audit all folders
    folders = ['as_source', 'autoevony', 'borg', 'client', 'cve', 
               'enums_cve', 'keys', 'protocols', 'scripts', 'training_jsonl']
    
    for folder in folders:
        audit_folder(folder)
    
    # Audit JSONL files
    audit_jsonl_files()
    
    # Print summary
    print("\n" + "="*60)
    print("AUDIT SUMMARY")
    print("="*60)
    print(f"Files Kept: {stats['kept']}")
    print(f"Files Trashed: {stats['trashed']}")
    print(f"JSONL Entries Kept: {stats['jsonl_kept']}")
    print(f"JSONL Entries Removed: {stats['jsonl_removed']}")
    
    if trash_reasons:
        print("\nTrash Reasons:")
        for reason, files in sorted(trash_reasons.items(), key=lambda x: -len(x[1])):
            print(f"  {reason}: {len(files)} files")
            for f in files[:3]:
                print(f"    - {f}")
            if len(files) > 3:
                print(f"    ... and {len(files)-3} more")
    
    # Save report
    report_path = BASE_DIR / "comprehensive_audit_report.json"
    with open(report_path, 'w') as f:
        json.dump({
            'files_kept': stats['kept'],
            'files_trashed': stats['trashed'],
            'jsonl_kept': stats['jsonl_kept'],
            'jsonl_removed': stats['jsonl_removed'],
            'trash_reasons': {k: len(v) for k, v in trash_reasons.items()}
        }, f, indent=2)
    
    print(f"\nReport saved: {report_path}")
    print(f"Trash folder: {TRASH_DIR}")

if __name__ == "__main__":
    main()
