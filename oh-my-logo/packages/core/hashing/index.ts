/**
 * Deterministic Hashing System
 * Ensures reproducible renders with content/style/font fingerprints
 */

import { createHash } from 'crypto';

// ============================================
// Types
// ============================================

export interface RenderHash {
  contentHash: string;
  styleHash: string;
  fontHash: string;
  renderHash: string;
  version: string;
  timestamp: number;
}

export interface HashableContent {
  text: string;
  multiline?: boolean;
}

export interface HashableStyle {
  palette: string[];
  direction: string;
  effects: Record<string, any>;
  background?: string;
}

export interface HashableFont {
  name: string;
  kerning?: number;
  letterSpacing?: number;
  lineHeight?: number;
}

// ============================================
// Hash Functions
// ============================================

const ENGINE_VERSION = '1.0.0';

function sha256(data: string): string {
  return createHash('sha256').update(data).digest('hex');
}

function normalizeObject(obj: Record<string, any>): string {
  const sorted = Object.keys(obj)
    .sort()
    .reduce((acc, key) => {
      const value = obj[key];
      if (value !== undefined && value !== null) {
        acc[key] = typeof value === 'object' && !Array.isArray(value)
          ? normalizeObject(value)
          : value;
      }
      return acc;
    }, {} as Record<string, any>);
  
  return JSON.stringify(sorted);
}

export function hashContent(content: HashableContent): string {
  return sha256(`content:${normalizeObject(content)}`);
}

export function hashStyle(style: HashableStyle): string {
  return sha256(`style:${normalizeObject(style)}`);
}

export function hashFont(font: HashableFont): string {
  return sha256(`font:${normalizeObject(font)}`);
}

export function hashRender(
  content: HashableContent,
  style: HashableStyle,
  font: HashableFont
): RenderHash {
  const contentHash = hashContent(content);
  const styleHash = hashStyle(style);
  const fontHash = hashFont(font);
  
  const renderHash = sha256(
    `render:${ENGINE_VERSION}:${contentHash}:${styleHash}:${fontHash}`
  );
  
  return {
    contentHash,
    styleHash,
    fontHash,
    renderHash,
    version: ENGINE_VERSION,
    timestamp: Date.now(),
  };
}

export function verifyHash(hash1: RenderHash, hash2: RenderHash): boolean {
  return hash1.renderHash === hash2.renderHash;
}

export function shortHash(hash: string): string {
  return hash.substring(0, 8);
}

export function compareHashes(hash1: RenderHash, hash2: RenderHash) {
  return {
    match: hash1.renderHash === hash2.renderHash,
    contentChanged: hash1.contentHash !== hash2.contentHash,
    styleChanged: hash1.styleHash !== hash2.styleHash,
    fontChanged: hash1.fontHash !== hash2.fontHash,
  };
}

// Cache
class RenderCache {
  private cache: Map<string, { output: string; createdAt: number }> = new Map();
  private maxSize: number;
  
  constructor(maxSize = 100) { this.maxSize = maxSize; }
  
  get(hash: RenderHash): string | null {
    return this.cache.get(hash.renderHash)?.output || null;
  }
  
  set(hash: RenderHash, output: string): void {
    if (this.cache.size >= this.maxSize) {
      const oldest = [...this.cache.entries()].sort((a, b) => a[1].createdAt - b[1].createdAt)[0];
      if (oldest) this.cache.delete(oldest[0]);
    }
    this.cache.set(hash.renderHash, { output, createdAt: Date.now() });
  }
  
  has(hash: RenderHash): boolean { return this.cache.has(hash.renderHash); }
  clear(): void { this.cache.clear(); }
  size(): number { return this.cache.size; }
}

export const renderCache = new RenderCache();
