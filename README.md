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

| Plugin | Category | Description |
|--------|----------|-------------|
| [analyze-competitor](./plugins/analyze-competitor/) | Research | Competitive analysis with feature comparison, pricing research, and market positioning |
| [analyze-metrics](./plugins/analyze-metrics/) | Analytics | Product metrics analysis for usage, adoption, conversion, retention, and revenue data |
| [analyze-research](./plugins/analyze-research/) | Research | User research synthesis from interviews, transcripts, and feedback |
| [build-prototype](./plugins/build-prototype/) | Development | React/TypeScript prototype builder from PRDs using Shadcn/ui |
| [commit](./plugins/commit/) | Git | Conventional commits with emoji prefixes and smart message formatting |
| [create-pr](./plugins/create-pr/) | Git | Pull request creation with comprehensive summary and test plan |
| [daily-pulse](./plugins/daily-pulse/) | Productivity | Morning briefing combining calendar agenda with task priorities |
| [push](./plugins/push/) | Git | Push to remote with upstream tracking and force-push safety checks |
| [translate-i18n](./plugins/translate-i18n/) | Localization | English-French translation with Canadian French and OQLF compliance |
| [weekly-recap](./plugins/weekly-recap/) | Productivity | Executive-ready weekly recap structured around key initiatives |
| [weekly-review](./plugins/weekly-review/) | Productivity | Weekly review with goal progress, blockers, and next week planning |
| [write-comms](./plugins/write-comms/) | Writing | Internal communications: status reports, newsletters, and stakeholder updates |
| [write-dev-docs](./plugins/write-dev-docs/) | Writing | Developer documentation: API references, guides, and Postman collections |
| [write-doc](./plugins/write-doc/) | Writing | Product documents: PRDs, specs, briefs, user stories, and decision docs |
| [write-ux-copy](./plugins/write-ux-copy/) | Writing | UX copy for buttons, errors, tooltips, notifications, and onboarding |


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
