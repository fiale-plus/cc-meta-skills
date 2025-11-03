#!/bin/bash
# User input hook - loads skills based on keywords and file paths in user message

# Get hook directory
HOOK_DIR="$(dirname "$0")"
LIB_DIR="$HOOK_DIR/lib"

# Source utilities
source "$LIB_DIR/session-state.sh"
source "$LIB_DIR/load-skill.sh"

# User message is first argument
USER_MESSAGE="$1"

# Index file
INDEX_FILE="$LIB_DIR/skill-index.json"

# Initialize session (if not already)
init_session

# Check if index exists
if [ ! -f "$INDEX_FILE" ]; then
  # Build index if missing
  "$LIB_DIR/build-skill-index.sh" >&2
fi

# Check if index is empty
if ! command -v jq &> /dev/null || [ "$(jq length "$INDEX_FILE" 2>/dev/null)" = "0" ]; then
  # No skills or jq not available, exit gracefully
  exit 0
fi

# Extract file paths from message (simple pattern matching)
# Matches: src/api/file.kt, /path/to/file.ts, etc.
file_paths=$(echo "$USER_MESSAGE" | grep -oE '[a-zA-Z0-9_/-]+\.[a-z]+' | sort -u)

# Extract keywords (lowercase words, 3+ chars)
keywords=$(echo "$USER_MESSAGE" | tr '[:upper:]' '[:lower:]' | grep -oE '\b[a-z]{3,}\b' | sort -u)

# Skills to load
declare -a skills_to_load

# Match against skill index
while IFS= read -r skill_entry; do
  skill_name=$(echo "$skill_entry" | jq -r '.name')

  # Skip if already loaded
  if is_skill_loaded "$skill_name"; then
    continue
  fi

  skill_paths=$(echo "$skill_entry" | jq -r '.paths[]')
  skill_keywords=$(echo "$skill_entry" | jq -r '.keywords[]' | tr '[:upper:]' '[:lower:]')

  # Check path matching
  path_match=false
  for user_path in $file_paths; do
    for skill_path in $skill_paths; do
      if [[ "$user_path" == *"$skill_path"* ]]; then
        path_match=true
        break 2
      fi
    done
  done

  # Check keyword matching (require 2+ matches)
  keyword_matches=0
  for user_keyword in $keywords; do
    for skill_keyword in $skill_keywords; do
      if [ "$user_keyword" = "$skill_keyword" ]; then
        ((keyword_matches++))
        break
      fi
    done
  done

  # Add to load list if matched
  if [ "$path_match" = true ] || [ $keyword_matches -ge 2 ]; then
    skills_to_load+=("$skill_name")
  fi
done < <(jq -c '.[]' "$INDEX_FILE")

# Load matched skills
if [ ${#skills_to_load[@]} -gt 0 ]; then
  echo "[User input hook: Loading ${#skills_to_load[@]} skill(s)]" >&2
  load_skills "${skills_to_load[@]}"
fi

exit 0
