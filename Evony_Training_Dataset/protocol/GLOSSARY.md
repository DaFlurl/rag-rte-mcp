# Svony Studio - Glossary of Terms

> **Quick Reference** - Common terms and abbreviations used in Svony Studio documentation

---

## A

**ABC (ActionScript Byte Code)**
Compiled ActionScript 3 bytecode stored in DoABC tags within SWF files. Contains classes, methods, and executable code.

**AMF (Action Message Format)**
Binary serialization format used by Flash for data exchange. AMF3 is the current version used by Evony.

**AS3 (ActionScript 3)**
The programming language used in Flash/AIR applications. Evony client is written in AS3.

**AVM2 (ActionScript Virtual Machine 2)**
The virtual machine that executes ABC bytecode in Flash Player.

---

## B

**Ballista**
Siege unit in Evony with high attack and range. Critical for NPC defense - NPCs level 4+ contain ballistae.

**Borg Mode**
Advanced analysis mode in Svony Studio that performs comprehensive automated analysis of SWF files.

**Bot Framework**
External automation tools (pyEvony, RoboEvony, AutoEvony) that interact with Evony servers.

---

## C

**Cataphract**
Heavy cavalry unit in Evony with high attack and defense stats.

**Constant Pool**
Section of ABC bytecode containing all constants (integers, strings, namespaces, etc.).

**Control Flow Obfuscation**
Technique to make code harder to understand by adding fake branches and dead code.

---

## D

**Decompilation**
Process of converting compiled bytecode back to readable source code.

**Deobfuscation**
Process of reversing obfuscation to make code readable again.

**DoABC Tag**
SWF tag type that contains ABC bytecode.

---

## E

**Evony**
Browser-based MMO strategy game. Primary target for Svony Studio analysis.

---

## F

**FFDec (JPEXS Free Flash Decompiler)**
Open-source Flash decompiler that Svony Studio wraps and extends.

**Flash Player**
Adobe's runtime for executing SWF files. End-of-life December 2020 but still used for legacy games.

---

## G

**GUI (Graphical User Interface)**
Visual interface for interacting with software (planned for Svony Studio Phase 2).

---

## H

**Hero**
Commander unit in Evony that leads armies and provides stat bonuses.

**Hex View**
Display of raw binary data in hexadecimal format.

---

## I

**Instance Info**
ABC structure containing class instance data (name, superclass, interfaces, traits).

---

## J

**JAR (Java Archive)**
Java package format. FFDec is distributed as ffdec.jar.

---

## L

**Loot**
Resources gained from attacking NPCs or other players in Evony.

---

## M

**Method Body**
ABC structure containing actual bytecode instructions for a method.

**Multiname**
ABC constant pool entry representing a qualified name (namespace + name).

---

## N

**Namespace**
ABC concept for organizing identifiers (public, private, internal, etc.).

**NPC (Non-Player Character)**
Computer-controlled targets in Evony. Levels 1-10, used for farming resources.

---

## O

**Obfuscation**
Techniques to make code harder to reverse engineer (renaming, encryption, control flow).

**Opaque Predicate**
Obfuscation technique using conditions that always evaluate the same way.

---

## P

**P-Code**
Human-readable representation of ABC bytecode instructions.

**Proxy**
Intermediary that captures network traffic between client and server.

---

## Q

**QName (Qualified Name)**
A name with an associated namespace in ABC.

---

## R

**RABCDAsm**
Tool for assembling/disassembling ABC bytecode.

**REPL (Read-Eval-Print Loop)**
Interactive command-line environment.

---

## S

**Scout**
Fast reconnaissance unit in Evony used for gathering intelligence.

**Siege**
Category of units (Ballista, Ram, Catapult) designed for attacking fortifications.

**SOL (Shared Object Local)**
Flash's local storage format, similar to cookies. Contains saved credentials.

**SWF (Shockwave Flash)**
Adobe's file format for Flash content. Contains tags with various content types.

---

## T

**Tag**
Basic building block of SWF files. Each tag has a type and contains specific data.

**Trait**
ABC structure representing a class member (property, method, getter/setter, etc.).

**Transporter**
Support unit in Evony with high carrying capacity for moving resources.

---

## U

**UTF-8**
Unicode text encoding used in ABC string constants.

---

## W

**Worker**
Basic civilian unit in Evony used for construction and resource transport.

---

## X

**XOR**
Bitwise operation commonly used in simple string encryption/obfuscation.

---

## Command IDs (Evony)

| Range | Category |
|-------|----------|
| 10xxx | Authentication |
| 20xxx | City Management |
| 21xxx | Research |
| 30xxx | Army/Troops |
| 35xxx | Hero |
| 40xxx | Alliance |
| 50xxx | Map/World |
| 60xxx | Chat |
| 90xxx | Events |

---

## File Extensions

| Extension | Description |
|-----------|-------------|
| `.swf` | Shockwave Flash file |
| `.sol` | Flash Shared Object (local storage) |
| `.abc` | ActionScript Byte Code |
| `.as` | ActionScript source |
| `.amf` | Action Message Format data |

---

## Keyboard Modifiers

| Symbol | Windows | macOS |
|--------|---------|-------|
| `Ctrl` | Control | Command (⌘) |
| `Alt` | Alt | Option (⌥) |
| `Shift` | Shift | Shift |

---

*Document Version: 1.0.0 | Svony Studio Glossary*
