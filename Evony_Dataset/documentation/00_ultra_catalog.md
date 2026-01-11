
# Additional Flash / SWF / LSO Tools Catalog (Generated 2026-01-01)

This document extends the prior catalog with more tools uncovered through further research.  It includes utilities for SWF decompression, deobfuscation, LSO parsing in various languages, and web-based editors.  Tools are grouped by functionality and rated for usefulness (★ out of 10) in the context of reverse engineering and automating **Evony Age II (2009–2013)** and related bots.

## Deobfuscation & Bytecode Tools

| Tool | Description & Why It’s Useful | Stars |
|----|----|----|
| **FlashSuite** | A Java-based toolkit that deobfuscates disassembled SWF code.  Modules include **Deirrfuscate** (decrypts strings from Irrfuscator), **Nitrome Decrypter**, **SAS4 Deobfuscator**, and **SecureSWF Flow** deobfuscator.  You must first disassemble the SWF with RABCDAsm; then run the appropriate module to produce cleaner ActionScript code【515146224424350†L255-L319】.  Useful when the Evony client or bot uses commercial obfuscators like SecureSWF or Irrfuscator. | 8★ |
| **Flasm** | A command-line Flash ActionScript bytecode disassembler/assembler.  It can translate SWF bytecode into human-readable assembly and reassemble it after modification.  Great for fine-grained patches, such as altering constants or simple logic, when decompilers fail or produce too much noise. | 7★ |
| **Other ABC Disassemblers** | E.g., MITRE’s `abcd` (limited docs).  They operate at the bytecode (AVM2/ABC) level and can complement RABCDAsm for analysis.  Their use is more specialised; thus rated lower. | 5★ |

## SWF Compression & Extraction

| Tool | Description & Why It’s Useful | Stars |
|----|----|----|
| **swfpack** | C utility to compress or decompress SWF files.  Supports output to/from standard input, DEFLATE or LZMA compression, and in-place modification【492144833086052†L268-L303】.  When working with projector EXEs or heavily compressed SWFs, swfpack helps you decompress them for analysis or recompress after edits. | 6★ |
| **swfzip** | Python 2.7 script to compress/decompress SWF files using zlib or LZMA【673970543468538†L270-L284】.  It is easy to integrate into Python workflows but requires an outdated interpreter. | 5★ |
| **swfmill** | Converts SWF files to and from an XML dialect (`swfml`) and can pack media into a new SWF【859642729835163†L321-L331】.  Good for injecting or replacing assets (images, fonts) or for inspecting SWF structure in a human-readable XML form. | 7★ |
| **extract_swf** | Python script that extracts an embedded SWF from a Flash projector (EXE) and outputs a decompressed SWF【381585271803916†L0-L11】.  Essential when dealing with stand-alone Flash players shipped as `.exe` (common for RoboEvony bots). | 6★ |
| **libswf** | Modern C++17 library for editing SWF files.  Features include exporting/importing SWFs from projector EXEs, compress/decompress with zlib/LZMA, and exporting/replacing MP3s, images and binary data tags; it also serializes AMF0/AMF3 to JSON【799269667084266†L299-L312】.  Suitable for building a high-performance pipeline around SWF editing. | 8★ |
| **SWFCompressionTool** | C# CLI that decompresses CWS/ZWS SWF headers to FWS for editing then recompresses them【651244927306321†L271-L276】.  A user-friendly option for Windows users who need to modify SWFs without manually calling compression utilities. | 6★ |

## LSO / AMF Parsing in Other Languages

| Tool | Description & Why It’s Useful | Stars |
|----|----|----|
| **Flash-SharedObject-Parser (C#)** | Provides a class to parse AS3 SharedObject (.sol) files.  The README explains it was created for porting Adobe AIR apps to Unity and describes storing and retrieving primitive types.  It emphasises that `.sol` files reside in the `#SharedObjects/<UID>/` folder with `.sol` extension【562901023574253†L260-L314】.  Great for .NET developers or for building cross-platform editors that consume `.sol` via C#. | 7★ |
| **goamf** | Go library implementing AMF3 decoding.  It demonstrates decoding objects using Go’s reflection and supports some basic types【879570906016723†L310-L334】.  Useful if building Go-based services to process LSO data (e.g., a backend service for migrating accounts). | 6★ |
| **AMF.net (C#)** | Implements AMF0/AMF3 serialization in .NET.  The README includes sample code to serialize/deserialize and mentions an object viewer and Fiddler inspector【293764369203095†L34-L92】.  Could be integrated into a Visual Studio plugin or test harness for .sol parsing. | 6★ |
| **Parse::Flash::Cookie (Perl)** | CPAN module that reads `.sol` files and returns data as a list【237543142729523†L10-L14】.  Good for quick scripts or migrating data in a Perl-heavy environment. | 4★ |
| **amf.js** | Pure JavaScript AMF implementation with a custom ByteArray polyfill【812540103757720†L49-L64】.  Enables reading/writing AMF0/AMF3 entirely in the browser (no Flash), which can power web-based LSO editors or debugging UIs. | 7★ |

## Web-Based & Cross-platform Tools

| Tool | Description & Why It’s Useful | Stars |
|----|----|----|
| **Minerva (.sol editor)** | Web-based GUI for viewing/editing LSO files, supporting all AMF types and offering AIR versions for offline editing【314070883101429†L89-L93】.  Perfect for manual inspection and editing across OSes. | 8★ |
| **SolVE** | Cross-platform LSO viewer/editor in Java (SWT) that reads AMF0/AMF3【993719178797030†L80-L83】.  Offers a simple GUI and portability; could serve as a model for building your own editor. | 7★ |
| **n0samu.github.io** | A set of web tools including a Rust-based LSO editor, Ruffle saves exporter, Flash player check, etc.  The LSO editor uses `rust-flash-lso` under the hood【482655797463837†L350-L365】.  Useful for quick editing without installing anything locally. | 8★ |
| **Other Tools** | There are many domain-specific tools (e.g., Evercookie testers, cross-domain cookie managers).  Their relevance to Evony is lower, so they receive lower ratings. | 3–5★ |

## Observations & Recommendations

1. **Combine strengths:** Use `rust-flash-lso` for core parsing/editing, then wrap additional functionality from `libswf` or `swfmill` for SWF-level modifications.  For example, decompress a projector with `extract_swf`, edit the SWF via `FFDec`/`RABCDAsm`, recompress using `libswf`, and decode/edit `.sol` using Rust + Python.
2. **Deobfuscate when needed:** Some bots or clients may embed obfuscation (Irrfuscator, SecureSWF).  Run `RABCDAsm` + `FlashSuite` to clean up code before analysis.  Flasm can handle targeted modifications.
3. **Language choice matters:** If you plan to build a UI or cross-platform tools, pick the language that best suits your environment—Rust for CLI performance, Python for quick scripts, C# for Windows integration, JavaScript/Haxe for web GUIs.
4. **Hidden gem search:** Continue exploring terms like “sharedobject parser”, “amf0”, “rtmp player”, “bytecode dump” to unearth less obvious repositories.  Use the hidden gems playbook in earlier docs for strategy.

See the new diagram `advanced_tool_mapping.svg` for a visual overview of tool categories and examples.

# Expanded Use-Cases & Best Practices for Evony / RoboEvony Automation

This document synthesises how the newly discovered tools can fit into your Evony automation ecosystem.

## 1. Decompressing / Recompressing SWFs

Before you can analyse or patch a SWF, you may need to decompress it:

- **Use `extract_swf`** to pull the SWF out of a projector EXE and decompress it.  This is common for `roboevony.exe` or old Evony clients that ship as stand‑alone players【381585271803916†L0-L11】.
- **Run `swfpack` or `swfzip`** if the SWF has CWS/ZWS headers.  Decompress (`-d`) to FWS, perform edits, then recompress with zlib or LZMA (`-c` or `-z`)【492144833086052†L268-L303】【673970543468538†L270-L284】.
- **Alternatively, use `libswf`** for an all-in-one API to decompress, modify tags, and recompress SWFs【799269667084266†L299-L312】.

## 2. Disassemble, Deobfuscate, & Patch

- **Disassemble with RABCDAsm** to get clean ABC files.  If you detect obfuscation, run the relevant **FlashSuite** module on the disassembled directory (e.g., `java -jar FlashSuite.jar secureflow outDir`).  The goal is to remove encrypted strings or control-flow flatteners【515146224424350†L255-L319】.
- When modifications are simple (e.g., toggling a boolean or disabling a timer), **Flasm** can patch bytecode directly without full reassembly.
- Reassemble or patch back the SWF and then recompress if needed.

## 3. Parse and Edit LSOs (.sol files)

- **Choose your core library:** `rust-flash-lso` (performance + safety), `Py3AMF` (rapid prototyping), `Flash-SharedObject-Parser` (C# integration), or other language-specific libs.  Always verify round‑trip integrity on a corpus of `.sol` files.
- Use **Minerva** or **SolVE** for manual inspection and editing across platforms【314070883101429†L89-L93】【993719178797030†L80-L83】.
- Build a command-line tool (`soltool.exe`) on top of these libraries for automation (see earlier blueprint).  Include features like JSON diffing, profiles, and evidence bundles.

## 4. Integrate with Existing Evony Bots

- **RoboTool / Svony:** Use the path manager to map drive + folder into correct Macromedia `#localWithNet/<folder>/` path.  For each account, decompress its SWF if needed, decompile to inspect SharedObject keys, then apply .sol modifications via the sol-toolkit.
- **EvonyScoutingApp / EvonyUltimatumApp:** Leverage `Py3AMF` to encode/decode messages to the Evony servers.  Combine with new sol editor to adjust credentials or script values.
- **pyEvony + evony_automation_tools:** These Python scripts can send game commands; integrate the sol editor to manage login data across multiple accounts.

## 5. Web & Cross-Platform Front-Ends

- Deploy **n0samu’s LSO editor** or your own variant built on `amf.js` to provide a browser-based editing interface【482655797463837†L350-L365】.  This is ideal for non-developers.
- Use `amf.net` or `Flash-SharedObject-Parser` if you are building a Windows desktop app (e.g., in C# / WPF).  They can decode and encode `.sol` files and integrate with `Svony` GUI.

## 6. Future Exploration

- **Data transport:** Investigate RTMP/NetConnection decoders to capture live messages (they may contain references to SharedObjects on the server side).
- **Archive scanning:** Explore tools like `libswf` for injecting instrumentation into the SWF to log SharedObject operations.
- **Compression algorithms:** Understand differences between zlib and LZMA in SWF contexts; some players only support zlib.

By combining the above tools and strategies, you can build a robust pipeline for exploring, editing, and maintaining your Evony bots and clients.

# Future Work & Hidden Search Strategies

To ensure your tooling remains comprehensive and up‑to‑date, consider the following lines of inquiry:

1. **Monitor package ecosystems:** Search CPAN (Perl), NuGet (.NET), Maven Central (Java), crates.io (Rust), and npm (JavaScript) for packages containing “sharedobject”, “amf”, or “flash” keywords.  Many older tools predate GitHub.
2. **Reverse-engineer `.sol` encryption:** Some games or bots may encrypt their SharedObjects.  Look for repos addressing encryption (e.g., XOR‐based or AES).  Keyword hints: “secure local shared object”, “protected LSO”.
3. **RTMP/NetConnection:** Investigate **rtmpdump** derivatives or AMF/RTMP proxies to decode live traffic between the client and server.  This can shed light on how game state is synced and might reveal additional data structures to capture.
4. **Look beyond GitHub:** Many early Flash tools were hosted on SourceForge, Google Code, Baidu Tieba, or Chinese blogs.  Use translated search terms (“共享对象 编辑器”, “闪客 反编译”) and time range filters to uncover hidden gems.
5. **Collect & anonymise your own corpus:** Build a dataset of real `.sol` files from different accounts, anonymised, to test the resilience of your editors.  Use hashing and truncated dumps to share with collaborators without exposing secrets.
6. **Community engagement:** Engage with communities like **Ruffle**, **Lightspark**, or **Haxe/OpenFL** Slack/Discord; they have deep domain expertise and may point you to lesser‑known tools.

This research process is iterative.  Keep refining your search terms and exploring unusual languages and ecosystems to uncover the next valuable component for your toolkit.
