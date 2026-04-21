# 🎉 Your OpenClaw Render Tool is Ready!

## 📍 Location

All files are in:
```
/home/openclaw/.openclaw/workspace/openclaw-render/
```

---

## 📦 What's Included

✅ `Dockerfile` — Container configuration with Node.js v22
✅ `backup.py` — Auto-backup to GitHub Gist
✅ `start.sh` — Startup script with auto-restore
✅ `render.yaml` — One-click deploy config
✅ `README.md` — Complete documentation
✅ `.gitignore` — Git ignore file
✅ `setup.sh` — Quick setup script

---

## 🚀 3 Steps to Deploy

### Step 1: Push to GitHub

```bash
# Navigate to the directory
cd /home/openclaw/.openclaw/workspace/openclaw-render/

# Run the setup script
bash setup.sh
```

The script will:
- Initialize git repository
- Add all files
- Commit them

Then you need to:
1. Create GitHub repo: `openclaw-render`
2. Add remote:
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/openclaw-render.git
   ```
3. Push:
   ```bash
   git push -u origin main
   ```

---

### Step 2: Get API Keys

**Required:**

1. **OpenRouter API Key (Free)**
   - Go to: https://openrouter.ai/keys
   - Sign up free
   - Create API key
   - Copy it

2. **GitHub Token (for backup)**
   - Go to: https://github.com/settings/tokens
   - Create new token (classic)
   - Name: `OpenClaw Backup`
   - **ONLY check:** ☑️ `gist`
   - Create and copy token

**Optional (for 24/7):**

3. **UptimeRobot API Key**
   - Go to: https://uptimerobot.com
   - Sign up free
   - Go to Settings → API Settings
   - Copy "Main API Key"

---

### Step 3: Deploy to Render

**One-Click Deploy:**

Click this link (replace YOUR_USERNAME with your GitHub username):
```
https://render.com/deploy?repo=https://github.com/YOUR_USERNAME/openclaw-render
```

**Or Manual Deploy:**

1. Go to: https://dashboard.render.com
2. Click **"New +"** → **"Web Service"**
3. Connect GitHub
4. Select `openclaw-render` repo
5. Click **"Connect"**

---

## ⚙️ Add Environment Variables

In Render, add these:

| Key | Value | Required |
|-----|-------|----------|
| `OPENCLAW_LLM_API_KEY` | Your OpenRouter key | ✅ Yes |
| `GITHUB_GIST_TOKEN` | Your GitHub token | ✅ Yes |
| `OPENCLAW_LLM_MODEL` | `openrouter/google/gemma-4-31b-it:free` | Optional |
| `UPTIMEROBOT_API_KEY` | Your UptimeRobot key | Optional |

Then click **"Create Web Service"** and wait 2-5 minutes.

---

## ✅ What You Get

- ✅ **OpenClaw running** on Render (free tier)
- ✅ **Auto-backup** every 2 minutes
- ✅ **Auto-restore** on startup
- ✅ **24/7 uptime** with UptimeRobot
- ✅ **Free AI model** (Gemma 4)
- ✅ **Never lose data**
- ✅ **Zero copy-paste** needed!

---

## 🌐 After Deployment

Your URLs will be:
- **OpenClaw:** `https://openclaw-24-7.onrender.com`
- **Health:** `https://openclaw-24-7.onrender.com/health`

Check your backups at: https://gist.github.com

---

## 📖 Full Documentation

Read `README.md` for complete documentation and troubleshooting.

---

## 🎯 That's It!

Just push to GitHub and deploy to Render. Everything else is automatic!

No copy-paste, no manual setup. Just 3 steps!

---

**Need help? Check README.md for troubleshooting!**