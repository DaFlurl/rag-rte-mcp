/**
 * Theme System
 * 12 built-in themes including Borg, with full customization support
 */

// ============================================
// Types
// ============================================

export interface ThemeColors {
  primary: string[];
  secondary: string[];
  accent: string[];
  background: string;
  foreground: string;
}

export interface ThemeFonts {
  heading: string;
  body: string;
  mono: string;
}

export interface ThemeEffects {
  shadow?: {
    enabled: boolean;
    color: string;
    offsetX: number;
    offsetY: number;
    blur: number;
  };
  outline?: {
    enabled: boolean;
    color: string;
    width: number;
  };
  glow?: {
    enabled: boolean;
    color: string;
    intensity: number;
    spread: number;
  };
}

export interface Theme {
  id: string;
  name: string;
  description: string;
  category: 'dark' | 'light' | 'neon' | 'retro' | 'minimal' | 'nature';
  colors: ThemeColors;
  fonts: ThemeFonts;
  effects: ThemeEffects;
  tags: string[];
}

// ============================================
// Built-in Themes (12)
// ============================================

export const THEMES: Record<string, Theme> = {
  // 1. BORG - Matrix Green (Your favorite!)
  borg: {
    id: 'borg',
    name: 'Borg',
    description: 'Matrix-style green on black, cyberpunk hacker aesthetic',
    category: 'dark',
    colors: {
      primary: ['#00ff00', '#00cc00', '#009900'],
      secondary: ['#33ff33', '#00ff66', '#00cc66'],
      accent: ['#66ff66', '#00ff99', '#00ffcc'],
      background: '#000000',
      foreground: '#00ff00',
    },
    fonts: {
      heading: 'ANSI Shadow',
      body: 'Standard',
      mono: 'Term',
    },
    effects: {
      shadow: { enabled: true, color: '#003300', offsetX: 2, offsetY: 2, blur: 0 },
      glow: { enabled: true, color: '#00ff0066', intensity: 0.5, spread: 3 },
    },
    tags: ['matrix', 'hacker', 'cyberpunk', 'green', 'terminal'],
  },

  // 2. Sunset - Warm gradients
  sunset: {
    id: 'sunset',
    name: 'Sunset',
    description: 'Warm oranges and pinks like a beautiful sunset',
    category: 'light',
    colors: {
      primary: ['#ff9966', '#ff5e62', '#ff3366'],
      secondary: ['#ffa34e', '#ff7e5f', '#feb47b'],
      accent: ['#ffcc00', '#ff9900', '#ff6600'],
      background: '#1a0a0a',
      foreground: '#ff9966',
    },
    fonts: {
      heading: 'Banner',
      body: 'Standard',
      mono: 'Small',
    },
    effects: {
      shadow: { enabled: true, color: '#330000', offsetX: 1, offsetY: 1, blur: 2 },
    },
    tags: ['warm', 'orange', 'pink', 'gradient'],
  },

  // 3. Ocean - Cool blues
  ocean: {
    id: 'ocean',
    name: 'Ocean',
    description: 'Deep ocean blues and teals for a calm aesthetic',
    category: 'dark',
    colors: {
      primary: ['#00b4db', '#0083b0', '#005f73'],
      secondary: ['#48cae4', '#00b4d8', '#0096c7'],
      accent: ['#90e0ef', '#caf0f8', '#ade8f4'],
      background: '#001219',
      foreground: '#48cae4',
    },
    fonts: {
      heading: 'Slant',
      body: 'Standard',
      mono: 'Small',
    },
    effects: {
      glow: { enabled: true, color: '#00b4db44', intensity: 0.3, spread: 5 },
    },
    tags: ['blue', 'teal', 'calm', 'water'],
  },

  // 4. Fire - Reds and oranges
  fire: {
    id: 'fire',
    name: 'Fire',
    description: 'Blazing reds and oranges for intense impact',
    category: 'dark',
    colors: {
      primary: ['#ff0000', '#ff4400', '#ff8800'],
      secondary: ['#cc0000', '#ff2200', '#ff6600'],
      accent: ['#ffaa00', '#ffcc00', '#ffee00'],
      background: '#0a0000',
      foreground: '#ff4400',
    },
    fonts: {
      heading: 'Doom',
      body: 'Standard',
      mono: 'Term',
    },
    effects: {
      glow: { enabled: true, color: '#ff440066', intensity: 0.6, spread: 4 },
      shadow: { enabled: true, color: '#440000', offsetX: 2, offsetY: 2, blur: 3 },
    },
    tags: ['red', 'orange', 'intense', 'hot'],
  },

  // 5. Neon - Bright cyans and magentas
  neon: {
    id: 'neon',
    name: 'Neon',
    description: 'Electric neon lights, cyberpunk city vibes',
    category: 'neon',
    colors: {
      primary: ['#00ffff', '#ff00ff', '#ffff00'],
      secondary: ['#00ccff', '#ff00cc', '#ccff00'],
      accent: ['#ff0099', '#9900ff', '#00ff99'],
      background: '#0a0014',
      foreground: '#ff00ff',
    },
    fonts: {
      heading: '3D-ASCII',
      body: 'Standard',
      mono: 'Small',
    },
    effects: {
      glow: { enabled: true, color: '#ff00ff88', intensity: 0.8, spread: 6 },
    },
    tags: ['cyberpunk', 'electric', 'bright', 'city'],
  },

  // 6. Retro - 80s synthwave
  retro: {
    id: 'retro',
    name: 'Retro',
    description: '80s synthwave aesthetics with purple and pink',
    category: 'retro',
    colors: {
      primary: ['#ff00ff', '#8b00ff', '#0088ff'],
      secondary: ['#ff0088', '#cc00ff', '#00ccff'],
      accent: ['#ff44aa', '#aa44ff', '#44aaff'],
      background: '#1a0a2e',
      foreground: '#ff00ff',
    },
    fonts: {
      heading: 'Larry 3D',
      body: 'Standard',
      mono: 'Small',
    },
    effects: {
      shadow: { enabled: true, color: '#330066', offsetX: 3, offsetY: 3, blur: 0 },
      outline: { enabled: true, color: '#00ffff', width: 1 },
    },
    tags: ['80s', 'synthwave', 'vaporwave', 'purple'],
  },

  // 7. Minimal - Grayscale clean
  minimal: {
    id: 'minimal',
    name: 'Minimal',
    description: 'Clean grayscale for professional simplicity',
    category: 'minimal',
    colors: {
      primary: ['#ffffff', '#cccccc', '#999999'],
      secondary: ['#dddddd', '#bbbbbb', '#888888'],
      accent: ['#666666', '#444444', '#222222'],
      background: '#000000',
      foreground: '#ffffff',
    },
    fonts: {
      heading: 'Standard',
      body: 'Standard',
      mono: 'Small',
    },
    effects: {},
    tags: ['clean', 'simple', 'professional', 'grayscale'],
  },

  // 8. Corporate - Professional subdued
  corporate: {
    id: 'corporate',
    name: 'Corporate',
    description: 'Professional and subdued for business use',
    category: 'minimal',
    colors: {
      primary: ['#1a73e8', '#174ea6', '#0d47a1'],
      secondary: ['#4285f4', '#2196f3', '#1976d2'],
      accent: ['#90caf9', '#64b5f6', '#42a5f5'],
      background: '#ffffff',
      foreground: '#1a73e8',
    },
    fonts: {
      heading: 'Banner',
      body: 'Standard',
      mono: 'Small',
    },
    effects: {
      shadow: { enabled: true, color: '#00000022', offsetX: 1, offsetY: 1, blur: 2 },
    },
    tags: ['business', 'professional', 'blue', 'clean'],
  },

  // 9. Hacker - Green on black terminal
  hacker: {
    id: 'hacker',
    name: 'Hacker',
    description: 'Classic terminal green, old-school hacker vibes',
    category: 'dark',
    colors: {
      primary: ['#33ff33', '#22cc22', '#119911'],
      secondary: ['#44ff44', '#33dd33', '#22bb22'],
      accent: ['#55ff55', '#44ee44', '#33cc33'],
      background: '#000000',
      foreground: '#33ff33',
    },
    fonts: {
      heading: 'Bloody',
      body: 'Standard',
      mono: 'Term',
    },
    effects: {
      glow: { enabled: true, color: '#33ff3333', intensity: 0.4, spread: 2 },
    },
    tags: ['terminal', 'classic', 'green', 'console'],
  },

  // 10. Rainbow - Full spectrum
  rainbow: {
    id: 'rainbow',
    name: 'Rainbow',
    description: 'Full spectrum rainbow for maximum impact',
    category: 'neon',
    colors: {
      primary: ['#ff0000', '#ff8800', '#ffff00', '#00ff00', '#0088ff', '#8800ff'],
      secondary: ['#ff4444', '#ffaa44', '#ffff44', '#44ff44', '#44aaff', '#aa44ff'],
      accent: ['#ff8888', '#ffcc88', '#ffff88', '#88ff88', '#88ccff', '#cc88ff'],
      background: '#000000',
      foreground: '#ffffff',
    },
    fonts: {
      heading: 'Banner',
      body: 'Standard',
      mono: 'Small',
    },
    effects: {},
    tags: ['colorful', 'spectrum', 'pride', 'vibrant'],
  },

  // 11. Cyberpunk - Purple and pink
  cyberpunk: {
    id: 'cyberpunk',
    name: 'Cyberpunk',
    description: 'Futuristic purple and pink neon city',
    category: 'neon',
    colors: {
      primary: ['#ff0066', '#cc00ff', '#6600ff'],
      secondary: ['#ff3399', '#dd33ff', '#9933ff'],
      accent: ['#ff66cc', '#ee66ff', '#cc66ff'],
      background: '#0a0014',
      foreground: '#ff0066',
    },
    fonts: {
      heading: 'Isometric1',
      body: 'Standard',
      mono: 'Term',
    },
    effects: {
      glow: { enabled: true, color: '#ff006688', intensity: 0.7, spread: 5 },
      outline: { enabled: true, color: '#00ffff', width: 1 },
    },
    tags: ['future', 'city', 'neon', 'purple'],
  },

  // 12. Nature - Greens and browns
  nature: {
    id: 'nature',
    name: 'Nature',
    description: 'Natural earth tones, forest and wood colors',
    category: 'nature',
    colors: {
      primary: ['#228b22', '#2e8b57', '#3cb371'],
      secondary: ['#8b4513', '#a0522d', '#cd853f'],
      accent: ['#90ee90', '#98fb98', '#00fa9a'],
      background: '#1a1a0a',
      foreground: '#228b22',
    },
    fonts: {
      heading: 'Roman',
      body: 'Standard',
      mono: 'Small',
    },
    effects: {
      shadow: { enabled: true, color: '#0a0a00', offsetX: 2, offsetY: 2, blur: 1 },
    },
    tags: ['earth', 'forest', 'organic', 'green'],
  },
};

// ============================================
// Theme Functions
// ============================================

export function getTheme(id: string): Theme | undefined {
  return THEMES[id];
}

export function listThemes(): Theme[] {
  return Object.values(THEMES);
}

export function listThemesByCategory(category: Theme['category']): Theme[] {
  return listThemes().filter(t => t.category === category);
}

export function searchThemes(query: string): Theme[] {
  const q = query.toLowerCase();
  return listThemes().filter(t =>
    t.name.toLowerCase().includes(q) ||
    t.description.toLowerCase().includes(q) ||
    t.tags.some(tag => tag.includes(q))
  );
}

export function getThemeColors(id: string): string[] {
  const theme = getTheme(id);
  return theme?.colors.primary || ['#ffffff'];
}

export function createCustomTheme(base: string, overrides: Partial<Theme>): Theme {
  const baseTheme = getTheme(base) || THEMES.minimal;
  return {
    ...baseTheme,
    ...overrides,
    id: overrides.id || `custom-${Date.now()}`,
    name: overrides.name || `Custom ${baseTheme.name}`,
    colors: { ...baseTheme.colors, ...overrides.colors },
    fonts: { ...baseTheme.fonts, ...overrides.fonts },
    effects: { ...baseTheme.effects, ...overrides.effects },
  };
}

export default {
  THEMES,
  getTheme,
  listThemes,
  listThemesByCategory,
  searchThemes,
  getThemeColors,
  createCustomTheme,
};
