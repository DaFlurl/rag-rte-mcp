<div align="center">

```
   ____  _     __  __       _                          ____            
  / __ \| |__ |  \/  |_   _| |    ___   __ _  ___     |  _ \ _ __ ___  
 | |  | | '_ \| |\/| | | | | |   / _ \ / _` |/ _ \    | |_) | '__/ _ \ 
 | |__| | | | | |  | | |_| | |__| (_) | (_| | (_) |   |  __/| | | (_) |
  \____/|_| |_|_|  |_|\__, |_____\___/ \__, |\___/    |_|   |_|  \___/ 
                      |___/            |___/                           
```

# Oh-My-Logo Pro

### The AI-Powered Text-Based Design Studio

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.3-blue.svg)](https://www.typescriptlang.org/)
[![Node.js](https://img.shields.io/badge/Node.js-20+-green.svg)](https://nodejs.org/)
[![Electron](https://img.shields.io/badge/Electron-28+-blue.svg)](https://www.electronjs.org/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

**Not just an ASCII art generator — a professional design environment for terminal-native graphics.**

[Features](#-features) • [Installation](#-installation) • [Quick Start](#-quick-start) • [Documentation](#-documentation) • [Contributing](#-contributing)

</div>

---

## 🎯 What is Oh-My-Logo Pro?

Oh-My-Logo Pro is a **professional-grade ASCII art design studio** that combines the power of AI with enterprise-level features like:

- 🤖 **AI-Powered Design Assistant** — Claude, Ollama, and more
- ⏱️ **Fusion 360-style Timeline** — Unlimited undo/redo with branches
- 🎨 **50+ Fonts & Palettes** — From classic to cutting-edge
- 🚀 **Three Execution Modes** — GUI, CLI, and Headless
- 📦 **8 Export Formats** — PNG, SVG, HTML, GIF, PDF, MD, ANSI, JSON
- 🔐 **Deterministic Hashing** — CI/CD validation ready

---

## ✨ Features

### Core Features (~25)

| Feature | Description |
|---------|-------------|
| **Multi-Font Rendering** | 50+ FIGlet fonts with categories |
| **Color Palettes** | 50+ curated palettes with gradients |
| **Effects Engine** | Shadow, outline, glow, blur |
| **8 Export Formats** | PNG, SVG, HTML, GIF, PDF, MD, ANSI, JSON |
| **Unlimited Undo/Redo** | Full history with named snapshots |
| **Cross-Platform** | Windows, macOS, Linux |

### Pro Differentiators (~15)

| Feature | Description |
|---------|-------------|
| **AI Design Assistant** | Claude Opus 4.5, Ollama, OpenRouter |
| **Prompt Enhancer** | 3 levels (basic/detailed/extreme) |
| **Timeline System** | Git-like branches and time travel |
| **Animation Engine** | 12 transitions, GIF export |
| **Visual Diffing** | Character/color/style comparison |
| **Deterministic Hashes** | Same inputs = Same output |
| **Prompt → Preset Compiler** | Generate themes from descriptions |

### Platform Features (~10)

| Feature | Description |
|---------|-------------|
| **GUI Mode** | Electron + React visual editor |
| **CLI Mode** | Commander.js for scripting |
| **Headless Mode** | No UI deps, pure Node.js |
| **Plugin System** | Extensible architecture |
| **REST API** | HTTP endpoints for integration |
| **GitHub Actions** | CI/CD integration ready |

---

## 🚀 Installation

### Prerequisites

- **Node.js** 20+ 
- **npm** 10+ or **pnpm** 8+
- **Git**

### Quick Install

```bash
# Clone the repository
git clone https://github.com/yourname/oh-my-logo.git
cd oh-my-logo

# Install dependencies
npm install

# Start the GUI
npm run gui

# Or use the CLI
npm run cli -- generate "HELLO" --font=Banner
```

### Docker Install

```bash
# Pull the image
docker pull ohmylogo/pro:latest

# Run headless
docker run -v $(pwd)/output:/output ohmylogo/pro generate "HELLO"
```

---

## ⚡ Quick Start

### GUI Mode

```bash
npm run gui
```

Opens the visual editor with:
- Left Panel: Fonts, palettes, effects
- Center Canvas: Real-time preview
- Right Panel: AI chat, enhancer
- Timeline: History with branches
- Terminal: Embedded CLI

### CLI Mode

```bash
# Basic usage
oml generate "HELLO WORLD"

# With options
oml generate "LOGO" \
  --font=Banner \
  --theme=borg \
  --export=png,svg \
  --output=./exports/

# Interactive mode
oml interactive

# Batch processing
oml batch ./designs/*.json --output=./exports/
```

### Headless Mode (SDK)

```typescript
import { HeadlessEngine } from 'oh-my-logo/headless';

const engine = new HeadlessEngine();

// Generate ASCII
const result = await engine.generate({
  text: 'HELLO',
  font: 'Banner',
  theme: 'borg'
});

// Export to PNG
await engine.export(result, 'png', './output.png');

// With AI enhancement
const enhanced = await engine.enhance(
  'cyberpunk logo',
  'extreme'
);
```

---

## 🎨 Themes

12 built-in themes, or create your own:

| Theme | Colors | Style |
|-------|--------|-------|
| **Borg** 🟢 | Green on black | Matrix-style (default) |
| **Sunset** 🌅 | Orange, pink | Warm gradients |
| **Ocean** 🌊 | Blues, teals | Cool depth |
| **Fire** 🔥 | Reds, oranges | Hot flames |
| **Neon** 💡 | Bright colors | High contrast |
| **Retro** 🕹️ | Magenta, cyan | 80s synthwave |
| **Cyberpunk** 🌃 | Purple, pink | Night city |
| **Minimal** ⬜ | Grayscale | Clean |
| **Corporate** 💼 | Blues | Professional |
| **Hacker** 💻 | Pure green | Terminal |
| **Rainbow** 🌈 | Full spectrum | Pride |
| **Nature** 🌲 | Greens, browns | Organic |

---

## 📦 Export Formats

| Format | Type | Use Case |
|--------|------|----------|
| **PNG** | Raster | Social media, badges |
| **SVG** | Vector | Scalable graphics |
| **HTML** | Web | Embeddable |
| **GIF** | Animated | Animations |
| **PDF** | Print | Documentation |
| **Markdown** | Text | README files |
| **ANSI** | Terminal | CLI output |
| **JSON** | Data | API/automation |

---

## 🤖 AI Integration

Oh-My-Logo Pro supports multiple AI providers:

| Provider | Local | Cloud | Default Model |
|----------|-------|-------|---------------|
| **Claude** | ❌ | ✅ | claude-opus-4-5-20251101 |
| **Ollama** | ✅ | ❌ | llama3 |
| **LM Studio** | ✅ | ❌ | varies |
| **OpenRouter** | ❌ | ✅ | varies |
| **OpenAI** | ❌ | ✅ | gpt-4 |

### Configuration

```env
# .env
AI_PROVIDER=claude
ANTHROPIC_API_KEY=sk-ant-...

# Or for local
AI_PROVIDER=ollama
OLLAMA_BASE_URL=http://localhost:11434
OLLAMA_MODEL=llama3
```

---

## 📖 Documentation

| Document | Description |
|----------|-------------|
| [ARCHITECTURE.md](./docs/engineering/ARCHITECTURE.md) | Complete system architecture |
| [MASTER_ACTION_PLAN.md](./MASTER_ACTION_PLAN.md) | Development roadmap |
| [API Reference](./docs/api/) | API documentation |
| [User Guide](./docs/user-guide/) | How to use |

### Engineering Diagrams

All architecture diagrams are in `docs/engineering/diagrams/`:

- `00-master-architecture.svg` — Complete system overview
- `06-ai-integration.svg` — AI layer
- `07-timeline-system.svg` — Timeline/history
- `08-animation-engine.svg` — Animation
- `09-export-system.svg` — Export formats
- `10-theme-system.svg` — Themes
- `11-visual-diffing.svg` — Diffing
- `12-prompt-compiler.svg` — Prompt → Preset
- `13-headless-engine.svg` — Headless SDK
- `14-font-system.svg` — Fonts
- `15-palette-system.svg` — Palettes
- `16-data-flow.svg` — Data flow
- `17-gui-layout.svg` — GUI wireframe

---

## 🏗️ Project Structure

```
oh-my-logo/
├── packages/
│   ├── core/           # Shared engine (zero UI deps)
│   ├── ai/             # AI integration
│   ├── timeline/       # History management
│   ├── animation/      # Animation engine
│   ├── themes/         # Theme system
│   ├── export/         # Export engines
│   └── headless/       # Headless SDK
│
├── apps/
│   ├── gui/            # Electron GUI
│   └── cli/            # CLI application
│
├── docs/               # Documentation
│   └── engineering/    # Architecture docs
│       └── diagrams/   # SVG diagrams
│
└── examples/           # Example usage
```

---

## 🧪 Development

```bash
# Install dependencies
npm install

# Run in development
npm run dev

# Build all packages
npm run build

# Run tests
npm test

# Lint
npm run lint

# Type check
npm run typecheck
```

---

## 🤝 Contributing

We welcome contributions! See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

### Development Setup

1. Fork the repository
2. Clone your fork
3. Create a feature branch
4. Make your changes
5. Run tests
6. Submit a PR

---

## 📄 License

MIT License — see [LICENSE](./LICENSE) for details.

---

## 🙏 Acknowledgments

- [FIGlet](http://www.figlet.org/) for the font rendering engine
- [Anthropic](https://anthropic.com/) for Claude AI
- [Electron](https://www.electronjs.org/) for cross-platform GUI
- All our amazing contributors!

---

<div align="center">

**Made with 💚 by the Oh-My-Logo Pro team**

[⬆ Back to top](#oh-my-logo-pro)

</div>
