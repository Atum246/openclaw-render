#!/bin/bash

echo "🚀 OpenClaw Render Setup Script"
echo "================================"
echo ""

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📦 Initializing git repository..."
    git init
else
    echo "✅ Git already initialized"
fi

# Check if remote is set
if git remote get-url origin > /dev/null 2>&1; then
    echo "✅ Git remote already set to: $(git remote get-url origin)"
else
    echo "⚠️  No git remote set. Please run:"
    echo "   git remote add origin https://github.com/YOUR_USERNAME/openclaw-render.git"
    echo ""
    read -p "Press Enter to continue after setting remote..."
fi

# Add all files
echo ""
echo "📝 Adding files to git..."
git add .

# Commit
echo ""
echo "💾 Committing changes..."
git commit -m "Initial OpenClaw Render setup"

echo ""
echo "✅ Ready to push!"
echo ""
echo "📌 Next steps:"
echo "   1. Create a GitHub repo called 'openclaw-render'"
echo "   2. Add remote: git remote add origin https://github.com/YOUR_USERNAME/openclaw-render.git"
echo "   3. Push: git push -u origin main"
echo "   4. Deploy to Render: https://render.com/deploy?repo=https://github.com/YOUR_USERNAME/openclaw-render"
echo ""
echo "📖 See README.md for deployment instructions!"