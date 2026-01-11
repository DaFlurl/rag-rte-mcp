/**
 * Ollama AI Provider
 * Local LLM support via Ollama
 */

import type {
  AIAgent,
  AIMessage,
  AIResponse,
  AIProviderConfig,
  LogoDesign,
  Suggestion,
  DesignIntent,
  StyleContext,
  StylePreset,
  EnhancedPrompt,
  EnhancementLevel,
  ConversationContext,
} from '../types';

const SYSTEM_PROMPT = `You are an expert ASCII art and logo design assistant.
Generate creative designs with specific fonts, colors, and effects.
Always respond with valid JSON when asked for design specifications.`;

export class OllamaProvider implements AIAgent {
  readonly provider = 'ollama' as const;
  readonly model: string;
  
  private baseUrl: string;
  private context: ConversationContext | null = null;
  
  constructor(config: AIProviderConfig) {
    this.baseUrl = config.baseUrl || process.env.OLLAMA_BASE_URL || 'http://localhost:11434';
    this.model = config.model || process.env.OLLAMA_MODEL || 'llama3.1:70b';
  }
  
  async chat(messages: AIMessage[]): Promise<AIResponse> {
    // Format messages for Ollama
    const formattedMessages = messages.map(m => ({
      role: m.role,
      content: m.content,
    }));
    
    // Add system message if not present
    if (!formattedMessages.find(m => m.role === 'system')) {
      formattedMessages.unshift({
        role: 'system',
        content: SYSTEM_PROMPT,
      });
    }
    
    const response = await fetch(`${this.baseUrl}/api/chat`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        model: this.model,
        messages: formattedMessages,
        stream: false,
      }),
    });
    
    if (!response.ok) {
      throw new Error(`Ollama API error: ${response.status}`);
    }
    
    const data = await response.json();
    
    return {
      content: data.message?.content || '',
      model: this.model,
      usage: {
        inputTokens: data.prompt_eval_count || 0,
        outputTokens: data.eval_count || 0,
      },
    };
  }
  
  async generateLogo(prompt: string): Promise<LogoDesign> {
    const messages: AIMessage[] = [
      {
        role: 'user',
        content: `Generate an ASCII logo design for: "${prompt}"
        
Respond with JSON: {"text": "...", "font": "...", "palette": ["#hex1", "#hex2"], "direction": "vertical|horizontal|diagonal"}`,
      },
    ];
    
    const response = await this.chat(messages);
    
    try {
      const jsonMatch = response.content.match(/\{[\s\S]*\}/);
      if (!jsonMatch) throw new Error('No JSON');
      
      const design = JSON.parse(jsonMatch[0]);
      
      return {
        id: crypto.randomUUID(),
        text: design.text || prompt,
        font: design.font || 'Standard',
        palette: design.palette || ['#00ff00', '#00cc00'],
        direction: design.direction || 'vertical',
        effects: design.effects || {},
        metadata: {
          createdAt: new Date(),
          updatedAt: new Date(),
          version: 1,
          tags: [],
        },
      };
    } catch {
      return {
        id: crypto.randomUUID(),
        text: prompt,
        font: 'Standard',
        palette: ['#00ff00', '#00cc00'],
        direction: 'vertical',
        effects: {},
        metadata: {
          createdAt: new Date(),
          updatedAt: new Date(),
          version: 1,
          tags: [],
        },
      };
    }
  }
  
  async refineLogo(current: LogoDesign, feedback: string): Promise<LogoDesign> {
    const response = await this.chat([
      {
        role: 'user',
        content: `Refine this design based on feedback: "${feedback}"\n\nCurrent: ${JSON.stringify(current)}`,
      },
    ]);
    
    try {
      const jsonMatch = response.content.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        const refined = JSON.parse(jsonMatch[0]);
        return { ...current, ...refined, metadata: { ...current.metadata, version: current.metadata.version + 1 } };
      }
    } catch {}
    return current;
  }
  
  async suggestImprovements(design: LogoDesign): Promise<Suggestion[]> {
    const response = await this.chat([
      {
        role: 'user',
        content: `Suggest improvements for: ${JSON.stringify(design)}\n\nRespond with JSON array.`,
      },
    ]);
    
    try {
      const jsonMatch = response.content.match(/\[[\s\S]*\]/);
      if (jsonMatch) return JSON.parse(jsonMatch[0]);
    } catch {}
    return [];
  }
  
  async detectIntent(prompt: string): Promise<DesignIntent> {
    const response = await this.chat([
      { role: 'user', content: `Classify intent for "${prompt}": logo, banner, header, badge, title, or signature?` },
    ]);
    
    const intent = response.content.toLowerCase();
    if (intent.includes('banner')) return 'banner';
    if (intent.includes('header')) return 'header';
    if (intent.includes('badge')) return 'badge';
    if (intent.includes('title')) return 'title';
    if (intent.includes('signature')) return 'signature';
    return 'logo';
  }
  
  async suggestStyle(context: StyleContext): Promise<StylePreset> {
    return {
      name: context.tone || 'Default',
      font: 'Standard',
      palette: context.colors || ['#00ff00', '#00cc00'],
      effects: {},
    };
  }
  
  async enhancePrompt(basic: string, level: EnhancementLevel = 'detailed'): Promise<EnhancedPrompt> {
    const response = await this.chat([
      {
        role: 'user',
        content: `Enhance this prompt with ${level} detail: "${basic}"`,
      },
    ]);
    
    return {
      original: basic,
      enhanced: response.content,
      suggestions: [],
      detectedIntent: 'logo',
      recommendedStyle: { name: 'Default', font: 'Standard', palette: ['#00ff00'], effects: {} },
    };
  }
  
  async saveContext(context: ConversationContext): Promise<void> {
    this.context = context;
  }
  
  async getContext(): Promise<ConversationContext | null> {
    return this.context;
  }
}

export default OllamaProvider;
