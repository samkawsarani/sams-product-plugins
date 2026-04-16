---
name: sync-meetings
description: Sync Granola meetings to local meetings folder. Invoked when user asks to sync meetings, pull transcripts, or says "sync my meetings", "pull today's meetings", "what meetings did I have".
allowed-tools: mcp__granola__list_meetings, mcp__granola__get_meetings, mcp__granola__get_meeting_transcript, Read, Write, Glob, Bash
argument-hint: "[folder-name] [--days N] [--all]"
compatibility: "Requires Granola MCP."
---

## Dependency Check

Before starting, verify required dependencies:

1. **Granola MCP (required):** Check if Granola MCP tools are available in your tools list.
   - If **missing**: Tell the user: "The Granola MCP server is not configured. This skill requires Granola MCP. Please install and configure the Granola MCP server (see https://granola.ai) and try again." **Stop here.**

## Context

Sync state is tracked in `<target-folder>/.synced-meetings.json`.
Today's date: $TODAY
Arguments: `$ARGUMENTS`

## Your Task

Sync Granola meetings to `<target-folder>` using the Granola MCP.

---

## Step 1: Parse Arguments

- First positional arg = target folder (default: `meetings/`)
- `--days N` = sync meetings from the last N days
- `--all` = re-sync all meetings, ignoring sync state

## Step 2: Check Sync State

Read `<target-folder>/.synced-meetings.json`. If it doesn't exist, this is a first sync.

```json
{
  "last_sync": "<ISO timestamp>",
  "synced": {
    "<meeting-uuid>": {
      "title": "Meeting Title",
      "synced_at": "<ISO timestamp>",
      "file_path": "meetings/2026-03-16-Meeting-Title.md"
    }
  }
}
```

## Step 3: List Meetings from Granola

Via Granola MCP, list meetings with the appropriate time range:
- **First sync** (no `.synced-meetings.json`): use `last_30_days`
- **Subsequent syncs**: use `this_week`
- **`--days N`**: use custom range based on N
- **`--all`**: use `last_30_days` and ignore existing sync state

## Step 4: Filter Unsynced Meetings

Compare returned meeting IDs against the `synced` keys in `.synced-meetings.json`.
- Skip any meeting whose ID is already synced (unless `--all` was passed)
- Build a list of unsynced meetings with title + date

## Step 5: Present to User

Show the list of unsynced meetings:

```
Found N new meetings to sync:
1. 2026-03-18 — Weekly Standup
2. 2026-03-17 — Product Review
3. 2026-03-16 — 1:1 with Manager

Sync all, select specific (e.g. "1,3"), or skip?
```

Wait for user confirmation before proceeding.

## Step 6: Sync Selected Meetings

For each selected meeting:

### 6a. Fetch Metadata
Via Granola MCP, fetch the meeting to get:
- Title, created_at, updated_at
- Attendees list (names and emails)
- Granola URL (`https://notes.granola.ai/d/<uuid>`)

### 6b. Fetch Transcript
Via Granola MCP, fetch the meeting transcript.
- **Skip** meetings with empty or no transcript (placeholder meetings). Tell the user you're skipping and why.

### 6c. Generate Filename
Format: `YYYY-MM-DD-Sanitized-Title.md`

Sanitize the title:
- Replace `&` with `and`
- Strip characters: `[](){}!@#$%^*`
- Replace spaces and `/` with `-`
- Collapse multiple dashes into one
- Truncate to ~80 characters
- Example: `"Q1 Planning & Review (Draft)"` → `2026-03-18-Q1-Planning-and-Review-Draft.md`

### 6d. Write Meeting File
Write to `<target-folder>/<filename>` with this format:

```markdown
---
granola_id: <uuid>
title: "<meeting title>"
granola_url: "https://notes.granola.ai/d/<uuid>"
created_at: <ISO timestamp>
updated_at: <ISO timestamp>
attendees:
  - Name <email>
tags:
  - person/<firstname-lastname>
---

# <Meeting Title>

## Transcript

**Them**: ...

**Me**: ...
```

**Transcript formatting rules:**
- Split raw transcript on `Me:` and `Them:` speaker markers
- Format as `**Me**: text` and `**Them**: text`
- Add blank lines between speaker turns
- No timestamps (MCP doesn't provide them)

**Attendee tags:**
- Generate `person/<firstname-lastname>` from attendee names (lowercase, hyphenated)
- Skip the note creator (the user themselves) from tags

### 6e. Update Sync State
After each successful write, update `<target-folder>/.synced-meetings.json`:
- Add the meeting ID to `synced` with title, synced_at timestamp, and file_path
- Update `last_sync` to current timestamp

## Step 7: Summary

Report what was synced:

```
Synced N meetings to <target-folder>/:
- 2026-03-18-Weekly-Standup.md
- 2026-03-17-Product-Review.md

Skipped M meetings (no transcript).
```
