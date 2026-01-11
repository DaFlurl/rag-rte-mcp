# BORG TOOLKIT - Client Wrapper
"""
Wrapper around existing evony_client.py for exploit injection.
Uses the already-working connection from sol_manager.
"""

import sys
from pathlib import Path

# Add sol_manager to path
SOL_MANAGER_PATH = Path(__file__).parent.parent.parent / "sol_manager" / "extractor"
sys.path.insert(0, str(SOL_MANAGER_PATH))

# Import existing client
try:
    from evony_client import EvonyClient, extract_account
    CLIENT_AVAILABLE = True
except ImportError:
    CLIENT_AVAILABLE = False
    print("[!] evony_client not found - check sol_manager/extractor path")


class BorgClient:
    """
    Extended client with exploit injection capabilities.
    Wraps existing EvonyClient from sol_manager.
    """
    
    def __init__(self, server: str = 'cc2'):
        if not CLIENT_AVAILABLE:
            raise ImportError("evony_client not available")
        self.client = EvonyClient(server)
        self.server = server
        self.castle_id = None
    
    def login(self, email: str, password: str) -> bool:
        """Login using existing client"""
        result = self.client.login(email, password)
        if result:
            castles = self.client.get_castles()
            if castles:
                self.castle_id = castles[0].get('id')
        return result
    
    def send_raw(self, command: str, params: dict) -> dict:
        """Send raw command through connection"""
        if not self.client.connection:
            return {'error': 'Not connected'}
        
        self.client.connection.send_message(command, params)
        # Note: Response handling depends on command
        return {'sent': True, 'command': command}
    
    # EXPLOIT METHODS
    
    def troop_produce(self, troop_type: int, num: int, position_id: int = 1) -> dict:
        """Send troop production command"""
        return self.send_raw('troop.produceTroop', {
            'castleId': self.castle_id,
            'positionId': position_id,
            'troopType': troop_type,
            'num': num,
            'isShare': False,
            'toIdle': True,
        })
    
    def troop_cancel(self, position_id: int = 1, queue_id: int = 0) -> dict:
        """Cancel troop production"""
        return self.send_raw('troop.cancelTroopProduce', {
            'castleId': self.castle_id,
            'positionId': position_id,
            'queueId': queue_id,
        })
    
    def use_item(self, item_id: str, num: int = 1) -> dict:
        """Use item"""
        return self.send_raw('shop.useGoods', {
            'castleId': self.castle_id,
            'itemId': item_id,
            'num': num,
        })
    
    def run_overflow_exploit(self, troop_type: int = 6, overflow_num: int = 6135037):
        """
        Run troop overflow exploit.
        
        troop_type: 6=archer, 7=cavalry, 8=cataphract
        overflow_num: Number above INT32_MAX/cost threshold
        """
        print(f"[*] Running overflow: {overflow_num:,} troops (type {troop_type})")
        
        # Step 1: Queue overflow
        print("[1] Sending production...")
        self.troop_produce(troop_type, overflow_num)
        
        # Step 2: Wait
        import time
        print("[2] Waiting 0.5s...")
        time.sleep(0.5)
        
        # Step 3: Cancel
        print("[3] Canceling...")
        self.troop_cancel()
        
        print("[*] Exploit sent - check resources")
    
    def close(self):
        self.client.close()


# Overflow thresholds
OVERFLOW = {
    6: 6135037,   # archer
    7: 2684355,   # cavalry
    8: 1431656,   # cataphract
}
