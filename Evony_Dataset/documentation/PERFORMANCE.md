# Svony Studio - Performance Guide

> **"Optimization and Tuning"** - Getting the Best Performance

---

## Overview

This guide covers performance optimization for Svony Studio operations, from SWF decompilation to batch processing.

---

## System Requirements

### Minimum vs Recommended

| Component | Minimum | Recommended | Optimal |
|-----------|---------|-------------|---------|
| **CPU** | 4 cores | 8 cores | 16+ cores |
| **RAM** | 8 GB | 16 GB | 32+ GB |
| **Storage** | HDD | SSD | NVMe SSD |
| **Java Heap** | 2 GB | 4 GB | 8 GB |

### Memory Configuration

```bash
# Set Java heap for FFDec
set JAVA_OPTS=-Xmx4g -Xms2g

# Or in config/settings.yaml
java:
  heap_max: 4g
  heap_min: 2g
```

---

## Benchmarks

### SWF Decompilation Times

| File Size | FFDec Direct | Svony Studio | Overhead |
|-----------|--------------|--------------|----------|
| 1 MB | 2s | 2.5s | +25% |
| 10 MB | 15s | 18s | +20% |
| 50 MB | 90s | 110s | +22% |
| 100 MB | 200s | 250s | +25% |

### Asset Export Times

| Operation | 1000 Assets | 10000 Assets |
|-----------|-------------|--------------|
| Images (PNG) | 30s | 5min |
| Scripts (AS3) | 45s | 8min |
| All Assets | 2min | 20min |

### SOL Operations

| Operation | Time (typical) |
|-----------|---------------|
| Scan system | 5-30s |
| Read SOL | <100ms |
| Write SOL | <100ms |
| Batch (100 files) | 10s |

---

## Optimization Techniques

### Parallel Processing

```python
# Enable parallel decompilation
config = {
    "parallel": True,
    "workers": os.cpu_count(),  # Use all cores
    "chunk_size": 100  # Methods per chunk
}

# CLI
python main.py swf decompile large.swf --parallel --workers 8
```

### Memory Management

```python
# For large files, use streaming
class StreamingSWFProcessor:
    def process_large_swf(self, filepath):
        # Process tags incrementally
        for tag in self.iter_tags(filepath):
            self.process_tag(tag)
            
            # Release memory periodically
            if self.processed_count % 1000 == 0:
                gc.collect()
```

### Disk I/O Optimization

```python
# Use buffered I/O
BUFFER_SIZE = 64 * 1024  # 64KB

with open(filepath, 'rb', buffering=BUFFER_SIZE) as f:
    data = f.read()

# Write in batches
with open(output, 'w', buffering=BUFFER_SIZE) as f:
    for item in items:
        f.write(item)
```

### Caching

```python
# Enable decompilation cache
config = {
    "cache": {
        "enabled": True,
        "directory": ".cache/",
        "max_size_mb": 500,
        "ttl_hours": 168  # 1 week
    }
}

# Check cache before decompiling
def decompile_with_cache(swf_hash, method_id):
    cache_key = f"{swf_hash}_{method_id}"
    
    if cache.has(cache_key):
        return cache.get(cache_key)
    
    result = decompile(method_id)
    cache.set(cache_key, result)
    return result
```

---

## FFDec Optimization

### Command Line Tuning

```bash
# Faster decompilation (skip some checks)
ffdec -cli -export script output.dir client.swf -format as -selectas3class

# Skip P-code generation
ffdec -cli -export script output.dir client.swf -format as -onerror ignore

# Parallel export
ffdec -cli -export script output.dir client.swf -format as -exportMode export -parallelSpeedUp
```

### Memory Settings

```bash
# Edit ffdec.bat or ffdec.sh
java -Xmx8g -XX:+UseG1GC -jar ffdec.jar %*
```

### Configuration File

```
# ffdec.properties
export.parallel=true
cache.maxsize=1000
decompile.timeout=300
```

---

## Batch Processing

### Efficient Batch Export

```python
def batch_export_optimized(swf_files, output_dir):
    """Optimized batch export with parallelism."""
    
    from concurrent.futures import ProcessPoolExecutor, as_completed
    
    results = []
    
    with ProcessPoolExecutor(max_workers=os.cpu_count()) as executor:
        futures = {
            executor.submit(export_swf, swf, output_dir): swf
            for swf in swf_files
        }
        
        for future in as_completed(futures):
            swf = futures[future]
            try:
                result = future.result()
                results.append(("success", swf, result))
            except Exception as e:
                results.append(("error", swf, str(e)))
    
    return results
```

### Progress Monitoring

```python
from tqdm import tqdm

def batch_with_progress(files):
    with tqdm(total=len(files), desc="Processing") as pbar:
        for f in files:
            process(f)
            pbar.update(1)
```

---

## Network Performance

### Connection Pooling

```python
import aiohttp

class ConnectionPool:
    def __init__(self, max_connections=10):
        self.connector = aiohttp.TCPConnector(
            limit=max_connections,
            keepalive_timeout=30
        )
        self.session = None
    
    async def get_session(self):
        if self.session is None:
            self.session = aiohttp.ClientSession(connector=self.connector)
        return self.session
```

### Async Operations

```python
import asyncio

async def fetch_all_cities(client, city_ids):
    """Fetch multiple cities concurrently."""
    tasks = [
        client.get_city_info(city_id)
        for city_id in city_ids
    ]
    
    return await asyncio.gather(*tasks, return_exceptions=True)
```

### Rate Limiting

```python
from asyncio import Semaphore

class RateLimiter:
    def __init__(self, max_per_second=10):
        self.semaphore = Semaphore(max_per_second)
        self.last_reset = time.time()
    
    async def acquire(self):
        # Reset semaphore every second
        now = time.time()
        if now - self.last_reset >= 1.0:
            self.semaphore = Semaphore(self.max_per_second)
            self.last_reset = now
        
        await self.semaphore.acquire()
```

---

## UI Performance

### Lazy Loading

```python
class LazyTreeView:
    """Load tree nodes on demand."""
    
    def on_expand(self, node):
        if not node.children_loaded:
            children = self.load_children(node.path)
            for child in children:
                node.add_child(child)
            node.children_loaded = True
```

### Virtual Scrolling

```python
class VirtualList:
    """Only render visible items."""
    
    def __init__(self, items, visible_count=50):
        self.items = items
        self.visible_count = visible_count
        self.scroll_offset = 0
    
    def get_visible_items(self):
        start = self.scroll_offset
        end = start + self.visible_count
        return self.items[start:end]
```

### Async Updates

```python
import threading

def update_ui_async(callback, *args):
    """Run callback on UI thread."""
    root.after(0, lambda: callback(*args))

def long_operation():
    result = do_expensive_work()
    update_ui_async(display_result, result)

# Start in background
threading.Thread(target=long_operation).start()
```

---

## Profiling

### Python Profiling

```python
import cProfile
import pstats

def profile_operation():
    profiler = cProfile.Profile()
    profiler.enable()
    
    # Your code here
    result = expensive_operation()
    
    profiler.disable()
    stats = pstats.Stats(profiler)
    stats.sort_stats('cumulative')
    stats.print_stats(20)  # Top 20 functions
    
    return result
```

### Memory Profiling

```python
from memory_profiler import profile

@profile
def memory_intensive_function():
    large_list = [i for i in range(1000000)]
    process(large_list)
```

### CLI Profiling

```bash
# Profile with cProfile
python -m cProfile -s cumulative main.py swf decompile large.swf

# Memory profiling
python -m memory_profiler main.py swf decompile large.swf
```

---

## Performance Configuration

### Recommended Settings

```yaml
# config/performance.yaml
performance:
  parallel:
    enabled: true
    max_workers: auto  # Use CPU count
  
  cache:
    enabled: true
    max_size_mb: 1000
    preload: false
  
  memory:
    gc_threshold: 1000  # Items before GC
    max_heap_percent: 75
  
  io:
    buffer_size: 65536
    async_writes: true
```

### Environment-Specific

```yaml
# Development - prioritize debugging
development:
  parallel: false
  cache: false
  logging: DEBUG

# Production - prioritize speed
production:
  parallel: true
  cache: true
  logging: WARNING
```

---

## Troubleshooting Performance

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Slow decompilation | Low memory | Increase Java heap |
| UI freezing | Blocking operations | Use async/threading |
| High memory usage | Large files | Use streaming |
| Disk thrashing | Small I/O operations | Use buffering |

### Diagnostic Commands

```bash
# Check system resources
python main.py diag system

# Profile specific operation
python main.py diag profile --operation decompile --file large.swf

# Memory analysis
python main.py diag memory --snapshot before --snapshot after
```

---

## Best Practices Summary

1. **Use parallel processing** for batch operations
2. **Enable caching** for repeated operations
3. **Increase Java heap** for large files
4. **Use SSD storage** for better I/O
5. **Profile before optimizing** - measure first
6. **Lazy load** large data structures
7. **Buffer I/O** operations
8. **Monitor memory** usage
9. **Use async** for network operations
10. **Clean up** temporary files

---

## Related Documentation

- `CONFIGURATION.md` - Config settings
- `CLI_REFERENCE.md` - CLI options
- `TROUBLESHOOTING.md` - Problem solving
- `DEVELOPER_GUIDE.md` - Development

---

*Document Version: 1.0.0 | Performance Guide*
