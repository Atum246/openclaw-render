#!/bin/bash

echo "🚀 Starting OpenClaw..."

# Restore from backup
echo "📥 Restoring workspace..."
python3 /app/backup.py --restore

# Set environment defaults
export OPENCLAW_LLM_API_KEY="${OPENCLAW_LLM_API_KEY:-}"
export OPENCLAW_LLM_MODEL="${OPENCLAW_LLM_MODEL:-openrouter/google/gemma-4-31b-it:free}"
export GATEWAY_PORT="${GATEWAY_PORT:-7860}"

# Start backup daemon
echo "💾 Starting backup daemon..."
python3 /app/backup.py &

# Start OpenClaw gateway
echo "🤖 Starting OpenClaw gateway on port ${GATEWAY_PORT}..."
openclaw gateway start --port ${GATEWAY_PORT} &

# Keep the container running
wait