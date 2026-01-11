/**
 * Center Canvas - ASCII Art Preview with Real-time Updates
 */

import React, { useState, useEffect, useRef, useMemo } from 'react';
import { useStore } from '../../store';
import {
  ZoomIn,
  ZoomOut,
  Maximize,
  Copy,
  Download,
  RefreshCw,
  Grid,
  Eye,
  EyeOff,
} from 'lucide-react';

// ============================================
// ASCII Preview Component
// ============================================

interface AsciiPreviewProps {
  text: string;
  font: string;
  colors: string[];
  direction: 'vertical' | 'horizontal' | 'diagonal';
  zoom: number;
}

function AsciiPreview({ text, font, colors, direction, zoom }: AsciiPreviewProps) {
  // Simulated ASCII art - in production would use figlet
  const asciiArt = useMemo(() => {
    // Simple simulation for demo
    const lines = text.split('\n').length > 1 
      ? text.split('\n') 
      : generateSimpleAscii(text);
    return lines;
  }, [text, font]);
  
  const coloredLines = useMemo(() => {
    return asciiArt.map((line, rowIndex) => {
      const chars = [...line].map((char, colIndex) => {
        let colorIndex: number;
        
        switch (direction) {
          case 'horizontal':
            colorIndex = Math.floor((colIndex / line.length) * colors.length);
            break;
          case 'diagonal':
            colorIndex = Math.floor(((rowIndex + colIndex) / (asciiArt.length + line.length)) * colors.length);
            break;
          case 'vertical':
          default:
            colorIndex = Math.floor((rowIndex / asciiArt.length) * colors.length);
        }
        
        return {
          char,
          color: colors[Math.min(colorIndex, colors.length - 1)] || '#fff',
        };
      });
      
      return chars;
    });
  }, [asciiArt, colors, direction]);
  
  return (
    <div 
      className="ascii-preview"
      style={{ fontSize: `${14 * zoom}px` }}
    >
      {coloredLines.map((line, rowIndex) => (
        <div key={rowIndex} className="ascii-line">
          {line.map((item, colIndex) => (
            <span
              key={colIndex}
              style={{ color: item.color }}
            >
              {item.char}
            </span>
          ))}
        </div>
      ))}
    </div>
  );
}

// Simple ASCII generator (placeholder)
function generateSimpleAscii(text: string): string[] {
  // Basic block letters simulation
  const letterHeight = 6;
  const lines: string[] = Array(letterHeight).fill('');
  
  const blockChars = {
    row0: '███████╗',
    row1: '██╔════╝',
    row2: '███████╗',
    row3: '╚════██║',
    row4: '███████║',
    row5: '╚══════╝',
  };
  
  // Generate simple pattern based on text
  for (let i = 0; i < letterHeight; i++) {
    for (const char of text.toUpperCase()) {
      if (char === ' ') {
        lines[i] += '    ';
      } else {
        // Simple pattern based on character
        const charCode = char.charCodeAt(0);
        const pattern = '█▀▄▌▐░▒▓';
        lines[i] += pattern[i % pattern.length].repeat(6) + ' ';
      }
    }
  }
  
  return lines;
}

// ============================================
// Main Center Canvas
// ============================================

export default function CenterCanvas() {
  const { 
    currentDesign, 
    previewText, 
    setPreviewText,
    appendTerminalOutput 
  } = useStore();
  
  const [zoom, setZoom] = useState(1);
  const [showGrid, setShowGrid] = useState(false);
  const [isFullscreen, setIsFullscreen] = useState(false);
  const canvasRef = useRef<HTMLDivElement>(null);
  
  const font = currentDesign?.font || 'Standard';
  const colors = currentDesign?.palette || ['#00ff00', '#00cc00', '#009900'];
  const direction = currentDesign?.direction || 'vertical';
  
  // Zoom controls
  const handleZoomIn = () => setZoom(z => Math.min(z + 0.25, 3));
  const handleZoomOut = () => setZoom(z => Math.max(z - 0.25, 0.5));
  const handleZoomReset = () => setZoom(1);
  
  // Copy to clipboard
  const handleCopy = async () => {
    try {
      // Get the text content from canvas
      const text = canvasRef.current?.innerText || previewText;
      await navigator.clipboard.writeText(text);
      appendTerminalOutput('✓ Copied to clipboard');
    } catch (err) {
      appendTerminalOutput('✗ Failed to copy');
    }
  };
  
  // Export
  const handleExport = () => {
    appendTerminalOutput('Opening export dialog...');
    // Would open export modal
  };
  
  // Fullscreen toggle
  const handleFullscreen = () => {
    if (!isFullscreen) {
      canvasRef.current?.requestFullscreen?.();
    } else {
      document.exitFullscreen?.();
    }
    setIsFullscreen(!isFullscreen);
  };
  
  return (
    <div className="center-canvas">
      {/* Toolbar */}
      <div className="canvas-toolbar">
        <div className="toolbar-left">
          <input
            type="text"
            className="preview-text-input"
            value={previewText}
            onChange={e => setPreviewText(e.target.value)}
            placeholder="Enter text to preview..."
          />
        </div>
        
        <div className="toolbar-center">
          <span className="current-font">Font: {font}</span>
          <span className="color-indicator">
            {colors.map((c, i) => (
              <span key={i} className="color-dot" style={{ backgroundColor: c }} />
            ))}
          </span>
        </div>
        
        <div className="toolbar-right">
          <button className="toolbar-btn" onClick={handleZoomOut} title="Zoom Out">
            <ZoomOut size={16} />
          </button>
          <span className="zoom-level">{Math.round(zoom * 100)}%</span>
          <button className="toolbar-btn" onClick={handleZoomIn} title="Zoom In">
            <ZoomIn size={16} />
          </button>
          <button className="toolbar-btn" onClick={handleZoomReset} title="Reset Zoom">
            <RefreshCw size={16} />
          </button>
          
          <div className="toolbar-divider" />
          
          <button 
            className={`toolbar-btn ${showGrid ? 'active' : ''}`}
            onClick={() => setShowGrid(!showGrid)}
            title="Toggle Grid"
          >
            <Grid size={16} />
          </button>
          
          <div className="toolbar-divider" />
          
          <button className="toolbar-btn" onClick={handleCopy} title="Copy to Clipboard">
            <Copy size={16} />
          </button>
          <button className="toolbar-btn" onClick={handleExport} title="Export">
            <Download size={16} />
          </button>
          <button className="toolbar-btn" onClick={handleFullscreen} title="Fullscreen">
            <Maximize size={16} />
          </button>
        </div>
      </div>
      
      {/* Canvas Area */}
      <div 
        ref={canvasRef}
        className={`canvas-area ${showGrid ? 'show-grid' : ''}`}
      >
        <div className="canvas-content">
          <AsciiPreview
            text={previewText}
            font={font}
            colors={colors}
            direction={direction}
            zoom={zoom}
          />
        </div>
        
        {showGrid && (
          <div className="grid-overlay" />
        )}
      </div>
      
      {/* Status Bar */}
      <div className="canvas-status">
        <span>Lines: {previewText.split('\n').length}</span>
        <span>Chars: {previewText.length}</span>
        <span>Direction: {direction}</span>
      </div>
    </div>
  );
}
