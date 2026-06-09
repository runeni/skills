#!/bin/bash
# Symlink all skills in this repo into ~/.claude/skills/
SKILLS_DIR="$(cd "$(dirname "$0")" && pwd)"
mkdir -p ~/.claude/skills

for dir in "$SKILLS_DIR"/*/; do
  skill=$(basename "$dir")
  target=~/.claude/skills/"$skill"
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "skip: $skill (already exists)"
  else
    ln -s "$dir" "$target"
    echo "linked: $skill"
  fi
done
