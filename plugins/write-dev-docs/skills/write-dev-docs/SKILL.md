---
name: write-dev-docs
model: sonnet
description: Generates best-in-class developer documentation (API references, integration guides, code recipes, Postman collections) from OpenAPI specs, code, natural language, or PRDs. Stripe-quality output. Invoked when asked to write API docs, developer guides, code samples, quickstarts, Postman collections, or when user says "document this API", "write a quickstart for X", or "create a Postman collection".
argument-hint: '[doc-type] [name] — types: api-reference, guide, recipe, postman'
compatibility: "qmd CLI optional for semantic search."
---

## Dependency Check

Before starting, check optional dependencies:

1. **qmd (optional):** Run `command -v qmd`.
   - If **available**: Use `qmd query` for semantic search across knowledge bases — this gives the best results.
   - If **missing**: Fall back to `Grep` and `Glob` for keyword search. Note to the user that `qmd` would improve search quality, but proceed without it.

---

# Developer Documentation Generator

Generate Stripe-quality developer documentation — API references, integration guides, code recipes, and Postman collections — from any input source.

## Quick Start

**Arguments:** `$ARGUMENTS`

Parse `$ARGUMENTS` to determine:
1. **Doc type**: api-reference, guide, recipe, postman
2. **Subject name**: The resource, feature, or API being documented
3. **Additional context**: Language preferences, audience level, specific endpoints

If doc type is not specified, ask the user which type they need.

**Triggers:**
- `/write-dev-docs api-reference payments` — API reference for payments resource
- `/write-dev-docs guide getting-started` — Integration quickstart guide
- `/write-dev-docs recipe create-payment` — Multi-language code recipe
- `/write-dev-docs postman payments-api` — Exportable Postman collection
- "Write API docs for..." / "Create a developer guide for..." / "Generate code samples for..."

**Scope — this skill is for:**
- API endpoint documentation (REST)
- Developer integration guides and tutorials
- Multi-language code samples and recipes
- Postman/API client collections

**NOT for:**
- PM documents (PRDs, specs, briefs) → use `write-doc`
- UX copy or UI text → use `write-ux-copy`
- SDK source code or library implementation
- Internal architecture docs

## Doc Types

| Type | Command | Output | Audience | Reference |
|------|---------|--------|----------|-----------|
| API Reference | `api-reference [resource]` | Endpoint-by-endpoint reference with params, responses, errors | Developers integrating the API | `references/api-reference-format.md` |
| Integration Guide | `guide [name]` | Step-by-step tutorial from zero to working code | Developers new to the platform | `references/guide-format.md` |
| Code Recipe | `recipe [use-case]` | Multi-language copy-paste snippets (cURL, Node.js, Python) | Developers building specific features | `references/code-recipe-format.md` |
| Postman Collection | `postman [api-name]` | Exportable Postman v2.1 JSON with test scripts | Developers testing and exploring the API | `references/postman-format.md` |

## Input Sources

The workflow adapts based on what the user provides:

| Source | Detection | Workflow Adaptation |
|--------|-----------|-------------------|
| **OpenAPI/Swagger spec** | User provides `.yaml`/`.json` file or URL | Parse spec → extract endpoints, schemas, auth → generate structured docs |
| **Existing code/routes** | User points to route files, controllers, or handlers | Infer API contracts from code → extract params, responses, middleware → document |
| **Natural language description** | User describes the API verbally | Gather relevant context → construct API docs from requirements and context |
| **PRD/technical spec** | User references a spec or initiative file | Extract API requirements, resource models, error codes → generate developer-facing docs |

## Core Workflow

### Step 1: Understand the Request

Identify:
- **Doc type**: api-reference, guide, recipe, or postman
- **Subject**: Resource name, API name, or use case
- **Input source**: What information is available (spec, code, NL, PRD)
- **Target audience**: Experience level (beginner, intermediate, advanced)
- **Language preferences**: Which code languages to include (default: cURL, Node.js, Python)

If doc type is ambiguous, ask the user. If input source is unclear, ask what they have available.

### Step 2: Gather Context

**Always pull information from these sources (in order of priority):**

1. **User-provided input**:
   - OpenAPI specs, code files, PRDs, or natural language description
   - Any existing documentation to build on or replace

2. **Supplementary context** (if available):
   - API standards, naming conventions, and strategic context
   - Goals related to developer experience or this API
   - Technical standards, release processes, and prior API design decisions

**Context gathering approach:**
- Use Glob and Grep to find relevant files — don't read everything
- Use `qmd query` for semantic search if available
- Focus on API contracts, resource models, and error definitions
- If user references specific files with @ mentions, prioritize those

### Step 3: Load Format Reference

Load the type-specific reference file from `references/`:
- `references/api-reference-format.md` — For API references
- `references/guide-format.md` — For integration guides
- `references/code-recipe-format.md` — For code recipes
- `references/postman-format.md` — For Postman collections

These contain the quality standards, conventions, and structural rules for each doc type.

### Step 4: Generate Using Template

Load the corresponding template from `assets/` and generate complete content:
- `assets/api-reference-template.md` — API reference scaffold
- `assets/guide-template.md` — Integration guide scaffold
- `assets/code-recipe-template.md` — Code recipe scaffold
- `assets/postman-collection-template.json` — Postman collection skeleton

**Critical: Generate COMPLETE content.** Every section must have real, specific content. No placeholders, no `[TODO]`, no `...` ellipsis in code samples.

**For each section:**
1. Fill with specific, contextual content based on gathered information
2. Write working code examples that use real endpoints and parameters
3. Include actual error codes and their resolutions
4. Use test/sandbox credentials in examples (never real keys)
5. Flag genuine unknowns as "Open Questions" rather than leaving blank

### Step 5: Validate Against Quality Checklist

Run through the Quality Checklist (below) before presenting. This is a **hard gate** — fix any failures before showing the document to the user. If a section is thin, revisit context sources rather than presenting filler.

### Step 6: Present and Iterate

Present the generated documentation with:
1. **Summary**: What was generated and for which API/resource
2. **Input sources used**: What context informed the output
3. **Assumptions made**: "I assumed X — is that right?"
4. **What needs review**: Sections requiring user validation (auth details, rate limits, error codes)
5. **Open questions**: Genuine unknowns that surfaced
6. **Next steps**: Related docs to generate (e.g., "Want me to create a guide for this API?")

Then iterate based on feedback. Re-validate against the Quality Checklist after each revision.

## Doc Type Guidelines

Each type has a template in `assets/` and format rules in `references/`. Key non-obvious rules:

**API Reference** (`assets/api-reference-template.md`, `references/api-reference-format.md`): Auth block before any endpoint. Every error code has a resolution step (not just a description). Document idempotency key support where applicable.

**Integration Guide** (`assets/guide-template.md`, `references/guide-format.md`): Open with outcome statement ("By the end of this guide..."). Each step shows expected output. Use NOTE/WARNING/TIP/SECURITY callout blocks for important asides.

**Code Recipe** (`assets/code-recipe-template.md`, `references/code-recipe-format.md`): Outcome-oriented titles ("Create a Refund", not "POST /refunds"). Variations shown as additive diffs from the base recipe — not full rewrites.

**Postman Collection** (`assets/postman-collection-template.json`, `references/postman-format.md`): Auth at collection level via `{{secret_key}}`. Minimum 3 test script assertions per request. Chain variables: Create → save ID → use in subsequent requests.

## Quality Checklist

Validate against `references/quality-checklist.md` before presenting — this is a hard gate. Fix failures before showing output.
