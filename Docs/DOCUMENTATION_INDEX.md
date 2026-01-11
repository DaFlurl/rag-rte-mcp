# 📚 EVONY RTE - COMPLETE DOCUMENTATION INDEX

> **Master Index for All Documentation, Diagrams, and Resources**  
> **Project:** Evony Real-Time Engineering (RTE) + MCP Toolkit  
> **Version:** 2.0 | **Last Updated:** January 2026

---

## 🎯 Quick Navigation

| Section | Description | Priority |
|---------|-------------|----------|
| [Core Documentation](#core-documentation) | Essential guides and references | 🔴 CRITICAL |
| [Architecture Diagrams](#architecture-diagrams) | Visual system documentation | 🔴 CRITICAL |
| [Training & Models](#training--models) | LLM fine-tuning documentation | 🟠 HIGH |
| [Tool References](#tool-references) | MCP tools and capabilities | 🟠 HIGH |
| [Protocol Documentation](#protocol-documentation) | AMF3, packets, encryption | 🟡 MEDIUM |
| [Exploit Research](#exploit-research) | Vulnerability documentation | 🟡 MEDIUM |
| [Legacy Resources](#legacy-resources) | Historical documentation | 🟢 LOW |

---

## 📖 Core Documentation

### Primary References

| Document | Path | Lines | Description |
|----------|------|-------|-------------|
| **MASTER_RESOURCE_INDEX** | `Docs/MASTER_RESOURCE_INDEX.md` | 800 | Complete index of 20,000+ Evony files |
| **INTEGRATION_GUIDE** | `Docs/INTEGRATION_GUIDE.md` | 272 | System integration procedures |
| **API_REFERENCE** | `Docs/API_REFERENCE.md` | 350 | Complete API documentation |
| **COMMAND_REFERENCE** | `Docs/COMMAND_REFERENCE.md` | 400 | All 301+ game commands |
| **HACKING_TOOLKIT** | `Docs/HACKING_TOOLKIT.md` | 350 | Security research toolkit |
| **TROUBLESHOOTING** | `Docs/TROUBLESHOOTING.md` | 200 | Common issues and solutions |

### MCP Server Documentation

| Document | Path | Lines | Description |
|----------|------|-------|-------------|
| **MCP_SERVER_README** | `evony_rte/README.md` | 200 | MCP server overview |
| **CLAUDE_DESKTOP_ASSISTANCE** | `CLAUDE_DESKTOP_ASSISTANCE.md` | 150 | Claude Desktop integration |
| **EVONY_MCP_COMPLETE_AUDIT** | `EVONY_MCP_COMPLETE_AUDIT.md` | 300 | Full MCP audit report |
| **EVONY_MCP_GAP_ANALYSIS** | `EVONY_MCP_GAP_ANALYSIS.md` | 200 | Gap analysis and remediation |

### Bot Server Documentation

| Document | Path | Lines | Description |
|----------|------|-------|-------------|
| **Bot README** | `evony_bot/README.md` | 1517 | Complete bot documentation |
| **WORKING_EXPLOITS_GUIDE** | `evony_bot/WORKING_EXPLOITS_GUIDE.md` | 271 | Verified exploit guide |
| **EXPLOIT_FINDINGS_FINAL** | `evony_bot/EXPLOIT_FINDINGS_FINAL.md` | 150 | Research findings |
| **EXPLOIT_TEST_RESULTS** | `evony_bot/EXPLOIT_TEST_RESULTS.md` | 100 | Test results |

---

## 🎨 Architecture Diagrams

### System Diagrams (SVG)

| Diagram | Path | Description |
|---------|------|-------------|
| **SYSTEM_ARCHITECTURE** | `Docs/diagrams/SYSTEM_ARCHITECTURE.svg` | Complete system overview |
| **MCP_SERVER_FLOW** | `Docs/diagrams/MCP_SERVER_FLOW.svg` | MCP request/response flow |
| **AMF3_PROTOCOL** | `Docs/diagrams/AMF3_PROTOCOL.svg` | AMF3 encoding/decoding |
| **EXPLOIT_FRAMEWORK** | `Docs/diagrams/EXPLOIT_FRAMEWORK.svg` | Exploit execution pipeline |
| **RAG_ARCHITECTURE** | `Docs/diagrams/RAG_ARCHITECTURE.svg` | RAG system architecture |
| **LLM_TRAINING_PIPELINE** | `Docs/diagrams/LLM_TRAINING_PIPELINE.svg` | Training workflow |
| **PACKET_FLOW** | `Docs/diagrams/PACKET_FLOW.svg` | Network packet flow |
| **TOOL_ECOSYSTEM** | `Docs/diagrams/TOOL_ECOSYSTEM.svg` | Tools and integrations |
| **EVONY_CLIENT_STRUCTURE** | `Docs/diagrams/EVONY_CLIENT_STRUCTURE.svg` | Flash client architecture |
| **AUTOEVONY_INTEGRATION** | `Docs/diagrams/AUTOEVONY_INTEGRATION.svg` | AutoEvony bot integration |

### Architecture Documents

| Document | Path | Description |
|----------|------|-------------|
| **ARCHITECTURE** | `Docs/diagrams/ARCHITECTURE.md` | Detailed architecture specs |
| **CLIENT_STRUCTURE** | `Docs/CLIENT_STRUCTURE.md` | Client component analysis |
| **NETWORK_PROTOCOL** | `Docs/NETWORK_PROTOCOL.md` | Protocol specification |

---

## 🤖 Training & Models

### Model Documentation

| Document | Path | Description |
|----------|------|-------------|
| **LLM_TRAINING_COMPLETE** | `Docs/LLM_TRAINING_COMPLETE.md` | Full training documentation |
| **EPIC_TRAINING_PLAN** | `Docs/EPIC_TRAINING_PLAN.md` | Training strategy |
| **DATA_CURATION_REPORT** | `DATA_CURATION_REPORT.md` | Dataset curation report |
| **TRAINING_DATA_ACTION_PLAN** | `Docs/TRAINING_DATA_ACTION_PLAN.md` | Data preparation guide |

### Trained Models

| Model | Location | Size | Architecture | Training |
|-------|----------|------|--------------|----------|
| **Phase 4 - F16** | `phase4-h200/` | 15.24GB | Qwen-7B | 3800 iterations, F16 |
| **Phase 4 - Q8** | `phase4-h200/` | 8.10GB | Qwen-7B | Quantized Q8 |
| **Phase 4 - Q4** | `phase4-h200/` | 4.68GB | Qwen-7B | Quantized Q4 |

### Training Data Stats (Jan 2026)

| Category | Count |
|----------|-------|
| **Total Examples** | 766,822 |
| **Source Code** | 120,645 |
| **Script-Related** | 15,764 |
| **ActionScript** | 6,468 |
| **Protocol** | 3,530 |
| **Verified CVEs** | 1,358 |
| **Overflow Exploits** | 1,476 |

### Model Purpose
- ✅ Reverse engineering AS3/Flash (2009-2018)
- ✅ Script creation (Autoevony, Roboevony)
- ✅ Exploits, CVEs, packet editing
- ❌ NOT trained on gameplay

### Training Scripts

| Script | Path | GPU Target |
|--------|------|------------|
| `train_phase3_3090.py` | `phase3-3090/` | RTX 3090 24GB |
| `train_runpod_h200.py` | `evony_phase3/` | H200 SXM |
| `train_b200_fp16_epic.py` | `phase4-h200/` | B200 192GB |

---

## 🛠️ Tool References

### MCP Server Tools

#### Evony RTE MCP Server (55 handlers)
| Category | Count | Description |
|----------|-------|-------------|
| **Packet Tools** | 12 | Capture, decode, encode, inject, replay |
| **Game Tools** | 15 | Send, status, connect, resources, troops |
| **Exploit Tools** | 10 | List, test, scan, create, verify |
| **RE Tools** | 8 | FFDec, rabcdasm, Ghidra, radare2 |
| **Proxy Tools** | 6 | Start, stop, inject, intercept |
| **Utility Tools** | 4 | Various helpers |

#### Evony RAG MCP Server (8 tools) - Updated Jan 2026
| Tool | Purpose |
|------|---------|
| `evony.search` | Hybrid lexical+semantic search |
| `evony.answer` | LLM-generated answer |
| `evony.precision` | Verified answer with citations |
| `evony.feedback` | **NEW** Submit user feedback |
| `evony.open` | Read source file |
| `evony.symbol` | Find symbol |
| `evony.mode` | Set query mode |
| `evony.stats` | Get statistics |

### Tool Documentation

| Document | Path | Description |
|----------|------|-------------|
| **MCP_TOOLS_ACTION_PLAN** | `Docs/MCP_TOOLS_ACTION_PLAN.md` | Complete tool guide |
| **TOOLS_INDEX** | `Docs/tools/TOOLS_INDEX.md` | Tool reference index |
| **WINDSURF_CLAUDE_CAPABILITIES** | `Docs/WINDSURF_CLAUDE_CAPABILITIES.md` | IDE integration |

### LM Studio Integration (NEW Jan 2026)

| File | Path | Lines | Purpose |
|------|------|-------|---------|
| `lmstudio_control.py` | `evony_rte/` | 591 | Model switching, preset management |
| `lmstudio_manager.py` | `evony_rte/` | 1000+ | Full LM Studio manager |
| `mcp_lmstudio_tools.py` | `evony_rte/` | 400+ | MCP tools for LM Studio |
| `LMSTUDIO_CLAUDE_WINDSURF_ACCESS.md` | `Docs/` | 300+ | LM Studio access guide |
| `LMSTUDIO_F16_CONFIG.md` | `Docs/` | 900+ | Model configuration |

### LM Studio Presets (7 NEW)

| Preset | Temp | Use Case |
|--------|------|----------|
| `evony-master-expert.preset.json` | 0.4 | All-in-one expert |
| `evony-exploit-hunter.preset.json` | 0.2 | Vulnerability analysis |
| `evony-protocol-decoder.preset.json` | 0.1 | AMF3 binary decoding |
| `evony-code-auditor.preset.json` | 0.3 | AS3/bot code review |
| `evony-quick-reference.preset.json` | 0.5 | Fast lookups |
| `evony-forensic-analyst.preset.json` | 0.25 | Incident investigation |
| `evony-creative-writer.preset.json` | 0.7 | Documentation |

### Knowledge Graph Enhancement (NEW Jan 2026)

| File | Path | Purpose |
|------|------|---------|
| `enhanced_kg_extractor.py` | `evony_rag/` | Advanced relationship extraction |
| `rebuild_in_place.py` | `evony_rag/` | In-place KG rebuild |
| `rebuild_final.py` | `evony_rag/` | Final rebuild script |
| `rebuild_indices_full.py` | `evony_rag/` | Full index rebuild |
| `verify_indices.py` | `evony_rag/` | Index verification |
| `kg_full.json` | `evony_rag/index/knowledge_graph/` | 101,853 entities, 346,398 relationships |

### RAG System Files (Updated Jan 2026)

| File | Path | Purpose |
|------|------|---------|
| **precision_rag.py** | `evony_rag/` | Main RAG with verification, citations, confidence |
| **question_formatter.py** | `evony_rag/` | Transform vague questions to training format |
| **feedback_loop.py** | `evony_rag/` | User feedback collection for improvement |
| **reranker.py** | `evony_rag/` | Cross-encoder + heuristic reranking |
| **chroma_search.py** | `evony_rag/` | Optional ChromaDB vector search |
| **hybrid_search.py** | `evony_rag/` | Lexical + semantic search |
| **knowledge_graph.py** | `evony_rag/` | 101K entity knowledge graph |
| **gradio_ui.py** | `evony_rag/` | Web UI with feedback buttons |
| **mcp_server_v2.py** | `evony_rag/` | MCP server with 8 tools |

### RAG Benchmark Files

| File | Path | Purpose |
|------|------|---------|
| **comprehensive_benchmark.py** | `evony_rag/` | Full benchmark suite |
| **benchmark_natural.py** | `evony_rag/` | Natural user question tests |
| **benchmark_dataset.py** | `evony_rag/` | Training data format tests |
| **gap_analysis.py** | `evony_rag/` | Integration gap checker |

---

## 🔐 Protocol Documentation

### AMF3 & Network

| Document | Path | Description |
|----------|------|-------------|
| **EVONY_PROTOCOL** | `Docs/EVONY_PROTOCOL.md` | Protocol overview |
| **COMPLETE_PROTOCOL_REFERENCE** | `Docs/COMPLETE_PROTOCOL_REFERENCE.md` | All commands |
| **NETWORK_PROTOCOL** | `Docs/NETWORK_PROTOCOL.md` | Network layer |
| **SCHEMAS** | `Docs/SCHEMAS.md` | Data schemas |

### Protocol Subdirectory

| Document | Path | Description |
|----------|------|-------------|
| Protocol specs | `Docs/protocols/` | Detailed protocol files |
| Packet captures | `evony_rte/captures/` | Captured packets |

---

## 💀 Exploit Research

### Research Documents

| Document | Path | Description |
|----------|------|-------------|
| **HIDDEN_COMMANDS** | `Docs/HIDDEN_COMMANDS.md` | Undocumented commands |
| **SECURITY_VALIDATION_RULES** | `Docs/SECURITY_VALIDATION_RULES.md` | Validation bypasses |
| **CRITICAL_ENUM_ANALYSIS** | `Docs/CRITICAL_ENUM_ANALYSIS.md` | Enum vulnerabilities |

### CVE Research

| Document | Path | Description |
|----------|------|-------------|
| **CVE_README** | `CVE_Research/README.md` | CVE research overview |
| **CVE_ATTACK_SURFACE_DIAGRAM** | `CVE_Research/CVE_ATTACK_SURFACE_DIAGRAM.md` | Attack surface |
| **RESEARCH_SOURCES** | `CVE_Research/RESEARCH_SOURCES.md` | Source references |

### Exploit Subdirectory

| Document | Path | Description |
|----------|------|-------------|
| Exploit docs | `Docs/exploits/` | Detailed exploit files |
| BorgToolkit exploits | `BorgToolkit/docs/EXPLOITS.md` | Toolkit exploits |

---

## 📜 Legacy Resources

### AutoEvony Documentation

| Document | Path | Description |
|----------|------|-------------|
| **AUTOEVONY_SCRIPT_REFERENCE** | `Docs/AUTOEVONY_SCRIPT_REFERENCE.md` | Script commands |
| **AUTOEVONY_VS_CLIENT_ANALYSIS** | `Docs/AUTOEVONY_VS_CLIENT_ANALYSIS.md` | Comparison analysis |
| **BOT_SCRIPTING** | `Docs/BOT_SCRIPTING.md` | Bot scripting guide |

### Svony Studio Documentation

| Document | Path | Description |
|----------|------|-------------|
| **USER_GUIDE** | `Docs/svony_docs/USER_GUIDE.md` | User documentation |
| **TUTORIALS** | `Docs/svony_docs/TUTORIALS.md` | Tutorial collection |
| **ULTIMATE_SOURCE_ANALYSIS** | `Docs/svony_docs/ULTIMATE_SOURCE_ANALYSIS.md` | Source analysis |

### Game Data

| Document | Path | Description |
|----------|------|-------------|
| **TROOP_DATA** | `Docs/TROOP_DATA.md` | Troop statistics |
| **BATTLE_MECHANICS** | `Docs/BATTLE_MECHANICS.md` | Combat system |
| **NPC_FARMING** | `Docs/NPC_FARMING.md` | NPC strategies |
| **RESOURCES** | `Docs/RESOURCES.md` | Resource management |

---

## 📊 Statistics (Updated Jan 11, 2026)

### Documentation Metrics

| Metric | Value |
|--------|-------|
| **Total Markdown Files** | 60+ |
| **Total Lines of Documentation** | 55,000+ |
| **Total Diagrams** | 10+ |
| **Code Examples** | 500+ |
| **RAG Chunks** | 16,962 |
| **KG Entities** | 101,853 |
| **Training Examples** | 766,822 |
| **Commands Documented** | 301+ |

### RAG System Stats

| Component | Count |
|-----------|-------|
| Chunks | 16,962 |
| Embeddings | 16,962 x 768 dims |
| KG Entities | 101,853 |
| KG Relationships | 346,398 |
| MCP Tools | 8 |
| New Features (Jan 2026) | 5 |

### Coverage Matrix

```
┌─────────────────────────────────────────────────────────────────┐
│              DOCUMENTATION COVERAGE (Jan 11, 2026)               │
├──────────────────────┬────────────┬──────────────────────────────┤
│ Area                 │ Coverage   │ Status                       │
├──────────────────────┼────────────┼──────────────────────────────┤
│ MCP Server           │ 95%        │ ✅ Complete                  │
│ Bot Server           │ 95%        │ ✅ Complete                  │
│ Protocol/AMF3        │ 90%        │ ✅ Complete                  │
│ Exploits             │ 85%        │ ✅ Complete                  │
│ Training/Models      │ 90%        │ ✅ Updated Jan 2026          │
│ RAG System           │ 90%        │ ✅ Updated Jan 2026          │
│ RE Tools             │ 70%        │ 🟡 In Progress               │
│ Diagrams             │ 60%        │ 🟡 Needs Work                │
└──────────────────────┴────────────┴──────────────────────────────┘
```

### Benchmark Results (Jan 11, 2026)

| Metric | Score |
|--------|-------|
| Answer Rate | 60% |
| Grounded | 70% |
| Avg Confidence | 78% |
| Features Working | 100% (5/5) |
| **Overall** | **69% GOOD** |

---

## 🔗 Quick Links

### For Developers
- [MCP Server Setup](../evony_rte/README.md)
- [Bot Server Setup](../evony_bot/README.md)
- [API Reference](API_REFERENCE.md)
- [Tool Action Plans](MCP_TOOLS_ACTION_PLAN.md)

### For Researchers
- [Exploit Guide](../evony_bot/WORKING_EXPLOITS_GUIDE.md)
- [Protocol Reference](COMPLETE_PROTOCOL_REFERENCE.md)
- [Hidden Commands](HIDDEN_COMMANDS.md)
- [CVE Research](../CVE_Research/README.md)

### For AI/ML Engineers
- Training Documentation
- [Dataset Report](../DATA_CURATION_REPORT.md)
- [RAG Configuration](RAG_CAPABILITIES.md)

---

## 📝 Document Conventions

### Status Indicators
- ✅ **Complete** - Fully documented and verified
- 🟡 **In Progress** - Partial documentation
- 🔴 **Needs Work** - Missing or outdated
- ⚠️ **Deprecated** - No longer maintained

### Priority Levels
- 🔴 **CRITICAL** - Essential documentation
- 🟠 **HIGH** - Important reference material
- 🟡 **MEDIUM** - Useful but not essential
- 🟢 **LOW** - Historical or supplementary

---

*This index is automatically maintained. Last scan: January 2026*
