# Testing Guide

## Test Targets

### 1. Simple Project: tradingview-mcp-server

**Repository**: https://github.com/fiale-plus/tradingview-mcp-server

**Expected Stack**:
- Node.js/TypeScript
- MCP server patterns
- Likely REST or similar API

**Test Focus**:
- Phase 1 technology detection accuracy
- Skill generation for simple structure
- Token budget compliance

**Success Criteria**:
- Detects TypeScript + Node.js
- Generates 2-4 skills
- All skills < 500 tokens
- Skills have proper descriptions

### 2. Complex Project: Gradle

**Repository**: https://github.com/gradle/gradle

**Expected Stack**:
- Java/Kotlin/Groovy
- Multi-module build system
- Deep directory structure

**Test Focus**:
- Hybrid scanning (should use agents)
- Multi-module pattern detection
- Skill chain correctness
- Deep analysis capabilities

**Success Criteria**:
- Uses Task/Explore agents (>50 files)
- Detects Java + Kotlin + Groovy
- Generates 5-10 skills
- Skill chains reflect module dependencies
- All skills < 500 tokens

## Test Procedure

### Phase 0 Testing

1. Run skill in fresh directory (no .claude/skills/)
2. Verify directory is created
3. Run skill again
4. Verify existing skills are detected
5. Test "Regenerate All" option
6. Test "Cancel" option

### Phase 1 Testing

1. Clone test repository
2. Run skill
3. Verify all major technologies detected
4. Compare against manual package file inspection
5. Check for false positives

### Phase 2 Testing

1. Verify findings are grouped correctly
2. Test selecting single area
3. Test selecting multiple areas
4. Test "All" option
5. Verify adaptive depth works

### Phase 3 Testing

1. Check file references are valid
2. Verify patterns match actual code
3. Test chain detection accuracy
4. Validate examples are concrete

### Phase 4 Testing

1. Read generated skills
2. Count tokens (chars / 4)
3. Verify all < 500 tokens
4. Check descriptions have all 4 elements
5. Verify marker comments present
6. Test skill invocation manually

### Success Criteria Validation

**Per success criteria from implementation guide:**

1. **Technology Detection Accuracy**: 90%+ major techs found
   - Manual: Compare against package files

2. **Token Budget Compliance**: All skills < 500 tokens
   - Script: `wc -c .claude/skills/*.md | awk '{print $1/4}'`

3. **Chain Correctness**: Related Skills match flows
   - Manual: Trace typical feature implementation

4. **Description Quality**: All 4 elements present
   - Manual: Check each skill description

5. **Actionability**: 3+ file refs, 2+ examples per skill
   - Manual: Count in each generated skill

6. **Contextual Invocation**: Skills get matched during work
   - Test: Implement feature, verify skill usage

7. **Re-runnable**: Can update existing skills
   - Test: Run twice, verify detection works

## Test Checklist

**Before Testing:**
- [ ] Skill file complete
- [ ] Slash command created
- [ ] Repository structure correct

**Simple Project (tradingview-mcp-server):**
- [ ] Clone repository
- [ ] Run /discover-skills
- [ ] Verify tech detection
- [ ] Check generated skills
- [ ] Validate token budget
- [ ] Test skill invocation

**Complex Project (gradle):**
- [ ] Clone repository
- [ ] Run /discover-skills
- [ ] Verify agents are used
- [ ] Check multi-module detection
- [ ] Validate skill chains
- [ ] Test update workflow

**Re-run Testing:**
- [ ] Run skill twice on same repo
- [ ] Verify existing skills detected
- [ ] Test regenerate option
- [ ] Test update specific option

**Error Testing:**
- [ ] Test with no package files
- [ ] Test with unreadable files
- [ ] Test in directory without write permissions
- [ ] Verify graceful error messages
