/**
 * Visual Diffing System
 * Character-level, color, and style comparison
 */

// ============================================
// Types
// ============================================

export interface CharacterDiff {
  row: number;
  col: number;
  oldChar: string;
  newChar: string;
  type: 'added' | 'removed' | 'changed' | 'unchanged';
}

export interface ColorDiff {
  row: number;
  col: number;
  oldColor: string;
  newColor: string;
}

export interface StyleDiff {
  property: string;
  oldValue: any;
  newValue: any;
}

export interface DiffSummary {
  charactersAdded: number;
  charactersRemoved: number;
  charactersChanged: number;
  colorsChanged: number;
  stylesChanged: number;
  similarity: number; // 0-100%
}

export interface VisualDiff {
  characters: CharacterDiff[];
  colors: ColorDiff[];
  styles: StyleDiff[];
  summary: DiffSummary;
}

export interface AsciiFrame {
  lines: string[];
  colors?: string[][];
  styles?: Record<string, any>;
}

// ============================================
// Diff Functions
// ============================================

/**
 * Compute character-level diff between two ASCII frames
 */
export function diffCharacters(
  oldFrame: AsciiFrame,
  newFrame: AsciiFrame
): CharacterDiff[] {
  const diffs: CharacterDiff[] = [];
  const maxRows = Math.max(oldFrame.lines.length, newFrame.lines.length);
  
  for (let row = 0; row < maxRows; row++) {
    const oldLine = oldFrame.lines[row] || '';
    const newLine = newFrame.lines[row] || '';
    const maxCols = Math.max(oldLine.length, newLine.length);
    
    for (let col = 0; col < maxCols; col++) {
      const oldChar = oldLine[col] || '';
      const newChar = newLine[col] || '';
      
      if (oldChar !== newChar) {
        let type: CharacterDiff['type'];
        if (!oldChar) type = 'added';
        else if (!newChar) type = 'removed';
        else type = 'changed';
        
        diffs.push({ row, col, oldChar, newChar, type });
      }
    }
  }
  
  return diffs;
}

/**
 * Compute color diff between two frames
 */
export function diffColors(
  oldFrame: AsciiFrame,
  newFrame: AsciiFrame
): ColorDiff[] {
  const diffs: ColorDiff[] = [];
  
  if (!oldFrame.colors || !newFrame.colors) return diffs;
  
  const maxRows = Math.max(oldFrame.colors.length, newFrame.colors.length);
  
  for (let row = 0; row < maxRows; row++) {
    const oldRow = oldFrame.colors[row] || [];
    const newRow = newFrame.colors[row] || [];
    const maxCols = Math.max(oldRow.length, newRow.length);
    
    for (let col = 0; col < maxCols; col++) {
      const oldColor = oldRow[col] || '';
      const newColor = newRow[col] || '';
      
      if (oldColor !== newColor) {
        diffs.push({ row, col, oldColor, newColor });
      }
    }
  }
  
  return diffs;
}

/**
 * Compute style diff between two frames
 */
export function diffStyles(
  oldFrame: AsciiFrame,
  newFrame: AsciiFrame
): StyleDiff[] {
  const diffs: StyleDiff[] = [];
  const oldStyles = oldFrame.styles || {};
  const newStyles = newFrame.styles || {};
  
  const allKeys = new Set([
    ...Object.keys(oldStyles),
    ...Object.keys(newStyles),
  ]);
  
  for (const key of allKeys) {
    const oldValue = oldStyles[key];
    const newValue = newStyles[key];
    
    if (JSON.stringify(oldValue) !== JSON.stringify(newValue)) {
      diffs.push({ property: key, oldValue, newValue });
    }
  }
  
  return diffs;
}

/**
 * Compute complete visual diff between two frames
 */
export function diffFrames(
  oldFrame: AsciiFrame,
  newFrame: AsciiFrame
): VisualDiff {
  const characters = diffCharacters(oldFrame, newFrame);
  const colors = diffColors(oldFrame, newFrame);
  const styles = diffStyles(oldFrame, newFrame);
  
  // Calculate summary
  const added = characters.filter(d => d.type === 'added').length;
  const removed = characters.filter(d => d.type === 'removed').length;
  const changed = characters.filter(d => d.type === 'changed').length;
  
  // Calculate total characters for similarity
  const oldTotal = oldFrame.lines.reduce((sum, line) => sum + line.length, 0);
  const newTotal = newFrame.lines.reduce((sum, line) => sum + line.length, 0);
  const avgTotal = (oldTotal + newTotal) / 2;
  const totalChanges = added + removed + changed;
  const similarity = avgTotal > 0 
    ? Math.round((1 - totalChanges / avgTotal) * 100)
    : 100;
  
  return {
    characters,
    colors,
    styles,
    summary: {
      charactersAdded: added,
      charactersRemoved: removed,
      charactersChanged: changed,
      colorsChanged: colors.length,
      stylesChanged: styles.length,
      similarity: Math.max(0, Math.min(100, similarity)),
    },
  };
}

/**
 * Generate visual diff report as markdown
 */
export function generateDiffReport(diff: VisualDiff): string {
  const lines: string[] = [
    '# Visual Diff Report',
    '',
    '## Summary',
    `- **Similarity**: ${diff.summary.similarity}%`,
    `- **Characters Added**: ${diff.summary.charactersAdded}`,
    `- **Characters Removed**: ${diff.summary.charactersRemoved}`,
    `- **Characters Changed**: ${diff.summary.charactersChanged}`,
    `- **Colors Changed**: ${diff.summary.colorsChanged}`,
    `- **Styles Changed**: ${diff.summary.stylesChanged}`,
    '',
  ];
  
  if (diff.styles.length > 0) {
    lines.push('## Style Changes');
    for (const s of diff.styles) {
      lines.push(`- **${s.property}**: \`${JSON.stringify(s.oldValue)}\` → \`${JSON.stringify(s.newValue)}\``);
    }
    lines.push('');
  }
  
  return lines.join('\n');
}

/**
 * Check if two frames are identical
 */
export function framesEqual(a: AsciiFrame, b: AsciiFrame): boolean {
  const diff = diffFrames(a, b);
  return diff.summary.similarity === 100;
}

export default {
  diffCharacters,
  diffColors,
  diffStyles,
  diffFrames,
  generateDiffReport,
  framesEqual,
};
