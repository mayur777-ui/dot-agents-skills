#!/usr/bin/env bash
# Syncs My_Agent_Skills to Antigravity global configuration on Linux/macOS

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$(cd "$SCRIPT_DIR/../skills" && pwd)"
GEMINI_CONFIG_DIR="$HOME/.gemini/config"
SKILLS_CONFIG_FILE="$GEMINI_CONFIG_DIR/skills.json"

echo "Syncing My_Agent_Skills to Antigravity..."
echo "Skills Path: $SKILLS_DIR"

mkdir -p "$GEMINI_CONFIG_DIR"

# Write or update skills.json using python or node if available, fallback to jq/cat
python3 -c "
import json, os

config_path = '$SKILLS_CONFIG_FILE'
skills_path = '$SKILLS_DIR'

data = {'entries': []}
if os.path.exists(config_path):
    try:
        with open(config_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
            if 'entries' not in data:
                data['entries'] = []
    except Exception:
        pass

if not any(e.get('path') == skills_path for e in data['entries']):
    data['entries'].append({'path': skills_path})
    with open(config_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2)
    print('Registered skills path in:', config_path)
else:
    print('Skills path is already registered in:', config_path)
"

echo "Sync complete!"
