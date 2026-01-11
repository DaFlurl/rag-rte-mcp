"""
Batch Account Extractor - Extract ALL 479 accounts
Complete 1:1 dumps for every account
"""

import json
import time
import logging
from pathlib import Path
from datetime import datetime
from concurrent.futures import ThreadPoolExecutor, as_completed

from src.complete_extractor import CompleteExtractor, extract_account

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] %(message)s',
    handlers=[
        logging.FileHandler('data/extraction.log'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

# Paths
ACCOUNTS_FILE = Path("data/final_accounts/FINAL_userpass.txt")
OUTPUT_DIR = Path("data/dumps")
RESULTS_FILE = Path("data/extraction_results.json")


def load_accounts(filepath: Path) -> list:
    """Load accounts from user:pass file"""
    accounts = []
    
    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            
            if ':' in line:
                parts = line.split(':', 1)
                if len(parts) == 2 and '@' in parts[0]:
                    accounts.append({
                        'email': parts[0].strip(),
                        'password': parts[1].strip()
                    })
    
    return accounts


def extract_single(account: dict, server: str = 'cc2') -> dict:
    """Extract single account with error handling"""
    email = account['email']
    password = account['password']
    
    result = {
        'email': email,
        'server': server,
        'success': False,
        'error': None,
        'dump_file': None,
        'data_size': 0,
        'extracted_at': datetime.now().isoformat()
    }
    
    try:
        filepath = extract_account(email, password, server, str(OUTPUT_DIR))
        
        if filepath and filepath.exists():
            result['success'] = True
            result['dump_file'] = str(filepath)
            result['data_size'] = filepath.stat().st_size
            logger.info(f"✓ {email}: {result['data_size']:,} bytes")
        else:
            result['error'] = "No data returned"
            logger.warning(f"✗ {email}: No data")
            
    except Exception as e:
        result['error'] = str(e)
        logger.error(f"✗ {email}: {e}")
    
    return result


def extract_all_accounts(max_workers: int = 1, delay: float = 2.0):
    """
    Extract all accounts sequentially (to avoid rate limiting).
    
    Args:
        max_workers: Number of parallel workers (1 recommended for safety)
        delay: Delay between accounts in seconds
    """
    # Load accounts
    if not ACCOUNTS_FILE.exists():
        logger.error(f"Accounts file not found: {ACCOUNTS_FILE}")
        return
    
    accounts = load_accounts(ACCOUNTS_FILE)
    logger.info(f"Loaded {len(accounts)} accounts to extract")
    
    # Create output dir
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    
    # Results tracking
    results = {
        'started_at': datetime.now().isoformat(),
        'total_accounts': len(accounts),
        'successful': 0,
        'failed': 0,
        'accounts': []
    }
    
    # Process accounts
    for i, account in enumerate(accounts):
        logger.info(f"[{i+1}/{len(accounts)}] Processing {account['email']}...")
        
        result = extract_single(account, server='cc2')
        results['accounts'].append(result)
        
        if result['success']:
            results['successful'] += 1
        else:
            results['failed'] += 1
        
        # Save progress periodically
        if (i + 1) % 10 == 0:
            save_results(results)
            logger.info(f"Progress: {results['successful']} success, {results['failed']} failed")
        
        # Rate limiting
        time.sleep(delay)
    
    # Final save
    results['completed_at'] = datetime.now().isoformat()
    save_results(results)
    
    # Summary
    logger.info("=" * 60)
    logger.info("EXTRACTION COMPLETE")
    logger.info(f"Total: {len(accounts)}")
    logger.info(f"Successful: {results['successful']}")
    logger.info(f"Failed: {results['failed']}")
    logger.info(f"Results saved to: {RESULTS_FILE}")
    logger.info("=" * 60)
    
    return results


def save_results(results: dict):
    """Save results to JSON"""
    with open(RESULTS_FILE, 'w', encoding='utf-8') as f:
        json.dump(results, f, indent=2)


def retry_failed(max_retries: int = 3):
    """Retry failed accounts from previous run"""
    if not RESULTS_FILE.exists():
        logger.error("No previous results found")
        return
    
    with open(RESULTS_FILE, 'r') as f:
        results = json.load(f)
    
    failed = [a for a in results['accounts'] if not a['success']]
    logger.info(f"Retrying {len(failed)} failed accounts...")
    
    for account in failed:
        for attempt in range(max_retries):
            logger.info(f"Retry {attempt+1}/{max_retries}: {account['email']}")
            
            result = extract_single({
                'email': account['email'],
                'password': account.get('password', '')
            })
            
            if result['success']:
                # Update results
                for i, a in enumerate(results['accounts']):
                    if a['email'] == account['email']:
                        results['accounts'][i] = result
                        results['failed'] -= 1
                        results['successful'] += 1
                        break
                break
            
            time.sleep(5)  # Longer delay on retry
    
    save_results(results)
    logger.info(f"After retry: {results['successful']} success, {results['failed']} failed")


if __name__ == "__main__":
    import sys
    
    if len(sys.argv) > 1 and sys.argv[1] == '--retry':
        retry_failed()
    else:
        # Extract all accounts
        extract_all_accounts(max_workers=1, delay=2.0)
