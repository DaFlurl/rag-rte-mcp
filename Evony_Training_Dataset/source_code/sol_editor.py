#!/usr/bin/env python3
"""
SOL File Editor for Evony Age II
Reads and edits Flash Local Shared Objects (.sol files)
"""
import os
import sys
import json
import struct
from datetime import datetime
from pathlib import Path

try:
    from pyamf import sol
    HAS_PYAMF = True
except ImportError:
    try:
        from py3amf import sol
        HAS_PYAMF = True
    except ImportError:
        HAS_PYAMF = False

# Default SOL locations
DEFAULT_SOL_PATH = os.path.expandvars(
    r"%AppData%\Macromedia\Flash Player\#SharedObjects"
)

class SOLEditor:
    """Editor for Flash SOL (Local Shared Object) files"""
    
    def __init__(self):
        self.sol_path = DEFAULT_SOL_PATH
        self.current_file = None
        self.data = None
    
    def find_sol_folders(self):
        """Find all SOL folders (unique per PC)"""
        folders = []
        if os.path.exists(self.sol_path):
            for item in os.listdir(self.sol_path):
                full_path = os.path.join(self.sol_path, item)
                if os.path.isdir(full_path):
                    folders.append((item, full_path))
        return folders
    
    def find_sol_files(self, folder_path, pattern="*.sol"):
        """Find all SOL files in a folder recursively"""
        sol_files = []
        for root, dirs, files in os.walk(folder_path):
            for file in files:
                if file.endswith('.sol'):
                    full_path = os.path.join(root, file)
                    sol_files.append(full_path)
        return sol_files
    
    def read_sol(self, file_path):
        """Read a SOL file and return its contents"""
        if not HAS_PYAMF:
            return self._read_sol_raw(file_path)
        
        try:
            with open(file_path, 'rb') as f:
                data = sol.load(f)
            return {
                'success': True,
                'file': file_path,
                'name': data.name if hasattr(data, 'name') else os.path.basename(file_path),
                'data': dict(data) if hasattr(data, 'items') else data
            }
        except Exception as e:
            return self._read_sol_raw(file_path, str(e))
    
    def _read_sol_raw(self, file_path, amf_error=None):
        """Raw SOL file parser (fallback)"""
        try:
            with open(file_path, 'rb') as f:
                data = f.read()
            
            # SOL file structure:
            # 2 bytes: 0x00 0xBF (signature)
            # 4 bytes: file length
            # 4 bytes: "TCSO" magic
            # ... AMF encoded data
            
            result = {
                'success': True,
                'file': file_path,
                'size': len(data),
                'raw_hex': data[:100].hex(),
            }
            
            if len(data) >= 6:
                sig = data[0:2]
                length = struct.unpack('>I', data[2:6])[0]
                result['signature'] = sig.hex()
                result['declared_length'] = length
            
            if len(data) >= 10:
                magic = data[6:10]
                result['magic'] = magic.decode('ascii', errors='replace')
            
            # Extract readable strings
            strings = self._extract_strings(data)
            result['strings'] = strings[:50]  # First 50 strings
            
            if amf_error:
                result['amf_error'] = amf_error
                result['note'] = "AMF parsing failed, showing raw data"
            
            return result
        except Exception as e:
            return {'success': False, 'error': str(e), 'file': file_path}
    
    def _extract_strings(self, data):
        """Extract readable strings from binary data"""
        strings = []
        current = b''
        for byte in data:
            if 32 <= byte <= 126:
                current += bytes([byte])
            else:
                if len(current) >= 4:
                    try:
                        strings.append(current.decode('ascii'))
                    except:
                        pass
                current = b''
        return strings
    
    def write_sol(self, file_path, data, name=None):
        """Write data to a SOL file"""
        if not HAS_PYAMF:
            return {'success': False, 'error': 'py3amf not available for writing'}
        
        try:
            if name is None:
                name = os.path.splitext(os.path.basename(file_path))[0]
            
            with open(file_path, 'wb') as f:
                sol.save(data, f, name=name)
            
            return {'success': True, 'file': file_path}
        except Exception as e:
            return {'success': False, 'error': str(e)}
    
    def export_to_json(self, sol_file, json_file=None):
        """Export SOL file to JSON for easy editing"""
        if json_file is None:
            json_file = sol_file + '.json'
        
        data = self.read_sol(sol_file)
        
        with open(json_file, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, default=str)
        
        return json_file
    
    def list_all_sol_files(self):
        """List all SOL files found on the system"""
        folders = self.find_sol_folders()
        all_files = []
        
        for folder_id, folder_path in folders:
            files = self.find_sol_files(folder_path)
            for f in files:
                rel_path = os.path.relpath(f, folder_path)
                size = os.path.getsize(f)
                mtime = datetime.fromtimestamp(os.path.getmtime(f))
                all_files.append({
                    'folder_id': folder_id,
                    'relative_path': rel_path,
                    'full_path': f,
                    'size': size,
                    'modified': mtime.isoformat()
                })
        
        return all_files


def main():
    print("=" * 60)
    print("  Evony SOL File Editor")
    print("  Flash Local Shared Object Manager")
    print("=" * 60)
    print()
    
    editor = SOLEditor()
    
    # Find SOL folders
    folders = editor.find_sol_folders()
    if not folders:
        print(f"[!] No SOL folders found at: {DEFAULT_SOL_PATH}")
        return
    
    print(f"[+] Found {len(folders)} SOL folder(s):")
    for folder_id, folder_path in folders:
        print(f"    - {folder_id}")
    print()
    
    # List all SOL files
    all_files = editor.list_all_sol_files()
    print(f"[+] Found {len(all_files)} SOL file(s) total")
    
    # Filter for Evony-related files
    evony_files = [f for f in all_files if 'evony' in f['relative_path'].lower() 
                   or 'robo' in f['relative_path'].lower()]
    
    if evony_files:
        print(f"\n[+] Evony-related SOL files ({len(evony_files)}):")
        for f in evony_files[:20]:  # Show first 20
            print(f"    {f['relative_path']} ({f['size']} bytes)")
    
    # Export file list
    output_dir = r"D:\EvonyToolKit\tools\sol_exports"
    os.makedirs(output_dir, exist_ok=True)
    
    list_file = os.path.join(output_dir, "sol_file_list.json")
    with open(list_file, 'w', encoding='utf-8') as f:
        json.dump(all_files, f, indent=2)
    print(f"\n[+] Exported file list to: {list_file}")
    
    # Try to read and export Evony SOL files
    if evony_files:
        print("\n[*] Analyzing Evony SOL files...")
        for f in evony_files[:10]:  # Analyze first 10
            data = editor.read_sol(f['full_path'])
            export_name = f['relative_path'].replace('\\', '_').replace('/', '_')
            export_path = os.path.join(output_dir, export_name + '.json')
            
            with open(export_path, 'w', encoding='utf-8') as outf:
                json.dump(data, outf, indent=2, default=str)
            
            status = "OK" if data.get('success') else "FAIL"
            print(f"    [{status}] {f['relative_path']}")
    
    print(f"\n[+] Exports saved to: {output_dir}")
    print("\n[*] Done!")


if __name__ == "__main__":
    main()
