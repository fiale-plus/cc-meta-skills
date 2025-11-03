#!/bin/bash
# Tool call hook - loads skills based on file path in Read/Edit calls

# Get hook directory
HOOK_DIR="$(dirname "$0")"
LIB_DIR="$HOOK_DIR/lib"

# Source utilities
source "$LIB_DIR/session-state.sh"
source "$LIB_DIR/load-skill.sh"

# Tool call parameters (passed by Claude Code)
TOOL_NAME="$1"
TOOL_PARAMS="$2"

# Index file
INDEX_FILE="$LIB_DIR/skill-index.json"

# Initialize session (if not already)
init_session

# Only process Read and Edit tools
if [ "$TOOL_NAME" != "Read" ] && [ "$TOOL_NAME" != "Edit" ]; then
  exit 0
fi

# Check if index exists
if [ ! -f "$INDEX_FILE" ]; then
  # Build index if missing
  "$LIB_DIR/build-skill-index.sh" >&2
fi

# Check if index is empty or jq not available
if ! command -v jq &> /dev/null || [ "$(jq length "$INDEX_FILE" 2>/dev/null)" = "0" ]; then
  exit 0
fi

# Extract file_path from tool params (JSON)
# Example: {"file_path": "src/api/routes/UserRoutes.kt"}
file_path=$(echo "$TOOL_PARAMS" | jq -r '.file_path // empty')

if [ -z "$file_path" ]; then
  exit 0
fi

# Skills to load
declare -a skills_to_load

# Match against skill index paths
while IFS= read -r skill_entry; do
  skill_name=$(echo "$skill_entry" | jq -r '.name')

  # Skip if already loaded
  if is_skill_loaded "$skill_name"; then
    continue
  fi

  skill_paths=$(echo "$skill_entry" | jq -r '.paths[]')

  # Check if file path matches any skill path pattern
  for skill_path in $skill_paths; do
    if [[ "$file_path" == *"$skill_path"* ]]; then
      skills_to_load+=("$skill_name")
      break
    fi
  done
done < <(jq -c '.[]' "$INDEX_FILE")

# Load matched skills
if [ ${#skills_to_load[@]} -gt 0 ]; then
  echo "[Tool call hook: Loading ${#skills_to_load[@]} skill(s) for $file_path]" >&2
  load_skills "${skills_to_load[@]}"
fi

exit 0
