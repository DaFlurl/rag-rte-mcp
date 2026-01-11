/**
 * Right Panel - AI Chatbot & Prompt Enhancer
 */

import React, { useState, useRef, useEffect } from 'react';
import { useStore } from '../../store';
import { 
  MessageSquare, 
  Sparkles, 
  History, 
  Send, 
  Loader2,
  Settings,
  Zap,
  Brain,
  Wand2
} from 'lucide-react';

// ============================================
// AI Chat Tab
// ============================================

function ChatTab() {
  const { 
    chatMessages, 
    addChatMessage, 
    isAiLoading, 
    setIsAiLoading,
    aiProvider,
    currentDesign,
    setCurrentDesign
  } = useStore();
  
  const [input, setInput] = useState('');
  const messagesEndRef = useRef<HTMLDivElement>(null);
  
  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  };
  
  useEffect(() => {
    scrollToBottom();
  }, [chatMessages]);
  
  const handleSend = async () => {
    if (!input.trim() || isAiLoading) return;
    
    const userMessage = input.trim();
    setInput('');
    
    // Add user message
    addChatMessage({ role: 'user', content: userMessage });
    
    // Simulate AI response (replace with real API call)
    setIsAiLoading(true);
    
    try {
      // TODO: Replace with actual AI call
      await new Promise(resolve => setTimeout(resolve, 1500));
      
      addChatMessage({
        role: 'assistant',
        content: `I'll help you create that! Here's what I suggest:

**Font:** ANSI Shadow
**Palette:** Borg Green (#00ff00 → #00cc00 → #009900)
**Direction:** Diagonal gradient
**Effects:** Subtle glow

Would you like me to generate this design, or would you like to adjust any of these settings?`,
      });
    } catch (error) {
      addChatMessage({
        role: 'assistant',
        content: 'Sorry, I encountered an error. Please try again.',
      });
    } finally {
      setIsAiLoading(false);
    }
  };
  
  const handleKeyPress = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      handleSend();
    }
  };
  
  return (
    <div className="chat-container">
      {/* Chat Messages */}
      <div className="chat-messages">
        {chatMessages.length === 0 ? (
          <div className="chat-empty">
            <Brain className="chat-empty-icon" />
            <h3>AI Design Assistant</h3>
            <p>Describe what you want to create and I'll help design it.</p>
            <div className="chat-suggestions">
              <button onClick={() => setInput('Create a cyberpunk logo for "NEON"')}>
                Cyberpunk logo
              </button>
              <button onClick={() => setInput('Make a retro 80s banner')}>
                Retro banner
              </button>
              <button onClick={() => setInput('Design a hacker-style header')}>
                Hacker header
              </button>
            </div>
          </div>
        ) : (
          chatMessages.map((msg) => (
            <div key={msg.id} className={`chat-message ${msg.role}`}>
              <div className="chat-message-content">
                {msg.content}
              </div>
              <div className="chat-message-time">
                {msg.timestamp.toLocaleTimeString()}
              </div>
            </div>
          ))
        )}
        
        {isAiLoading && (
          <div className="chat-message assistant loading">
            <Loader2 className="animate-spin" />
            <span>Thinking...</span>
          </div>
        )}
        
        <div ref={messagesEndRef} />
      </div>
      
      {/* Chat Input */}
      <div className="chat-input-container">
        <textarea
          className="chat-input"
          placeholder="Describe your logo design..."
          value={input}
          onChange={(e) => setInput(e.target.value)}
          onKeyPress={handleKeyPress}
          rows={2}
        />
        <button 
          className="chat-send-btn"
          onClick={handleSend}
          disabled={!input.trim() || isAiLoading}
        >
          {isAiLoading ? <Loader2 className="animate-spin" /> : <Send />}
        </button>
      </div>
    </div>
  );
}

// ============================================
// Prompt Enhancer Tab
// ============================================

function EnhancerTab() {
  const { enhancedPrompt, setEnhancedPrompt, setIsAiLoading, isAiLoading } = useStore();
  const [basicPrompt, setBasicPrompt] = useState('');
  const [enhancementLevel, setEnhancementLevel] = useState<'basic' | 'detailed' | 'extreme'>('extreme');
  
  const handleEnhance = async () => {
    if (!basicPrompt.trim()) return;
    
    setIsAiLoading(true);
    
    try {
      // TODO: Replace with actual AI call
      await new Promise(resolve => setTimeout(resolve, 2000));
      
      setEnhancedPrompt({
        original: basicPrompt,
        enhanced: `Create a stunning ${basicPrompt} with the following specifications:

**Typography:** Use the "ANSI Shadow" FIGlet font for a bold, modern look with crisp edges and excellent readability.

**Color Palette:** Apply a vibrant gradient using these exact hex values:
- Primary: #00ff00 (Electric Lime)
- Secondary: #00cc00 (Borg Green)
- Accent: #009900 (Deep Forest)

**Gradient Direction:** Diagonal (top-left to bottom-right) for dynamic visual flow.

**Effects:**
- Shadow: 2px offset, 50% opacity, #004400
- Outline: 1px width, #00ff00
- Glow: Subtle 5px spread, #00ff0066

**Layout:** Center-aligned with 20% padding, aspect ratio 16:9 for banner compatibility.

**Animation (optional):** Typewriter reveal, 50ms per character, loop disabled.`,
        suggestions: [
          'Add a subtle scanline effect for retro feel',
          'Consider using "3D-ASCII" font for more depth',
          'Try rainbow gradient for more impact',
        ],
        detectedIntent: 'logo',
        recommendedStyle: {
          name: 'Borg',
          font: 'ANSI Shadow',
          palette: ['#00ff00', '#00cc00', '#009900'],
          effects: {},
        },
      });
    } finally {
      setIsAiLoading(false);
    }
  };
  
  return (
    <div className="enhancer-container">
      <div className="enhancer-header">
        <Wand2 />
        <h3>Prompt Enhancer</h3>
      </div>
      
      <div className="enhancer-input-section">
        <label>Basic Prompt</label>
        <textarea
          className="enhancer-input"
          placeholder="e.g., cyberpunk logo for my gaming channel"
          value={basicPrompt}
          onChange={(e) => setBasicPrompt(e.target.value)}
          rows={3}
        />
      </div>
      
      <div className="enhancer-level-section">
        <label>Enhancement Level</label>
        <div className="enhancer-levels">
          {(['basic', 'detailed', 'extreme'] as const).map((level) => (
            <button
              key={level}
              className={`enhancer-level-btn ${enhancementLevel === level ? 'active' : ''}`}
              onClick={() => setEnhancementLevel(level)}
            >
              {level === 'basic' && <Zap size={14} />}
              {level === 'detailed' && <Sparkles size={14} />}
              {level === 'extreme' && <Brain size={14} />}
              {level.charAt(0).toUpperCase() + level.slice(1)}
            </button>
          ))}
        </div>
      </div>
      
      <button 
        className="enhancer-btn"
        onClick={handleEnhance}
        disabled={!basicPrompt.trim() || isAiLoading}
      >
        {isAiLoading ? (
          <>
            <Loader2 className="animate-spin" />
            Enhancing...
          </>
        ) : (
          <>
            <Sparkles />
            Enhance Prompt
          </>
        )}
      </button>
      
      {enhancedPrompt && (
        <div className="enhanced-result">
          <div className="enhanced-header">
            <h4>Enhanced Prompt</h4>
            <button className="copy-btn">Copy</button>
          </div>
          <div className="enhanced-content">
            {enhancedPrompt.enhanced}
          </div>
          
          {enhancedPrompt.suggestions.length > 0 && (
            <div className="enhanced-suggestions">
              <h5>Suggestions</h5>
              <ul>
                {enhancedPrompt.suggestions.map((s, i) => (
                  <li key={i}>{s}</li>
                ))}
              </ul>
            </div>
          )}
        </div>
      )}
    </div>
  );
}

// ============================================
// Memory Tab
// ============================================

function MemoryTab() {
  const recentProjects = [
    { id: '1', name: 'SVONY Logo', date: '2 hours ago' },
    { id: '2', name: 'Gaming Banner', date: 'Yesterday' },
    { id: '3', name: 'Tech Header', date: '3 days ago' },
  ];
  
  return (
    <div className="memory-container">
      <div className="memory-header">
        <History />
        <h3>Project Memory</h3>
      </div>
      
      <div className="memory-section">
        <h4>Recent Projects</h4>
        <div className="memory-projects">
          {recentProjects.map((project) => (
            <div key={project.id} className="memory-project-item">
              <div className="memory-project-info">
                <span className="memory-project-name">{project.name}</span>
                <span className="memory-project-date">{project.date}</span>
              </div>
              <button className="memory-restore-btn">Restore</button>
            </div>
          ))}
        </div>
      </div>
      
      <div className="memory-section">
        <h4>Favorite Styles</h4>
        <div className="memory-styles">
          <div className="memory-style-chip">Borg Green</div>
          <div className="memory-style-chip">Cyberpunk</div>
          <div className="memory-style-chip">Retro</div>
        </div>
      </div>
      
      <div className="memory-section">
        <h4>Favorite Fonts</h4>
        <div className="memory-fonts">
          <div className="memory-font-chip">ANSI Shadow</div>
          <div className="memory-font-chip">3D-ASCII</div>
          <div className="memory-font-chip">Isometric1</div>
        </div>
      </div>
    </div>
  );
}

// ============================================
// Main Right Panel
// ============================================

export default function RightPanel() {
  const { rightPanelTab, setRightPanelTab, aiProvider, setAiProvider } = useStore();
  
  return (
    <div className="right-panel">
      {/* Tab Header */}
      <div className="right-panel-header">
        <div className="right-panel-tabs">
          <button
            className={`tab-btn ${rightPanelTab === 'chat' ? 'active' : ''}`}
            onClick={() => setRightPanelTab('chat')}
          >
            <MessageSquare size={16} />
            Chat
          </button>
          <button
            className={`tab-btn ${rightPanelTab === 'enhancer' ? 'active' : ''}`}
            onClick={() => setRightPanelTab('enhancer')}
          >
            <Sparkles size={16} />
            Enhancer
          </button>
          <button
            className={`tab-btn ${rightPanelTab === 'memory' ? 'active' : ''}`}
            onClick={() => setRightPanelTab('memory')}
          >
            <History size={16} />
            Memory
          </button>
        </div>
        
        {/* AI Provider Selector */}
        <div className="ai-provider-selector">
          <select 
            value={aiProvider}
            onChange={(e) => setAiProvider(e.target.value as any)}
          >
            <option value="claude">Claude Opus 4.5</option>
            <option value="openrouter">OpenRouter</option>
            <option value="ollama">Ollama (Local)</option>
            <option value="lmstudio">LM Studio</option>
          </select>
          <Settings size={14} />
        </div>
      </div>
      
      {/* Tab Content */}
      <div className="right-panel-content">
        {rightPanelTab === 'chat' && <ChatTab />}
        {rightPanelTab === 'enhancer' && <EnhancerTab />}
        {rightPanelTab === 'memory' && <MemoryTab />}
      </div>
    </div>
  );
}
