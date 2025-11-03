#!/bin/bash
# Load skill content and inject into Claude's context

# Get script directory (works when sourced or executed)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/session-state.sh"

SKILLS_DIR="${SKILLS_DIR:-.claude/skills}"

# Load a skill by name
# Usage: load_skill "skill-name"
load_skill() {
  local skill_name="$1"
  local skill_file="$SKILLS_DIR/${skill_name}.md"

  # Check if already loaded
  if is_skill_loaded "$skill_name"; then
    echo "[Skill already loaded: $skill_name]" >&2
    return 0
  fi

  # Check if skill file exists
  if [ ! -f "$skill_file" ]; then
    echo "[Skill not found: $skill_name]" >&2
    return 1
  fi

  # Read skill content
  skill_content=$(cat "$skill_file")

  # Inject into context via stdout
  echo "📚 Loading skill: $skill_name"
  echo ""
  echo "$skill_content"
  echo ""

  # Mark as loaded
  mark_skill_loaded "$skill_name"

  echo "[Loaded skill: $skill_name]" >&2
  return 0
}

# Load multiple skills
# Usage: load_skills "skill1" "skill2" "skill3"
load_skills() {
  local loaded_count=0

  for skill_name in "$@"; do
    if load_skill "$skill_name"; then
      ((loaded_count++))
    fi
  done

  if [ $loaded_count -gt 0 ]; then
    echo "[Loaded $loaded_count skill(s) this invocation]" >&2
  fi
}

# If script is executed directly, load the skill(s) passed as arguments
if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  init_session
  load_skills "$@"
fi
