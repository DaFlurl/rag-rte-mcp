# Svony Studio - Frequently Asked Questions

> **"FAQ"** - Common Questions and Answers

---

## General Questions

### What is Svony Studio?

Svony Studio is a specialized reverse engineering environment for Evony Age II, built on FFDec integration with additional tools for SOL management, protocol analysis, and bot development.

### Is Svony Studio free?

Yes, Svony Studio is open-source software released under the MIT license.

### What platforms are supported?

- **Primary**: Windows 10/11 (64-bit)
- **Planned**: Linux (Ubuntu, Fedora), macOS

### What are the system requirements?

- Python 3.11+
- Java 8+ (for FFDec)
- 8GB RAM minimum (16GB recommended)
- 2GB free disk space

---

## Installation Questions

### Why do I need Java installed?

FFDec (JPEXS Free Flash Decompiler) is written in Java and requires a Java Runtime Environment to function. Svony Studio uses FFDec for SWF decompilation.

### FFDec is not being detected. What should I do?

1. Verify FFDec is installed correctly
2. Set the `FFDEC_PATH` environment variable:
   ```powershell
   $env:FFDEC_PATH = "C:\Program Files (x86)\FFDec"
   ```
3. Or edit `config/settings.yaml`:
   ```yaml
   tools:
     ffdec_path: "C:/Program Files (x86)/FFDec"
   ```

### How do I update Svony Studio?

```powershell
cd D:\svony_studio
git pull origin main
pip install -r requirements.txt --upgrade
```

### Can I run multiple instances?

Yes, but ensure each instance uses a different project to avoid file conflicts.

---

## SWF Analysis Questions

### What SWF versions are supported?

Svony Studio supports all Flash SWF versions from 1-43, including:
- ActionScript 2 (SWF 6-8)
- ActionScript 3 (SWF 9+)

### Why is decompilation slow?

Large SWF files with extensive obfuscation take longer. Tips:
- Use SSD storage
- Close other applications
- Enable incremental decompilation in settings

### Can I edit the SWF directly?

Yes, through FFDec integration. Svony Studio provides:
- Script editing and recompilation
- Asset replacement
- Binary patching

### What's the difference between P-code and ActionScript?

- **ActionScript**: High-level, human-readable code
- **P-code**: Low-level bytecode representation
- Use P-code when decompilation produces errors

### How do I find specific code in a large SWF?

1. Use `Ctrl+Shift+F` for global search
2. Search by:
   - Function names
   - String literals
   - Class names
3. Use Evony-specific tools for protocol analysis

---

## SOL Questions

### What is a SOL file?

SOL (SharedObject Local) is Flash's equivalent of browser cookies. Evony uses SOL files to store:
- Login credentials
- Game settings
- Server preferences

### Where are Evony SOL files stored?

Common locations:
- `%APPDATA%\Macromedia\Flash Player\#SharedObjects\`
- `%LOCALAPPDATA%\Google\Chrome\User Data\Default\Pepper Data\`
- `~/.macromedia/Flash_Player/#SharedObjects/` (Linux)

### Are passwords stored in plain text?

No, Evony stores passwords as MD5 hashes. However, MD5 is considered weak and can be reversed using rainbow tables.

### Can I edit SOL files manually?

Yes, but be careful:
1. Always create backups first
2. Use Svony Studio's SOL Editor for safe editing
3. Invalid edits can corrupt the file

---

## Evony-Specific Questions

### Which Evony version does this support?

Svony Studio is designed for **Evony Age II** (the Flash-based version). It does not support:
- Evony: The King's Return (mobile)
- Evony Age I (older version)

### Can I connect to official Evony servers?

Svony Studio is for analysis and bot development. Connecting bots to official servers may violate Terms of Service. Use at your own risk.

### What bot frameworks are compatible?

- **RoboEvony** v1.41+
- **AutoEvony** v1.65+
- **YAEB** (legacy)
- **pyEvony** (Python)

### How do I set up a private server?

1. Use SPITFIRE server emulator
2. Follow setup in `docs/evony/RESOURCES.md`
3. Patch client to connect to localhost

### What's "Borg Mode"?

Borg Mode is deep analysis that scans the entire Evony client for:
- Protocol commands
- Network handlers
- Credential storage
- Security mechanisms

---

## Bot Development Questions

### What scripting languages are supported?

- AutoEvony script syntax
- RoboEvony script syntax
- Python (via pyEvony)

### How do I avoid bot detection?

1. Use Tor for IP rotation
2. Add random delays between actions
3. Simulate human-like behavior
4. Don't run 24/7 without breaks

### Can I run multiple accounts?

Yes, with proper setup:
1. Configure Tor rotation
2. Use separate SOL files per account
3. Stagger login times

### Why do my attacks fail?

Common causes:
1. Insufficient troops
2. Hero not available
3. March queue full
4. Target already occupied
5. Rate limiting by server

---

## Protocol Questions

### What is AMF?

AMF (Action Message Format) is Adobe's binary serialization format. Evony uses AMF3 for client-server communication.

### How do I decode AMF messages?

1. Use Svony Studio's protocol analyzer
2. Or use Python with Py3AMF:
   ```python
   from pyamf import remoting
   decoded = remoting.decode(binary_data)
   ```

### What ports does Evony use?

- **443**: Primary game traffic (HTTPS/AMF)
- **80**: HTTP resources
- **Policy**: Port 843 (Flash socket policy)

### Can I replay captured packets?

Yes, but session tokens expire. You'll need to:
1. Capture fresh login
2. Extract new session token
3. Update replayed packets

---

## Troubleshooting Questions

### Application won't start

1. Check Python version: `python --version`
2. Verify dependencies: `pip install -r requirements.txt`
3. Check logs in `logs/` folder

### "Java not found" error

1. Install Java 8+
2. Set JAVA_HOME environment variable
3. Restart terminal/application

### SWF fails to open

1. Verify file is valid SWF (check magic bytes)
2. Try decompressing first: `swf decompress file.swf`
3. Check for corruption

### SOL files not found

1. Run scan with elevated permissions
2. Check browser-specific locations
3. SOL files may be in Pepper Data for Chrome

### Script validation fails

1. Check syntax against reference
2. Ensure proper line endings (CRLF/LF)
3. Remove special characters

---

## Security Questions

### Is my data safe?

Svony Studio:
- Does not collect telemetry
- Does not phone home
- Stores all data locally

### Should I share my SOL files?

**No!** SOL files contain:
- Hashed passwords
- Session tokens
- Account identifiers

### Is using bots legal?

Using bots typically violates game Terms of Service. Consider:
- You may get banned
- Only use on private servers for safety
- Educational use is generally acceptable

### How do I secure my installation?

1. Don't run as administrator
2. Keep software updated
3. Don't share config files with credentials
4. Use encrypted storage for sensitive data

---

## Contributing Questions

### How do I report bugs?

1. Check existing issues on GitHub
2. Create detailed bug report with:
   - Steps to reproduce
   - Expected vs actual behavior
   - Logs and screenshots

### Can I contribute code?

Yes! We welcome contributions:
1. Fork the repository
2. Create feature branch
3. Submit pull request
4. Follow coding standards

### How do I request features?

1. Open GitHub issue with "Feature Request" label
2. Describe use case
3. Provide examples if possible

---

## Miscellaneous

### Why "Svony"?

"Svony" is a play on "Evony" - the S represents "Studio" or "Svelte" (lightweight). It's also an anagram approach to differentiate from the game name.

### Is this project maintained?

Yes, Svony Studio is actively developed. Check:
- GitHub for latest commits
- CHANGELOG.md for version history
- Roadmap for planned features

### Where can I get help?

1. Read documentation thoroughly
2. Check FAQ (this document)
3. Search closed GitHub issues
4. Open new issue if needed

### Can I use this for other Flash games?

Yes! While optimized for Evony, Svony Studio works with any SWF file. The Evony-specific tools won't apply, but:
- Decompilation works
- Asset export works
- SOL editing works (for any SharedObject)

---

## Related Documentation

- `TROUBLESHOOTING.md` - Detailed problem solving
- `INSTALLATION_GUIDE.md` - Setup instructions
- `USER_GUIDE.md` - Usage guide
- `GLOSSARY.md` - Term definitions

---

*Document Version: 1.0.0 | Frequently Asked Questions*
