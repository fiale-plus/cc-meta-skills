# Discover Project Skills

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/fiale-plus/cc-meta-skills/releases)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Plugin-purple.svg)](https://claude.ai/code)

A Claude Code skill that analyzes codebases to automatically discover technologies, extract project-specific patterns, and generate contextual skills with intelligent chaining.

## 🚀 Quick Start

```bash
# Add the marketplace
claude plugin marketplace add fiale-plus/cc-meta-skills

# Install the plugin
claude plugin install cc-meta-skills
```

Then run in any project:
```bash
/cc-meta-skills:discover-project-skills
```

## What It Does

This skill analyzes your codebase and generates:

1. **Technology Skills**: Best practices for detected tech stack (PostgreSQL, Kafka, gRPC, etc.)
2. **Project Skills**: Patterns specific to your architecture (API layer, service layer, etc.)
3. **Skill Chains**: Automatically links related skills for natural workflow

**Example output:**
```
.claude/skills/
├── postgresql-patterns.md
├── kafka-patterns.md
├── rest-api-patterns.md
├── service-layer-patterns.md
└── event-processing-patterns.md
```

Each skill includes:
- Overview of how it's used in your codebase
- Key patterns with file references
- Common gotchas
- Related skills for workflow chaining
- Concrete examples from your code

## Usage

### Basic Usage

```bash
/cc-meta-skills:discover-project-skills
```

The skill will:
1. Check for existing generated skills
2. Scan your codebase for technologies
3. Ask which areas to analyze
4. Generate contextual skills
5. Commit them to `.claude/skills/`

### When to Run

- **New codebase**: Document patterns for team
- **After refactoring**: Update skills to reflect changes
- **Technology adoption**: Add skills for new tech stack
- **Onboarding**: Generate skills to help new developers

## How It Works

### Five-Phase Workflow

**Phase 0: Pre-check**
- Detects existing generated skills
- Offers to regenerate, update specific, or cancel

**Phase 1: Technology Detection**
- Scans package files (package.json, pom.xml, etc.)
- Detects languages, frameworks, databases, messaging, APIs
- Uses hybrid strategy: direct tools for small projects, agents for large

**Phase 2: Focus Selection**
- Presents detected technologies
- User selects areas to analyze deeply
- Adaptive depth: deep dive for 1-2 areas, medium for "all"

**Phase 3: Deep Analysis**
- Extracts patterns from selected areas
- Analyzes flows (synchronous/asynchronous)
- Detects skill chains based on directory structure
- Collects file references and examples

**Phase 4: Skill Generation**
- Generates skills using templates
- Validates token budget (<500 tokens each)
- Adds marker comments for detection
- Writes to `.claude/skills/`

### Hybrid Discovery Mechanism

Skills are discovered two ways:

1. **Explicit Chaining**: "Related Skills" sections link skills
2. **Context Matching**: Rich descriptions with keywords, file patterns, scenarios

**Example:**
```markdown
description: PostgreSQL database access patterns. Use when working with
database queries, SQL operations, repository pattern, especially in
src/repository/ or src/dao/ files, or implementing CRUD operations
and query optimization.
```

When you work on database code, Claude matches:
- Keywords: "database queries", "SQL", "repository"
- File patterns: "src/repository/", "src/dao/"
- Scenarios: "CRUD operations", "query optimization"

### Supported Technologies

**Languages**: TypeScript, JavaScript, Java, Kotlin, Python, Go

**Frameworks**:
- Node: Express, NestJS, Fastify
- Java/Kotlin: Spring Boot, Ktor, Micronaut
- Python: FastAPI, Django, Flask

**Databases**: PostgreSQL, MongoDB, MySQL, Redis

**Messaging**: Kafka, RabbitMQ, SQS, PubSub

**APIs**: REST, gRPC, GraphQL

## Examples

### Example 1: Simple Node.js API

```bash
/cc-meta-skills:discover-project-skills
```

**Detects:**
- TypeScript + Express
- PostgreSQL via pg
- REST endpoints in /controllers

**Generates:**
- `typescript-patterns.md`
- `express-api-patterns.md`
- `postgresql-access-patterns.md`

**Chains:**
- express-api-patterns → postgresql-access-patterns

### Example 2: Event-Driven Microservice

```bash
/cc-meta-skills:discover-project-skills
```

**Detects:**
- Java + Spring Boot + Kotlin
- Kafka producers/consumers
- PostgreSQL + MongoDB
- gRPC services

**Generates:**
- `spring-boot-patterns.md`
- `kafka-producer-patterns.md`
- `kafka-consumer-patterns.md`
- `postgresql-access-patterns.md`
- `mongodb-patterns.md`
- `grpc-patterns.md`

**Chains:**
- grpc-patterns → service-layer → kafka-producer
- kafka-consumer → service-layer → mongodb-patterns

## Maintenance

### Updating Skills

When your codebase evolves:

```bash
/cc-meta-skills:discover-project-skills
```

The skill detects existing generated skills and offers options:
- **Regenerate All**: Fresh analysis
- **Update Specific**: Choose which areas to regenerate
- **Cancel**: Keep existing skills

### Version Control

Generated skills are **committed to git** by default. This allows:
- Team sharing: Everyone gets the same skills
- History tracking: See how patterns evolve
- Import/export: Share skills across projects

## Configuration

### Token Budget

Skills are kept under 500 tokens each for efficiency. The skill:
1. Counts tokens: `character_count / 4`
2. If over 500, optimizes:
   - Removes mermaid diagrams
   - Keeps top 3-4 patterns
   - Consolidates file references
3. If still over, asks user to proceed or simplify

### Scanning Strategy

**Small projects (<50 files)**: Direct tools (Read/Glob/Grep)
**Large projects (>50 files)**: Task/Explore agents

Automatically detected by counting source files.

## Troubleshooting

**No technologies detected:**
- Point to specific package files manually
- Check if package files are in expected locations

**Skills not being invoked:**
- Check skill descriptions have rich keywords
- Verify Related Skills chains are correct
- Ensure file patterns match your structure

**Token budget exceeded:**
- Let skill optimize automatically
- Or simplify patterns manually

## Contributing

Contributions welcome! This is an MIT-licensed open-source project.

**To contribute:**
1. Fork the repository
2. Create feature branch
3. Make changes
4. Test with real codebases
5. Submit pull request

## License

MIT License - see LICENSE file for details.

## Credits

Built for the Claude Code community to make codebases more discoverable and documented through automatically generated contextual skills.
