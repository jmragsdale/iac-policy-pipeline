# Development Log - iac-policy-pipeline

Auto-generated journal of project changes.
Generated: 2026-01-05 19:39

## 2026-08-27 18:33

**Commit:** `0badc86`

ci: replace dead conftest action, gate infracost on its API key

instrumenta/conftest-action has no v0.3 tag (only v0.1.0-v0.4.0) and the
action is unmaintained since 2021, so the runner could not resolve it and
the job died in 'Set up job' before any scanner ran. Install a pinned
conftest 0.69.0 binary instead and run it directly.

infracost/actions/setup needs an API key that this repo has no secret for,
so both infracost steps are now skipped unless INFRACOST_API_KEY is set.

Note: examples/ contains no tracked files, so the OPA step emits a warning
rather than silently passing on an empty target list.

**Files:** .github/workflows/security.yml

---


## 2026-01-23 12:37

**Commit:** 

Auto-update DEVLOG.md

**Files:** DEVLOG.md

---


## 2026-01-23 12:34

**Commit:** 

Update .gitignore and sync CHANGELOG/DEVLOG files

**Files:** .gitignore,CHANGELOG.md,DEVLOG.md

---


## 2025-10-03

**Commit:** `6fbc30f`

Add files via upload

---

## 2025-10-03

**Commit:** `4be37c7`

Add files via upload

---

## 2025-09-30

**Commit:** `32d8e40`

Update README.md

---

## 2025-09-30

**Commit:** `9e05f9e`

Add comprehensive README documentation

- Added detailed project overview and architecture

---

## 2025-09-10

**Commit:** `25d88bf`

feat: scaffold

---

## 2025-09-10

**Commit:** `2ad71b4`

chore: init iac-policy-pipeline

---

