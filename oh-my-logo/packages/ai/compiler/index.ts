/**
 * Prompt → Preset Compiler
 * Converts natural language prompts into themes, templates, presets, and plugins
 */

// ============================================
// Types
// ============================================

export interface CompiledTheme {
  id: string;
  name: string;
  description: string;
  colors: {
    primary: string[];
    secondary: string[];
    accent: string[];
    background: string;
    foreground: string;
  };
  fonts: {
    heading: string;
    body: string;
  };
  effects: {
    shadow?: { enabled: boolean; color: string; offsetX: number; offsetY: number };
    outline?: { enabled: boolean; color: string; width: number };
    glow?: { enabled: boolean; color: string; intensity: number; spread: number };
  };
  mood: string[];
  tags: string[];
}

export interface CompiledTemplate {
  id: string;
  name: string;
  description: string;
  variables: { name: string; default: string; type: 'text' | 'number' | 'color' | 'select'; options?: string[] }[];
  layout: {
    alignment: 'left' | 'center' | 'right';
    padding: number;
    spacing: number;
  };
  style: {
    font: string;
    direction: 'vertical' | 'horizontal' | 'diagonal';
  };
}

export interface CompiledPreset {
  id: string;
  name: string;
  description: string;
  version: string;
  theme: CompiledTheme;
  template: CompiledTemplate;
  metadata: {
    author: string;
    createdAt: Date;
    tags: string[];
    license: string;
  };
}

export interface PluginDefinition {
  name: string;
  version: string;
  type: 'theme' | 'template' | 'effect' | 'font' | 'preset';
  description: string;
  exports: CompiledPreset | CompiledTheme | CompiledTemplate;
  manifest: {
    main: string;
    dependencies: string[];
    peerDependencies: string[];
  };
  install: string; // Install script content
}

export interface CompilerOptions {
  aiProvider?: 'claude' | 'openai' | 'ollama';
  apiKey?: string;
  verbose?: boolean;
}

// ============================================
// Mood/Style Analysis
// ============================================

const MOOD_COLORS: Record<string, string[]> = {
  energetic: ['#ff0000', '#ff6600', '#ffcc00', '#ff3366'],
  calm: ['#00b4db', '#48cae4', '#90e0ef', '#caf0f8'],
  dark: ['#1a1a1a', '#333333', '#4a4a4a', '#666666'],
  nature: ['#228b22', '#2e8b57', '#3cb371', '#90ee90'],
  tech: ['#00ff00', '#00cc00', '#009900', '#006600'],
  retro: ['#ff00ff', '#8b00ff', '#0088ff', '#00ffff'],
  warm: ['#ff9966', '#ff5e62', '#ff3366', '#ffcc00'],
  cool: ['#00b4db', '#0083b0', '#005f73', '#003845'],
  neon: ['#00ffff', '#ff00ff', '#ffff00', '#ff0099'],
  minimal: ['#ffffff', '#e0e0e0', '#c0c0c0', '#a0a0a0'],
  corporate: ['#1a73e8', '#174ea6', '#0d47a1', '#4285f4'],
  playful: ['#ff69b4', '#dda0dd', '#98fb98', '#87ceeb'],
};

const MOOD_KEYWORDS: Record<string, string[]> = {
  energetic: ['bold', 'vibrant', 'exciting', 'dynamic', 'powerful', 'intense'],
  calm: ['peaceful', 'serene', 'relaxing', 'gentle', 'soft', 'tranquil'],
  dark: ['mysterious', 'gothic', 'moody', 'night', 'shadow', 'noir'],
  nature: ['organic', 'forest', 'earth', 'natural', 'green', 'eco'],
  tech: ['hacker', 'matrix', 'cyber', 'digital', 'terminal', 'code'],
  retro: ['80s', 'synthwave', 'vaporwave', 'vintage', 'nostalgic', 'arcade'],
  warm: ['sunset', 'fire', 'autumn', 'cozy', 'orange', 'golden'],
  cool: ['ocean', 'ice', 'winter', 'blue', 'arctic', 'frost'],
  neon: ['electric', 'glow', 'bright', 'fluorescent', 'vivid', 'laser'],
  minimal: ['clean', 'simple', 'modern', 'elegant', 'sleek', 'professional'],
  corporate: ['business', 'enterprise', 'formal', 'official', 'brand'],
  playful: ['fun', 'cute', 'cheerful', 'happy', 'whimsical', 'colorful'],
};

const FONT_SUGGESTIONS: Record<string, string[]> = {
  energetic: ['Doom', 'Banner', 'Block', 'Epic'],
  calm: ['Roman', 'Standard', 'Small', 'Slant'],
  dark: ['Bloody', 'Doom', 'Gothic', 'Shadow'],
  tech: ['ANSI Shadow', '3D-ASCII', 'Digital', 'Cybermedium'],
  retro: ['Larry 3D', 'Isometric1', 'Colossal', 'Banner'],
  minimal: ['Standard', 'Small', 'Thin', 'Mini'],
  corporate: ['Banner', 'Standard', 'Roman', 'Big'],
  playful: ['Bubble', 'Puffy', 'Pebbles', 'Rounded'],
};

// ============================================
// Prompt Analyzer
// ============================================

function analyzePrompt(prompt: string): {
  moods: string[];
  colors: string[];
  fonts: string[];
  effects: string[];
  keywords: string[];
} {
  const lowerPrompt = prompt.toLowerCase();
  const moods: string[] = [];
  const keywords: string[] = [];
  
  // Detect moods from keywords
  for (const [mood, words] of Object.entries(MOOD_KEYWORDS)) {
    for (const word of words) {
      if (lowerPrompt.includes(word)) {
        if (!moods.includes(mood)) moods.push(mood);
        if (!keywords.includes(word)) keywords.push(word);
      }
    }
  }
  
  // Default to tech if no mood detected
  if (moods.length === 0) moods.push('tech');
  
  // Get colors for detected moods
  const colors = moods.flatMap(mood => MOOD_COLORS[mood] || []).slice(0, 6);
  
  // Get font suggestions
  const fonts = moods.flatMap(mood => FONT_SUGGESTIONS[mood] || ['Standard']).slice(0, 3);
  
  // Detect effect preferences
  const effects: string[] = [];
  if (lowerPrompt.includes('glow') || lowerPrompt.includes('neon')) effects.push('glow');
  if (lowerPrompt.includes('shadow') || lowerPrompt.includes('3d')) effects.push('shadow');
  if (lowerPrompt.includes('outline') || lowerPrompt.includes('border')) effects.push('outline');
  
  return { moods, colors, fonts, effects, keywords };
}

// ============================================
// Theme Compiler
// ============================================

export function compileTheme(prompt: string, name?: string): CompiledTheme {
  const analysis = analyzePrompt(prompt);
  const id = `theme-${Date.now()}`;
  
  // Generate colors based on analysis
  const primaryColors = analysis.colors.slice(0, 3);
  const secondaryColors = analysis.colors.slice(0, 3).map(c => lightenColor(c, 20));
  const accentColors = analysis.colors.slice(0, 3).map(c => saturateColor(c, 20));
  
  // Determine background based on mood
  const isDark = analysis.moods.some(m => ['dark', 'tech', 'neon', 'retro'].includes(m));
  
  return {
    id,
    name: name || `${analysis.moods[0]} Theme`,
    description: `Generated from: "${prompt.substring(0, 50)}..."`,
    colors: {
      primary: primaryColors.length ? primaryColors : ['#00ff00', '#00cc00', '#009900'],
      secondary: secondaryColors.length ? secondaryColors : ['#33ff33', '#33cc33', '#339933'],
      accent: accentColors.length ? accentColors : ['#66ff66', '#66cc66', '#669966'],
      background: isDark ? '#0a0a0a' : '#ffffff',
      foreground: isDark ? '#e0e0e0' : '#1a1a1a',
    },
    fonts: {
      heading: analysis.fonts[0] || 'ANSI Shadow',
      body: 'Standard',
    },
    effects: {
      glow: analysis.effects.includes('glow')
        ? { enabled: true, color: primaryColors[0] + '66', intensity: 0.5, spread: 4 }
        : undefined,
      shadow: analysis.effects.includes('shadow')
        ? { enabled: true, color: '#000000', offsetX: 2, offsetY: 2 }
        : undefined,
      outline: analysis.effects.includes('outline')
        ? { enabled: true, color: accentColors[0] || '#ffffff', width: 1 }
        : undefined,
    },
    mood: analysis.moods,
    tags: analysis.keywords,
  };
}

// ============================================
// Template Compiler
// ============================================

export function compileTemplate(prompt: string, name?: string): CompiledTemplate {
  const analysis = analyzePrompt(prompt);
  const id = `template-${Date.now()}`;
  
  // Detect alignment preferences
  let alignment: 'left' | 'center' | 'right' = 'center';
  if (prompt.toLowerCase().includes('left')) alignment = 'left';
  if (prompt.toLowerCase().includes('right')) alignment = 'right';
  
  // Detect direction
  let direction: 'vertical' | 'horizontal' | 'diagonal' = 'vertical';
  if (prompt.toLowerCase().includes('horizontal')) direction = 'horizontal';
  if (prompt.toLowerCase().includes('diagonal')) direction = 'diagonal';
  
  // Extract variables from {{variable}} patterns
  const variableMatches = prompt.match(/\{\{(\w+)\}\}/g) || [];
  const variables = variableMatches.map(match => ({
    name: match.replace(/[{}]/g, ''),
    default: '',
    type: 'text' as const,
  }));
  
  return {
    id,
    name: name || `${analysis.moods[0]} Template`,
    description: `Generated from: "${prompt.substring(0, 50)}..."`,
    variables: variables.length ? variables : [
      { name: 'title', default: 'HELLO', type: 'text' },
    ],
    layout: {
      alignment,
      padding: 2,
      spacing: 1,
    },
    style: {
      font: analysis.fonts[0] || 'Standard',
      direction,
    },
  };
}

// ============================================
// Preset Compiler
// ============================================

export function compilePreset(prompt: string, name?: string): CompiledPreset {
  const theme = compileTheme(prompt, name ? `${name} Theme` : undefined);
  const template = compileTemplate(prompt, name ? `${name} Template` : undefined);
  
  return {
    id: `preset-${Date.now()}`,
    name: name || `${theme.mood[0]} Preset`,
    description: `Complete preset generated from: "${prompt.substring(0, 50)}..."`,
    version: '1.0.0',
    theme,
    template,
    metadata: {
      author: 'Oh-My-Logo Pro',
      createdAt: new Date(),
      tags: [...theme.tags, ...theme.mood],
      license: 'MIT',
    },
  };
}

// ============================================
// Plugin Exporter
// ============================================

export function exportAsPlugin(preset: CompiledPreset): PluginDefinition {
  const pluginName = preset.name.toLowerCase().replace(/\s+/g, '-');
  
  return {
    name: `oml-plugin-${pluginName}`,
    version: preset.version,
    type: 'preset',
    description: preset.description,
    exports: preset,
    manifest: {
      main: 'index.js',
      dependencies: [],
      peerDependencies: ['oh-my-logo-pro'],
    },
    install: `
// ${preset.name} Plugin for Oh-My-Logo Pro
// Auto-generated plugin definition

const preset = ${JSON.stringify(preset, null, 2)};

module.exports = {
  name: '${preset.name}',
  version: '${preset.version}',
  type: 'preset',
  
  register(engine) {
    engine.registerTheme(preset.theme);
    engine.registerTemplate(preset.template);
    engine.registerPreset(preset);
  },
  
  unregister(engine) {
    engine.unregisterTheme(preset.theme.id);
    engine.unregisterTemplate(preset.template.id);
    engine.unregisterPreset(preset.id);
  },
  
  getPreset() {
    return preset;
  },
  
  getTheme() {
    return preset.theme;
  },
  
  getTemplate() {
    return preset.template;
  }
};
`,
  };
}

// ============================================
// Color Utilities
// ============================================

function lightenColor(hex: string, percent: number): string {
  const num = parseInt(hex.replace('#', ''), 16);
  const r = Math.min(255, (num >> 16) + Math.round(2.55 * percent));
  const g = Math.min(255, ((num >> 8) & 0x00ff) + Math.round(2.55 * percent));
  const b = Math.min(255, (num & 0x0000ff) + Math.round(2.55 * percent));
  return `#${((r << 16) | (g << 8) | b).toString(16).padStart(6, '0')}`;
}

function saturateColor(hex: string, percent: number): string {
  // Simple saturation boost
  const num = parseInt(hex.replace('#', ''), 16);
  const r = Math.min(255, Math.round((num >> 16) * (1 + percent / 100)));
  const g = Math.min(255, Math.round(((num >> 8) & 0x00ff) * (1 + percent / 100)));
  const b = Math.min(255, Math.round((num & 0x0000ff) * (1 + percent / 100)));
  return `#${((r << 16) | (g << 8) | b).toString(16).padStart(6, '0')}`;
}

// ============================================
// Main Compiler Class
// ============================================

export class PromptCompiler {
  private options: CompilerOptions;
  
  constructor(options: CompilerOptions = {}) {
    this.options = options;
  }
  
  compileTheme(prompt: string, name?: string): CompiledTheme {
    return compileTheme(prompt, name);
  }
  
  compileTemplate(prompt: string, name?: string): CompiledTemplate {
    return compileTemplate(prompt, name);
  }
  
  compilePreset(prompt: string, name?: string): CompiledPreset {
    return compilePreset(prompt, name);
  }
  
  exportPlugin(preset: CompiledPreset): PluginDefinition {
    return exportAsPlugin(preset);
  }
  
  analyzePrompt(prompt: string) {
    return analyzePrompt(prompt);
  }
}

export default {
  PromptCompiler,
  compileTheme,
  compileTemplate,
  compilePreset,
  exportAsPlugin,
  analyzePrompt,
};
