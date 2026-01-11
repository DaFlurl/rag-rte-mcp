import json
import os

# Load the CVE data
with open(r'C:\Users\Admin\Downloads\Evony_Decrypted\CVE_Research\evony_verified_cves.json', 'r') as f:
    data = json.load(f)

cves = data['cves']
print(f"Loaded {len(cves)} CVEs")

# Generate training examples
training_examples = []

for cve in cves:
    cve_id = cve.get('cve_id', '')
    name = cve.get('name', '')
    severity = cve.get('severity', '')
    cvss = cve.get('cvss', 0)
    affected = cve.get('affected', '')
    surface = cve.get('surface', 'Memory')
    confidence = cve.get('confidence', 'HIGH')
    bulletin = cve.get('bulletin', '')
    code_location = cve.get('code_location', '')
    exploited = cve.get('exploited_in_wild', False)
    
    # Example 1: What is this CVE?
    ex1 = {
        "instruction": f"What is {cve_id} and does it affect Evony's Flash 10.0.x client?",
        "input": "",
        "output": f"{cve_id} ({name}) is a {severity} severity vulnerability (CVSS: {cvss}) affecting {affected}. This CVE affects Evony's Flash 10.0.x client because Evony targets Flash 10.0.x which falls within the affected version range. The vulnerability involves {surface} operations. Confidence: {confidence}." + (f" Bulletin: {bulletin}." if bulletin else "") + (" This CVE was exploited in the wild." if exploited else "")
    }
    training_examples.append(ex1)
    
    # Example 2: Surface mapping (for CVEs with code location)
    if code_location:
        ex2 = {
            "instruction": f"Where in Evony's source code is {cve_id} exploitable?",
            "input": "",
            "output": f"{cve_id} ({name}) is exploitable in Evony at {code_location}. This maps to the {surface} attack surface. The vulnerability affects {affected} and has {severity} severity with CVSS {cvss}."
        }
        training_examples.append(ex2)
    
    # Example 3: Severity classification
    if severity == "CRITICAL":
        ex3 = {
            "instruction": f"Is {cve_id} a critical vulnerability for Evony?",
            "input": "",
            "output": f"Yes, {cve_id} ({name}) is CRITICAL severity with CVSS {cvss}. It affects {affected} through {surface} operations. Evony's Flash 10.0.x client is vulnerable." + (" This was actively exploited in the wild." if exploited else "") + (f" Addressed in {bulletin}." if bulletin else "")
        }
        training_examples.append(ex3)

# Save training examples
output_path = r'C:\Users\Admin\Downloads\Evony_Decrypted\CVE_Research\evony_cve_expanded_training.jsonl'
with open(output_path, 'w') as f:
    for ex in training_examples:
        f.write(json.dumps(ex) + '\n')

print(f"Generated {len(training_examples)} training examples")
print(f"Saved to: {output_path}")

# Count by severity
critical = sum(1 for c in cves if c.get('severity') == 'CRITICAL')
high = sum(1 for c in cves if c.get('severity') == 'HIGH')
medium = sum(1 for c in cves if c.get('severity') == 'MEDIUM')
wild = sum(1 for c in cves if c.get('exploited_in_wild'))

print(f"\nCVE Statistics:")
print(f"  CRITICAL: {critical}")
print(f"  HIGH: {high}")
print(f"  MEDIUM: {medium}")
print(f"  Exploited in wild: {wild}")
