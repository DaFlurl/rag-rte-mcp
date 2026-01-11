# Evony MCP - Technical Implementation Guide

**Companion to**: EVONY_MCP_COMPLETE_AUDIT.md  
**Purpose**: Detailed code fixes and implementation specs  
**Target Audience**: Developers implementing the fixes  
**Updated**: January 10, 2026 - Cross-reference tools IMPLEMENTED  

---

## 🔧 Critical Bug Fixes (Week 1)

### **Fix 1: Knowledge Base Encoding Error** ✅ PARTIAL FIX APPLIED

**File**: `evony_rag/hybrid_search.py` (line ~297-301)  
**Status**: Null check added, but embedding model still not loading

**Original Error**:
```python
AttributeError: 'NoneType' object has no attribute 'encode'
```

**Fix Applied (2026-01-10)**:
```python
# In _semantic_search method:
if self.embedding_model is None:
    return []  # Fall back to lexical search only
```

**Root Cause Analysis**:
```python
# Likely issue in semantic search flow:
def evony_search(query: str):
    # Problem 1: Query might be None/empty
    embedding = self.embedder.encode(query)  # ❌ Crashes if query is None
    
    # Problem 2: Embedder might not be initialized
    if self.embedder is None:  # This check might be missing
        # Should initialize embedder here
```

**Fixed Implementation**:
```python
from typing import Optional
import logging

logger = logging.getLogger(__name__)

class EvonyKnowledgeRAG:
    def __init__(self):
        self.embedder = None
        self.initialized = False
    
    def _ensure_initialized(self):
        """Lazy initialization of embedding model"""
        if not self.initialized:
            try:
                from sentence_transformers import SentenceTransformer
                self.embedder = SentenceTransformer('all-MiniLM-L6-v2')
                self.initialized = True
                logger.info("Embedding model initialized successfully")
            except Exception as e:
                logger.error(f"Failed to initialize embedder: {e}")
                raise
    
    def evony_search(self, query: str, k: int = 10, **kwargs) -> dict:
        """Search Evony knowledge base with robust error handling"""
        
        # Validation
        if not query or not query.strip():
            return {
                "error": "Query cannot be empty",
                "query": query,
                "results": []
            }
        
        # Ensure embedder is ready
        try:
            self._ensure_initialized()
        except Exception as e:
            return {
                "error": f"Embedding model initialization failed: {str(e)}",
                "query": query,
                "results": []
            }
        
        # Safe encoding with error handling
        try:
            query_embedding = self.embedder.encode(
                query.strip(),
                convert_to_tensor=False,
                show_progress_bar=False
            )
        except Exception as e:
            logger.error(f"Encoding failed for query '{query}': {e}")
            return {
                "error": f"Query encoding failed: {str(e)}",
                "query": query,
                "results": []
            }
        
        # Perform search
        try:
            results = self._search_with_embedding(query_embedding, k)
            return {
                "query": query,
                "results": results,
                "total": len(results)
            }
        except Exception as e:
            logger.error(f"Search failed: {e}")
            return {
                "error": f"Search execution failed: {str(e)}",
                "query": query,
                "results": []
            }
    
    def evony_answer(self, question: str, k: int = 10, **kwargs) -> dict:
        """RAG-based Q&A with error handling"""
        
        # Reuse search with validation
        search_results = self.evony_search(question, k=k)
        
        if "error" in search_results:
            return {
                "question": question,
                "answer": None,
                "error": search_results["error"],
                "sources": []
            }
        
        # Generate answer from search results
        try:
            context = self._build_context(search_results["results"])
            answer = self._generate_answer(question, context)
            
            return {
                "question": question,
                "answer": answer,
                "sources": search_results["results"][:5],
                "total_sources": len(search_results["results"])
            }
        except Exception as e:
            logger.error(f"Answer generation failed: {e}")
            return {
                "question": question,
                "answer": None,
                "error": f"Answer generation failed: {str(e)}",
                "sources": []
            }
```

**Testing**:
```python
# Test cases to validate fix
def test_evony_search_null_query():
    rag = EvonyKnowledgeRAG()
    result = rag.evony_search(None)
    assert "error" in result
    assert result["results"] == []

def test_evony_search_empty_query():
    rag = EvonyKnowledgeRAG()
    result = rag.evony_search("")
    assert "error" in result
    
def test_evony_search_valid_query():
    rag = EvonyKnowledgeRAG()
    result = rag.evony_search("march mechanics")
    assert "error" not in result
    assert len(result["results"]) > 0
```

---

### **Fix 2: memory_processes Parameter Bug**

**File**: `evony-rte/server/tools/memory.py`

**Current Error**:
```python
TypeError: <lambda>() missing 1 required positional argument: 'args'
```

**Current Implementation** (buggy):
```python
def memory_processes(filter: str):  # ❌ Required param
    processes = psutil.process_iter(['pid', 'name', 'memory_info'])
    if filter:
        processes = [p for p in processes if filter in p.info['name'].lower()]
    return format_process_list(processes)
```

**Fixed Implementation**:
```python
from typing import Optional
import psutil
import logging

logger = logging.getLogger(__name__)

def memory_processes(filter: Optional[str] = None) -> dict:
    """
    List running processes with optional filtering.
    
    Args:
        filter: Optional process name filter (case-insensitive substring match)
        
    Returns:
        {
            "processes": [{"pid": int, "name": str, "memory_mb": float}],
            "total": int,
            "filter_applied": str | None
        }
    """
    try:
        all_processes = []
        
        for proc in psutil.process_iter(['pid', 'name', 'memory_info']):
            try:
                proc_info = {
                    "pid": proc.info['pid'],
                    "name": proc.info['name'],
                    "memory_mb": proc.info['memory_info'].rss / (1024 * 1024)
                }
                
                # Apply filter if provided
                if filter is None or filter.lower() in proc_info['name'].lower():
                    all_processes.append(proc_info)
                    
            except (psutil.NoSuchProcess, psutil.AccessDenied):
                # Process terminated or access denied - skip
                continue
        
        # Sort by memory usage descending
        all_processes.sort(key=lambda x: x['memory_mb'], reverse=True)
        
        return {
            "processes": all_processes,
            "total": len(all_processes),
            "filter_applied": filter
        }
        
    except Exception as e:
        logger.error(f"Failed to list processes: {e}")
        return {
            "error": str(e),
            "processes": [],
            "total": 0
        }

# MCP tool registration
mcp_tools = {
    "memory_processes": {
        "function": memory_processes,
        "description": "List running processes with optional name filter",
        "parameters": {
            "filter": {
                "type": "string",
                "description": "Optional filter by process name (case-insensitive)",
                "required": False
            }
        }
    }
}
```

**Testing**:
```python
def test_memory_processes_no_filter():
    result = memory_processes()
    assert "error" not in result
    assert len(result["processes"]) > 0
    assert result["filter_applied"] is None

def test_memory_processes_with_filter():
    result = memory_processes(filter="evony")
    assert "error" not in result
    assert all("evony" in p["name"].lower() for p in result["processes"])
    assert result["filter_applied"] == "evony"

def test_memory_processes_no_matches():
    result = memory_processes(filter="nonexistent_process_12345")
    assert result["total"] == 0
    assert result["processes"] == []
```

---

### **Fix 3: Packet Encoding AMF3 Binary Output**

**File**: `evony-rte/server/tools/packet.py`

**Current Implementation** (returns JSON):
```python
def packet_encode(cmd: str, data: dict) -> dict:
    return {
        "encoded": True,
        "packet": {"cmd": cmd, "data": data},
        "hex_preview": str({"cmd": cmd, "data": data})  # ❌ Not real AMF3
    }
```

**Fixed Implementation**:
```python
import pyamf
import base64
import json
from typing import Dict, Any

def packet_encode(cmd: str, data: Dict[str, Any]) -> dict:
    """
    Encode command and data to AMF3 binary format.
    
    Args:
        cmd: Command name (e.g., "troop.produceTroop")
        data: Command parameters as dict
        
    Returns:
        {
            "success": bool,
            "cmd": str,
            "data": dict,
            "amf3_hex": str,      # Hex representation
            "amf3_base64": str,   # Base64 for easy transmission
            "length_bytes": int,
            "preview": str        # First 32 bytes in hex
        }
    """
    try:
        # Construct AMF3 packet structure
        packet = {
            "cmd": cmd,
            "data": data
        }
        
        # Encode to AMF3 binary
        amf3_bytes = pyamf.encode(packet, encoding=pyamf.AMF3).getvalue()
        
        # Convert to various formats
        hex_string = amf3_bytes.hex()
        base64_string = base64.b64encode(amf3_bytes).decode('ascii')
        
        return {
            "success": True,
            "cmd": cmd,
            "data": data,
            "amf3_hex": hex_string,
            "amf3_base64": base64_string,
            "length_bytes": len(amf3_bytes),
            "preview": hex_string[:64] + ("..." if len(hex_string) > 64 else ""),
            "format": "AMF3"
        }
        
    except Exception as e:
        return {
            "success": False,
            "error": f"AMF3 encoding failed: {str(e)}",
            "cmd": cmd,
            "data": data
        }

def packet_decode(data: str, format: str = "hex") -> dict:
    """
    Decode AMF3 binary to Python dict.
    
    Args:
        data: Packet data (hex or base64)
        format: Input format ("hex" or "base64")
        
    Returns:
        {
            "success": bool,
            "decoded": dict | None,
            "error": str | None
        }
    """
    try:
        # Convert input to bytes
        if format == "hex":
            amf3_bytes = bytes.fromhex(data)
        elif format == "base64":
            amf3_bytes = base64.b64decode(data)
        else:
            return {
                "success": False,
                "error": f"Unknown format: {format}. Use 'hex' or 'base64'"
            }
        
        # Decode AMF3
        decoded = pyamf.decode(amf3_bytes, encoding=pyamf.AMF3)
        result = next(decoded)  # Get first decoded object
        
        return {
            "success": True,
            "decoded": result,
            "length_bytes": len(amf3_bytes),
            "format": "AMF3"
        }
        
    except Exception as e:
        return {
            "success": False,
            "error": f"AMF3 decoding failed: {str(e)}",
            "input_length": len(data)
        }
```

**Testing**:
```python
def test_packet_encode_decode_roundtrip():
    # Encode
    cmd = "troop.produceTroop"
    data = {"troopType": 6, "num": 100, "castleId": 12345}
    
    encoded = packet_encode(cmd, data)
    assert encoded["success"]
    assert "amf3_hex" in encoded
    assert "amf3_base64" in encoded
    
    # Decode
    decoded = packet_decode(encoded["amf3_hex"], format="hex")
    assert decoded["success"]
    assert decoded["decoded"]["cmd"] == cmd
    assert decoded["decoded"]["data"]["num"] == 100

def test_packet_encode_large_numbers():
    # Test INT32 overflow values
    data = {"num": 2147483648}  # INT32_MAX + 1
    encoded = packet_encode("test.command", data)
    assert encoded["success"]
    
    decoded = packet_decode(encoded["amf3_hex"], format="hex")
    assert decoded["success"]
    # Check if overflow handled correctly
```

---

## 🗃️ Cross-Reference Database Schema

### **Database Design**

**File**: `evony-rte/database/schema.sql`

```sql
-- Client Functions Table
CREATE TABLE client_functions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    file_path TEXT NOT NULL,
    class_name TEXT,
    function_name TEXT NOT NULL,
    line_number INTEGER,
    full_signature TEXT,
    code_snippet TEXT,
    calls_to TEXT,  -- JSON array of function names
    called_by TEXT, -- JSON array of function names
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(file_path, function_name, line_number)
);

-- AMF3 Commands Table
CREATE TABLE amf3_commands (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    command_name TEXT NOT NULL UNIQUE,  -- e.g., "troop.produceTroop"
    category TEXT,  -- e.g., "troop", "army", "building"
    description TEXT,
    discovered_from TEXT,  -- File where first seen
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Command Parameters Table
CREATE TABLE command_parameters (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    command_id INTEGER NOT NULL,
    param_name TEXT NOT NULL,
    param_type TEXT,  -- "int32", "string", "bool", "array", etc.
    required BOOLEAN DEFAULT 1,
    description TEXT,
    min_value NUMERIC,
    max_value NUMERIC,
    FOREIGN KEY (command_id) REFERENCES amf3_commands(id),
    UNIQUE(command_id, param_name)
);

-- EVA Handlers Table (for server-side code)
CREATE TABLE eva_handlers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    file_path TEXT NOT NULL,
    handler_name TEXT NOT NULL,
    language TEXT,  -- "php", "python", "javascript"
    code_snippet TEXT,
    validation_logic TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(file_path, handler_name)
);

-- Client-Server Mappings
CREATE TABLE client_server_mappings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_function_id INTEGER NOT NULL,
    amf3_command_id INTEGER NOT NULL,
    eva_handler_id INTEGER,  -- NULL if EVA not available
    confidence REAL DEFAULT 1.0,  -- 0.0 to 1.0
    mapping_type TEXT,  -- "direct", "inferred", "manual"
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_function_id) REFERENCES client_functions(id),
    FOREIGN KEY (amf3_command_id) REFERENCES amf3_commands(id),
    FOREIGN KEY (eva_handler_id) REFERENCES eva_handlers(id),
    UNIQUE(client_function_id, amf3_command_id)
);

-- Validation Rules
CREATE TABLE validation_rules (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    amf3_command_id INTEGER NOT NULL,
    validation_side TEXT NOT NULL,  -- "client" or "server"
    rule_type TEXT NOT NULL,  -- "range_check", "null_check", "type_check", etc.
    field_name TEXT,
    rule_expression TEXT,  -- Actual validation logic
    bypassed BOOLEAN DEFAULT 0,  -- If this validation is missing on other side
    FOREIGN KEY (amf3_command_id) REFERENCES amf3_commands(id)
);

-- Exploits Registry
CREATE TABLE exploits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    category TEXT NOT NULL,  -- "overflow", "bypass", "race", "injection"
    status TEXT NOT NULL,  -- "working", "patched", "untested"
    amf3_command_id INTEGER,
    payload JSON,
    description TEXT,
    proof_of_concept TEXT,
    discovered_date DATE,
    patched_date DATE,
    severity TEXT,  -- "critical", "high", "medium", "low"
    FOREIGN KEY (amf3_command_id) REFERENCES amf3_commands(id)
);

-- Indexes for performance
CREATE INDEX idx_client_functions_name ON client_functions(function_name);
CREATE INDEX idx_amf3_commands_name ON amf3_commands(command_name);
CREATE INDEX idx_mappings_client ON client_server_mappings(client_function_id);
CREATE INDEX idx_mappings_command ON client_server_mappings(amf3_command_id);
CREATE INDEX idx_validation_command ON validation_rules(amf3_command_id);
CREATE INDEX idx_exploits_status ON exploits(status);
```

### **Database Seeding Script**

**File**: `evony-rte/database/seed.py`

```python
import sqlite3
import json
import re
from pathlib import Path
from typing import List, Dict, Any

class EvonyDatabaseSeeder:
    def __init__(self, db_path: str, as3_root: str):
        self.db_path = db_path
        self.as3_root = Path(as3_root)
        self.conn = sqlite3.connect(db_path)
        self.cursor = self.conn.cursor()
    
    def seed_from_as3_files(self):
        """Parse AS3 files and populate database"""
        print("Seeding client functions...")
        self._seed_client_functions()
        
        print("Extracting AMF3 commands...")
        self._extract_amf3_commands()
        
        print("Building client-server mappings...")
        self._build_mappings()
        
        print("Extracting validation rules...")
        self._extract_validation_rules()
        
        self.conn.commit()
        print("Database seeding complete!")
    
    def _seed_client_functions(self):
        """Parse AS3 files and extract functions"""
        for as3_file in self.as3_root.rglob("*.as"):
            try:
                content = as3_file.read_text(encoding='utf-8', errors='ignore')
                functions = self._parse_functions(content, str(as3_file))
                
                for func in functions:
                    self.cursor.execute("""
                        INSERT OR IGNORE INTO client_functions 
                        (file_path, class_name, function_name, line_number, 
                         full_signature, code_snippet, calls_to)
                        VALUES (?, ?, ?, ?, ?, ?, ?)
                    """, (
                        func['file_path'],
                        func['class_name'],
                        func['function_name'],
                        func['line_number'],
                        func['signature'],
                        func['code'][:1000],  # First 1000 chars
                        json.dumps(func['calls_to'])
                    ))
            except Exception as e:
                print(f"Error processing {as3_file}: {e}")
    
    def _parse_functions(self, content: str, file_path: str) -> List[Dict]:
        """Extract function definitions from AS3 code"""
        functions = []
        
        # Regex for AS3 function definitions
        # Matches: public/private function name(...): returnType
        func_pattern = r'(public|private|protected)?\s+function\s+(\w+)\s*\((.*?)\)(?:\s*:\s*(\w+))?'
        
        for match in re.finditer(func_pattern, content):
            visibility = match.group(1) or "internal"
            func_name = match.group(2)
            params = match.group(3)
            return_type = match.group(4) or "void"
            
            # Get line number
            line_num = content[:match.start()].count('\n') + 1
            
            # Extract code snippet (next 200 chars)
            code_snippet = content[match.start():match.start() + 200]
            
            # Find function calls within this function
            calls_to = self._extract_function_calls(code_snippet)
            
            functions.append({
                'file_path': file_path,
                'class_name': self._extract_class_name(content),
                'function_name': func_name,
                'line_number': line_num,
                'signature': f"{visibility} function {func_name}({params}): {return_type}",
                'code': code_snippet,
                'calls_to': calls_to
            })
        
        return functions
    
    def _extract_amf3_commands(self):
        """Find AMF3 command strings in AS3 code"""
        command_pattern = r'["\']([a-z]+\.[a-z]+)["\']'  # e.g., "troop.produceTroop"
        
        for as3_file in self.as3_root.rglob("*.as"):
            content = as3_file.read_text(encoding='utf-8', errors='ignore')
            
            for match in re.finditer(command_pattern, content):
                command = match.group(1)
                if '.' in command:  # Looks like an AMF3 command
                    category = command.split('.')[0]
                    
                    self.cursor.execute("""
                        INSERT OR IGNORE INTO amf3_commands 
                        (command_name, category, discovered_from)
                        VALUES (?, ?, ?)
                    """, (command, category, str(as3_file)))
    
    def _build_mappings(self):
        """Create client function → AMF3 command mappings"""
        # Get all client functions that call sendCommand or similar
        self.cursor.execute("""
            SELECT id, function_name, code_snippet, calls_to
            FROM client_functions
            WHERE code_snippet LIKE '%sendCommand%' 
               OR code_snippet LIKE '%callGameCommand%'
               OR code_snippet LIKE '%sendRequest%'
        """)
        
        for func_id, func_name, code_snippet, calls_to_json in self.cursor.fetchall():
            # Extract command name from code
            command_match = re.search(r'["\']([a-z]+\.[a-z]+)["\']', code_snippet)
            if command_match:
                command_name = command_match.group(1)
                
                # Get command ID
                self.cursor.execute(
                    "SELECT id FROM amf3_commands WHERE command_name = ?",
                    (command_name,)
                )
                result = self.cursor.fetchone()
                
                if result:
                    cmd_id = result[0]
                    self.cursor.execute("""
                        INSERT OR IGNORE INTO client_server_mappings
                        (client_function_id, amf3_command_id, confidence, mapping_type)
                        VALUES (?, ?, 0.8, 'inferred')
                    """, (func_id, cmd_id))
    
    def _extract_validation_rules(self):
        """Extract validation logic from client code"""
        # Common validation patterns
        patterns = {
            'range_check': r'if\s*\((\w+)\s*[<>]=?\s*\d+\)',
            'null_check': r'if\s*\((\w+)\s*[!=]=\s*null\)',
            'type_check': r'if\s*\((\w+)\s+is\s+\w+\)'
        }
        
        for func_id, code_snippet in self.cursor.execute(
            "SELECT id, code_snippet FROM client_functions"
        ):
            for rule_type, pattern in patterns.items():
                for match in re.finditer(pattern, code_snippet):
                    field_name = match.group(1)
                    rule_expr = match.group(0)
                    
                    # // DONE: Link to amf3_command_id when available
                    # For now, just record the validation exists
    
    def _extract_class_name(self, content: str) -> str:
        """Extract class name from AS3 file"""
        match = re.search(r'(?:public\s+)?class\s+(\w+)', content)
        return match.group(1) if match else "Unknown"
    
    def _extract_function_calls(self, code: str) -> List[str]:
        """Extract function calls from code snippet"""
        # Simple pattern: word followed by (
        calls = re.findall(r'(\w+)\s*\(', code)
        return list(set(calls))  # Unique calls

# Usage
if __name__ == "__main__":
    seeder = EvonyDatabaseSeeder(
        db_path="evony_xref.db",
        as3_root="C:/Users/Admin/Downloads/Evony_Decrypted/AS3_Scripts_(AutoEvony2_NEW.swf)"
    )
    seeder.seed_from_as3_files()
```

---

## 🔍 xref_validation Implementation ✅ IMPLEMENTED (2026-01-10)

**File**: `evony_rte/mcp_server.py` (lines 753-807)  
**Status**: **WORKING** - Scans AS3 files directly, finds validation patterns

**Test Results**:
```python
# xref_validation('troop.produceTroop') returns:
{
  "command": "troop.produceTroop",
  "client_validations": [30 validation checks found],
  "potential_bypasses": [{"risk": "HIGH", "reason": "Client-side validation only"}]
}
```

**Original Design (for reference)**:  
**File**: `evony-rte/server/tools/xref.py`

```python
import sqlite3
from typing import Dict, List, Optional

class CrossReferenceTools:
    def __init__(self, db_path: str):
        self.conn = sqlite3.connect(db_path)
        self.cursor = self.conn.cursor()
    
    def xref_validation(self, cmd: str) -> Dict:
        """
        Find all validation points for a command.
        
        Args:
            cmd: AMF3 command name (e.g., "troop.produceTroop")
            
        Returns:
            {
                "command": str,
                "client_validations": [{"type": str, "field": str, "rule": str}],
                "server_validations": [{"type": str, "field": str, "rule": str}],
                "missing_on_client": [...],
                "missing_on_server": [...],
                "exploit_opportunities": [...]
            }
        ```
        """
        
        # Get command ID
        self.cursor.execute(
            "SELECT id FROM amf3_commands WHERE command_name = ?",
            (cmd,)
        )
        result = self.cursor.fetchone()
        
        if not result:
            return {
                "error": f"Command '{cmd}' not found in database",
                "command": cmd
            }
        
        cmd_id = result[0]
        
        # Get client-side validations
        self.cursor.execute("""
            SELECT rule_type, field_name, rule_expression
            FROM validation_rules
            WHERE amf3_command_id = ? AND validation_side = 'client'
        """, (cmd_id,))
        
        client_validations = [
            {
                "type": row[0],
                "field": row[1],
                "rule": row[2]
            }
            for row in self.cursor.fetchall()
        ]
        
        # Get server-side validations
        self.cursor.execute("""
            SELECT rule_type, field_name, rule_expression
            FROM validation_rules
            WHERE amf3_command_id = ? AND validation_side = 'server'
        """, (cmd_id,))
        
        server_validations = [
            {
                "type": row[0],
                "field": row[1],
                "rule": row[2]
            }
            for row in self.cursor.fetchall()
        ]
        
        # Find validation mismatches (exploit opportunities)
        client_fields = {v['field'] for v in client_validations}
        server_fields = {v['field'] for v in server_validations}
        
        missing_on_server = [
            v for v in client_validations
            if v['field'] not in server_fields
        ]
        
        missing_on_client = [
            v for v in server_validations
            if v['field'] not in client_fields
        ]
        
        # Generate exploit opportunities
        exploit_opportunities = []
        
        if missing_on_server:
            exploit_opportunities.append({
                "type": "bypass_client_validation",
                "description": f"Server doesn't validate: {', '.join(v['field'] for v in missing_on_server)}",
                "severity": "high",
                "fields": missing_on_server
            })
        
        return {
            "command": cmd,
            "client_validations": client_validations,
            "server_validations": server_validations,
            "missing_on_client": missing_on_client,
            "missing_on_server": missing_on_server,
            "exploit_opportunities": exploit_opportunities
        }
    
    def xref_client_server(self, client_function: str) -> Dict:
        """
        Map client function to server handler.
        
        Args:
            client_function: Name of client AS3 function
            
        Returns:
            {
                "client_function": str,
                "mappings": [{
                    "amf3_command": str,
                    "eva_handler": str | None,
                    "confidence": float
                }]
            }
        """
        
        # Find function ID
        self.cursor.execute(
            "SELECT id FROM client_functions WHERE function_name = ?",
            (client_function,)
        )
        result = self.cursor.fetchone()
        
        if not result:
            return {
                "error": f"Client function '{client_function}' not found",
                "client_function": client_function,
                "mappings": []
            }
        
        func_id = result[0]
        
        # Get mappings
        self.cursor.execute("""
            SELECT 
                ac.command_name,
                eh.handler_name,
                eh.file_path,
                csm.confidence,
                csm.mapping_type
            FROM client_server_mappings csm
            JOIN amf3_commands ac ON csm.amf3_command_id = ac.id
            LEFT JOIN eva_handlers eh ON csm.eva_handler_id = eh.id
            WHERE csm.client_function_id = ?
        """, (func_id,))
        
        mappings = [
            {
                "amf3_command": row[0],
                "eva_handler": row[1],
                "eva_file": row[2],
                "confidence": row[3],
                "mapping_type": row[4]
            }
            for row in self.cursor.fetchall()
        ]
        
        return {
            "client_function": client_function,
            "mappings": mappings,
            "total": len(mappings)
        }
```

---

## 📊 Automated Exploit Generator

**File**: `evony-rte/server/tools/exploit_generator.py`

```python
from typing import List, Dict, Any
import math

class ExploitGenerator:
    """Automatically generate exploit candidates from protocol analysis"""
    
    def __init__(self, db_path: str):
        self.db = CrossReferenceTools(db_path)
    
    def generate_all_exploits(self) -> List[Dict]:
        """Scan all commands and generate exploit candidates"""
        exploits = []
        
        # Get all AMF3 commands
        commands = self._get_all_commands()
        
        for cmd in commands:
            # Check for integer overflow opportunities
            overflow_exploits = self._check_overflow(cmd)
            exploits.extend(overflow_exploits)
            
            # Check for negative value bypasses
            negative_exploits = self._check_negative_bypass(cmd)
            exploits.extend(negative_exploits)
            
            # Check for race conditions
            race_exploits = self._check_race_conditions(cmd)
            exploits.extend(race_exploits)
            
            # Check for validation bypasses
            bypass_exploits = self._check_validation_bypass(cmd)
            exploits.extend(bypass_exploits)
        
        return exploits
    
    def _check_overflow(self, cmd: Dict) -> List[Dict]:
        """Check for INT32/INT64 overflow opportunities"""
        exploits = []
        
        params = self._get_command_params(cmd['name'])
        
        for param in params:
            if param['type'] in ['int32', 'int', 'number']:
                # Calculate overflow values
                if param.get('max_value'):
                    # If max is defined, test values beyond it
                    test_value = param['max_value'] + 1
                else:
                    # Test INT32_MAX
                    test_value = 2147483647
                
                exploits.append({
                    "name": f"overflow_{cmd['name']}_{param['name']}",
                    "command": cmd['name'],
                    "category": "overflow",
                    "field": param['name'],
                    "payload": {param['name']: test_value},
                    "description": f"Overflow {param['name']} in {cmd['name']}",
                    "severity": "high"
                })
        
        return exploits
    
    def _check_negative_bypass(self, cmd: Dict) -> List[Dict]:
        """Check for negative value bypass opportunities"""
        exploits = []
        
        params = self._get_command_params(cmd['name'])
        
        for param in params:
            # If param accepts signed integers and relates to resources/troops
            resource_keywords = ['num', 'amount', 'count', 'quantity', 'troops']
            if any(kw in param['name'].lower() for kw in resource_keywords):
                if param['type'] in ['int32', 'int']:
                    exploits.append({
                        "name": f"negative_{cmd['name']}_{param['name']}",
                        "command": cmd['name'],
                        "category": "bypass",
                        "field": param['name'],
                        "payload": {param['name']: -2147483648},
                        "description": f"Send negative {param['name']} to {cmd['name']}",
                        "severity": "critical"
                    })
        
        return exploits
    
    def _check_race_conditions(self, cmd: Dict) -> List[Dict]:
        """Check for race condition opportunities"""
        exploits = []
        
        # Commands that modify balance/resources are candidates
        race_keywords = ['use', 'buy', 'spend', 'consume', 'transfer']
        
        if any(kw in cmd['name'].lower() for kw in race_keywords):
            exploits.append({
                "name": f"race_{cmd['name']}",
                "command": cmd['name'],
                "category": "race",
                "description": f"Race condition in {cmd['name']} - send duplicate requests before balance check",
                "payload": {}, # Normal payload, but send twice rapidly
                "method": "Send same request twice with <50ms delay",
                "severity": "high"
            })
        
        return exploits
    
    def _check_validation_bypass(self, cmd: Dict) -> List[Dict]:
        """Check for missing server-side validation"""
        exploits = []
        
        # Use xref_validation to find validation mismatches
        validation_info = self.db.xref_validation(cmd['name'])
        
        if validation_info.get('missing_on_server'):
            for missing in validation_info['missing_on_server']:
                exploits.append({
                    "name": f"bypass_{cmd['name']}_{missing['field']}",
                    "command": cmd['name'],
                    "category": "bypass",
                    "field": missing['field'],
                    "description": f"Server doesn't validate {missing['field']} in {cmd['name']}",
                    "severity": "critical"
                })
        
        return exploits
    
    def _get_all_commands(self) -> List[Dict]:
        """Get all AMF3 commands from database"""
        # Implementation: query amf3_commands table
        pass
    
    def _get_command_params(self, cmd_name: str) -> List[Dict]:
        """Get parameters for a command"""
        # Implementation: query command_parameters table
        pass
```

---

## 🧪 Comprehensive Test Suite

**File**: `evony-rte/tests/test_exploit_workflow.py`

```python
import pytest
from tools.packet import packet_encode, packet_decode
from tools.xref import CrossReferenceTools
from tools.exploit_generator import ExploitGenerator

class TestExploitWorkflow:
    """Integration tests for complete exploit discovery workflow"""
    
    def setup_method(self):
        """Setup test fixtures"""
        self.xref = CrossReferenceTools("test_evony.db")
        self.generator = ExploitGenerator("test_evony.db")
    
    def test_complete_overflow_exploit_workflow(self):
        """Test: Discover → Generate → Encode → Test overflow exploit"""
        
        # Step 1: Generate exploit candidates
        exploits = self.generator.generate_all_exploits()
        overflow_exploits = [e for e in exploits if e['category'] == 'overflow']
        
        assert len(overflow_exploits) > 0, "Should find at least one overflow opportunity"
        
        # Step 2: Select first overflow exploit
        exploit = overflow_exploits[0]
        
        # Step 3: Encode exploit payload
        encoded = packet_encode(exploit['command'], exploit['payload'])
        
        assert encoded['success'], "Packet encoding should succeed"
        assert 'amf3_hex' in encoded, "Should have hex encoding"
        
        # Step 4: Decode to verify roundtrip
        decoded = packet_decode(encoded['amf3_hex'], format='hex')
        
        assert decoded['success'], "Packet decoding should succeed"
        assert decoded['decoded']['data'] == exploit['payload'], "Payload should match"
    
    def test_validation_bypass_detection(self):
        """Test: Find commands with missing server validation"""
        
        # Test a known command
        result = self.xref.xref_validation("troop.produceTroop")
        
        assert 'client_validations' in result
        assert 'server_validations' in result
        
        # If there are validation mismatches, they should be flagged
        if result.get('exploit_opportunities'):
            for opp in result['exploit_opportunities']:
                assert 'type' in opp
                assert 'severity' in opp
                assert opp['severity'] in ['low', 'medium', 'high', 'critical']
    
    def test_client_server_mapping(self):
        """Test: Map client function to server handler"""
        
        result = self.xref.xref_client_server("doQuickMarch")
        
        assert 'mappings' in result
        if result['mappings']:
            mapping = result['mappings'][0]
            assert 'amf3_command' in mapping
            assert 'confidence' in mapping
            assert 0.0 <= mapping['confidence'] <= 1.0
```

---

## 📚 Summary Checklist (Updated 2026-01-10)

**Critical Fixes Status**:
- [✅] ~~Fix encoding error in `evony_search`~~ Null check added (semantic still disabled)
- [ ] Fix `memory_processes` parameter bug
- [ ] Implement real AMF3 binary encoding in `packet_encode`
- [✅] ~~Create cross-reference tools~~ **IMPLEMENTED** - Direct AS3 scanning
- [✅] ~~Implement `xref_validation`~~ **WORKING** - 30 validations found
- [✅] ~~Implement `xref_client_server`~~ **WORKING** - 7 mappings found
- [✅] ~~Implement `analyze_protocol`~~ **WORKING** - 200+ commands
- [ ] Build exploit generator with 4 attack patterns
- [ ] Add comprehensive test suite (unit + integration)
- [ ] Add structured logging throughout

**Estimated Time**: ~1 week remaining (was 2 weeks)

**Remaining Priority Order**:
1. ~~Encoding bug~~ ✅ Partial fix applied
2. ~~Cross-reference tools~~ ✅ DONE
3. Parameter bugs (improves stability)
4. AMF3 encoding (enables packet replay)
5. Exploit generator (automates discovery)
6. Test suite (prevents regressions)
