#!/usr/bin/env python3
"""
Evony Hub - Code and Protocol Analyzers
Analysis tools for AS3 source, protocol patterns, and vulnerabilities.
"""

import re
from pathlib import Path
from typing import Dict, List, Set, Optional, Tuple
from dataclasses import dataclass, field
from collections import defaultdict


@dataclass
class AnalysisResult:
    """Result of code analysis."""
    file_path: Path
    findings: List[Dict]
    metrics: Dict
    score: float = 0.0


@dataclass
class VulnerabilityFinding:
    """A potential vulnerability finding."""
    severity: str  # critical, high, medium, low
    category: str
    description: str
    file_path: str
    line_number: int
    code_snippet: str
    recommendation: str


class AS3Analyzer:
    """Analyzer for ActionScript 3 source code."""
    
    # Patterns indicating potential vulnerabilities
    VULN_PATTERNS = {
        'integer_overflow': [
            (r'int\s*\(\s*\w+\s*\*\s*\w+\s*\)', 'Potential integer overflow in multiplication'),
            (r'\+=\s*\d{6,}', 'Large number addition - overflow risk'),
            (r'2147483647|0x7FFFFFFF', 'INT32_MAX reference - boundary condition'),
        ],
        'race_condition': [
            (r'setTimeout\s*\(', 'Async setTimeout - timing vulnerability'),
            (r'setInterval\s*\(', 'Interval timer - race condition risk'),
            (r'\.addEventListener\s*\([^)]*COMPLETE', 'Async completion - race window'),
        ],
        'injection': [
            (r'sendAction\s*\([^)]*\+', 'Dynamic action construction'),
            (r'URLRequest\s*\([^)]*\+', 'Dynamic URL construction'),
            (r'eval\s*\(', 'Eval usage - code injection risk'),
        ],
        'hardcoded_secrets': [
            (r'["\'][a-f0-9]{32}["\']', 'Hardcoded MD5 hash'),
            (r'password\s*=\s*["\'][^"\']+["\']', 'Hardcoded password'),
            (r'api[_]?key\s*=\s*["\'][^"\']+["\']', 'Hardcoded API key'),
        ],
    }
    
    def analyze(self, filepath: Path) -> AnalysisResult:
        """Analyze AS3 file for patterns and vulnerabilities."""
        result = AnalysisResult(
            file_path=filepath,
            findings=[],
            metrics={}
        )
        
        try:
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
                lines = content.split('\n')
            
            # Collect metrics
            result.metrics = {
                'lines': len(lines),
                'imports': len([l for l in lines if l.strip().startswith('import ')]),
                'classes': len(re.findall(r'\bclass\s+\w+', content)),
                'functions': len(re.findall(r'\bfunction\s+\w+', content)),
                'public_methods': len(re.findall(r'\bpublic\s+function\s+\w+', content)),
            }
            
            # Scan for vulnerabilities
            for category, patterns in self.VULN_PATTERNS.items():
                for pattern, description in patterns:
                    for i, line in enumerate(lines, 1):
                        if re.search(pattern, line, re.IGNORECASE):
                            result.findings.append({
                                'category': category,
                                'description': description,
                                'line': i,
                                'code': line.strip()[:100],
                            })
            
            # Calculate risk score
            severity_weights = {'integer_overflow': 3, 'race_condition': 2, 
                              'injection': 3, 'hardcoded_secrets': 2}
            result.score = sum(
                severity_weights.get(f['category'], 1) 
                for f in result.findings
            )
            
        except Exception as e:
            result.findings.append({
                'category': 'error',
                'description': str(e),
                'line': 0,
                'code': ''
            })
        
        return result


class ProtocolAnalyzer:
    """Analyzer for protocol commands and patterns."""
    
    # Known exploitable command patterns
    EXPLOIT_COMMANDS = {
        'troop.produceTroop': {
            'risk': 'critical',
            'vuln': 'integer overflow in num parameter',
            'params': ['num'],
        },
        'shop.buy': {
            'risk': 'high',
            'vuln': 'negative quantity exploit',
            'params': ['num', 'amount'],
        },
        'shop.useGoods': {
            'risk': 'high', 
            'vuln': 'race condition on item use',
            'params': ['itemId'],
        },
        'common.getPackage': {
            'risk': 'medium',
            'vuln': 'package ID enumeration',
            'params': ['packageId'],
        },
    }
    
    def analyze_command_usage(self, content: str) -> List[Dict]:
        """Find protocol command usages in code."""
        findings = []
        
        # Pattern for ActionFactory command calls
        pattern = r'ActionFactory\.getInstance\(\)\.(\w+)Commands\(\)\.(\w+)\s*\('
        
        for match in re.finditer(pattern, content):
            category = match.group(1).lower()
            command = match.group(2)
            full_cmd = f"{category}.{command}"
            
            finding = {
                'command': full_cmd,
                'position': match.start(),
                'risk': 'unknown',
                'vuln': None,
            }
            
            if full_cmd in self.EXPLOIT_COMMANDS:
                exploit_info = self.EXPLOIT_COMMANDS[full_cmd]
                finding['risk'] = exploit_info['risk']
                finding['vuln'] = exploit_info['vuln']
            
            findings.append(finding)
        
        return findings


class PatternMatcher:
    """Generic pattern matching for code analysis."""
    
    def __init__(self):
        self.patterns: Dict[str, List[Tuple[str, str]]] = {}
    
    def add_pattern(self, category: str, pattern: str, description: str):
        """Add a pattern to match."""
        if category not in self.patterns:
            self.patterns[category] = []
        self.patterns[category].append((pattern, description))
    
    def match_file(self, filepath: Path) -> List[Dict]:
        """Match all patterns against a file."""
        findings = []
        
        try:
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                lines = f.readlines()
            
            for i, line in enumerate(lines, 1):
                for category, patterns in self.patterns.items():
                    for pattern, description in patterns:
                        if re.search(pattern, line, re.IGNORECASE):
                            findings.append({
                                'category': category,
                                'description': description,
                                'file': str(filepath),
                                'line': i,
                                'match': line.strip()[:80],
                            })
        except Exception:
            pass
        
        return findings


class DependencyAnalyzer:
    """Analyze import dependencies in AS3 code."""
    
    def analyze(self, filepath: Path) -> Dict:
        """Extract and analyze imports."""
        result = {
            'imports': [],
            'dependencies': defaultdict(list),
            'external': [],
        }
        
        try:
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                for line in f:
                    line = line.strip()
                    if line.startswith('import '):
                        import_path = line[7:].rstrip(';').strip()
                        result['imports'].append(import_path)
                        
                        # Categorize
                        if import_path.startswith('com.evony'):
                            result['dependencies']['evony'].append(import_path)
                        elif import_path.startswith('flash.'):
                            result['dependencies']['flash'].append(import_path)
                        elif import_path.startswith('mx.'):
                            result['dependencies']['flex'].append(import_path)
                        else:
                            result['external'].append(import_path)
        except Exception:
            pass
        
        return result


__all__ = [
    'AnalysisResult', 'VulnerabilityFinding', 'AS3Analyzer',
    'ProtocolAnalyzer', 'PatternMatcher', 'DependencyAnalyzer'
]
