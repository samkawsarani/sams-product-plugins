---
name: weekly-recap
model: sonnet
description: Generates an exec-ready weekly recap structured around key initiatives for sharing with manager and execs. Pulls from tasks, transcripts, and goals. Invoked via /weekly-recap or "write my weekly update", "write my update for leadership". Supports "quick", "slack" modes.
argument-hint: '[optional: "quick" for condensed, "slack" for Slack-optimized]'
---

# Weekly Recap Generator

Generate a polished, exec-ready weekly recap structured around key initiatives. This is for sharing upward — not an internal reflection. Focus on initiative progress, strategic signals from meetings, and what's coming next.

## Context

- **Report Date**: $TODAY
- **Arguments**: $ARGUMENTS
- Find task and goal context from the project.
- Find meeting transcripts from this week.
- Find initiative context and voice/tone guidance from the project.
**Audience:** Manager and execs — people with some but not deep context on your day-to-day work.

**Tone:** Professional but warm. Heavy on structure and scannability. Concise with clear action items. Follow exec audience tone guidance from the project — no corporate jargon, no hedging, get to the point.

**Recommended timing:**
- Friday afternoon (while the week is fresh)
- Monday morning (recap last week before new priorities)

## Your Task

If user provided arguments: $ARGUMENTS
- "quick" → Skip to the Quick Version section below
- "slack" → Format a Slack-optimized version (shorter, plain markdown, no nested headers)

---

## Step 0: Calculate Date Range

Determine the reporting period before collecting any data.

1. **Current week** = last completed Monday through Sunday
   - If today is Monday, current week = previous Monday to yesterday (Sunday)
   - If today is any other day, current week = most recent Monday to most recent Sunday
2. Display the calculated date range in the output header as `[Start Date] - [End Date]`

---

## Steps 1 and 2: Collect Data (Parallel)

**Steps 1 and 2 are independent. Execute them in parallel.**

### Step 1: Find This Week's Transcripts

**Actions:**
1. Find meeting transcripts from within the date range from Step 0
2. **Token optimization**: Read transcript summaries/headers first. Only deep-read transcripts that are relevant to active initiatives or contain decision keywords.
3. Cap transcript reading at 5 most recent if volume is high.
4. From relevant transcripts, extract:
   - Key decisions made
   - Customer or merchant signals (feedback, pain points, requests)
   - Strategic discussions or pivots
   - Blockers or risks raised
   - Cross-team dependencies mentioned
5. Keep attribution for each insight: which meeting, which date

**Keep a running list of extracted insights — these feed into Steps 3 and 4.**

### Step 2: Review Completed and In-Progress Work

**Actions:**
1. Find tasks completed this week
2. Find tasks currently in progress
3. Find blocked tasks
4. Identify stale tasks (started but not updated recently)
5. Group tasks by goal alignment

Use whatever task tools or files are available in the project.

**Do not output this step directly — it feeds into Step 3.**

---

## Step 3: Assess Initiative Progress

**Actions:**
1. Find and read goal context from the project
2. Find and apply any voice/tone guidance for exec audience. Apply to all output sections.
3. Find initiative context from the project
   - **Token optimization**: Skip initiative files if goal context provides sufficient information
4. For each active goal/initiative, combine task data (Step 2) with transcript insights (Step 1) to assess:
   - What shipped or moved forward this week
   - Current status: On Track, At Risk, or Blocked
   - Key decisions made (from transcripts)
   - What's coming next

**Output format:**
```
## Weekly Recap: [Start Date] - [End Date]

### TL;DR

[1-2 sentence summary. Lead with the headline — what's the most important thing that happened this week? If something is at risk, say so.]

---

### Initiative Progress

**[Goal/Initiative Name]**
Status: On Track | At Risk | Blocked

- **What moved:** [Key accomplishments — shipped, milestones hit, progress made]
- **Key decisions:** [Decisions from meetings that affect this initiative]
- **Next up:** [What's planned for next week]

---

**[Goal/Initiative Name]**
Status: On Track | At Risk | Blocked

- **What moved:** [Key accomplishments]
- **Key decisions:** [Decisions from meetings]
- **Next up:** [What's planned]

(repeat for each active initiative — skip initiatives with no activity this week unless they are at risk or blocked)
```

## Step 4: Synthesize Transcript Insights

**Actions:**
1. Review the extracted transcript insights from Step 1
2. Surface themes that don't fit neatly under a single initiative but matter for leadership visibility:
   - Customer or merchant feedback patterns
   - Competitive signals
   - Cross-team asks or dependencies
   - Strategic pivots or new information

**Output format (append to the recap):**
```
### Customer and Merchant Signals

- **[Signal]:** [Brief context — who said it, what meeting (date), why it matters]
- **[Signal]:** [Brief context]

(only include if there are meaningful signals from transcripts — skip this section if nothing notable)
```

## Step 5: Risks, Blockers, and Next Week

**Actions:**
1. Pull blocked tasks (status `b`) and stale tasks from Step 2
2. Include risks surfaced from transcripts in Step 1
3. Identify top 2-3 priorities for next week based on goal alignment and urgency

**Output format (append to the recap):**
```
### Risks and Blockers

- **[Risk/Blocker]:** [Impact on which initiative] — [What's being done about it or what's needed]

(skip if nothing is blocked or at risk)

### Next Week Focus

1. [Top priority — tied to which initiative]
2. [Second priority]
3. [Third priority]
```

---

## Step 6: Validation Checklist

Before presenting the final recap, verify:

- [ ] Every active initiative is accounted for (covered or explicitly skipped with reason)
- [ ] Date range in header matches the actual period covered (from Step 0)
- [ ] Transcript insights are attributed (which meeting, which date)
- [ ] "Next Week Focus" items align with project goals
- [ ] Voice matches exec tone guidance (no jargon, no hedging)
- [ ] TL;DR leads with the headline, not a summary of activity
- [ ] Stale tasks are flagged if any exist

---

## Quick Version

If user passed "quick" argument, collapse everything into a tight leadership update. Still execute Steps 0-2 for data collection, but output this condensed format:

```
## Weekly Recap: [Start Date] - [End Date]

**Initiative Status:**
- [Initiative 1]: On Track — [one-liner on what moved]
- [Initiative 2]: At Risk — [one-liner on the risk]
- [Initiative 3]: On Track — [one-liner on what moved]

**Key decisions:** [1-2 bullets]
**Risks:** [1-2 bullets if any, omit section if none]
**Next week:** [2-3 bullets]
```

---

## Slack Version

If user passed "slack" argument, format for Slack posting:
- Plain markdown (no nested headers beyond ##)
- Shorter bullets, tighter language
- No attribution details (keep it scannable)
- Max ~15 lines total

---

## Error Handling

| Scenario | Action |
|----------|--------|
| No transcripts this week | Proceed with task/goal data only, note "No meeting transcripts for this period" in output |
| No completed tasks | Focus on in-progress and blocked items, note in TL;DR |
| No active goals found | Flag to user, generate task-based recap instead of initiative-based |
| Initiative file missing/empty | Use available goal description as fallback context |
| No task data found | Ask the user to summarize completed work directly |
| Stale tasks found | Include in Risks and Blockers section with recommendation |

---

## Best Practices

- Lead with initiative progress, not task lists — execs care about outcomes, not activity
- Use transcript insights to add color and strategic context that task data alone misses
- Be honest about status — flag At Risk or Blocked early, don't hide problems
- Keep it scannable — headers, bold, bullets. No walls of text
- Only include Customer and Merchant Signals if there's something genuinely worth surfacing
- Match voice/tone guidance: direct, structured, no jargon, action-oriented
- Aim for a 2-3 minute read (full version) or 30-second scan (quick version)

---

## Token Optimization Notes

- Read transcript summaries/headers first, only deep-read relevant ones
- Skip initiative files if goal context provides sufficient information
- Cap transcript reading at 5 most recent if volume is high
