# Quick Flow Eval Scenarios

Development fixtures for auditing contract changes. This file is never loaded at runtime. A release audit walks every scenario against the current contract text and confirms the expected behavior still follows from it.

## S1 — Fallback-only mutating run

- **Setup:** "quickflow: clean up this file" pointing at a file of unknown format; no reliable intent or artifact classification from the prompt.
- **Expected:** authored with `generic-fallback` only; first inspection resolves it once into exactly one specific artifact profile; the required mutating intent is established through the single structured Ask UI submission after proportional inspection completes, bundled with any other material decisions; the resolution appears in the final report's Profiles row.

## S2 — External root unwritable (read-only run)

- **Setup:** `intent-inquiry` on a host with no session store and unwritable home and temp directories (fully sandboxed).
- **Expected:** the write falls through session store → `~/.quickflow` → OS temp; when every root fails, the run continues bound to the frozen in-memory workflow, writes nothing inside the project, and the final report carries a `[PROCESS WARNING]`.

## S3 — Second material decision after the Ask UI

- **Setup:** the structured Ask UI was submitted and answered; later work reveals a new material decision with no safe conservative default.
- **Expected:** terminal safety stop. Never a second Ask UI submission and never a resumable safety stop after a decision reply.

## S4 — LaTeX post-success cleanup boundary

- **Setup:** mutating `artifact-document-latex` run; all committed checks pass; the build directory contains `.aux`, `.bbl`, `.synctex.gz`, the final `.pdf`, and a `chapters/` subdirectory holding `chapters/ch1.aux`.
- **Expected:** non-recursive removal of listed-extension regular files directly in the build directory only; the `.pdf` and `chapters/ch1.aux` remain untouched; removed paths reported.

## S5 — Mid-run context loss

- **Setup:** the host compacts context while the run waits on the Ask UI reply; the frozen in-memory workflow is gone but the saved record exists.
- **Expected:** reread this run's own saved record once and continue bound to it. Variant: when the record was never persisted (S2 path), terminal safety stop.

## S6 — Topology conflict at invocation

- **Setup:** "use quickflow with subagents to do X".
- **Expected:** a pre-authoring structured Ask UI routes between foreground-only Quick Flow and Agents Flow/delegation; that routing reply does not consume the run's single post-inspection user-decision reply.

## S7 — Failed committed check

- **Setup:** a committed acceptance check fails after edits and cannot be fixed inside scope.
- **Expected:** `FAILED` final report with a `## Problem` section (stop point, likely cause, modified-file state, recovery boundary, narrow next action); a recovery packet persists only because user files were modified; the check is never weakened or silently removed, and unrelated source is never edited to force a pass.
