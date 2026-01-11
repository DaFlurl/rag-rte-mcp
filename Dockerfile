# Evony RTE - Docker Container
# Multi-stage build for optimized image size

FROM python:3.11-slim as builder

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# Production stage
FROM python:3.11-slim

WORKDIR /app

# Install runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    tshark \
    ngrep \
    tcpflow \
    && rm -rf /var/lib/apt/lists/*

# Copy Python packages from builder
COPY --from=builder /root/.local /root/.local
ENV PATH=/root/.local/bin:$PATH

# Copy application code
COPY evony_rte/ ./evony_rte/
COPY evony_bot/ ./evony_bot/
COPY AS3_Scripts_*/ ./AS3_Scripts/

# Create necessary directories
RUN mkdir -p /app/evony_rte/logs /app/evony_rte/re_output

# Environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app
ENV BOT_SERVER_PORT=9999
ENV MCP_SERVER_PORT=8080

# Expose ports
EXPOSE 9999
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import requests; requests.get('http://localhost:9999/api/status')" || exit 1

# Default command: Start MCP server with bot
CMD ["python", "-m", "evony_rte.mcp_server"]
