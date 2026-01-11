#!/usr/bin/env python3
"""
Flash Player CVE Fetcher for Evony Training Data
=================================================
1. Downloads NVD Flash Player CVE data
2. Filters by version 10.x or "and earlier"
3. Cross-references with Evony code surfaces
4. Outputs validated training data

Target: Flash Player 10.0.x (Evony compiled Nov 2009)
"""

import json
import re
import os
import requests
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional, Set

# Paths
PROJECT_ROOT = Path(__file__).parent.parent
CVE_OUTPUT_DIR = Path(__file__).parent
EVONY_SOURCE = PROJECT_ROOT / "AS3_Scripts_(EvonyClient1921.swf)"
AUTOEVONY_SOURCE = PROJECT_ROOT / "AS3_Scripts_(AutoEvony2_NEW.swf)"

# NVD API endpoints
NVD_API_BASE = "https://services.nvd.nist.gov/rest/json/cves/2.0"

# Target Flash versions
TARGET_VERSIONS = ["10.0", "10.1", "9.0"]
MAX_AFFECTED_VERSION = 10  # Include CVEs affecting Flash 10 or earlier

# Vulnerable code surfaces to search for in Evony
CODE_SURFACES = {
    "ByteArray": {
        "patterns": ["ByteArray", "readBytes", "writeBytes", "uncompress", "compress"],
        "category": "memory",
        "severity_boost": 2
    },
    "Socket": {
        "patterns": ["Socket", "XMLSocket", "connect", "readUTF", "writeUTF"],
        "category": "network",
        "severity_boost": 1
    },
    "SharedObject": {
        "patterns": ["SharedObject", "getLocal", "flush", ".data"],
        "category": "storage",
        "severity_boost": 1
    },
    "ExternalInterface": {
        "patterns": ["ExternalInterface", "call(", "addCallback"],
        "category": "xss",
        "severity_boost": 1
    },
    "Loader": {
        "patterns": ["Loader", "URLLoader", "loadBytes", "LoaderContext"],
        "category": "injection",
        "severity_boost": 1
    },
    "Vector": {
        "patterns": ["Vector.<", "Vector.<uint>", "Vector.<int>", "Vector.<Number>"],
        "category": "memory",
        "severity_boost": 2
    },
    "BitmapData": {
        "patterns": ["BitmapData", "draw", "copyPixels", "getPixels"],
        "category": "graphics",
        "severity_boost": 1
    },
    "XML": {
        "patterns": ["XML", "XMLList", "parseXML", "XMLDocument"],
        "category": "parsing",
        "severity_boost": 1
    },
    "NetConnection": {
        "patterns": ["NetConnection", "NetStream", "RTMP"],
        "category": "network",
        "severity_boost": 1
    },
    "AMF": {
        "patterns": ["writeObject", "readObject", "registerClassAlias", "IExternalizable"],
        "category": "deserialization",
        "severity_boost": 2
    },
    "Security": {
        "patterns": ["Security.", "loadPolicyFile", "allowDomain", "crossdomain"],
        "category": "sandbox",
        "severity_boost": 1
    },
    "LocalConnection": {
        "patterns": ["LocalConnection", "allowDomain", "send"],
        "category": "ipc",
        "severity_boost": 1
    }
}


def search_evony_for_surface(surface_name: str, patterns: List[str]) -> Dict:
    """Search Evony source code for vulnerable surface patterns"""
    results = {
        "surface": surface_name,
        "found": False,
        "files": [],
        "count": 0
    }
    
    for source_dir in [EVONY_SOURCE, AUTOEVONY_SOURCE]:
        if not source_dir.exists():
            continue
            
        for as_file in source_dir.rglob("*.as"):
            try:
                content = as_file.read_text(encoding='utf-8', errors='ignore')
                for pattern in patterns:
                    if pattern in content:
                        results["found"] = True
                        results["count"] += content.count(pattern)
                        rel_path = str(as_file.relative_to(source_dir))
                        if rel_path not in results["files"]:
                            results["files"].append(rel_path)
                        break
            except:
                continue
    
    # Limit file list for output
    results["files"] = results["files"][:10]
    return results


def scan_evony_surfaces() -> Dict:
    """Scan all vulnerable surfaces in Evony code"""
    print("\n🔍 Scanning Evony source for vulnerable surfaces...")
    
    surface_results = {}
    for surface_name, surface_info in CODE_SURFACES.items():
        result = search_evony_for_surface(surface_name, surface_info["patterns"])
        result["category"] = surface_info["category"]
        surface_results[surface_name] = result
        
        if result["found"]:
            print(f"  ✅ {surface_name}: Found in {len(result['files'])} files ({result['count']} occurrences)")
        else:
            print(f"  ❌ {surface_name}: Not found")
    
    return surface_results


def version_matches_target(version_str: str) -> bool:
    """Check if a version string indicates Flash 10.x or earlier is affected"""
    if not version_str:
        return False
    
    version_lower = version_str.lower()
    
    # Direct version matches
    for target in TARGET_VERSIONS:
        if target in version_str:
            return True
    
    # "X and earlier" patterns
    if "and earlier" in version_lower or "and before" in version_lower:
        # Extract version number
        match = re.search(r'(\d+)\.', version_str)
        if match:
            major = int(match.group(1))
            if major >= MAX_AFFECTED_VERSION:
                return True
    
    # "before X.Y.Z" patterns
    match = re.search(r'before\s+(\d+)\.(\d+)', version_lower)
    if match:
        major = int(match.group(1))
        if major >= MAX_AFFECTED_VERSION:
            return True
    
    # Version range like "9.0 - 18.0"
    match = re.search(r'(\d+)\.[\d.]+\s*[-–]\s*(\d+)\.', version_str)
    if match:
        start_major = int(match.group(1))
        end_major = int(match.group(2))
        if start_major <= MAX_AFFECTED_VERSION <= end_major:
            return True
    
    return False


def extract_cve_surfaces(description: str) -> List[str]:
    """Extract vulnerable surfaces mentioned in CVE description"""
    surfaces_found = []
    desc_lower = description.lower()
    
    for surface_name, surface_info in CODE_SURFACES.items():
        for pattern in surface_info["patterns"]:
            if pattern.lower() in desc_lower:
                if surface_name not in surfaces_found:
                    surfaces_found.append(surface_name)
                break
    
    return surfaces_found


def fetch_nvd_cves(keyword: str = "flash player", max_results: int = 500) -> List[Dict]:
    """Fetch CVEs from NVD API"""
    print(f"\n📥 Fetching CVEs from NVD for '{keyword}'...")
    
    all_cves = []
    start_index = 0
    results_per_page = 100
    
    while start_index < max_results:
        try:
            params = {
                "keywordSearch": keyword,
                "resultsPerPage": min(results_per_page, max_results - start_index),
                "startIndex": start_index
            }
            
            response = requests.get(NVD_API_BASE, params=params, timeout=30)
            
            if response.status_code == 200:
                data = response.json()
                vulnerabilities = data.get("vulnerabilities", [])
                
                if not vulnerabilities:
                    break
                
                all_cves.extend(vulnerabilities)
                print(f"  Fetched {len(all_cves)} CVEs...")
                
                start_index += results_per_page
                
                # Rate limiting
                import time
                time.sleep(0.6)  # NVD rate limit: 5 requests per 30 seconds without API key
            else:
                print(f"  ⚠️ API returned status {response.status_code}")
                break
                
        except Exception as e:
            print(f"  ⚠️ Error fetching from NVD: {e}")
            break
    
    print(f"  ✅ Total CVEs fetched: {len(all_cves)}")
    return all_cves


def parse_nvd_cve(cve_item: Dict, evony_surfaces: Dict) -> Optional[Dict]:
    """Parse NVD CVE item and check if it matches our criteria"""
    try:
        cve_data = cve_item.get("cve", {})
        cve_id = cve_data.get("id", "")
        
        # Get descriptions
        descriptions = cve_data.get("descriptions", [])
        description = ""
        for desc in descriptions:
            if desc.get("lang") == "en":
                description = desc.get("value", "")
                break
        
        # Check if Flash Player related
        if "flash" not in description.lower() and "flash_player" not in str(cve_data).lower():
            return None
        
        # Get affected versions from configurations
        affected_versions = []
        configurations = cve_data.get("configurations", [])
        for config in configurations:
            for node in config.get("nodes", []):
                for cpe_match in node.get("cpeMatch", []):
                    criteria = cpe_match.get("criteria", "")
                    if "flash_player" in criteria:
                        version_end = cpe_match.get("versionEndIncluding", "")
                        version_start = cpe_match.get("versionStartIncluding", "")
                        if version_end:
                            affected_versions.append(f"up to {version_end}")
                        if version_start:
                            affected_versions.append(f"from {version_start}")
        
        # Build version string for checking
        version_check_str = " ".join(affected_versions) + " " + description
        
        # Check if affects our target version
        if not version_matches_target(version_check_str):
            # Also check explicit CPE for flash_player:10
            cpe_str = str(configurations)
            if "flash_player:10" not in cpe_str and "flash_player:9" not in cpe_str:
                # Check for high version numbers that imply "and earlier"
                if not any(f"flash_player:{v}" in cpe_str for v in range(10, 35)):
                    return None
        
        # Get CVSS score
        cvss_score = 0.0
        severity = "UNKNOWN"
        metrics = cve_data.get("metrics", {})
        
        for cvss_version in ["cvssMetricV31", "cvssMetricV30", "cvssMetricV2"]:
            if cvss_version in metrics:
                cvss_data = metrics[cvss_version][0].get("cvssData", {})
                cvss_score = cvss_data.get("baseScore", 0.0)
                severity = cvss_data.get("baseSeverity", "UNKNOWN")
                break
        
        # Extract surfaces from description
        cve_surfaces = extract_cve_surfaces(description)
        
        # Check if surfaces exist in Evony
        evony_matches = []
        for surface in cve_surfaces:
            if surface in evony_surfaces and evony_surfaces[surface]["found"]:
                evony_matches.append({
                    "surface": surface,
                    "files": evony_surfaces[surface]["files"][:3],
                    "category": evony_surfaces[surface]["category"]
                })
        
        # Determine confidence
        confidence = "LOW"
        if evony_matches:
            confidence = "HIGH"
        elif version_matches_target(version_check_str):
            confidence = "MEDIUM"
        
        return {
            "cve_id": cve_id,
            "description": description[:500],
            "affected_versions": affected_versions[:5],
            "cvss_score": cvss_score,
            "severity": severity,
            "surfaces": cve_surfaces,
            "evony_matches": evony_matches,
            "confidence": confidence,
            "applies_to_evony": len(evony_matches) > 0
        }
        
    except Exception as e:
        return None


def create_training_example(cve: Dict) -> Dict:
    """Create a training example from a validated CVE"""
    
    # Build context about Evony matches
    evony_context = ""
    if cve["evony_matches"]:
        matches_str = ", ".join([m["surface"] for m in cve["evony_matches"]])
        files_str = ", ".join([f for m in cve["evony_matches"] for f in m["files"][:2]])
        evony_context = f"\n\nEvony uses these vulnerable surfaces: {matches_str}\nFound in: {files_str}"
    
    question = f"Explain {cve['cve_id']} and how it relates to the Evony client."
    
    answer = f"""{cve['cve_id']} - {cve['severity']} (CVSS {cve['cvss_score']})

**Description:**
{cve['description']}

**Affected Versions:** {', '.join(cve['affected_versions']) if cve['affected_versions'] else 'Flash Player 10.x and earlier'}

**Vulnerable Surfaces:** {', '.join(cve['surfaces']) if cve['surfaces'] else 'Memory/Type handling'}

**Applies to Evony:** {'Yes' if cve['applies_to_evony'] else 'Potentially'} (Confidence: {cve['confidence']}){evony_context}

**Security Implications:**
This vulnerability affects the Flash Player version that Evony was compiled for (Flash 10.0.x, Flex SDK 3.5). The vulnerable code patterns exist in the Evony client source code."""

    return {
        "messages": [
            {"role": "user", "content": question},
            {"role": "assistant", "content": answer}
        ]
    }


def main():
    print("=" * 60)
    print("FLASH PLAYER CVE FETCHER FOR EVONY")
    print(f"Target: Flash Player 10.0.x (Evony Nov 2009)")
    print(f"Started: {datetime.now()}")
    print("=" * 60)
    
    # Step 1: Scan Evony for vulnerable surfaces
    evony_surfaces = scan_evony_surfaces()
    
    # Save surface scan results
    surfaces_file = CVE_OUTPUT_DIR / "evony_surfaces.json"
    with open(surfaces_file, 'w') as f:
        json.dump(evony_surfaces, f, indent=2)
    print(f"\n💾 Saved surface scan to {surfaces_file.name}")
    
    # Step 2: Fetch CVEs from NVD
    raw_cves = fetch_nvd_cves("adobe flash player", max_results=500)
    
    # Step 3: Parse and filter CVEs
    print("\n🔍 Filtering CVEs for Flash 10.x...")
    validated_cves = []
    
    for cve_item in raw_cves:
        parsed = parse_nvd_cve(cve_item, evony_surfaces)
        if parsed:
            validated_cves.append(parsed)
    
    print(f"  ✅ Validated {len(validated_cves)} CVEs for Flash 10.x")
    
    # Step 4: Sort by relevance
    validated_cves.sort(key=lambda x: (
        -1 if x["applies_to_evony"] else 0,
        -x["cvss_score"],
        x["confidence"]
    ))
    
    # Step 5: Save validated CVEs
    cves_file = CVE_OUTPUT_DIR / "validated_flash_cves.json"
    with open(cves_file, 'w') as f:
        json.dump({
            "metadata": {
                "fetched": datetime.now().isoformat(),
                "target_version": "Flash Player 10.0.x",
                "total_cves": len(validated_cves),
                "high_confidence": len([c for c in validated_cves if c["confidence"] == "HIGH"]),
                "applies_to_evony": len([c for c in validated_cves if c["applies_to_evony"]])
            },
            "cves": validated_cves
        }, f, indent=2)
    print(f"💾 Saved validated CVEs to {cves_file.name}")
    
    # Step 6: Create training examples
    print("\n📝 Creating training examples...")
    training_examples = []
    
    for cve in validated_cves:
        example = create_training_example(cve)
        training_examples.append(example)
    
    # Save training data
    training_file = CVE_OUTPUT_DIR / "train_cve_validated.jsonl"
    with open(training_file, 'w', encoding='utf-8') as f:
        for example in training_examples:
            f.write(json.dumps(example, ensure_ascii=False) + '\n')
    
    print(f"💾 Saved {len(training_examples)} training examples to {training_file.name}")
    
    # Summary
    print("\n" + "=" * 60)
    print("SUMMARY")
    print("=" * 60)
    print(f"  📊 Total CVEs fetched: {len(raw_cves)}")
    print(f"  ✅ Validated for Flash 10.x: {len(validated_cves)}")
    print(f"  🎯 High confidence (Evony match): {len([c for c in validated_cves if c['confidence'] == 'HIGH'])}")
    print(f"  📁 Applies to Evony: {len([c for c in validated_cves if c['applies_to_evony']])}")
    print(f"\n  Output files:")
    print(f"    - {surfaces_file}")
    print(f"    - {cves_file}")
    print(f"    - {training_file}")
    
    return len(validated_cves)


if __name__ == "__main__":
    main()
