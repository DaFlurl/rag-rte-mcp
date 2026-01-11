#!/usr/bin/env python3
"""
SOL File Generator for Evony Age II
Creates config.sol files from account data (CSV or JSON)
Supports batch creation for 500+ accounts with proper node assignment
"""
import os
import sys
import json
import csv
from pathlib import Path
from datetime import datetime

try:
    import pyamf.sol as sol
    HAS_AMF = True
except ImportError:
    HAS_AMF = False
    print("[!] pyamf required: pip install Py3AMF")

# Paths
ETK_ROOT = Path(r"D:\EvonyToolKit")
OUTPUT_DIR = ETK_ROOT / "generated_sols"
CSV_PATH = ETK_ROOT / "scripts" / "khan_Accounts_556" / "khanaccounts.csv"

# Server configurations
SERVERS = {
    "cc2": {"ip": "216.66.17.168", "sid": "375", "alias": "Parapet"},
    "na1": {"ip": "216.66.17.169", "sid": "1", "alias": "NA1"},
    "na2": {"ip": "216.66.17.170", "sid": "2", "alias": "NA2"},
}

def create_sol_data(email: str, password: str, server: str = "cc2", 
                    node: int = 0, proxy_port: int = None) -> dict:
    """Create SOL data structure for an account"""
    
    if proxy_port is None:
        proxy_port = 9999 - node  # Node 0 = port 9999, Node 49 = port 9950
    
    server_info = SERVERS.get(server, SERVERS["cc2"])
    
    return {
        "now": {
            "username": email,
            "password": password,
            "server": server,
            "serverIP": server_info["ip"],
            "sid": server_info["sid"],
            "proxyHost": "127.0.0.1",
            "proxyPort": str(proxy_port),
            "proxyType": "ss5",
            "proxyUn": "",
            "proxyPw": "",
            "loginType": "ev",
            "autoLogin": True,
            "autoRun": True,
            "autoScript": False,
            "autoLoginMinTime": "0",
            "autoLoginMaxTime": "3",
            "theme": "Classic Blue RE",
            "secCode": "",
            "skypeUn": "",
            "skypePw": "",
            "strserverAlias": server_info["alias"],
            "tokenExpires": float('nan')
        }
    }

def write_sol_file(sol_data: dict, output_path: str) -> bool:
    """Write SOL data to a file"""
    if not HAS_AMF:
        return False
    
    try:
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        with open(output_path, 'wb') as f:
            sol.save(sol_data, f, name="config")
        return True
    except Exception as e:
        print(f"[!] Error writing {output_path}: {e}")
        return False

def load_accounts_from_csv(csv_path: str) -> list:
    """Load accounts from CSV file"""
    accounts = []
    
    with open(csv_path, 'r', encoding='utf-8', errors='ignore') as f:
        for line in f:
            parts = line.strip().split(',')
            if len(parts) >= 2:
                email = parts[0].strip()
                password = parts[1].strip()
                
                # Skip status-only entries
                if password.lower() in ['active', 'inactive', 'not working', '']:
                    continue
                
                # Skip if password looks like notes
                if len(password) > 50 or ' ' in password:
                    continue
                
                accounts.append({
                    "email": email,
                    "password": password,
                    "server": "cc2"  # Default server
                })
    
    return accounts

def generate_sol_files(accounts: list, output_dir: str, 
                       accounts_per_node: int = 10) -> dict:
    """Generate SOL files for multiple accounts with node distribution"""
    
    os.makedirs(output_dir, exist_ok=True)
    
    results = {
        "created": 0,
        "failed": 0,
        "files": [],
        "nodes": {}
    }
    
    for i, acc in enumerate(accounts):
        # Assign to node (round-robin across 50 nodes)
        node = (i // accounts_per_node) % 50
        
        if node not in results["nodes"]:
            results["nodes"][node] = []
        
        # Create safe folder name
        safe_email = acc["email"].replace("@", "_at_").replace(".", "_")
        
        # Create SOL data
        sol_data = create_sol_data(
            email=acc["email"],
            password=acc["password"],
            server=acc.get("server", "cc2"),
            node=node
        )
        
        # Create folder structure: output_dir/NodeX/account_name/roboevony.exe/config.sol
        sol_path = os.path.join(
            output_dir, 
            f"Node{node}", 
            safe_email, 
            "roboevony.exe", 
            "config.sol"
        )
        
        if write_sol_file(sol_data, sol_path):
            results["created"] += 1
            results["files"].append(sol_path)
            results["nodes"][node].append(acc["email"])
        else:
            results["failed"] += 1
    
    return results

def generate_batch_script(output_dir: str, nodes: dict) -> str:
    """Generate batch script to copy SOL files to SharedObjects"""
    
    script_path = os.path.join(output_dir, "deploy_sols.bat")
    
    lines = [
        "@echo off",
        "echo Deploying SOL files to SharedObjects...",
        "",
        "REM Get SharedObjects folder ID",
        'set "SO_PATH=%APPDATA%\\Macromedia\\Flash Player\\#SharedObjects"',
        'for /d %%i in ("%SO_PATH%\\*") do set "FOLDER_ID=%%~nxi"',
        'echo Found SharedObjects folder: %FOLDER_ID%',
        "",
        "REM Create target directories and copy files",
    ]
    
    for node in sorted(nodes.keys()):
        lines.append(f"\nREM Node {node} - {len(nodes[node])} accounts")
        lines.append(f'xcopy /E /I /Y "Node{node}" "%SO_PATH%\\%FOLDER_ID%\\localhost\\evony\\Node{node}"')
    
    lines.extend([
        "",
        "echo.",
        "echo Deployment complete!",
        "pause"
    ])
    
    with open(script_path, 'w') as f:
        f.write('\n'.join(lines))
    
    return script_path

def main():
    print("=" * 60)
    print("  SOL File Generator")
    print("  Batch create config.sol for 500+ accounts")
    print("=" * 60)
    print()
    
    if not HAS_AMF:
        print("[!] Cannot proceed without pyamf library")
        return
    
    # Load accounts
    print(f"[*] Loading accounts from: {CSV_PATH}")
    accounts = load_accounts_from_csv(str(CSV_PATH))
    print(f"[+] Loaded {len(accounts)} accounts with valid credentials")
    
    if not accounts:
        print("[!] No valid accounts found")
        return
    
    # Generate SOL files
    output_dir = str(OUTPUT_DIR)
    print(f"\n[*] Generating SOL files to: {output_dir}")
    print(f"[*] Distribution: 10 accounts per node, 50 nodes total")
    
    results = generate_sol_files(accounts, output_dir)
    
    print(f"\n[+] Created: {results['created']} SOL files")
    print(f"[-] Failed: {results['failed']}")
    
    # Show node distribution
    print("\n[+] Node distribution:")
    for node in sorted(results["nodes"].keys())[:10]:
        print(f"    Node {node}: {len(results['nodes'][node])} accounts")
    if len(results["nodes"]) > 10:
        print(f"    ... and {len(results['nodes']) - 10} more nodes")
    
    # Generate deployment script
    script_path = generate_batch_script(output_dir, results["nodes"])
    print(f"\n[+] Deployment script: {script_path}")
    
    # Save summary
    summary_path = os.path.join(output_dir, "generation_summary.json")
    summary = {
        "generated": datetime.now().isoformat(),
        "total_accounts": len(accounts),
        "files_created": results["created"],
        "files_failed": results["failed"],
        "nodes_used": len(results["nodes"]),
        "node_distribution": {str(k): len(v) for k, v in results["nodes"].items()}
    }
    
    with open(summary_path, 'w') as f:
        json.dump(summary, f, indent=2)
    
    print(f"[+] Summary saved: {summary_path}")
    print("\n[*] Done!")
    print("\nNext steps:")
    print("  1. Review generated SOL files in:", output_dir)
    print("  2. Run deploy_sols.bat to copy to SharedObjects")
    print("  3. Start ETK and load accounts by node")


if __name__ == "__main__":
    main()
