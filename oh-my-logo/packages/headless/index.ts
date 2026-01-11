/**
 * Headless Pro Engine
 * Pure Node.js engine - No UI dependencies, No Electron
 * Shared core for GUI, CLI, and automation
 */

import { EventEmitter } from 'events';

// ============================================
// Types
// ============================================

export interface HeadlessConfig {
  text: string;
  font?: string;
  palette?: string[];
  theme?: string;
  effects?: {
    shadow?: { enabled: boolean; color: string; offsetX: number; offsetY: number };
    outline?: { enabled: boolean; color: string; width: number };
    glow?: { enabled: boolean; color: string; intensity: number };
  };
  animation?: {
    enabled: boolean;
    transition: string;
    duration: number;
    frameRate: number;
    loop: boolean | number;
  };
  export?: {
    format: 'png' | 'svg' | 'html' | 'gif' | 'pdf' | 'markdown' | 'ansi' | 'json';
    outputPath?: string;
    options?: Record<string, any>;
  };
  batch?: {
    inputs: string[];
    template?: string;
    variables?: Record<string, string[]>;
    parallel?: number;
  };
  ai?: {
    enabled: boolean;
    provider: 'claude' | 'openai' | 'ollama' | 'lmstudio';
    enhance?: boolean;
    enhanceLevel?: 'basic' | 'detailed' | 'extreme';
  };
}

export interface RenderResult {
  success: boolean;
  ascii: string;
  colors: string[][];
  hash: { content: string; style: string; font: string; render: string };
  metadata: {
    font: string;
    palette: string[];
    dimensions: { width: number; height: number };
    timestamp: number;
  };
  export?: { format: string; data: Buffer | string; path?: string };
}

export interface BatchResult {
  total: number;
  successful: number;
  failed: number;
  results: RenderResult[];
  errors: { input: string; error: string }[];
  duration: number;
}

// ============================================
// Headless Engine Class
// ============================================

export class HeadlessEngine extends EventEmitter {
  private config: HeadlessConfig;
  private cache: Map<string, RenderResult> = new Map();
  
  constructor(config: HeadlessConfig) {
    super();
    this.config = config;
  }
  
  async render(): Promise<RenderResult> {
    this.emit('render:start', { text: this.config.text });
    
    try {
      const ascii = this.generateAscii(this.config.text, this.config.font || 'Standard');
      const colors = this.applyColors(ascii, this.config.palette || ['#00ff00']);
      const hash = this.generateHashes(this.config.text, this.config);
      
      const cached = this.cache.get(hash.render);
      if (cached) {
        this.emit('render:cached', { hash: hash.render });
        return cached;
      }
      
      const result: RenderResult = {
        success: true,
        ascii,
        colors,
        hash,
        metadata: {
          font: this.config.font || 'Standard',
          palette: this.config.palette || ['#00ff00'],
          dimensions: this.calculateDimensions(ascii),
          timestamp: Date.now(),
        },
      };
      
      if (this.config.export) {
        result.export = await this.exportResult(result);
      }
      
      this.cache.set(hash.render, result);
      this.emit('render:complete', result);
      return result;
    } catch (error) {
      this.emit('render:error', error);
      throw error;
    }
  }
  
  async batchRender(): Promise<BatchResult> {
    if (!this.config.batch) throw new Error('Batch configuration required');
    
    const startTime = Date.now();
    const results: RenderResult[] = [];
    const errors: { input: string; error: string }[] = [];
    const inputs = this.expandBatchInputs();
    const parallel = this.config.batch.parallel || 4;
    
    this.emit('batch:start', { total: inputs.length, parallel });
    
    for (let i = 0; i < inputs.length; i += parallel) {
      const chunk = inputs.slice(i, i + parallel);
      const chunkResults = await Promise.allSettled(chunk.map(input => this.renderSingle(input)));
      
      chunkResults.forEach((result, idx) => {
        if (result.status === 'fulfilled') results.push(result.value);
        else errors.push({ input: chunk[idx], error: result.reason.message });
      });
      
      this.emit('batch:progress', { completed: Math.min(i + parallel, inputs.length), total: inputs.length });
    }
    
    const batchResult: BatchResult = {
      total: inputs.length, successful: results.length, failed: errors.length,
      results, errors, duration: Date.now() - startTime,
    };
    
    this.emit('batch:complete', batchResult);
    return batchResult;
  }
  
  private async renderSingle(text: string): Promise<RenderResult> {
    const engine = new HeadlessEngine({ ...this.config, text });
    return engine.render();
  }
  
  private expandBatchInputs(): string[] {
    const { batch } = this.config;
    if (!batch) return [];
    
    if (batch.template && batch.variables) {
      const expanded: string[] = [];
      const varNames = Object.keys(batch.variables);
      const varValues = Object.values(batch.variables);
      const combinations = this.cartesianProduct(varValues);
      
      for (const combo of combinations) {
        let text = batch.template;
        varNames.forEach((name, i) => {
          text = text.replace(new RegExp(`\\{\\{${name}\\}\\}`, 'g'), combo[i]);
        });
        expanded.push(text);
      }
      return expanded;
    }
    return batch.inputs || [];
  }
  
  private cartesianProduct(arrays: string[][]): string[][] {
    return arrays.reduce<string[][]>((acc, arr) => acc.flatMap(x => arr.map(y => [...x, y])), [[]]);
  }
  
  private generateAscii(text: string, font: string): string {
    const lines: string[] = [];
    for (let i = 0; i < 6; i++) {
      let line = '';
      for (const char of text.toUpperCase()) {
        if (char === ' ') line += '    ';
        else line += ['█▀▀', '█▀▀', '███', '█▄▄', '█▄▄', '▀▀▀'][i] + ' ';
      }
      lines.push(line);
    }
    return lines.join('\n');
  }
  
  private applyColors(ascii: string, palette: string[]): string[][] {
    const lines = ascii.split('\n');
    return lines.map((line, row) =>
      [...line].map(() => palette[Math.min(Math.floor((row / lines.length) * palette.length), palette.length - 1)])
    );
  }
  
  private generateHashes(text: string, config: HeadlessConfig) {
    const crypto = require('crypto');
    const sha256 = (data: string) => crypto.createHash('sha256').update(data).digest('hex');
    const contentHash = sha256(`content:${text}`);
    const styleHash = sha256(`style:${JSON.stringify(config.palette)}:${JSON.stringify(config.effects)}`);
    const fontHash = sha256(`font:${config.font || 'Standard'}`);
    const renderHash = sha256(`render:${contentHash}:${styleHash}:${fontHash}`);
    return { content: contentHash, style: styleHash, font: fontHash, render: renderHash };
  }
  
  private calculateDimensions(ascii: string) {
    const lines = ascii.split('\n');
    return { width: Math.max(...lines.map(l => l.length)), height: lines.length };
  }
  
  private async exportResult(result: RenderResult) {
    const { format, outputPath } = this.config.export!;
    const data = format === 'json' ? JSON.stringify(result, null, 2) : `[${format.toUpperCase()}]`;
    return { format, data, path: outputPath };
  }
  
  setConfig(config: Partial<HeadlessConfig>): void { this.config = { ...this.config, ...config }; }
  clearCache(): void { this.cache.clear(); }
  getCacheStats() { return { size: this.cache.size, keys: [...this.cache.keys()].map(k => k.substring(0, 8)) }; }
}

export function createHeadlessEngine(config: HeadlessConfig): HeadlessEngine {
  return new HeadlessEngine(config);
}

export default { HeadlessEngine, createHeadlessEngine };
