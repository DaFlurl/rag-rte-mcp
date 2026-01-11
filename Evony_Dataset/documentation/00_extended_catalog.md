# Extended Flash/AMF/LSO Toolkit — Hidden Gems & Lesser‑Known Projects

This catalogue expands upon the core toolset covered in the main report by surfacing **hard‑to‑find or deceptively named repositories**.  Each project is rated on a 0–10 ★ scale based on its relevance to Evony‑era reverse‑engineering and `.sol`/SWF manipulation workflows.  Where possible, the evaluation uses primary documentation from the project’s repository or homepage.

---

## A) Additional .SOL / AMF Codecs and Editors

| Tool | Rating | Evidence & Key Features | Why it’s useful |
|---|---|---|---|
| **SolVE** (Java LSO Viewer/Editor) | **7★** | SourceForge summary notes that SolVE is a **cross‑platform Local Shared Object viewer/editor written in Java using SWT**【993719178797030†L80-L83】. | Provides a GUI to open and edit Flash cookies; useful when you need a graphical workflow that works on Windows, macOS or Linux.  Can load `.sol` files from backups and update values manually. |
| **.sol Editor (Flash Shared Object)** | **6★** | SourceForge project description states that this tool **opens or creates a Macromedia Flash shared object (.sol), displays its contents and allows you to change the values**【314070883101429†L89-L93】. | Simple standalone editor for `.sol` files; good for quick manual tweaks but less feature rich than SolVE or FFDec. |
| **Parse::Flash::Cookie (Perl)** | **4★** | The CPAN readme explains that this Perl module **reads a Local Shared Object file and returns the content as a list**【237543142729523†L10-L14】. | Useful if you’re comfortable with Perl and need a quick parser; otherwise, better to rely on Rust or Python codecs. |
| **goamf** (Go AMF library) | **5★** | The project states that it is an **AMF library for Golang; only AMF3 is supported** and provides a `NewDecoder` API【879570906016723†L310-L334】. | Useful when building Go‑based tooling; can decode AMF3 structures but lacks AMF0 support. |
| **AMF.net** (C#) | **7★** | The README notes that AMF.net is an **implementation in C# of both AMF0 and AMF3** and includes sample code for serializing/deserializing packets plus an **Object Viewer** and **Fiddler Inspector**【293764369203095†L34-L92】. | Ideal for .NET ecosystems: integrate `.sol` decoding into C# apps, or use the object viewer for inspecting complex AMF objects. |
| **amf.js** (Pure JavaScript AMF library) | **6★** | A blog post introducing amf.js explains that it’s a **pure JavaScript implementation of AMF** using a custom ByteArray class; it supports both AMF0 and AMF3 and can decode objects in browsers without Flash【812540103757720†L49-L64】. | Useful for web‑based tools or when you need to decode AMF directly in the browser; can interface with BlazeDS servers for legacy endpoints. |

### Observations
* These tools are **language‑specific**: they’re valuable if you already work in that ecosystem or need to embed `.sol`/AMF parsing into non‑Python projects (e.g., .NET, Go, JS, Perl).
* **SolVE** and **.sol Editor** are GUI applications; they’re convenient for manual editing but lack automated validation and round‑trip testing.  When building a robust pipeline, treat them as *inspectors*, not as the main editing engine.

---

## B) SWF Parsing, Extraction & Decompilation

| Tool | Rating | Evidence & Key Features | Why it’s useful |
|---|---|---|---|
| **py3swf / pyswf** | **7★** | The README for Pyswf describes it as a **Python library for reading and writing SWF files** and notes that it’s a port of Claus Wahlers’ parser【779397042260553†L0-L6】.  The usage examples show how to load a SWF and even export it to SVG【779397042260553†L37-L70】. | Handy for inspecting and extracting resources (e.g., images, vector art) from the Evony game client.  You can automate SWF parsing in Python without using external decompilers. |
| **extract_swf** | **6★** | A Python script that **extracts potential SWF files from a Flash projector binary**; the README notes that it outputs a decompressed SWF file extracted from a provided binary【381585271803916†L0-L11】. | Useful for unpacking Flash projectors (`roboevony.exe`) to access the underlying SWF, which can then be decompiled by JPEXS or patched. |
| **YASWFP** (Yet Another SWF Parser) | **5★** | A GitHub project aimed at parsing SWF; details are scarce because the repository is archived and lacks a detailed README. | Could serve as an alternative parser; but given lack of documentation, treat as a reference rather than primary tool. |
| **ABCd** (ActionScript Byte Code Disassembler) | **4★** | MITRE’s `abcd` repository is an **archived ActionScript bytecode disassembler**【668373833624499†L0-L27】.  It likely provides raw bytecode dumps but little guidance. | Might help if you need a bare‑bones disassembler; however, RABCDAsm remains the superior tool for editing AS3 bytecode. |

---

## C) Multi‑Language AMF/LSO Libraries (for unusual cases)

| Language | Library | Evidence & Features | Usage for Evony projects |
|---|---|---|---|
| **Rust** | `flash‑lso` (`rust‑flash‑lso`) | Provides **safe parsing and encoding of LSO files and AMF0/AMF3 data**【630156934774250†L90-L91】; heavily tested. | Best choice for high‑performance, cross‑platform `.sol` manipulation (foundation for a new soltool). |
| **Python** | `Py3AMF` and `mini‑amf` | Py3AMF is the only actively developed Python AMF project【243078572716210†L306-L340】; mini‑amf offers trimmed‑down serialization/deserialization【346007733383056†L296-L307】. | Use Py3AMF as a reference decoder and mini‑amf for lightweight tasks. |
| **Go** | `goamf` | AMF3 decoding in Go; developer must map AMF types to Go types manually【879570906016723†L310-L334】. | Could power Go‑based microservices or bots interacting with AMF endpoints. |
| **C#** | `AMF.net` | Supports both AMF0 and AMF3 and includes object viewer and Fiddler inspector【293764369203095†L34-L92】. | Integrate into Windows tools; helpful for inspecting network messages captured by Fiddler. |
| **JavaScript** | `amf.js` | Pure JavaScript library for reading AMF0/AMF3 data; built on a high‑performance ByteArray port【812540103757720†L49-L64】. | Allows building browser‑based debuggers or editors that run without the Flash plugin. |
| **Perl** | `Parse::Flash::Cookie` | Reads `.sol` files and returns content as a list【237543142729523†L10-L14】. | Rarely needed; useful for quick one‑liner scripts on Unix systems. |

---

## D) Other Notable Tools

| Tool | Purpose | Evidence & Notes |
|---|---|---|
| **Evercookie** | A JavaScript library that **creates extremely persistent cookies** across multiple storage mechanisms including Flash LSOs; the Open Hub summary notes that it aims to identify a client even after standard cookies and Flash cookies have been removed【607805378514618†L45-L50】. | Not directly useful for your project, but interesting if you need to understand cross‑storage persistence or test cookie deletion. |
| **FlashCookiesView** | A Windows utility to **list, view and delete Flash cookie files**; the README (in the utility’s zip) details that it displays `.sol` files, shows a readable/hex dump and can delete or export them (not accessible via API). | Good for manual inspection and cleanup of `.sol` caches. |
| **CyberChef** | A general‑purpose data analysis tool with **AMF encode/decode operations** (from the operations list). | Useful for ad‑hoc decoding tasks without writing code. |
| **SWF/Ming Tools** | Includes `swfextract`, `swfdump` and the Ming library to programmatically generate SWF files. | Handy for extracting resources or creating test SWFs. |

### Honorable Mentions
* **SWFTools** – CLI suite for dumping and extracting SWF tags; pairs well with py3swf when working from the command line.
* **Flasm** – Bytecode assembler/disassembler; good for patching at the bytecode level when JPEXS output is messy.
* **Ruffle** and **Lightspark** – modern Flash emulators; useful to run decompiled SWFs without the original projector.

---

## Summary

These additional tools broaden your options for working with Evony’s legacy Flash assets:

* **Cross‑language support** means you can integrate `.sol`/AMF parsing into almost any environment (Rust for performance, C# for Windows apps, Go for microservices, JavaScript for web tools and Perl for quick scripts).
* **GUI editors** (SolVE, .sol Editor, FlashCookiesView) are convenient for **manual editing** and verifying values, but you should still build an **automated pipeline** (e.g., using rust‑flash‑lso + Py3AMF) to avoid human error.
* **SWF parsers** like `py3swf` and extraction scripts (`extract_swf`) complement decompilers by letting you programmatically access resources or decompress the projector wrapper.  Combined with JPEXS or Flasm, you can patch the client or bots.

Refer to the new diagrams (`extended_tool_landscape.svg` and `sol_toolkit_blueprint.svg`) for a visual overview of how these projects fit together.
# .sol Repositories as Building Blocks: How to Build Robust Tools

Working with Evony’s **Flash Player 11** client and RoboEvony bots means dealing with **Local Shared Objects (LSOs)** that store everything from login credentials to automation scripts.  Choosing the right base repository matters.  Below is a guide on how to leverage existing open‑source projects as **foundations** for your own `.sol`‑aware tools.

## 1. Start from a **trustworthy codec**

A solid editor must be able to **decode** and **encode** `.sol` files without corruption.  Two standout libraries are:

- **`rust‑flash‑lso`**: A Rust crate that fully supports LSO parsing and encoding, including AMF0 and AMF3, and claims to be heavily tested【630156934774250†L90-L91】.  Because Rust compiles to a single binary and offers memory safety, this crate is ideal for building a high‑performance core.  You can expose it through FFI bindings to Python/Go/C# or compile to WebAssembly for use in browsers.
- **`Py3AMF`**: A Python fork of PyAMF that remains actively maintained【243078572716210†L306-L340】.  While slower than Rust, it’s invaluable as a **reference implementation**.  Use it to cross‑validate your Rust encoder or to prototype new features quickly.

## 2. Layer on language‑specific APIs

Once you have a core codec, wrap it in the languages you need:

- **Python**: Provide a simple `decode(file) → dict` and `encode(obj) → file` API, plus convenience functions for scanning directories.  Consider porting key features from `fmoo/soltool` (e.g., `find-recent` and `check`) to build your own CLI【697370996925510†L245-L306】.
- **Go**: Use `cgo` to link against the Rust library or extend `goamf` to handle AMF0 and `.sol` container structures.  Go is good for concurrent scanning across drives.
- **C#**: For Windows GUI tools, embed the Rust codec via C# P/Invoke or rely on `AMF.net` for AMF serialization【293764369203095†L34-L92】.  Add logic to read/write the `.sol` container format around the AMF payload.
- **JavaScript**: With WebAssembly, you can run the Rust codec in a browser; pair it with UI frameworks (Electron or Tauri) to build cross‑platform editors.  Alternatively, `amf.js` can decode AMF in pure JS【812540103757720†L49-L64】, but you’ll still need to implement the `.sol` header and footer.

## 3. Add **validation and safety**

Even good codecs can be misused.  Borrow techniques from `soltool` and `FlashCookiesView`:

- Implement a **round‑trip test** (decode→encode→decode) on a corpus of real Evony `.sol` files to detect loss of data or reordering.  Use Py3AMF as the baseline for comparison.
- Always write a **new file** (e.g., `config.sol.edited.<timestamp>.sol`), preserving the original as a backup.  Provide `--force` flags for destructive operations only.
- Maintain a **manifest** (hashes, sizes, timestamps) and include JSON dumps before and after editing to create an “evidence bundle.”
- Include a **diff viewer** so users can see exactly what changed.

## 4. Build **front‑ends** tailored to your workflow

A robust `.sol` toolkit isn’t just a codec; it includes user interfaces and automation hooks:

- **CLI**: Expose commands like `scan`, `dump`, `edit`, `validate`, `apply patch` and `export` (similar to `soltool`【697370996925510†L245-L306】).  Design for batch operations: scanning many drives or applying the same edit to multiple accounts.
- **GUI**: Use Electron, Qt, or Java (e.g., following SolVE) to build a tree viewer and value editor.  Provide search, filtering, and preset profiles for common goal scripts.
- **Watchers**: A background service can monitor the Macromedia `#SharedObjects` directories for changes and trigger exports or backups.  Integrate with Svony’s path‑manager logic so the watch path reflects the user’s chosen drive and folder.

## 5. Extend beyond **credentials**

Many `.sol` files in Evony contain more than login/pass data: they hold **automation goals, city layouts and scripts**.  To make full use of these, add features such as:

- **Schema inference**: Analyse multiple `.sol` files to infer common keys and data types.  This can help generate JSON schemas and auto‑suggest field names in the editor.
- **Template library**: Maintain a library of known “good” goal/auto‑script configurations.  Users can load a template and apply it to a new account, reducing manual effort.
- **Cross‑version diffing**: Compare `.sol` files across different RoboEvony versions to detect new fields or changes in data formats.  This helps keep your editor up to date.

## 6. Integration with **Svony** and **RoboTool**

To fully support Evony account management:

1. **Path mapping**: Use the path manager from Svony to compute the correct Macromedia path (e.g., `#localWithNet\evony2\{account}`) and bot folder (`D:\evony2\{account}
oboevony.exe`).  Ensure your toolkit reads/writes `.sol` files from that path.
2. **Import/Export**: When users change drive letters or folder names, automatically copy both the `.sol` and the `roboevony.exe` to the new location, preserving names.
3. **Bulk operations**: Provide an “import all accounts” button in Svony’s GUI that invokes your toolkit to decode each `.sol`, scan for credentials, and report which accounts have valid data.  Then, copy missing `.sol` files from backups using your scanner.

## Conclusion

By **building on top of existing `.sol` repositories** and combining them with robust testing and user‑friendly interfaces, you can create a powerful toolkit that handles everything from manual edits to automated migrations.  The accompanying diagram (`sol_toolkit_blueprint.svg`) illustrates how these layers fit together.
# Hidden Gem Search Playbook (Extended)

The Flash ecosystem is fragmented: some of the best tools don’t advertise themselves as “Flash” at all.  Below are **search strategies** and **example queries** to unearth those projects, followed by notes on newly discovered repositories.

## 1. Evolve your keywords

In addition to the patterns from the main playbook, experiment with:

- **Language filters**: Append languages to your search (e.g., `amf parser c#`, `lso rust crate`, `amf3 go library`) to uncover language‑specific projects such as `goamf`【879570906016723†L310-L334】 and `AMF.net`【293764369203095†L34-L92】.
- **Generic terms**: Terms like `ByteArray`, `binary format parser`, `cookie viewer`, or `object viewer` often lead to AMF/LSO projects (e.g., `amf.js`【812540103757720†L49-L64】).
- **File extractors**: Search for “projector extractor”, “swf extraction script” or “SWF parser python” to find scripts like `extract_swf`【381585271803916†L0-L11】.
- **Obfuscated names**: Many older projects have whimsical names (e.g., “SolVE”, “YASWFP”).  Use `site:github.com sol viewer` or `site:sourceforge.net lso` to browse directories.

### Example search queries

- `"Local Shared Object" parser rust`
- `amf3 decode go library`
- `"flash cookie" viewer`
- `swf parser javascript`
- `"Action Message Format" .NET`
- `projector extract swf script`

## 2. Dive into other ecosystems

Not everything lives on GitHub:

- **CPAN (Perl)**: searching for `Flash` reveals modules like `Parse::Flash::Cookie` that read `.sol` files and return the contents【237543142729523†L10-L14】.
- **NuGet (.NET)**: packages like `mtanksl.ActionMessageFormat` provide AMF serialization/deserialization【293764369203095†L2-L20】.
- **PyPI**: besides `Py3AMF`, you’ll find `mini-amf`, `pyswf` and `hexagonit.swfheader` for Python.  Use `pip search swf` to browse.
- **SourceForge**: still hosts legacy tools like **SolVE** and **.sol Editor**【993719178797030†L80-L83】【314070883101429†L89-L93】.

## 3. Validate and curate

When you discover a new repo:

1. **Read the README** and confirm it actually handles Flash/AMF/LSO data.  Some projects may be unrelated (e.g., `.sol` can also refer to Solidity contracts).  In `.sol Editor`’s page, the description clearly states its purpose【314070883101429†L89-L93】.
2. **Check activity and license**.  Archived or single‑commit projects (like YASWFP) can still be valuable as references, but don’t rely on them for production.
3. **Test on real files**.  Run the tool against a sample `.sol` or SWF and compare output with a known good decoder (e.g., Py3AMF).  Discard projects that corrupt data.
4. **Document** your findings.  Note the project URL, commit hash, and any build instructions.  If useful, add it to your internal catalogue for future reference.

## 4. Hidden gems discovered

During this round of research we found several projects that might otherwise be overlooked:

| Project | Description & Evidence | Potential use |
|---|---|---|
| **SolVE** | Java/SWT app to view/edit LSOs【993719178797030†L80-L83】. | A manual inspector for `.sol` files when building test cases or exploring unfamiliar LSOs. |
| **.sol Editor** | Simple Java tool that opens or creates `.sol` files and lets you modify values【314070883101429†L89-L93】. | Quick edits on old `.sol` files; works offline. |
| **Parse::Flash::Cookie** | Perl module that reads `.sol` files and returns contents as a list【237543142729523†L10-L14】. | Useful in Unix environments; demonstrates how the `.sol` format can be parsed without large dependencies. |
| **goamf** | A Go library supporting AMF3 decoding【879570906016723†L310-L334】. | Could be extended to parse `.sol` files in Go‑based tools or servers. |
| **AMF.net** | C# library implementing AMF0/AMF3 with object viewer and Fiddler inspector【293764369203095†L34-L92】. | Perfect for building Windows utilities or plugins to view AMF objects captured from network traffic. |
| **amf.js** | Pure JS AMF0/AMF3 implementation using a ByteArray polyfill【812540103757720†L49-L64】. | Enables browser‑based `.sol` or AMF editors once paired with a `.sol` container handler. |
| **extract_swf** | Python script to extract SWF files from Flash projectors【381585271803916†L0-L11】. | Essential when dealing with self‑contained `.exe` projectors like RoboEvony; lets you retrieve the SWF for decompilation. |
| **py3swf/pyswf** | Python library to read/write SWFs and export them to SVG【779397042260553†L0-L6】【779397042260553†L37-L70】. | Good for programmatic SWF introspection, resource extraction or conversion. |

## Conclusion

Finding hidden tools takes creativity.  Use varied search terms, explore multiple package ecosystems and read README files carefully.  By doing so, you’ll assemble a diverse set of libraries that complement the mainstream tools and give you maximum flexibility when working with Flash, LSOs and AMF in your Evony projects.
