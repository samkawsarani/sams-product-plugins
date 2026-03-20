---
name: daily-pulse
model: haiku
description: Generates a morning briefing combining calendar agenda with task priorities and goal alignment. Invoked via /daily-pulse or "morning pulse", "what's my day look like". Supports variations: tomorrow, week.
allowed-tools: list_tasks, find_overdue_tasks, get_task_summary, Glob, Read, Bash
argument-hint: [optional: "tomorrow", "week"]
---

## Dependency Check

Before starting, verify required dependencies:

1. **gws CLI (required):** Run `command -v gws`.
   - If **missing**: Tell the user: "The `gws` CLI is required to fetch calendar data. See https://github.com/googleworkspace/cli for installation, then try again." **Stop here.**
2. **MCP task tools (required):** Check if `list_tasks` is available in your tools list.
   - If **missing**: Tell the user: "Task MCP tools are not configured. This skill requires task management tools (`list_tasks`, `find_overdue_tasks`). Please configure the task MCP server from [sams-product-os](https://github.com/samkawsarani/sams-product-os) and try again." **Stop here.**

---

## Context

Tasks are in `tasks/` with YAML frontmatter (priority, status, due_date, category).
Goals are in `GOALS.md`.
Today's date: $TODAY
Arguments: `$ARGUMENTS` (optional — see variations: tomorrow, week)

**Best timing:** First thing in morning, before checking email/Slack

## Your Task

Generate a morning pulse that combines calendar agenda with task priorities.

If user provided arguments: $ARGUMENTS
- "tomorrow" → Use Tomorrow Look-Ahead variation
- "week" → Use Week Overview variation

---

## Default: Full Morning Pulse

### Step 1: Calendar Agenda

**Actions:**
1. Fetch today's calendar agenda:
   ```bash
   gws calendar +agenda --today
   ```
2. Optionally fetch tomorrow for look-ahead context:
   ```bash
   gws calendar +agenda --tomorrow
   ```
3. Filter out **multi-day all-day events** (where the event spans more than one day). Single-day all-day events can be shown as context above the table.
4. Parse the results and present as a **table** with columns: Time, Event
   - For events where you are marked as **optional**, append `*(you're optional)*` to the event name in italics
4. After the table, add a single **"A few things to note:"** section with bullet points covering:
   - Any **cancelled or declined** meetings (include who declined and their reason/proposed new time if available)
   - **Free blocks** — gaps of 30+ minutes between meetings within 9am–5pm (mention duration)
   - **Density observations** — if there's a packed stretch of back-to-back meetings, call it out (e.g. "Your morning is fairly packed back-to-back from 9:30 to 11:30")
   - Any **scheduling conflicts** (overlapping events)
   - Only include bullets that are relevant — don't pad with filler

### Step 2: Task Priorities

**Actions:**
1. Use `find_overdue_tasks` MCP tool to get overdue tasks
2. Use `list_tasks` MCP tool to get:
   - P0 tasks (not done)
   - P1 tasks (not done)
   - Tasks with due dates today
   - Tasks due in the next 7 days
   - Unscheduled P0/P1 tasks (no due_date set)
3. Read `GOALS.md` for goal context
4. Find blocked tasks (status `b`) and identify if any can be unblocked today

### Step 3: Synthesize

Combine calendar + tasks into a unified briefing.

**Omit any section that would be empty — don't show headers or placeholder text for empty sections.**

**Output format:**
```
Daily Pulse for [Day, Date]

CALENDAR
| Time | Event |
|------|-------|
| [Start]–[End] | [Event title] |
| [Start]–[End] | [Event title] *(you're optional)* |
| ... | ... |

A few things to note:
- [Person] declined [Meeting] and asked to move it to [new time] — "[reason]"
- You have a free block from [X]–[Y] (Xh Xm) and another from [Y]–[Z] (Xh Xm)
- Your [morning/afternoon] is fairly packed back-to-back from [X] to [Y]
- [Meeting A] and [Meeting B] overlap at [time] — you'll need to pick one

TOP PRIORITIES
1. [Task with context]
   Goal: [Goal name from GOALS.md]
   Why today: [Urgency/impact]

2. [Second priority]
   ...

3. [Third priority]
   ...

DUE TODAY
  - [Task] (P0) — [context]
  - ...

OVERDUE
  - [Task] (P1) — due [date], [N] days overdue
  - ...

UPCOMING (next 7 days)
  - [Task] (P0) — due [date]
  - ...

UNSCHEDULED P0/P1
  - [Task] (P0) — no due date set
  - ...

BLOCKED
  [Task name] (P0) - Blocked on: [Dependency]
  - Can you unblock today? [Yes/No + suggestion]

TOMORROW LOOK-AHEAD
  - [N] meetings, [Key event to note]
```

### Step 4: Offer Support

```
Ready to start?
- Say "start [task name]" to mark task as in progress
- Say "/daily-pulse tomorrow" for tomorrow's briefing
- Say "/daily-pulse week" for the week overview
```

---

## Variations

### Tomorrow Look-Ahead

**When to use:** User passes "tomorrow" argument

**Actions:**
1. Fetch tomorrow's calendar agenda:
   ```bash
   gws calendar +agenda --tomorrow
   ```
2. Filter out multi-day all-day events.
2. Present events as a **table** (same format as default pulse, with *(you're optional)* on optional events)
3. Add **"A few things to note:"** section with bullets for free blocks, cancellations/declines, back-to-back stretches, and conflicts
4. Show tasks with due dates tomorrow
5. Show overdue tasks still outstanding

**Output:** Calendar table + notes + tasks due tomorrow + overdue

### Week Overview

**When to use:** User passes "week" argument

**Actions:**
1. Fetch next 7 days of events:
   ```bash
   gws calendar +agenda --week
   ```
2. Filter out multi-day all-day events.
2. Summarize per-day: meeting count, total meeting time
3. Show tasks due this week from `tasks/`

**Output format:**
```
Week Overview ([Date Range])

[Day]  [N] meetings  [X]h
[Day]  [N] meetings  [X]h
...

BUSIEST DAY: [Day] -- [Context]
LIGHTEST DAY: [Day] -- Best for deep work

TASKS DUE THIS WEEK
- [Task] (P0) - Due [Day]
- [Task] (P1) - Due [Day]

OVERDUE
- [Task] (P1) - Due [date], [N] days overdue
```

---

## Best Practices

- Keep this session under 2 minutes
- Focus on outcomes, not activity
- Mark tasks as started when you begin work
- If user seems stuck choosing, make a recommendation
- If calendar fetch fails, proceed with task-only pulse and note the issue
