/**
 * Export System
 * PNG, SVG, HTML, GIF, PDF, Markdown, ANSI, JSON exports
 */

// ============================================
// Types
// ============================================

export type ExportFormat = 
  | 'png' 
  | 'svg' 
  | 'html' 
  | 'gif' 
  | 'pdf' 
  | 'markdown' 
  | 'ansi' 
  | 'json';

export interface ExportOptions {
  format: ExportFormat;
  width?: number;
  height?: number;
  scale?: number;
  dpi?: number;
  background?: string | 'transparent';
  padding?: number | [number, number, number, number];
  filename?: string;
}

export interface PngOptions extends ExportOptions {
  format: 'png';
  compression?: number; // 0-9
  colorType?: 'rgb' | 'rgba' | 'grayscale';
}

export interface SvgOptions extends ExportOptions {
  format: 'svg';
  embedFonts?: boolean;
  responsive?: boolean;
  className?: string;
}

export interface HtmlOptions extends ExportOptions {
  format: 'html';
  inlineStyles?: boolean;
  responsive?: boolean;
  darkMode?: boolean;
  title?: string;
}

export interface GifOptions extends ExportOptions {
  format: 'gif';
  frameDelay?: number; // ms
  loop?: boolean | number;
  quality?: number; // 1-20
}

export interface PdfOptions extends ExportOptions {
  format: 'pdf';
  pageSize?: 'a4' | 'letter' | 'legal' | 'custom';
  orientation?: 'portrait' | 'landscape';
  margins?: number | [number, number, number, number];
}

export interface ExportResult {
  success: boolean;
  format: ExportFormat;
  data: Buffer | string;
  mimeType: string;
  filename: string;
  size: number;
  metadata?: Record<string, any>;
}

// ============================================
// Export Functions
// ============================================

/**
 * Export to PNG (requires sharp or node-canvas)
 */
export async function exportPng(
  asciiArt: string,
  colors: string[][],
  options: PngOptions
): Promise<ExportResult> {
  // In real implementation, would use sharp or node-canvas
  const buffer = Buffer.from(`[PNG: ${asciiArt.substring(0, 50)}...]`);
  
  return {
    success: true,
    format: 'png',
    data: buffer,
    mimeType: 'image/png',
    filename: options.filename || `ascii-${Date.now()}.png`,
    size: buffer.length,
    metadata: {
      width: options.width || 800,
      height: options.height || 600,
      dpi: options.dpi || 300,
    },
  };
}

/**
 * Export to SVG (vector)
 */
export async function exportSvg(
  asciiArt: string,
  colors: string[][],
  options: SvgOptions
): Promise<ExportResult> {
  const lines = asciiArt.split('\n');
  const charWidth = 10;
  const charHeight = 18;
  const width = Math.max(...lines.map(l => l.length)) * charWidth;
  const height = lines.length * charHeight;
  
  let svg = `<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" 
     viewBox="0 0 ${width} ${height}"
     ${options.responsive ? 'preserveAspectRatio="xMidYMid meet"' : ''}
     ${options.className ? `class="${options.className}"` : ''}>
  <style>
    .ascii-char { font-family: monospace; font-size: 14px; }
  </style>
  <rect width="100%" height="100%" fill="${options.background || '#000'}"/>
  <g class="ascii-text">
`;

  lines.forEach((line, row) => {
    [...line].forEach((char, col) => {
      const color = colors[row]?.[col] || '#fff';
      if (char !== ' ') {
        svg += `    <text class="ascii-char" x="${col * charWidth}" y="${(row + 1) * charHeight}" fill="${color}">${escapeHtml(char)}</text>\n`;
      }
    });
  });

  svg += `  </g>\n</svg>`;
  
  return {
    success: true,
    format: 'svg',
    data: svg,
    mimeType: 'image/svg+xml',
    filename: options.filename || `ascii-${Date.now()}.svg`,
    size: Buffer.byteLength(svg),
    metadata: { width, height },
  };
}

/**
 * Export to HTML
 */
export async function exportHtml(
  asciiArt: string,
  colors: string[][],
  options: HtmlOptions
): Promise<ExportResult> {
  const lines = asciiArt.split('\n');
  const bg = options.background || '#000';
  const title = options.title || 'ASCII Art';
  
  let html = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${escapeHtml(title)}</title>
  <style>
    body {
      margin: 0;
      padding: 20px;
      background: ${bg};
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }
    .ascii-container {
      font-family: 'Courier New', monospace;
      font-size: 14px;
      line-height: 1.2;
      white-space: pre;
    }
    .ascii-line { display: block; }
    ${options.darkMode ? '@media (prefers-color-scheme: light) { body { background: #fff; } }' : ''}
  </style>
</head>
<body>
  <div class="ascii-container">
`;

  lines.forEach((line, row) => {
    html += '    <span class="ascii-line">';
    [...line].forEach((char, col) => {
      const color = colors[row]?.[col] || '#fff';
      if (options.inlineStyles) {
        html += `<span style="color:${color}">${escapeHtml(char)}</span>`;
      } else {
        html += escapeHtml(char);
      }
    });
    html += '</span>\n';
  });

  html += `  </div>
</body>
</html>`;

  return {
    success: true,
    format: 'html',
    data: html,
    mimeType: 'text/html',
    filename: options.filename || `ascii-${Date.now()}.html`,
    size: Buffer.byteLength(html),
  };
}

/**
 * Export to Markdown
 */
export async function exportMarkdown(
  asciiArt: string,
  options: ExportOptions
): Promise<ExportResult> {
  const md = `\`\`\`
${asciiArt}
\`\`\``;

  return {
    success: true,
    format: 'markdown',
    data: md,
    mimeType: 'text/markdown',
    filename: options.filename || `ascii-${Date.now()}.md`,
    size: Buffer.byteLength(md),
  };
}

/**
 * Export to ANSI (terminal codes)
 */
export async function exportAnsi(
  asciiArt: string,
  colors: string[][],
  options: ExportOptions
): Promise<ExportResult> {
  const lines = asciiArt.split('\n');
  let ansi = '';
  
  lines.forEach((line, row) => {
    [...line].forEach((char, col) => {
      const hex = colors[row]?.[col] || '#ffffff';
      const rgb = hexToRgb(hex);
      ansi += `\x1b[38;2;${rgb.r};${rgb.g};${rgb.b}m${char}`;
    });
    ansi += '\x1b[0m\n';
  });

  return {
    success: true,
    format: 'ansi',
    data: ansi,
    mimeType: 'text/plain',
    filename: options.filename || `ascii-${Date.now()}.ans`,
    size: Buffer.byteLength(ansi),
  };
}

/**
 * Export to JSON (design data)
 */
export async function exportJson(
  design: Record<string, any>,
  options: ExportOptions
): Promise<ExportResult> {
  const json = JSON.stringify(design, null, 2);
  
  return {
    success: true,
    format: 'json',
    data: json,
    mimeType: 'application/json',
    filename: options.filename || `ascii-${Date.now()}.json`,
    size: Buffer.byteLength(json),
  };
}

/**
 * Export to GIF (animated)
 */
export async function exportGif(
  frames: string[],
  colors: string[][][],
  options: GifOptions
): Promise<ExportResult> {
  // In real implementation, would use gif-encoder-2 or similar
  const buffer = Buffer.from(`[GIF: ${frames.length} frames]`);
  
  return {
    success: true,
    format: 'gif',
    data: buffer,
    mimeType: 'image/gif',
    filename: options.filename || `ascii-${Date.now()}.gif`,
    size: buffer.length,
    metadata: {
      frames: frames.length,
      frameDelay: options.frameDelay || 100,
      loop: options.loop ?? true,
    },
  };
}

/**
 * Export to PDF
 */
export async function exportPdf(
  asciiArt: string,
  colors: string[][],
  options: PdfOptions
): Promise<ExportResult> {
  // In real implementation, would use pdfkit
  const buffer = Buffer.from(`[PDF: ${asciiArt.substring(0, 50)}...]`);
  
  return {
    success: true,
    format: 'pdf',
    data: buffer,
    mimeType: 'application/pdf',
    filename: options.filename || `ascii-${Date.now()}.pdf`,
    size: buffer.length,
    metadata: {
      pageSize: options.pageSize || 'a4',
      orientation: options.orientation || 'landscape',
    },
  };
}

// ============================================
// Unified Export Function
// ============================================

export async function exportDesign(
  asciiArt: string,
  colors: string[][],
  options: ExportOptions
): Promise<ExportResult> {
  switch (options.format) {
    case 'png':
      return exportPng(asciiArt, colors, options as PngOptions);
    case 'svg':
      return exportSvg(asciiArt, colors, options as SvgOptions);
    case 'html':
      return exportHtml(asciiArt, colors, options as HtmlOptions);
    case 'markdown':
      return exportMarkdown(asciiArt, options);
    case 'ansi':
      return exportAnsi(asciiArt, colors, options);
    case 'json':
      return exportJson({ asciiArt, colors }, options);
    case 'gif':
      return exportGif([asciiArt], [colors], options as GifOptions);
    case 'pdf':
      return exportPdf(asciiArt, colors, options as PdfOptions);
    default:
      throw new Error(`Unsupported format: ${options.format}`);
  }
}

// ============================================
// Helpers
// ============================================

function escapeHtml(text: string): string {
  return text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;');
}

function hexToRgb(hex: string): { r: number; g: number; b: number } {
  const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  return result ? {
    r: parseInt(result[1], 16),
    g: parseInt(result[2], 16),
    b: parseInt(result[3], 16),
  } : { r: 255, g: 255, b: 255 };
}

export default {
  exportPng,
  exportSvg,
  exportHtml,
  exportMarkdown,
  exportAnsi,
  exportJson,
  exportGif,
  exportPdf,
  exportDesign,
};
