---
name: write-doc
model: sonnet
description: Generates PM documents (PRDs, specs, briefs, user stories, decision docs) from templates and knowledge base context. Supports two modes — auto-generate for immediate first drafts, or co-authoring for guided iterative writing. Invoked when asked to write, generate, or co-author product documents, or when user says "help me write a PRD", "draft a spec for X", or "I need a brief on Y".
argument-hint: '[doc-type] [name] — types: prd, brief, spec, user-stories, decision'
compatibility: "qmd CLI optional for semantic search."
---

## Dependency Check

Before starting, check optional dependencies:

1. **qmd (optional):** Run `command -v qmd`.
   - If **available**: Use `qmd query` for semantic search across knowledge bases — this gives the best results.
   - If **missing**: Fall back to `Grep` and `Glob` for keyword search. Note to the user that `qmd` would improve search quality, but proceed without it.

---

# Product Documentation Generator

Generate comprehensive product documentation (PRDs, briefs, specs, user stories, decision docs) with full context from your knowledge base.

## Modes

This skill supports two modes:

**Auto-Generate Mode** (default): Generates a complete first draft from templates and knowledge base context. Use when you want an immediate, comprehensive document.
- Triggered by: `/write-doc prd feature-name`, `/write-doc spec feature-name`, or "generate a PRD for X"

**Co-Authoring Mode**: Guided, iterative document creation through structured conversation — context gathering, section-by-section refinement, and reader testing. Use when you want collaborative, high-quality writing.
- Triggered by: `/write-doc` with collaborative intent, "co-author a doc", "help me write a spec", or "let's work on a PRD together"
- See `references/coauthoring-workflow.md` for the full co-authoring workflow

**How to choose:**
- Need a quick first draft? → Auto-generate
- Want to iterate and refine together? → Co-authoring
- Not sure? → Auto-generate first, then switch to co-authoring for refinement

## Quick Start

**Arguments:** `$ARGUMENTS`

Parse `$ARGUMENTS` to determine:
1. **Document type**: prd, brief, spec, user-stories, decision
2. **Subject name**: The feature/project name
3. **Mode hint**: If user language suggests collaboration ("help me write", "let's co-author", "work together on"), use co-authoring mode

If document type is not specified, ask the user which type they need.

**How it works (auto-generate):**
1. Identify document type needed (or ask if ambiguous)
2. Gather context from knowledge base and existing files
3. Select appropriate template from assets/
4. Generate complete first draft
5. Present for review and iteration

**How it works (co-authoring):**
1. Follow the workflow in `references/coauthoring-workflow.md`
2. Three stages: Context Gathering → Refinement & Structure → Reader Testing

## Core Workflow

Follow this workflow for auto-generate mode:

### Step 1: Understand the Request

Identify:
- Document type (PRD, brief, spec, user stories, decision doc)
- Subject (feature/project name, decision made)
- Any specific requirements or constraints mentioned
- Target audience (if specified)

If document type is ambiguous, ask the user which type they need using the table above as reference.

### Step 2: Gather Context

**Pull relevant context (in order of priority):**

1. **Existing related documents**: Find related initiatives, specs, PRDs, or briefs that provide relevant context.

2. **Product strategy and frameworks**: Find product vision, roadmap, strategic pillars, PM frameworks, and company context.

3. **User research**: Find user interviews, stakeholder meeting notes, relevant insights, pain points, and quotes.

4. **Writing style**: Find voice/tone samples and writing style guides if available.

5. **Process and standards**: Find team rituals, decision-making frameworks, and current metrics/KPIs if available.

**Context gathering approach:**
- Use `qmd query "topic"` for semantic search if available (best for open-ended context gathering)
- Use Glob/Grep for keyword and pattern search
- Focus on recent and relevant documents
- Prioritize quality over quantity — better to deeply understand 2-3 key docs than skim 20
- If user references specific files with @ mentions, prioritize those

### Step 3: Select Template

Load the appropriate template from this skill's `assets/` directory:
- `assets/prd-template.md` - For PRDs
- `assets/brief-template.md` - For project briefs
- `assets/spec-template.md` - For product specs
- `assets/user-stories-template.md` - For user stories
- `assets/decision-doc-template.md` - For decision documentation

### Step 4: Generate Complete First Draft

**Critical: Generate a COMPLETE first draft.** Do not leave placeholder text or TODOs unless genuinely unknown.

**For each section in the template:**
1. Fill with specific, contextual content based on gathered information
2. Use actual data, metrics, and insights from the knowledge base
3. Include concrete examples and specific details
4. Match writing style from voice samples
5. Flag genuine unknowns as "Open Questions" rather than leaving blank
6. If a section truly doesn't apply, either remove it or explain why it's N/A

**Quality standards:**
- Every statement should be specific and actionable
- Replace template placeholders with real content
- Use actual user quotes from transcripts when available
- Include real metrics from product-analytics (or note current/target as TBD)
- Cross-reference related documents for consistency
- Ensure strategic alignment with product-strategy files

### Step 5: Validate Before Presenting

Run through the Quality Checklist (below) before showing the document. Fix any issues found. If a section feels thin or generic, revisit context sources for richer content rather than presenting filler.

### Step 6: Present and Iterate

Present the generated document with:
1. **Summary**: Brief overview of what was generated
2. **What was included**: Key sections populated and their sources
3. **What needs review**: Sections that need user input or validation
4. **Open questions**: Genuine unknowns that surfaced during generation
5. **Next steps**: Suggested actions (e.g., "Review success metrics", "Add technical details")

Then iterate based on user feedback. After each round of revisions, re-validate against the Quality Checklist before presenting updates.

## Doc Type Guidelines

Each type has a template in `assets/`. Key non-obvious rules per type:

**PRD** (`assets/prd-template.md`): Lead with "Why" (business value, user impact). Define success with current → target metric values. Explicitly call out what's out of scope.

**Brief** (`assets/brief-template.md`): 1–2 pages max — this is an alignment doc, not a spec. In/out scope must be crystal clear.

**Spec** (`assets/spec-template.md`): Requirements use P0/P1/P2 prioritization. Every requirement has testable acceptance criteria.

**User Stories** (`assets/user-stories-template.md`): Standard format "As a [user], I want [goal], so that [benefit]". Include edge cases and error scenarios. Each story gets 3–5 acceptance criteria.

**Decision Doc** (`assets/decision-doc-template.md`): State the decision in one sentence upfront. Explicit tradeoffs (what we're giving up). Measurable success criteria. Ask user for save location or use current directory.

## Quality Checklist

Before presenting any generated document, verify:

- [ ] All template sections are filled (or explicitly marked N/A with reason)
- [ ] No placeholder text like [TODO], [X], [Name] remains
- [ ] Metrics have actual values (or marked as "Current: TBD, Target: TBD")
- [ ] References to user research include actual quotes or insights
- [ ] Strategic alignment is explicit and references actual strategy docs
- [ ] Writing style matches voice samples (if available)
- [ ] Open questions are captured in dedicated section (not as TODOs)
- [ ] Related documents are cross-referenced
- [ ] Document has clear owner, date, and status
- [ ] Success metrics are specific and measurable
- [ ] Out of scope items are explicitly called out

## Advanced Usage

- **From opportunity/initiative file**: Read source → extract problem/target users/strategic value → expand into doc type → link back to source
- **Expand existing doc**: Read existing → identify gaps → fill missing sections → preserve all existing content
- **Update lifecycle status**: Update status field in doc header, add changelog entry with date
