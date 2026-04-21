#!/usr/bin/env python3
"""
Auto-backup OpenClaw workspace to GitHub Gist
"""

import os
import json
import tarfile
import base64
import requests
from pathlib import Path
import time

# Configuration
WORKSPACE_PATH = os.path.expanduser("~/.openclaw/workspace")
GIST_TOKEN = os.environ.get("GITHUB_GIST_TOKEN", "")
GIST_ID = os.environ.get("GITHUB_GIST_ID", "")
STATE_FILE = Path(WORKSPACE_PATH) / ".backup-state.json"

def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}")

def pack_workspace():
    """Pack workspace into tar.gz"""
    tar_path = "/tmp/workspace-backup.tar.gz"
    ws = Path(WORKSPACE_PATH)

    with tarfile.open(tar_path, "w:gz") as tar:
        if ws.exists():
            for item in ws.rglob("*"):
                if item.is_file() and not any(p.startswith('.') for p in item.parts):
                    tar.add(item, arcname=item.relative_to(ws))

    with open(tar_path, "rb") as f:
        return base64.b64encode(f.read()).decode()

def save_state(gist_id):
    """Save Gist ID to workspace"""
    STATE_FILE.parent.mkdir(parents=True, exist_ok=True)
    with open(STATE_FILE, "w") as f:
        json.dump({"gist_id": gist_id, "last_backup": time.time()}, f)

def load_state():
    """Load Gist ID from workspace"""
    if STATE_FILE.exists():
        try:
            return json.loads(STATE_FILE.read_text())
        except:
            pass
    return {}

def create_gist(content):
    """Create new gist"""
    headers = {"Authorization": f"token {GIST_TOKEN}"}
    data = {
        "description": "OpenClaw Workspace Backup",
        "public": False,
        "files": {
            "workspace-backup.tar.gz": {
                "content": content
            }
        }
    }
    resp = requests.post("https://api.github.com/gists", json=data, headers=headers)
    if resp.status_code == 201:
        return resp.json()["id"]
    return None

def update_gist(gist_id, content):
    """Update existing gist"""
    headers = {"Authorization": f"token {GIST_TOKEN}"}
    data = {
        "files": {
            "workspace-backup.tar.gz": {
                "content": content
            }
        }
    }
    resp = requests.patch(f"https://api.github.com/gists/{gist_id}", json=data, headers=headers)
    return resp.status_code == 200

def backup():
    """Run backup"""
    if not GIST_TOKEN:
        log("❌ GITHUB_GIST_TOKEN not set!")
        return

    state = load_state()
    gist_id = state.get("gist_id") or GIST_ID

    log("🔄 Packing workspace...")
    content = pack_workspace()

    if gist_id:
        log(f"📤 Updating gist {gist_id}...")
        if update_gist(gist_id, content):
            log("✅ Backup updated!")
        else:
            log("❌ Update failed, trying new gist...")
            gist_id = create_gist(content)
            if gist_id:
                save_state(gist_id)
                log(f"✅ New gist created: {gist_id}")
    else:
        log("📤 Creating new gist...")
        gist_id = create_gist(content)
        if gist_id:
            save_state(gist_id)
            log(f"✅ Backup created: {gist_id}")

def restore():
    """Restore from backup"""
    state = load_state()
    gist_id = state.get("gist_id") or GIST_ID

    if not gist_id or not GIST_TOKEN:
        log("ℹ️ No backup found")
        return False

    log(f"📥 Restoring from gist {gist_id}...")

    headers = {"Authorization": f"token {GIST_TOKEN}"}
    resp = requests.get(f"https://api.github.com/gists/{gist_id}", headers=headers)

    if resp.status_code != 200:
        log("❌ Failed to fetch gist")
        return False

    gist = resp.json()
    files = gist.get("files", {})

    if "workspace-backup.tar.gz" not in files:
        log("❌ No backup file in gist")
        return False

    content = files["workspace-backup.tar.gz"]["content"]
    tar_data = base64.b64decode(content)

    tar_path = "/tmp/restore-backup.tar.gz"
    with open(tar_path, "wb") as f:
        f.write(tar_data)

    ws = Path(WORKSPACE_PATH)
    ws.mkdir(parents=True, exist_ok=True)

    with tarfile.open(tar_path, "r:gz") as tar:
        tar.extractall(ws)

    log("✅ Workspace restored!")
    return True

if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1 and sys.argv[1] == "--restore":
        restore()
    else:
        backup()