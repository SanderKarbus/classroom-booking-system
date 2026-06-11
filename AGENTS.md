# PROJECT CONTEXT
**Project Name:** Classroom Booking System  
**Type:** Python CLI Application  
**Stack:** Python 3.x + PostgreSQL + psycopg2-binary  
**Purpose:** Classroom booking management system

**Development Commands:**
- `python app/main.py` - Run application
- `pytest tests/` - Run tests
- `psql -d classroom_booking -f schema.sql` - Run migrations

**Database:**
- PostgreSQL database: classroom_booking
- Schema: schema.sql
- Connection: app/db.py

**Architecture:**
- CLI-based Python application
- Database layer: app/db.py
- Main logic: app/main.py
- CRUD: app/crud.sql

---

# MASTER SPECIFICATION & QUALITY HARNESS

## Universal AI Engineering Ruleset

This specification defines mandatory engineering, architectural, quality, security, and workflow rules for AI coding agents operating within a repository.

Goals:

- Architectural consistency
- Production-safe code generation
- Reduced hallucination and refactoring drift
- Long-term maintainability
- Predictable and auditable changes
- High code quality with minimal regressions

When project-specific conventions exist, prioritize consistency with the existing codebase unless explicitly instructed otherwise.

---

# 1. PROJECT DISCOVERY & CONTEXT ANALYSIS

Before generating, modifying, or refactoring code:

1. Inspect repository structure.
2. Identify frameworks, languages, tooling, and architecture.
3. Read relevant modules before making changes.
4. Understand existing implementation patterns.
5. Prefer extending existing solutions over introducing new ones.

## Repository Analysis

Inspect relevant files such as:

- package.json
- pnpm-workspace.yaml
- turbo.json
- requirements.txt
- pyproject.toml
- go.mod
- Cargo.toml
- pom.xml
- build.gradle
- docker-compose.yml
- schema.prisma
- migration directories

Determine:

- application type
- architectural style
- framework stack
- database technology
- testing framework
- build tooling

## Existing Pattern Priority

Always prioritize:

- existing architecture
- existing folder structure
- existing naming conventions
- existing dependency choices
- existing coding style

Consistency is more important than theoretical perfection.

---

# 2. DEVELOPMENT COMMANDS

Before executing commands, inspect the repository and identify the correct tooling.

Examples:

- npm test
- pnpm test
- yarn test
- pytest
- go test
- cargo test

Never assume commands.

Use the commands already defined by the repository.

Before marking work complete, run all applicable:

- tests
- linting
- formatting checks
- type checks
- build validation

---

# 3. CODE GENERATION RULES

## Context First

Read relevant:

- schemas
- interfaces
- types
- services
- configs
- related modules

before writing code.

Do not generate isolated assumptions.

## Zero Guesswork

If uncertainty affects:

- business logic
- security
- infrastructure
- database structure
- API contracts
- architectural direction

ask for clarification before proceeding.

## Deterministic Output

Generated code must be:

- complete
- executable
- production-safe
- internally consistent

Forbidden:

- TODO placeholders
- pseudocode
- incomplete implementations
- fabricated integrations
- fake production logic

## Minimal Change Strategy

Prefer:

- minimal diffs
- isolated fixes
- targeted changes

Avoid:

- opportunistic rewrites
- unrelated refactoring
- unnecessary renaming
- architectural reshuffling

Preserve existing behavior unless explicitly instructed otherwise.

---

# 4. ARCHITECTURE & DESIGN

## Prefer Boring Solutions

Favor:

- simple
- explicit
- predictable
- maintainable

solutions over clever abstractions.

Readability and maintainability are more important than novelty.

## Abstraction Rules

Avoid Hasty Abstractions.

Only abstract when:

- logic repeats multiple times
- duplication creates maintenance burden
- abstraction improves clarity

If abstraction reduces readability, prefer explicit code.

## Separation of Concerns

Keep separate:

- business logic
- database access
- external integrations
- side effects
- presentation logic

Do not mix unrelated responsibilities.

## Architectural Boundaries

Do not introduce:

- CQRS
- repository patterns
- event systems
- service layers
- caching layers
- plugin systems
- microservice splits

unless:

- already present
- explicitly requested

Extend existing architecture before redesigning it.

---

# 5. TYPE SAFETY & VALIDATION

Prefer strong typing whenever possible.

Avoid:

- any
- weakly typed objects
- implicit contracts

Define:

- input types
- output types
- failure behavior

for public APIs and services.

Validate all external input:

- request payloads
- query parameters
- forms
- webhooks
- environment variables

Prefer schema validation libraries when available.

Handle:

- null
- undefined
- optional values

explicitly and safely.

---

# 6. ERROR HANDLING & OBSERVABILITY

## Failure Handling

Empty catch or exception blocks are forbidden.

Failures must:

- log useful context
- fail safely
- preserve system integrity

## Logging

Prefer structured logs containing:

- request context
- operation context
- correlation identifiers

Never log:

- passwords
- tokens
- secrets
- credentials
- sensitive personal data

---

# 7. SECURITY RULES

Never:

- hardcode secrets
- hardcode credentials
- disable authentication checks
- disable authorization checks

Use:

- environment variables
- parameterized queries
- ORM protections
- input validation

Apply least-privilege principles whenever possible.

---

# 8. DEPENDENCY MANAGEMENT

Before adding a dependency:

1. Check whether the functionality already exists.
2. Check whether the standard library is sufficient.
3. Check whether a project dependency already solves the problem.

Do not add dependencies without clear justification.

Avoid dependency sprawl.

New dependencies must provide measurable value.

---

# 9. TESTING RULES

## Test Expectations

New functionality should include:

- happy path tests
- failure path tests
- edge case tests

where practical.

## Regression Protection

Bug fixes must include a regression test whenever technically possible.

A bug is not considered fixed until:

1. The test reproduces the original issue.
2. The test fails before the fix.
3. The test passes after the fix.

## Existing Tests

Do not remove or weaken tests without clear justification.

Preserve test coverage whenever possible.

---

# 10. GIT WORKFLOW

Never commit directly to:

- main
- master

Use a dedicated feature branch for all work.

Keep pull requests:

- small
- focused
- reviewable

Prefer one logical change per commit.

Use descriptive commit messages.

Examples:

- feat(auth): add MFA validation
- fix(api): prevent null session crash
- refactor(user): simplify token parsing

---

# 11. QUALITY GATES

Work is not complete until all applicable checks pass.

Required checks:

- tests
- linting
- formatting validation
- type checking
- build validation

Do not claim success while known failures remain unresolved.

CI pipelines should enforce these checks whenever possible.

Branch protection should be used whenever available.

---

# 12. SCOPE CONTROL

Modify only files directly related to the requested task.

Do not:

- refactor unrelated code
- reorganize project structure unnecessarily
- rename public interfaces without reason
- modify unrelated functionality

If a change requires modifications across more than five files, explain why before proceeding.

Large-scale refactors require approval.

---

# 13. APPROVAL REQUIRED CHANGES

Request approval before:

- database schema changes
- migration changes
- dependency additions
- authentication changes
- authorization changes
- public API changes
- deployment changes
- infrastructure changes
- deleting files
- large-scale refactors
- introducing new architectural patterns

When uncertain, ask first.

---

# 14. AI CHANGELOG PROTOCOL

Maintain `ai_changelog.md`.

Create it if missing.

Append entries for:

- features
- bug fixes
- refactors
- architectural changes

Use append-only history.

Never rewrite or remove existing entries.

Recommended format:

### [YYYY-MM-DD HH:MM] - Change Title

- Harness Used:
- Files Modified:
- What Was Done:
- Why It Was Done:
- Breaking Changes:

---

# 15. LANGUAGE RULES

Use English for:

- code
- comments
- documentation
- commit messages
- branch names

Use the language requested by the user for communication.

---

# 16. AI MAINTAINABILITY

Generated code must remain understandable for:

- future developers
- future AI agents
- partial-context editing sessions

Avoid:

- hidden execution flow
- excessive indirection
- deep abstraction chains
- unnecessary complexity

Prefer explicit behavior and readable control flow.

---

# 17. COMPLETION CHECKLIST

Before marking work complete:

- [ ] Requirements reviewed
- [ ] Only relevant files modified
- [ ] Existing functionality preserved
- [ ] Tests pass
- [ ] Linting passes
- [ ] Type checks pass
- [ ] Build succeeds
- [ ] Regression tests added when applicable
- [ ] No secrets introduced
- [ ] Changelog updated when required
- [ ] Changes summarized for the user
- [ ] No unrelated modifications remain
