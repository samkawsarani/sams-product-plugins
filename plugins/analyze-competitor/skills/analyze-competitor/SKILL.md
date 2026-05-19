---
name: analyze-competitor
model: opus
description: Analyzes competitors including features, pricing, target customers, strengths, gaps, and market positioning. Handles single-competitor deep dives and multi-competitor parallel research with comparison matrix. Invoked when asked to research, analyze, or compare against competitors, when user mentions a competitor by name, or says "how does X compare" or "research competitor Y".
compatibility: "Notion MCP optional for internal research."
---

## Dependency Check

1. **Notion MCP (optional):** Check if `Notion:notion-search` is available in your tools list.
   - If **available**: Use it to search for internal competitor research.
   - If **missing**: Skip Notion search and proceed with other sources.

---

# Competitor Analysis Skill

Perform comprehensive competitive analysis of a single competitor, gathering intelligence from multiple sources to create a structured research report.

This skill analyzes ONE competitor at a time. For analyzing multiple competitors in parallel, pass multiple competitor names.

**Output**: Structured markdown report saved to `competitor-[NAME]-comparison.md` (or user-specified location)

**Data sources** (in priority order):
1. Project files (existing research, transcripts, context files)
2. Notion workspace (if MCP available)
3. Web search (pricing pages, reviews, testimonials)
4. User-provided sources

---

## Workflow

### Step 1: Understand the Request

Gather essential information:

**Required**:
- Competitor name
- Website URL (or prompt user if not provided)

**Optional**:
- Our product context (look for a product context file)
- Specific focus areas (e.g., "focus on pricing" or "analyze their enterprise features")
- Output location (default: `competitor-[name]-comparison.md`)

**If a product context file exists**: Read it to understand our product for comparison purposes.

---

### Step 2: Gather Information (Multi-Source Strategy)

Follow this prioritized approach to gather comprehensive competitive intelligence:

#### Source 1: Project Files (Check First)
- Search for existing research mentioning the competitor
- Search for transcripts or notes mentioning the competitor
- Use `Read` to load any existing research notes found
- **Why first**: Existing internal research is most reliable and contextual

#### Source 2: Notion Workspace (If Available)
- Check if Notion MCP tools are available
- Use `Notion:notion-search` with queries like:
  - `[Competitor Name]`
  - `[Competitor Name] pricing`
  - `[Competitor Name] features`
  - `[Competitor Name] customers`
- Use `Notion:notion-fetch` to retrieve relevant pages
- **Why second**: Internal research may contain analysis and context

#### Source 3: Web Search (Public Information)
- Use `WebSearch` for targeted queries:
  - `[Competitor Name] pricing 2026`
  - `[Competitor Name] features`
  - `[Competitor Name] customers case studies`
  - `[Competitor Name] reviews`
  - `[Competitor Name] vs competitors`
- Use `WebFetch` to retrieve specific pages:
  - Competitor's official pricing page
  - Competitor's features/product page
  - Review sites (G2, Capterra, TrustRadius)
  - Customer testimonial pages
- **Why third**: Most current public information, but needs validation

#### Source 4: User Input (Always Available)
- Ask user if they have specific sources to include
- Ask about particular aspects to focus on
- Clarify any ambiguous information
- **Why last**: Fill gaps identified in other sources

**Research Categories to Cover**: Company Overview, Product Features, Pricing Model, Target Customers, Strengths & Competitive Advantages, Weaknesses & Gaps, Customer Testimonials & Reviews, Market Positioning.

See `references/research-methodology.md` for extraction guidance, credibility checks, and what to look for in each category.

---

### Step 3: Analyze and Synthesize

After gathering raw data, analyze it:

**Extract Evidence**:
- Quote liberally with attribution (never paraphrase reviews)
- Use specific data points (numbers, percentages, dates)
- Note conflicting information from different sources
- Flag assumptions vs. facts

**Identify Patterns**:
- Themes across multiple reviews
- Consistency between marketing claims and customer feedback
- Feature gaps relative to our product (if product-info.md exists)
- Pricing positioning in market

**Assess Data Quality**:
- Note data freshness (when was it published?)
- Flag outdated information (pricing from 2 years ago)
- Identify information gaps (missing pricing, no customer testimonials)
- Mark speculative vs. confirmed information

**Load Analysis Framework**:
- Read `references/research-methodology.md` for systematic analysis approach
- Follow credibility checks and validation steps
- Apply framework to ensure comprehensive coverage

---

### Step 4: Generate Report

Use `assets/competitor-profile-template.md` — it contains all required sections in order with formatting guidance. Follow the template structure exactly.

Key formatting rules: use tables for features and pricing, blockquotes for verbatim testimonials with attribution, ✅/⚠️/❌ for feature comparisons. Include "Comparison to Us" column only if product-info.md exists.

---

### Step 5: Validate Report Completeness

Before saving, verify the report covers all 8 research categories from Step 2. For each category, confirm:
- Evidence is cited with sources (not just assertions)
- Data freshness is noted
- Gaps are explicitly flagged rather than silently omitted

If any category has no data, include it in the report with "No information found" and suggest how to fill the gap.

### Step 6: Save Output

**Default location**: `competitor-[name]-comparison.md` in the current directory, or ask the user for preferred location
- Normalize name to lowercase-with-hyphens
- Example: "Stripe" → `competitor-stripe-comparison.md`

**Custom location**: If user specifies different path, save there instead

**After saving**:
- Confirm save location to user
- Provide 2-3 sentence summary of key findings
- Suggest next steps (research more competitors, create comparison matrix)

---

## Error Handling

**If competitor website not found**:
- Ask user for correct URL
- Try common variations (.com, .io, .co)
- Search for "[Competitor Name] official website"

**If no pricing information found**:
- Note "Pricing not publicly available - likely custom/enterprise only"
- Look for analyst reports or user discussions about pricing
- Ask user if they have pricing information

**If Notion MCP unavailable**:
- Skip Notion search gracefully
- Note in report: "Notion research not performed (MCP unavailable)"
- Proceed with other sources

**If WebSearch fails**:
- Note which searches failed
- Proceed with available sources
- Flag gaps in final report

**If very little information found**:
- Still create report with available information
- Clearly mark data gaps
- Suggest manual research or user interviews
- Recommend researching a different competitor if this one is too obscure

---

## Multi-Competitor Research

Orchestrates research across multiple competitors in parallel and synthesizes into a comparison matrix.

**Outputs**:
- Individual reports: `competitor-[name]-comparison.md` (current directory or user-specified location)
- Comparison matrix: `competitor-comparison-matrix-YYYY-MM-DD.md` (current directory or user-specified location)

### Step 1: Identify Competitors

Check in this order:
1. **File**: Search for a competitors list file → parse competitor list
2. **Arguments**: Parse `$ARGUMENTS` for comma-separated names/URLs
3. **Prompt**: If neither exists, ask user for competitor list

Also look for a product context file for comparison context.

### Step 2: Invoke Parallel Research

For EACH competitor, invoke this skill's single-competitor workflow **simultaneously** using parallel Task agents.

### Step 3: Monitor & Handle Errors

- Successful analyses → note report location
- Failed analyses → continue with others, note in summary

### Step 4: Aggregate Results

Read all generated reports. Extract from each: executive summary, features, pricing, strengths (top 2-3), weaknesses (top 2-3), target customers, market positioning.

Synthesize patterns:
- Common features (all have) vs unique features (only one has)
- Pricing patterns and ranges
- Shared strengths (threats) and common gaps (opportunities)

### Step 5: Generate Comparison Matrix

Sections: Executive Summary, Feature Comparison Matrix (table with checkmarks), Pricing Comparison, Target Customer Comparison, Positioning Map, Strengths/Weaknesses by Competitor, Market Gaps & Opportunities, Competitive Threats (severity-rated), Strategic Recommendations, Links to Individual Reports.

### Step 6: Present Results

Provide: list of individual reports, link to comparison matrix, 3 key insights, suggested next steps.
