#!/bin/bash
# Session start hook - builds skill index and displays summary

# Get hook directory
HOOK_DIR="$(dirname "$0")"
LIB_DIR="$HOOK_DIR/lib"

# Build skill index
"$LIB_DIR/build-skill-index.sh" 2>&1

INDEX_FILE="$LIB_DIR/skill-index.json"

# Check if any skills were indexed
if [ ! -f "$INDEX_FILE" ] || ! command -v jq &> /dev/null; then
  exit 0
fi

skill_count=$(jq length "$INDEX_FILE" 2>/dev/null || echo "0")

if [ "$skill_count" -eq "0" ]; then
  exit 0
fi

# Display summary
echo "📚 Project Skills Available ($skill_count skills):"
echo ""

# List skills with their covered paths
jq -r '.[] | "- \(.name) → \(.paths | join(", "))"' "$INDEX_FILE"

echo ""
echo "Skills will auto-load when working on relevant files."
echo ""

exit 0
