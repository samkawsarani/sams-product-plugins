---
name: analyze-research
model: opus
description: Analyzes user interviews, research transcripts, and feedback to extract themes, generate insights, create personas, and synthesize findings into actionable reports. Invoked when asked to analyze interviews, synthesize research, identify pain points, produce research synthesis, or when user says "what did users say about X", "summarize research on Y", or shares interview notes.
compatibility: "qmd CLI optional for semantic search."
---

## Dependency Check

Before starting, check optional dependencies:

1. **qmd (optional):** Run `command -v qmd`.
   - If **available**: Use `qmd query` for semantic search across knowledge bases — this gives the best results.
   - If **missing**: Fall back to `Grep` and `Glob` for keyword search. Note to the user that `qmd` would improve search quality, but proceed without it.

---

# User Research Analysis

## Overview

Systematically analyze user interviews, research transcripts, surveys, and feedback to extract themes, identify patterns, generate actionable insights, and create comprehensive synthesis reports or personas.

## Analysis Workflow

### 1. Understand the Request

Clarify what type of analysis is needed:
- **Theme extraction**: Identify recurring topics and patterns
- **Insight generation**: Synthesize findings into actionable recommendations
- **Persona creation**: Build user profiles from research data
- **Quick synthesis**: Summarize key findings
- **Full report**: Comprehensive research synthesis document

Determine the source materials:
- Location of transcripts (ask the user if not provided)
- Related files — initiatives, specs, or prior research
- Timeframe or specific interviews to analyze

Find relevant transcripts and documents using available search tools.
- Any specific questions to answer

### 2. Review Source Materials

Read through all relevant materials:
- Interview transcripts
- Survey responses
- Feedback forms
- Meeting notes
- Related product specs, opportunities, or initiatives

**Use the analysis framework** by reading `references/analysis-framework.md` for systematic guidance on:
- How to extract themes
- How to categorize findings
- How to quote effectively
- How to generate insights from observations

### 3. Perform Analysis

Based on the analysis framework, systematically:

**Extract themes:**
- Identify recurring pain points, feature requests, behaviors
- Quote verbatim with source attribution
- Note frequency (how many users mentioned it)
- Assess intensity (how strongly they felt about it)

**Categorize findings:**
- Pain Points
- Feature Requests
- Workflow Patterns
- Usability Issues
- Jobs to be Done
- Competitive Insights

**Generate insights:**
- Transform observations into implications
- Connect findings to product strategy
- Recommend next steps
- Prioritize based on frequency, intensity, and strategic fit

### 3b. Multiple Transcript Analysis (Parallel Processing)

When analyzing 3+ independent transcripts, launch parallel Explore agents (max 3 concurrent) to analyze transcripts independently — each extracting themes, verbatim quotes, pain points, and feature requests with frequency/intensity. Then aggregate: merge theme counts, deduplicate quotes, cross-reference patterns across transcripts, and prioritize by (frequency × intensity).

### 4. Create Deliverable

Choose the appropriate output format:

#### Full Research Synthesis Report

Use the template at `assets/synthesis-report-template.md` when creating comprehensive reports. Copy the template structure and populate with:
- Executive summary with top 3 insights
- Detailed findings with supporting quotes
- User segments identified
- Pain points summary table
- Feature requests and opportunities
- Behavioral patterns and workflows
- Competitive insights
- Recommendations (immediate, short-term, long-term)
- Open questions and next steps

Save synthesis reports alongside related files, or ask the user where to save.

#### Insight Cards (Quick Summaries)

Use the template at `assets/insight-card-template.md` for stakeholder-friendly summaries. Each card includes:
- Priority level (High/Medium/Low)
- Category (Pain Point/Feature Request/etc.)
- Clear one-sentence insight
- Supporting quotes with sources
- Frequency data
- Why it matters
- Recommended action

Save insight cards alongside related files, or ask the user where to save.

#### User Personas

**Read the persona guide** at `references/persona-guide.md` for detailed instructions on creating research-based personas. The guide covers:
- What makes a good persona
- Required components (goals, pain points, behaviors, context)
- How to segment users from research
- Persona format template
- Anti-patterns to avoid

Save personas in the relevant project location, or ask the user where to save.

### 5. Link to Source Materials

Always reference source materials in the output:
- Link to specific transcript files
- Attribute quotes with dates and participant roles
- Note sample size and methodology
- Flag any biases or limitations

## Best Practices

- Quote verbatim with attribution (Interview YYYY-MM-DD with [Role]) — never paraphrase customer words
- Track both frequency (how many mentioned it) and intensity (how strongly they felt) — prioritize themes with both
- Don't cherry-pick: note contradictions and distinguish edge cases from patterns
- Make it actionable: connect findings to product implications, flag what needs further research
