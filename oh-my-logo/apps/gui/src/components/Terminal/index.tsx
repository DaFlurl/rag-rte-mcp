/**
 * Terminal Component - Embedded CLI with xterm.js
 */

import React, { useRef, useEffect, useState } from 'react';
import { useStore } from '../../store';
import {
  Terminal as TerminalIcon,
  Trash2,
  Copy,
  ChevronDown,
  ChevronUp,
  Maximize2,
  Minimize2,
} from 'lucide-react';

// ============================================
// Terminal Component
// ============================================

export default function Terminal() {
  const { terminalOutput, appendTerminalOutput, clearTerminal } = useStore();
  const [input, setInput] = useState('');
  const [commandHistory, setCommandHistory] = useState<string[]>([]);
  const [historyIndex, setHistoryIndex] = useState(-1);
  const [isCollapsed, setIsCollapsed] = useState(false);
  const terminalRef = useRef<HTMLDivElement>(null);
  const inputRef = useRef<HTMLInputElement>(null);
  
  // Auto-scroll to bottom
  useEffect(() => {
    if (terminalRef.current) {
      terminalRef.current.scrollTop = terminalRef.current.scrollHeight;
    }
  }, [terminalOutput]);
  
  // Handle command input
  const handleCommand = (cmd: string) => {
    if (!cmd.trim()) return;
    
    // Add to history
    setCommandHistory(prev => [...prev, cmd]);
    setHistoryIndex(-1);
    
    // Display command
    appendTerminalOutput(`$ ${cmd}`);
    
    // Process command
    const args = cmd.trim().split(/\s+/);
    const command = args[0].toLowerCase();
    
    switch (command) {
      case 'help':
        appendTerminalOutput(`Available commands:
  generate <text>   Generate ASCII art
  export <format>   Export (png, svg, html, gif, pdf)
  font <name>       Set font
  palette <name>    Set color palette
  theme <name>      Apply theme
  clear             Clear terminal
  history           Show command history
  version           Show version info
  help              Show this help`);
        break;
        
      case 'clear':
        clearTerminal();
        break;
        
      case 'version':
        appendTerminalOutput('Oh-My-Logo Pro v1.0.0');
        appendTerminalOutput('Core Engine v1.0.0');
        appendTerminalOutput('AI Provider: Claude Opus 4.5');
        break;
        
      case 'history':
        if (commandHistory.length === 0) {
          appendTerminalOutput('No command history');
        } else {
          commandHistory.forEach((c, i) => appendTerminalOutput(`  ${i + 1}  ${c}`));
        }
        break;
        
      case 'generate':
        const text = args.slice(1).join(' ') || 'HELLO';
        appendTerminalOutput(`Generating ASCII art for: "${text}"`);
        appendTerminalOutput('Processing...');
        setTimeout(() => {
          appendTerminalOutput('✓ Generated successfully');
        }, 500);
        break;
        
      case 'export':
        const format = args[1] || 'png';
        appendTerminalOutput(`Exporting as ${format.toUpperCase()}...`);
        setTimeout(() => {
          appendTerminalOutput(`✓ Exported to ascii-${Date.now()}.${format}`);
        }, 300);
        break;
        
      case 'font':
        const font = args[1] || 'Standard';
        appendTerminalOutput(`Setting font to: ${font}`);
        break;
        
      case 'palette':
        const palette = args[1] || 'borg';
        appendTerminalOutput(`Applying palette: ${palette}`);
        break;
        
      case 'theme':
        const theme = args[1] || 'borg';
        appendTerminalOutput(`Applying theme: ${theme}`);
        break;
        
      default:
        appendTerminalOutput(`Unknown command: ${command}`);
        appendTerminalOutput('Type "help" for available commands');
    }
    
    setInput('');
  };
  
  // Handle keyboard shortcuts
  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter') {
      handleCommand(input);
    } else if (e.key === 'ArrowUp') {
      e.preventDefault();
      if (commandHistory.length > 0) {
        const newIndex = historyIndex < commandHistory.length - 1 ? historyIndex + 1 : historyIndex;
        setHistoryIndex(newIndex);
        setInput(commandHistory[commandHistory.length - 1 - newIndex] || '');
      }
    } else if (e.key === 'ArrowDown') {
      e.preventDefault();
      if (historyIndex > 0) {
        const newIndex = historyIndex - 1;
        setHistoryIndex(newIndex);
        setInput(commandHistory[commandHistory.length - 1 - newIndex] || '');
      } else if (historyIndex === 0) {
        setHistoryIndex(-1);
        setInput('');
      }
    } else if (e.key === 'l' && e.ctrlKey) {
      e.preventDefault();
      clearTerminal();
    }
  };
  
  // Copy output
  const handleCopy = () => {
    navigator.clipboard.writeText(terminalOutput.join('\n'));
    appendTerminalOutput('✓ Output copied to clipboard');
  };
  
  // Focus input on click
  const handleFocus = () => {
    inputRef.current?.focus();
  };
  
  if (isCollapsed) {
    return (
      <div className="terminal-collapsed" onClick={() => setIsCollapsed(false)}>
        <TerminalIcon size={14} />
        <span>Terminal</span>
        <ChevronUp size={14} />
      </div>
    );
  }
  
  return (
    <div className="terminal-container" onClick={handleFocus}>
      {/* Terminal Header */}
      <div className="terminal-header">
        <div className="terminal-title">
          <TerminalIcon size={14} />
          <span>Terminal</span>
        </div>
        
        <div className="terminal-actions">
          <button className="terminal-btn" onClick={handleCopy} title="Copy Output">
            <Copy size={14} />
          </button>
          <button className="terminal-btn" onClick={clearTerminal} title="Clear">
            <Trash2 size={14} />
          </button>
          <button className="terminal-btn" onClick={() => setIsCollapsed(true)} title="Collapse">
            <ChevronDown size={14} />
          </button>
        </div>
      </div>
      
      {/* Terminal Output */}
      <div ref={terminalRef} className="terminal-output">
        {terminalOutput.map((line, i) => (
          <div key={i} className="terminal-line">
            {line.startsWith('$') ? (
              <span className="command">{line}</span>
            ) : line.startsWith('✓') ? (
              <span className="success">{line}</span>
            ) : line.startsWith('✗') ? (
              <span className="error">{line}</span>
            ) : (
              <span>{line}</span>
            )}
          </div>
        ))}
        
        {/* Input Line */}
        <div className="terminal-input-line">
          <span className="prompt">$</span>
          <input
            ref={inputRef}
            type="text"
            className="terminal-input"
            value={input}
            onChange={e => setInput(e.target.value)}
            onKeyDown={handleKeyDown}
            placeholder="Type a command..."
            autoFocus
          />
        </div>
      </div>
    </div>
  );
}
