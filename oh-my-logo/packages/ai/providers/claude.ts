/**
 * Claude AI Provider
 * Default AI provider using Anthropic's Claude API
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

// System prompt for logo design assistance
const SYSTEM_PROMPT = `You are an expert ASCII art and logo design assistant for Oh-My-Logo Pro.

Your capabilities:
1. Generate creative ASCII logo designs with detailed specifications
2. Suggest fonts, colors, and effects based on user intent
3. Refine designs based on feedback
4. Detect design intent (logo, banner, header, badge, etc.)
5. Enhance basic prompts into detailed design specifications

When generating logo designs, always respond with valid JSON in this format:
{
  "text": "THE TEXT",
  "font": "FIGlet font name",
  "palette": ["#hex1", "#hex2", "#hex3"],
  "direction": "vertical|horizontal|diagonal",
  "effects": {
    "shadow": { "enabled": boolean, "color": "#hex", "offsetX": number, "offsetY": number },
    "outline": { "enabled": boolean, "color": "#hex", "width": number },
    "glow": { "enabled": boolean, "color": "#hex", "intensity": number }
  },
  "reasoning": "Brief explanation of design choices"
}

Available FIGlet fonts: Standard, Big, Banner, Block, Bubble, Digital, Doom, Epic, 
Graffiti, Isometric1, Isometric3, Larry 3D, Letters, Pebbles, Puffy, Roman, 
Script, Shadow, Slant, Small, Speed, Star Wars, Stop, Straight, 3D-ASCII, ANSI Shadow.

Color guidelines:
- Use vibrant gradients for impact
- Ensure readability with sufficient contrast
- Match colors to the tone (corporate=subdued, hacker=green, neon=bright)`;

export class ClaudeProvider implements AIAgent {
  readonly provider = 'claude' as const;
  readonly model: string;
  
  private apiKey: string;
  private baseUrl: string;
  private context: ConversationContext | null = null;
  
  constructor(config: AIProviderConfig) {
    this.apiKey = config.apiKey || process.env.ANTHROPIC_API_KEY || '';
    this.model = config.model || 'claude-opus-4-5-20250514';
    this.baseUrl = 'https://api.anthropic.com/v1';
    
    if (!this.apiKey) {
      console.warn('Warning: ANTHROPIC_API_KEY not set');
    }
  }
  
  async chat(messages: AIMessage[]): Promise<AIResponse> {
    const response = await fetch(`${this.baseUrl}/messages`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': this.apiKey,
        'anthropic-version': '2023-06-01',
      },
      body: JSON.stringify({
        model: this.model,
        max_tokens: 4096,
        system: SYSTEM_PROMPT,
        messages: messages.filter(m => m.role !== 'system').map(m => ({
          role: m.role,
          content: m.content,
        })),
      }),
    });
    
    if (!response.ok) {
      const error = await response.text();
      throw new Error(`Claude API error: ${response.status} - ${error}`);
    }
    
    const data = await response.json();
    
    return {
      content: data.content[0].text,
      model: data.model,
      usage: {
        inputTokens: data.usage?.input_tokens || 0,
        outputTokens: data.usage?.output_tokens || 0,
      },
      finishReason: data.stop_reason,
    };
  }
  
  async generateLogo(prompt: string): Promise<LogoDesign> {
    const messages: AIMessage[] = [
      {
        role: 'user',
        content: `Generate an ASCII logo design for: "${prompt}"
        
Respond with a complete JSON design specification.`,
      },
    ];
    
    const response = await this.chat(messages);
    
    try {
      // Extract JSON from response
      const jsonMatch = response.content.match(/\{[\s\S]*\}/);
      if (!jsonMatch) {
        throw new Error('No JSON found in response');
      }
      
      const design = JSON.parse(jsonMatch[0]);
      
      return {
        id: crypto.randomUUID(),
        text: design.text || prompt,
        font: design.font || 'Standard',
        palette: design.palette || ['#00ff00', '#00cc00', '#009900'],
        direction: design.direction || 'vertical',
        effects: design.effects || {},
        metadata: {
          createdAt: new Date(),
          updatedAt: new Date(),
          version: 1,
          tags: [],
          description: design.reasoning,
        },
      };
    } catch (error) {
      // Fallback to default design
      return {
        id: crypto.randomUUID(),
        text: prompt,
        font: 'Standard',
        palette: ['#00ff00', '#00cc00', '#009900'],
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
    const messages: AIMessage[] = [
      {
        role: 'user',
        content: `Current design:
${JSON.stringify(current, null, 2)}

User feedback: "${feedback}"

Generate an improved design based on the feedback. Respond with complete JSON.`,
      },
    ];
    
    const response = await this.chat(messages);
    
    try {
      const jsonMatch = response.content.match(/\{[\s\S]*\}/);
      if (!jsonMatch) throw new Error('No JSON found');
      
      const refined = JSON.parse(jsonMatch[0]);
      
      return {
        ...current,
        ...refined,
        id: current.id,
        metadata: {
          ...current.metadata,
          updatedAt: new Date(),
          version: current.metadata.version + 1,
        },
      };
    } catch {
      return current;
    }
  }
  
  async suggestImprovements(design: LogoDesign): Promise<Suggestion[]> {
    const messages: AIMessage[] = [
      {
        role: 'user',
        content: `Analyze this ASCII logo design and suggest improvements:
${JSON.stringify(design, null, 2)}

Respond with JSON array of suggestions:
[{"type": "font|color|effect|layout|general", "description": "...", "confidence": 0.0-1.0}]`,
      },
    ];
    
    const response = await this.chat(messages);
    
    try {
      const jsonMatch = response.content.match(/\[[\s\S]*\]/);
      if (!jsonMatch) return [];
      
      return JSON.parse(jsonMatch[0]);
    } catch {
      return [];
    }
  }
  
  async detectIntent(prompt: string): Promise<DesignIntent> {
    const messages: AIMessage[] = [
      {
        role: 'user',
        content: `Classify the design intent for: "${prompt}"
        
Options: logo, banner, header, badge, title, signature

Respond with just the single word classification.`,
      },
    ];
    
    const response = await this.chat(messages);
    const intent = response.content.toLowerCase().trim();
    
    const validIntents: DesignIntent[] = ['logo', 'banner', 'header', 'badge', 'title', 'signature'];
    return validIntents.includes(intent as DesignIntent) 
      ? (intent as DesignIntent) 
      : 'logo';
  }
  
  async suggestStyle(context: StyleContext): Promise<StylePreset> {
    const messages: AIMessage[] = [
      {
        role: 'user',
        content: `Suggest a style preset for:
Brand: ${context.brand || 'Not specified'}
Industry: ${context.industry || 'Not specified'}
Tone: ${context.tone || 'Not specified'}
Preferred colors: ${context.colors?.join(', ') || 'Not specified'}

Respond with JSON: {"name": "...", "font": "...", "palette": [...], "effects": {...}}`,
      },
    ];
    
    const response = await this.chat(messages);
    
    try {
      const jsonMatch = response.content.match(/\{[\s\S]*\}/);
      if (!jsonMatch) throw new Error('No JSON found');
      
      return JSON.parse(jsonMatch[0]);
    } catch {
      return {
        name: 'Default',
        font: 'Standard',
        palette: ['#00ff00', '#00cc00', '#009900'],
        effects: {},
      };
    }
  }
  
  async enhancePrompt(basic: string, level: EnhancementLevel = 'extreme'): Promise<EnhancedPrompt> {
    const levelInstructions = {
      basic: 'Add minor details to improve the prompt',
      detailed: 'Expand with specific styling suggestions and context',
      extreme: `Transform this into an extremely detailed, professional design brief.
Include: specific font recommendations, exact color hex codes, effect parameters,
layout suggestions, animation possibilities, and alternative variations.
Be creative but practical. Think like a professional graphic designer.`,
    };
    
    const messages: AIMessage[] = [
      {
        role: 'user',
        content: `Enhance this basic prompt: "${basic}"

Enhancement level: ${level}
${levelInstructions[level]}

Respond with JSON:
{
  "original": "...",
  "enhanced": "extremely detailed prompt...",
  "suggestions": ["suggestion1", "suggestion2", ...],
  "detectedIntent": "logo|banner|header|badge|title|signature",
  "recommendedStyle": {"name": "...", "font": "...", "palette": [...], "effects": {...}}
}`,
      },
    ];
    
    const response = await this.chat(messages);
    
    try {
      const jsonMatch = response.content.match(/\{[\s\S]*\}/);
      if (!jsonMatch) throw new Error('No JSON found');
      
      const result = JSON.parse(jsonMatch[0]);
      return {
        original: basic,
        enhanced: result.enhanced || basic,
        suggestions: result.suggestions || [],
        detectedIntent: result.detectedIntent || 'logo',
        recommendedStyle: result.recommendedStyle || {
          name: 'Default',
          font: 'Standard',
          palette: ['#00ff00'],
          effects: {},
        },
      };
    } catch {
      return {
        original: basic,
        enhanced: basic,
        suggestions: [],
        detectedIntent: 'logo',
        recommendedStyle: {
          name: 'Default',
          font: 'Standard',
          palette: ['#00ff00'],
          effects: {},
        },
      };
    }
  }
  
  async saveContext(context: ConversationContext): Promise<void> {
    this.context = context;
    // In production, persist to storage
  }
  
  async getContext(): Promise<ConversationContext | null> {
    return this.context;
  }
}

export default ClaudeProvider;
