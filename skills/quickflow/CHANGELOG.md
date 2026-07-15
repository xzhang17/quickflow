<!-- Quick Flow changelog -->

# Quick Flow Changelog

- **v5.1.0 (2026-07-15):** froze the authored profile set for each run while allowing one bounded `generic-fallback` resolution into its single specific artifact profile at first inspection before editing (never inferring a primary intent from the target; a sole fallback's required mutating intent is established through the structured Ask UI), added evidence-gated handling for inapplicable profile obligations and terminal stops for insufficient profile coverage, distinguished authorized target corruption from unexpected corruption, replaced the former LaTeX cleanup subsystem with non-recursive removal of existing `.aux`, `.log`, `.out`, and `.toc` files in the resolved build directory, routed Quick Flow versus parallel/delegated requests through the structured Ask UI, and replaced the plain-text routine questionnaire with one structured decision submission. Retained workflow schema `6` and bumped profile schema to `4`.

- **v5.0.6 (2026-07-15):** removed the saved-workflow reread by freezing the mechanically validated in-memory render after a successful write, removed routine phase-status traffic, made semantically equivalent validation obligations collapse into one check and execution, retired the obsolete configured `quick` agent, and shortened the always-loaded skill contract. The canonical automatic LaTeX cleanup contract and eligibility remain unchanged. Retained workflow schema `6` and profile schema `3` because their file formats did not change.

- **v5.0.5 (2026-07-14):** removed post-write content-equality and duplicate metadata/profile verification. The runner now performs the existing mechanical checks once in memory, writes the fresh workflow, reads the saved record once, freezes that persisted content, and continues directly. Retained workflow schema `6` and profile schema `3` because their file formats did not change.

- **v5.0.4 (2026-07-14):** made LaTeX cleanup existence-aware so removal commands run only for generated residuals that still exist after the native clean step, collapsed cleanup verification to one residual check plus protected-root/final-output existence checks, and tightened proportional validation to one focused proof with representative rather than exhaustive rendering by default. Retained workflow schema `6` and profile schema `3` because their file formats did not change.

- **v5.0.3 (2026-07-14):** centralized terminal-stop trigger authority in `references/grilling-intake.md`, aligned recovery-packet triggers so either the user or workflow may request an audit artifact, and added conditional cleanup to the README lifecycle diagram. Retained workflow schema `6` and profile schema `3` because their file formats did not change.

- **v5.0.2 (2026-07-14):** resolved the pre-freeze safety-stop scope conflict, explicitly allowed the two reporting references needed for that stop without permitting target inspection, clarified that collision-safe project-local workflow records remain under `.quickflow/`, and expanded the release consistency check to cover every active skill and schema declaration. Retained workflow schema `6` and profile schema `3` because their file formats did not change.

- **v5.0.1 (2026-07-14):** corrected the foreground contract before further release work. Read-only inquiry and diagnosis now keep workflow records and command outputs outside the project and skip implementation; workflow records were read back and verified before freezing at that release, a step removed in v5.0.5; build-failure evidence is intent-aware; each run waits for at most one user-decision reply; the README lifecycle and global-policy compatibility guidance match runtime behavior; and residual named-agent wording was removed. Retained workflow schema `6` and profile schema `3` because their file formats did not change.

- **v5.0.0 (2026-07-14):** merged workflow authoring and runtime execution into the active foreground TUI agent. Removed child-agent launch, hidden background execution, relay transport, and separate agent-definition dependencies. The same runner now writes and freezes the workflow before inspection, asks the questionnaire directly, implements and validates visibly, performs eligible cleanup, and reports in the active conversation. Added concise phase statuses and reduced installation to the skill directory. Retained workflow schema `6` and profile schema `3` because their file formats did not change.

- **v4.1.1 (2026-07-14):** centralized bounded LaTeX post-success cleanup in `references/latex-cleanup.md`. Cleanup now runs only for eligible mutating work after every committed validation check passes, resolves the real build boundary, removes only identified generated intermediates, protects source and final artifacts, verifies residuals, and reports partial or skipped cleanup accurately. Cleanup remains non-fatal housekeeping unless cleanup itself is the requested deliverable.

- **v4.1.0 (2026-07-14):** introduced profile-specific LaTeX post-success cleanup while preserving final PDFs and `.bbl` files. Cleanup is skipped after failed validation and reported as a warning when incomplete.

- **v4.0.1 (2026-07-14):** clarified the exact skill-version stamp, retained schema-specific format versions, aligned workflow rendering and runtime sanity checks, and standardized final outcomes as `SUCCEEDED`, `FAILED`, or `BLOCKED`.

- **v4.0.0 (2026-07-14):** redesigned Quick Flow around one fresh, compact workflow per invocation. Removed executable snapshot reuse, merged implementation and validation planning into one compact checklist, made validation proportional, reduced routine status traffic, and made recovery evidence conditional. Bumped workflow/profile schemas to `6`/`3`.

- **v3.3.1 (2026-07-14):** made workflow and runtime validation proportional while retaining exact schema, path, profile, and readability checks.

- **v3.3.0 (2026-07-14):** hardened autonomous safety boundaries, including metadata-only authoring, typed safety stops, prompt-authorized destructive effects, secret handling, provenance-preserving validation, bounded document cleanup, and project-external recovery evidence.

- **v3.2.0 (2026-07-13):** introduced the lightweight profile library in `references/profiles.md`, with composable intent, artifact, and evidence profiles under one global composition contract.

- **v3.1.0 (2026-07-13):** moved the bounded questionnaire after project inspection. Replaced sequential questions with one consolidated packet containing at most three evidence-grounded decisions and one direct reply.

- **v3.0.0 (2026-07-13):** standardized explicit Quick Flow invocations around an authored workflow and bounded runtime execution.

- **v2.1.0 (2026-07-13):** consolidated inspection, planning, real-file edits, validation, authorized housekeeping, recovery evidence, and final reporting into one runtime path.

- **v2.0.0 (2026-07-13):** introduced the dedicated Quick Flow runtime topology.

- **v1.2.0 (2026-07-11):** refined fast local execution, profile loading, bounded questions, status handling, and safety behavior.

- **v1.1.0 (2026-07-10):** strengthened task contracts, targeted inspection, browser and visual evidence, terminology, and report consistency.

- **v1.0.0 (2026-07-10):** initial Quick Flow release with profiled workflow authoring, bounded intake, implementation checklists, validation, recovery boundaries, and concise result reporting.
