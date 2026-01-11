"""
Test MCP handler functionality
"""
import pytest
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent.parent.parent))

from evony_rte.mcp_server import handle_tool, HANDLERS


class TestHandlerRegistry:
    """Test handler registration"""
    
    def test_handlers_registered(self):
        """Test that handlers are registered"""
        assert len(HANDLERS) >= 55
    
    def test_all_handlers_callable(self):
        """Test all handlers are callable"""
        for name, handler in HANDLERS.items():
            assert callable(handler), f"{name} is not callable"


class TestPacketTools:
    """Test packet manipulation handlers"""
    
    def test_packet_capture_status(self):
        """Test packet capture status"""
        result = handle_tool('packet_capture', {'action': 'status'})
        assert 'error' not in result or 'status' in result
    
    def test_packet_encode(self):
        """Test packet encoding"""
        result = handle_tool('packet_encode', {
            'cmd': 'city.getInfo',
            'data': {'castleId': 12345}
        })
        assert 'amf3_hex' in result
    
    def test_packet_decode_no_data(self):
        """Test packet decode without data"""
        result = handle_tool('packet_decode', {})
        assert result is not None


class TestClientAnalysis:
    """Test client code analysis handlers"""
    
    def test_client_search(self):
        """Test client search"""
        result = handle_tool('client_search', {'query': 'TroopCommands'})
        assert 'results' in result or 'matches' in result or 'error' not in result
    
    def test_client_strings(self):
        """Test client strings extraction"""
        result = handle_tool('client_strings', {'filter': 'troop'})
        assert 'strings' in result or 'error' not in result
    
    def test_client_callgraph(self):
        """Test client callgraph"""
        result = handle_tool('client_callgraph', {})
        assert result is not None


class TestExploitFramework:
    """Test exploit framework handlers"""
    
    def test_exploit_list(self):
        """Test exploit listing"""
        result = handle_tool('exploit_list', {})
        assert 'exploits' in result
    
    def test_exploit_list_with_category(self):
        """Test exploit listing by category"""
        result = handle_tool('exploit_list', {'category': 'overflow'})
        assert 'exploits' in result
    
    def test_exploit_scan(self):
        """Test exploit scanning"""
        result = handle_tool('exploit_scan', {})
        assert result is not None
    
    def test_exploit_create(self):
        """Test exploit creation template"""
        result = handle_tool('exploit_create', {
            'name': 'test_exploit',
            'cmd': 'test.command'
        })
        assert result is not None


class TestGameInteraction:
    """Test game interaction handlers"""
    
    def test_game_status(self):
        """Test game status"""
        result = handle_tool('game_status', {})
        assert result is not None
    
    def test_game_send_no_cmd(self):
        """Test game send without command"""
        result = handle_tool('game_send', {})
        assert 'status' in result or 'usage' in result
    
    def test_game_send_with_cmd(self):
        """Test game send with command"""
        result = handle_tool('game_send', {
            'cmd': 'city.getInfo',
            'data': {'castleId': 12345}
        })
        assert 'amf3_hex' in result or 'status' in result
    
    def test_game_resources(self):
        """Test game resources"""
        result = handle_tool('game_resources', {})
        assert result is not None
    
    def test_game_troops(self):
        """Test game troops"""
        result = handle_tool('game_troops', {})
        assert result is not None


class TestProxyTools:
    """Test proxy handlers"""
    
    def test_proxy_status(self):
        """Test proxy status"""
        result = handle_tool('proxy_status', {})
        assert result is not None
    
    def test_proxy_session(self):
        """Test proxy session"""
        result = handle_tool('proxy_session', {})
        assert result is not None


class TestAdvancedRETools:
    """Test advanced RE tool handlers"""
    
    def test_advanced_tools_status(self):
        """Test advanced tools status"""
        result = handle_tool('advanced_tools_status', {})
        assert 'tools' in result or isinstance(result, dict)
    
    def test_ffdec_status(self):
        """Test FFDec status"""
        result = handle_tool('ffdec', {'action': 'status'})
        assert result is not None
    
    def test_ghidra_status(self):
        """Test Ghidra status"""
        result = handle_tool('ghidra', {'action': 'status'})
        assert result is not None
    
    def test_radare2_status(self):
        """Test radare2 status"""
        result = handle_tool('radare2', {'action': 'status'})
        assert result is not None
    
    def test_scapy_status(self):
        """Test scapy status"""
        result = handle_tool('scapy', {'action': 'status'})
        assert result is not None


class TestSystemTools:
    """Test system handlers"""
    
    def test_rte_stats(self):
        """Test RTE stats"""
        result = handle_tool('rte_stats', {})
        assert result is not None
    
    def test_tools_status(self):
        """Test tools status"""
        result = handle_tool('tools_status', {})
        assert result is not None
    
    def test_find_vulnerabilities(self):
        """Test vulnerability finder"""
        result = handle_tool('find_vulnerabilities', {})
        assert result is not None
    
    def test_analyze_protocol(self):
        """Test protocol analysis"""
        result = handle_tool('analyze_protocol', {})
        assert result is not None


class TestCrossReference:
    """Test cross-reference handlers"""
    
    def test_xref_client_server(self):
        """Test client-server cross-reference"""
        result = handle_tool('xref_client_server', {})
        assert result is not None
    
    def test_xref_packet_handler(self):
        """Test packet handler cross-reference"""
        result = handle_tool('xref_packet_handler', {})
        assert result is not None
    
    def test_xref_validation(self):
        """Test validation cross-reference"""
        result = handle_tool('xref_validation', {})
        assert result is not None
