#!/bin/bash
# ─────────────────────────────────────────────
#  Run this from your OLD machine to push
#  files to the new Fedora machine.
#
#  Usage: ./sync.sh user@new-machine-ip
# ─────────────────────────────────────────────

TARGET=$1

if [ -z "$TARGET" ]; then
  echo "Usage: ./sync.sh user@<new-machine-ip>"
  exit 1
fi

echo "→ Copying projects..."
rsync -avz --progress \
  --exclude='.git' \
  --exclude='node_modules' \
  --exclude='__pycache__' \
  --exclude='.venv' \
  --exclude='target' \
  --exclude='build' \
  ~/projects/ \
  $TARGET:~/projects/

echo "✓ Done"
