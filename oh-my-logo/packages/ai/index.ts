/**
 * AI Provider Factory
 * Creates AI provider instances based on configuration
 */

import type { AIAgent, AIProviderConfig, AIProviderType } from './types';
import { ClaudeProvider } from './providers/claude';
import { OllamaProvider } from './providers/ollama';

// Provider registry
const providers: Record<AIProviderType, new (config: AIProviderConfig) => AIAgent> = {
  claude: ClaudeProvider,
  ollama: OllamaProvider,
  openrouter: ClaudeProvider, // Uses same interface with different base URL
  lmstudio: OllamaProvider,   // Uses OpenAI-compatible API
  openai: ClaudeProvider,     // Similar API structure
};

/**
 * Create an AI provider instance
 */
export function createProvider(config: AIProviderConfig): AIAgent {
  const ProviderClass = providers[config.type];
  
  if (!ProviderClass) {
    throw new Error(`Unknown AI provider type: ${config.type}`);
  }
  
  return new ProviderClass(config);
}

/**
 * Create default provider from environment
 */
export function createDefaultProvider(): AIAgent {
  const providerType = (process.env.AI_DEFAULT_PROVIDER || 'claude') as AIProviderType;
  
  const configs: Record<AIProviderType, AIProviderConfig> = {
    claude: {
      type: 'claude',
      apiKey: process.env.ANTHROPIC_API_KEY,
      model: process.env.CLAUDE_MODEL || 'claude-opus-4-5-20250514',
    },
    openrouter: {
      type: 'openrouter',
      apiKey: process.env.OPENROUTER_API_KEY,
      baseUrl: 'https://openrouter.ai/api/v1',
      model: process.env.OPENROUTER_MODEL || 'anthropic/claude-3.5-sonnet',
    },
    ollama: {
      type: 'ollama',
      baseUrl: process.env.OLLAMA_BASE_URL || 'http://localhost:11434',
      model: process.env.OLLAMA_MODEL || 'llama3.1:70b',
    },
    lmstudio: {
      type: 'lmstudio',
      baseUrl: process.env.LMSTUDIO_BASE_URL || 'http://localhost:1234/v1',
      model: process.env.LMSTUDIO_MODEL || 'local-model',
    },
    openai: {
      type: 'openai',
      apiKey: process.env.OPENAI_API_KEY,
      model: process.env.OPENAI_MODEL || 'gpt-4-turbo',
    },
  };
  
  return createProvider(configs[providerType]);
}

/**
 * List available providers
 */
export function listProviders(): AIProviderType[] {
  return Object.keys(providers) as AIProviderType[];
}

/**
 * Check if provider is available (has required config)
 */
export function isProviderAvailable(type: AIProviderType): boolean {
  switch (type) {
    case 'claude':
      return !!process.env.ANTHROPIC_API_KEY;
    case 'openrouter':
      return !!process.env.OPENROUTER_API_KEY;
    case 'openai':
      return !!process.env.OPENAI_API_KEY;
    case 'ollama':
    case 'lmstudio':
      return true; // Local providers always "available"
    default:
      return false;
  }
}

// Re-export types
export * from './types';
export { ClaudeProvider } from './providers/claude';
export { OllamaProvider } from './providers/ollama';
