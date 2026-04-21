#!/bin/bash

echo "🚀 Starting OpenClaw..."

# Restore from backup
echo "📥 Restoring workspace..."
python3 /app/backup.py --restore

# Set environment defaults
export OPENCLAW_LLM_API_KEY="${OPENCLAW_LLM_API_KEY:-}"
export OPENCLAW_LLM_MODEL="${OPENCLAW_LLM_MODEL:-openrouter/google/gemma-4-31b-it:free}"
export OPENCLAW_GATEWAY_PORT="${PORT:-10000}"

# Start backup daemon
echo "💾 Starting backup daemon..."
python3 /app/backup.py &

# Start OpenClaw gateway
echo "🤖 Starting OpenClaw gateway on port ${OPENCLAW_GATEWAY_PORT}..."
openclaw gateway start &

# Keep the container running
wait