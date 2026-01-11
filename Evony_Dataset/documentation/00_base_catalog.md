# Flash / Evony Reverse-Engineering Repo Catalog (v2026-01-01)

This pack focuses on **Flash Player 11 era (2009–2013)** workflows: SWF inspection, AS3/ABC analysis, and **Local Shared Object (.sol / LSO)** decoding/editing with safe round-trips.

## How to read the ratings (0–10 ★)
- **10★**: best-in-class, actively maintained, directly useful for your pipeline
- **7–9★**: strong tool; might need wrappers or some modernization
- **4–6★**: niche / dated / partial; still useful as a reference or a component
- **0–3★**: low value for your goals (kept for completeness)

---

## A) MUST-HAVE (Core)

### 1) JPEXS Free Flash Decompiler (FFDec) — **9★**
**Link:** https://github.com/jindrapetrik/jpexs-decompiler  
**What it is:** Open source SWF decompiler/editor (extract resources, edit ActionScript, convert to FLA, etc.).  
**Why it matters for you:**
- Fast path to **understand and diff** Evony-era SWFs
- Lets you locate **SharedObject usage** patterns in scripts
**Best use-cases:**
- Build a “SWF evidence bundle” (resources + scripts + hashes)
- Identify SO keys, obfuscation layers, and version gates

### 2) RABCDAsm (AVM2/ABC assembler/disassembler) — **9★**
**Link:** https://github.com/CyberShadow/RABCDAsm  
**What it is:** AVM2 ABC disassembler/assembler toolchain used heavily in AS3 reversing.  
**Why it matters:**
- When decompilers struggle, ABC disassembly is the “truth layer”
- Great for controlled, minimal patches and round-trip diffs  
**Best use-cases:**
- Patch a method safely (small deltas)
- Recover structure when decompiler output is messy

### 3) rust-flash-lso — **10★**
**Link:** https://github.com/ruffle-rs/rust-flash-lso  
**What it is:** A **fast, safe** parser/encoder for Flash Local Shared Objects (LSO) and AMF0/AMF3.  
**Why it matters:**
- This is the cleanest foundation for a modern **config.sol editor**
- Rust = easy to ship as a single Windows binary + bindings  
**Best use-cases:**
- Build `soltool.exe` (decode/edit/encode)
- Add fuzz + corpus tests for “no corruption” guarantees

### 4) Py3AMF — **8★**
**Link:** https://github.com/StdCarrot/Py3AMF  
**What it is:** Python AMF library including **`sol.py`** to work with Flash `.sol` SharedObjects.  
**Why it matters:**
- Quick prototyping + rapid format experiments
- Useful for test fixtures / golden outputs  
**Best use-cases:**
- Make reference decoder to compare with Rust outputs
- Script bulk dumps of `.sol` files across drives

---

## B) HIGH VALUE (Strong Supporting Tools)

### 5) SWFTools — **7★**
**Link:** https://github.com/swftools/swftools  
**What it is:** Utility suite for reading/extracting/combining SWFs, dumping details, extracting assets.  
**Why it matters:**
- Great “Swiss-army knife” for batch operations + quick SWF introspection  
**Caveat:** repo states it hasn’t been actively developed for a long time, but still useful.

### 6) Ruffle — **7★**
**Link:** https://github.com/ruffle-rs/ruffle  
**What it is:** Flash Player emulator in Rust (desktop + web).  
**Why it matters for you (even if you use projector FP11):**
- Provides a modern, instrumentable runtime to test parsing and basic behavior
- Has a “scanner” for benchmarking SWF parsing against corpora

### 7) as3commons-bytecode — **7★**
**Link:** https://github.com/teotiographix/as3-commons-bytecode  
**What it is:** Library for reading/writing ActionScript bytecode structures.  
**Why it matters:**
- Useful for building automation around ABC analysis and transforms
- Good reference implementation for bytecode-level tools

---

## C) PLAYER / RUNTIME (Niche but Useful)

### 8) Lightspark — **5★**
**Link:** https://github.com/lightspark/lightspark  
**What it is:** Open-source Flash player implementation (focused on running content).  
**Why it’s here:** Useful for compatibility experiments and sandboxing.

### 9) Gnash — **4★**
**Link:** https://github.com/strk/gnash  
**What it is:** GNU Flash player (legacy).  
**Why it’s here:** Reference / legacy testing, not your primary path.

---

## D) “HIDDEN GEM” SEARCH TERMS (to find repos whose names don’t match)

Use these terms when searching GitHub (and your local stash) to find repos that *don’t* advertise “Flash/Evony” in the name:

- **LSO** / **Local Shared Object** / **sharedobject**
- **.sol** / **Flash cookies**
- **AMF0** / **AMF3** / **Action Message Format**
- **AVM2** / **ABC** / **bytecode** / **p-code**
- **deobfuscate** / **unpack** / **decrypt** / **loader**
- **NetConnection** / **NetStream** / **RTMP**

---

## Next Actions (recommended)
1. Add a new folder/module in your repo ecosystem: `tools/sol-toolkit/`
2. Implement **decode → edit → encode** with:
   - Rust core (rust-flash-lso) for correctness + speed
   - Python reference (Py3AMF) for cross-checking
3. Bake in safety:
   - Always backup originals
   - Deterministic round-trip tests on a corpus of `.sol` files
   - Emit “evidence zips” (hash manifest + JSON dumps + diffs)

See diagrams in `diagrams/`.
# Building a Robust config.sol Editor (Evony-era Flash Player 11)

## Problem
Evony (2009–2013) style clients commonly store settings and state in **Flash Local Shared Objects** (`.sol`).
A robust editor must be able to:
- **Decode** `.sol` reliably (AMF0/AMF3 structures)
- **Edit** values safely (schema-aware when possible)
- **Encode** back to `.sol` with **byte-accurate behavior** (or at least behaviorally identical)
- **Never corrupt** user data (always backup + validate)

## Recommended implementation (production-grade)
### Layer 1 — Core codec (Rust)
Use `rust-flash-lso` as the correctness base.
- Pros: fast, safe, portable, easy to bundle into a single Windows exe
- Output: decode to JSON (or msgpack) + metadata

### Layer 2 — Reference codec (Python)
Use `Py3AMF` (`sol.py`) as the “second opinion”.
- Pros: fast iteration
- Role: verify edge cases and generate fixtures

### Layer 3 — Editor semantics
Implement a structured editor model:
- **Typed fields** (bool/int/float/string/bytes/object/array)
- **Diff view** (before/after)
- **Profiles** (named presets of edits)
- **Constraints** (value ranges, enums, “must exist” flags)

### Layer 4 — Safety & evidence
- Always write new file: `config.sol.edited.<timestamp>.sol`
- Store backup: `config.sol.bak`
- Emit evidence:
  - `manifest.json` (hashes + sizes)
  - `dump.before.json` / `dump.after.json`
  - `diff.patch.json`
  - logs + version info

## CLI proposal (Windows-first)
`soltool.exe` subcommands:
- `scan <path>`  → find `.sol`
- `dump <file.sol> --json out.json`
- `edit <file.sol> --set key=value ...`
- `apply <file.sol> --patch patch.json`
- `validate <file.sol> --roundtrip`
- `pack <json> --out file.sol`

## GUI proposal
Two panes:
- left: tree view of AMF object graph
- right: value editor + hex viewer (for bytes)
Includes:
- search
- “recent files”
- profiles
- one-click restore

## Test strategy (this is what makes it *robust*)
1) **Golden corpus**: collect 50–500 real `.sol` files from different machines/sessions  
2) Round-trip test:
- decode → encode → decode
- ensure structural equality (+ stable ordering where needed)  
3) Fuzz:
- mutate keys/strings/arrays/bytes within safe bounds
- ensure decoder never crashes and encoder never emits invalid structure  
4) Behavior test:
- run the projector/client with edited file and compare state changes

See `diagrams/pipeline.svg`.
# Finding “Hidden Gem” Flash/LSO/AMF Repos (that don’t look like Flash projects)

## Why names lie
Many useful repos avoid “flash/swf” in the title (e.g., they’re described as:
- “AMF serializer”
- “bytecode tools”
- “binary format parser”
- “cookie decoder”
- “web archive tools”

## Search patterns that work

### A) GitHub search strings
Try combinations like:

- `lso parser amf3`
- `sharedobject decode amf0`
- `"Local Shared Object" rust`
- `".sol" "SharedObject" tool`
- `avm2 abc disassembler`
- `actionscript bytecode library`
- `netconnection rtmp protocol`

### B) “Negative” search to surface weird repos
- `amf3 -flash -swf` (find AMF projects that aren’t labeled Flash)
- `sharedobject -game -cookie` (find SO tools not framed as cookies)
- `abc bytecode -python -java` (force unusual languages)

### C) Local-drive search (Windows, fast)
Use ripgrep + Everything + targeted paths.

**Ripgrep examples:**
- Find `.sol` references in code:
  - `rg -n --hidden --no-ignore-vcs "\.sol\b|SharedObject\b|Local\s+SharedObject\b|AMF3\b|NetConnection\b" X:\your\repos`
- Find files literally named `config.sol`:
  - `rg --files X:\ | rg -i "config\.sol$"`

**Everything:**
- Search: `config.sol | *.sol | SharedObject | #SharedObjects`
- Filter by modified date to narrow to active profiles.

### D) Evidence-first workflow
When you find a candidate repo:
1) record URL + commit hash
2) run it on a sample `.sol`
3) compare outputs with your “reference” decoder (Py3AMF)
4) keep it only if it passes round-trip and doesn’t corrupt data

---

## Output you want from this process
A small, curated library of:
- 1–2 **core decoders**
- 1 **GUI editor**
- 1 **CLI batch tool**
- a repeatable test harness + corpus

That’s what gets you to “professional and correct”.
# How These Tools Fit *Your* Evony / RoboEvony / Svony Ecosystem

## Your current zip snapshot (high-level)
From the uploaded archives, **Svony** already includes multiple scripts and diagram generators (e.g. `generate_api_diagrams.py`, `generate_svg_examples.py`, etc.).
That means your ecosystem is already set up for:
- structured docs generation
- pipeline-oriented tooling

## Where to plug in `sol-toolkit`
### Option 1 — Svony as the “documentation + orchestration” host
- Add `tools/sol-toolkit/`
- Svony calls it to:
  - scan user profile folders (including Flash `#SharedObjects`)
  - dump `.sol` to JSON
  - generate docs + diagrams automatically

### Option 2 — RoboTool as the automation host
- Use `sol-toolkit` as an executable
- RoboTool invokes it as a “preflight” stage (backup + validate + apply patch)

## Suggested repo layout (Docker/WSL2-friendly, Windows-first)
```
/tools
  /sol-toolkit
    /core-rust
    /cli
    /gui
    /tests
    /corpus
/docs
  /flash
    01_repo_catalog.md
    02_sol_editor_blueprint.md
    03_hidden_gems_search_playbook.md
/diagrams
```

## Practical use-cases for Evony-era Flash
- Restore / migrate settings across machines
- Diff what changes after in-game actions (config evolution)
- Build “profile packs” (safe presets) for debugging and research
- Create regression tests for your reverse-engineered client behavior

## What I did NOT include
I avoided anything that would meaningfully help **cheat on live services** (e.g., botting instructions).
This package focuses on **file formats, offline analysis, toolchain building, and safe editing**.

See `diagrams/integration-blueprint.svg`.
