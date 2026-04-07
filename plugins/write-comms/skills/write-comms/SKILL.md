---
name: write-comms
model: sonnet
description: Generates internal communications (3P updates, stakeholder reports, newsletters, FAQs, incident reports) in company-preferred formats. Invoked when asked to write status reports, leadership updates, project updates, or any internal communication. Also triggers on "write a status update", "draft an email to leadership", or "I need a 3P update".
compatibility: "Slack MCP, Linear MCP, Google Drive MCP, and gws CLI optional for pulling data automatically."
---

## Available Sources

Check which data sources are present — the skill works with any combination. For each missing source, ask the user to provide that context directly instead.

- **Slack MCP:** available → pull team updates and announcements | missing → ask user for key updates
- **Linear MCP:** available → pull completed issues, milestones, blockers | missing → ask user for project status
- **gws CLI** (`command -v gws`): available → pull calendar events via `gws calendar +agenda` | missing → ask user for meeting highlights
- **Google Drive MCP:** available → pull recently published docs | missing → ask user for relevant documents

Proceed regardless of which sources are missing. Never stop due to an unavailable data source.

---

# Internal Communications Writer

Generate clear, actionable internal communications that keep teams aligned and leadership informed.

## Quick Start

**Common triggers:**
- "Write a 3P update for [team]"
- "Create a stakeholder update for [project]"
- "Draft a company newsletter"
- "Write FAQ answers for [topic]"
- "Create a status report for [audience]"
- "Write an incident report for [issue]"

## Communication Types

| Type | Audience | Read Time | Reference File |
|------|----------|-----------|----------------|
| **3P Update** | Team leads, execs | 30-60 sec | `references/3p-updates.md` |
| **Stakeholder Update** | Executives, leadership | 5-10 min | `references/stakeholder-updates.md` |
| **Company Newsletter** | All employees | 3-5 min | `references/company-newsletter.md` |
| **FAQ Answers** | All employees | 1-2 min per Q | `references/faq-answers.md` |
| **General Comms** | Varies | Varies | `references/general-comms.md` |

## Core Workflow

### 1. Gather Context

Before writing any communication:

1. **Identify the type** — Match the request to a communication type above
2. **Load the reference file** — Read the corresponding file from `references/`
3. **Clarify scope** — Confirm with the user:
   - Team or project name
   - Target audience
   - Time period covered
   - Desired tone (if not standard)
4. **Check voice guide** — Read `VOICE-GUIDE.md` (project root) for tone and style preferences

### 2. Pull Information from Sources

Search available tools for relevant content:

| Source | What to Look For |
|--------|-----------------|
| **Slack** | Posts with many reactions, team updates, announcements, questions with lots of engagement |
| **Linear** | Completed issues, milestones, blockers, in-progress work |
| **Google Calendar (gws)** | Non-recurring meetings, all-hands, product reviews, large attendee events — use `gws calendar +agenda` |
| **Google Drive** | Recently published docs with high visibility, vision docs, quarterly plans |
| **Knowledge base** | `knowledge/product-strategy/` for strategic context, `tasks/` for current work |

If sources are unavailable, ask the user for the key information needed.

### 3. Draft the Communication

1. **Follow the reference file format exactly** — Each type has strict formatting rules
2. **Apply these universal principles:**
   - Lead with the most important information
   - Use concrete metrics over vague descriptions
   - Keep bullets to 1-2 sentences max
   - Use active voice ("We shipped X" not "X was shipped")
   - Include links to source documents where possible
3. **Match the audience level:**
   - Executives → strategic impact, decisions needed, blockers
   - Team leads → progress detail, cross-team dependencies
   - All employees → company wins, big-picture context, culture moments

### 4. Quality Check

Before presenting the draft, verify:

- [ ] Correct format matches the reference file template
- [ ] Tone matches `VOICE-GUIDE.md` preferences
- [ ] Appropriate length for the communication type
- [ ] Metrics and data are specific, not vague
- [ ] Asks and decisions are clearly called out
- [ ] No sensitive information exposed to wrong audience
- [ ] Links and references are included where available
- [ ] Time period is clearly stated

## Type-Specific Guidelines

### 3P Updates (Progress, Plans, Problems)

- **Format**: Emoji + Team Name + Date Range, then 1-3 sentences per P
- **Tone**: Matter-of-fact, data-driven, no fluff
- **Scope**: One week (Progress/Problems = past week, Plans = next week)
- **Must ask**: Team name if not specified
- **Reference**: `references/3p-updates.md`

### Stakeholder Updates

- **Format**: Structured report with status indicators (green/yellow/red)
- **Tone**: Direct, transparent, solutions-oriented
- **Sections**: TL;DR, Quick Stats, Progress, Risks & Blockers, Decisions Needed, Asks
- **Must include**: Overall status (On Track / At Risk / Blocked)
- **Reference**: `references/stakeholder-updates.md`

### Company Newsletter

- **Format**: ~20-25 bullets organized by theme (announcements, progress, leadership, social)
- **Tone**: "We" voice, celebratory but factual
- **Distribution**: Slack and email — keep scannable
- **Focus**: Company-wide impact, not team-specific details
- **Reference**: `references/company-newsletter.md`

### FAQ Answers

- **Format**: Question (1 sentence) + Answer (1-2 sentences)
- **Tone**: Professional but approachable
- **Focus**: Company-wide confusion points, not team-specific
- **Must do**: Base answers on official communications, flag uncertain answers
- **Reference**: `references/faq-answers.md`

### General Comms

- **When**: Request doesn't match any standard type above
- **Must ask**: Target audience, purpose, desired tone, formatting needs
- **Reference**: `references/general-comms.md`

## Keywords
3P updates, stakeholder updates, project status, executive updates, company newsletter, company comms, weekly update, FAQs, common questions, updates, internal comms, status report, leadership updates, incident report, team update
