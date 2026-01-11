import React, { useState, useEffect, useCallback } from 'react';
import { Terminal, Code, Zap, Shield, Eye, Database, Play, Search, Brain, Target, AlertTriangle, ChevronRight, Folder, File, Settings, Users, Sword, Castle, Coins, FlaskConical, Bug, Sparkles, Download, Upload, RefreshCw, Copy, Check, X, Maximize2, Minimize2, Activity, Cpu, Network } from 'lucide-react';

// ============================================
// EVONY HACKING TOOLKIT - AI EXPLOIT STUDIO
// ============================================

// Complete encryption keys from extracted source
const EVONY_KEYS = {
  ACTION_KEY: 'TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}',
  ACTION_KEY_SL: 'TAO_{313-894*&*($*#-FDIU(430}_SL',
  USER_INFO_KEY: 'IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}',
  API_KEY: '9f758e2deccbe6244f734371b9642eda',
  XOR_KEY: 0xAA,
  GAME_KEY: 'EvonyGameKey2009',
  NETWORK_KEY: 'EvonyNetKey2009',
};

// Known game constants for exploit detection
const GAME_LIMITS = {
  MAX_SAFE_FOOD: 485000000,
  FOOD_FLIP_THRESHOLD: 999000000,
  MAX_SAFE_TROOP_SINGLE: 700000000,
  MAX_VALLEY_TRANSPORT: 495000000,
  WAVE_TROOP_COUNT: 33000,
  AMULET_TARGET_DAILY: 15000,
  CENTS_TARGET_DAILY: 20000,
};

// Bot commands parsed from Commands.as
const BOT_COMMANDS = [
  { name: 'attack', desc: 'Send attack to coordinates', params: 'x,y hero troops', category: 'army' },
  { name: 'reinforce', desc: 'Reinforce city/valley', params: 'x,y hero troops', category: 'army' },
  { name: 'scout', desc: 'Scout coordinates', params: 'x,y', category: 'army' },
  { name: 'transport', desc: 'Transport resources', params: 'x,y resources', category: 'trade' },
  { name: 'qcolony', desc: 'Colony operations', params: 'operation target', category: 'colony' },
  { name: 'qfarm', desc: 'Quick farm NPCs', params: 'level count', category: 'farming' },
  { name: 'build', desc: 'Build/upgrade building', params: 'building level', category: 'city' },
  { name: 'train', desc: 'Train troops', params: 'type amount', category: 'army' },
  { name: 'research', desc: 'Research technology', params: 'tech', category: 'tech' },
  { name: 'mail', desc: 'Send mail', params: 'player message', category: 'social' },
  { name: 'chat', desc: 'Send chat message', params: 'channel message', category: 'social' },
  { name: 'spin', desc: 'Spin wheel', params: '', category: 'items' },
  { name: 'openbox', desc: 'Open package', params: 'itemId', category: 'items' },
  { name: 'levy', desc: 'Levy from colony', params: 'type target', category: 'colony' },
  { name: 'abandon', desc: 'Abandon colony', params: 'target', category: 'colony' },
  { name: 'suppress', desc: 'Set suppression', params: 'troops target', category: 'colony' },
];

// Known exploits from script analysis
const KNOWN_EXPLOITS = [
  { name: 'Food Flip Glitch', severity: 'critical', desc: 'Food resets to 0 at 999M+', safeValue: '485M max', category: 'resource' },
  { name: 'Valley Amulet Farm', severity: 'high', desc: 'Intentional troop loss for amulets', gain: '25K amulets/day', category: 'farming' },
  { name: 'Troop Overflow', severity: 'critical', desc: 'Single troop type overflow bug', safeValue: '700M max per type', category: 'troop' },
  { name: 'Quest Commission Glitch', severity: 'medium', desc: 'Quest exploit for resources', gain: 'Varies', category: 'quest' },
  { name: 'Transport Limit Bypass', severity: 'medium', desc: 'Valley transport limit exploit', limit: '495M max', category: 'transport' },
  { name: 'Wheel Spin Automation', severity: 'low', desc: 'Automated wheel spinning', gain: '20K cents/day', category: 'items' },
];

// Sample scripts from the extracted files
const SAMPLE_SCRIPTS = [
  { name: '7of9_Borg_Attack', file: '7of9_1Borg_script.txt', category: 'attack', lines: 95 },
  { name: 'Food Glitch Counter', file: 'FoodGlitchCounterV1.2.txt', category: 'exploit', lines: 280 },
  { name: 'Fast Attack v6', file: 'fastattack_v6_LagFree.txt', category: 'attack', lines: 180 },
  { name: 'Valley Glitch', file: 'Glitchscript.txt', category: 'exploit', lines: 420 },
  { name: 'Account Builder Elite', file: 'AccountBuilderSnippetElite.1.txt', category: 'automation', lines: 650 },
  { name: 'NPC Farmer', file: 'advEvasion_for_RE.txt', category: 'farming', lines: 380 },
  { name: 'Colony Manager', file: 'Colony Script.txt', category: 'colony', lines: 150 },
  { name: 'Draft Finder', file: 'draftFinder_for_RE.txt', category: 'hero', lines: 390 },
];

// Main App Component
export default function EvonyHackerToolkit() {
  const [activeTab, setActiveTab] = useState('dashboard');
  const [selectedScript, setSelectedScript] = useState(null);
  const [scriptCode, setScriptCode] = useState('');
  const [aiPrompt, setAiPrompt] = useState('');
  const [aiResponse, setAiResponse] = useState('');
  const [isGenerating, setIsGenerating] = useState(false);
  const [exploitResults, setExploitResults] = useState([]);
  const [patternMatches, setPatternMatches] = useState([]);
  const [logs, setLogs] = useState([]);
  const [accounts, setAccounts] = useState([
    { id: 1, name: '7of9_Borg', server: 'na2', status: 'online', cities: 10 },
    { id: 2, name: 'QueenBorg', server: 'na2', status: 'online', cities: 8 },
    { id: 3, name: 'DroneAlpha', server: 'na2', status: 'offline', cities: 5 },
  ]);
  const [swarmStatus, setSwarmStatus] = useState({ active: false, agents: 0, tasks: 0 });

  // Add log entry
  const addLog = useCallback((message, type = 'info') => {
    const timestamp = new Date().toLocaleTimeString();
    setLogs(prev => [...prev.slice(-100), { timestamp, message, type }]);
  }, []);

  // Simulate AI script generation
  const generateScript = async () => {
    if (!aiPrompt.trim()) return;
    setIsGenerating(true);
    addLog(`AI Request: ${aiPrompt}`, 'ai');
    
    // Simulate AI response
    await new Promise(r => setTimeout(r, 1500));
    
    const generatedScript = `// AI Generated Script: ${aiPrompt}
// Generated: ${new Date().toISOString()}
// ============================================

setsilence true
echo "Starting: ${aiPrompt}"

// Variables
set targetCoord "500,500"
set troopType "cata"
set troopCount 33000

// Main execution loop
label mainLoop
  echo "Executing wave..."
  attack %targetCoord% bestHero %troopType%:%troopCount%
  wait 5000
  
  // Check for stop condition
  if {$c.cm.allTroop.catapult$ < 100000} goto exitScript
  
goto mainLoop

label exitScript
echo "Script complete!"
setsilence false
loop`;
    
    setAiResponse(generatedScript);
    setScriptCode(generatedScript);
    setIsGenerating(false);
    addLog('AI script generated successfully', 'success');
  };

  // Pattern analysis simulation
  const runPatternAnalysis = () => {
    addLog('Starting pattern analysis on source code...', 'info');
    
    const patterns = [
      { pattern: 'if (count > 999999999)', file: 'ResourceManager.as', line: 342, severity: 'critical', desc: 'Possible overflow check' },
      { pattern: 'troopBean.amount > MAX_TROOP', file: 'TroopCommands.as', line: 156, severity: 'high', desc: 'Troop limit validation' },
      { pattern: 'validateTransport(resources)', file: 'TradeCommands.as', line: 89, severity: 'medium', desc: 'Transport validation bypass' },
      { pattern: 'if (!isRateLimited())', file: 'ActionFactory.as', line: 234, severity: 'low', desc: 'Rate limit check' },
      { pattern: 'sessionToken == null', file: 'SecurityCommands.as', line: 45, severity: 'high', desc: 'Session validation gap' },
    ];
    
    setPatternMatches(patterns);
    addLog(`Found ${patterns.length} potential vulnerabilities`, 'warning');
  };

  // Exploit discovery simulation
  const runExploitDiscovery = () => {
    addLog('Running AI exploit discovery engine...', 'info');
    
    setTimeout(() => {
      setExploitResults(KNOWN_EXPLOITS);
      addLog(`Discovered ${KNOWN_EXPLOITS.length} exploits`, 'success');
    }, 2000);
  };

  // Tab Navigation
  const tabs = [
    { id: 'dashboard', label: 'Dashboard', icon: Activity },
    { id: 'scripts', label: 'Script Studio', icon: Code },
    { id: 'ai', label: 'AI Generator', icon: Brain },
    { id: 'exploits', label: 'Exploit Engine', icon: Bug },
    { id: 'swarm', label: 'Borg Swarm', icon: Users },
    { id: 'source', label: 'Source Browser', icon: Folder },
    { id: 'protocol', label: 'Protocol Analyzer', icon: Network },
    { id: 'crypto', label: 'Crypto Tools', icon: Shield },
  ];

  return (
    <div className="min-h-screen bg-[#0a0a0f] text-gray-100 font-mono overflow-hidden">
      {/* Animated Background Grid */}
      <div className="fixed inset-0 pointer-events-none opacity-10">
        <div className="absolute inset-0" style={{
          backgroundImage: `
            linear-gradient(rgba(0, 255, 136, 0.03) 1px, transparent 1px),
            linear-gradient(90deg, rgba(0, 255, 136, 0.03) 1px, transparent 1px)
          `,
          backgroundSize: '50px 50px'
        }} />
      </div>
      
      {/* Scanline Effect */}
      <div className="fixed inset-0 pointer-events-none opacity-[0.02]" style={{
        background: 'repeating-linear-gradient(0deg, transparent, transparent 2px, rgba(0,255,136,0.1) 2px, rgba(0,255,136,0.1) 4px)'
      }} />

      {/* Header */}
      <header className="relative z-10 border-b border-emerald-500/20 bg-black/80 backdrop-blur-xl">
        <div className="flex items-center justify-between px-6 py-4">
          <div className="flex items-center gap-4">
            <div className="relative">
              <div className="absolute -inset-1 bg-emerald-500/20 blur-xl rounded-full" />
              <div className="relative w-12 h-12 rounded-xl bg-gradient-to-br from-emerald-400 to-cyan-500 flex items-center justify-center">
                <Zap className="w-7 h-7 text-black" />
              </div>
            </div>
            <div>
              <h1 className="text-2xl font-black tracking-tight bg-gradient-to-r from-emerald-400 via-cyan-400 to-purple-400 bg-clip-text text-transparent">
                EVONY HACKER TOOLKIT
              </h1>
              <p className="text-xs text-emerald-500/60 tracking-widest">AI-POWERED EXPLOIT STUDIO v2.0</p>
            </div>
          </div>
          
          <div className="flex items-center gap-4">
            <div className="flex items-center gap-2 px-3 py-1.5 bg-emerald-500/10 rounded-full border border-emerald-500/20">
              <div className="w-2 h-2 rounded-full bg-emerald-400 animate-pulse" />
              <span className="text-xs text-emerald-400">CONNECTED</span>
            </div>
            <div className="text-xs text-gray-500">
              Keys: <span className="text-emerald-400">{Object.keys(EVONY_KEYS).length}</span> | 
              Scripts: <span className="text-cyan-400">{SAMPLE_SCRIPTS.length}</span> |
              Exploits: <span className="text-red-400">{KNOWN_EXPLOITS.length}</span>
            </div>
          </div>
        </div>
        
        {/* Tab Navigation */}
        <nav className="flex gap-1 px-4 pb-2 overflow-x-auto">
          {tabs.map(tab => (
            <button
              key={tab.id}
              onClick={() => setActiveTab(tab.id)}
              className={`flex items-center gap-2 px-4 py-2 rounded-lg text-sm font-medium transition-all whitespace-nowrap ${
                activeTab === tab.id
                  ? 'bg-emerald-500/20 text-emerald-400 border border-emerald-500/30'
                  : 'text-gray-400 hover:text-gray-200 hover:bg-white/5'
              }`}
            >
              <tab.icon className="w-4 h-4" />
              {tab.label}
            </button>
          ))}
        </nav>
      </header>

      {/* Main Content */}
      <main className="relative z-10 flex h-[calc(100vh-140px)]">
        {/* Left Sidebar - Scripts & Files */}
        <aside className="w-72 border-r border-emerald-500/10 bg-black/40 overflow-y-auto">
          <div className="p-4">
            <h3 className="text-xs font-bold text-emerald-500/60 tracking-widest mb-3 flex items-center gap-2">
              <Folder className="w-4 h-4" />
              SCRIPTS LIBRARY
            </h3>
            <div className="space-y-1">
              {SAMPLE_SCRIPTS.map((script, i) => (
                <button
                  key={i}
                  onClick={() => {
                    setSelectedScript(script);
                    setScriptCode(`// ${script.name}\n// File: ${script.file}\n// Lines: ${script.lines}\n\n// Loading script content...`);
                    addLog(`Loaded script: ${script.name}`, 'info');
                  }}
                  className={`w-full flex items-center gap-2 px-3 py-2 rounded-lg text-left text-sm transition-all ${
                    selectedScript?.name === script.name
                      ? 'bg-emerald-500/20 text-emerald-400 border border-emerald-500/30'
                      : 'text-gray-400 hover:text-gray-200 hover:bg-white/5'
                  }`}
                >
                  <File className="w-4 h-4 flex-shrink-0" />
                  <div className="flex-1 min-w-0">
                    <div className="truncate">{script.name}</div>
                    <div className="text-xs text-gray-600">{script.category} • {script.lines} lines</div>
                  </div>
                </button>
              ))}
            </div>
          </div>
          
          <div className="p-4 border-t border-emerald-500/10">
            <h3 className="text-xs font-bold text-cyan-500/60 tracking-widest mb-3 flex items-center gap-2">
              <Database className="w-4 h-4" />
              BOT COMMANDS
            </h3>
            <div className="space-y-1 max-h-60 overflow-y-auto">
              {BOT_COMMANDS.map((cmd, i) => (
                <div
                  key={i}
                  className="px-3 py-2 rounded-lg bg-white/5 hover:bg-white/10 cursor-pointer transition-all group"
                  onClick={() => {
                    setScriptCode(prev => prev + `\n${cmd.name} ${cmd.params}`);
                    addLog(`Added command: ${cmd.name}`, 'info');
                  }}
                >
                  <div className="flex items-center justify-between">
                    <code className="text-cyan-400 text-sm">{cmd.name}</code>
                    <span className="text-xs text-gray-600">{cmd.category}</span>
                  </div>
                  <div className="text-xs text-gray-500 mt-0.5">{cmd.desc}</div>
                </div>
              ))}
            </div>
          </div>
        </aside>

        {/* Main Content Area */}
        <div className="flex-1 flex flex-col overflow-hidden">
          {/* Dashboard Tab */}
          {activeTab === 'dashboard' && (
            <div className="flex-1 p-6 overflow-y-auto">
              <div className="grid grid-cols-4 gap-4 mb-6">
                {[
                  { label: 'Accounts Online', value: accounts.filter(a => a.status === 'online').length, icon: Users, color: 'emerald' },
                  { label: 'Scripts Loaded', value: SAMPLE_SCRIPTS.length, icon: Code, color: 'cyan' },
                  { label: 'Exploits Found', value: KNOWN_EXPLOITS.length, icon: Bug, color: 'red' },
                  { label: 'Keys Available', value: Object.keys(EVONY_KEYS).length, icon: Shield, color: 'purple' },
                ].map((stat, i) => (
                  <div key={i} className={`p-4 rounded-xl bg-${stat.color}-500/10 border border-${stat.color}-500/20`}>
                    <div className="flex items-center justify-between mb-2">
                      <stat.icon className={`w-5 h-5 text-${stat.color}-400`} />
                      <span className={`text-3xl font-black text-${stat.color}-400`}>{stat.value}</span>
                    </div>
                    <div className="text-xs text-gray-500">{stat.label}</div>
                  </div>
                ))}
              </div>
              
              {/* Quick Actions */}
              <div className="grid grid-cols-3 gap-4 mb-6">
                <button
                  onClick={runExploitDiscovery}
                  className="p-4 rounded-xl bg-gradient-to-br from-red-500/20 to-orange-500/10 border border-red-500/20 hover:border-red-500/40 transition-all group"
                >
                  <Bug className="w-8 h-8 text-red-400 mb-2 group-hover:scale-110 transition-transform" />
                  <div className="font-bold text-red-400">Run Exploit Discovery</div>
                  <div className="text-xs text-gray-500">AI-powered vulnerability scan</div>
                </button>
                
                <button
                  onClick={runPatternAnalysis}
                  className="p-4 rounded-xl bg-gradient-to-br from-purple-500/20 to-pink-500/10 border border-purple-500/20 hover:border-purple-500/40 transition-all group"
                >
                  <Search className="w-8 h-8 text-purple-400 mb-2 group-hover:scale-110 transition-transform" />
                  <div className="font-bold text-purple-400">Pattern Analysis</div>
                  <div className="text-xs text-gray-500">Scan source for loopholes</div>
                </button>
                
                <button
                  onClick={() => setActiveTab('ai')}
                  className="p-4 rounded-xl bg-gradient-to-br from-cyan-500/20 to-blue-500/10 border border-cyan-500/20 hover:border-cyan-500/40 transition-all group"
                >
                  <Brain className="w-8 h-8 text-cyan-400 mb-2 group-hover:scale-110 transition-transform" />
                  <div className="font-bold text-cyan-400">AI Script Generator</div>
                  <div className="text-xs text-gray-500">Create custom exploits</div>
                </button>
              </div>
              
              {/* Accounts Table */}
              <div className="rounded-xl bg-black/40 border border-emerald-500/10 overflow-hidden">
                <div className="px-4 py-3 border-b border-emerald-500/10 flex items-center justify-between">
                  <h3 className="font-bold text-emerald-400 flex items-center gap-2">
                    <Users className="w-4 h-4" />
                    Connected Accounts
                  </h3>
                  <button className="text-xs text-gray-400 hover:text-white flex items-center gap-1">
                    <RefreshCw className="w-3 h-3" />
                    Refresh
                  </button>
                </div>
                <table className="w-full">
                  <thead className="text-xs text-gray-500 border-b border-emerald-500/10">
                    <tr>
                      <th className="px-4 py-2 text-left">Account</th>
                      <th className="px-4 py-2 text-left">Server</th>
                      <th className="px-4 py-2 text-left">Status</th>
                      <th className="px-4 py-2 text-left">Cities</th>
                      <th className="px-4 py-2 text-left">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    {accounts.map(account => (
                      <tr key={account.id} className="border-b border-emerald-500/5 hover:bg-white/5">
                        <td className="px-4 py-3 font-medium">{account.name}</td>
                        <td className="px-4 py-3 text-gray-400">{account.server}</td>
                        <td className="px-4 py-3">
                          <span className={`inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs ${
                            account.status === 'online' ? 'bg-emerald-500/20 text-emerald-400' : 'bg-gray-500/20 text-gray-400'
                          }`}>
                            <div className={`w-1.5 h-1.5 rounded-full ${account.status === 'online' ? 'bg-emerald-400' : 'bg-gray-400'}`} />
                            {account.status}
                          </span>
                        </td>
                        <td className="px-4 py-3 text-cyan-400">{account.cities}</td>
                        <td className="px-4 py-3">
                          <div className="flex gap-2">
                            <button className="px-2 py-1 text-xs bg-emerald-500/20 text-emerald-400 rounded hover:bg-emerald-500/30">
                              Run Script
                            </button>
                            <button className="px-2 py-1 text-xs bg-cyan-500/20 text-cyan-400 rounded hover:bg-cyan-500/30">
                              View
                            </button>
                          </div>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}

          {/* Scripts Tab */}
          {activeTab === 'scripts' && (
            <div className="flex-1 flex flex-col">
              <div className="flex items-center justify-between px-4 py-3 border-b border-emerald-500/10 bg-black/40">
                <div className="flex items-center gap-4">
                  <h3 className="font-bold text-emerald-400">
                    {selectedScript ? selectedScript.name : 'Script Editor'}
                  </h3>
                  {selectedScript && (
                    <span className="text-xs text-gray-500">
                      {selectedScript.file} • {selectedScript.lines} lines
                    </span>
                  )}
                </div>
                <div className="flex gap-2">
                  <button className="px-3 py-1.5 text-sm bg-emerald-500/20 text-emerald-400 rounded-lg hover:bg-emerald-500/30 flex items-center gap-1">
                    <Play className="w-4 h-4" />
                    Run
                  </button>
                  <button className="px-3 py-1.5 text-sm bg-cyan-500/20 text-cyan-400 rounded-lg hover:bg-cyan-500/30 flex items-center gap-1">
                    <Download className="w-4 h-4" />
                    Export
                  </button>
                </div>
              </div>
              <div className="flex-1 relative">
                <textarea
                  value={scriptCode}
                  onChange={(e) => setScriptCode(e.target.value)}
                  className="absolute inset-0 w-full h-full p-4 bg-transparent text-emerald-100 font-mono text-sm resize-none focus:outline-none"
                  placeholder="// Enter or paste your script here...&#10;// Use commands from the sidebar&#10;// AI can generate scripts for you"
                  spellCheck={false}
                  style={{ lineHeight: '1.6' }}
                />
                {/* Line numbers overlay */}
                <div className="absolute left-0 top-0 w-10 h-full bg-black/40 border-r border-emerald-500/10 pointer-events-none">
                  <div className="p-4 text-xs text-gray-600 font-mono" style={{ lineHeight: '1.6' }}>
                    {scriptCode.split('\n').map((_, i) => (
                      <div key={i}>{i + 1}</div>
                    ))}
                  </div>
                </div>
              </div>
            </div>
          )}

          {/* AI Generator Tab */}
          {activeTab === 'ai' && (
            <div className="flex-1 flex flex-col p-6 overflow-y-auto">
              <div className="max-w-4xl mx-auto w-full">
                <div className="text-center mb-8">
                  <div className="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-gradient-to-br from-cyan-500 to-purple-500 mb-4">
                    <Brain className="w-8 h-8 text-white" />
                  </div>
                  <h2 className="text-2xl font-black bg-gradient-to-r from-cyan-400 to-purple-400 bg-clip-text text-transparent">
                    AI Script Generator
                  </h2>
                  <p className="text-gray-500 mt-2">Describe what you want to automate and let AI create the script</p>
                </div>
                
                <div className="space-y-4">
                  <div className="relative">
                    <textarea
                      value={aiPrompt}
                      onChange={(e) => setAiPrompt(e.target.value)}
                      placeholder="Example: Create a script that attacks NPC level 10 valleys in a loop, using catapults, and stops when catas fall below 100k..."
                      className="w-full h-32 p-4 bg-black/40 border border-cyan-500/20 rounded-xl text-white placeholder-gray-600 focus:outline-none focus:border-cyan-500/50 resize-none"
                    />
                    <button
                      onClick={generateScript}
                      disabled={isGenerating}
                      className="absolute bottom-4 right-4 px-4 py-2 bg-gradient-to-r from-cyan-500 to-purple-500 text-white font-bold rounded-lg hover:opacity-90 disabled:opacity-50 flex items-center gap-2"
                    >
                      {isGenerating ? (
                        <>
                          <RefreshCw className="w-4 h-4 animate-spin" />
                          Generating...
                        </>
                      ) : (
                        <>
                          <Sparkles className="w-4 h-4" />
                          Generate Script
                        </>
                      )}
                    </button>
                  </div>
                  
                  {/* Quick Prompts */}
                  <div className="flex flex-wrap gap-2">
                    {[
                      'Valley attack loop',
                      'Resource glitch automation',
                      'NPC farming optimization',
                      'Troop training scheduler',
                      'Colony management',
                      'Amulet farming bot',
                    ].map((prompt, i) => (
                      <button
                        key={i}
                        onClick={() => setAiPrompt(prompt)}
                        className="px-3 py-1 text-xs bg-white/5 text-gray-400 rounded-full hover:bg-white/10 hover:text-white transition-all"
                      >
                        {prompt}
                      </button>
                    ))}
                  </div>
                  
                  {/* Generated Response */}
                  {aiResponse && (
                    <div className="mt-6">
                      <div className="flex items-center justify-between mb-2">
                        <h4 className="font-bold text-emerald-400">Generated Script</h4>
                        <button
                          onClick={() => {
                            navigator.clipboard.writeText(aiResponse);
                            addLog('Script copied to clipboard', 'success');
                          }}
                          className="text-xs text-gray-400 hover:text-white flex items-center gap-1"
                        >
                          <Copy className="w-3 h-3" />
                          Copy
                        </button>
                      </div>
                      <pre className="p-4 bg-black/60 border border-emerald-500/20 rounded-xl overflow-x-auto text-sm text-emerald-100">
                        {aiResponse}
                      </pre>
                    </div>
                  )}
                </div>
              </div>
            </div>
          )}

          {/* Exploits Tab */}
          {activeTab === 'exploits' && (
            <div className="flex-1 p-6 overflow-y-auto">
              <div className="flex items-center justify-between mb-6">
                <h2 className="text-xl font-bold text-red-400 flex items-center gap-2">
                  <Bug className="w-6 h-6" />
                  Exploit Discovery Engine
                </h2>
                <button
                  onClick={runExploitDiscovery}
                  className="px-4 py-2 bg-red-500/20 text-red-400 rounded-lg hover:bg-red-500/30 flex items-center gap-2"
                >
                  <Search className="w-4 h-4" />
                  Scan for Exploits
                </button>
              </div>
              
              {/* Pattern Analysis Results */}
              {patternMatches.length > 0 && (
                <div className="mb-6">
                  <h3 className="font-bold text-purple-400 mb-3 flex items-center gap-2">
                    <Eye className="w-4 h-4" />
                    Pattern Analysis Results
                  </h3>
                  <div className="space-y-2">
                    {patternMatches.map((pattern, i) => (
                      <div key={i} className="p-3 bg-purple-500/10 border border-purple-500/20 rounded-lg">
                        <div className="flex items-center justify-between mb-1">
                          <code className="text-purple-300 text-sm">{pattern.pattern}</code>
                          <span className={`text-xs px-2 py-0.5 rounded-full ${
                            pattern.severity === 'critical' ? 'bg-red-500/20 text-red-400' :
                            pattern.severity === 'high' ? 'bg-orange-500/20 text-orange-400' :
                            pattern.severity === 'medium' ? 'bg-yellow-500/20 text-yellow-400' :
                            'bg-gray-500/20 text-gray-400'
                          }`}>
                            {pattern.severity}
                          </span>
                        </div>
                        <div className="text-xs text-gray-500">
                          {pattern.file}:{pattern.line} • {pattern.desc}
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              )}
              
              {/* Known Exploits */}
              <div className="grid grid-cols-2 gap-4">
                {exploitResults.length > 0 ? exploitResults.map((exploit, i) => (
                  <div key={i} className="p-4 bg-black/40 border border-red-500/20 rounded-xl hover:border-red-500/40 transition-all">
                    <div className="flex items-start justify-between mb-2">
                      <h4 className="font-bold text-red-400">{exploit.name}</h4>
                      <span className={`text-xs px-2 py-0.5 rounded-full ${
                        exploit.severity === 'critical' ? 'bg-red-500/20 text-red-400' :
                        exploit.severity === 'high' ? 'bg-orange-500/20 text-orange-400' :
                        exploit.severity === 'medium' ? 'bg-yellow-500/20 text-yellow-400' :
                        'bg-emerald-500/20 text-emerald-400'
                      }`}>
                        {exploit.severity}
                      </span>
                    </div>
                    <p className="text-sm text-gray-400 mb-3">{exploit.desc}</p>
                    <div className="flex items-center justify-between text-xs">
                      <span className="text-gray-600">{exploit.category}</span>
                      <span className="text-emerald-400">{exploit.safeValue || exploit.gain}</span>
                    </div>
                    <button
                      onClick={() => {
                        setActiveTab('ai');
                        setAiPrompt(`Create exploit script for: ${exploit.name} - ${exploit.desc}`);
                      }}
                      className="mt-3 w-full py-2 text-xs bg-red-500/20 text-red-400 rounded-lg hover:bg-red-500/30"
                    >
                      Generate Exploit Script
                    </button>
                  </div>
                )) : (
                  <div className="col-span-2 text-center py-12 text-gray-600">
                    <Bug className="w-12 h-12 mx-auto mb-4 opacity-50" />
                    <p>Click "Scan for Exploits" to discover vulnerabilities</p>
                  </div>
                )}
              </div>
            </div>
          )}

          {/* Borg Swarm Tab */}
          {activeTab === 'swarm' && (
            <div className="flex-1 p-6 overflow-y-auto">
              <div className="flex items-center justify-between mb-6">
                <h2 className="text-xl font-bold text-emerald-400 flex items-center gap-2">
                  <Users className="w-6 h-6" />
                  Borg Collective Swarm
                </h2>
                <button
                  onClick={() => {
                    setSwarmStatus({ active: !swarmStatus.active, agents: accounts.length, tasks: 12 });
                    addLog(swarmStatus.active ? 'Swarm deactivated' : 'Swarm activated', 'success');
                  }}
                  className={`px-4 py-2 rounded-lg flex items-center gap-2 ${
                    swarmStatus.active 
                      ? 'bg-red-500/20 text-red-400 hover:bg-red-500/30' 
                      : 'bg-emerald-500/20 text-emerald-400 hover:bg-emerald-500/30'
                  }`}
                >
                  {swarmStatus.active ? <X className="w-4 h-4" /> : <Play className="w-4 h-4" />}
                  {swarmStatus.active ? 'Stop Swarm' : 'Activate Swarm'}
                </button>
              </div>
              
              {/* Swarm Status */}
              <div className="grid grid-cols-3 gap-4 mb-6">
                <div className="p-4 bg-emerald-500/10 border border-emerald-500/20 rounded-xl text-center">
                  <div className="text-3xl font-black text-emerald-400">{swarmStatus.active ? swarmStatus.agents : 0}</div>
                  <div className="text-xs text-gray-500">Active Agents</div>
                </div>
                <div className="p-4 bg-cyan-500/10 border border-cyan-500/20 rounded-xl text-center">
                  <div className="text-3xl font-black text-cyan-400">{swarmStatus.active ? swarmStatus.tasks : 0}</div>
                  <div className="text-xs text-gray-500">Running Tasks</div>
                </div>
                <div className="p-4 bg-purple-500/10 border border-purple-500/20 rounded-xl text-center">
                  <div className="text-3xl font-black text-purple-400">{swarmStatus.active ? '98%' : '0%'}</div>
                  <div className="text-xs text-gray-500">Efficiency</div>
                </div>
              </div>
              
              {/* Swarm Tasks */}
              <div className="bg-black/40 border border-emerald-500/10 rounded-xl overflow-hidden">
                <div className="px-4 py-3 border-b border-emerald-500/10 flex items-center gap-2">
                  <Activity className="w-4 h-4 text-emerald-400" />
                  <h3 className="font-bold text-emerald-400">Swarm Task Queue</h3>
                </div>
                <div className="divide-y divide-emerald-500/5">
                  {[
                    { task: 'Valley Glitch Farming', account: '7of9_Borg', status: 'running', progress: 75 },
                    { task: 'NPC Farm Route', account: 'QueenBorg', status: 'running', progress: 42 },
                    { task: 'Resource Collection', account: 'DroneAlpha', status: 'queued', progress: 0 },
                    { task: 'Troop Training', account: '7of9_Borg', status: 'running', progress: 88 },
                    { task: 'Colony Levy', account: 'QueenBorg', status: 'completed', progress: 100 },
                  ].map((task, i) => (
                    <div key={i} className="px-4 py-3 flex items-center gap-4">
                      <div className={`w-2 h-2 rounded-full ${
                        task.status === 'running' ? 'bg-emerald-400 animate-pulse' :
                        task.status === 'completed' ? 'bg-cyan-400' : 'bg-gray-600'
                      }`} />
                      <div className="flex-1">
                        <div className="flex items-center justify-between mb-1">
                          <span className="font-medium">{task.task}</span>
                          <span className="text-xs text-gray-500">{task.account}</span>
                        </div>
                        <div className="h-1.5 bg-gray-800 rounded-full overflow-hidden">
                          <div 
                            className={`h-full transition-all ${
                              task.status === 'completed' ? 'bg-cyan-500' : 'bg-emerald-500'
                            }`}
                            style={{ width: `${task.progress}%` }}
                          />
                        </div>
                      </div>
                      <span className={`text-xs px-2 py-0.5 rounded-full ${
                        task.status === 'running' ? 'bg-emerald-500/20 text-emerald-400' :
                        task.status === 'completed' ? 'bg-cyan-500/20 text-cyan-400' :
                        'bg-gray-500/20 text-gray-400'
                      }`}>
                        {task.status}
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          )}

          {/* Crypto Tools Tab */}
          {activeTab === 'crypto' && (
            <div className="flex-1 p-6 overflow-y-auto">
              <h2 className="text-xl font-bold text-purple-400 flex items-center gap-2 mb-6">
                <Shield className="w-6 h-6" />
                Encryption Keys & Crypto Tools
              </h2>
              
              <div className="grid grid-cols-2 gap-4">
                {Object.entries(EVONY_KEYS).map(([key, value]) => (
                  <div key={key} className="p-4 bg-purple-500/10 border border-purple-500/20 rounded-xl">
                    <div className="flex items-center justify-between mb-2">
                      <span className="font-bold text-purple-400">{key}</span>
                      <button
                        onClick={() => {
                          navigator.clipboard.writeText(String(value));
                          addLog(`Copied ${key} to clipboard`, 'success');
                        }}
                        className="text-xs text-gray-400 hover:text-white"
                      >
                        <Copy className="w-4 h-4" />
                      </button>
                    </div>
                    <code className="text-sm text-gray-300 break-all">{String(value)}</code>
                  </div>
                ))}
              </div>
              
              {/* Game Limits */}
              <div className="mt-6">
                <h3 className="font-bold text-cyan-400 mb-3 flex items-center gap-2">
                  <AlertTriangle className="w-4 h-4" />
                  Critical Game Limits
                </h3>
                <div className="grid grid-cols-3 gap-4">
                  {Object.entries(GAME_LIMITS).map(([key, value]) => (
                    <div key={key} className="p-3 bg-cyan-500/10 border border-cyan-500/20 rounded-lg">
                      <div className="text-xs text-gray-500 mb-1">{key.replace(/_/g, ' ')}</div>
                      <div className="text-lg font-bold text-cyan-400">{value.toLocaleString()}</div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          )}

          {/* Source Browser Tab */}
          {activeTab === 'source' && (
            <div className="flex-1 p-6 overflow-y-auto">
              <h2 className="text-xl font-bold text-orange-400 flex items-center gap-2 mb-6">
                <Folder className="w-6 h-6" />
                Decompiled Source Browser
              </h2>
              
              <div className="grid grid-cols-2 gap-6">
                {/* AutoEvony Source */}
                <div className="bg-black/40 border border-orange-500/20 rounded-xl overflow-hidden">
                  <div className="px-4 py-3 border-b border-orange-500/10 bg-orange-500/10">
                    <h3 className="font-bold text-orange-400">AutoEvony2 Bot Source</h3>
                    <p className="text-xs text-gray-500">Complete bot decompiled source</p>
                  </div>
                  <div className="p-4 space-y-2">
                    {['cmds', 'common', 'event', 'gui', 'management', 'net', 'player', 'scripts'].map(folder => (
                      <div key={folder} className="flex items-center gap-2 px-3 py-2 bg-white/5 rounded-lg hover:bg-white/10 cursor-pointer">
                        <Folder className="w-4 h-4 text-orange-400" />
                        <span>autoevony/{folder}/</span>
                      </div>
                    ))}
                  </div>
                </div>
                
                {/* Client Source */}
                <div className="bg-black/40 border border-blue-500/20 rounded-xl overflow-hidden">
                  <div className="px-4 py-3 border-b border-blue-500/10 bg-blue-500/10">
                    <h3 className="font-bold text-blue-400">EvonyClient1921 Source</h3>
                    <p className="text-xs text-gray-500">Game client decompiled source</p>
                  </div>
                  <div className="p-4 space-y-2">
                    {['action', 'response', 'beans', 'constants', 'module', 'net', 'events'].map(folder => (
                      <div key={folder} className="flex items-center gap-2 px-3 py-2 bg-white/5 rounded-lg hover:bg-white/10 cursor-pointer">
                        <Folder className="w-4 h-4 text-blue-400" />
                        <span>com/evony/client/{folder}/</span>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
              
              {/* Key Files */}
              <div className="mt-6 bg-black/40 border border-emerald-500/20 rounded-xl overflow-hidden">
                <div className="px-4 py-3 border-b border-emerald-500/10">
                  <h3 className="font-bold text-emerald-400">Key Source Files</h3>
                </div>
                <div className="p-4 grid grid-cols-3 gap-2">
                  {[
                    { file: 'Commands.as', size: '112KB', desc: 'All bot commands' },
                    { file: 'Connection.as', size: '28KB', desc: 'Network protocol' },
                    { file: 'ResponseDispatcher.as', size: '434KB', desc: 'Server responses' },
                    { file: 'ActionFactory.as', size: '11KB', desc: 'Command factory' },
                    { file: 'ArmyCommands.as', size: '8KB', desc: 'Army operations' },
                    { file: 'SecurityCommands.as', size: '5KB', desc: 'Security/Auth' },
                  ].map((file, i) => (
                    <div key={i} className="p-3 bg-white/5 rounded-lg hover:bg-white/10 cursor-pointer">
                      <div className="flex items-center gap-2">
                        <File className="w-4 h-4 text-emerald-400" />
                        <span className="text-sm font-medium">{file.file}</span>
                      </div>
                      <div className="text-xs text-gray-500 mt-1">{file.size} • {file.desc}</div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          )}

          {/* Protocol Analyzer Tab */}
          {activeTab === 'protocol' && (
            <div className="flex-1 p-6 overflow-y-auto">
              <h2 className="text-xl font-bold text-pink-400 flex items-center gap-2 mb-6">
                <Network className="w-6 h-6" />
                Protocol Analyzer
              </h2>
              
              <div className="bg-black/40 border border-pink-500/20 rounded-xl overflow-hidden">
                <div className="px-4 py-3 border-b border-pink-500/10 flex items-center justify-between">
                  <h3 className="font-bold text-pink-400">AMF Command Structure</h3>
                  <button className="px-3 py-1 text-xs bg-pink-500/20 text-pink-400 rounded-lg hover:bg-pink-500/30">
                    Start Capture
                  </button>
                </div>
                <div className="p-4">
                  <table className="w-full text-sm">
                    <thead className="text-xs text-gray-500 border-b border-pink-500/10">
                      <tr>
                        <th className="px-3 py-2 text-left">Command</th>
                        <th className="px-3 py-2 text-left">Class</th>
                        <th className="px-3 py-2 text-left">Parameters</th>
                        <th className="px-3 py-2 text-left">Response</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-pink-500/5">
                      {[
                        { cmd: 'newArmy', cls: 'ArmyCommands', params: 'castleId, hero, troops, target', resp: 'ArmyResponse' },
                        { cmd: 'getResources', cls: 'CityCommands', params: 'castleId', resp: 'ResourceBean' },
                        { cmd: 'buyItem', cls: 'ShopCommands', params: 'itemId, count', resp: 'ItemResponse' },
                        { cmd: 'sendMail', cls: 'MailCommands', params: 'target, subject, body', resp: 'MailResponse' },
                        { cmd: 'upgradeTech', cls: 'TechCommand', params: 'castleId, techId', resp: 'TechResponse' },
                      ].map((cmd, i) => (
                        <tr key={i} className="hover:bg-white/5">
                          <td className="px-3 py-2 text-pink-400 font-mono">{cmd.cmd}</td>
                          <td className="px-3 py-2 text-gray-400">{cmd.cls}</td>
                          <td className="px-3 py-2 text-gray-500 text-xs">{cmd.params}</td>
                          <td className="px-3 py-2 text-cyan-400">{cmd.resp}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          )}
        </div>

        {/* Right Sidebar - Logs */}
        <aside className="w-80 border-l border-emerald-500/10 bg-black/40 flex flex-col">
          <div className="p-4 border-b border-emerald-500/10 flex items-center justify-between">
            <h3 className="text-xs font-bold text-emerald-500/60 tracking-widest flex items-center gap-2">
              <Terminal className="w-4 h-4" />
              ACTIVITY LOG
            </h3>
            <button 
              onClick={() => setLogs([])}
              className="text-xs text-gray-500 hover:text-white"
            >
              Clear
            </button>
          </div>
          <div className="flex-1 overflow-y-auto p-4 space-y-2">
            {logs.length === 0 ? (
              <div className="text-center text-gray-600 py-8">
                <Terminal className="w-8 h-8 mx-auto mb-2 opacity-50" />
                <p className="text-xs">No activity yet</p>
              </div>
            ) : (
              logs.map((log, i) => (
                <div key={i} className={`text-xs p-2 rounded-lg ${
                  log.type === 'success' ? 'bg-emerald-500/10 text-emerald-400' :
                  log.type === 'warning' ? 'bg-yellow-500/10 text-yellow-400' :
                  log.type === 'error' ? 'bg-red-500/10 text-red-400' :
                  log.type === 'ai' ? 'bg-purple-500/10 text-purple-400' :
                  'bg-white/5 text-gray-400'
                }`}>
                  <span className="text-gray-600 mr-2">[{log.timestamp}]</span>
                  {log.message}
                </div>
              ))
            )}
          </div>
        </aside>
      </main>
    </div>
  );
}
