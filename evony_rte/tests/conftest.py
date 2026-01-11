"""
Pytest configuration for Evony RTE tests
"""
import pytest
import sys
from pathlib import Path

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent.parent.parent))

@pytest.fixture
def sample_amf3_data():
    """Sample data for AMF3 tests"""
    return {
        'cmd': 'city.getInfo',
        'data': {'castleId': 12345}
    }

@pytest.fixture
def sample_troop_data():
    """Sample troop production data"""
    return {
        'cmd': 'troop.produceTroop',
        'data': {'troopType': 6, 'num': 100, 'castleId': 12345}
    }

@pytest.fixture
def bot_server_url():
    """Bot server URL"""
    return "http://localhost:9999"
