# ============================================================
# OpenClaw on Render.com
# Fresh setup with auto-backup and 24/7 uptime
# ============================================================

FROM node:22-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    curl \
    git \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Install OpenClaw
RUN npm install -g openclaw@latest

# Install Python dependencies
RUN pip3 install --no-cache-dir requests --break-system-packages

# Create workspace directory
RUN mkdir -p /root/.openclaw/workspace /app

WORKDIR /app

# Copy backup script
COPY backup.py /app/backup.py

# Copy startup script
COPY start.sh /app/start.sh

# Make scripts executable
RUN chmod +x /app/start.sh /app/backup.py

# Environment defaults
ENV NODE_ENV=production
ENV PORT=10000

# Expose port (Render uses PORT env var)
EXPOSE 10000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl -f http://localhost:${PORT}/health || exit 1

# Startup command
CMD ["/bin/bash", "/app/start.sh"]