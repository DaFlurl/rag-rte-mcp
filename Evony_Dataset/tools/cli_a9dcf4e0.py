"""
ETK SOL Manager - Command Line Interface
Run account extraction and data queries from command line
"""

import argparse
import sys
import json
from pathlib import Path
from typing import Optional

from .database import AccountDatabase
from .extractor import AccountExtractor


def print_progress(current: int, total: int, email: str):
    """Print progress bar"""
    percent = (current / total) * 100
    bar_len = 40
    filled = int(bar_len * current / total)
    bar = '█' * filled + '░' * (bar_len - filled)
    print(f"\r[{bar}] {percent:.1f}% - {email[:40]:<40}", end='', flush=True)


def cmd_extract(args):
    """Extract account data"""
    db = AccountDatabase()
    extractor = AccountExtractor(db)
    
    if args.email:
        # Extract single account
        print(f"Extracting data for: {args.email}")
        result = extractor.extract_account(args.email, args.password)
        
        if result.get('extracted'):
            print(f"✓ Successfully extracted data for {args.email}")
            print(f"  Player: {result.get('player_name', 'Unknown')}")
            print(f"  Cities: {len(result.get('cities', []))}")
            print(f"  Server: {result.get('server', 'cc2')}")
        else:
            print(f"✗ Failed to extract: {result.get('error', 'Unknown error')}")
    else:
        # Extract all accounts
        print("Extracting all accounts...")
        results = extractor.extract_all_accounts(print_progress)
        print()  # New line after progress bar
        
        print(f"\nExtraction complete:")
        print(f"  Total accounts: {results['total']}")
        print(f"  Extracted: {results['extracted']}")
        print(f"  Failed: {results['failed']}")
    
    if extractor.errors:
        print(f"\nErrors ({len(extractor.errors)}):")
        for err in extractor.errors[:10]:
            print(f"  - {err}")


def cmd_report(args):
    """Generate account report"""
    db = AccountDatabase()
    extractor = AccountExtractor(db)
    
    if not args.email:
        print("Error: --email is required for report")
        return
    
    report = extractor.get_account_report(args.email)
    
    if args.output:
        with open(args.output, 'w', encoding='utf-8') as f:
            f.write(report)
        print(f"Report saved to: {args.output}")
    else:
        print(report)


def cmd_list(args):
    """List accounts in database"""
    db = AccountDatabase()
    accounts = db.get_all_accounts()
    
    if not accounts:
        print("No accounts in database. Run 'extract' first.")
        return
    
    print(f"\nAccounts in database: {len(accounts)}")
    print("-" * 80)
    print(f"{'Email':<40} {'Player':<15} {'Cities':>6} {'Prestige':>12}")
    print("-" * 80)
    
    for acc in accounts[:args.limit]:
        email = acc.get('email', '')[:38]
        player = acc.get('player_name', '-')[:13] if acc.get('player_name') else '-'
        cities = '-'  # Would need join to get city count
        prestige = f"{acc.get('prestige', 0):,}" if acc.get('prestige') else '-'
        print(f"{email:<40} {player:<15} {cities:>6} {prestige:>12}")
    
    if len(accounts) > args.limit:
        print(f"... and {len(accounts) - args.limit} more accounts")


def cmd_stats(args):
    """Show database statistics"""
    db = AccountDatabase()
    stats = db.get_statistics()
    
    print("\nDatabase Statistics:")
    print("-" * 40)
    for table, count in stats.items():
        print(f"  {table.title():<20} {count:>10,}")


def cmd_export(args):
    """Export account data to JSON"""
    db = AccountDatabase()
    
    if args.email:
        # Export single account
        summary = db.get_account_summary(args.email)
        if not summary:
            print(f"No data found for {args.email}")
            return
        data = summary
    else:
        # Export all accounts
        accounts = db.get_all_accounts()
        data = {'accounts': accounts, 'count': len(accounts)}
    
    output_path = args.output or Path(f"D:\\EvonyToolKit\\data\\export_{args.email or 'all'}.json")
    
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, default=str)
    
    print(f"Exported to: {output_path}")


def cmd_query(args):
    """Run custom query"""
    db = AccountDatabase()
    
    query = args.sql
    if not query:
        print("Error: --sql is required")
        return
    
    try:
        with db.get_connection() as conn:
            cursor = conn.cursor()
            cursor.execute(query)
            rows = cursor.fetchall()
            
            if rows:
                # Print headers
                headers = [desc[0] for desc in cursor.description]
                print("\t".join(headers))
                print("-" * (len(headers) * 15))
                
                # Print rows
                for row in rows[:args.limit]:
                    print("\t".join(str(v) for v in row))
                
                if len(rows) > args.limit:
                    print(f"... {len(rows) - args.limit} more rows")
            else:
                print("No results")
    except Exception as e:
        print(f"Query error: {e}")


def cmd_borg(args):
    """Extract Borg's account specifically (demo/test)"""
    db = AccountDatabase()
    extractor = AccountExtractor(db)
    
    # Find Borg's account (look for "borg" in player name or email)
    print("Searching for Borg's account...")
    
    # Check CSV for borg-related accounts
    csv_path = Path(r"D:\EvonyToolKit\scripts\khan_Accounts_556\khanaccounts.csv")
    if csv_path.exists():
        accounts = extractor.load_from_csv(csv_path)
        for acc in accounts:
            if 'borg' in acc['email'].lower():
                print(f"Found: {acc['email']}")
                result = extractor.extract_account(acc['email'], acc.get('password'))
                if result.get('extracted'):
                    print("\n" + extractor.get_account_report(acc['email']))
                return
    
    # Also check SOL files
    for base_path in [extractor.SYSTEM_SOL_PATH, extractor.PROJECT_SOL_PATH]:
        if not base_path.exists():
            continue
        for config_path in base_path.rglob("config.sol"):
            config_data = extractor.extract_config_sol(config_path)
            email = config_data.get('email', '')
            if 'borg' in email.lower():
                print(f"Found: {email}")
                result = extractor.extract_account(email, config_data.get('password'))
                if result.get('extracted'):
                    print("\n" + extractor.get_account_report(email))
                return
    
    print("Borg's account not found in available data")


def run_extraction():
    """Main entry point for CLI"""
    parser = argparse.ArgumentParser(
        description='ETK SOL Manager - Account Data Extraction Tool',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python -m sol_manager.extractor extract              # Extract all accounts
  python -m sol_manager.extractor extract -e user@email.com  # Extract single account
  python -m sol_manager.extractor report -e user@email.com   # Generate report
  python -m sol_manager.extractor list                 # List all accounts
  python -m sol_manager.extractor stats                # Show statistics
  python -m sol_manager.extractor borg                 # Extract Borg's account
        """
    )
    
    subparsers = parser.add_subparsers(dest='command', help='Command to run')
    
    # Extract command
    extract_parser = subparsers.add_parser('extract', help='Extract account data')
    extract_parser.add_argument('-e', '--email', help='Email to extract (or all if not specified)')
    extract_parser.add_argument('-p', '--password', help='Password (optional)')
    extract_parser.set_defaults(func=cmd_extract)
    
    # Report command
    report_parser = subparsers.add_parser('report', help='Generate account report')
    report_parser.add_argument('-e', '--email', required=True, help='Email to report')
    report_parser.add_argument('-o', '--output', help='Output file')
    report_parser.set_defaults(func=cmd_report)
    
    # List command
    list_parser = subparsers.add_parser('list', help='List accounts in database')
    list_parser.add_argument('-l', '--limit', type=int, default=50, help='Limit results')
    list_parser.set_defaults(func=cmd_list)
    
    # Stats command
    stats_parser = subparsers.add_parser('stats', help='Show database statistics')
    stats_parser.set_defaults(func=cmd_stats)
    
    # Export command
    export_parser = subparsers.add_parser('export', help='Export data to JSON')
    export_parser.add_argument('-e', '--email', help='Email to export (or all if not specified)')
    export_parser.add_argument('-o', '--output', help='Output file')
    export_parser.set_defaults(func=cmd_export)
    
    # Query command
    query_parser = subparsers.add_parser('query', help='Run custom SQL query')
    query_parser.add_argument('--sql', required=True, help='SQL query to run')
    query_parser.add_argument('-l', '--limit', type=int, default=100, help='Limit results')
    query_parser.set_defaults(func=cmd_query)
    
    # Borg command (special test)
    borg_parser = subparsers.add_parser('borg', help="Extract Borg's account")
    borg_parser.set_defaults(func=cmd_borg)
    
    args = parser.parse_args()
    
    if not args.command:
        parser.print_help()
        return
    
    args.func(args)


if __name__ == '__main__':
    run_extraction()
