/**
 * Global State Store
 * Using Zustand for lightweight state management
 */

import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import type { LogoDesign, AIProviderType, EnhancedPrompt } from '../../../packages/ai/types';

// ============================================
// Types
// ============================================

interface Project {
  id: string;
  name: string;
  design: LogoDesign | null;
  createdAt: Date;
  updatedAt: Date;
}

interface ChatMessage {
  id: string;
  role: 'user' | 'assistant';
  content: string;
  timestamp: Date;
}

interface AppState {
  // UI State
  theme: 'dark' | 'light';
  showTimeline: boolean;
  showTerminal: boolean;
  sidebarTab: 'projects' | 'fonts' | 'palettes' | 'effects';
  rightPanelTab: 'chat' | 'enhancer' | 'memory';
  
  // Design State
  currentProject: Project | null;
  currentDesign: LogoDesign | null;
  previewText: string;
  
  // AI State
  aiProvider: AIProviderType;
  chatMessages: ChatMessage[];
  isAiLoading: boolean;
  enhancedPrompt: EnhancedPrompt | null;
  
  // Timeline State
  canUndo: boolean;
  canRedo: boolean;
  historyCount: number;
  
  // Terminal State
  terminalOutput: string[];
  
  // Actions
  setTheme: (theme: 'dark' | 'light') => void;
  toggleTimeline: () => void;
  toggleTerminal: () => void;
  setSidebarTab: (tab: 'projects' | 'fonts' | 'palettes' | 'effects') => void;
  setRightPanelTab: (tab: 'chat' | 'enhancer' | 'memory') => void;
  
  setCurrentProject: (project: Project | null) => void;
  setCurrentDesign: (design: LogoDesign | null) => void;
  setPreviewText: (text: string) => void;
  
  setAiProvider: (provider: AIProviderType) => void;
  addChatMessage: (message: Omit<ChatMessage, 'id' | 'timestamp'>) => void;
  clearChat: () => void;
  setIsAiLoading: (loading: boolean) => void;
  setEnhancedPrompt: (prompt: EnhancedPrompt | null) => void;
  
  setCanUndo: (can: boolean) => void;
  setCanRedo: (can: boolean) => void;
  setHistoryCount: (count: number) => void;
  
  appendTerminalOutput: (line: string) => void;
  clearTerminal: () => void;
}

// ============================================
// Store
// ============================================

export const useStore = create<AppState>()(
  persist(
    (set, get) => ({
      // Initial UI State
      theme: 'dark',
      showTimeline: true,
      showTerminal: true,
      sidebarTab: 'fonts',
      rightPanelTab: 'chat',
      
      // Initial Design State
      currentProject: null,
      currentDesign: null,
      previewText: 'HELLO WORLD',
      
      // Initial AI State
      aiProvider: 'claude',
      chatMessages: [],
      isAiLoading: false,
      enhancedPrompt: null,
      
      // Initial Timeline State
      canUndo: false,
      canRedo: false,
      historyCount: 0,
      
      // Initial Terminal State
      terminalOutput: ['Welcome to Oh-My-Logo Pro!', ''],
      
      // UI Actions
      setTheme: (theme) => set({ theme }),
      toggleTimeline: () => set((s) => ({ showTimeline: !s.showTimeline })),
      toggleTerminal: () => set((s) => ({ showTerminal: !s.showTerminal })),
      setSidebarTab: (tab) => set({ sidebarTab: tab }),
      setRightPanelTab: (tab) => set({ rightPanelTab: tab }),
      
      // Design Actions
      setCurrentProject: (project) => set({ currentProject: project }),
      setCurrentDesign: (design) => set({ currentDesign: design }),
      setPreviewText: (text) => set({ previewText: text }),
      
      // AI Actions
      setAiProvider: (provider) => set({ aiProvider: provider }),
      addChatMessage: (message) => set((s) => ({
        chatMessages: [
          ...s.chatMessages,
          {
            ...message,
            id: crypto.randomUUID(),
            timestamp: new Date(),
          },
        ],
      })),
      clearChat: () => set({ chatMessages: [] }),
      setIsAiLoading: (loading) => set({ isAiLoading: loading }),
      setEnhancedPrompt: (prompt) => set({ enhancedPrompt: prompt }),
      
      // Timeline Actions
      setCanUndo: (can) => set({ canUndo: can }),
      setCanRedo: (can) => set({ canRedo: can }),
      setHistoryCount: (count) => set({ historyCount: count }),
      
      // Terminal Actions
      appendTerminalOutput: (line) => set((s) => ({
        terminalOutput: [...s.terminalOutput, line],
      })),
      clearTerminal: () => set({ terminalOutput: [] }),
    }),
    {
      name: 'oh-my-logo-storage',
      partialize: (state) => ({
        theme: state.theme,
        aiProvider: state.aiProvider,
        previewText: state.previewText,
      }),
    }
  )
);

export default useStore;
