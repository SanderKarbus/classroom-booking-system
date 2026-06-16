# PROJECT CONTEXT

**Project Name:** Classroom Booking System
**Type:** Python CLI Application
**Stack:** Python 3.x + PostgreSQL + psycopg2-binary
**Purpose:** Simple CLI-based classroom booking management

**Critical Files & Directories:**

| Path | Purpose |
|------|---------|
| `app/main.py` | Main application - CLI menu, CRUD functions |
| `app/db.py` | Database connection (psycopg2) |
| `schema.sql` | Full DB schema: tables, constraints, views |
| `crud.sql` | Example CRUD queries for reference |
| `tests/test_simple.py` | Test file (pytest) |
| `.github/workflows/ci.yml` | CI pipeline |
| `requirements.txt` | Dependencies (psycopg2-binary) |

**Database Schema (`schema.sql`):**
- `lesson_type` - lesson categories (id, name)
- `classroom` - classrooms (id, name, capacity, has_computers)
- `user_or_group` - teachers or student groups (id, name, type)
- `booking` - core booking table with FK references and CHECK constraints
- `booking_participants` - junction table for N:M booking participants
- `classroom_usage_hours` - materialized usage statistics view

**Application Flow:**
- `app/db.py` opens a connection using hardcoded credentials (needs env var migration)
- `app/main.py` runs a CLI menu loop: list/add/update/delete bookings + statistics
- Input is via `input()`, SQL via parameterized queries (safe from injection)

---

# 1. DEVELOPMENT COMMANDS

```bash
python app/main.py                 # Run the CLI application
pytest tests/ -v                   # Run test suite
python -m py_compile app/main.py   # Syntax check main
python -m py_compile app/db.py     # Syntax check db module
pip install -r app/requirements.txt  # Install dependencies
psql -d classroom_booking -f schema.sql  # Run migrations
```

All commands must be run from the project root directory.

---

# 2. CODE STYLE & CONVENTIONS

Follow the existing patterns in this codebase exactly.

**Functions & structure:**
- Each CRUD operation is a separate function in `app/main.py` (e.g., `list_bookings`, `add_booking`)
- DB functions use `psycopg2` with parameterized queries (`%s` placeholders)
- The main loop is a `while True` with `if/elif` menu dispatch

**Database access:**
- Use `get_connection()` from `app/db.py` - do not create raw connections elsewhere
- Always close connections with `conn.close()` after use
- Always call `conn.commit()` after INSERT/UPDATE/DELETE

**Naming:**
- Functions: `snake_case`
- SQL keywords: UPPERCASE
- Variables: `snake_case`

**What NOT to do:**
- Do not change the existing menu structure or function signatures
- Do not add OOP patterns (classes, ORMs) unless explicitly requested
- Do not refactor `get_connection()` without approval

---

# 3. ARCHITECTURE & DESIGN

This project uses a flat, procedural architecture:

```
app/main.py  →  CLI menu + CRUD logic
app/db.py    →  psycopg2 connection wrapper
schema.sql   →  PostgreSQL schema definition
tests/       →  pytest test files
```

**Key decisions to preserve:**
- Connection details are in one place (`app/db.py`)
- Business logic and DB access are in the same module (no layered architecture)
- No ORM - raw SQL with parameterized queries
- No web framework - pure CLI

**Forbidden patterns** (will break project consistency):
- Introducing CQRS, repository pattern, or service layers
- Adding async/await
- Migrating to an ORM
- Splitting into microservices

Extend existing architecture before redesigning it.

---

# 4. TESTING RULES

Tests live in `tests/test_simple.py` and use pytest.

**Test expectations:**
- New functionality must include tests (happy path + failure path + edge cases)
- Tests must be runnable with: `pytest tests/ -v`
- Use `assert` statements (no unittest.TestCase)

**Regression protection:**
- Bug fixes MUST include a regression test that reproduces the original issue
- A bug is not fixed until: test fails before fix → test passes after fix
- Do not remove or weaken existing tests

**Testing the DB layer:**
- For tests that need a database, use a test database or mock `get_connection()`
- Do not hardcode production DB credentials in tests

---

# 5. GIT WORKFLOW & MAIN BRANCH PROTECTION

Never commit directly to `main` or `master`.

**Workflow:**
1. Create a feature branch: `git checkout -b feat/description`
2. Make focused, atomic commits
3. Ensure all quality gates pass before pushing
4. Open a pull request for review
5. Do not merge until CI is green

**PR requirements:**
- Keep PRs small and focused (one logical change per PR)
- Summarize every changed file in the PR description
- Ensure PR title follows conventional commits pattern

**Quality gates (all must pass before marking complete):**
- [ ] `pytest tests/ -v` passes
- [ ] `python -m py_compile app/main.py app/db.py` succeeds
- [ ] Only relevant files modified
- [ ] No secrets added
- [ ] ai_changelog.md updated if applicable

---

# 6. SCOPE CONTROL

Modify only files directly related to the requested task.

**Do NOT:**
- Refactor unrelated code or functions
- Rename functions, database columns, or tables without explicit request
- Change `schema.sql` unless the task explicitly requires schema changes
- Change `app/db.py` connection logic without approval
- Reformat or restructure files that are not part of the task

**Threshold:**
- If a change requires touching more than 5 files, explain why before proceeding
- Large-scale refactors require explicit user approval

---

# 7. SECURITY RULES

- Never commit secrets, passwords, API keys, or tokens
- `app/db.py` currently has hardcoded credentials (`admin`/`admin`) - do not duplicate this pattern
- If adding new database access code, always use parameterized queries (`%s` style)
- Do not log SQL queries that contain user data
- Do not disable authentication or authorization for testing
- Prefer environment variables over hardcoded configuration for any new connection code

---

# 8. DEPENDENCY RULES

Current dependencies (in `app/requirements.txt`):
- `psycopg2-binary`

**Rules:**
- Do not add new production dependencies without explaining why they are necessary
- Check whether the standard library or existing dependency already solves the problem
- New dependencies must provide clear, measurable value
- Development-only dependencies (pytest) are acceptable if explained

---

# 9. ERROR HANDLING

- Every DB operation must handle connection failures gracefully
- Do not use bare `except:` blocks - always catch specific exceptions
- Print user-friendly error messages, not raw Python tracebacks (in production code)
- In tests, showing tracebacks is acceptable

---

# 10. COMPLETION CHECKLIST

Before marking any task as complete:

- [ ] Requirements reviewed and understood
- [ ] Only directly relevant files modified
- [ ] Existing functionality preserved
- [ ] `pytest tests/ -v` passes
- [ ] `python -m py_compile app/main.py app/db.py` succeeds
- [ ] No secrets or credentials introduced
- [ ] No unrelated refactoring performed
- [ ] Changes summarized (which files, what changed, why)
- [ ] `ai_changelog.md` updated with the change entry
- [ ] If a bug was fixed: regression test added and verified

---

# 11. WHEN UNSURE

Ask for clarification before:

- Changing `schema.sql` or any database schema
- Changing `app/db.py` connection logic or adding new DB modules
- Adding new production dependencies
- Deleting any file
- Changing the CLI menu flow or function signatures in `app/main.py`
- Introducing a new architectural pattern

If a requirement is ambiguous, propose a short plan before editing code.

If tests fail and the cause is unclear, report the failure instead of guessing a fix.

---

# 12. AI CHANGELOG PROTOCOL

File: `ai_changelog.md` (project root)

- Append new entries for every feature, bug fix, or refactor
- Never rewrite or remove existing entries
- Format:

### [YYYY-MM-DD HH:MM] - Change Title

- Files Modified: list
- What Was Done: short description
- Why It Was Done: reason
- Breaking Changes: yes/no
