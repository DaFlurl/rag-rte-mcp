/**
 * Timeline Component - Fusion 360-style History with Visual Controls
 */

import React, { useState, useRef, useEffect } from 'react';
import { useStore } from '../../store';
import {
  Undo2,
  Redo2,
  Rewind,
  FastForward,
  Play,
  Pause,
  RotateCcw,
  GitBranch,
  ChevronDown,
  Trash2,
  Save,
  Clock,
} from 'lucide-react';

// ============================================
// Types
// ============================================

interface TimelineSnapshot {
  id: string;
  index: number;
  action: string;
  timestamp: Date;
  preview?: string;
  isCurrent: boolean;
}

// ============================================
// Timeline Slider Component
// ============================================

interface TimelineSliderProps {
  snapshots: TimelineSnapshot[];
  currentIndex: number;
  onSeek: (index: number) => void;
}

function TimelineSlider({ snapshots, currentIndex, onSeek }: TimelineSliderProps) {
  const sliderRef = useRef<HTMLDivElement>(null);
  const [isDragging, setIsDragging] = useState(false);
  
  const handleMouseDown = (e: React.MouseEvent) => {
    setIsDragging(true);
    handleSeek(e);
  };
  
  const handleMouseMove = (e: React.MouseEvent) => {
    if (isDragging) {
      handleSeek(e);
    }
  };
  
  const handleMouseUp = () => {
    setIsDragging(false);
  };
  
  const handleSeek = (e: React.MouseEvent) => {
    if (!sliderRef.current || snapshots.length === 0) return;
    
    const rect = sliderRef.current.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const percentage = Math.max(0, Math.min(1, x / rect.width));
    const index = Math.round(percentage * (snapshots.length - 1));
    onSeek(index);
  };
  
  const progress = snapshots.length > 1 
    ? (currentIndex / (snapshots.length - 1)) * 100 
    : 0;
  
  return (
    <div 
      ref={sliderRef}
      className="timeline-slider"
      onMouseDown={handleMouseDown}
      onMouseMove={handleMouseMove}
      onMouseUp={handleMouseUp}
      onMouseLeave={handleMouseUp}
    >
      {/* Track */}
      <div className="slider-track">
        <div 
          className="slider-progress" 
          style={{ width: `${progress}%` }}
        />
      </div>
      
      {/* Markers */}
      <div className="slider-markers">
        {snapshots.map((snapshot, i) => (
          <div
            key={snapshot.id}
            className={`slider-marker ${i === currentIndex ? 'current' : ''} ${i < currentIndex ? 'past' : ''}`}
            style={{ left: `${(i / (snapshots.length - 1 || 1)) * 100}%` }}
            onClick={() => onSeek(i)}
            title={`${snapshot.action} - ${formatTime(snapshot.timestamp)}`}
          >
            <div className="marker-dot" />
            {i % 5 === 0 && (
              <span className="marker-label">{i}</span>
            )}
          </div>
        ))}
      </div>
      
      {/* Thumb */}
      <div 
        className="slider-thumb"
        style={{ left: `${progress}%` }}
      >
        <Clock size={12} />
      </div>
    </div>
  );
}

// ============================================
// Branch Selector
// ============================================

interface Branch {
  id: string;
  name: string;
  isActive: boolean;
}

function BranchSelector() {
  const [isOpen, setIsOpen] = useState(false);
  const [branches, setBranches] = useState<Branch[]>([
    { id: 'main', name: 'Main', isActive: true },
    { id: 'experiment-1', name: 'Experiment 1', isActive: false },
  ]);
  
  const activeBranch = branches.find(b => b.isActive);
  
  const switchBranch = (id: string) => {
    setBranches(prev => prev.map(b => ({ ...b, isActive: b.id === id })));
    setIsOpen(false);
  };
  
  return (
    <div className="branch-selector">
      <button 
        className="branch-btn"
        onClick={() => setIsOpen(!isOpen)}
      >
        <GitBranch size={14} />
        <span>{activeBranch?.name || 'Main'}</span>
        <ChevronDown size={12} />
      </button>
      
      {isOpen && (
        <div className="branch-dropdown">
          {branches.map(branch => (
            <button
              key={branch.id}
              className={`branch-item ${branch.isActive ? 'active' : ''}`}
              onClick={() => switchBranch(branch.id)}
            >
              <GitBranch size={12} />
              {branch.name}
            </button>
          ))}
          <div className="branch-divider" />
          <button className="branch-item new">
            + New Branch
          </button>
        </div>
      )}
    </div>
  );
}

// ============================================
// Main Timeline Component
// ============================================

export default function Timeline() {
  const { canUndo, canRedo, historyCount, setCanUndo, setCanRedo, setHistoryCount } = useStore();
  
  // Simulated timeline data
  const [snapshots, setSnapshots] = useState<TimelineSnapshot[]>([
    { id: '1', index: 0, action: 'Initial', timestamp: new Date(Date.now() - 300000), isCurrent: false },
    { id: '2', index: 1, action: 'Changed font', timestamp: new Date(Date.now() - 240000), isCurrent: false },
    { id: '3', index: 2, action: 'Applied gradient', timestamp: new Date(Date.now() - 180000), isCurrent: false },
    { id: '4', index: 3, action: 'Added shadow', timestamp: new Date(Date.now() - 120000), isCurrent: false },
    { id: '5', index: 4, action: 'Adjusted colors', timestamp: new Date(Date.now() - 60000), isCurrent: true },
  ]);
  
  const [currentIndex, setCurrentIndex] = useState(4);
  const [isPlaying, setIsPlaying] = useState(false);
  
  // Update store state
  useEffect(() => {
    setCanUndo(currentIndex > 0);
    setCanRedo(currentIndex < snapshots.length - 1);
    setHistoryCount(snapshots.length);
  }, [currentIndex, snapshots.length]);
  
  // Timeline controls
  const handleUndo = () => {
    if (currentIndex > 0) {
      setCurrentIndex(currentIndex - 1);
    }
  };
  
  const handleRedo = () => {
    if (currentIndex < snapshots.length - 1) {
      setCurrentIndex(currentIndex + 1);
    }
  };
  
  const handleRewind = () => {
    setCurrentIndex(0);
  };
  
  const handleFastForward = () => {
    setCurrentIndex(snapshots.length - 1);
  };
  
  const handleSeek = (index: number) => {
    setCurrentIndex(index);
    setSnapshots(prev => prev.map((s, i) => ({ ...s, isCurrent: i === index })));
  };
  
  const handlePlayPause = () => {
    setIsPlaying(!isPlaying);
  };
  
  // Auto-play through history
  useEffect(() => {
    if (!isPlaying) return;
    
    const timer = setInterval(() => {
      setCurrentIndex(prev => {
        if (prev >= snapshots.length - 1) {
          setIsPlaying(false);
          return prev;
        }
        return prev + 1;
      });
    }, 500);
    
    return () => clearInterval(timer);
  }, [isPlaying, snapshots.length]);
  
  return (
    <div className="timeline-panel">
      {/* Timeline Header */}
      <div className="timeline-header">
        <div className="timeline-title">
          <Clock size={14} />
          <span>Timeline</span>
          <span className="history-count">{snapshots.length} snapshots</span>
        </div>
        
        <BranchSelector />
      </div>
      
      {/* Timeline Controls */}
      <div className="timeline-controls">
        <div className="control-group">
          <button 
            className="control-btn"
            onClick={handleRewind}
            disabled={currentIndex === 0}
            title="Rewind to start"
          >
            <Rewind size={16} />
          </button>
          
          <button 
            className="control-btn"
            onClick={handleUndo}
            disabled={!canUndo}
            title="Undo (Ctrl+Z)"
          >
            <Undo2 size={16} />
          </button>
          
          <button 
            className="control-btn play-btn"
            onClick={handlePlayPause}
            title={isPlaying ? 'Pause' : 'Play through history'}
          >
            {isPlaying ? <Pause size={18} /> : <Play size={18} />}
          </button>
          
          <button 
            className="control-btn"
            onClick={handleRedo}
            disabled={!canRedo}
            title="Redo (Ctrl+Shift+Z)"
          >
            <Redo2 size={16} />
          </button>
          
          <button 
            className="control-btn"
            onClick={handleFastForward}
            disabled={currentIndex === snapshots.length - 1}
            title="Fast forward to end"
          >
            <FastForward size={16} />
          </button>
        </div>
        
        <div className="control-group">
          <button className="control-btn" title="Save checkpoint">
            <Save size={14} />
          </button>
          <button className="control-btn" title="Clear history">
            <Trash2 size={14} />
          </button>
          <button className="control-btn" title="Reset">
            <RotateCcw size={14} />
          </button>
        </div>
      </div>
      
      {/* Timeline Slider */}
      <TimelineSlider
        snapshots={snapshots}
        currentIndex={currentIndex}
        onSeek={handleSeek}
      />
      
      {/* Current Action Display */}
      <div className="timeline-current">
        <span className="current-index">
          Step {currentIndex + 1} of {snapshots.length}
        </span>
        <span className="current-action">
          {snapshots[currentIndex]?.action}
        </span>
        <span className="current-time">
          {formatTime(snapshots[currentIndex]?.timestamp)}
        </span>
      </div>
    </div>
  );
}

// ============================================
// Helpers
// ============================================

function formatTime(date?: Date): string {
  if (!date) return '';
  
  const now = new Date();
  const diff = now.getTime() - date.getTime();
  
  if (diff < 60000) return 'Just now';
  if (diff < 3600000) return `${Math.floor(diff / 60000)}m ago`;
  if (diff < 86400000) return `${Math.floor(diff / 3600000)}h ago`;
  return date.toLocaleDateString();
}
