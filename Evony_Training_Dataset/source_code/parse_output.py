"""
PARSE ROBOEVONY EXTRACTION OUTPUT
Parses the console output from BATCH_TROOP_EXTRACT.txt and saves to JSON
"""
import json
import re
from pathlib import Path
from datetime import datetime

def parse_extraction_output(text):
    """Parse the DATA_START to DATA_END block from RoboEvony output"""
    accounts = []
    
    # Find all DATA blocks
    pattern = r'DATA_START\n(.*?)\nDATA_END'
    matches = re.findall(pattern, text, re.DOTALL)
    
    for match in matches:
        data = {}
        for line in match.strip().split('\n'):
            if ',' in line:
                key, value = line.split(',', 1)
                try:
                    data[key] = int(value)
                except ValueError:
                    data[key] = value
        if data:
            accounts.append(data)
    
    return accounts

def main():
    # Read from clipboard or file
    import sys
    
    if len(sys.argv) > 1:
        input_file = Path(sys.argv[1])
        with open(input_file, 'r') as f:
            text = f.read()
    else:
        print("Paste RoboEvony output (Ctrl+Z or Ctrl+D when done):")
        lines = []
        try:
            while True:
                lines.append(input())
        except EOFError:
            pass
        text = '\n'.join(lines)
    
    accounts = parse_extraction_output(text)
    
    if accounts:
        # Save to JSON
        output = Path(r'G:\Evony_UI\fresh_extractions.json')
        
        # Load existing if present
        existing = []
        if output.exists():
            with open(output, 'r') as f:
                existing = json.load(f)
        
        # Add new accounts
        existing.extend(accounts)
        
        with open(output, 'w') as f:
            json.dump(existing, f, indent=2)
        
        print(f"Parsed {len(accounts)} accounts")
        print(f"Saved to: {output}")
        print(f"Total accounts in file: {len(existing)}")
    else:
        print("No DATA blocks found in input")

if __name__ == '__main__':
    main()
