# PM Skills Marketplace — Interactive Setup

You are helping the user install plugins from [Sam's PM Skills Marketplace](https://github.com/samkawsarani/sams-product-plugins). Follow the steps below in order. Be conversational and concise.

**Alternative:** If you prefer installing skills directly without the marketplace, see the "Direct Skill Install" section in [README.md](./README.md).

---

## Step 1: Choose install method

Ask the user:

> **How would you like to add the marketplace?**
>
> 1. **From GitHub** (recommended) — adds the marketplace directly, no local clone needed
> 2. **Clone locally** — clones the repo to `~/Projects/sams-product-plugins` first

Based on their choice, run the appropriate commands:

**Option 1 — GitHub:**
```bash
claude plugin add github:samkawsarani/sams-product-plugins
```

**Option 2 — Local clone:**
```bash
git clone https://github.com/samkawsarani/sams-product-plugins ~/Projects/sams-product-plugins
claude plugin add dir:~/Projects/sams-product-plugins
```

---

## Step 2: Install plugins

Present the full list of available plugins. Show the table below and ask which ones the user wants to enable. Enable selected plugins with `claude plugin enable <name>@sams-product-plugins`.

| Plugin | Category | Description |
|--------|----------|-------------|
| `analyze-competitor` | Research | Competitive analysis with feature comparison, pricing research, and market positioning |
| `analyze-metrics` | Analytics | Product metrics analysis for usage, adoption, conversion, retention, and revenue data |
| `analyze-research` | Research | User research synthesis from interviews, transcripts, and feedback |
| `build-prototype` | Development | React/TypeScript prototype builder from PRDs using Shadcn/ui |
| `commit` | Git | Conventional commits with emoji prefixes and smart message formatting |
| `create-pr` | Git | Pull request creation with comprehensive summary and test plan |
| `daily-pulse` | Productivity | Morning briefing combining calendar agenda with task priorities |
| `push` | Git | Push to remote with upstream tracking and force-push safety checks |
| `sync-granola-meetings` | Productivity | Sync Granola meetings to local meetings folder with transcripts and metadata |
| `translate-i18n` | Localization | English-French translation with Canadian French and OQLF compliance |
| `weekly-recap` | Productivity | Executive-ready weekly recap structured around key initiatives |
| `weekly-review` | Productivity | Weekly review with goal progress, blockers, and next week planning |
| `write-comms` | Writing | Internal communications: status reports, newsletters, and stakeholder updates |
| `write-dev-docs` | Writing | Developer documentation: API references, guides, and Postman collections |
| `write-doc` | Writing | Product documents: PRDs, specs, briefs, user stories, and decision docs |
| `write-ux-copy` | Writing | UX copy for buttons, errors, tooltips, notifications, and onboarding |

If the user wants all plugins, enable them all at once:
```bash
claude plugin enable analyze-metrics@sams-product-plugins
claude plugin enable analyze-competitor@sams-product-plugins
claude plugin enable analyze-research@sams-product-plugins
claude plugin enable build-prototype@sams-product-plugins
claude plugin enable commit@sams-product-plugins
claude plugin enable create-pr@sams-product-plugins
claude plugin enable daily-pulse@sams-product-plugins
claude plugin enable push@sams-product-plugins
claude plugin enable sync-granola-meetings@sams-product-plugins
claude plugin enable translate-i18n@sams-product-plugins
claude plugin enable weekly-recap@sams-product-plugins
claude plugin enable weekly-review@sams-product-plugins
claude plugin enable write-comms@sams-product-plugins
claude plugin enable write-dev-docs@sams-product-plugins
claude plugin enable write-doc@sams-product-plugins
claude plugin enable write-ux-copy@sams-product-plugins
```

---

## Step 3: Verify

Run `claude plugin list` and confirm the enabled plugins appear correctly.

---

## Step 4: Dependencies

Based on which plugins the user enabled, mention relevant optional dependencies:

| Dependency | Required by | Install |
|-----------|-------------|---------|
| `qmd` CLI | analyze-research, weekly-recap, weekly-review, write-dev-docs, write-doc | [qmd docs](https://github.com/tobi/qmd) |
| `gws` CLI (Google Workspace) | daily-pulse, write-comms | [gws docs](https://github.com/googleworkspace/cli) |
| `gh` (GitHub CLI) | create-pr | `brew install gh` |
| Python 3 | analyze-metrics, build-prototype | `brew install python` |
| Node.js / `npx` | build-prototype | `brew install node` |

| Granola MCP | sync-granola-meetings | [Granola](https://granola.ai) |

Only mention dependencies for the plugins the user actually enabled. If none of their chosen plugins need external dependencies, skip this step.
