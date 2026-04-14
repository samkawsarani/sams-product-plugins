[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Star this repo](https://img.shields.io/github/stars/samkawsarani/sams-product-plugins?style=social)](https://github.com/samkawsarani/sams-product-plugins)

Quick links: [Install](#install) · [Plugin catalog](#plugin-catalog)

---

# PM Skills Marketplace

My Claude Code setup. A plugin marketplace of Claude Code skills for product management workflows. Install individual plugins to extend Claude with specialized PM capabilities.


## Install

### Claude Code (recommended)
Install as a plugin

```bash
claude plugin marketplace samkawsarani/sams-product-plugins
claude plugin install {PLUGIN-NAME}@sams-product-plugins 
# e.g. analyze-competitor@sams-product-plugins
```

### Any agent (Claude Code, Cursor, Copilot, Windsurf, Cline, Codex)

```bash
# Install all plugins from this marketplace
npx skills add samkawsarani/sams-product-plugins

# Install specific plugins only
npx skills add samkawsarani/sams-product-plugins --skill write-doc write-comms

# For a specific agent 
npx skills add samkawsarani/sams-product-plugins --skill write-doc -a cursor

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
| [analyze-meetings](./plugins/analyze-meetings/)     | Productivity | Meeting transcript analysis for communication patterns, conflict avoidance, and leadership style |
| [analyze-metrics](./plugins/analyze-metrics/)       | Analytics    | Product metrics analysis for usage, adoption, conversion, retention, and revenue data  |
| [analyze-research](./plugins/analyze-research/)     | Research     | User research synthesis from interviews, transcripts, and feedback                     |
| [build-prototype](./plugins/build-prototype/)       | Development  | React/TypeScript prototype builder from PRDs using Shadcn/ui                           |
| [commit](./plugins/commit/)                         | Git          | Conventional commits with emoji prefixes and smart message formatting                  |
| [create-pr](./plugins/create-pr/)                   | Git          | Pull request creation with comprehensive summary and test plan                         |
| [push](./plugins/push/)                             | Git          | Push to remote with upstream tracking and force-push safety checks                     |
| [sync-granola-meetings](./plugins/sync-granola-meetings/) | Productivity | Sync Granola meetings to local meetings folder with transcripts and metadata     |
| [translate-i18n](./plugins/translate-i18n/)         | Localization | English-French translation with Canadian French and OQLF compliance                    |
| [write-comms](./plugins/write-comms/)               | Writing      | Internal communications: status reports, newsletters, and stakeholder updates          |
| [write-dev-docs](./plugins/write-dev-docs/)         | Writing      | Developer documentation: API references, guides, and Postman collections               |
| [write-doc](./plugins/write-doc/)                   | Writing      | Product documents: PRDs, specs, briefs, user stories, and decision docs                |
| [write-ux-copy](./plugins/write-ux-copy/)           | Writing      | UX copy for buttons, errors, tooltips, notifications, and onboarding                   |


## License

[MIT](LICENSE) — Copyright (c) 2026 Sam Kawsarani