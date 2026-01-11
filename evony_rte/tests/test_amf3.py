"""
Test AMF3 encoding/decoding functionality
"""
import pytest
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent.parent.parent))

from evony_rte.mcp_server import handle_tool


class TestPacketEncode:
    """Test packet encoding functionality"""
    
    def test_encode_basic_command(self, sample_amf3_data):
        """Test basic AMF3 encoding"""
        result = handle_tool('packet_encode', sample_amf3_data)
        
        assert 'amf3_hex' in result
        assert len(result['amf3_hex']) > 0
        assert result.get('command') == 'city.getInfo'
    
    def test_encode_with_integer(self):
        """Test encoding integer values"""
        result = handle_tool('packet_encode', {
            'cmd': 'test.command',
            'data': {'intValue': 12345}
        })
        
        assert 'amf3_hex' in result
    
    def test_encode_with_string(self):
        """Test encoding string values"""
        result = handle_tool('packet_encode', {
            'cmd': 'test.command',
            'data': {'strValue': 'hello world'}
        })
        
        assert 'amf3_hex' in result
    
    def test_encode_with_boolean(self):
        """Test encoding boolean values"""
        result = handle_tool('packet_encode', {
            'cmd': 'test.command',
            'data': {'boolValue': True}
        })
        
        assert 'amf3_hex' in result
    
    def test_encode_with_array(self):
        """Test encoding array values"""
        result = handle_tool('packet_encode', {
            'cmd': 'test.command',
            'data': {'arrayValue': [1, 2, 3, 4, 5]}
        })
        
        assert 'amf3_hex' in result
    
    def test_encode_with_nested_object(self):
        """Test encoding nested objects"""
        result = handle_tool('packet_encode', {
            'cmd': 'test.command',
            'data': {'nested': {'a': 1, 'b': {'c': 2}}}
        })
        
        assert 'amf3_hex' in result
    
    def test_encode_large_integer(self):
        """Test encoding large integers (near INT32_MAX)"""
        result = handle_tool('packet_encode', {
            'cmd': 'troop.produceTroop',
            'data': {'num': 2147483647}  # INT32_MAX
        })
        
        assert 'amf3_hex' in result
    
    def test_encode_negative_integer(self):
        """Test encoding negative integers"""
        result = handle_tool('packet_encode', {
            'cmd': 'test.command',
            'data': {'negValue': -1000}
        })
        
        assert 'amf3_hex' in result
    
    def test_encode_empty_data(self):
        """Test encoding with empty data"""
        result = handle_tool('packet_encode', {
            'cmd': 'test.command',
            'data': {}
        })
        
        assert 'amf3_hex' in result


class TestPacketDecode:
    """Test packet decoding functionality"""
    
    def test_decode_hex(self, sample_amf3_data):
        """Test decoding hex-encoded AMF3"""
        # First encode
        encoded = handle_tool('packet_encode', sample_amf3_data)
        
        # Then decode
        decoded = handle_tool('packet_decode', {
            'data': encoded['amf3_hex'],
            'format': 'hex'
        })
        
        assert 'decoded' in decoded or 'raw_bytes' in decoded
    
    def test_decode_invalid_hex(self):
        """Test decoding invalid hex string"""
        result = handle_tool('packet_decode', {
            'data': 'invalid_hex_string',
            'format': 'hex'
        })
        
        # Should handle gracefully
        assert result is not None


class TestExploitPayloads:
    """Test exploit-related encoding"""
    
    def test_encode_overflow_payload(self):
        """Test encoding integer overflow payload"""
        result = handle_tool('packet_encode', {
            'cmd': 'troop.produceTroop',
            'data': {
                'troopType': 6,
                'num': 6135037,  # Archer overflow number
                'castleId': 12345
            }
        })
        
        assert 'amf3_hex' in result
    
    def test_encode_negative_troop_payload(self):
        """Test encoding negative troop payload"""
        result = handle_tool('packet_encode', {
            'cmd': 'troop.disbandTroop',
            'data': {
                'troopType': 6,
                'num': -2000000000
            }
        })
        
        assert 'amf3_hex' in result
