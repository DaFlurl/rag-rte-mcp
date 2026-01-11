"""
ETK SOL Manager - Account Validator
Tests account credentials by attempting login
"""

import time
import json
from pathlib import Path
from typing import Dict, List, Optional, Tuple, Any
from datetime import datetime
from dataclasses import dataclass, field
from enum import Enum
import threading
import queue

from ..data_models.account_data import AccountData, AccountStatus


class ValidationResult(Enum):
    SUCCESS = "success"
    INVALID_CREDENTIALS = "invalid_credentials"
    BANNED = "banned"
    SERVER_ERROR = "server_error"
    TIMEOUT = "timeout"
    UNKNOWN = "unknown"


@dataclass
class ValidationReport:
    """Result of validating an account"""
    email: str
    result: ValidationResult
    message: str = ""
    response_time_ms: float = 0
    timestamp: datetime = field(default_factory=datetime.now)
    player_name: str = ""
    server: str = ""
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "email": self.email,
            "result": self.result.value,
            "message": self.message,
            "response_time_ms": self.response_time_ms,
            "timestamp": self.timestamp.isoformat(),
            "player_name": self.player_name,
            "server": self.server
        }


class AccountValidator:
    """
    Validates account credentials by testing login.
    
    Note: This validator creates validation reports but the actual
    login testing requires running RoboEvony with the credentials.
    This class manages the validation queue and results.
    
    For actual login testing, accounts are:
    1. Deployed to system Macromedia folder
    2. RoboEvony is launched
    3. Login success/failure is detected
    4. Results are recorded
    """
    
    def __init__(self):
        self.validation_queue: queue.Queue = queue.Queue()
        self.results: Dict[str, ValidationReport] = {}
        self.is_running = False
        self._worker_thread: Optional[threading.Thread] = None
    
    def queue_validation(self, account: AccountData):
        """Add account to validation queue"""
        self.validation_queue.put(account)
    
    def queue_batch(self, accounts: List[AccountData]):
        """Add multiple accounts to validation queue"""
        for acc in accounts:
            self.queue_validation(acc)
    
    def get_result(self, email: str) -> Optional[ValidationReport]:
        """Get validation result for an account"""
        return self.results.get(email.lower())
    
    def get_all_results(self) -> List[ValidationReport]:
        """Get all validation results"""
        return list(self.results.values())
    
    def get_valid_accounts(self) -> List[str]:
        """Get list of validated working accounts"""
        return [
            email for email, report in self.results.items()
            if report.result == ValidationResult.SUCCESS
        ]
    
    def get_invalid_accounts(self) -> List[str]:
        """Get list of accounts that failed validation"""
        return [
            email for email, report in self.results.items()
            if report.result == ValidationResult.INVALID_CREDENTIALS
        ]
    
    def record_result(self, email: str, result: ValidationResult, 
                      message: str = "", player_name: str = "", 
                      response_time_ms: float = 0):
        """Record a validation result"""
        report = ValidationReport(
            email=email,
            result=result,
            message=message,
            player_name=player_name,
            response_time_ms=response_time_ms
        )
        self.results[email.lower()] = report
    
    def export_results(self, output_path: Path) -> bool:
        """Export validation results to JSON"""
        try:
            data = {
                "generated": datetime.now().isoformat(),
                "total_validated": len(self.results),
                "valid": len(self.get_valid_accounts()),
                "invalid": len(self.get_invalid_accounts()),
                "results": {
                    email: report.to_dict()
                    for email, report in self.results.items()
                }
            }
            
            output_path.parent.mkdir(parents=True, exist_ok=True)
            with open(output_path, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=2)
            
            return True
        except Exception as e:
            print(f"Export failed: {e}")
            return False
    
    def print_summary(self):
        """Print validation summary"""
        print("=" * 60)
        print("VALIDATION SUMMARY")
        print("=" * 60)
        print(f"Total validated: {len(self.results)}")
        print(f"Valid (working): {len(self.get_valid_accounts())}")
        print(f"Invalid: {len(self.get_invalid_accounts())}")
        
        # Count by result type
        by_result = {}
        for report in self.results.values():
            key = report.result.value
            by_result[key] = by_result.get(key, 0) + 1
        
        print("\nResults by type:")
        for result_type, count in sorted(by_result.items()):
            print(f"  {result_type}: {count}")


def create_validation_script() -> str:
    """
    Creates a RoboEvony script that tests login and outputs result.
    This script is run inside RoboEvony to verify credentials work.
    """
    script = '''#===============================================
# Account Validation Script
# Tests if current account credentials are valid
# Outputs: VALID or INVALID with details
#===============================================

# Wait for login attempt
sleep 5000

# Check if logged in by looking for player name
iferror %player.name% goto LoginFailed

# Login successful
output "VALIDATION_RESULT:VALID"
output "PLAYER_NAME:%player.name%"
output "SERVER:%server.name%"
output "PRESTIGE:%player.prestige%"
goto End

:LoginFailed
output "VALIDATION_RESULT:INVALID"
output "ERROR:Login failed or timed out"

:End
output "VALIDATION_COMPLETE"
'''
    return script


def create_batch_validation_script() -> str:
    """
    Creates a script that can validate multiple accounts.
    Requires account credentials to be set before running.
    """
    script = '''#===============================================
# Batch Account Validation Script
# Run this after setting account credentials
#===============================================

setsilence true //

# Try to login
sleep 3000

# Check login status
iferror %player.name% goto Failed

# Success - output account info
output "===ACCOUNT_VALID==="
output "EMAIL:%config.username%"
output "PLAYER:%player.name%"
output "SERVER:%server.name%"
output "GOLD:%player.gold%"
output "PRESTIGE:%player.prestige%"
output "===END_VALIDATION==="
goto Done

:Failed
output "===ACCOUNT_INVALID==="
output "EMAIL:%config.username%"
output "ERROR:Login failed"
output "===END_VALIDATION==="

:Done
# Script complete
'''
    return script
