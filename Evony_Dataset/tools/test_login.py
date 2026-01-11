#!/usr/bin/env python3
"""
BORG TOOLKIT - Login Test Script
Tests the login validation system with sample accounts
"""

import sys
import logging
from pathlib import Path

# Add src to path
sys.path.insert(0, str(Path(__file__).parent))

from src.login_validator import LoginValidator, validate_from_file

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] %(message)s'
)

def test_single_account():
    """Test validating a single account"""
    print("=" * 60)
    print("  BORG TOOLKIT - Login Validation Test")
    print("=" * 60)
    
    validator = LoginValidator(max_retries=3, retry_delay=2.0)
    
    # Add Tor proxies
    validator.add_tor_proxies(base_port=9000, count=10)
    
    # Test with a sample account (will fail but tests the flow)
    result = validator.validate_account(
        email="test@example.com",
        password="testpass",
        server="cc2"
    )
    
    print(f"\nResult: {result}")
    print(f"Stats: {validator.get_stats()}")
    
    return result

def test_file_validation():
    """Test validating accounts from file"""
    print("=" * 60)
    print("  BORG TOOLKIT - File Validation Test")
    print("=" * 60)
    
    # Use the generated userpass file
    login_dir = Path(__file__).parent / "data" / "login_files"
    userpass_files = list(login_dir.glob("userpass_*.txt"))
    
    if not userpass_files:
        print("[!] No userpass files found. Run generate_login_files.py first.")
        return None
    
    input_file = sorted(userpass_files)[-1]  # Most recent
    print(f"Using: {input_file}")
    
    # Only test first 5 accounts
    accounts = []
    with open(input_file, 'r') as f:
        for i, line in enumerate(f):
            if i >= 5:
                break
            line = line.strip()
            if ':' in line:
                email, password = line.split(':', 1)
                accounts.append({'email': email, 'password': password, 'server': 'cc2'})
    
    print(f"Testing {len(accounts)} accounts...")
    
    validator = LoginValidator(max_retries=2, retry_delay=1.0)
    validator.add_tor_proxies(base_port=9000, count=5)
    
    results = validator.validate_accounts(accounts)
    paths = validator.save_results()
    
    print(f"\nStats: {validator.get_stats()}")
    print(f"Results saved to: {paths}")
    
    return results

def main():
    print("\n" + "=" * 60)
    print("  Choose test mode:")
    print("  1. Single account test (connection test)")
    print("  2. File validation test (first 5 accounts)")
    print("  3. Full validation (all accounts)")
    print("=" * 60)
    
    choice = input("\nEnter choice (1/2/3): ").strip()
    
    if choice == "1":
        test_single_account()
    elif choice == "2":
        test_file_validation()
    elif choice == "3":
        login_dir = Path(__file__).parent / "data" / "login_files"
        userpass_files = list(login_dir.glob("userpass_*.txt"))
        if userpass_files:
            input_file = sorted(userpass_files)[-1]
            result = validate_from_file(input_file, max_retries=5, use_tor=True)
            print(f"\nResults: {result}")
        else:
            print("[!] No userpass files found.")
    else:
        print("Invalid choice")

if __name__ == '__main__':
    main()
