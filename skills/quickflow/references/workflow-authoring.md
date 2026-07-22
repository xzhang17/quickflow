# Fresh Workflow Authoring

Use this reference for every explicitly activated Quick Flow request. The foreground runner renders, validates, freezes, and writes one fresh task-specific workflow before target inspection, then continues directly in the same TUI session. It does not generate a launcher or start another agent.

## Authoring Boundary

Authoring is a prompt-structuring pass, not target inspection. Before reading target contents, the foreground runner may use only:

- the current prompt and supplied context;
- explicitly named files, folders, references, screenshots, and artifacts;
- metadata needed to choose a project-local or project-external workflow-record location and a collision-free path;
- the Profile Selection Index in `references/profiles.md`;
- `assets/QUICK_WORKFLOW_CORE.template.md`.

If the in-memory workflow cannot be rendered safely, the runner may load only `references/grilling-intake.md` and `references/templates.md` to issue the required pre-freeze terminal safety stop and blocked final report. This exception does not permit target inspection.

It must not search project code, compile, diagnose, count occurrences, infer APIs or schemas, select edits, or write the implementation checklist. Put facts requiring inspection under **Facts for QUICK to discover**.


## Output Location

Write one fresh workflow record:

1. for mutating, project-backed work with a writable project root, use `.quickflow/QUICK_WORKFLOW.md` when absent, otherwise `.quickflow/QUICK_WORKFLOW_<short-task-slug>.md`;
2. for `intent-inquiry`, `intent-diagnosis`, or a task with no writable project root, use `<external-records-root>/workflows/QUICK_WORKFLOW_<short-task-slug>-<UTC-YYYYMMDDTHHMMSSZ>.md`;
3. add the smallest collision-free numeric suffix when the selected path exists;
4. never overwrite an earlier workflow.

### External records root

Resolve `<external-records-root>` once per run, mechanically and without asking the user:

1. the host's addressable session store when it provides one (for example `local://quickflow` on omp);
2. otherwise `~/.quickflow` in the user's home directory;
3. otherwise `<OS-temp>/quickflow` when the home directory is unavailable or unwritable.

The same resolved root serves workflow records (`<external-records-root>/workflows/`) and recovery packets. Report the resolved location whenever a record or packet is persisted there.

The project-external path is part of the read-only contract: authoring a Quick Flow inquiry or diagnosis must not dirty the target project. Do not create `QUICK_LAUNCHER*.md`. Existing launcher files and old workflows are historical records only. Generated records are inert history: the user may delete them or add `.quickflow/` to the project ignore file freely, and the runner never deletes, prunes, or migrates them.

## Profile Selection

Read the compact Profile Selection Index, verify only selected IDs and cues, and apply these composition rules:

1. exactly one primary intent unless `generic-fallback` is the only profile;
2. secondary intents only for distinct compatible outcomes explicitly requested by the prompt;
3. inquiry and diagnosis are read-only and do not mix with mutating intents;
4. repair already includes diagnosis;
5. editing requires at least one artifact profile or `generic-fallback`;
6. fallback does not coexist with a specific artifact profile;
7. evidence profiles are optional and do not replace intent or artifact profiles;
8. profile IDs are unique.

Annotate the selected-profile list:

```text
- `intent-repair` — primary intent
- `artifact-code`
- `evidence-build-test`
```

Do not copy profile clauses into the workflow. After the record is written and frozen, the saved profile list never changes; the same foreground runner reads only those selected profiles' runtime sections and may perform only the one-time `generic-fallback` resolution described in `references/profiles.md`.

## Template Slots

Render `assets/QUICK_WORKFLOW_CORE.template.md` in memory by replacing every slot exactly once:

| Slot | Required content |
|---|---|
| `@@QUICK_SLOT:TASK_TITLE@@` | Short prompt-grounded task title. |
| `@@QUICK_SLOT:SKILL_VERSION@@` | `Quick Flow skill: 5.4.0`. |
| `@@QUICK_SLOT:SCHEMA_VERSION@@` | `Workflow schema: 6`. |
| `@@QUICK_SLOT:PROFILE_SCHEMA_VERSION@@` | `Profile schema: 4`. |
| `@@QUICK_SLOT:GOAL@@` | Concise observable user outcome. |
| `@@QUICK_SLOT:CONTEXT@@` | User-supplied background and explicit constraints only. |
| `@@QUICK_SLOT:INPUTS@@` | Prompt-named inputs and edit/read-only boundaries. |
| `@@QUICK_SLOT:SELECTED_PROFILE_IDS@@` | Canonical profile IDs with exactly one primary intent annotation. |
| `@@QUICK_SLOT:PROMPT_REQUIREMENTS@@` | Prompt-explicit and necessarily implied non-negotiables; no invented project facts. |
| `@@QUICK_SLOT:QUICK_DISCOVERABLE_FACTS@@` | Facts the foreground runner must establish by inspection. |
| `@@QUICK_SLOT:VALIDATION_EXPECTATIONS@@` | Observable proof requested or implied by the prompt; use “the runner discovers the focused project-native check” when commands are unknown. |
| `@@QUICK_SLOT:STOPPING_DETAILS@@` | Completion boundary and any prompt-explicit safety boundary. |

The skill version is an exact installation-consistency stamp. Workflow and profile schema numbers identify their respective contract formats and change only when those formats change.

Use `- None.` only when a section genuinely has no content. Do not add implementation details, command guesses, occurrence counts, site lists, or project discoveries.

## Mechanical Validation

Before writing, mechanically validate the fully rendered in-memory content:

1. no `@@QUICK_SLOT:` marker remains;
2. metadata declares exactly `Quick Flow skill: 5.4.0`, `Workflow schema: 6`, and `Profile schema: 4`;
3. `Goal`, `Context`, `Inputs`, `Selected Task Profiles`, `Requirements`, `Facts for QUICK to discover`, `Validation`, and `Stopping Condition` each occur once and are nonempty;
4. selected profile IDs are unique, exist in the index, and satisfy the composition rules;
5. exactly one selected profile is annotated `— primary intent` unless fallback-only;
6. prompt facts remain separate from inspection-needed facts;
7. destructive or external effects appear only when the prompt explicitly authorizes the exact target and effect; the non-recursive post-success removal of existing known LaTeX intermediate files (never `.pdf`, sources, figures, or assets) directly inside the resolved LaTeX build directory is profile-derived housekeeping;
8. the workflow contains no invented implementation plan or empirical project evidence.

Use mechanical string checking rather than re-emitting the template from memory. Correct a failed in-memory render before writing.

After the in-memory checks pass, the validated render is frozen as the binding workflow; write it only to the selected new path and do not reread or revalidate the saved record. If a project-local `.quickflow/` write fails, stop before target inspection. If an external-record write fails, fall through the remaining roots in the resolution order; when every root fails, continue the read-only run bound to the frozen in-memory workflow, never write inside the project instead, and disclose a `[PROCESS WARNING]` in the final report.

## Fresh-Only Rule

Never treat an existing workflow as the executable input to a new Quick Flow run. Old workflows may be read by humans as records, but they receive no migration or compatibility path.

If an external instruction supplies an old workflow path, author a new current workflow only after a new explicit Quick Flow invocation.

One exception applies within a single run: when the frozen in-memory contract is lost mid-run (for example after host context compaction), the runner rereads this run's own saved record once and continues bound to it. That is recovery of the same frozen contract, not workflow reuse. If the run has no saved record because external persistence failed, the runner issues a terminal safety stop.

## Foreground Continuation

After the workflow record is written — or its external persistence failure is recorded as a process warning — continue with the foreground runtime in `SKILL.md`: load the frozen selected profile sections, inspect and change the profile set only through the one-time `generic-fallback` resolution in `references/profiles.md`, ask once through the structured Ask UI only if needed, form the checklist, edit only for mutating work, validate proportionally, perform eligible narrow LaTeX cleanup, handle conditional recovery evidence, and report directly. There is no launch command, child agent, background job, relay layer, transport waiter, or second runtime session.
