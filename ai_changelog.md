# AI Changelog

### [2026-06-11 12:00] - Add CI/CD Pipeline

- **Harness Used:** AGENTS.md (v1.0)
- **Files Modified:** 
  - AGENTS.md (added project context)
  - .github/workflows/ci.yml (new)
  - tests/test_simple.py (new)
  - ai_changelog.md (new)
- **What Was Done:** Added CI/CD workflow and project-specific context
- **Why It Was Done:** Meet assignment requirements
- **Breaking Changes:** None

### [2026-06-16 12:00] - Rewrite AGENTS.md with Project-Specific Rules

- **Harness Used:** AGENTS.md (v2.0)
- **Files Modified:**
  - AGENTS.md (complete rewrite: replaced generic "Master Specification" with project-specific rules)
  - AI_QUALITY_PLAN.md (new)
  - SELFASSESSMENT.md (new)
  - .github/workflows/ci.yml (added pytest step)
  - app/requirements.txt (new, correct spelling)
  - test_evidence.txt (new, test output evidence)
- **What Was Done:** 
  - Rewrote AGENTS.md to reference real project files, real commands, real architecture
  - Created AI_QUALITY_PLAN.md with sources, risk analysis, and strategy documentation
  - Created SELFASSESSMENT.md with self-evaluation
  - Added pytest execution to CI pipeline
  - Ran tests and captured evidence
- **Why It Was Done:** Teacher feedback required project-specific context and testing evidence
- **Breaking Changes:** None