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

### SKILL.md Frontmatter Fields

| Field | Required | Description |
|---|---|---|
| `name` | Yes | Skill identifier (matches directory name) |
| `description` | Yes | What the skill does + trigger phrases |
| `model` | No | `sonnet`, `opus`, or `haiku` |
| `disable-model-invocation` | No | Set `true` for script-only skills |
| `allowed-tools` | No | Comma-separated list of permitted tools |
| `argument-hint` | No | Usage hint shown to the user |
| `compatibility` | No | Plain English sentence listing external dependencies |

**`compatibility` field:** Use this to expose CLI tools and MCP servers required or optionally used by the skill. Agents can read this to pre-flight check whether a skill can run in their environment.

Format: a plain English sentence. Omit the field entirely if the skill has no external dependencies.

```yaml
# Required dependencies only
compatibility: "Requires Slack MCP, Linear MCP, and gws CLI."

# Mixed required and optional
compatibility: "Requires Task MCP. qmd CLI optional for semantic search."

# Optional only
compatibility: "qmd CLI optional for semantic search."
```

**Canonical names:** Use lowercase for CLI tools (`git`, `gh`, `gws`, `python3`, `node`, `npm`, `npx`, `qmd`) and title case + "MCP" suffix for MCP servers (`Granola MCP`, `Notion MCP`, `Slack MCP`, `Linear MCP`, `Google Drive MCP`, `Task MCP`).

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
- [ ] `compatibility` frontmatter added with external deps, or confirmed not needed (omit if none)
