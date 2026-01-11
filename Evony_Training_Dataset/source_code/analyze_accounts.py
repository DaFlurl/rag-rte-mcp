"""
Account Analysis Script
Analyzes all config.sol files to find unique accounts
"""

import os
from pathlib import Path
from collections import defaultdict
import pyamf.sol

def analyze_accounts():
    # System Macromedia path
    system_path = Path(r'C:\Users\Admin\AppData\Roaming\Macromedia\Flash Player\#SharedObjects\YUGK6X86')
    
    # Also check project Macromedia path
    project_path = Path(r'D:\EvonyToolKit\Macromedia\Flash Player\#SharedObjects')
    
    # Find all config.sol files from both locations
    config_files = []
    if system_path.exists():
        config_files.extend(list(system_path.rglob('config.sol')))
    if project_path.exists():
        config_files.extend(list(project_path.rglob('config.sol')))
    
    print(f'Total config.sol files found: {len(config_files)}')
    
    # Extract emails
    emails = {}
    errors = 0
    
    for config_path in config_files:
        try:
            with open(config_path, 'rb') as f:
                result = pyamf.sol.decode(f)
            
            # pyamf.sol.decode returns tuple: (name, data_dict)
            if isinstance(result, tuple) and len(result) >= 2:
                data = result[1]
            else:
                data = result
            
            if isinstance(data, dict) and 'now' in data and 'username' in data['now']:
                email = data['now'].get('username', '')
                password = data['now'].get('password', '')
                server = data['now'].get('server', '')
                proxy_port = data['now'].get('proxyPort', '')
                
                if email:
                    key = email.lower()
                    if key not in emails:
                        emails[key] = {
                            'email': email,
                            'password': password,
                            'server': server,
                            'proxy_port': proxy_port,
                            'paths': []
                        }
                    emails[key]['paths'].append(str(config_path.parent))
                    # Update password if this one has it and previous didn't
                    if password and not emails[key]['password']:
                        emails[key]['password'] = password
        except Exception as e:
            errors += 1
    
    print(f'Errors reading files: {errors}')
    print(f'Unique email accounts: {len(emails)}')
    
    has_pass = sum(1 for e in emails.values() if e['password'])
    print(f'Accounts WITH password: {has_pass}')
    print(f'Accounts WITHOUT password: {len(emails) - has_pass}')
    print()
    
    # Count duplicates
    dups = sum(1 for e in emails.values() if len(e['paths']) > 1)
    print(f'Accounts with multiple copies: {dups}')
    print()
    
    # Show accounts with passwords
    print('=' * 80)
    print('ACCOUNTS WITH PASSWORDS (ready to test):')
    print('=' * 80)
    count = 0
    for key, acc in sorted(emails.items()):
        if acc['password']:
            count += 1
            copies = len(acc['paths'])
            dup_mark = f' [{copies} copies]' if copies > 1 else ''
            print(f'{count:3}. {acc["email"]:40} | {acc["server"]:5} | port:{acc["proxy_port"]}{dup_mark}')
    
    print()
    print('=' * 80)
    print('ACCOUNTS WITHOUT PASSWORDS:')
    print('=' * 80)
    count = 0
    for key, acc in sorted(emails.items()):
        if not acc['password']:
            count += 1
            if count <= 50:  # Only show first 50
                print(f'{count:3}. {acc["email"]:40} | {acc["server"]:5}')
    
    if count > 50:
        print(f'... and {count - 50} more')
    
    return emails

if __name__ == '__main__':
    analyze_accounts()
