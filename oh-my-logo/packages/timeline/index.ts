/**
 * Timeline System
 * Fusion 360-style history management with undo/redo, branching, and persistence
 */

import type { LogoDesign } from '../ai/types';

// ============================================
// Types
// ============================================

export interface DesignSnapshot {
  id: string;
  timestamp: Date;
  design: LogoDesign;
  action: string;
  description: string;
  preview?: string; // Base64 thumbnail
}

export interface TimelineBranch {
  id: string;
  name: string;
  parentId?: string;
  snapshots: DesignSnapshot[];
  createdAt: Date;
}

export interface TimelineState {
  // Current state
  currentSnapshotId: string | null;
  
  // History stacks
  past: DesignSnapshot[];
  present: DesignSnapshot | null;
  future: DesignSnapshot[];
  
  // Branching
  branches: TimelineBranch[];
  activeBranchId: string;
  
  // Metadata
  projectId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface TimelineAction {
  type: string;
  payload: any;
  timestamp: Date;
}

// ============================================
// Timeline Manager
// ============================================

export class TimelineManager {
  private state: TimelineState;
  private maxHistory: number;
  private autoSnapshot: boolean;
  private listeners: Set<(state: TimelineState) => void>;
  
  constructor(projectId: string, options?: { maxHistory?: number; autoSnapshot?: boolean }) {
    this.maxHistory = options?.maxHistory || 500;
    this.autoSnapshot = options?.autoSnapshot ?? true;
    this.listeners = new Set();
    
    // Initialize state
    const mainBranch: TimelineBranch = {
      id: 'main',
      name: 'Main',
      snapshots: [],
      createdAt: new Date(),
    };
    
    this.state = {
      currentSnapshotId: null,
      past: [],
      present: null,
      future: [],
      branches: [mainBranch],
      activeBranchId: 'main',
      projectId,
      createdAt: new Date(),
      updatedAt: new Date(),
    };
  }
  
  // ----------------------------------------
  // State Management
  // ----------------------------------------
  
  getState(): TimelineState {
    return { ...this.state };
  }
  
  getCurrentDesign(): LogoDesign | null {
    return this.state.present?.design || null;
  }
  
  subscribe(listener: (state: TimelineState) => void): () => void {
    this.listeners.add(listener);
    return () => this.listeners.delete(listener);
  }
  
  private notify() {
    this.state.updatedAt = new Date();
    this.listeners.forEach(listener => listener(this.getState()));
  }
  
  // ----------------------------------------
  // Snapshot Operations
  // ----------------------------------------
  
  /**
   * Create a new snapshot (like committing in git)
   */
  createSnapshot(design: LogoDesign, action: string, description?: string): DesignSnapshot {
    const snapshot: DesignSnapshot = {
      id: crypto.randomUUID(),
      timestamp: new Date(),
      design: { ...design },
      action,
      description: description || action,
    };
    
    // Clear future (we're creating a new timeline branch)
    if (this.state.present) {
      this.state.past.push(this.state.present);
    }
    this.state.present = snapshot;
    this.state.future = [];
    this.state.currentSnapshotId = snapshot.id;
    
    // Enforce max history
    if (this.state.past.length > this.maxHistory) {
      this.state.past = this.state.past.slice(-this.maxHistory);
    }
    
    // Add to active branch
    const branch = this.state.branches.find(b => b.id === this.state.activeBranchId);
    if (branch) {
      branch.snapshots.push(snapshot);
    }
    
    this.notify();
    return snapshot;
  }
  
  /**
   * Update current snapshot without creating new history entry
   */
  updateCurrent(design: LogoDesign): void {
    if (this.state.present) {
      this.state.present = {
        ...this.state.present,
        design: { ...design },
        timestamp: new Date(),
      };
      this.notify();
    }
  }
  
  // ----------------------------------------
  // Time Travel Operations
  // ----------------------------------------
  
  /**
   * Undo - go back one step
   */
  undo(): DesignSnapshot | null {
    if (this.state.past.length === 0) return null;
    
    const previous = this.state.past.pop()!;
    
    if (this.state.present) {
      this.state.future.unshift(this.state.present);
    }
    
    this.state.present = previous;
    this.state.currentSnapshotId = previous.id;
    
    this.notify();
    return previous;
  }
  
  /**
   * Redo - go forward one step
   */
  redo(): DesignSnapshot | null {
    if (this.state.future.length === 0) return null;
    
    const next = this.state.future.shift()!;
    
    if (this.state.present) {
      this.state.past.push(this.state.present);
    }
    
    this.state.present = next;
    this.state.currentSnapshotId = next.id;
    
    this.notify();
    return next;
  }
  
  /**
   * Rewind - go back multiple steps
   */
  rewind(steps: number): DesignSnapshot | null {
    let result: DesignSnapshot | null = null;
    for (let i = 0; i < steps && this.canUndo(); i++) {
      result = this.undo();
    }
    return result;
  }
  
  /**
   * Fast forward - go forward multiple steps
   */
  fastForward(steps: number): DesignSnapshot | null {
    let result: DesignSnapshot | null = null;
    for (let i = 0; i < steps && this.canRedo(); i++) {
      result = this.redo();
    }
    return result;
  }
  
  /**
   * Jump to specific snapshot
   */
  jumpTo(snapshotId: string): DesignSnapshot | null {
    // Check past
    const pastIndex = this.state.past.findIndex(s => s.id === snapshotId);
    if (pastIndex !== -1) {
      const stepsBack = this.state.past.length - pastIndex;
      return this.rewind(stepsBack);
    }
    
    // Check future
    const futureIndex = this.state.future.findIndex(s => s.id === snapshotId);
    if (futureIndex !== -1) {
      return this.fastForward(futureIndex + 1);
    }
    
    // Already at this snapshot
    if (this.state.present?.id === snapshotId) {
      return this.state.present;
    }
    
    return null;
  }
  
  /**
   * Jump to specific index in timeline
   */
  jumpToIndex(index: number): DesignSnapshot | null {
    const allSnapshots = this.getAllSnapshots();
    if (index < 0 || index >= allSnapshots.length) return null;
    
    return this.jumpTo(allSnapshots[index].id);
  }
  
  // ----------------------------------------
  // Query Operations
  // ----------------------------------------
  
  canUndo(): boolean {
    return this.state.past.length > 0;
  }
  
  canRedo(): boolean {
    return this.state.future.length > 0;
  }
  
  getUndoCount(): number {
    return this.state.past.length;
  }
  
  getRedoCount(): number {
    return this.state.future.length;
  }
  
  getCurrentIndex(): number {
    return this.state.past.length;
  }
  
  getTotalCount(): number {
    return this.state.past.length + (this.state.present ? 1 : 0) + this.state.future.length;
  }
  
  getAllSnapshots(): DesignSnapshot[] {
    return [
      ...this.state.past,
      ...(this.state.present ? [this.state.present] : []),
      ...this.state.future,
    ];
  }
  
  getSnapshot(id: string): DesignSnapshot | null {
    return this.getAllSnapshots().find(s => s.id === id) || null;
  }
  
  // ----------------------------------------
  // Branch Operations
  // ----------------------------------------
  
  createBranch(name: string): TimelineBranch {
    const branch: TimelineBranch = {
      id: crypto.randomUUID(),
      name,
      parentId: this.state.activeBranchId,
      snapshots: this.state.present ? [this.state.present] : [],
      createdAt: new Date(),
    };
    
    this.state.branches.push(branch);
    this.notify();
    return branch;
  }
  
  switchBranch(branchId: string): boolean {
    const branch = this.state.branches.find(b => b.id === branchId);
    if (!branch) return false;
    
    this.state.activeBranchId = branchId;
    
    // Restore branch state
    if (branch.snapshots.length > 0) {
      const lastSnapshot = branch.snapshots[branch.snapshots.length - 1];
      this.state.past = branch.snapshots.slice(0, -1);
      this.state.present = lastSnapshot;
      this.state.future = [];
      this.state.currentSnapshotId = lastSnapshot.id;
    }
    
    this.notify();
    return true;
  }
  
  deleteBranch(branchId: string): boolean {
    if (branchId === 'main') return false; // Can't delete main
    if (this.state.activeBranchId === branchId) return false; // Can't delete active
    
    this.state.branches = this.state.branches.filter(b => b.id !== branchId);
    this.notify();
    return true;
  }
  
  renameBranch(branchId: string, newName: string): boolean {
    const branch = this.state.branches.find(b => b.id === branchId);
    if (!branch) return false;
    
    branch.name = newName;
    this.notify();
    return true;
  }
  
  listBranches(): TimelineBranch[] {
    return [...this.state.branches];
  }
  
  // ----------------------------------------
  // Persistence
  // ----------------------------------------
  
  /**
   * Export timeline to JSON
   */
  export(): string {
    return JSON.stringify(this.state, null, 2);
  }
  
  /**
   * Import timeline from JSON
   */
  import(json: string): void {
    const imported = JSON.parse(json);
    
    // Restore dates
    imported.createdAt = new Date(imported.createdAt);
    imported.updatedAt = new Date(imported.updatedAt);
    imported.past.forEach((s: any) => s.timestamp = new Date(s.timestamp));
    if (imported.present) imported.present.timestamp = new Date(imported.present.timestamp);
    imported.future.forEach((s: any) => s.timestamp = new Date(s.timestamp));
    imported.branches.forEach((b: any) => {
      b.createdAt = new Date(b.createdAt);
      b.snapshots.forEach((s: any) => s.timestamp = new Date(s.timestamp));
    });
    
    this.state = imported;
    this.notify();
  }
  
  /**
   * Clear all history
   */
  clear(): void {
    this.state.past = [];
    this.state.present = null;
    this.state.future = [];
    this.state.currentSnapshotId = null;
    this.notify();
  }
}

// ============================================
// Factory Function
// ============================================

export function createTimeline(projectId: string, options?: { maxHistory?: number; autoSnapshot?: boolean }): TimelineManager {
  return new TimelineManager(projectId, options);
}

export default TimelineManager;
