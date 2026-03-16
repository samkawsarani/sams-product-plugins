[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-orange.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)
[![Star this repo](https://img.shields.io/github/stars/samkawsarani/sams-product-plugins?style=social)](https://github.com/samkawsarani/sams-product-plugins)

# PM Skills Marketplace

A plugin marketplace of Claude Code skills for product management workflows. Install individual plugins to extend Claude with specialized PM capabilities.

## Setup

### Quick Start (automatic)

Paste this into Claude Code and it will walk you through setup interactively — choosing your install method and which plugins to enable:

```
Go to https://github.com/samkawsarani/sams-product-plugins/blob/main/SETUP.md and set me up.
```

### Manual Install

**Option A — directly from GitHub (recommended):**

```bash
claude plugin add github:samkawsarani/sams-product-plugins
claude plugin enable analyze-metrics@sams-product-plugins
claude plugin enable analyze-competitor@sams-product-plugins
claude plugin enable analyze-research@sams-product-plugins
claude plugin enable build-prototype@sams-product-plugins
claude plugin enable commit@sams-product-plugins
claude plugin enable create-pr@sams-product-plugins
claude plugin enable daily-pulse@sams-product-plugins
claude plugin enable push@sams-product-plugins
claude plugin enable translate-i18n@sams-product-plugins
claude plugin enable weekly-recap@sams-product-plugins
claude plugin enable weekly-review@sams-product-plugins
claude plugin enable write-comms@sams-product-plugins
claude plugin enable write-dev-docs@sams-product-plugins
claude plugin enable write-doc@sams-product-plugins
claude plugin enable write-ux-copy@sams-product-plugins
```

**Option B — clone locally first:**

```bash
git clone https://github.com/samkawsarani/sams-product-plugins ~/Projects/sams-product-plugins
claude plugin add dir:~/Projects/sams-product-plugins
claude plugin enable analyze-metrics@sams-product-plugins
claude plugin enable analyze-competitor@sams-product-plugins
claude plugin enable analyze-research@sams-product-plugins
claude plugin enable build-prototype@sams-product-plugins
claude plugin enable commit@sams-product-plugins
claude plugin enable create-pr@sams-product-plugins
claude plugin enable daily-pulse@sams-product-plugins
claude plugin enable push@sams-product-plugins
claude plugin enable translate-i18n@sams-product-plugins
claude plugin enable weekly-recap@sams-product-plugins
claude plugin enable weekly-review@sams-product-plugins
claude plugin enable write-comms@sams-product-plugins
claude plugin enable write-dev-docs@sams-product-plugins
claude plugin enable write-doc@sams-product-plugins
claude plugin enable write-ux-copy@sams-product-plugins
```

### Verify

```bash
claude plugin list
```

You should see the marketplace and all enabled plugins listed.

## Structure

Each plugin follows this layout:

```
plugins/skill-name/
├── .claude-plugin/
│   └── plugin.json          # Plugin metadata
└── skills/
    └── skill-name/
        ├── SKILL.md          # Core instructions and workflow
        ├── references/       # Documentation loaded on-demand
        ├── assets/           # Templates and output files
        └── scripts/          # Executable utilities
```

## Plugin Catalog

### Analytics & Data

| Plugin | Install Command | Description |
|--------|----------------|-------------|
| [analyze-metrics](./plugins/analyze-metrics/) | `/plugin install analyze-metrics@sams-product-plugins` | Product metrics analysis for usage, adoption, conversion, retention, and revenue data |

### Research & Analysis

| Plugin | Install Command | Description |
|--------|----------------|-------------|
| [analyze-competitor](./plugins/analyze-competitor/) | `/plugin install analyze-competitor@sams-product-plugins` | Competitive analysis with feature comparison, pricing research, and market positioning |
| [analyze-research](./plugins/analyze-research/) | `/plugin install analyze-research@sams-product-plugins` | User research synthesis from interviews, transcripts, and feedback |

### Documentation & Writing

| Plugin | Install Command | Description |
|--------|----------------|-------------|
| [write-doc](./plugins/write-doc/) | `/plugin install write-doc@sams-product-plugins` | Product documents: PRDs, specs, briefs, user stories, and decision docs |
| [write-dev-docs](./plugins/write-dev-docs/) | `/plugin install write-dev-docs@sams-product-plugins` | Developer documentation: API references, guides, and Postman collections |
| [write-comms](./plugins/write-comms/) | `/plugin install write-comms@sams-product-plugins` | Internal communications: status reports, newsletters, and stakeholder updates |
| [write-ux-copy](./plugins/write-ux-copy/) | `/plugin install write-ux-copy@sams-product-plugins` | UX copy for buttons, errors, tooltips, notifications, and onboarding |

### Git & Version Control

| Plugin | Install Command | Description |
|--------|----------------|-------------|
| [commit](./plugins/commit/) | `/plugin install commit@sams-product-plugins` | Conventional commits with emoji prefixes and smart message formatting |
| [create-pr](./plugins/create-pr/) | `/plugin install create-pr@sams-product-plugins` | Pull request creation with comprehensive summary and test plan |
| [push](./plugins/push/) | `/plugin install push@sams-product-plugins` | Push to remote with upstream tracking and force-push safety checks |

### Productivity & Planning

| Plugin | Install Command | Description |
|--------|----------------|-------------|
| [daily-pulse](./plugins/daily-pulse/) | `/plugin install daily-pulse@sams-product-plugins` | Morning briefing combining calendar agenda with task priorities |
| [weekly-recap](./plugins/weekly-recap/) | `/plugin install weekly-recap@sams-product-plugins` | Executive-ready weekly recap structured around key initiatives |
| [weekly-review](./plugins/weekly-review/) | `/plugin install weekly-review@sams-product-plugins` | Weekly review with goal progress, blockers, and next week planning |

### Development & Prototyping

| Plugin | Install Command | Description |
|--------|----------------|-------------|
| [build-prototype](./plugins/build-prototype/) | `/plugin install build-prototype@sams-product-plugins` | React/TypeScript prototype builder from PRDs using Shadcn/ui |

### Localization

| Plugin | Install Command | Description |
|--------|----------------|-------------|
| [translate-i18n](./plugins/translate-i18n/) | `/plugin install translate-i18n@sams-product-plugins` | English-French translation with Canadian French and OQLF compliance |


## Dependencies

| Dependency | Required by |
|-----------|-------------|
| `qmd` CLI | analyze-research, weekly-recap, weekly-review, write-dev-docs, write-doc |
| MCP task tools | daily-pulse, weekly-recap, weekly-review |
| `gws` CLI (Google Workspace) | daily-pulse, write-comms |
| `gh` (GitHub CLI) | create-pr |
| `git` | commit, create-pr, push |
| Python 3 | analyze-metrics, build-prototype |
| Node.js, `npx` | build-prototype |
| Notion MCP (optional) | analyze-competitor |
| Slack MCP, Linear MCP (optional) | write-comms |
