"""
Account Parser - Multi-Format Account File Parser

Parses account credentials from multiple file formats:
- TXT (plain text, various formats)
- XLSX/XLS (Excel spreadsheets)
- DOCX (Word documents)
- RTF (Rich Text Format)
- PDF (PDF documents)
- JSON (structured data)
- CSV (comma-separated)

Searches evony folders and other locations for account files.
"""

import logging
import os
import re
import json
from dataclasses import dataclass, field
from datetime import datetime
from pathlib import Path
from typing import Dict, Optional, List, Any, Tuple
import glob

logger = logging.getLogger(__name__)


@dataclass
class AccountCredential:
    """Single account credential"""
    username: str
    password: str = ""
    email: str = ""
    server: str = ""
    world: str = ""
    notes: str = ""
    source_file: str = ""
    last_modified: Optional[datetime] = None
    
    @property
    def is_valid(self) -> bool:
        return bool(self.username and (self.password or self.email))


@dataclass
class AccountFile:
    """Parsed account file"""
    path: str
    format: str
    accounts: List[AccountCredential] = field(default_factory=list)
    modified: Optional[datetime] = None
    parse_errors: List[str] = field(default_factory=list)


class AccountParser:
    """
    Multi-format account file parser.
    
    Features:
    - Parse TXT, XLSX, DOCX, RTF, PDF, JSON, CSV
    - Auto-detect account patterns
    - Search evony folders recursively
    - Sort by modification date (newest first)
    - Handle various credential formats
    """
    
    # Common account patterns in text
    PATTERNS = {
        # username:password
        "colon_separated": re.compile(
            r'^([A-Za-z0-9_@.]+)\s*:\s*([A-Za-z0-9!@#$%^&*()_+=\-]+)$',
            re.MULTILINE
        ),
        # username / password
        "slash_separated": re.compile(
            r'^([A-Za-z0-9_@.]+)\s*/\s*([A-Za-z0-9!@#$%^&*()_+=\-]+)$',
            re.MULTILINE
        ),
        # email:password
        "email_password": re.compile(
            r'^([A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,})\s*:\s*(.+)$',
            re.MULTILINE
        ),
        # Username: xxx Password: xxx
        "labeled": re.compile(
            r'[Uu]sername\s*[:=]\s*([A-Za-z0-9_@.]+).*?[Pp]assword\s*[:=]\s*([^\s\n]+)',
            re.DOTALL
        ),
        # user=xxx pass=xxx
        "equals_format": re.compile(
            r'user(?:name)?\s*=\s*([A-Za-z0-9_@.]+).*?pass(?:word)?\s*=\s*([^\s\n]+)',
            re.DOTALL | re.IGNORECASE
        ),
        # JSON-like in text
        "json_like": re.compile(
            r'"(?:user|username|email)":\s*"([^"]+)".*?"(?:pass|password)":\s*"([^"]+)"',
            re.DOTALL | re.IGNORECASE
        ),
    }
    
    # Default search paths
    DEFAULT_PATHS = [
        r"D:\Users\Admin\Desktop\evony_2024",
        r"D:\Users\Admin\Desktop\evony",
        r"D:\Users\Admin\Desktop\ETK accounts",
        r"D:\Users\Admin\Desktop\mark evony accounts",
        r"D:\Users\marki\Desktop\evony",
        r"D:\Users\marki\Desktop\ETK accounts",
        r"D:\Users\marki\Desktop\evony\khan\accounts",
    ]
    
    # Supported extensions
    SUPPORTED_EXTENSIONS = [
        ".txt", ".xlsx", ".xls", ".docx", ".doc",
        ".rtf", ".pdf", ".json", ".csv"
    ]
    
    def __init__(self):
        self._accounts: Dict[str, AccountCredential] = {}
        self._files: List[AccountFile] = []
        self._search_paths: List[str] = list(self.DEFAULT_PATHS)
        
    def add_search_path(self, path: str):
        """Add a search path"""
        if path not in self._search_paths:
            self._search_paths.append(path)
            
    def search_and_parse(self, paths: List[str] = None) -> List[AccountFile]:
        """Search paths and parse all account files"""
        paths = paths or self._search_paths
        
        all_files = []
        for base_path in paths:
            if not os.path.exists(base_path):
                continue
                
            # Find all supported files
            for ext in self.SUPPORTED_EXTENSIONS:
                pattern = os.path.join(base_path, "**", f"*{ext}")
                files = glob.glob(pattern, recursive=True)
                all_files.extend(files)
                
        # Parse each file
        parsed = []
        for file_path in all_files:
            try:
                result = self.parse_file(file_path)
                if result and result.accounts:
                    parsed.append(result)
            except Exception as e:
                logger.debug(f"Failed to parse {file_path}: {e}")
                
        # Sort by modification date (newest first)
        parsed.sort(key=lambda x: x.modified or datetime.min, reverse=True)
        
        self._files = parsed
        return parsed
        
    def parse_file(self, file_path: str) -> Optional[AccountFile]:
        """Parse a single file based on extension"""
        if not os.path.exists(file_path):
            return None
            
        ext = os.path.splitext(file_path)[1].lower()
        modified = datetime.fromtimestamp(os.path.getmtime(file_path))
        
        result = AccountFile(
            path=file_path,
            format=ext,
            modified=modified,
        )
        
        try:
            if ext == ".txt":
                result.accounts = self._parse_txt(file_path)
            elif ext in [".xlsx", ".xls"]:
                result.accounts = self._parse_excel(file_path)
            elif ext in [".docx", ".doc"]:
                result.accounts = self._parse_docx(file_path)
            elif ext == ".rtf":
                result.accounts = self._parse_rtf(file_path)
            elif ext == ".pdf":
                result.accounts = self._parse_pdf(file_path)
            elif ext == ".json":
                result.accounts = self._parse_json(file_path)
            elif ext == ".csv":
                result.accounts = self._parse_csv(file_path)
                
            # Set source file for all accounts
            for acc in result.accounts:
                acc.source_file = file_path
                acc.last_modified = modified
                
        except Exception as e:
            result.parse_errors.append(str(e))
            logger.debug(f"Parse error in {file_path}: {e}")
            
        return result
        
    # ========== Format-Specific Parsers ==========
    
    def _parse_txt(self, file_path: str) -> List[AccountCredential]:
        """Parse plain text file"""
        accounts = []
        
        try:
            # Try different encodings
            content = None
            for encoding in ['utf-8', 'utf-16', 'latin-1', 'cp1252']:
                try:
                    with open(file_path, 'r', encoding=encoding) as f:
                        content = f.read()
                    break
                except UnicodeDecodeError:
                    continue
                    
            if not content:
                return accounts
                
            # Try each pattern
            for pattern_name, pattern in self.PATTERNS.items():
                matches = pattern.findall(content)
                for match in matches:
                    if len(match) >= 2:
                        username, password = match[0], match[1]
                        # Skip if looks like a comment or header
                        if username.lower() in ['username', 'user', 'email', 'login']:
                            continue
                        accounts.append(AccountCredential(
                            username=username.strip(),
                            password=password.strip(),
                        ))
                        
        except Exception as e:
            logger.debug(f"TXT parse error: {e}")
            
        return accounts
        
    def _parse_excel(self, file_path: str) -> List[AccountCredential]:
        """Parse Excel file (xlsx/xls)"""
        accounts = []
        
        try:
            import openpyxl
            
            wb = openpyxl.load_workbook(file_path, data_only=True)
            
            for sheet in wb.worksheets:
                # Look for header row
                headers = {}
                for col_idx, cell in enumerate(sheet[1]):
                    if cell.value:
                        header = str(cell.value).lower().strip()
                        if 'user' in header or 'email' in header or 'login' in header:
                            headers['username'] = col_idx
                        elif 'pass' in header or 'pwd' in header:
                            headers['password'] = col_idx
                        elif 'server' in header or 'world' in header:
                            headers['server'] = col_idx
                            
                # Parse data rows
                if 'username' in headers:
                    for row in sheet.iter_rows(min_row=2):
                        username = row[headers['username']].value
                        password = row[headers.get('password', 0)].value if 'password' in headers else ""
                        server = row[headers.get('server', 0)].value if 'server' in headers else ""
                        
                        if username:
                            accounts.append(AccountCredential(
                                username=str(username).strip(),
                                password=str(password).strip() if password else "",
                                server=str(server).strip() if server else "",
                            ))
                            
        except ImportError:
            logger.debug("openpyxl not installed, skipping Excel files")
        except Exception as e:
            logger.debug(f"Excel parse error: {e}")
            
        return accounts
        
    def _parse_docx(self, file_path: str) -> List[AccountCredential]:
        """Parse Word document"""
        accounts = []
        
        try:
            from docx import Document
            
            doc = Document(file_path)
            full_text = "\n".join([para.text for para in doc.paragraphs])
            
            # Also check tables
            for table in doc.tables:
                for row in table.rows:
                    row_text = " ".join([cell.text for cell in row.cells])
                    full_text += "\n" + row_text
                    
            # Use text patterns on extracted content
            for pattern_name, pattern in self.PATTERNS.items():
                matches = pattern.findall(full_text)
                for match in matches:
                    if len(match) >= 2:
                        accounts.append(AccountCredential(
                            username=match[0].strip(),
                            password=match[1].strip(),
                        ))
                        
        except ImportError:
            logger.debug("python-docx not installed, skipping DOCX files")
        except Exception as e:
            logger.debug(f"DOCX parse error: {e}")
            
        return accounts
        
    def _parse_rtf(self, file_path: str) -> List[AccountCredential]:
        """Parse RTF file"""
        accounts = []
        
        try:
            # Simple RTF text extraction
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
                
            # Remove RTF control codes
            import re
            text = re.sub(r'\\[a-z]+\d*\s?', '', content)
            text = re.sub(r'[{}]', '', text)
            
            # Use text patterns
            for pattern_name, pattern in self.PATTERNS.items():
                matches = pattern.findall(text)
                for match in matches:
                    if len(match) >= 2:
                        accounts.append(AccountCredential(
                            username=match[0].strip(),
                            password=match[1].strip(),
                        ))
                        
        except Exception as e:
            logger.debug(f"RTF parse error: {e}")
            
        return accounts
        
    def _parse_pdf(self, file_path: str) -> List[AccountCredential]:
        """Parse PDF file"""
        accounts = []
        
        try:
            import PyPDF2
            
            with open(file_path, 'rb') as f:
                reader = PyPDF2.PdfReader(f)
                text = ""
                for page in reader.pages:
                    text += page.extract_text() + "\n"
                    
            # Use text patterns
            for pattern_name, pattern in self.PATTERNS.items():
                matches = pattern.findall(text)
                for match in matches:
                    if len(match) >= 2:
                        accounts.append(AccountCredential(
                            username=match[0].strip(),
                            password=match[1].strip(),
                        ))
                        
        except ImportError:
            logger.debug("PyPDF2 not installed, skipping PDF files")
        except Exception as e:
            logger.debug(f"PDF parse error: {e}")
            
        return accounts
        
    def _parse_json(self, file_path: str) -> List[AccountCredential]:
        """Parse JSON file"""
        accounts = []
        
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                data = json.load(f)
                
            # Handle different JSON structures
            if isinstance(data, list):
                for item in data:
                    acc = self._extract_from_dict(item)
                    if acc:
                        accounts.append(acc)
            elif isinstance(data, dict):
                # Check for accounts array
                for key in ['accounts', 'users', 'credentials', 'data']:
                    if key in data and isinstance(data[key], list):
                        for item in data[key]:
                            acc = self._extract_from_dict(item)
                            if acc:
                                accounts.append(acc)
                        break
                else:
                    # Single account in dict
                    acc = self._extract_from_dict(data)
                    if acc:
                        accounts.append(acc)
                        
        except Exception as e:
            logger.debug(f"JSON parse error: {e}")
            
        return accounts
        
    def _parse_csv(self, file_path: str) -> List[AccountCredential]:
        """Parse CSV file"""
        accounts = []
        
        try:
            import csv
            
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                reader = csv.DictReader(f)
                
                for row in reader:
                    # Normalize keys
                    row_lower = {k.lower().strip(): v for k, v in row.items()}
                    
                    username = (
                        row_lower.get('username') or 
                        row_lower.get('user') or 
                        row_lower.get('email') or
                        row_lower.get('login')
                    )
                    password = (
                        row_lower.get('password') or 
                        row_lower.get('pass') or 
                        row_lower.get('pwd')
                    )
                    
                    if username:
                        accounts.append(AccountCredential(
                            username=username.strip(),
                            password=password.strip() if password else "",
                            server=row_lower.get('server', '').strip(),
                        ))
                        
        except Exception as e:
            logger.debug(f"CSV parse error: {e}")
            
        return accounts
        
    def _extract_from_dict(self, data: dict) -> Optional[AccountCredential]:
        """Extract account from dictionary"""
        if not isinstance(data, dict):
            return None
            
        # Normalize keys
        data_lower = {k.lower(): v for k, v in data.items()}
        
        username = (
            data_lower.get('username') or 
            data_lower.get('user') or 
            data_lower.get('email') or
            data_lower.get('login') or
            data_lower.get('name')
        )
        password = (
            data_lower.get('password') or 
            data_lower.get('pass') or 
            data_lower.get('pwd')
        )
        
        if username:
            return AccountCredential(
                username=str(username).strip(),
                password=str(password).strip() if password else "",
                server=str(data_lower.get('server', '')).strip(),
                world=str(data_lower.get('world', '')).strip(),
                email=str(data_lower.get('email', '')).strip(),
            )
            
        return None
        
    # ========== Account Management ==========
    
    def get_all_accounts(self) -> List[AccountCredential]:
        """Get all parsed accounts (deduplicated)"""
        seen = set()
        unique = []
        
        for file in self._files:
            for acc in file.accounts:
                key = (acc.username.lower(), acc.server.lower())
                if key not in seen:
                    seen.add(key)
                    unique.append(acc)
                    
        return unique
        
    def get_accounts_by_server(self, server: str) -> List[AccountCredential]:
        """Get accounts for specific server"""
        return [
            acc for acc in self.get_all_accounts()
            if server.lower() in acc.server.lower()
        ]
        
    def get_newest_file(self) -> Optional[AccountFile]:
        """Get most recently modified account file"""
        if self._files:
            return self._files[0]  # Already sorted by date
        return None
        
    def export_to_json(self, output_path: str):
        """Export all accounts to JSON"""
        accounts = [
            {
                "username": acc.username,
                "password": acc.password,
                "email": acc.email,
                "server": acc.server,
                "world": acc.world,
                "source": acc.source_file,
            }
            for acc in self.get_all_accounts()
        ]
        
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(accounts, f, indent=2)
            
    def get_statistics(self) -> Dict:
        """Get parser statistics"""
        all_accounts = self.get_all_accounts()
        
        return {
            "files_parsed": len(self._files),
            "total_accounts": len(all_accounts),
            "unique_accounts": len(all_accounts),
            "by_format": {
                ext: len([f for f in self._files if f.format == ext])
                for ext in self.SUPPORTED_EXTENSIONS
            },
            "newest_file": self._files[0].path if self._files else None,
            "search_paths": self._search_paths,
        }


# Singleton
_parser: Optional[AccountParser] = None

def get_account_parser() -> AccountParser:
    """Get singleton account parser"""
    global _parser
    if _parser is None:
        _parser = AccountParser()
    return _parser
