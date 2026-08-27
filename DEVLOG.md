# Development Log - iac-policy-pipeline

Auto-generated journal of project changes.
Generated: 2026-01-05 19:39

## 2026-08-27 18:48

**Commit:** `8cc883e`

feat(policy): make the gate real — HCL-aware rules, paired fixtures, both-direction CI

The pipeline was green while evaluating zero files: examples/ held four
empty directories, so the OPA step had no input, and the single rule was
written against a hand-shaped {resource_type, public, name} document that
nothing in the repo ever produced. It also used v0 rego syntax, which the
OPA 1.x bundled with current conftest refuses to compile.

- Rewrite the S3 rules and add Azure Storage rules in rego v1, reading the
  HCL shape conftest actually emits (input.resource[type][name][i]).
- Add paired compliant/non-compliant fixtures under examples/.
- Add 7 policy unit tests, run by 'conftest verify'.
- CI now asserts both directions: the bad fixtures must be rejected and the
  good ones must pass, so the gate cannot pass by evaluating nothing.
- tfsec and Checkov scan examples/ with soft_fail, since half the fixtures
  are insecure on purpose; the OPA gate decides pass/fail.
- README: replace the Quick Start and policy sample, which described a
  terraform-plan workflow and a package name this repo does not use, and
  split the violation list into what is enforced today versus planned.

Verified locally against conftest 0.69.0, the version CI pins.

**Files:** .github/workflows/security.yml,README.md,examples/aws/public-s3/main.tf,examples/aws/secure-s3/main.tf,examples/azure/public-blob/main.tf,examples/azure/secure-blob/main.tf,policies/opa/no-public-blob.rego,policies/opa/no-public-s3.rego,policies/opa/policies_test.rego

---


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

