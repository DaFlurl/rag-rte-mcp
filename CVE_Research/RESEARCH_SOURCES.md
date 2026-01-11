# Research Sources & Assignments
## Claude ↔ Windsurf Coordination

### Claude's Research Sources (Web/Documentation)
| Source | URL | Purpose | Status |
|--------|-----|---------|--------|
| NVD | nvd.nist.gov | CVE details, CVSS | ✅ Done |
| Adobe APSB | helpx.adobe.com/security | Bulletins | ✅ Done |
| MITRE CVE | cve.mitre.org | Official CVE data | ✅ Done |
| Exploit-DB | exploit-db.com | PoC code | ⏳ Available |
| Rapid7/Metasploit | rapid7.com | Module research | ⏳ Available |
| SecurityFocus | securityfocus.com | Historical CVEs | ⏳ Available |

### Windsurf's Data Sources (Local Files)
| Source | Path | Purpose | Status |
|--------|------|---------|--------|
| NVD Fetched | CVE_Research/*.json | Raw CVE data | ✅ Done |
| Training JSONL | training/*.jsonl | Training examples | ✅ Done |
| Evony Source | *.as files | Code analysis | ✅ Done |

### High-Value Research Targets (Claude to Investigate)

**Exploit Kit Documentation:**
- Angler EK Flash CVE usage
- RIG EK payload analysis
- Nuclear Pack techniques

**APT Group Research:**
- APT3 (CVE-2016-1019)
- APT28/Fancy Bear Flash usage
- Hacking Team leaked tools

**Technical Papers:**
- Blazakis JIT spray paper
- Flash heap spray techniques
- Vector corruption methods

### CVE Deep Dive Queue
| CVE | Priority | Research Needed | Assigned |
|-----|----------|-----------------|----------|
| CVE-2015-5119 | S | Full exploit chain | Claude |
| CVE-2015-0311 | S | Evony code mapping | ✅ Done |
| CVE-2010-3654 | A | JIT spray details | Claude |
| CVE-2016-1019 | A | APT3 usage | Claude |
| CVE-2014-0502 | A | Double-free technique | Claude |
