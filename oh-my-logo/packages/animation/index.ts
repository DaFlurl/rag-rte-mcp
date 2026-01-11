/**
 * Animation Engine
 * Frame sequences, transitions, and timeline-based animation
 */

// ============================================
// Types
// ============================================

export type TransitionType = 
  | 'typewriter'
  | 'fade'
  | 'slide-left'
  | 'slide-right'
  | 'slide-up'
  | 'slide-down'
  | 'glitch'
  | 'wave'
  | 'rainbow'
  | 'matrix'
  | 'pulse'
  | 'dissolve';

export type EasingFunction = 
  | 'linear'
  | 'ease-in'
  | 'ease-out'
  | 'ease-in-out'
  | 'bounce';

export interface AnimationFrame {
  id: string;
  content: string;
  colors: string[][];
  timestamp: number;
  duration: number;
}

export interface AnimationConfig {
  transition: TransitionType;
  duration: number;       // Total duration in ms
  frameRate: number;      // Frames per second
  loop: boolean | number; // true = infinite, number = repeat count
  easing: EasingFunction;
  delay?: number;         // Initial delay
  reverse?: boolean;      // Play in reverse
}

export interface Animation {
  id: string;
  name: string;
  frames: AnimationFrame[];
  config: AnimationConfig;
  metadata: {
    createdAt: Date;
    totalDuration: number;
    frameCount: number;
  };
}

// ============================================
// Easing Functions
// ============================================

const easings: Record<EasingFunction, (t: number) => number> = {
  'linear': t => t,
  'ease-in': t => t * t,
  'ease-out': t => t * (2 - t),
  'ease-in-out': t => t < 0.5 ? 2 * t * t : -1 + (4 - 2 * t) * t,
  'bounce': t => {
    if (t < 1/2.75) return 7.5625 * t * t;
    if (t < 2/2.75) return 7.5625 * (t -= 1.5/2.75) * t + 0.75;
    if (t < 2.5/2.75) return 7.5625 * (t -= 2.25/2.75) * t + 0.9375;
    return 7.5625 * (t -= 2.625/2.75) * t + 0.984375;
  },
};

// ============================================
// Transition Generators
// ============================================

/**
 * Typewriter effect - reveal characters one by one
 */
export function generateTypewriter(
  text: string,
  colors: string[][],
  config: AnimationConfig
): AnimationFrame[] {
  const lines = text.split('\n');
  const totalChars = lines.reduce((sum, l) => sum + l.length, 0);
  const frameCount = Math.min(totalChars, config.duration / (1000 / config.frameRate));
  const charsPerFrame = Math.ceil(totalChars / frameCount);
  
  const frames: AnimationFrame[] = [];
  let revealed = 0;
  
  for (let f = 0; f < frameCount; f++) {
    revealed = Math.min(totalChars, revealed + charsPerFrame);
    
    let charCount = 0;
    const frameLines: string[] = [];
    const frameColors: string[][] = [];
    
    for (let row = 0; row < lines.length; row++) {
      let line = '';
      const lineColors: string[] = [];
      
      for (let col = 0; col < lines[row].length; col++) {
        if (charCount < revealed) {
          line += lines[row][col];
          lineColors.push(colors[row]?.[col] || '#fff');
        } else {
          line += ' ';
          lineColors.push('transparent');
        }
        charCount++;
      }
      
      frameLines.push(line);
      frameColors.push(lineColors);
    }
    
    frames.push({
      id: `frame-${f}`,
      content: frameLines.join('\n'),
      colors: frameColors,
      timestamp: f * (config.duration / frameCount),
      duration: config.duration / frameCount,
    });
  }
  
  return frames;
}

/**
 * Fade effect - gradual opacity change
 */
export function generateFade(
  text: string,
  colors: string[][],
  config: AnimationConfig
): AnimationFrame[] {
  const frameCount = Math.floor(config.duration / (1000 / config.frameRate));
  const frames: AnimationFrame[] = [];
  const easing = easings[config.easing];
  
  for (let f = 0; f < frameCount; f++) {
    const progress = easing(f / (frameCount - 1));
    const opacity = Math.floor(progress * 255).toString(16).padStart(2, '0');
    
    const frameColors = colors.map(row =>
      row.map(color => `${color}${opacity}`)
    );
    
    frames.push({
      id: `frame-${f}`,
      content: text,
      colors: frameColors,
      timestamp: f * (config.duration / frameCount),
      duration: config.duration / frameCount,
    });
  }
  
  return frames;
}

/**
 * Slide effect - move content in from direction
 */
export function generateSlide(
  text: string,
  colors: string[][],
  config: AnimationConfig,
  direction: 'left' | 'right' | 'up' | 'down'
): AnimationFrame[] {
  const lines = text.split('\n');
  const frameCount = Math.floor(config.duration / (1000 / config.frameRate));
  const frames: AnimationFrame[] = [];
  const easing = easings[config.easing];
  const maxWidth = Math.max(...lines.map(l => l.length));
  
  for (let f = 0; f < frameCount; f++) {
    const progress = easing(f / (frameCount - 1));
    const frameLines: string[] = [];
    const frameColors: string[][] = [];
    
    for (let row = 0; row < lines.length; row++) {
      let line = lines[row];
      let lineColors = colors[row] || [];
      
      if (direction === 'left' || direction === 'right') {
        const offset = Math.floor((1 - progress) * maxWidth);
        const padding = ' '.repeat(offset);
        
        if (direction === 'left') {
          line = padding + line;
          lineColors = [...Array(offset).fill('transparent'), ...lineColors];
        } else {
          line = line + padding;
          lineColors = [...lineColors, ...Array(offset).fill('transparent')];
        }
      }
      
      frameLines.push(line);
      frameColors.push(lineColors);
    }
    
    // Handle vertical slides
    if (direction === 'up' || direction === 'down') {
      const rowOffset = Math.floor((1 - progress) * lines.length);
      const emptyLines = Array(rowOffset).fill(' '.repeat(maxWidth));
      const emptyColors = Array(rowOffset).fill(Array(maxWidth).fill('transparent'));
      
      if (direction === 'up') {
        frameLines.unshift(...emptyLines);
        frameColors.unshift(...emptyColors);
      } else {
        frameLines.push(...emptyLines);
        frameColors.push(...emptyColors);
      }
    }
    
    frames.push({
      id: `frame-${f}`,
      content: frameLines.join('\n'),
      colors: frameColors,
      timestamp: f * (config.duration / frameCount),
      duration: config.duration / frameCount,
    });
  }
  
  return frames;
}

/**
 * Glitch effect - random character corruption
 */
export function generateGlitch(
  text: string,
  colors: string[][],
  config: AnimationConfig
): AnimationFrame[] {
  const glitchChars = '!@#$%^&*()_+-=[]{}|;:,.<>?~`░▒▓█▄▀';
  const frameCount = Math.floor(config.duration / (1000 / config.frameRate));
  const frames: AnimationFrame[] = [];
  const lines = text.split('\n');
  
  for (let f = 0; f < frameCount; f++) {
    const intensity = Math.sin(f / frameCount * Math.PI) * 0.3;
    const frameLines: string[] = [];
    const frameColors: string[][] = [];
    
    for (let row = 0; row < lines.length; row++) {
      let line = '';
      const lineColors: string[] = [];
      
      for (let col = 0; col < lines[row].length; col++) {
        if (Math.random() < intensity) {
          line += glitchChars[Math.floor(Math.random() * glitchChars.length)];
          lineColors.push(['#ff0000', '#00ff00', '#0000ff'][Math.floor(Math.random() * 3)]);
        } else {
          line += lines[row][col];
          lineColors.push(colors[row]?.[col] || '#fff');
        }
      }
      
      frameLines.push(line);
      frameColors.push(lineColors);
    }
    
    frames.push({
      id: `frame-${f}`,
      content: frameLines.join('\n'),
      colors: frameColors,
      timestamp: f * (config.duration / frameCount),
      duration: config.duration / frameCount,
    });
  }
  
  return frames;
}

/**
 * Rainbow cycle - shift colors through spectrum
 */
export function generateRainbow(
  text: string,
  config: AnimationConfig
): AnimationFrame[] {
  const frameCount = Math.floor(config.duration / (1000 / config.frameRate));
  const frames: AnimationFrame[] = [];
  const lines = text.split('\n');
  
  for (let f = 0; f < frameCount; f++) {
    const hueOffset = (f / frameCount) * 360;
    const frameColors: string[][] = [];
    
    for (let row = 0; row < lines.length; row++) {
      const lineColors: string[] = [];
      for (let col = 0; col < lines[row].length; col++) {
        const hue = (hueOffset + col * 10 + row * 20) % 360;
        lineColors.push(`hsl(${hue}, 100%, 50%)`);
      }
      frameColors.push(lineColors);
    }
    
    frames.push({
      id: `frame-${f}`,
      content: text,
      colors: frameColors,
      timestamp: f * (config.duration / frameCount),
      duration: config.duration / frameCount,
    });
  }
  
  return frames;
}

// ============================================
// Animation Generator
// ============================================

export function generateAnimation(
  text: string,
  colors: string[][],
  config: AnimationConfig
): Animation {
  let frames: AnimationFrame[];
  
  switch (config.transition) {
    case 'typewriter':
      frames = generateTypewriter(text, colors, config);
      break;
    case 'fade':
      frames = generateFade(text, colors, config);
      break;
    case 'slide-left':
      frames = generateSlide(text, colors, config, 'left');
      break;
    case 'slide-right':
      frames = generateSlide(text, colors, config, 'right');
      break;
    case 'slide-up':
      frames = generateSlide(text, colors, config, 'up');
      break;
    case 'slide-down':
      frames = generateSlide(text, colors, config, 'down');
      break;
    case 'glitch':
      frames = generateGlitch(text, colors, config);
      break;
    case 'rainbow':
      frames = generateRainbow(text, config);
      break;
    default:
      frames = [{ id: 'frame-0', content: text, colors, timestamp: 0, duration: config.duration }];
  }
  
  if (config.reverse) {
    frames = frames.reverse();
  }
  
  return {
    id: `anim-${Date.now()}`,
    name: `${config.transition} animation`,
    frames,
    config,
    metadata: {
      createdAt: new Date(),
      totalDuration: config.duration,
      frameCount: frames.length,
    },
  };
}

// ============================================
// Animation Player (for preview)
// ============================================

export class AnimationPlayer {
  private animation: Animation;
  private currentFrame: number = 0;
  private isPlaying: boolean = false;
  private timer: NodeJS.Timeout | null = null;
  private onFrame: ((frame: AnimationFrame) => void) | null = null;
  
  constructor(animation: Animation) {
    this.animation = animation;
  }
  
  play(onFrame: (frame: AnimationFrame) => void): void {
    this.onFrame = onFrame;
    this.isPlaying = true;
    this.tick();
  }
  
  pause(): void {
    this.isPlaying = false;
    if (this.timer) clearTimeout(this.timer);
  }
  
  stop(): void {
    this.pause();
    this.currentFrame = 0;
  }
  
  seek(frameIndex: number): void {
    this.currentFrame = Math.max(0, Math.min(frameIndex, this.animation.frames.length - 1));
    if (this.onFrame) {
      this.onFrame(this.animation.frames[this.currentFrame]);
    }
  }
  
  private tick(): void {
    if (!this.isPlaying) return;
    
    const frame = this.animation.frames[this.currentFrame];
    if (this.onFrame) this.onFrame(frame);
    
    this.currentFrame++;
    
    if (this.currentFrame >= this.animation.frames.length) {
      if (this.animation.config.loop === true || 
          (typeof this.animation.config.loop === 'number' && this.animation.config.loop > 0)) {
        this.currentFrame = 0;
        if (typeof this.animation.config.loop === 'number') {
          this.animation.config.loop--;
        }
      } else {
        this.isPlaying = false;
        return;
      }
    }
    
    this.timer = setTimeout(() => this.tick(), frame.duration);
  }
  
  getCurrentFrame(): number { return this.currentFrame; }
  getTotalFrames(): number { return this.animation.frames.length; }
  getIsPlaying(): boolean { return this.isPlaying; }
}

export default {
  generateAnimation,
  generateTypewriter,
  generateFade,
  generateSlide,
  generateGlitch,
  generateRainbow,
  AnimationPlayer,
};
