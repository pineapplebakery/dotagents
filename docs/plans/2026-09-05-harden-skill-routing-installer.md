# Work plan: Harden skill routing and installer

- Created: 2026-09-05
- Status: done

## Request

- Address the remaining required findings from the adversarial skill review while leaving gitignored third-party Skill files unchanged. The user later requested a simple Bash installer without staged replacement and asked that excluded Ponytail entries remain commented out with reasons.

## Goal

Keep Ponytail available without weakening the internal Python workflow, and keep latest-version third-party Skill installation simple and explicitly Bash-based.

## Done when

- [x] Tracked routing rules define internal Python workflow precedence and limit Ponytail review/audit routing to overengineering checks.
- [x] `ponytail-gain` and `ponytail-help` remain visibly commented out with reasons instead of being silently removed from tracked configuration.
- [x] External repositories continue to resolve the latest `main` revision, as requested by the user.
- [x] The installer and README consistently require Bash, using the original direct-copy installation model.
- [x] Bash syntax, installer behavior, and diffs are verified without modifying the installed gitignored Skills.

## Design choices

- Keep the base `ponytail` Skill, but subordinate its Python test and workflow guidance to `my-work-plan`, `my-implement`, and `my-test` in `myAGENTS.md`.
- Do not edit third-party `SKILL.md` files because their directories are gitignored and installer-owned.
- Keep `ponytail-debt` because it remains independently useful when `ponytail:` markers exist; comment out `ponytail-gain` and `ponytail-help` with reasons in the tracked installer and routing documentation.
- Keep downloading `main` archives because the user requires the latest upstream version. Accept that installs are not reproducible and rely on the repository's required source review before installation or update.
- Keep the original direct-copy model. Accept the possibility of stale upstream files because staged replacement and rollback are disproportionate for this installer.

## Steps

1. [done] Inspect the current upstream revisions and selected Skill contents.
2. [done] Update tracked routing and installer behavior without editing installed third-party Skills.
3. [done] Verify Bash syntax, replacement behavior, and final diff.
4. [done] Simplify the installer and preserve excluded Ponytail entries as explanatory comments.

## Current

- None; all steps are complete.

## Completed

- Confirmed the existing staged `.gitignore` and installer changes belong to the user and must be preserved.
- Added internal-over-Ponytail precedence to `myAGENTS.md`; focused verification passed.
- Step 1: inspected the current upstream `main` revisions for Ponytail, HumanLayer Skills, and Anthropic community plugins. Their selected Skill directories contain only `SKILL.md` and match the currently installed copies. The user then chose latest-version installation instead of pinning these revisions.
- Steps 2–3: restricted Ponytail review/audit routing and confirmed the Bash conversion and latest-archive installation path. An initial staged-replacement implementation was verified but superseded after the user chose the simpler original copy model.
- Step 4: restored direct copying, removed rollback and retired-Skill deletion, and added reasons beside the commented-out Ponytail entries. `bash -n skill-install.sh` and `git diff --check HEAD` passed. A temporary-directory integration run installed the six active Skills, skipped gain/help, and confirmed that the accepted direct-copy model preserves an existing extra file. The repository's installed gitignored Skill directories were not modified.

## Remaining

- None.

## Next action

- Next: none.
- Notes: do not run the installer against the repository's existing gitignored Skill directories during verification.
