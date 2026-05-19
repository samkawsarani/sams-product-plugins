# Developer Docs Quality Checklist

This is a **hard gate** — fix all failures before presenting output to the user.

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
- [ ] IDs use prefixed format where applicable (`pay_`, `txn_`, `mer_`)
- [ ] Code samples follow language-specific conventions
- [ ] Tables properly formatted with consistent columns
- [ ] Headers follow logical hierarchy (H1 → H2 → H3)

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
