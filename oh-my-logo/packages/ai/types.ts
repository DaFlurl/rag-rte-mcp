/**
 * AI Provider Types and Interfaces
 * Core abstraction for multi-provider AI support
 */

// ============================================
// Provider Types
// ============================================

export type AIProviderType = 
  | 'claude' 
  | 'openrouter' 
  | 'ollama' 
  | 'lmstudio' 
  | 'openai';

export interface AIProviderConfig {
  type: AIProviderType;
  apiKey?: string;
  baseUrl?: string;
  model: string;
  maxTokens?: number;
  temperature?: number;
}

// ============================================
// Message Types
// ============================================

export interface AIMessage {
  role: 'system' | 'user' | 'assistant';
  content: string;
}

export interface AIResponse {
  content: string;
  model: string;
  usage?: {
    inputTokens: number;
    outputTokens: number;
  };
  finishReason?: string;
}

// ============================================
// Logo Design Types
// ============================================

export interface LogoDesign {
  id: string;
  text: string;
  font: string;
  palette: string[];
  direction: 'vertical' | 'horizontal' | 'diagonal';
  effects: EffectOptions;
  animation?: AnimationOptions;
  metadata: DesignMetadata;
}

export interface EffectOptions {
  shadow?: ShadowConfig;
  outline?: OutlineConfig;
  glow?: GlowConfig;
  background?: BackgroundConfig;
}

export interface ShadowConfig {
  enabled: boolean;
  color: string;
  offsetX: number;
  offsetY: number;
  blur: number;
}

export interface OutlineConfig {
  enabled: boolean;
  color: string;
  width: number;
}

export interface GlowConfig {
  enabled: boolean;
  color: string;
  intensity: number;
  spread: number;
}

export interface BackgroundConfig {
  type: 'solid' | 'gradient' | 'pattern' | 'transparent';
  color?: string;
  gradient?: string[];
  pattern?: string;
}

export interface AnimationOptions {
  enabled: boolean;
  type: 'typewriter' | 'fade' | 'slide' | 'glitch' | 'wave' | 'rainbow';
  duration: number;
  loop: boolean;
  easing: string;
}

export interface DesignMetadata {
  createdAt: Date;
  updatedAt: Date;
  version: number;
  tags: string[];
  description?: string;
}

// ============================================
// AI Agent Interface
// ============================================

export interface AIAgent {
  // Provider info
  readonly provider: AIProviderType;
  readonly model: string;
  
  // Basic operations
  chat(messages: AIMessage[]): Promise<AIResponse>;
  
  // Design operations
  generateLogo(prompt: string): Promise<LogoDesign>;
  refineLogo(current: LogoDesign, feedback: string): Promise<LogoDesign>;
  suggestImprovements(design: LogoDesign): Promise<Suggestion[]>;
  
  // Intelligence
  detectIntent(prompt: string): Promise<DesignIntent>;
  suggestStyle(context: StyleContext): Promise<StylePreset>;
  
  // Prompt enhancement
  enhancePrompt(basic: string, level?: EnhancementLevel): Promise<EnhancedPrompt>;
  
  // Memory operations
  saveContext(context: ConversationContext): Promise<void>;
  getContext(): Promise<ConversationContext | null>;
}

export interface Suggestion {
  type: 'font' | 'color' | 'effect' | 'layout' | 'general';
  description: string;
  preview?: string;
  confidence: number;
}

export type DesignIntent = 
  | 'logo' 
  | 'banner' 
  | 'header' 
  | 'badge' 
  | 'title' 
  | 'signature';

export interface StyleContext {
  brand?: string;
  industry?: string;
  tone?: 'serious' | 'playful' | 'corporate' | 'hacker' | 'retro';
  colors?: string[];
}

export interface StylePreset {
  name: string;
  font: string;
  palette: string[];
  effects: EffectOptions;
}

export type EnhancementLevel = 'basic' | 'detailed' | 'extreme';

export interface EnhancedPrompt {
  original: string;
  enhanced: string;
  suggestions: string[];
  detectedIntent: DesignIntent;
  recommendedStyle: StylePreset;
}

export interface ConversationContext {
  projectId: string;
  messages: AIMessage[];
  currentDesign?: LogoDesign;
  preferences: UserPreferences;
  history: DesignSnapshot[];
}

export interface UserPreferences {
  favoritesFonts: string[];
  favoritePalettes: string[];
  defaultStyle: Partial<StylePreset>;
}

export interface DesignSnapshot {
  id: string;
  timestamp: Date;
  design: LogoDesign;
  action: string;
}
