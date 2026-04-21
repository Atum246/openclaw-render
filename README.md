# OpenClaw on Render — One-Click Deploy

🚀 **Complete OpenClaw setup on Render with auto-backup and 24/7 uptime**

## ✨ Features

- ✅ OpenClaw running on Render (free tier)
- ✅ Auto-backup every 2 minutes to GitHub Gist
- ✅ Auto-restore on startup — never lose data
- ✅ 24/7 uptime with UptimeRobot integration
- ✅ Free AI model (Google Gemma 4)
- ✅ Zero configuration needed
- ✅ Just deploy and go!

---

## 🚀 Quick Start (5 Minutes)

### Step 1: Get API Keys

**OpenRouter Key (Free LLM):**
1. Go to: https://openrouter.ai/keys
2. Sign up free
3. Create API key
4. Copy it

**GitHub Token (for backup):**
1. Go to: https://github.com/settings/tokens
2. Create new token (classic)
3. Name it: `OpenClaw Backup`
4. **ONLY check:** ☑️ `gist`
5. Create and copy token

**UptimeRobot Key (for 24/7):**
1. Go to: https://uptimerobot.com
2. Sign up free
3. Go to Settings → API Settings
4. Copy your "Main API Key"

---

### Step 2: Deploy to Render

**Option A: One-Click Deploy (Easiest)**

Click this link:
```
https://render.com/deploy?repo=https://github.com/YOUR_USERNAME/openclaw-render
```

**Option B: Manual Deploy**

1. Go to: https://dashboard.render.com
2. Click **"New +"** → **"Web Service"**
3. Connect GitHub
4. Select `openclaw-render` repo
5. Click **"Connect"**

---

### Step 3: Add Environment Variables

In Render, add these variables:

| Key | Value | Required |
|-----|-------|----------|
| `OPENCLAW_LLM_API_KEY` | Your OpenRouter key | ✅ Yes |
| `GITHUB_GIST_TOKEN` | Your GitHub token | ✅ Yes |
| `OPENCLAW_LLM_MODEL` | `openrouter/google/gemma-4-31b-it:free` | Optional |
| `UPTIMEROBOT_API_KEY` | Your UptimeRobot key | Optional |

---

### Step 4: Deploy!

Click **"Create Web Service"** and wait 2-5 minutes.

That's it! 🎉

---

## 🎯 What Happens Automatically

### Auto-Backup Every 2 Minutes

- Your workspace backs up to GitHub Gist
- Check your backups at: https://gist.github.com
- Look for gist: "OpenClaw Workspace Backup"

### Auto-Restore on Startup

- When Render restarts your service, workspace is restored
- Never lose your conversations or data
- Completely automatic

### 24/7 Uptime

- UptimeRobot pings your service every 5 minutes
- Prevents Render from sleeping
- Your AI assistant stays awake 24/7

---

## 🔍 Verify It's Working

### 1. Check Your Service

- Open your Render URL
- You should see the OpenClaw web interface
- Try sending a message

### 2. Check Backup

- Go to: https://gist.github.com
- Look for "OpenClaw Workspace Backup"
- If you see it, backup is working! ✅

### 3. Check UptimeRobot

- Go to: https://uptimerobot.com
- Check your monitor status
- Green = Running ✅

---

## 🌐 Your URLs

After deployment, you'll have:

- **OpenClaw:** `https://openclaw-24-7.onrender.com`
- **Health Check:** `https://openclaw-24-7.onrender.com/health`

---

## 📝 How It Works

### Architecture

```
Render Container
├── OpenClaw Gateway (port 7860)
│   └── Serves web interface and API
├── Backup Daemon (Python)
│   └── Backs up to GitHub Gist every 2 min
└── Health Check
    └── Monitors service health
```

### Data Flow

1. **You use OpenClaw** → Data saved in workspace
2. **Backup daemon runs** → Packs workspace → Uploads to GitHub Gist
3. **Render restarts** → Startup script runs → Restores from Gist → You continue where you left off
4. **UptimeRobot pings** → Keeps service awake → 24/7 uptime

---

## 🔧 Environment Variables

### Required

| Variable | Description | How to Get |
|----------|-------------|------------|
| `OPENCLAW_LLM_API_KEY` | OpenRouter API key for AI | https://openrouter.ai/keys |
| `GITHUB_GIST_TOKEN` | GitHub token for backup | https://github.com/settings/tokens |

### Optional

| Variable | Description | Default |
|----------|-------------|---------|
| `OPENCLAW_LLM_MODEL` | AI model to use | `openrouter/google/gemma-4-31b-it:free` |
| `UPTIMEROBOT_API_KEY` | UptimeRobot API key for 24/7 | (none) |

---

## 💡 Tips

### Changing AI Model

1. Go to Render dashboard
2. Your service → Environment
3. Change `OPENCLAW_LLM_MODEL`
4. Save — auto-restarts

See free models at: https://openrouter.ai/models?free=true

### Check Backup Status

```bash
# Check Render logs for backup messages
# Look for:
# ✅ Backup updated!
# ✅ Backup created!
```

### Restore Manually

```bash
# SSH into Render container (if needed)
python3 /app/backup.py --restore
```

### View Backup Data

1. Go to: https://gist.github.com
2. Find "OpenClaw Workspace Backup"
3. Download and extract `workspace-backup.tar.gz`

---

## 🚨 Troubleshooting

### Service won't start

1. Check environment variables are set
2. Check Render logs for errors
3. Make sure both API keys are valid

### Backup not working

1. Check `GITHUB_GIST_TOKEN` is set
2. Check token has `gist` scope
3. Check GitHub gists for new gist

### Service sleeps

1. Check `UPTIMEROBOT_API_KEY` is set
2. Check UptimeRobot status is green
3. Add UptimeRobot monitor manually

### Can't access web interface

1. Wait 2-3 minutes after deployment
2. Check service status in Render dashboard
3. Try `/health` endpoint

---

## 📊 Free Tier Limits

Render Free Tier:
- 512MB RAM
- 0.1 CPU
- Spins down after 15 min (we prevent this with UptimeRobot)
- Limited bandwidth

OpenRouter Free:
- 50 requests/day
- Free models available

GitHub Gist:
- Unlimited
- Perfect for backups

UptimeRobot:
- 50 monitors free
- Perfect for 24/7 uptime

---

## 🎯 Next Steps

### Add a Custom Domain

1. Purchase domain (e.g., Namecheap)
2. Add in Render settings
3. SSL is automatic

### Add More Channels

Create environment variables for:
- `TELEGRAM_BOT_TOKEN`
- `TELEGRAM_USER_ID`
- `WHATSAPP_ENABLED=true`
- `DISCORD_TOKEN`

### Customize OpenClaw

Create files in workspace:
- `SOUL.md` — Personality
- `IDENTITY.md` — Identity
- `USER.md` — User info
- `MEMORY.md` — Long-term memory

These get auto-backed up!

---

## 📚 Resources

- **OpenClaw Docs:** https://docs.openclaw.ai
- **Render Docs:** https://render.com/docs
- **OpenRouter:** https://openrouter.ai
- **UptimeRobot:** https://uptimerobot.com

---

## 🎉 Enjoy Your 24/7 AI Assistant!

Your OpenClaw is now running forever with:
- ✅ Automatic backups
- ✅ Automatic restore
- ✅ 24/7 uptime
- ✅ Never lose data
- ✅ Completely FREE

---

Made with ❤️ for the OpenClaw community