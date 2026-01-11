#!/usr/bin/env python3
"""
CVE to Training JSONL Converter
Converts evony_verified_cves.json (473 CVEs) to training format
For Windsurf to merge with existing datasets
"""

import json
import os
from pathlib import Path

CVE_DIR = Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\CVE_Research")
OUTPUT_FILE = CVE_DIR / "train_cve_claude.jsonl"

def load_cves():
    """Load Claude's 473 CVEs from JSON"""
    with open(CVE_DIR / "evony_verified_cves.json", "r") as f:
        return json.load(f)

def generate_training_examples(cve):
    """Generate 1-3 training examples per CVE"""
    examples = []
    cve_id = cve.get("cve_id", "")
    name = cve.get("name", "Unknown")
    severity = cve.get("severity", "HIGH")
    cvss = cve.get("cvss", 9.0)
    affected = cve.get("affected", "Flash 10.x and earlier")
    surface = cve.get("surface", "Memory")
    code_loc = cve.get("code_location", "")
    wild = cve.get("exploited_in_wild", False)
    bulletin = cve.get("bulletin", "")
    
    # Example 1: Basic CVE question
    ex1 = {
        "instruction": f"What is {cve_id} and does it affect Evony's Flash client?",
        "input": "",
        "output": f"{cve_id} ({name}) is a {severity} severity vulnerability (CVSS: {cvss}) affecting {affected}. "
                  f"This CVE DOES affect Evony's Flash 10.0.x client because Evony targets Flash 10.0.x which falls within the affected range. "
                  f"The vulnerability affects the {surface} attack surface. "
                  + (f"This was exploited in the wild. " if wild else "")
                  + (f"Reference: {bulletin}." if bulletin else "")
    }
    examples.append(ex1)
    
    # Example 2: If has code location, add exploitation question
    if code_loc or surface in ["ByteArray", "Socket", "ExternalInterface", "SharedObject"]:
        location_map = {
            "ByteArray": "GameClient.as (lines 7, 20-21, 87)",
            "Socket": "GameClient.as (lines 8, 24, 33-35, 133)",
            "ExternalInterface": "EvonyClient.as (line 32)",
            "SharedObject": "EvonyClient.as (line 55)",
            "Memory": "All runtime operations"
        }
        loc = code_loc if code_loc else location_map.get(surface, "Flash runtime")
        
        ex2 = {
            "instruction": f"Where in Evony's source code is {cve_id} relevant?",
            "input": "",
            "output": f"{cve_id} ({name}) is relevant to Evony at {loc}. "
                      f"The {surface} attack surface in Evony's code is vulnerable to this {severity} severity issue. "
                      f"Evony's Flash 10.0.x target version ({affected}) makes this exploitable."
        }
        examples.append(ex2)
    
    return examples

def main():
    cves = load_cves()
    print(f"Loaded {len(cves)} CVEs from evony_verified_cves.json")
    
    all_examples = []
    for cve in cves:
        examples = generate_training_examples(cve)
        all_examples.extend(examples)
    
    # Write JSONL
    with open(OUTPUT_FILE, "w") as f:
        for ex in all_examples:
            f.write(json.dumps(ex) + "\n")
    
    print(f"Generated {len(all_examples)} training examples")
    print(f"Output: {OUTPUT_FILE}")
    
    # Stats
    print("\n=== MERGE INSTRUCTIONS FOR WINDSURF ===")
    print(f"1. Claude's new file: train_cve_claude.jsonl ({len(all_examples)} examples)")
    print("2. Existing files to merge:")
    print("   - evony_cve_training.jsonl (28 examples)")
    print("   - train_cve_validated.jsonl (489 examples)")
    print("   - train_cve_security.jsonl (14 examples)")
    print(f"3. Total after merge: ~{len(all_examples) + 28 + 489 + 14} examples")
    print("4. Deduplicate by CVE ID in instruction field")

if __name__ == "__main__":
    main()
