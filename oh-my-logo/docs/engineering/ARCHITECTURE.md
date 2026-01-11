# Oh-My-Logo Pro - Complete Architecture Documentation

> **"The AI-Powered Text-Based Design Studio"**  
> Professional design environment for terminal-native graphics

---

## 📋 Table of Contents

1. [System Overview](#system-overview)
2. [Three Execution Modes](#three-execution-modes)
3. [Core Engine Architecture](#core-engine-architecture)
4. [AI Integration Layer](#ai-integration-layer)
5. [Timeline System](#timeline-system)
6. [Animation Engine](#animation-engine)
7. [Export System](#export-system)
8. [Theme System](#theme-system)
9. [Font System](#font-system)
10. [Palette System](#palette-system)
11. [Deterministic Hashing](#deterministic-hashing)
12. [Visual Diffing](#visual-diffing)
13. [Prompt Compiler](#prompt-compiler)
14. [Headless Engine](#headless-engine)
15. [GUI Components](#gui-components)
16. [Data Flow](#data-flow)
17. [Package Structure](#package-structure)
18. [Engineering Diagrams Index](#engineering-diagrams-index)

---

## System Overview

![Master Architecture](./diagrams/00-master-architecture.svg)

Oh-My-Logo Pro is architected as a **modular, layered system** with three distinct execution modes sharing a common core engine. This design enables:

- **Maximum Code Reuse**: Core engine is 100% shared across all modes
- **Zero UI Dependencies in Core**: Headless mode requires no Electron/React
- **Plugin Architecture**: Extensible at every layer
- **Enterprise-Grade Features**: Timeline, AI, deterministic hashing

### Strategic Positioning

```
┌─────────────────────────────────────────────────────────────────────┐
│                    OH-MY-LOGO PRO                                   │
│        "AI-Powered Text-Based Design Studio"                        │
├─────────────────────────────────────────────────────────────────────┤
│  NOT just an ASCII art generator                                    │
│  A PROFESSIONAL design environment for terminal-native graphics     │
│                                                                     │
│  • Designers use GUI mode                                           │
│  • Developers use CLI mode                                          │
│  • Automation uses Headless mode                                    │
└─────────────────────────────────────────────────────────────────────┘
```

### Feature Scope

| Category | Count | Examples |
|----------|-------|----------|
| **Core Features** | ~25 | Multi-font, palettes, effects, exports, undo/redo |
| **Pro Differentiators** | ~15 | AI assistant, timeline, animation, visual diffing |
| **Platform/Ecosystem** | ~10 | 3 modes, plugins, GitHub Actions, REST API |

---

## Three Execution Modes

The system supports three distinct execution modes, all sharing the same core engine:

```
                     ┌─────────────────────────────────────┐
                     │        SHARED CORE ENGINE           │
                     │                                     │
                     │  Renderer │ Timeline │ AI Layer    │
                     │  Export   │ Themes   │ Animation   │
                     │  Hashing  │ Diffing  │ Palettes    │
                     └───────────────┬─────────────────────┘
                                     │
           ┌─────────────────────────┼─────────────────────────┐
           │                         │                         │
           ▼                         ▼                         ▼
    ┌─────────────┐          ┌─────────────┐          ┌─────────────┐
    │  GUI MODE   │          │  CLI MODE   │          │  HEADLESS   │
    │             │          │             │          │             │
    │ • Electron  │          │ • Commander │          │ • Pure Node │
    │ • React     │          │ • Inquirer  │          │ • No UI     │
    │ • Visual    │          │ • Scripts   │          │ • SDK/API   │
    └─────────────┘          └─────────────┘          └─────────────┘
```

### Mode Comparison

| Feature | GUI | CLI | Headless |
|---------|-----|-----|----------|
| UI Framework | Electron + React | Terminal | None |
| Interactive | ✅ Visual editor | ✅ Prompts | ❌ Config-driven |
| Real-time Preview | ✅ | ❌ | ❌ |
| Batch Processing | ✅ | ✅ | ✅ |
| CI/CD Integration | ❌ | ✅ | ✅ |
| Docker-friendly | ❌ | ✅ | ✅ |
| Memory Footprint | High | Medium | Low |

---

## Core Engine Architecture

The core engine (`packages/core/*`) contains all shared logic with zero UI dependencies.

```
packages/core/
├── renderer/           # FIGlet rendering engine
│   ├── index.ts        # Main render function
│   ├── fonts.ts        # Font loading & management
│   ├── colors.ts       # Color application
│   └── effects.ts      # Shadow, outline, glow
│
├── hashing/            # Deterministic hashing
│   ├── index.ts        # Hash generation
│   ├── content.ts      # Content fingerprinting
│   ├── style.ts        # Style fingerprinting
│   └── cache.ts        # Hash-based caching
│
├── diffing/            # Visual comparison
│   ├── index.ts        # Diff engine
│   ├── characters.ts   # Character-level diff
│   ├── colors.ts       # Color diff
│   └── report.ts       # Diff report generation
│
└── types/              # Shared TypeScript types
    ├── design.ts       # Design state types
    ├── render.ts       # Render types
    └── config.ts       # Configuration types
```

### Core Interfaces

```typescript
// Design state (the central data model)
interface DesignState {
  id: string;
  text: string;
  font: FontConfig;
  palette: PaletteConfig;
  effects: EffectsConfig;
  layout: LayoutConfig;
  metadata: DesignMetadata;
}

// Render result
interface RenderResult {
  ascii: string[][];           // 2D character array
  colors: string[][];          // Color per character
  hash: RenderHash;            // Deterministic hash
  dimensions: { width: number; height: number };
}

// Configuration
interface OMLConfig {
  ai: AIConfig;
  export: ExportConfig;
  themes: ThemeConfig;
  fonts: FontConfig;
  palettes: PaletteConfig;
}
```

---

## AI Integration Layer

![AI Integration](./diagrams/06-ai-integration.svg)

The AI layer provides intelligent design assistance through multiple providers.

### Multi-Provider Architecture

```typescript
// Provider factory pattern
const aiProvider = createAIProvider({
  provider: 'claude',  // or 'ollama', 'openrouter', 'lmstudio', 'openai'
  model: 'claude-opus-4-5-20251101',
  apiKey: process.env.ANTHROPIC_API_KEY
});

// Unified interface
interface AIProvider {
  generate(prompt: string, options?: GenerateOptions): Promise<AIResponse>;
  enhance(prompt: string, level: 'basic' | 'detailed' | 'extreme'): Promise<string>;
  suggest(context: DesignContext): Promise<Suggestion[]>;
  compile(prompt: string): Promise<CompiledPreset>;
}
```

### AI Operations

| Operation | Description | Use Case |
|-----------|-------------|----------|
| **Generate** | Create design from description | "Make a cyberpunk logo" |
| **Enhance** | Improve user prompts | Basic → Detailed prompt |
| **Suggest** | Recommend improvements | "Try this font/color" |
| **Compile** | Prompt → Preset | Generate reusable presets |

### Prompt Enhancer Levels

```typescript
// Basic: Add missing details
"logo" → "ASCII art logo with bold font"

// Detailed: Add style preferences
"logo" → "ASCII art logo with bold Banner font, green neon colors, 
         subtle glow effect, centered layout"

// Extreme: Full design specification
"logo" → "Professional ASCII art logo using Banner font at 14pt scale,
         Matrix green (#00FF00) to cyan (#00FFFF) horizontal gradient,
         2px shadow offset, 3px glow radius, dark background,
         optimized for terminal display at 80 columns"
```

---

## Timeline System

![Timeline System](./diagrams/07-timeline-system.svg)

The timeline system provides unlimited undo/redo with Git-like branching.

### Timeline Structure

```typescript
interface Timeline {
  // Current state
  current: TimelineSnapshot;
  currentBranch: string;
  
  // History
  snapshots: Map<string, TimelineSnapshot>;
  branches: Map<string, Branch>;
  
  // Operations
  undo(): TimelineSnapshot | null;
  redo(): TimelineSnapshot | null;
  snapshot(name?: string): string;
  branch(name: string): void;
  merge(source: string, target: string): void;
  jump(snapshotId: string): void;
}

interface TimelineSnapshot {
  id: string;
  hash: string;              // Deterministic content hash
  state: DesignState;
  action: string;            // What action created this
  timestamp: number;
  parentId: string | null;
  branch: string;
}
```

### Branch Operations

```
main ─────●─────●─────●─────●─────●─────●
                      │                 ↑
                      └───●───●───●─────┘  (merge)
                          experiment
```

### Key Features

- **Unlimited History**: No limit on undo levels
- **Named Snapshots**: Create checkpoints like Git commits
- **Branching**: Experiment without losing main work
- **Time Travel**: Jump to any point in history
- **Persistence**: Export/import timeline as JSON
- **Fusion 360-style UI**: Visual timeline slider with thumbnails

---

## Animation Engine

![Animation Engine](./diagrams/08-animation-engine.svg)

The animation engine creates frame-based animations with various transition effects.

### Animation Configuration

```typescript
interface AnimationConfig {
  transition: TransitionType;
  duration: number;          // milliseconds
  frameRate: number;         // frames per second
  easing: EasingFunction;
  loop: boolean | number;    // true = infinite, number = count
}

type TransitionType = 
  | 'typewriter'    // Characters appear one by one
  | 'fade'          // Opacity fade in/out
  | 'slide-left'    // Slide from left
  | 'slide-right'   // Slide from right
  | 'slide-up'      // Slide from top
  | 'slide-down'    // Slide from bottom
  | 'glitch'        // Random character glitching
  | 'wave'          // Wave distortion
  | 'rainbow'       // Color cycling
  | 'matrix'        // Matrix rain effect
  | 'pulse'         // Breathing/pulse effect
  | 'dissolve';     // Random pixel dissolve

type EasingFunction = 
  | 'linear'
  | 'ease-in'
  | 'ease-out'
  | 'ease-in-out'
  | 'bounce';
```

### Animation Player

```typescript
const player = new AnimationPlayer(animation);

player.play();
player.pause();
player.stop();
player.seek(0.5);  // 50% through animation

player.on('frame', (frame: AnimationFrame) => {
  render(frame);
});

player.on('complete', () => {
  console.log('Animation finished');
});
```

### Export Options

| Format | Description |
|--------|-------------|
| GIF | Animated GIF with configurable quality |
| Frame Sequence | PNG sequence for video editing |
| ANSI | Terminal escape codes for CLI playback |
| MP4 | Video format (requires ffmpeg) |

---

## Export System

![Export System](./diagrams/09-export-system.svg)

The export system supports 8 formats with format-specific options.

### Supported Formats

| Format | Type | Options |
|--------|------|---------|
| **PNG** | Raster | width, height, DPI, transparent, compression |
| **SVG** | Vector | viewBox, embedFonts, responsive, optimize |
| **HTML** | Web | inlineStyles, darkMode, responsive, standalone |
| **GIF** | Animated | frameDelay, loop, quality, dither |
| **PDF** | Print | pageSize, orientation, margins, embedFonts |
| **Markdown** | Text | codeBlock, language, github, comments |
| **ANSI** | Terminal | colorMode, trueColor, background, reset |
| **JSON** | Data | pretty, includeHash, includeAscii, schema |

### Export API

```typescript
// Single export
const result = await exportDesign(design, {
  type: 'png',
  width: 1200,
  height: 400,
  dpi: 300,
  transparent: true
});

// Batch export
const results = await batchExport(design, 
  ['png', 'svg', 'html'],
  { outputDir: './exports' }
);

// Export result
interface ExportResult {
  success: boolean;
  data: Buffer | string;
  format: ExportFormat;
  metadata: {
    hash: string;
    size: number;
    dimensions?: { width: number; height: number };
    timestamp: number;
  };
  error?: string;
}
```

---

## Theme System

![Theme System](./diagrams/10-theme-system.svg)

The theme system provides 12 built-in themes with custom creation support.

### Built-in Themes

| Theme | Category | Colors | Description |
|-------|----------|--------|-------------|
| **Borg** | dark | Green on black | Matrix-style, default |
| **Sunset** | warm | Orange, pink, yellow | Warm gradient |
| **Ocean** | cool | Blues, teals | Cool depth effect |
| **Fire** | warm | Reds, oranges | Hot flames |
| **Neon** | neon | Bright colors | High contrast glow |
| **Retro** | retro | Magenta, cyan | 80s synthwave |
| **Minimal** | minimal | Grayscale | Clean, simple |
| **Corporate** | minimal | Blues, grays | Professional |
| **Hacker** | dark | Pure green | Terminal aesthetic |
| **Rainbow** | rainbow | Full spectrum | Pride colors |
| **Cyberpunk** | neon | Purple, pink, cyan | Night city |
| **Nature** | nature | Greens, browns | Organic feel |

### Theme Structure

```typescript
interface Theme {
  id: string;
  name: string;
  category: ThemeCategory;
  
  colors: {
    primary: string[];      // Main colors
    secondary: string[];    // Supporting colors
    accent: string[];       // Highlight colors
    background: string;     // Background color
  };
  
  fonts: {
    heading: string;        // Suggested heading font
    body: string;           // Suggested body font
  };
  
  effects: {
    shadow?: ShadowConfig;
    outline?: OutlineConfig;
    glow?: GlowConfig;
  };
}

// Category types
type ThemeCategory = 
  | 'dark' 
  | 'light' 
  | 'neon' 
  | 'retro' 
  | 'minimal' 
  | 'nature';
```

### Theme Operations

```typescript
// Get theme
const theme = getTheme('borg');

// List by category
const darkThemes = listThemes('dark');

// Create custom
const custom = createCustomTheme(baseTheme, {
  colors: { primary: ['#ff0000'] }
});

// Search
const results = searchThemes('cyber');

// Export/Import
const json = exportTheme(theme);
const imported = importTheme(jsonString);
```

---

## Font System

![Font System](./diagrams/14-font-system.svg)

The font system manages 50+ FIGlet fonts with categories and favorites.

### Font Categories

| Category | Count | Examples |
|----------|-------|----------|
| **Sans Serif** | 12 | Standard, Big, Small, Mini |
| **Serif** | 10 | Roman, Gothic, Georgia |
| **Display** | 14 | Banner, Slant, Shadow, Speed |
| **3D** | 8 | 3D-ASCII, Isometric, Perspective |
| **Block** | 10 | Block, Colossal, Epic, Chunky |
| **Effect** | 12 | Neon, Doom, Weird, Bubble |

### Font Registry

```typescript
interface Font {
  id: string;
  name: string;
  category: FontCategory;
  description: string;
  preview: string;           // Sample ASCII preview
  charWidth: number;
  charHeight: number;
  tags: string[];
  isFavorite: boolean;
  usageCount: number;
}

// Operations
getFont(id: string): Font;
listFonts(category?: FontCategory): Font[];
searchFonts(query: string): Font[];
renderText(text: string, font: Font): string[][];
previewFont(font: Font): string;
toggleFavorite(id: string): void;
getFavorites(): Font[];
getRecent(): Font[];
getPopular(): Font[];
```

---

## Palette System

![Palette System](./diagrams/15-palette-system.svg)

The palette system provides 50+ color schemes with gradient support.

### Palette Categories

| Category | Count | Description |
|----------|-------|-------------|
| **Warm** | 8 | Reds, oranges, yellows |
| **Cool** | 8 | Blues, teals, cyans |
| **Neon** | 6 | Bright, vibrant colors |
| **Retro** | 6 | 80s/90s aesthetic |
| **Mono** | 6 | Grayscale |
| **Nature** | 6 | Greens, browns |
| **Cosmic** | 5 | Deep purples, space |
| **Rainbow** | 5 | Full spectrum |

### Gradient Directions

```typescript
type GradientDirection = 
  | 'horizontal'     // Left to right
  | 'vertical'       // Top to bottom
  | 'diagonal-down'  // Top-left to bottom-right
  | 'diagonal-up'    // Bottom-left to top-right
  | 'radial'         // Center outward
  | 'per-char'       // Each character different
  | 'per-line'       // Each row different
  | 'random';        // Scattered colors
```

### Palette Structure

```typescript
interface Palette {
  id: string;
  name: string;
  category: PaletteCategory;
  colors: string[];           // Hex color codes
  direction: GradientDirection;
  isFavorite: boolean;
}
```

---

## Deterministic Hashing

The hashing system ensures reproducible renders and enables caching.

### Hash Types

```typescript
interface RenderHash {
  // Individual fingerprints
  contentHash: string;    // SHA256 of input text
  styleHash: string;      // SHA256 of colors + effects
  fontHash: string;       // SHA256 of font config
  
  // Combined hash
  renderHash: string;     // SHA256(content + style + font)
  
  // Metadata
  version: string;        // Engine version
  timestamp: number;      // Generation time
}
```

### Benefits

| Benefit | Description |
|---------|-------------|
| **CI/CD Validation** | Verify renders haven't changed |
| **Caching** | Skip re-renders for identical inputs |
| **Diffing** | Detect what changed between versions |
| **Reproducibility** | Recreate exact outputs anywhere |

### Usage

```typescript
// Generate hash
const hash = generateRenderHash(design);

// Compare hashes
const isEqual = compareHashes(hashA, hashB);

// Verify render
const isValid = verifyRender(output, expectedHash);

// Cache lookup
const cached = cache.get(renderHash);
if (cached) return cached;
```

---

## Visual Diffing

![Visual Diffing](./diagrams/11-visual-diffing.svg)

The diffing system compares designs at multiple levels.

### Diff Types

```typescript
interface VisualDiff {
  // Character-level changes
  characters: CharacterDiff[];
  
  // Color changes
  colors: ColorDiff[];
  
  // Style changes
  styles: StyleDiff[];
  
  // Summary
  summary: DiffSummary;
}

interface CharacterDiff {
  position: [row: number, col: number];
  oldChar: string;
  newChar: string;
  type: 'added' | 'removed' | 'changed';
}

interface DiffSummary {
  charactersChanged: number;
  colorsChanged: number;
  stylesChanged: number;
  similarity: number;  // 0-100%
}
```

### Diff Operations

```typescript
// Compare two states
const diff = diffDesigns(stateA, stateB);

// Generate report
const report = generateDiffReport(diff, 'markdown');

// Check equality
const isEqual = areFramesEqual(frameA, frameB);

// Compare timeline states
const timelineDiff = diffTimelineStates(snapshotA, snapshotB);
```

---

## Prompt Compiler

![Prompt Compiler](./diagrams/12-prompt-compiler.svg)

The prompt compiler transforms natural language into design presets.

### Compilation Pipeline

```
User Prompt → AI Analysis → Theme Compiler → Template Compiler → Preset Compiler → Plugin Export
```

### Output Types

```typescript
// Theme output
interface CompiledTheme {
  name: string;
  colors: {
    primary: string[];
    secondary: string[];
    accent: string[];
  };
  fonts: {
    heading: string;
    body: string;
  };
  effects: EffectOptions;
}

// Template output
interface CompiledTemplate {
  name: string;
  variables: TemplateVariable[];
  layout: LayoutConfig;
  style: StyleConfig;
}

// Preset output (full bundle)
interface CompiledPreset {
  id: string;
  name: string;
  description: string;
  theme: CompiledTheme;
  template: CompiledTemplate;
  metadata: PresetMetadata;
}

// Plugin export
interface PluginDefinition {
  name: string;
  version: string;
  type: 'theme' | 'template' | 'effect' | 'font';
  exports: CompiledPreset;
  install(): void;
  uninstall(): void;
}
```

### Example

```typescript
// Input
const prompt = "Create a cyberpunk neon logo with glowing purple and cyan";

// Output
const preset = await compilePrompt(prompt);
// {
//   name: "Cyberpunk Neon",
//   theme: {
//     colors: {
//       primary: ["#ff00ff"],
//       secondary: ["#00ffff"],
//       accent: ["#ffcc00"]
//     },
//     effects: { glow: true, glowColor: "#ff00ff", glowRadius: 8 }
//   },
//   template: {
//     layout: "centered",
//     font: "Neon"
//   }
// }
```

---

## Headless Engine

![Headless Engine](./diagrams/13-headless-engine.svg)

The headless engine provides full capabilities without UI dependencies.

### Key Properties

- **No Electron**: Pure Node.js
- **No React**: No UI framework
- **No Browser APIs**: Server-compatible
- **Minimal Dependencies**: Fast installation
- **Full Feature Parity**: Everything except visual editing

### Usage

```typescript
// SDK usage
import { HeadlessEngine } from 'oh-my-logo/headless';

const engine = new HeadlessEngine();

const result = await engine.generate({
  text: 'HELLO',
  font: 'Banner',
  theme: 'borg'
});

await engine.export(result, 'png', './output.png');
```

### Config-Driven Execution

```json
// headless.config.json
{
  "input": "./designs/*.json",
  "output": "./exports/",
  "formats": ["png", "svg", "html"],
  "theme": "borg",
  "batch": {
    "parallel": 4,
    "continueOnError": true
  },
  "ai": {
    "provider": "ollama",
    "model": "llama3"
  }
}
```

### Use Cases

| Use Case | Description |
|----------|-------------|
| CI/CD | Automated badge/logo generation |
| GitHub Actions | Generate READMEs on commit |
| Docker | Containerized processing |
| REST API | Serve generation via HTTP |
| NPM Package | Integrate in other projects |

---

## GUI Components

### Layout Structure

```
┌─────────────────────────────────────────────────────────────────────┐
│                           HEADER                                     │
│  [File] [Edit] [View] [Tools] [Help]            [Theme] [Settings]  │
├────────────┬────────────────────────────────────┬───────────────────┤
│            │                                    │                   │
│   LEFT     │         CENTER CANVAS              │      RIGHT        │
│   PANEL    │                                    │      PANEL        │
│            │      ┌──────────────────┐          │                   │
│ • Projects │      │                  │          │  • AI Chat        │
│ • Fonts    │      │   ASCII PREVIEW  │          │  • Enhancer       │
│ • Palettes │      │                  │          │  • Memory         │
│ • Effects  │      │  [Real-time]     │          │                   │
│            │      └──────────────────┘          │                   │
│            │                                    │                   │
├────────────┴─────────┬──────────────────────────┴───────────────────┤
│      TIMELINE        │              TERMINAL                        │
│  ◀ ⏮ ⏯ ⏭ ▶         │  > oml generate "HELLO"                      │
│  [──────●──────────] │  > ✓ Generated in 45ms                       │
└──────────────────────┴──────────────────────────────────────────────┘
```

### Component Hierarchy

```
App
├── Header
│   ├── MenuBar
│   ├── ThemeToggle
│   └── SettingsButton
│
├── MainContent
│   ├── LeftPanel
│   │   ├── TabBar (Projects|Fonts|Palettes|Effects)
│   │   ├── ProjectBrowser
│   │   ├── FontLibrary
│   │   ├── PalettePicker
│   │   └── EffectControls
│   │
│   ├── CenterCanvas
│   │   ├── Toolbar
│   │   ├── PreviewArea
│   │   └── StatusBar
│   │
│   └── RightPanel
│       ├── TabBar (Chat|Enhancer|Memory)
│       ├── AIChat
│       ├── PromptEnhancer
│       └── MemoryPanel
│
├── TimelineBar
│   ├── Controls (undo/redo/play)
│   ├── TimelineSlider
│   └── BranchSelector
│
└── Terminal
    ├── TerminalHeader
    ├── TerminalOutput
    └── TerminalInput
```

---

## Data Flow

```
                    ┌─────────────────────┐
                    │     User Input      │
                    │  (GUI/CLI/Config)   │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │    Design State     │
                    │  (Central Model)    │
                    └──────────┬──────────┘
                               │
          ┌────────────────────┼────────────────────┐
          │                    │                    │
          ▼                    ▼                    ▼
   ┌─────────────┐     ┌─────────────┐     ┌─────────────┐
   │  Timeline   │     │   Renderer  │     │  AI Layer   │
   │  (History)  │     │  (Output)   │     │  (Assist)   │
   └─────────────┘     └─────────────┘     └─────────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │   Render Result     │
                    │  (ASCII + Colors)   │
                    └──────────┬──────────┘
                               │
          ┌────────────────────┼────────────────────┐
          │                    │                    │
          ▼                    ▼                    ▼
   ┌─────────────┐     ┌─────────────┐     ┌─────────────┐
   │   Export    │     │   Preview   │     │   Hashing   │
   │  (Files)    │     │   (Display) │     │   (Cache)   │
   └─────────────┘     └─────────────┘     └─────────────┘
```

---

## Package Structure

```
oh-my-logo/
├── packages/
│   ├── core/                 # Shared core engine (zero UI deps)
│   │   ├── renderer/         # FIGlet rendering
│   │   ├── fonts/            # Font management
│   │   ├── palettes/         # Color palettes
│   │   ├── effects/          # Effect system
│   │   ├── hashing/          # Deterministic hashes
│   │   ├── diffing/          # Visual diffing
│   │   └── types/            # Shared types
│   │
│   ├── ai/                   # AI integration
│   │   ├── providers/        # Multi-provider support
│   │   ├── enhancer/         # Prompt enhancement
│   │   ├── compiler/         # Prompt → Preset
│   │   └── memory/           # Project memory
│   │
│   ├── timeline/             # History management
│   │   ├── snapshots/        # Snapshot storage
│   │   ├── branches/         # Branch management
│   │   └── operations/       # Undo/redo/merge
│   │
│   ├── animation/            # Animation engine
│   │   ├── transitions/      # Transition effects
│   │   ├── player/           # Animation playback
│   │   └── export/           # GIF/video export
│   │
│   ├── themes/               # Theme system
│   │   ├── builtin/          # 12 built-in themes
│   │   └── creator/          # Custom theme tools
│   │
│   ├── export/               # Export engines
│   │   ├── image/            # PNG, SVG, GIF
│   │   ├── document/         # PDF, HTML, Markdown
│   │   └── data/             # JSON, ANSI
│   │
│   ├── headless/             # Headless SDK
│   │   ├── engine/           # Core engine wrapper
│   │   ├── api/              # REST API server
│   │   └── sdk/              # JavaScript SDK
│   │
│   └── plugins/              # Plugin system
│       ├── loader/           # Plugin loader
│       ├── api/              # Plugin API
│       └── registry/         # Plugin registry
│
├── apps/
│   ├── gui/                  # Electron GUI
│   │   ├── src/
│   │   │   ├── components/   # React components
│   │   │   ├── stores/       # State management
│   │   │   ├── hooks/        # Custom hooks
│   │   │   └── styles/       # CSS/styling
│   │   └── electron/         # Electron main process
│   │
│   └── cli/                  # CLI application
│       ├── commands/         # CLI commands
│       ├── interactive/      # Interactive mode
│       └── batch/            # Batch processing
│
├── config/                   # Configuration
│   ├── .env.example          # Environment template
│   └── default.json          # Default config
│
├── docs/                     # Documentation
│   ├── engineering/          # Technical docs
│   │   └── diagrams/         # SVG diagrams
│   ├── user-guide/           # User documentation
│   └── api/                  # API reference
│
└── examples/                 # Example usage
    ├── basic/                # Basic examples
    ├── advanced/             # Advanced examples
    └── plugins/              # Plugin examples
```

---

## Engineering Diagrams Index

All architectural diagrams are located in `docs/engineering/diagrams/`:

| # | Diagram | Description |
|---|---------|-------------|
| 00 | [master-architecture.svg](./diagrams/00-master-architecture.svg) | Complete system overview |
| 06 | [ai-integration.svg](./diagrams/06-ai-integration.svg) | AI layer architecture |
| 07 | [timeline-system.svg](./diagrams/07-timeline-system.svg) | Timeline/history system |
| 08 | [animation-engine.svg](./diagrams/08-animation-engine.svg) | Animation engine |
| 09 | [export-system.svg](./diagrams/09-export-system.svg) | Export system |
| 10 | [theme-system.svg](./diagrams/10-theme-system.svg) | Theme system |
| 11 | [visual-diffing.svg](./diagrams/11-visual-diffing.svg) | Visual diffing |
| 12 | [prompt-compiler.svg](./diagrams/12-prompt-compiler.svg) | Prompt compiler |
| 13 | [headless-engine.svg](./diagrams/13-headless-engine.svg) | Headless engine |
| 14 | [font-system.svg](./diagrams/14-font-system.svg) | Font system |
| 15 | [palette-system.svg](./diagrams/15-palette-system.svg) | Palette system |

---

## Success Metrics

| Metric | Target |
|--------|--------|
| GitHub Stars | 5,000+ |
| NPM Downloads | 10,000+/month |
| Test Coverage | 85%+ |
| Documentation | Complete |
| Fonts | 50+ |
| Palettes | 50+ |
| Themes | 12+ |
| Export Formats | 8 |
| AI Providers | 5+ |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-01 | Initial architecture |

---

*© 2026 Oh-My-Logo Pro - AI-Powered Text-Based Design Studio*
