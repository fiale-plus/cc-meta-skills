---
name: discover-project-skills
description: Analyze codebase to discover technologies and project patterns, then generate contextual skills for both
---

# Discover Project Skills

## Overview

This skill analyzes your codebase to automatically discover:
1. **Technologies used**: Frameworks, databases, messaging systems, API protocols
2. **Project-specific patterns**: Architecture flows, module organization, design patterns
3. **Contextual skills**: Generates reusable skill files that chain together

**When to use:**
- Starting work on a new codebase
- After major architectural changes
- When onboarding to a project
- To document project patterns as skills

**Output:**
- Technology skills (e.g., `kafka-patterns.md`, `grpc-best-practices.md`)
- Project skills (e.g., `api-layer-patterns.md`, `service-layer-patterns.md`)
- Saved to `.claude/skills/` for automatic discovery
