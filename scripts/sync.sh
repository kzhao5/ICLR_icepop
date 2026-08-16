#!/usr/bin/env bash
# Pull the latest from Overleaf, then push it to GitHub.
# Copy this into your cloned project directory and run it whenever you want
# GitHub to catch up with what you have written in Overleaf.
#
#   ./sync.sh              # Overleaf -> local -> GitHub
#   ./sync.sh --to-overleaf  # also push local commits back to Overleaf

set -euo pipefail
cd "$(dirname "$0")"

BRANCH="$(git branch --show-current)"

echo "==> pulling from Overleaf ($BRANCH)"
git pull --rebase overleaf "$BRANCH"

if [ "${1:-}" = "--to-overleaf" ]; then
  echo "==> pushing local commits back to Overleaf"
  git push overleaf "$BRANCH"
fi

echo "==> pushing to GitHub"
git push origin "$BRANCH"

echo "synced at $(date)"
