---
name: quickflow
version: 5.1.0
description: Run a fast Quick Flow in the current TUI session. The foreground runner writes and freezes one fresh workflow record before inspection, inspects proportionally, asks at most once when a material decision remains, forms one compact checklist, edits only for mutating intents, validates with the narrowest sufficient evidence, performs eligible cleanup, and reports directly. Read-only records stay outside the project. No child agent, delegation, relay layer, or workflow reuse.
---

<!-- Version: 5.1.0 — full history: see CHANGELOG.md in this skill directory. -->

# Skill: Quick Flow

## Purpose

Quick Flow is the speed-first path for bounded work. The current foreground TUI agent performs the complete run in one visible session.

```text
structure prompt → write and freeze one fresh workflow
→ inspect → ask once only if needed → form one compact checklist
→ edit only for mutating intents → validate → perform eligible cleanup → report
```

The skill is an instruction contract, not an executable actor. It never launches a child agent, delegates work, starts a hidden background job, or transfers responsibility to another session.

## Activation

Activate only when the current request explicitly invokes `quickflow`, asks to create or run a Quick Flow workflow, or uses equivalent explicit phrasing. Activation never carries across turns.

A request to inspect or edit the Quick Flow skill itself is ordinary standalone work unless that same request explicitly asks Quick Flow to perform it.

An invocation that also requires parallel execution, delegation, subagents, or Agents Flow is incompatible with Quick Flow's foreground-only topology. Before authoring a workflow, use the structured Ask UI to choose either foreground-only Quick Flow or Agents Flow/delegated execution. This pre-authoring routing decision is outside the Quick Flow run and does not consume its post-inspection user-decision reply.

## Foreground Runner

The agent already serving the user's TUI session performs the complete run: authoring, inspection, decisions, checklist formation, implementation for mutating work, validation, eligible cleanup, recovery evidence, and reporting.

`QUICK` in workflow slots and profile headings names this foreground role, not a configured or spawned agent. All substantive work remains in the active session; never delegate, launch a child agent, or create a relay/background implementation path.

## Minimal Messaging

Do not send routine authoring, inspection, implementation, validation, cleanup, or pre-final phase messages. Use the structured Ask UI only for a material decision, send a safety stop when needed, send one notice before an operation expected to exceed 90 seconds, and send the final report. Tool activity remains visible through the host, and the user may interrupt the foreground runner directly.

## Pre-Inspection Authoring

Follow `references/workflow-authoring.md`. Every invocation creates one fresh immutable workflow record before target inspection. Mutating project-backed work uses a collision-free `.quickflow/QUICK_WORKFLOW*.md`; `intent-inquiry`, `intent-diagnosis`, or a task without a writable project root uses a collision-free project-external `local://quickflow/workflows/QUICK_WORKFLOW*.md`. No launcher is generated.

Render and mechanically validate the canonical template in memory with `Quick Flow skill: 5.1.0`, workflow schema `6`, profile schema `4`, and prompt-grounded profile selection. A successful write freezes that validated in-memory render as the binding workflow; do not reread the saved record. A failed write stops the run before target inspection.

Authoring may use only the prompt and supplied context, explicitly named inputs, path metadata, the profile-selection index, and the canonical template. Put project facts under **Facts for QUICK to discover**; do not inspect targets, choose edits, or invent evidence before the workflow is frozen.

## Fresh-Only Contract

Every run receives a newly authored record. Once its write succeeds, the validated in-memory workflow is frozen: never rewrite, reuse, execute, or migrate an older record. Record later bounded decisions and checklist adjustments in the final report.

## Foreground Runtime

After the workflow write succeeds and the in-memory contract is frozen:

1. read only the frozen selected profiles' runtime guardrails and validation obligations;
2. inspect proportionally and resolve discoverable facts;
3. compare the frozen profiles with the observed target without changing the profile set, except the one-time `generic-fallback` resolution into its single specific artifact profile defined in `references/profiles.md`; never infer a primary intent from the target;
4. before editing, mark an inapplicable profile-derived obligation inapplicable only with observed evidence and only when the remaining selected profiles safely cover the task; disclose the mismatch in the final report;
5. issue a terminal safety stop when the primary intent is inapplicable or the remaining selected profiles do not safely cover the task;
6. ask zero or one consolidated set of material decisions through the structured Ask UI;
7. form one compact checklist connecting each change or answer to focused acceptance evidence;
8. edit directly only for a mutating intent; inquiry and diagnosis remain read-only;
9. validate every committed criterion with the narrowest sufficient project-native evidence, collapsing equivalent checks;
10. perform the narrow LaTeX post-success cleanup when `artifact-document-latex` is eligible;
11. persist recovery evidence only when required and report directly to the user.

No launcher, second agent, relay, job polling, or second runtime session exists.

## Structured Decisions and Continuation

Follow `references/grilling-intake.md`. Zero questions is preferred. The run waits for at most one user-decision reply: either one structured Ask UI submission containing at most three evidence-grounded decisions or one resumable safety stop, never both.

Never ask for discoverable facts, mode preferences, or checklist approval. After a reply, inspect only what is needed to bind the selected option. A newly discovered non-destructive target clearly implied by the original goal may be added to the checklist and disclosed in the final report; genuine scope expansion or an unresolved blocker follows the canonical safety-stop rules.

## Compact Action Checklist

Keep one internal checklist:

```text
1. files: <paths>
   change: <intended behavior>
   acceptance: <focused observable check>
```

It is not an approval packet. A stronger check may be added. A profile-derived check may be marked inapplicable only before editing, only with observed evidence, and only when the remaining frozen profiles still cover the task safely. The saved workflow never changes; the loaded profile set changes only for the one-time `generic-fallback` resolution before editing. After editing begins, never silently remove or weaken a committed acceptance check.

## Validation

Validation is proportional. Collapse semantically equivalent obligations from all selected profiles into one acceptance check and one execution. Run the narrowest project-native evidence that proves the result, then stop.

Reproduce repairs when practical, exercise changed UI in the browser, and compile/render task-relevant LaTeX with focused page and diagnostic inspection. Use exhaustive comparisons, broad suites, formatters, linters, or additional tests only when the prompt, changed interface, or focused evidence requires them. A committed check that cannot run is failed or blocked; never edit unrelated source merely to make validation pass.

## LaTeX Post-Success Cleanup

After every committed check passes for mutating `artifact-document-latex` work, resolve the exact LaTeX build directory, enumerate the existing regular files directly in that directory whose names match `*.aux`, `*.log`, `*.out`, or `*.toc`, and remove only those paths non-recursively with `rm -f -- <existing paths>`. Report the removed paths or that no matches existed. Never run this cleanup for `intent-inquiry` or `intent-diagnosis`; never recurse, remove matching directories, search unrelated directories, or remove any other extension. Cleanup failure is a non-fatal process warning.

## Conditional Evidence Persistence

Follow `references/safety.md` and `references/templates.md`. Persist a project-external recovery packet only when the user or workflow requests one, an irreversible/external effect occurred or was attempted, or the run fails or blocks after modifying user files. Otherwise report concise evidence inline.

## Core Safety Boundaries

- Inspect before editing and fix the requested problem at its source.
- Touch only checklist-required files and preserve protected APIs, identifiers, references, paths, structure, and meaning.
- Never expose secrets, add unrelated cleanup or dependencies, or weaken failed evidence.
- Irreversible or external effects require exact authorization plus recovery and validation boundaries.
- Destructive git rollback requires explicit approval in the current conversation; never discard user changes to repair workflow work.
- Corruption explicitly named as the repair target may be diagnosed and repaired narrowly; unexpected corruption outside that target, suspected data loss, uncertain provenance, or corruption requiring destructive rollback ends in a terminal safety stop.
- The four-extension LaTeX cleanup is the only automatic post-success cleanup.

Detailed scope, secret, rollback, recovery, and validation boundaries are canonical in `references/safety.md`.

## Direct Message Contract

Use the structured Ask UI for routine decisions. Use `references/templates.md` for safety stops, long-operation notices, recovery packets, and final reports. Do not create routine phase messages, a relay, a transport waiter, or a background status loop.

## Reference Files

Load only what the active phase needs:

- `assets/QUICK_WORKFLOW_CORE.template.md`: compact workflow template.
- `references/workflow-authoring.md`: pre-inspection rendering, write gate, and freeze.
- `references/profiles.md`: profile index plus selected runtime and validation obligations.
- `references/grilling-intake.md`: structured-decision and safety-stop rules.
- `references/safety.md`: destructive-action, scope, secret, recovery, and validation boundaries.
- `references/templates.md`: safety-stop, long-operation, recovery, and final-report formats.

## Completion

A run completes only after the requested result is produced or honestly blocked, every applicable committed check is accounted for, conditional recovery evidence is handled, and the foreground runner reports directly to the user.
