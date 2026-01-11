/**
 * Left Panel - Project Browser, Font Library, Palette Picker, Effect Controls
 */

import React, { useState } from 'react';
import { useStore } from '../../store';
import {
  Folder,
  Type,
  Palette,
  Sparkles,
  Search,
  Star,
  StarOff,
  Plus,
  ChevronRight,
  Clock,
  FileText,
  Filter,
} from 'lucide-react';

// ============================================
// Font Data
// ============================================

const FONTS = [
  { id: 'Standard', name: 'Standard', category: 'sans', preview: '█▀█' },
  { id: 'Banner', name: 'Banner', category: 'display', preview: '███' },
  { id: 'Big', name: 'Big', category: 'display', preview: '██▀' },
  { id: 'Block', name: 'Block', category: 'block', preview: '▓█▓' },
  { id: 'Bubble', name: 'Bubble', category: 'rounded', preview: '○●○' },
  { id: 'Digital', name: 'Digital', category: 'tech', preview: '▐█▌' },
  { id: 'Doom', name: 'Doom', category: 'display', preview: '▄█▄' },
  { id: 'Epic', name: 'Epic', category: 'display', preview: '▀█▀' },
  { id: 'Graffiti', name: 'Graffiti', category: 'artistic', preview: '▒█▒' },
  { id: 'Isometric1', name: 'Isometric 1', category: '3d', preview: '╱█╲' },
  { id: 'Isometric3', name: 'Isometric 3', category: '3d', preview: '╲█╱' },
  { id: 'Larry 3D', name: 'Larry 3D', category: '3d', preview: '▛█▟' },
  { id: 'Letters', name: 'Letters', category: 'serif', preview: 'ABC' },
  { id: 'Pebbles', name: 'Pebbles', category: 'artistic', preview: '°•°' },
  { id: 'Puffy', name: 'Puffy', category: 'rounded', preview: '◖●◗' },
  { id: 'Roman', name: 'Roman', category: 'serif', preview: 'ⅠⅡⅢ' },
  { id: 'Script', name: 'Script', category: 'script', preview: '~∿~' },
  { id: 'Shadow', name: 'Shadow', category: 'effect', preview: '▓▒░' },
  { id: 'Slant', name: 'Slant', category: 'italic', preview: '⁄█⁄' },
  { id: 'Small', name: 'Small', category: 'compact', preview: '▪▫▪' },
  { id: 'Speed', name: 'Speed', category: 'dynamic', preview: '»»»' },
  { id: 'Star Wars', name: 'Star Wars', category: 'themed', preview: '★☆★' },
  { id: 'Stop', name: 'Stop', category: 'block', preview: '▣▣▣' },
  { id: 'Straight', name: 'Straight', category: 'geometric', preview: '│█│' },
  { id: '3D-ASCII', name: '3D-ASCII', category: '3d', preview: '▛▀▜' },
  { id: 'ANSI Shadow', name: 'ANSI Shadow', category: 'effect', preview: '█▀▀' },
  { id: 'Bloody', name: 'Bloody', category: 'horror', preview: '▓█▓' },
  { id: 'Elite', name: 'Elite', category: 'tech', preview: '▄▀▄' },
  { id: 'Impossible', name: 'Impossible', category: '3d', preview: '◢█◣' },
  { id: 'Colossal', name: 'Colossal', category: 'display', preview: '███' },
];

// ============================================
// Palette Data
// ============================================

const PALETTES = [
  { id: 'borg', name: 'Borg', colors: ['#00ff00', '#00cc00', '#009900'], category: 'dark' },
  { id: 'sunset', name: 'Sunset', colors: ['#ff9966', '#ff5e62', '#ff3366'], category: 'warm' },
  { id: 'ocean', name: 'Ocean', colors: ['#00b4db', '#0083b0', '#005f73'], category: 'cool' },
  { id: 'fire', name: 'Fire', colors: ['#ff0000', '#ff4400', '#ff8800'], category: 'warm' },
  { id: 'neon', name: 'Neon', colors: ['#00ffff', '#ff00ff', '#ffff00'], category: 'neon' },
  { id: 'retro', name: 'Retro', colors: ['#ff00ff', '#8b00ff', '#0088ff'], category: 'retro' },
  { id: 'minimal', name: 'Minimal', colors: ['#ffffff', '#cccccc', '#999999'], category: 'mono' },
  { id: 'hacker', name: 'Hacker', colors: ['#33ff33', '#22cc22', '#119911'], category: 'dark' },
  { id: 'rainbow', name: 'Rainbow', colors: ['#ff0000', '#ff8800', '#ffff00', '#00ff00', '#0088ff', '#8800ff'], category: 'multi' },
  { id: 'cyberpunk', name: 'Cyberpunk', colors: ['#ff0066', '#cc00ff', '#6600ff'], category: 'neon' },
  { id: 'nature', name: 'Nature', colors: ['#228b22', '#2e8b57', '#3cb371'], category: 'green' },
  { id: 'corporate', name: 'Corporate', colors: ['#1a73e8', '#174ea6', '#0d47a1'], category: 'blue' },
];

// ============================================
// Projects Tab
// ============================================

function ProjectsTab() {
  const { currentProject, setCurrentProject } = useStore();
  
  const recentProjects = [
    { id: '1', name: 'SVONY Logo', updatedAt: '2 hours ago' },
    { id: '2', name: 'Gaming Banner', updatedAt: 'Yesterday' },
    { id: '3', name: 'Tech Header', updatedAt: '3 days ago' },
  ];
  
  return (
    <div className="panel-section">
      <div className="section-header">
        <Clock size={14} />
        <span>Recent Projects</span>
      </div>
      
      <div className="project-list">
        {recentProjects.map(project => (
          <div 
            key={project.id} 
            className={`project-item ${currentProject?.id === project.id ? 'active' : ''}`}
            onClick={() => setCurrentProject(project as any)}
          >
            <FileText size={14} />
            <div className="project-info">
              <span className="project-name">{project.name}</span>
              <span className="project-date">{project.updatedAt}</span>
            </div>
            <ChevronRight size={14} />
          </div>
        ))}
      </div>
      
      <button className="new-project-btn">
        <Plus size={14} />
        New Project
      </button>
    </div>
  );
}

// ============================================
// Fonts Tab
// ============================================

function FontsTab() {
  const { currentDesign, setCurrentDesign } = useStore();
  const [search, setSearch] = useState('');
  const [category, setCategory] = useState('all');
  const [favorites, setFavorites] = useState<string[]>(['ANSI Shadow', 'Isometric1', '3D-ASCII']);
  
  const categories = ['all', 'sans', 'serif', 'display', '3d', 'block', 'effect', 'artistic'];
  
  const filteredFonts = FONTS.filter(font => {
    const matchesSearch = font.name.toLowerCase().includes(search.toLowerCase());
    const matchesCategory = category === 'all' || font.category === category;
    return matchesSearch && matchesCategory;
  });
  
  const toggleFavorite = (fontId: string) => {
    setFavorites(prev => 
      prev.includes(fontId) 
        ? prev.filter(f => f !== fontId)
        : [...prev, fontId]
    );
  };
  
  const selectFont = (fontId: string) => {
    if (currentDesign) {
      setCurrentDesign({ ...currentDesign, font: fontId });
    }
  };
  
  return (
    <div className="panel-section fonts-section">
      <div className="search-bar">
        <Search size={14} />
        <input
          type="text"
          placeholder="Search fonts..."
          value={search}
          onChange={e => setSearch(e.target.value)}
        />
      </div>
      
      <div className="category-filter">
        <Filter size={12} />
        <select value={category} onChange={e => setCategory(e.target.value)}>
          {categories.map(cat => (
            <option key={cat} value={cat}>
              {cat.charAt(0).toUpperCase() + cat.slice(1)}
            </option>
          ))}
        </select>
      </div>
      
      {favorites.length > 0 && (
        <div className="favorites-section">
          <div className="section-label">Favorites</div>
          <div className="font-chips">
            {favorites.map(fav => (
              <button
                key={fav}
                className={`font-chip ${currentDesign?.font === fav ? 'active' : ''}`}
                onClick={() => selectFont(fav)}
              >
                {fav}
              </button>
            ))}
          </div>
        </div>
      )}
      
      <div className="font-grid">
        {filteredFonts.map(font => (
          <div
            key={font.id}
            className={`font-card ${currentDesign?.font === font.id ? 'active' : ''}`}
            onClick={() => selectFont(font.id)}
          >
            <div className="font-preview">{font.preview}</div>
            <div className="font-name">{font.name}</div>
            <button
              className="favorite-btn"
              onClick={e => { e.stopPropagation(); toggleFavorite(font.id); }}
            >
              {favorites.includes(font.id) ? <Star size={12} /> : <StarOff size={12} />}
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}

// ============================================
// Palettes Tab
// ============================================

function PalettesTab() {
  const { currentDesign, setCurrentDesign } = useStore();
  const [search, setSearch] = useState('');
  const [category, setCategory] = useState('all');
  
  const categories = ['all', 'dark', 'warm', 'cool', 'neon', 'mono', 'multi'];
  
  const filteredPalettes = PALETTES.filter(palette => {
    const matchesSearch = palette.name.toLowerCase().includes(search.toLowerCase());
    const matchesCategory = category === 'all' || palette.category === category;
    return matchesSearch && matchesCategory;
  });
  
  const selectPalette = (colors: string[]) => {
    if (currentDesign) {
      setCurrentDesign({ ...currentDesign, palette: colors });
    }
  };
  
  return (
    <div className="panel-section palettes-section">
      <div className="search-bar">
        <Search size={14} />
        <input
          type="text"
          placeholder="Search palettes..."
          value={search}
          onChange={e => setSearch(e.target.value)}
        />
      </div>
      
      <div className="category-filter">
        <Filter size={12} />
        <select value={category} onChange={e => setCategory(e.target.value)}>
          {categories.map(cat => (
            <option key={cat} value={cat}>
              {cat.charAt(0).toUpperCase() + cat.slice(1)}
            </option>
          ))}
        </select>
      </div>
      
      <div className="palette-grid">
        {filteredPalettes.map(palette => (
          <div
            key={palette.id}
            className={`palette-card ${JSON.stringify(currentDesign?.palette) === JSON.stringify(palette.colors) ? 'active' : ''}`}
            onClick={() => selectPalette(palette.colors)}
          >
            <div className="palette-preview">
              {palette.colors.map((color, i) => (
                <div
                  key={i}
                  className="color-swatch"
                  style={{ backgroundColor: color }}
                />
              ))}
            </div>
            <div className="palette-name">{palette.name}</div>
          </div>
        ))}
      </div>
      
      <button className="custom-palette-btn">
        <Plus size={14} />
        Custom Palette
      </button>
    </div>
  );
}

// ============================================
// Effects Tab
// ============================================

function EffectsTab() {
  const { currentDesign, setCurrentDesign } = useStore();
  
  const [shadow, setShadow] = useState({ enabled: false, color: '#000000', x: 2, y: 2, blur: 0 });
  const [outline, setOutline] = useState({ enabled: false, color: '#ffffff', width: 1 });
  const [glow, setGlow] = useState({ enabled: false, color: '#00ff00', intensity: 0.5, spread: 3 });
  
  return (
    <div className="panel-section effects-section">
      {/* Shadow Controls */}
      <div className="effect-group">
        <div className="effect-header">
          <label>
            <input
              type="checkbox"
              checked={shadow.enabled}
              onChange={e => setShadow({ ...shadow, enabled: e.target.checked })}
            />
            Shadow
          </label>
        </div>
        {shadow.enabled && (
          <div className="effect-controls">
            <div className="control-row">
              <label>Color</label>
              <input type="color" value={shadow.color} onChange={e => setShadow({ ...shadow, color: e.target.value })} />
            </div>
            <div className="control-row">
              <label>Offset X</label>
              <input type="range" min="-10" max="10" value={shadow.x} onChange={e => setShadow({ ...shadow, x: +e.target.value })} />
              <span>{shadow.x}px</span>
            </div>
            <div className="control-row">
              <label>Offset Y</label>
              <input type="range" min="-10" max="10" value={shadow.y} onChange={e => setShadow({ ...shadow, y: +e.target.value })} />
              <span>{shadow.y}px</span>
            </div>
          </div>
        )}
      </div>
      
      {/* Outline Controls */}
      <div className="effect-group">
        <div className="effect-header">
          <label>
            <input
              type="checkbox"
              checked={outline.enabled}
              onChange={e => setOutline({ ...outline, enabled: e.target.checked })}
            />
            Outline
          </label>
        </div>
        {outline.enabled && (
          <div className="effect-controls">
            <div className="control-row">
              <label>Color</label>
              <input type="color" value={outline.color} onChange={e => setOutline({ ...outline, color: e.target.value })} />
            </div>
            <div className="control-row">
              <label>Width</label>
              <input type="range" min="1" max="5" value={outline.width} onChange={e => setOutline({ ...outline, width: +e.target.value })} />
              <span>{outline.width}px</span>
            </div>
          </div>
        )}
      </div>
      
      {/* Glow Controls */}
      <div className="effect-group">
        <div className="effect-header">
          <label>
            <input
              type="checkbox"
              checked={glow.enabled}
              onChange={e => setGlow({ ...glow, enabled: e.target.checked })}
            />
            Glow
          </label>
        </div>
        {glow.enabled && (
          <div className="effect-controls">
            <div className="control-row">
              <label>Color</label>
              <input type="color" value={glow.color} onChange={e => setGlow({ ...glow, color: e.target.value })} />
            </div>
            <div className="control-row">
              <label>Intensity</label>
              <input type="range" min="0" max="1" step="0.1" value={glow.intensity} onChange={e => setGlow({ ...glow, intensity: +e.target.value })} />
              <span>{glow.intensity}</span>
            </div>
            <div className="control-row">
              <label>Spread</label>
              <input type="range" min="1" max="20" value={glow.spread} onChange={e => setGlow({ ...glow, spread: +e.target.value })} />
              <span>{glow.spread}px</span>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

// ============================================
// Main Left Panel
// ============================================

export default function LeftPanel() {
  const { sidebarTab, setSidebarTab } = useStore();
  
  return (
    <div className="left-panel">
      {/* Tab Header */}
      <div className="left-panel-tabs">
        <button
          className={`tab-btn ${sidebarTab === 'projects' ? 'active' : ''}`}
          onClick={() => setSidebarTab('projects')}
          title="Projects"
        >
          <Folder size={16} />
        </button>
        <button
          className={`tab-btn ${sidebarTab === 'fonts' ? 'active' : ''}`}
          onClick={() => setSidebarTab('fonts')}
          title="Fonts"
        >
          <Type size={16} />
        </button>
        <button
          className={`tab-btn ${sidebarTab === 'palettes' ? 'active' : ''}`}
          onClick={() => setSidebarTab('palettes')}
          title="Palettes"
        >
          <Palette size={16} />
        </button>
        <button
          className={`tab-btn ${sidebarTab === 'effects' ? 'active' : ''}`}
          onClick={() => setSidebarTab('effects')}
          title="Effects"
        >
          <Sparkles size={16} />
        </button>
      </div>
      
      {/* Tab Content */}
      <div className="left-panel-content">
        {sidebarTab === 'projects' && <ProjectsTab />}
        {sidebarTab === 'fonts' && <FontsTab />}
        {sidebarTab === 'palettes' && <PalettesTab />}
        {sidebarTab === 'effects' && <EffectsTab />}
      </div>
    </div>
  );
}
