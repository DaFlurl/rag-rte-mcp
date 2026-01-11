/**
 * Oh-My-Logo Pro - Main Application
 * AI-Powered ASCII Art Studio
 */

import React, { useState, useEffect } from 'react';
import { Panel, PanelGroup, PanelResizeHandle } from 'react-resizable-panels';
import { useStore } from './store';

// Components
import LeftPanel from './components/LeftPanel';
import CenterCanvas from './components/CenterCanvas';
import RightPanel from './components/RightPanel';
import Timeline from './components/Timeline';
import Terminal from './components/Terminal';
import Header from './components/Header';

// Styles
import './styles/globals.css';

export default function App() {
  const { 
    currentDesign, 
    aiProvider, 
    theme,
    showTimeline,
    showTerminal,
  } = useStore();
  
  return (
    <div className={`app-container theme-${theme}`}>
      {/* Header Bar */}
      <Header />
      
      {/* Main Content */}
      <div className="main-content">
        <PanelGroup direction="horizontal" className="panel-group-horizontal">
          {/* Left Panel - Project Browser, Fonts, Palettes */}
          <Panel defaultSize={20} minSize={15} maxSize={30}>
            <LeftPanel />
          </Panel>
          
          <PanelResizeHandle className="resize-handle-horizontal" />
          
          {/* Center - Canvas and Timeline */}
          <Panel defaultSize={55} minSize={40}>
            <PanelGroup direction="vertical">
              {/* Main Canvas */}
              <Panel defaultSize={showTimeline ? 75 : 100} minSize={50}>
                <CenterCanvas />
              </Panel>
              
              {/* Timeline (collapsible) */}
              {showTimeline && (
                <>
                  <PanelResizeHandle className="resize-handle-vertical" />
                  <Panel defaultSize={25} minSize={15} maxSize={40}>
                    <Timeline />
                  </Panel>
                </>
              )}
            </PanelGroup>
          </Panel>
          
          <PanelResizeHandle className="resize-handle-horizontal" />
          
          {/* Right Panel - AI Chatbot, Prompt Enhancer, Memory */}
          <Panel defaultSize={25} minSize={20} maxSize={35}>
            <RightPanel />
          </Panel>
        </PanelGroup>
      </div>
      
      {/* Bottom Terminal (collapsible) */}
      {showTerminal && (
        <div className="terminal-container">
          <Terminal />
        </div>
      )}
      
      {/* Status Bar */}
      <div className="status-bar">
        <div className="status-left">
          <span className="status-item">
            <span className="status-dot active" />
            {aiProvider}
          </span>
          <span className="status-item">
            {currentDesign?.font || 'No font selected'}
          </span>
        </div>
        <div className="status-right">
          <span className="status-item">
            v1.0.0
          </span>
        </div>
      </div>
    </div>
  );
}
