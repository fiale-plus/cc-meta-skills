#!/bin/bash
# Session state management for skill loading tracking

# Use session-specific temp directory
SESSION_DIR="/tmp/claude-skill-session-$$"
LOADED_SKILLS_FILE="$SESSION_DIR/loaded-skills.txt"

# Initialize session state
init_session() {
  mkdir -p "$SESSION_DIR"
  touch "$LOADED_SKILLS_FILE"
}

# Check if skill is already loaded
is_skill_loaded() {
  local skill_name="$1"
  [ -f "$LOADED_SKILLS_FILE" ] || return 1
  grep -qx "$skill_name" "$LOADED_SKILLS_FILE"
}

# Mark skill as loaded
mark_skill_loaded() {
  local skill_name="$1"
  echo "$skill_name" >> "$LOADED_SKILLS_FILE"
}

# Get list of loaded skills
get_loaded_skills() {
  [ -f "$LOADED_SKILLS_FILE" ] || return
  cat "$LOADED_SKILLS_FILE"
}

# Clear session state (cleanup)
clear_session() {
  rm -rf "$SESSION_DIR"
}

# Get session state file (for debugging)
get_session_file() {
  echo "$LOADED_SKILLS_FILE"
}
