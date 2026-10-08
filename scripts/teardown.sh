#!/bin/bash
set -e

echo "🧹 Cleaning up bootstrap setup..."

# 1. Remove Git pre-push hook
if [ -f .git/hooks/pre-push ]; then
  echo "🔧 Removing Git pre-push hook..."
  rm .git/hooks/pre-push
else
  echo "ℹ️ No pre-push hook found."
fi

# 2. Delete sample release tag
if git rev-parse v0.1.0 >/dev/null 2>&1; then
  echo "🏷️ Deleting sample tag v0.1.0..."
  git tag -d v0.1.0
  git push origin :refs/tags/v0.1.0
else
  echo "ℹ️ No sample tag v0.1.0 found."
fi

# 3. Reset secrets placeholders
if [ -f .github/secrets.env ]; then
  echo "🔑 Resetting secrets placeholders..."
  rm .github/secrets.env
else
  echo "ℹ️ No secrets.env file found."
fi

echo "✅ Cleanup complete! Repo is back to a clean state."
