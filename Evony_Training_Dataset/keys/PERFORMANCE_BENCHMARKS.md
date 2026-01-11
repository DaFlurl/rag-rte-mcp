# Svony Studio - Performance Benchmarks

> **"Detailed Performance Data"** - Benchmarks and Optimization Results

---

## Overview

This document provides detailed performance benchmarks comparing Svony Studio operations with FFDec direct and tracking performance improvements over time.

---

## Test Environment

### Hardware Configuration

| Component | Specification |
|-----------|---------------|
| **CPU** | AMD Ryzen 7 5800X3D (8 cores) |
| **RAM** | 64GB DDR4-3600 |
| **Storage** | Samsung 980 PRO NVMe SSD |
| **OS** | Windows 11 Pro 23H2 |
| **Java** | OpenJDK 17.0.9 |
| **Python** | 3.11.7 |

### Test Files

| File | Size | Description |
|------|------|-------------|
| small.swf | 1 MB | Simple Flash app |
| medium.swf | 10 MB | Game client (partial) |
| large.swf | 50 MB | Full game client |
| evony_client.swf | 85 MB | Evony Age II client |

---

## Decompilation Benchmarks

### Script Decompilation

| File | FFDec Direct | Svony Studio | Overhead |
|------|--------------|--------------|----------|
| small.swf | 1.2s | 1.5s | +25% |
| medium.swf | 12.4s | 15.1s | +22% |
| large.swf | 78.3s | 95.2s | +22% |
| evony_client.swf | 142.5s | 175.3s | +23% |

**Analysis:** Consistent ~22-25% overhead due to Python wrapper and result processing.

### Memory Usage

| File | FFDec Peak | Svony Studio Peak | Delta |
|------|------------|-------------------|-------|
| small.swf | 256 MB | 312 MB | +56 MB |
| medium.swf | 512 MB | 648 MB | +136 MB |
| large.swf | 1.8 GB | 2.1 GB | +300 MB |
| evony_client.swf | 3.2 GB | 3.6 GB | +400 MB |

**Recommendation:** Set Java heap to 4GB for large files.

---

## Export Benchmarks

### Image Export (PNG)

| File | Images | FFDec | Svony Studio | Per Image |
|------|--------|-------|--------------|-----------|
| small.swf | 50 | 2.1s | 2.5s | 50ms |
| medium.swf | 500 | 18.3s | 22.1s | 44ms |
| large.swf | 2,000 | 85.2s | 102.4s | 51ms |
| evony_client.swf | 3,500 | 156.8s | 188.5s | 54ms |

### Script Export (AS3)

| File | Scripts | FFDec | Svony Studio | Per Script |
|------|---------|-------|--------------|------------|
| small.swf | 20 | 0.8s | 1.0s | 50ms |
| medium.swf | 200 | 8.5s | 10.2s | 51ms |
| large.swf | 800 | 42.3s | 51.8s | 65ms |
| evony_client.swf | 1,500 | 89.4s | 109.2s | 73ms |

### Full Export (All Assets)

| File | Total Assets | FFDec | Svony Studio |
|------|--------------|-------|--------------|
| small.swf | 150 | 8.2s | 10.1s |
| medium.swf | 1,200 | 68.5s | 83.2s |
| large.swf | 5,000 | 285.3s | 348.7s |
| evony_client.swf | 8,500 | 512.4s | 625.8s |

---

## SOL Operations

### SOL File Operations

| Operation | Files | Time | Per File |
|-----------|-------|------|----------|
| System Scan | 150 | 4.2s | 28ms |
| Read SOL | 1 | 12ms | 12ms |
| Write SOL | 1 | 18ms | 18ms |
| Parse AMF | 1 | 8ms | 8ms |
| Batch Read | 100 | 1.8s | 18ms |
| Batch Export | 100 | 3.5s | 35ms |

### Credential Extraction

| Operation | Time |
|-----------|------|
| Find Evony SOLs | 850ms |
| Extract Credentials | 45ms |
| Export to JSON | 22ms |
| **Total** | **~1s** |

---

## Protocol Analysis

### Proxy Capture

| Metric | Value |
|--------|-------|
| Latency overhead | <5ms |
| Throughput | 10,000+ msg/sec |
| AMF decode time | 0.5ms avg |
| Memory per capture | 2KB avg |

### Protocol Mapping

| Operation | Evony Client | Time |
|-----------|--------------|------|
| Find command classes | 85 | 12.3s |
| Extract command IDs | 85 | 2.1s |
| Generate documentation | 85 | 1.8s |
| **Total** | | **~16s** |

---

## Parallel Processing

### Decompilation with Workers

| Workers | medium.swf | large.swf | Speedup |
|---------|------------|-----------|---------|
| 1 | 15.1s | 95.2s | 1.0x |
| 2 | 8.9s | 54.3s | 1.7x |
| 4 | 5.2s | 31.8s | 3.0x |
| 8 | 3.4s | 19.5s | 4.9x |
| 16 | 3.1s | 17.2s | 5.5x |

**Note:** Diminishing returns above CPU core count.

### Batch Export with Workers

| Workers | 1000 Images | Speedup |
|---------|-------------|---------|
| 1 | 52.4s | 1.0x |
| 4 | 15.8s | 3.3x |
| 8 | 9.2s | 5.7x |

---

## Caching Performance

### Decompilation Cache

| Scenario | First Run | Cached Run | Speedup |
|----------|-----------|------------|---------|
| small.swf | 1.5s | 0.2s | 7.5x |
| medium.swf | 15.1s | 1.8s | 8.4x |
| large.swf | 95.2s | 8.5s | 11.2x |

### Cache Statistics

| Metric | Value |
|--------|-------|
| Hit rate (typical) | 85-95% |
| Cache size (default) | 500 MB |
| Entries (large file) | ~5,000 |
| TTL | 168 hours |

---

## Memory Optimization

### Streaming vs Full Load

| File | Full Load | Streaming | Memory Saved |
|------|-----------|-----------|--------------|
| 10 MB | 648 MB | 128 MB | 80% |
| 50 MB | 2.1 GB | 256 MB | 88% |
| 85 MB | 3.6 GB | 384 MB | 89% |

### Garbage Collection Impact

| GC Strategy | Time (large.swf) | Memory |
|-------------|------------------|--------|
| Default | 95.2s | 2.1 GB |
| G1GC | 92.1s | 1.9 GB |
| ZGC | 98.5s | 2.0 GB |
| Shenandoah | 96.3s | 1.8 GB |

**Recommendation:** Use G1GC for best balance.

---

## Platform Comparison

### Windows vs Linux vs macOS

| Operation | Windows | Linux | macOS |
|-----------|---------|-------|-------|
| Decompile (medium) | 15.1s | 14.2s | 15.8s |
| Export images | 22.1s | 20.5s | 23.2s |
| SOL scan | 4.2s | 3.8s | 4.5s |
| Startup time | 2.8s | 2.2s | 3.1s |

**Note:** Linux slightly faster due to filesystem.

---

## Version History

### Performance Over Time

| Version | Decompile | Export | Memory |
|---------|-----------|--------|--------|
| v0.1.0 | 180.5s | 142.3s | 4.2 GB |
| v0.2.0 | 152.3s | 118.5s | 3.8 GB |
| v0.3.0 | 125.8s | 98.2s | 3.5 GB |
| v0.4.0 | 108.2s | 85.5s | 3.2 GB |
| v1.0.0 | 95.2s | 72.4s | 2.1 GB |

**Improvement:** 47% faster, 50% less memory since v0.1.0.

---

## Bottleneck Analysis

### Decompilation Bottlenecks

| Stage | Time % | Description |
|-------|--------|-------------|
| ABC Parsing | 15% | Read bytecode |
| P-Code Gen | 25% | Generate P-code |
| Decompilation | 45% | Convert to AS3 |
| Formatting | 10% | Pretty print |
| I/O | 5% | File operations |

### Optimization Opportunities

| Opportunity | Potential | Difficulty |
|-------------|-----------|------------|
| Native ABC parser | +30% | High |
| Incremental decompile | +50% | Medium |
| Better caching | +20% | Low |
| I/O optimization | +10% | Low |

---

## Benchmark Scripts

### Running Benchmarks

```bash
# Full benchmark suite
python main.py benchmark --all

# Specific benchmark
python main.py benchmark --test decompile --file large.swf

# Compare with FFDec
python main.py benchmark --compare --file medium.swf

# Generate report
python main.py benchmark --report --output benchmark_report.html
```

### Custom Benchmark

```python
from svony.benchmark import Benchmark

bench = Benchmark()

# Time operation
with bench.measure("decompile"):
    decompile_swf("client.swf")

# Memory tracking
with bench.track_memory("export"):
    export_assets("client.swf", "output/")

# Generate report
bench.report("my_benchmark.json")
```

---

## Optimization Tips

### For Speed

1. Enable parallel processing
2. Use SSD storage
3. Increase Java heap
4. Enable caching
5. Use streaming for large files

### For Memory

1. Process in chunks
2. Enable streaming mode
3. Limit cache size
4. Use 64-bit Java
5. Close unused files

---

## Related Documentation

- `PERFORMANCE.md` - Optimization guide
- `CONFIGURATION.md` - Config options
- `CLI_REFERENCE.md` - CLI commands
- `TROUBLESHOOTING.md` - Performance issues

---

*Document Version: 1.0.0 | Performance Benchmarks*
