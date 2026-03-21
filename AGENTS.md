# AGENTS.md

This project is a plugin marketplace of Claude Code skills for product management workflows. When working in this repository, act as an expert skill creator following Claude Code's best practices.

## Role

You are an expert in creating and maintaining Claude Code skills packaged as plugins. Your primary responsibilities:

1. **Create new plugins** - Design and implement skills that extend Claude's capabilities with specialized PM workflows
2. **Maintain existing plugins** - Update and improve skills based on usage feedback
3. **Follow best practices** - Ensure all skills adhere to Claude Code's skill architecture

## Plugin Architecture

Every plugin follows this structure:

```
plugins/skill-name/
├── .claude-plugin/
│   └── plugin.json           # Required: {name, description, version, author}
└── skills/
    └── skill-name/
        ├── SKILL.md           # Required: Frontmatter (name, description) + instructions
        ├── references/        # Optional: Documentation loaded on-demand
        ├── assets/            # Optional: Templates, files used in output
        └── scripts/           # Optional: Executable code for deterministic tasks
```

### Core Principles

1. **Concise is key** - Context window is shared. Only include what Claude doesn't already know.
2. **Progressive disclosure** - SKILL.md stays lean (<500 lines). Detailed content goes in references/.
3. **Appropriate freedom** - Match specificity to task fragility. More guardrails for error-prone operations.

### Version Increment Rule

**Every time a plugin is updated, its version MUST be incremented in both `plugin.json` and the matching entry in `.claude-plugin/marketplace.json`.** Claude Code uses the version to detect updates — if you change code but don't bump the version, users won't receive the update.

Follow semantic versioning (`MAJOR.MINOR.PATCH`):
- **PATCH** (1.0.0 -> 1.0.1): Bug fixes, wording changes, minor tweaks
- **MINOR** (1.0.0 -> 1.1.0): New features, new references, expanded workflows
- **MAJOR** (1.0.0 -> 2.0.0): Breaking changes to skill behavior or removed functionality

### What NOT to Include (per plugin)

- README.md, CHANGELOG.md, or auxiliary documentation
- Setup/installation guides
- User-facing documentation separate from SKILL.md

## Creating Plugins

Invoke the skill-creator skill directly. It guides best practices for structure, references, and implementation.

## Quality Standards

Before finalizing any plugin:

- [ ] Frontmatter has clear, comprehensive `description`
- [ ] SKILL.md is under 500 lines
- [ ] References are one level deep from SKILL.md
- [ ] No placeholder text or TODOs
- [ ] All scripts tested and functional
- [ ] Triggers documented in description, not body
- [ ] plugin.json has correct name, description, version, and author
- [ ] marketplace.json entry has matching version and author
- [ ] README.md updated: plugin catalog table and dependencies (if any)
