# Quick Flow Safety Boundaries

Load this reference for destructive actions, external effects, secrets, unexpected corruption, failed validation after edits, or safety-stop decisions. Passive rules should not create routine checkpoints.

## Destructive Git and rollback

Quick Flow creates no backup or checkpoint. The user manages restore points.

`git reset --hard`, `git checkout -- <file>`, `git clean -fd`, and `git stash drop` are forbidden without explicit user approval in the current conversation. Never discard user changes to repair the foreground runner's own work.

`git restore <file>` may discard uncommitted work and therefore also requires approval of the exact path and command.

Corruption explicitly named as the authorized repair target may be diagnosed and repaired narrowly. Stop and report when corruption is unexpected outside that target, suggests user-data loss, has uncertain provenance, or would require destructive rollback; do not attempt destructive self-repair.

## Irreversible and external effects

An irreversible filesystem, database, deployment, publication, credential, permission, or remote-service action requires workflow authorization naming the exact target and effect. The foreground runner must establish the affected environment, recovery boundary, and validation method before acting. The non-recursive post-success removal of existing known LaTeX intermediate files — never `.pdf`, sources, figures, or assets — directly inside the resolved LaTeX build directory is profile-derived housekeeping rather than an irreversible action.

A general request to “fix,” “test,” or “validate” never authorizes production deployment, migration, publication, credential rotation, external messaging, permission changes, or destructive deletion. Missing authorization is a terminal safety stop.

Inspection and validation must not themselves mutate production or external state unless the workflow explicitly authorizes that exact effect.

## Secrets

Never expose secret values or copy live credentials into examples, tests, commands, statuses, reports, recovery packets, or generated artifacts. Validate secret-bearing files without printing their values. Do not rotate, replace, publish, or normalize credentials without exact authorization.

## Scope and semantic integrity

The foreground runner must:

1. inspect before editing;
2. fix the requested problem at its source;
3. touch only files required by the original goal and compact checklist;
4. preserve public APIs, identifiers, labels, references, paths, mathematical meaning, legal meaning, and document structure unless explicitly authorized otherwise;
5. avoid unrelated cleanup, formatting, warning suppression, dependency changes, and opportunistic fixes;
6. trust observed behavioral, rendered, test, log, and source evidence over a success narrative;
7. report failed committed checks rather than weakening them or editing unrelated source to make them pass.

## Bounded continuation

A newly discovered target or delta inspection may remain inside the current run when it is clearly implied by the original goal, introduces no new destructive or external effect, preserves protected scope, and needs no new authorization. The runner updates its checklist and discloses the adjustment.

The frozen profile set never changes after inspection, except the one-time `generic-fallback` resolution into its single specific artifact profile at first inspection before editing; a primary intent is never inferred from the target, and a sole fallback that needs a specific mutating intent establishes it through one structured Ask UI submission. Before editing, the runner may omit an inapplicable profile-derived obligation only with observed evidence and only when the remaining selected profiles safely cover the target. It must disclose the resolution and any mismatch in the final report. An inapplicable primary intent, a fallback whose artifact or required intent cannot be established, or insufficient remaining coverage is a terminal safety stop.

Use a resumable safety stop only for one already-bounded choice. Use a terminal safety stop only for a trigger defined in `references/grilling-intake.md`; that reference is the canonical terminal-trigger list.

## Validation and tests

Validation is proportional to the changed behavior. Use the narrowest project-native evidence that proves each committed acceptance check, and do not duplicate an adequate proof with broader checks.

- A reported defect should be reproduced when practical and confirmed gone.
- UI changes require exercising affected behavior in the browser.
- Task-relevant LaTeX source changes require one project-native build invocation to convergence, a directly affected page or normally one to three representative pages, and one final relevant diagnostic check.
- Full-corpus page, image, viewport, or hash comparisons require an explicit exhaustive-fidelity goal or evidence that focused validation cannot prove the result.
- Add a test only when a new observable contract lacks existing coverage or the user requests one.
- Broad suites, builds, formatters, linters, and unrelated checks are not default requirements.

Before editing, the runner may omit an inapplicable profile-derived check only with observed evidence and only when the remaining frozen profiles still cover the task safely. After editing begins, it may add checks but may not silently remove or weaken a committed acceptance check.

## Post-success cleanup

Automatic cleanup exists only after all committed checks pass for mutating `artifact-document-latex` work. Resolve the exact LaTeX build directory and remove only the existing regular files directly in that directory whose extension is a known LaTeX intermediate — `.aux`, `.bbl`, `.bcf`, `.blg`, `.brf`, `.fdb_latexmk`, `.fls`, `.glg`, `.glo`, `.gls`, `.idx`, `.ilg`, `.ind`, `.ist`, `.lof`, `.log`, `.lot`, `.nav`, `.out`, `.run.xml`, `.snm`, `.synctex.gz`, `.toc`, `.vrb`, `.xdy` — non-recursively with `rm -f -- <existing paths>`. Never remove `.pdf`, source, figure, or asset files. Report the removed paths or that no matches existed. Never run this cleanup for `intent-inquiry` or `intent-diagnosis`, recurse, remove matching directories, search unrelated directories, or remove an extension outside this list. A cleanup failure is a non-fatal process warning.

## Conditional recovery evidence

A recovery packet is required only when:

1. the user or workflow requests one;
2. an irreversible or external effect occurred or was attempted, excluding the bounded LaTeX intermediate cleanup;
3. the run ends failed or terminally blocked after modifying user files.

Otherwise report concise evidence inline and create no packet. A required packet must state changed files, failed checks, modified-file state, external effects, recovery boundary, and narrow next action without private reasoning, secrets, source dumps, or unnecessary raw output.

## Success criteria

A run succeeds only when:

1. the fresh workflow sanity check and selected-profile load pass;
2. the foreground runner follows its compact action checklist;
3. unrelated files remain untouched;
4. every committed acceptance check passes;
5. the user-visible issue is fixed or requested output is produced;
6. any conditionally required recovery packet persists, or a visible process warning supplies equivalent inline recovery evidence.

Routine phase statuses are not required. Audit persistence is not a success criterion when the conditions above do not require it.
