#!/usr/bin/env python3
"""
Dataset Audit Script
====================
Scan all training data for non-Evony/AutoEvony/RE content
Remove unrelated entries, keep only relevant training data
"""

import os
import re
import json
from pathlib import Path
from collections import defaultdict

class DatasetAuditor:
    def __init__(self):
        self.base_path = Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\phase4-h200\dataset")
        
        # VALID keywords - must be related to Evony/AutoEvony/RE
        self.valid_keywords = [
            # Evony specific
            'evony', 'autoevony', 'roboevony', 'troop', 'troops', 'hero', 'heroes',
            'city', 'cities', 'alliance', 'castle', 'fortress', 'barracks', 'wall',
            'food', 'gold', 'lumber', 'iron', 'stone', 'resource', 'resources',
            'attack', 'defend', 'march', 'rally', 'scout', 'reinforce', 'garrison',
            'building', 'research', 'academy', 'forge', 'warehouse', 'embassy',
            'knight', 'archer', 'cavalry', 'infantry', 'catapult', 'ballista',
            'worker', 'warrior', 'pikeman', 'swordsman', 'scout', 'transporter',
            
            # Flash/ActionScript specific
            'flash', 'actionscript', 'as3', 'swf', 'amf', 'bytearray', 'socket',
            'netconnection', 'netstream', 'loader', 'urlloader', 'urlrequest',
            'sprite', 'movieclip', 'displayobject', 'stage', 'event', 'eventdispatcher',
            'bitmap', 'bitmapdata', 'matrix', 'point', 'rectangle',
            
            # Protocol/Network
            'protocol', 'packet', 'server', 'client', 'message', 'command', 'response',
            'login', 'session', 'token', 'auth', 'encrypt', 'decrypt', 'hash',
            'serialize', 'deserialize', 'encode', 'decode',
            
            # Security/CVE
            'cve', 'vulnerability', 'exploit', 'overflow', 'injection', 'bypass',
            'memory', 'buffer', 'heap', 'stack', 'pointer', 'corruption',
            'security', 'patch', 'unpatched', 'flaw', 'weakness',
            
            # Game mechanics
            'quest', 'mission', 'reward', 'item', 'inventory', 'equipment',
            'level', 'experience', 'power', 'might', 'prestige', 'honor',
            'war', 'battle', 'combat', 'pvp', 'pve', 'npc', 'monster',
            'map', 'tile', 'coordinate', 'world', 'server', 'kingdom',
            
            # Class/Package names from source
            'gamemodule', 'gamedata', 'gamemanager', 'gameclient', 'gameserver',
            'playermanager', 'citymanager', 'armymanager', 'alliancemanager',
            'chatmanager', 'mailmanager', 'questmanager', 'eventmanager',
            'com.evony', 'org.evony', 'net.evony',
        ]
        
        # INVALID keywords - definitely NOT Evony related
        self.invalid_keywords = [
            # Wrong tech stack
            'react native', 'flutter', 'swift', 'kotlin', 'objective-c', 'ios app',
            'android app', 'mobile app', 'unity3d', 'unreal engine', 'godot',
            'angular', 'vue.js', 'node.js', 'django', 'rails', 'laravel',
            'wordpress', 'drupal', 'joomla', 'magento', 'shopify',
            
            # Wrong domains
            'cryptocurrency', 'blockchain', 'bitcoin', 'ethereum', 'nft',
            'machine learning', 'tensorflow', 'pytorch', 'neural network',
            'docker', 'kubernetes', 'aws', 'azure', 'gcp',
            
            # Wrong games
            'minecraft', 'fortnite', 'roblox', 'world of warcraft', 'league of legends',
            'call of duty', 'counter-strike', 'valorant', 'apex legends',
            
            # Generic unrelated
            'recipe', 'cooking', 'weather forecast', 'stock market', 'real estate',
            'medical', 'healthcare', 'pharmaceutical', 'legal advice',
        ]
        
        self.stats = defaultdict(int)
        self.issues = []
        
    def is_valid_entry(self, entry, file_path):
        """Check if entry is valid Evony-related content"""
        
        entry_text = json.dumps(entry).lower()
        
        # Check for invalid keywords first
        for invalid in self.invalid_keywords:
            if invalid in entry_text:
                return False, f"Invalid keyword: {invalid}"
        
        # Check for valid keywords
        valid_count = sum(1 for kw in self.valid_keywords if kw in entry_text)
        
        if valid_count >= 1:
            return True, f"Valid ({valid_count} keywords)"
        
        # Check if it's empty or too short
        if len(entry_text) < 50:
            return False, "Too short/empty"
        
        return False, "No valid keywords found"
    
    def audit_jsonl_file(self, file_path):
        """Audit a JSONL file"""
        
        valid_entries = []
        removed_entries = []
        
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                for line_num, line in enumerate(f, 1):
                    line = line.strip()
                    if not line:
                        continue
                    
                    try:
                        entry = json.loads(line)
                        is_valid, reason = self.is_valid_entry(entry, file_path)
                        
                        if is_valid:
                            valid_entries.append(entry)
                        else:
                            removed_entries.append({
                                'line': line_num,
                                'reason': reason,
                                'preview': line[:100]
                            })
                    except json.JSONDecodeError:
                        removed_entries.append({
                            'line': line_num,
                            'reason': 'Invalid JSON',
                            'preview': line[:50]
                        })
        except Exception as e:
            self.issues.append(f"Error reading {file_path}: {e}")
            return [], []
        
        return valid_entries, removed_entries
    
    def audit_json_file(self, file_path):
        """Audit a JSON file"""
        
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                data = json.load(f)
            
            if isinstance(data, list):
                valid = []
                removed = []
                for i, entry in enumerate(data):
                    is_valid, reason = self.is_valid_entry(entry, file_path)
                    if is_valid:
                        valid.append(entry)
                    else:
                        removed.append({'index': i, 'reason': reason})
                return valid, removed
            elif isinstance(data, dict):
                is_valid, reason = self.is_valid_entry(data, file_path)
                if is_valid:
                    return [data], []
                else:
                    return [], [{'reason': reason}]
        except Exception as e:
            self.issues.append(f"Error reading {file_path}: {e}")
        
        return [], []
    
    def audit_folder(self, folder_name):
        """Audit a specific folder"""
        
        folder_path = self.base_path / folder_name
        if not folder_path.exists():
            return
        
        print(f"\n📁 Auditing {folder_name}/")
        print("-" * 50)
        
        total_valid = 0
        total_removed = 0
        
        # Process JSONL files
        for file_path in folder_path.rglob("*.jsonl"):
            valid, removed = self.audit_jsonl_file(file_path)
            
            if removed:
                # Overwrite with only valid entries
                with open(file_path, 'w', encoding='utf-8') as f:
                    for entry in valid:
                        f.write(json.dumps(entry, ensure_ascii=False) + '\n')
            
            rel_path = file_path.relative_to(self.base_path)
            print(f"   {rel_path}: ✅ {len(valid)} kept, ❌ {len(removed)} removed")
            
            total_valid += len(valid)
            total_removed += len(removed)
        
        # Process JSON files
        for file_path in folder_path.rglob("*.json"):
            if '_summary' in file_path.name:
                continue
            
            valid, removed = self.audit_json_file(file_path)
            
            if len(valid) > 0:
                rel_path = file_path.relative_to(self.base_path)
                print(f"   {rel_path}: ✅ {len(valid)} kept, ❌ {len(removed)} removed")
            
            total_valid += len(valid)
            total_removed += len(removed)
        
        self.stats[folder_name] = {'valid': total_valid, 'removed': total_removed}
        return total_valid, total_removed
    
    def run(self):
        """Run complete audit"""
        
        print("=" * 60)
        print("🔍 DATASET AUDIT - Evony/AutoEvony/RE Verification")
        print("=" * 60)
        
        # Audit each folder
        folders = ['enums_cve', 'cve', 'protocols', 'training_jsonl', 
                   'autoevony', 'client', 'as_source', 'keys', 'scripts', 'borg']
        
        grand_valid = 0
        grand_removed = 0
        
        for folder in folders:
            result = self.audit_folder(folder)
            if result:
                grand_valid += result[0]
                grand_removed += result[1]
        
        # Audit root files
        print(f"\n📁 Auditing root files/")
        print("-" * 50)
        
        for file_path in self.base_path.glob("*.jsonl"):
            valid, removed = self.audit_jsonl_file(file_path)
            
            if removed:
                with open(file_path, 'w', encoding='utf-8') as f:
                    for entry in valid:
                        f.write(json.dumps(entry, ensure_ascii=False) + '\n')
            
            print(f"   {file_path.name}: ✅ {len(valid)} kept, ❌ {len(removed)} removed")
            grand_valid += len(valid)
            grand_removed += len(removed)
        
        # Print summary
        print("\n" + "=" * 60)
        print("📊 AUDIT SUMMARY")
        print("=" * 60)
        print(f"   ✅ VALID (kept): {grand_valid:,}")
        print(f"   ❌ REMOVED (non-Evony): {grand_removed:,}")
        
        if self.issues:
            print(f"\n⚠️ Issues found:")
            for issue in self.issues[:10]:
                print(f"   - {issue}")
        
        # Save audit report
        report = {
            'valid_entries': grand_valid,
            'removed_entries': grand_removed,
            'folder_stats': dict(self.stats),
            'issues': self.issues
        }
        
        report_path = self.base_path / 'audit_report.json'
        with open(report_path, 'w') as f:
            json.dump(report, f, indent=2)
        
        print(f"\n📄 Report saved: {report_path}")
        
        return grand_valid, grand_removed


def main():
    auditor = DatasetAuditor()
    valid, removed = auditor.run()
    
    print(f"\n✅ Audit complete! Dataset cleaned for Evony/AutoEvony/RE training.")


if __name__ == "__main__":
    main()
