#!/bin/bash

echo "🚀 Starting OpenClaw..."

# Restore from backup
echo "📥 Restoring workspace..."
python3 /app/backup.py --restore

# Set environment defaults
export OPENCLAW_LLM_API_KEY="${OPENCLAW_LLM_API_KEY:-}"
export OPENCLAW_LLM_MODEL="${OPENCLAW_LLM_MODEL:-openrouter/google/gemma-4-31b-it:free}"

# Configure OpenClaw if not configured
if [ ! -f ~/.openclaw/config.json ]; then
    echo "⚙️  Configuring OpenClaw..."
    openclaw config set gateway.mode local --silent
    openclaw config set models.default "${OPENCLAW_LLM_MODEL}" --silent
    openclaw config set models.apiKey "${OPENCLAW_LLM_API_KEY}" --silent
    echo "✅ Configuration complete"
fi

# Use Render's PORT variable, default to 10000
GATEWAY_PORT="${PORT:-10000}"

# Start backup daemon
echo "💾 Starting backup daemon..."
python3 /app/backup.py &

# Start OpenClaw gateway
echo "🤖 Starting OpenClaw gateway on port ${GATEWAY_PORT}..."
openclaw gateway --port ${GATEWAY_PORT}

# Keep the container running
wait