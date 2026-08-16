#!/usr/bin/env bash
# One-time setup: clone the Overleaf project and connect it to GitHub.
# Run this on your own machine. It only needs to be run once.
#
#   bash setup.sh
#
# You will be prompted for your Overleaf Git token (Overleaf ->
# Account Settings -> Git Integration -> Generate token). The token is never
# written to disk by this script.

set -euo pipefail

OVERLEAF_URL="https://git@git.overleaf.com/6a74bdf66d6f76613d1938c0"
GITHUB_URL="https://github.com/kzhao5/ICLR_icepop.git"
DIR="icepop-paper"

if [ -e "$DIR" ]; then
  echo "error: '$DIR' already exists here. Move it aside or cd elsewhere." >&2
  exit 1
fi

echo "Cloning from Overleaf. When asked for a password, paste your Overleaf"
echo "Git token (nothing will appear as you type -- that is normal)."
echo
git clone "$OVERLEAF_URL" "$DIR"

cd "$DIR"

git remote rename origin overleaf
git remote add origin "$GITHUB_URL"

BRANCH="$(git branch --show-current)"
echo
echo "Overleaf branch is '$BRANCH'. Pushing it to GitHub..."
git push -u origin "$BRANCH"

echo
echo "Done. Remotes:"
git remote -v
echo
echo "From now on, sync with:  cd $DIR && ./sync.sh"
