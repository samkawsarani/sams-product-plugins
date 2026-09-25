# Developer Docs Quality Checklist

This is a **hard gate** — fix all failures before presenting output to the user.

If the target repo carries its own style guide, it wins on every point of conflict and this
checklist is the fallback.

## Fact discipline
- [ ] Every field name, type, and required list read out of the schema for this edit, not from
      memory and not from another page
- [ ] Nothing asserted that is not in the spec or the error catalog (key issuance, dashboard
      behavior, onboarding, support, rate limits are the usual invented ones)
- [ ] Contract gaps written down as asks, with which side you believe is right. No other repo edited
- [ ] No rule stated twice. It lives on the page that owns it, linked from everywhere else
- [ ] No page that only indexes what other pages contain

## Prose
See `writing-standards.md` for each of these.
- [ ] No absence stated. Every "there is no X" passes the competent-reader test or is cut
- [ ] No design rationale or threat model explained to the reader
- [ ] Opening paragraph carries a fact the title does not. Delete it and check what is lost
- [ ] No banned construction. Read it aloud; most announce themselves
- [ ] Unsettled things carry a callout, and the callout severity matches the fact

## Completeness
- [ ] All template sections filled with real content (no placeholders, no `[TODO]`, no `...`)
- [ ] Every endpoint has request examples in all specified languages
- [ ] Every parameter documented with type, constraints, and description
- [ ] Every error code has a resolution (not just a description)

## Authentication
- [ ] Auth section appears before any endpoint documentation
- [ ] Examples use test/sandbox credentials (never real keys)
- [ ] Auth method explicitly stated (Bearer token, API key, OAuth)
- [ ] Key format and placement documented (header, query param, body)

## Developer Experience
- [ ] Code samples are copy-paste ready (complete, runnable)
- [ ] Expected responses shown for every request example
- [ ] Error scenarios include resolution steps
- [ ] Rate limits documented where applicable
- [ ] Pagination pattern documented for list endpoints

## Correctness
- [ ] HTTP methods match the operation (GET/POST/PUT/DELETE)
- [ ] Status codes correct (201 create, 200 retrieve, 204 delete)
- [ ] Request/response JSON is valid and consistent
- [ ] Parameter types match between documentation and examples
- [ ] Endpoint paths consistent throughout

## Format
- [ ] Resource names use snake_case
- [ ] ID format in examples matches what the API actually returns. Never describe an id by what it lacks ("not a sequential number") — describe the format it has
- [ ] Code samples follow language-specific conventions
- [ ] Tables properly formatted with consistent columns
- [ ] Headers follow logical hierarchy (H1 → H2 → H3)

## Renames and links
- [ ] Grepped for the old slug before renaming any heading. Rewording a heading breaks every anchor
      pointing at it, silently
- [ ] A changed page slug has a redirect configured

## Automated checks
- [ ] Ran the repo's check script, if it has one
- [ ] Listed what that script cannot see, and checked each by hand. A linter that sweeps markdown
      does not read OpenAPI `description` fields as prose, and cannot match a required-field list
      against the schema beside it

## Guide-Specific
- [ ] Opens with outcome statement ("By the end of this guide...")
- [ ] Prerequisites list exact versions and install commands
- [ ] Each step has expected output
- [ ] Callout boxes used for warnings and tips
- [ ] Next steps section links to related docs

## Postman-Specific
- [ ] Collection uses Postman v2.1 schema
- [ ] Auth set at collection level with `{{secret_key}}`
- [ ] Test scripts on every request (minimum 3 assertions)
- [ ] Variable chaining works across requests in sequence
- [ ] Environment variables separated from collection variables
- [ ] JSON is valid and importable
