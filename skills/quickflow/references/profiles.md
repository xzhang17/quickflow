# Lightweight Profiles and Domain Guardrails

Compact rubric library for Quick Flow v5. During pre-inspection authoring, the foreground runner uses only the selection index; after freezing the workflow, the same runner reads only selected profiles' runtime guardrails and validation obligations. Profiles are cumulative constraints, not execution modes, sub-plans, roles, or routing instructions. `QUICK` in retained section headings denotes the foreground runtime role, not a separately configured or spawned agent.
<!-- Profile schema: 4 -->

## Profile Selection Index

During authoring, the runner reads only candidate index rows. During runtime, it reads only the selected profiles' guardrails and validation obligations. It never scans the whole file during a normal run.

| Category | Profile ID | Select when |
|---|---|---|
| Intent | `intent-inquiry` | Explicitly invoked answer-only or read-only question. |
| Intent | `intent-diagnosis` | Root-cause analysis, failure explanation, or rollback advice without edits. |
| Intent | `intent-repair` | Fix a broken, buggy, corrupted, or incorrect artifact. |
| Intent | `intent-feature-implementation` | Add new behavior, files, components, or a coordinated feature. |
| Intent | `intent-refactor` | Restructure internals without observable behavior change. |
| Intent | `intent-optimization` | Improve measurable performance or resource use without behavior change. |
| Intent | `intent-translation` | Translate text while preserving protected structure and meaning. |
| Intent | `intent-formatting` | Apply an explicitly cosmetic formatting or layout rule. |
| Intent | `intent-conversion` | Convert an artifact to another format with fidelity requirements. |
| Artifact | `artifact-code` | Source code, scripts, libraries, applications, or build/test infrastructure. |
| Artifact | `artifact-web-ui` | Browser-rendered UI, frontend components, templates, styles, or interactions. |
| Artifact | `artifact-configuration-data` | Structured configuration or data such as JSON, YAML, TOML, XML, CSV, SQL, or env files. |
| Artifact | `artifact-document-latex` | LaTeX sources, bibliographies, figures, classes, or document builds. |
| Artifact | `artifact-document-generic` | Markdown, plain text, DOCX, RTF, EPUB, or other non-code documents. |
| Artifact | `artifact-generic-files` | Files that do not fit a more specific artifact profile. |
| Evidence | `evidence-build-test` | The request requires compilation, building, testing, or build-failure evidence. |
| Evidence | `evidence-visual-browser-pdf` | The request requires browser, screenshot, rendered-page, PDF, or visual evidence. |
| Evidence | `evidence-source-reference` | A source, specification, original, or reference artifact defines correctness. |
| Fallback | `generic-fallback` | The prompt does not reveal a reliable intent or artifact profile. |

## Global Composition Contract

Profiles are cumulative dimensions, not independent plans:

1. **Exactly one primary intent.** Every non-fallback workflow annotates exactly one primary intent. Secondary intents are allowed only when the prompt explicitly requests distinct compatible outcomes.
2. **Read-only intents are exclusive.** `intent-inquiry` and `intent-diagnosis` cannot coexist with a mutating intent. `intent-repair` already includes diagnosis.
3. **Artifact defines preservation boundaries.** Every editing workflow selects at least one artifact profile or `generic-fallback`.
4. **Fallback is exclusive with specific artifacts.** `generic-fallback` may accompany a known intent when the artifact is unknown, but never coexists with a specific artifact profile.
5. **Evidence defines proof.** Evidence profiles are optional overlays and never replace an intent or artifact profile.
6. **Specific rules override generic rules without weakening them.** Selected obligations otherwise accumulate.
7. **One run, one checklist.** The foreground runner produces one compact action checklist whose items include focused acceptance checks. Profiles never create mini-plans, handoffs, additional agents, or background jobs.
8. **Frozen profile set with one fallback resolution.** Profiles selected during authoring remain in the frozen workflow for the complete run. Never add, remove, replace, or promote profiles after inspection, with one exception: when `generic-fallback` was selected, the first target inspection resolves it once, before any edit, into the single specific artifact profile the target is discovered to be. Artifact type is a discoverable fact; primary intent is a user goal and is never inferred from the target. When `generic-fallback` is the sole selected profile and the work needs a specific mutating intent, establish that intent through one structured Ask UI submission, not by guessing. This one-time resolution loads the resolved profile's obligations, makes no other change to the profile set, and is disclosed in the final report. Before editing, an inapplicable profile-derived obligation may be omitted only with observed evidence and only when the remaining selected profiles safely cover the task; disclose the mismatch in the final report. An inapplicable primary intent, a fallback whose artifact cannot be resolved or whose required intent cannot be established, or insufficient remaining coverage requires a terminal safety stop.
9. **Material conflicts are decisions.** Use the structured Ask UI for bounded alternatives; use a safety stop only when the original goal cannot safely contain the decision.
10. **Equivalent obligations collapse.** Semantically equivalent proof requirements merge into one acceptance check and one execution; profiles do not multiply commands that prove the same outcome.

For editing work, select one primary intent plus an artifact profile or fallback. Add secondary intents only when explicitly requested and compatible. Profile IDs are unique.

## Foreground Runtime Synthesis

After the in-memory workflow is frozen, the foreground runner:

1. reads each frozen selected profile's `Runtime guardrails — QUICK` and `Validation obligations`;
2. performs one proportional target inspection;
3. compares the selected profiles with the observed target, changing the profile set only to perform the one-time `generic-fallback` resolution defined in the composition contract;
4. omits an inapplicable obligation before editing only under the frozen-profile rule above, or issues a terminal safety stop when the primary intent or remaining coverage is insufficient;
5. waits for at most one user-decision reply, using either one structured Ask UI submission or one resumable safety stop;
6. merges applicable obligations into one compact action checklist with focused acceptance checks;
7. executes the checklist, edits only for mutating intents, validates, and reports in the active TUI session without delegation.

# Intent Profiles

## `intent-inquiry`

### Select when
The explicitly activated Quick Flow task asks for an answer or bounded read-only investigation and requests no edits.

### Runtime guardrails — QUICK
- Inspect or research only what is needed to answer reliably.
- Do not modify project files or create project-local workflow, build, test, cache, or diagnostic artifacts.
- Prefer existing evidence. If execution is necessary, direct every output and cache to a project-external temporary location or use a disposable external copy. If the command cannot be isolated, do not run it; report the unavailable evidence and resulting uncertainty.
- Distinguish observed facts from inference and state unresolved uncertainty.

### Validation obligations
- Answer the binding question directly and support it with the required sources or project evidence.

## `intent-diagnosis`

### Select when
The task asks what failed, why it failed, whether to rewind, or what narrow repair is appropriate, without requesting edits.

### Runtime guardrails — QUICK
- Inspect relevant logs, diffs, changed files, dependencies, and consumers in one proportional pass.
- Identify the exact failure point and root cause; do not modify project files or create project-local workflow, build, test, cache, or diagnostic artifacts.
- Prefer existing failure evidence. If reproduction is necessary, direct every output and cache to a project-external temporary location or use a disposable external copy. If the command cannot be isolated, do not run it; report the unavailable evidence and resulting uncertainty.
- Recommend the narrowest repair or rollback. Inspect the first build error, not only the last.

### Validation obligations
- Report the root cause, supporting evidence, uncertainty, and a concrete next action.

## `intent-repair`

### Select when
The task asks to fix a broken, buggy, corrupted, or incorrect artifact.

### Runtime guardrails — QUICK
- Diagnose the failure before editing.
- Corruption explicitly named as the authorized repair target, including OCR damage or malformed source, may be repaired narrowly.
- Fix the minimum needed to restore correct behavior.
- Prefer narrow local edits and sequence any necessary cross-subsystem changes.

### Validation obligations
- Reproduce or establish the original failure when practical, prove it is gone, and run only applicable artifact and evidence checks.

## `intent-feature-implementation`

### Select when
The task asks for new behavior, files, components, or a coordinated feature rather than a repair or refactor.

### Runtime guardrails — QUICK
- Define file-by-file behavior, data flow, interfaces, boundaries, and relevant error/loading/empty states.
- Reuse existing architecture and make each checklist item independently verifiable.
- Include configuration, API, UI, and test changes only when required by the feature.

### Validation obligations
- Verify each requested acceptance criterion end to end with focused checks; run broader regression checks only when the changed interface or project convention requires them.

## `intent-refactor`

### Select when
The task asks to restructure internals without changing observable behavior.

### Runtime guardrails — QUICK
- Identify exact scope and catalog all call sites and usages before editing.
- Preserve observable behavior, public APIs, configuration, and tests unless explicitly authorized otherwise.
- Do not run broad formatters or nonstandard linters unless the prompt or touched surface requires them.

### Validation obligations
- Run affected existing tests, check catalogued call sites, and exercise the modified behavior; do not run unrelated suites.

## `intent-optimization`

### Select when
The task asks to improve performance, memory use, or resource consumption without changing behavior.

### Runtime guardrails — QUICK
- Establish the workload, measurement method, baseline, correctness boundary, and relevant callers before editing.
- Preserve public behavior, APIs, and configuration.
- Avoid changes that cannot be measured against the same workload.

### Validation obligations
- Run correctness tests and report a reproducible before/after benchmark or profile demonstrating the requested improvement.

## `intent-translation`

### Select when
The task asks to translate text in a document, interface, configuration, or code-bearing artifact.

### Runtime guardrails — QUICK
- Establish source/target language, tone, protected content, and a consistent technical glossary.
- Translate in coherent chunks while preserving selected artifact structure.
- Do not translate command names, identifiers, paths, labels, citations, equations, code, URLs, or placeholders unless requested.

### Validation obligations
- Compare source and target structure, protected tokens, recurring terminology, placeholders, and representative segments.

## `intent-formatting`

### Select when
The task requests an explicitly cosmetic formatting, whitespace, style, or layout change.

### Runtime guardrails — QUICK
- Apply only the requested or project-native formatting rule.
- Do not make semantic edits, renames, cleanup, or unrelated reformatting.
- Do not run a broad formatter unless the prompt explicitly requests that scope.

### Validation obligations
- Use one artifact-appropriate diff, parser, renderer, or formatter check to prove only formatting changed. Add a representative render check only when output could change; do not stack exhaustive output comparisons onto an adequate source invariant.

## `intent-conversion`

### Select when
The task asks to convert an artifact from one format to another.

### Runtime guardrails — QUICK
- Define what must survive exactly: order, sections, equations, figures, tables, labels, references, citations, paths, numbering, and metadata as applicable.
- Prefer new output locations and preserve original inputs unless destructive replacement is explicitly authorized.
- Treat OCR artifacts as data corruption and repair them narrowly.

### Validation obligations
- Render or parse the output, inspect representative sections, and compare structure and protected content against the source.

# Artifact Profiles

## `artifact-code`

### Select when
The target includes source code, scripts, libraries, applications, or build/test infrastructure.

### Runtime guardrails — QUICK
- Inspect relevant structure, build system, definitions, references, callers, tests, and style conventions.
- Use LSP and syntax-aware tools where available; preserve APIs, configuration, and unrelated behavior.
- Add a test only when a new observable contract lacks existing coverage or the user requests one.
- Avoid broad formatters, full suites, and nonstandard linters unless the changed surface or prompt requires them.

### Validation obligations
- For mutating work, run focused project-native checks and exercise the modified behavior; add build, type, lint, or broader test commands only when required by the touched area or prompt. For read-only work, gather only the source or runtime evidence needed by the binding question and follow the read-only isolation rules.

## `artifact-web-ui`

### Select when
The target includes browser-rendered UI, frontend components, templates, styles, or interactions.

### Runtime guardrails — QUICK
- Inspect the relevant component tree, tokens, layout system, breakpoints, state management, routing, and shared data contracts.
- Specify applicable states and responsive, keyboard, focus, semantic, and contrast behavior before editing.
- Use the foreground runner's browser directly; do not delegate UI design or browser QA.

### Validation obligations
- Exercise affected behavior in the real browser at representative viewports and check only applicable console, accessibility, and visual states.

## `artifact-configuration-data`

### Select when
The target is structured configuration or data such as JSON, YAML, TOML, INI, XML, env files, CSV, or SQL schema.

### Runtime guardrails — QUICK
- Inspect the explicit or implicit schema, consumers, defaults, and project-native validation.
- Preserve comments and formatting where practical; avoid unrelated normalization.
- Pin shared field names, types, defaults, and error/loading shapes when code or UI consumes the data.
- Never print secret values in statuses, reports, validation commands, or tool summaries; validate structure without exposing contents.
- Distinguish live secret files from templates such as `.env.example`; do not copy live values into examples, tests, logs, or generated artifacts.
- Preserve permissions on secret-bearing files and do not rotate, replace, or publish credentials unless the workflow explicitly authorizes the exact effect.

### Validation obligations
- For mutating work, parse the changed data, run project-native schema checks, and verify affected consumers. For read-only work, parse only the relevant existing data without exposing secrets or creating project-local artifacts.

## `artifact-document-latex`

### Select when
The target includes LaTeX sources, bibliographies, figures, classes, or document builds.

### Runtime guardrails — QUICK
- Inspect the root and build inputs needed to understand the changed source; inspect only task-relevant includes, bibliography, logs, and rendered pages.
- Preserve mathematical meaning, labels, cross-references, citations, filenames, paths, and document order.
- Do not add language, font, or CJK packages unless required by the task.
- Keep braces required around `\mathop`-style operators used as `_`/`^` content and where control-word tokenization requires them.
- Treat OCR corruption narrowly and do not trust compilation alone.
- Discover and use the project-native LaTeX build pipeline. Prefer `latexmk` only when the project already uses it or no project-specific build contract exists.
- After every committed check passes for mutating work, resolve the exact LaTeX build directory, enumerate existing regular files directly in that directory whose names match `*.aux`, `*.log`, `*.out`, or `*.toc`, and remove only those paths non-recursively with `rm -f -- <existing paths>`. Report removed paths or that no matches existed. Never run this cleanup for `intent-inquiry` or `intent-diagnosis`, recurse, remove matching directories, search unrelated directories, or remove any other extension.
- Under `intent-inquiry` or `intent-diagnosis`, prefer existing logs and rendered output. If a fresh compile is necessary, run it with all outputs and caches in a project-external temporary location or from a disposable external copy; if complete isolation is unavailable, do not compile and report the evidence limitation.

### Validation obligations
- For task-relevant source changes, run one project-native build invocation to convergence, inspect directly affected pages or normally one to three representative pages for broad source-only changes, and check the final relevant undefined-reference, warning, or overfull diagnostics once. Inspect every page only when the prompt requires exhaustive visual fidelity or focused evidence cannot prove the result.

## `artifact-document-generic`

### Select when
The target is a non-LaTeX prose document such as Markdown, plain text, DOCX, RTF, or EPUB.

### Runtime guardrails — QUICK
- Inspect the document format, structure, metadata, links, assets, tables, notes, citations, tracked annotations, and rendering pipeline as applicable.
- Prefer minimal auditable changes and do not combine global prose and structural rewrites unless authorized.

### Validation obligations
- Parse or render when supported and inspect representative sections plus all applicable protected structure, links, metadata, citations, numbering, notes, and tracked annotations.

## `artifact-generic-files`

### Select when
The target is known but does not fit a more specific artifact profile.

### Runtime guardrails — QUICK
- Identify the format and inspect read-only before modifying it.
- Prefer non-destructive operations and preserve originals when confidence is limited.
- Stop rather than guessing when the format cannot be edited safely.

### Validation obligations
- Use format-appropriate parsing, byte comparison, rendering, or manual inspection and report uncertainty.

# Evidence Profiles

## `evidence-build-test`

### Select when
The request requires compilation, building, testing, or build-failure evidence.

### Runtime guardrails — QUICK
- Discover and use the narrow project-native build or test command that proves the requested result.
- Under `intent-inquiry` or `intent-diagnosis`, prefer existing build/test evidence. If execution is necessary, direct all outputs and caches to a project-external temporary location or use a disposable external copy. If complete isolation is unavailable, do not run the command; report the unavailable evidence and uncertainty.
- Keep verification proportional and inspect the first relevant error on failure.

### Validation obligations
- For `intent-inquiry` or `intent-diagnosis`, the focused command or existing output must establish the requested evidence; an expected nonzero result is valid when it reproduces the failure being investigated.
- For a mutating intent, applicable focused tests or builds pass after implementation unless the acceptance criterion explicitly requires a negative result.
- Broader commands and warning sweeps run only when the prompt or touched surface requires them.

## `evidence-visual-browser-pdf`

### Select when
The request supplies or requires screenshots, rendered PDF pages, browser QA, or visual-fidelity evidence.

### Runtime guardrails — QUICK
- Inspect supplied or rendered images/pages directly; use text extraction only as navigation evidence.
- For browser work, operate the real page and inspect the console.
- Compare the visual failure with source structure and search for similar source patterns before inferring a general rule.

### Validation obligations
- Compare the smallest representative set of pages, screenshots, states, and viewports that proves the expected result and report any observed regression. Exhaustive visual comparison is required only when the prompt explicitly requires exhaustive fidelity or focused evidence cannot prove the result.

## `evidence-source-reference`

### Select when
A specification, original document, screenshot, source passage, URL, or reference file defines correctness.

### Runtime guardrails — QUICK
- Establish which source is authoritative and how structural, semantic, behavioral, or visual equivalence will be judged.
- Do not silently resolve a material discrepancy unsupported by the reference.

### Validation obligations
- Compare the output against the reference and report all material discrepancies.

# Fallback Profile

## `generic-fallback`

### Select when
The prompt does not support a reliable intent or artifact classification.

### Runtime guardrails — QUICK
- At first inspection, before any edit, resolve `generic-fallback` once into the single specific artifact profile the target is discovered to be, then load and follow that profile's obligations and disclose the resolution in the final report.
- Never infer the primary intent from the target. When `generic-fallback` is the sole selected profile and the work needs a specific mutating intent, establish that intent through one structured Ask UI submission.
- Make no other change to the profile set; this one-time resolution never becomes open-ended adding, removing, replacing, or promoting profiles.
- Prefer read-only discovery, minimal changes, and new outputs until the format and scope are clear.
- Continue under the generic obligations when they safely cover the target. Issue a terminal safety stop only when a single artifact profile cannot be identified, a required mutating intent cannot be established, or the generic obligations do not safely cover the target.

### Validation obligations
- Verify the result conservatively under the generic obligations and report ambiguity.
