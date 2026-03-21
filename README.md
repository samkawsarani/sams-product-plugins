[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-orange.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)
[![Star this repo](https://img.shields.io/github/stars/samkawsarani/sams-product-plugins?style=social)](https://github.com/samkawsarani/sams-product-plugins)

# PM Skills Marketplace

My Claude Code setup. A plugin marketplace of Claude Code skills for product management workflows. Install individual plugins to extend Claude with specialized PM capabilities.

## Setup

**Step 1 — Add the marketplace (choose one):**

```bash
# Option A: directly from GitHub (recommended)
/plugin marketplace add samkawsarani/sams-product-plugins

# Option B: clone locally first, then add
git clone https://github.com/samkawsarani/sams-product-plugins <path>
/plugin marketplace add ./path/to/marketplace.json
```

**Step 2 — Install the plugins you want:**

```bash
/plugin install {PLUGIN-NAME}@sams-product-plugins

# Example:
/plugin install analyze-competitor@sams-product-plugins
```

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


| Plugin                                              | Category     | Description                                                                            |
| --------------------------------------------------- | ------------ | -------------------------------------------------------------------------------------- |
| [analyze-competitor](./plugins/analyze-competitor/) | Research     | Competitive analysis with feature comparison, pricing research, and market positioning |
| [analyze-metrics](./plugins/analyze-metrics/)       | Analytics    | Product metrics analysis for usage, adoption, conversion, retention, and revenue data  |
| [analyze-research](./plugins/analyze-research/)     | Research     | User research synthesis from interviews, transcripts, and feedback                     |
| [build-prototype](./plugins/build-prototype/)       | Development  | React/TypeScript prototype builder from PRDs using Shadcn/ui                           |
| [commit](./plugins/commit/)                         | Git          | Conventional commits with emoji prefixes and smart message formatting                  |
| [create-pr](./plugins/create-pr/)                   | Git          | Pull request creation with comprehensive summary and test plan                         |
| [daily-pulse](./plugins/daily-pulse/)               | Productivity | Morning briefing combining calendar agenda with task priorities                        |
| [push](./plugins/push/)                             | Git          | Push to remote with upstream tracking and force-push safety checks                     |
| [sync-granola-meetings](./plugins/sync-granola-meetings/) | Productivity | Sync Granola meetings to local meetings folder with transcripts and metadata     |
| [translate-i18n](./plugins/translate-i18n/)         | Localization | English-French translation with Canadian French and OQLF compliance                    |
| [weekly-recap](./plugins/weekly-recap/)             | Productivity | Executive-ready weekly recap structured around key initiatives                         |
| [weekly-review](./plugins/weekly-review/)           | Productivity | Weekly review with goal progress, blockers, and next week planning                     |
| [write-comms](./plugins/write-comms/)               | Writing      | Internal communications: status reports, newsletters, and stakeholder updates          |
| [write-dev-docs](./plugins/write-dev-docs/)         | Writing      | Developer documentation: API references, guides, and Postman collections               |
| [write-doc](./plugins/write-doc/)                   | Writing      | Product documents: PRDs, specs, briefs, user stories, and decision docs                |
| [write-ux-copy](./plugins/write-ux-copy/)           | Writing      | UX copy for buttons, errors, tooltips, notifications, and onboarding                   |


## Dependencies


| Dependency                       | Required by                                                              |
| -------------------------------- | ------------------------------------------------------------------------ |
| `qmd` CLI                        | analyze-research, weekly-recap, weekly-review, write-dev-docs, write-doc |
| [MCP task tools](https://github.com/samkawsarani/sams-product-os) | daily-pulse, weekly-recap, weekly-review                                 |
| `gws` CLI (Google Workspace)     | daily-pulse, write-comms                                                 |
| `gh` (GitHub CLI)                | create-pr                                                                |
| `git`                            | commit, create-pr, push                                                  |
| Python 3                         | analyze-metrics, build-prototype                                         |
| Node.js, `npx`                   | build-prototype                                                          |
| Granola MCP                      | sync-granola-meetings                                                    |
| Notion MCP (optional)            | analyze-competitor                                                       |
| Slack MCP, Linear MCP (optional) | write-comms                                                              |


