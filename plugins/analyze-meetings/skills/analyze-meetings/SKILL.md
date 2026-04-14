---
name: analyze-meetings
description: Analyzes meeting transcripts to uncover communication patterns, behavioral tendencies, and growth opportunities. Identifies conflict avoidance, filler word usage, speaking ratios, interruption patterns, and leadership facilitation style from transcript files (.txt, .md, .vtt, .srt). Invoke when the user wants to analyze meetings, review their communication style, get feedback on facilitation, track speaking habits, compare meeting patterns over time, or examine a folder of transcripts for behavioral insights. Also triggers on "when do I avoid conflict", "how do I come across in meetings", "analyze my transcripts", "am I a good listener", "analyze meetings at ~/path", or any request to examine meeting files.
model: sonnet
allowed-tools: Read, Glob, Bash
argument-hint: "[path/to/meetings/folder]"
---

## Context

Arguments: `$ARGUMENTS`

---

## Instructions

### Step 1: Resolve the Meetings Path

- If `$ARGUMENTS` is provided, use it as the meetings folder path
  - Expand `~` if needed: `bash -c 'echo <path>'`
  - Verify the folder exists and has readable files: `ls "<resolved-path>"`
  - If the folder doesn't exist, tell the user and stop
- If no path was provided, ask: "Please provide the path to your meetings folder (e.g. `~/meetings/`)."

### Step 2: Discover Available Data

Scan the folder for transcript files (`.txt`, `.md`, `.vtt`, `.srt`, `.docx`):

```bash
ls "<meetings-path>"
```

- Confirm how many files and what date range they cover
- Check whether files contain speaker labels (e.g. `Sam:`, `[Sam]`, `Speaker 1:`)
- Identify the user's name or label in the transcripts — ask if unclear

If no transcript files are found, tell the user what formats are supported and stop.

### Step 3: Clarify Analysis Goals

If the user hasn't specified what to look for, ask what they want to learn:

- Specific behaviors: conflict avoidance, interruptions, filler words
- Communication effectiveness: clarity, directness, listening
- Meeting facilitation and leadership style
- Speaking ratios and turn-taking patterns
- Tracking improvement over time

### Step 4: Read and Analyze Transcripts

Read each relevant transcript file. For each requested analysis dimension:

**Conflict Avoidance**
- Hedging language: "maybe", "kind of", "I think", "sort of", "potentially"
- Indirect asks instead of direct requests
- Changing subject when tension arises
- Non-committal agreement: "yeah, but...", "whatever you think"
- Not naming obvious problems when they come up

**Speaking Ratios**
- Estimate percentage of each meeting the user is speaking
- Count interruptions (both by and of the user)
- Note question vs. statement ratio
- Track average speaking turn length

**Filler Words**
- Count: "um", "uh", "like", "you know", "actually", "basically", etc.
- Frequency per speaking turn, and in which situations they spike

**Active Listening**
- Questions that reference what someone else just said
- Paraphrasing or summarizing others' ideas
- Building on contributions from other participants
- Asking clarifying follow-up questions

**Leadership & Facilitation**
- Directive vs. collaborative decision-making
- How disagreements and pushback are handled
- Drawing in quieter participants
- Time management and agenda control
- Clarity of action items and follow-through

### Step 5: Provide Specific Examples

For each pattern found, structure the output like this:

```markdown
### [Pattern Name]

**Finding**: [One-sentence summary]

**Frequency**: [X times across Y meetings]

**Examples**:

1. **[Meeting Name/Date]** — [Timestamp if available]

   **What Happened**:
   > [Actual quote from transcript]

   **Why This Matters**:
   [Why this behavior has an impact]

   **Better Approach**:
   [Specific alternative phrasing or action]
```

Aim for 2–3 strong examples per pattern. Use real quotes from the transcripts.

### Step 6: Synthesize Insights

After covering all patterns, deliver a summary:

```markdown
# Meeting Insights Summary

**Analysis Period**: [Date range]
**Meetings Analyzed**: [N meetings]

## Key Patterns Identified

### 1. [Primary Pattern]
- **Observed**: [What you found]
- **Impact**: [Why it matters]
- **Recommendation**: [How to improve]

### 2. [Second Pattern]
...

## Communication Strengths

1. [Strength with example]
2. [Strength with example]

## Growth Opportunities

1. **[Area]**: [Specific, actionable advice]
2. **[Area]**: [Specific, actionable advice]

## Speaking Statistics

- Average speaking time: [X% of meeting]
- Questions per meeting: [X average]
- Filler words: [X per minute or per turn]
- Interruptions: [X given / Y received per meeting]

## Next Steps

[3–5 concrete actions the user can take]
```

### Step 7: Offer Follow-Up Options

Offer to:
- Deep dive into a specific meeting or pattern
- Compare patterns across two time periods (e.g. Q1 vs. Q2)
- Track these same metrics as new meetings are added
- Generate a development plan or performance review summary

---

## Example: Conflict Avoidance Analysis (inspired by Dan Shipper)

**User**: "Tell me all the times I subtly avoided conflict."

**Output**:
```markdown
# Conflict Avoidance Patterns

Found 23 instances across 15 meetings where you used indirect communication
or avoided addressing tensions directly.

## Pattern: Hedging on Critical Feedback

**Frequency**: 8 times across 7 meetings

**Example: 1:1 with Sarah** — 00:14:32

**What Happened**:
> "So, I was thinking... maybe we could, like, potentially consider
> looking at the timeline again? Whatever you think is best."

**Why This Matters**:
The hedging language ("maybe", "potentially") and the deflection at the
end made it easy for Sarah to miss the urgency of a two-week delay.

**Better Approach**:
"Sarah, the project is two weeks behind schedule. We need to agree on a
new plan today — what's blocking you?"
```

---

## Getting Transcripts

**→ Read `references/transcript-sources.md`** for instructions on exporting transcripts from Granola, Zoom, Google Meet, Fireflies, and Otter.ai, plus file naming best practices.
