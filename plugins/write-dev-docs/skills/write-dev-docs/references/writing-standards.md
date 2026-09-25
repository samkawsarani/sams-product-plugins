# Writing standards

Rules for the prose itself, independent of doc type. Every one of these exists because a generated
doc shipped the defect it prevents.

Apply these unless the target repo carries its own style guide. If it does, that guide wins on every
point of conflict and this file is the fallback.

## Fact discipline

### The spec is the source of truth

The OpenAPI file, schema, or route handler decides what is required, what is optional, and what a
field is called. Prose copies it. **Never restate a contract detail from memory**, including from
another page you wrote ten minutes ago.

Read the required list out of the schema per endpoint, per edit. The typical failure: an endpoint
description marks one field required when the schema does not, and omits another that the schema
does. That survives human review easily, because each reviewer assumes the other checked.

Where documentation narrows the contract deliberately (a preview, a tier, a subset), narrow it in
one place and say why in an internal note, never in the reader-facing prose.

### If it is not in the spec, do not assert it

The contract covers the contract. It does not cover how a developer gets a key, what the dashboard
can do, how long onboarding takes, what support will say, or what the rate limits are.

Prose reaches for those facts constantly and inventing one is easy, because a plausible sentence and
a true one read identically. Typical inventions: an error code listed under a status that exists in
no error catalog, and a claim that keys can only be issued by support when a self-serve dashboard
exists.

**Not checkable against the source is the tell.** When a sentence describes something outside the
contract, confirm it with whoever owns that surface, or give it a callout saying the answer is not
settled. A callout costs less than a confident sentence that is wrong.

### Contract gaps become asks, not edits

A missing error code, a field the docs need that the spec lacks, a path that disagrees with the
service that owns it: none of those get fixed by editing the other repo. Write them down as asks,
say which side you believe is right, and document what the source says today.

Editing another repo to make a sentence true is how a doc change becomes an unreviewed contract
change.

### One canonical statement per rule

A normative convention is stated once, on the page that owns it, and linked from everywhere else.
Pagination rules live on the pagination page. Auth lives on the auth page. Repeating them per
resource is how the copies drift, and the stale one is always the copy nobody remembered to update.

Do not build a page that indexes what other pages contain. An enums page listing every value set, a
concept page cataloguing endpoints, a resource page restating another resource's fields: each is a
second copy that ages the moment the source moves. State the rule that tells a reader where to look
instead.

## What to cut

### Never state an absence

Do not tell a reader that a capability is unavailable, out of scope, or not in this version. Write
what the API does and stop.

The test: **would a competent reader build something broken without this sentence?**

| Instead of | Write |
| --- | --- |
| "There is no saved address resource" | "The shipping address is supplied on each order." |
| "Audit entries are read-only. There is no create, update, or delete" | "Audit entries are read-only and retained for 90 days." |
| "Results are sorted by name. There is no `order` parameter" | The first sentence alone. |

Kept, because each prevents a real integration bug: a retry can deliver the same event twice, so
deduplicate on its id; a new API key is shown once and never again; branch on the error `code`, never
parse the message text. Each one stops a reader building something that corrupts.

**The exception is a genuinely undecided thing.** That is not an absence, and hiding it is worse
than stating it. Give it a callout on the page where a reader would look, saying what is unsettled,
why it does not block them, and what to do meanwhile. Delete the callout when the answer lands: one
that outlives its decision is worse than none.

**Two callout severities, never mixed.** One icon means unsettled and will change. A different one
means settled and expensive to get wrong. Using the provisional icon for a permanent rule teaches
readers that permanent rules are provisional.

### Do not explain the reasoning to readers

Document the behavior. Skip why it was chosen, especially when the why is a threat model.

"Deleting a user revokes every token they hold. A deleted account cannot keep access through an old
token." The first sentence is what a reader needs. The
second answers a question nobody asked and plants one they did not have. The same instinct produces
reassurances that only work by first raising the doubt.

Design rationale, what a field replaced, and what was ruled out belong in internal documents.

### Do not over-explain a limit

State what a parameter accepts. The API's own error documents the refusal. No "takes a single
value", no "cannot be combined with". The exception is a limit that fails **silently**, where a
reader gets a wrong result instead of an error.

### Every sentence carries a fact

The benchmark is Stripe's reference. Its authentication page opens with no framing: where keys live,
what each prefix grants, why a restricted key limits damage, store it in a vault, send it as the
basic-auth username, HTTPS or the call fails. Nine facts, no runway.

Two failures to watch for:

- **Orientation instead of information.** "This page covers the models and conventions that apply
  across the API" tells a reader nothing the title did not.
- **Restating the table below.** A preamble listing the fields already in the attribute table is
  filler. Say what the table cannot: when the resource comes into existence, which fields become
  immutable, which values are filled in later.

Test a paragraph by deleting it. If the page loses no information, it was not carrying any. Watch
the opening paragraph hardest: it is where a writer justifies the page before writing it.

### Stay on the page's subject

A page answers one question. A related concept gets a link, usually at the end, not a detour in the
opening paragraph. An authentication page that opens by explaining webhook signing sends a reader
somewhere else before they have made their first authenticated call.

## Voice

Declarative, present tense. Second person for what the reader does, third for what the platform does.

Write for the spoken voice. Read it aloud. If you would not say it to someone at a desk, cut it.

Plain words over abstractions. Many readers work through translation tools, and plain declarative
English survives that better than formal-sounding paraphrase. "Uploads over 10 MB fail" beats
"file size constraints may apply to upload operations".

Vary sentence length unpredictably. Two long sentences in a row is fine. Two of the same length and
shape is not.

### Banned constructions

These are the shapes that make prose read as generated. All of them are banned.

| Banned | Looks like |
| --- | --- |
| Throat-clearing openers | "Four rules apply to every request." Start with the first thing. |
| Setup and payoff | "Learn these once and the rest of the reference reads quickly." |
| Landing sentences | A closing line that restates the paragraph with a flourish. |
| Summary beats | "That is what makes this work." |
| Antithesis | "Not a folder you manage, but a snapshot of what was uploaded." |
| Corrective negation | "Not because it is faster, but because the contract requires it." |
| Contrasting pairs | "The guide explains the why; the reference explains the how." |
| Negative parallelism | "Never edited, never deleted." |
| Negative anaphora | "No setup. No config. No waiting." |
| Rule of three | "clear, concise, and complete." Use two items or four. |
| Parallel structure inside a paragraph | Three sentences built the same way in a row. |
| Parataxis | Stacked short clauses joined by commas for rhythm. |
| Paragraph pinning | Opening and closing a paragraph on the same word or idea. |
| Rhetorical crutches | "Here is the thing." "The catch:" "Worth knowing:" |
| Em dashes | Colon, comma, parentheses, or two sentences. |
| Stacked noun phrases | "user account notification preference update request record". |
| Nominalization | "perform a validation" instead of "validate". |
| Filler intensifiers | genuinely, really, truly, actually, simply, just. |
| Hedging qualifiers | generally, typically, in most cases, arguably. |
| Corporate-register verbs | leverage, underscore, reflect, align, enable, facilitate, ensure. |
| Performed enthusiasm | "The good news is", "happily", exclamation marks. |

These govern prose. A heading, a table cell, or a bullet list may take a parallel shape, because
there the shape helps someone scan. A factual inventory is fine too: "`name`, `email`, and `role`
are the only editable fields" lists three real fields. The ban is on reaching for
three because three sounds finished.

"X, not Y" survives when Y is a wrong assumption a reader actually arrives with. "Timestamps are
Unix seconds, not milliseconds" stops someone being off by a factor of 1000. That is disambiguation doing
work, not antithesis reaching for balance.

Frontmatter and metadata prose follows every rule above. A summary line is often the first thing
read, and it is the easiest place for this register to survive a sweep.

## Links and renames

A heading slug is usually the heading lowercased with spaces hyphenated and punctuation dropped, so
recasing a heading is safe and rewording one breaks every anchor pointing at it, silently.

Grep for the old slug before the rename, not after. If the page slug itself changes, the published
site needs a redirect.

## On automated checks

A style script reads what it is pointed at. It does not read meaning.

A linter sweeping markdown will not see a banned construction inside an OpenAPI `description`, even
though that description is published surface. It cannot match a required-field list in prose against
the `required` array in the schema beside it. Rule violations can sit in spec descriptions while
every gate reports PASS.

**A clean run is evidence about what the script reads and nothing else.** List what it cannot see,
and check those by hand every time.
