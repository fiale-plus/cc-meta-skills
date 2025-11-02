# Implementation Checklist

Use this checklist to verify implementation completeness.

## Repository Structure

- [ ] `skills/` directory exists
- [ ] `commands/` directory exists
- [ ] `docs/` directory exists
- [ ] `docs/plans/` directory exists
- [ ] `LICENSE` file exists (MIT)
- [ ] `.gitignore` created with correct patterns
- [ ] `README.md` is comprehensive

## Skill File (`skills/discover-project-skills.md`)

### Header
- [ ] YAML frontmatter with name and description
- [ ] Overview section explains purpose
- [ ] Lists when to use the skill

### Phase 0: Pre-check Existing Skills
- [ ] Check for .claude/skills/ directory
- [ ] Scan for marker comments
- [ ] AskUserQuestion with three options
- [ ] Create directory if needed
- [ ] Error handling documented

### Phase 1: Technology Detection
- [ ] Hybrid scanning strategy explained
- [ ] File count threshold specified (<50 vs >=50)
- [ ] Node.js detection with all required techs
- [ ] Java/Kotlin detection with all required techs
- [ ] Python detection
- [ ] Go detection
- [ ] REST detection with HTTP method patterns
- [ ] GraphQL detection
- [ ] Directory structure scanning
- [ ] Present findings format
- [ ] Error handling documented

### Phase 2: Focus Selection
- [ ] Group findings by category
- [ ] AskUserQuestion with area options
- [ ] Adaptive depth strategy explained
- [ ] Error handling documented

### Phase 3: Deep Analysis
- [ ] Module/system analysis steps
- [ ] Flow analysis (sync/async)
- [ ] Pattern extraction methods
- [ ] Chain detection algorithm (directory-based)
- [ ] Example chains provided
- [ ] Error handling documented

### Phase 4: Skill Generation
- [ ] Technology skill template with marker comment
- [ ] Project skill template with marker comment
- [ ] Description template with 5 elements
- [ ] Complete description example
- [ ] When to generate guidelines
- [ ] Skill generation process steps
- [ ] Token budget validation (chars/4)
- [ ] Optimization steps if over 500
- [ ] Write to .claude/skills/ instruction
- [ ] Error handling documented

### After Generation
- [ ] Git commit instructions
- [ ] Summary format
- [ ] Maintenance reminders

### Key Principles
- [ ] Scanning strategy guidelines
- [ ] Token budget rules
- [ ] Skill chaining requirements
- [ ] Description quality requirements
- [ ] Quality metrics (3 file refs, 2 examples)

### Error Handling Section
- [ ] Phase 0 errors covered
- [ ] Phase 1 errors covered
- [ ] Phase 2 errors covered
- [ ] Phase 3 errors covered
- [ ] Phase 4 errors covered
- [ ] General error strategy

## Slash Command (`commands/discover-skills.md`)

- [ ] File created
- [ ] Contains exact invocation command

## README.md

- [ ] What It Does section
- [ ] Installation instructions (two options)
- [ ] Usage examples
- [ ] How It Works (five phases)
- [ ] Hybrid Discovery Mechanism explained
- [ ] Supported Technologies listed
- [ ] Examples (simple and complex)
- [ ] Maintenance section
- [ ] Configuration section
- [ ] Troubleshooting section
- [ ] Contributing guidelines
- [ ] License
- [ ] Credits

## Documentation

- [ ] `docs/plans/2025-11-02-discover-project-skills.md` created
- [ ] `docs/testing-guide.md` created with both test targets
- [ ] `docs/architecture.md` created
- [ ] `docs/implementation-checklist.md` (this file) created

## Testing

- [ ] Skill file syntax is valid
- [ ] Slash command works
- [ ] Can read skill file via Skill tool
- [ ] Token budget formula is correct (chars/4)
- [ ] Marker comment format is consistent
- [ ] Description template has all 5 elements
- [ ] Chain examples make sense

## Git Commits

- [ ] Repository setup committed
- [ ] Slash command committed
- [ ] Skill header committed
- [ ] Phase 0 committed
- [ ] Phase 1 committed
- [ ] Phase 2 committed
- [ ] Phase 3 committed
- [ ] Phase 4 templates committed
- [ ] Phase 4 process committed
- [ ] Error handling committed
- [ ] After generation committed
- [ ] README committed
- [ ] Testing guide committed
- [ ] Architecture docs committed
- [ ] Implementation checklist committed

## Ready for Testing

- [ ] All files created
- [ ] All sections complete
- [ ] No TODOs or placeholders
- [ ] Git history is clean
- [ ] Ready to test on tradingview-mcp-server
- [ ] Ready to test on gradle repo
