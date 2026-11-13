#!/usr/bin/env bash
# Dynamically links all repository skills to ~/.gemini/config/skills on Linux/macOS

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_SKILLS_DIR="$(cd "$SCRIPT_DIR/../skills" && pwd)"
GLOBAL_SKILLS_DIR="$HOME/.gemini/config/skills"

echo "Syncing skills to Antigravity..."
echo "Source: $REPO_SKILLS_DIR"
echo "Target: $GLOBAL_SKILLS_DIR"

mkdir -p "$GLOBAL_SKILLS_DIR"

count=0
for skill_path in "$REPO_SKILLS_DIR"/*; do
  if [ -d "$skill_path" ]; then
    skill_name=$(basename "$skill_path")
    dest_path="$GLOBAL_SKILLS_DIR/$skill_name"
    
    # Remove existing link or directory if present
    rm -rf "$dest_path"
    
    # Create live symlink
    ln -s "$skill_path" "$dest_path"
    echo "  🔗 Linked: $skill_name"
    count=$((count + 1))
  fi
done

echo ""
echo "✅ Successfully synced $count skills to Antigravity!"
echo "Note: Start a new chat in Antigravity to load new skills into the prompt."
