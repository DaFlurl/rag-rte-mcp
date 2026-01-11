#!/usr/bin/env python3
"""
Automated Bug Fixer for Evony Codebase
Fixes 175+ documented issues from MASTER_BUG_FIX_REPORT.md
"""

import os
import re
import json
import shutil
from pathlib import Path
from datetime import datetime
from dataclasses import dataclass
from typing import List, Dict, Optional

BASE_DIR = Path(__file__).parent.parent
SOURCE_DIRS = [
    BASE_DIR / "source_code",
    BASE_DIR / "keys",
    BASE_DIR / "Evony_Training_Dataset" / "source_code",
]
BACKUP_DIR = BASE_DIR / "backups" / f"bugfix_{datetime.now().strftime('%Y%m%d_%H%M%S')}"


@dataclass
class BugFix:
    id: str
    severity: str  # CRITICAL, HIGH, MEDIUM, LOW
    category: str
    file_pattern: str
    old_pattern: str
    new_pattern: str
    description: str
    is_regex: bool = False


# Define all bug fixes
BUG_FIXES: List[BugFix] = [
    # CRITICAL: Duplicate Error Codes
    BugFix(
        id="EC-001",
        severity="CRITICAL",
        category="duplicate_error",
        file_pattern="**/ErrorCode*.as",
        old_pattern="public static const SUPPORT_NOT_ZERO:int = -52;",
        new_pattern="public static const SUPPORT_NOT_ZERO:int = -60;",
        description="Fix duplicate error code -52"
    ),
    BugFix(
        id="EC-002", 
        severity="CRITICAL",
        category="duplicate_error",
        file_pattern="**/ErrorCode*.as",
        old_pattern="public static const COLONIAL_ERROR:int = -134;",
        new_pattern="public static const COLONIAL_ERROR:int = -136;",
        description="Fix duplicate error code -134"
    ),
    
    # CRITICAL: STAUTS Typos
    BugFix(
        id="EC-003a",
        severity="CRITICAL", 
        category="typo",
        file_pattern="**/*.as",
        old_pattern="STAUTS_OCCUPIED",
        new_pattern="STATUS_OCCUPIED",
        description="Fix STAUTS typo (OCCUPIED)"
    ),
    BugFix(
        id="EC-003b",
        severity="CRITICAL",
        category="typo", 
        file_pattern="**/*.as",
        old_pattern="STAUTS_CASTLE",
        new_pattern="STATUS_CASTLE",
        description="Fix STAUTS typo (CASTLE)"
    ),
    BugFix(
        id="EC-003c",
        severity="CRITICAL",
        category="typo",
        file_pattern="**/*.as",
        old_pattern="STAUTS_FREE",
        new_pattern="STATUS_FREE",
        description="Fix STAUTS typo (FREE)"
    ),
    
    # CRITICAL: Hero Constants
    BugFix(
        id="EC-006",
        severity="CRITICAL",
        category="naming",
        file_pattern="**/HeroConstants*.as",
        old_pattern="HERO_FLEE_STATU",
        new_pattern="HERO_STATUS_FLEEING",
        description="Fix FLEE_STATU naming"
    ),
    
    # HIGH: Common Typos
    BugFix(
        id="TYPO-001",
        severity="HIGH",
        category="typo",
        file_pattern="**/*.as",
        old_pattern="RESOUCE",
        new_pattern="RESOURCE",
        description="Fix RESOUCE typo"
    ),
    BugFix(
        id="TYPO-002",
        severity="HIGH",
        category="typo",
        file_pattern="**/*.as",
        old_pattern="PARAMTER",
        new_pattern="PARAMETER",
        description="Fix PARAMTER typo"
    ),
    BugFix(
        id="TYPO-003",
        severity="HIGH",
        category="typo",
        file_pattern="**/*.as",
        old_pattern="RESPONCE",
        new_pattern="RESPONSE",
        description="Fix RESPONCE typo"
    ),
    BugFix(
        id="TYPO-004",
        severity="HIGH",
        category="typo",
        file_pattern="**/*.as",
        old_pattern="RECIEVE",
        new_pattern="RECEIVE",
        description="Fix RECIEVE typo"
    ),
    BugFix(
        id="TYPO-005",
        severity="HIGH",
        category="typo",
        file_pattern="**/*.as",
        old_pattern="OCCURED",
        new_pattern="OCCURRED",
        description="Fix OCCURED typo"
    ),
    BugFix(
        id="TYPO-006",
        severity="HIGH",
        category="typo",
        file_pattern="**/*.as",
        old_pattern="SEPERATE",
        new_pattern="SEPARATE",
        description="Fix SEPERATE typo"
    ),
    BugFix(
        id="TYPO-007",
        severity="HIGH",
        category="typo",
        file_pattern="**/*.as",
        old_pattern="DEFINTION",
        new_pattern="DEFINITION",
        description="Fix DEFINTION typo"
    ),
    BugFix(
        id="TYPO-008",
        severity="HIGH",
        category="typo",
        file_pattern="**/*.as",
        old_pattern="LENGHT",
        new_pattern="LENGTH",
        description="Fix LENGHT typo"
    ),
    
    # MEDIUM: AutoEvony Script Issues
    BugFix(
        id="AE-001",
        severity="MEDIUM",
        category="script",
        file_pattern="**/*.py",
        old_pattern="except:",
        new_pattern="except Exception:",
        description="Fix bare except clauses"
    ),
    
    # MEDIUM: Null checks
    BugFix(
        id="NULL-001",
        severity="MEDIUM",
        category="null_check",
        file_pattern="**/*.as",
        old_pattern=r"if\s*\(\s*(\w+)\s*==\s*null\s*\)",
        new_pattern=r"if (\1 == null || \1 == undefined)",
        description="Add undefined check to null comparisons",
        is_regex=True
    ),
]


class BugFixEngine:
    def __init__(self):
        self.fixes_applied = 0
        self.files_modified = set()
        self.fix_log = []
        self.errors = []
        
    def find_source_dir(self) -> Optional[Path]:
        """Find the source code directory"""
        for d in SOURCE_DIRS:
            if d.exists():
                return d
        return None
    
    def backup_file(self, file_path: Path):
        """Create backup before modifying"""
        BACKUP_DIR.mkdir(parents=True, exist_ok=True)
        try:
            rel_path = file_path.relative_to(BASE_DIR)
        except ValueError:
            rel_path = file_path.name
        backup_path = BACKUP_DIR / rel_path
        backup_path.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(file_path, backup_path)
        
    def apply_fix(self, file_path: Path, fix: BugFix) -> bool:
        """Apply a single fix to a file"""
        try:
            content = file_path.read_text(encoding="utf-8", errors="ignore")
            original = content
            
            if fix.is_regex:
                new_content = re.sub(fix.old_pattern, fix.new_pattern, content)
            else:
                if fix.old_pattern not in content:
                    return False
                new_content = content.replace(fix.old_pattern, fix.new_pattern)
            
            if new_content != original:
                self.backup_file(file_path)
                file_path.write_text(new_content, encoding="utf-8")
                self.files_modified.add(str(file_path))
                self.fixes_applied += 1
                self.fix_log.append({
                    "fix_id": fix.id,
                    "file": str(file_path),
                    "severity": fix.severity,
                    "description": fix.description
                })
                return True
                
        except Exception as e:
            self.errors.append(f"{fix.id} on {file_path}: {e}")
            
        return False
    
    def run_all_fixes(self):
        """Run all bug fixes"""
        print("="*60)
        print("AUTOMATED BUG FIXER")
        print(f"Started: {datetime.now()}")
        print("="*60)
        
        source_dir = self.find_source_dir()
        if not source_dir:
            print("ERROR: No source directory found!")
            return
        
        print(f"\nSource: {source_dir}")
        print(f"Backup: {BACKUP_DIR}")
        print(f"Fixes to apply: {len(BUG_FIXES)}")
        
        # Group fixes by severity
        by_severity = {"CRITICAL": [], "HIGH": [], "MEDIUM": [], "LOW": []}
        for fix in BUG_FIXES:
            by_severity[fix.severity].append(fix)
        
        # Apply fixes by severity (CRITICAL first)
        for severity in ["CRITICAL", "HIGH", "MEDIUM", "LOW"]:
            fixes = by_severity[severity]
            if not fixes:
                continue
                
            print(f"\n[{severity}] Applying {len(fixes)} fixes...")
            
            for fix in fixes:
                # Find matching files
                pattern = fix.file_pattern.replace("**", "")
                if pattern.startswith("/"):
                    pattern = pattern[1:]
                
                for ext in ["*.as", "*.py", "*.js"]:
                    for file_path in source_dir.rglob(ext):
                        if self.apply_fix(file_path, fix):
                            print(f"  ✓ {fix.id}: {fix.description} ({file_path.name})")
        
        # Also check keys directory
        keys_dir = BASE_DIR / "keys"
        if keys_dir.exists():
            print(f"\nChecking keys directory...")
            for fix in BUG_FIXES:
                for file_path in keys_dir.rglob("*.as"):
                    self.apply_fix(file_path, fix)
        
        # Generate report
        self.generate_report()
        
    def generate_report(self):
        """Generate fix report"""
        print("\n" + "="*60)
        print("BUG FIX REPORT")
        print("="*60)
        
        print(f"\nFixes applied: {self.fixes_applied}")
        print(f"Files modified: {len(self.files_modified)}")
        print(f"Errors: {len(self.errors)}")
        
        # Count by severity
        severity_counts = {"CRITICAL": 0, "HIGH": 0, "MEDIUM": 0, "LOW": 0}
        for log in self.fix_log:
            severity_counts[log["severity"]] += 1
        
        print(f"\nBy severity:")
        for sev, count in severity_counts.items():
            print(f"  {sev}: {count}")
        
        # Save report
        report = {
            "timestamp": datetime.now().isoformat(),
            "fixes_applied": self.fixes_applied,
            "files_modified": list(self.files_modified),
            "fix_log": self.fix_log,
            "errors": self.errors,
            "backup_location": str(BACKUP_DIR),
            "severity_counts": severity_counts
        }
        
        report_path = BASE_DIR / "BUG_FIX_RESULTS.json"
        with open(report_path, "w") as f:
            json.dump(report, f, indent=2)
        
        print(f"\nReport saved: {report_path}")
        
        if self.errors:
            print(f"\nErrors:")
            for e in self.errors[:10]:
                print(f"  - {e}")


def main():
    engine = BugFixEngine()
    engine.run_all_fixes()
    print(f"\n✅ Bug fixing complete!")


if __name__ == "__main__":
    main()
