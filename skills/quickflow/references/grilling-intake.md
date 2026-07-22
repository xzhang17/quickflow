# Quick Flow Structured Decisions and Safety Stops

Routine structured decisions and resumable safety stops use this protocol only after the fresh workflow has been authored and frozen, selected profiles are loaded, and enough target inspection is complete to establish facts and bounded alternatives. A topology-routing decision occurs before authoring, while a terminal safety stop may also occur before freezing when the in-memory workflow cannot be rendered safely.

## Pre-Authoring Topology Routing

When a request explicitly combines Quick Flow with parallel execution, delegation, subagents, or Agents Flow, use the structured Ask UI before workflow authoring to choose between foreground-only Quick Flow and Agents Flow/delegated execution. This routing decision is outside the Quick Flow run and does not consume its post-inspection user-decision reply. If Quick Flow is selected, no delegation or child agent is permitted.

## Routine Structured Decision

Zero questions is preferred. Use exactly one structured Ask UI submission only when all of the following hold:

1. the issue is a genuine user decision, not a discoverable fact;
2. it materially affects behavior, semantics, scope, safety, public compatibility, destructive behavior, or validation;
3. inspection produced concrete evidence and bounded alternatives;
4. the prompt, project conventions, and a conservative default do not already settle it safely.

Submit at most three related questions together and wait once for one reply. Give each question two to four bounded options, describe material tradeoffs concisely, and mark a recommended option when appropriate. A run waits for at most one user-decision reply: use either this structured Ask UI submission or one resumable safety stop, never both. Never ask routine questions one at a time, request checklist approval, or open a second decision request.

Do not ask where files or symbols are, which build command exists, how many occurrences exist, what project conventions say, or anything already answered by the prompt or inspection.

## After the Reply

Record selected options and conservative defaults, then perform only the targeted inspection needed to bind those choices. Update the compact action checklist and proceed without another approval.

A newly discovered target or bounded delta inspection does not require re-authoring when clearly implied by the original goal, non-destructive, inside protected scope, and independent of new authorization. Disclose the adjustment in the final report.

If more than three genuine decisions remain, submit the three highest-impact questions only when every omitted decision has a safe conservative default. If any remaining decision cannot be defaulted without materially changing behavior, scope, safety, compatibility, destructive effects, or validation, do not open the structured Ask UI; issue a terminal safety stop that explains why the run cannot safely continue.

## Safety Stops

Every safety stop declares one kind and appears directly in the active conversation. Never send a resumable safety stop after a structured decision reply.

### Resumable

Use only when no structured decision request has been submitted, complete bounded alternatives are already known, and one answer requires no new authorization or expanded scope. Ask once, wait for one direct reply, update the checklist, and continue in the same session.

### Terminal

Use for:

- the in-memory workflow cannot be rendered from the canonical template, or a later integrity failure occurs in a frozen workflow;
- a mid-run loss of the frozen in-memory contract when this run has no saved record to recover it from;
- missing selected profile;
- an inapplicable primary intent, a `generic-fallback` whose single specific artifact profile cannot be identified or whose required mutating intent cannot be established, or remaining applicable profiles that do not safely cover the observed target;
- genuinely expanded user scope rather than an implied target;
- irreversible or external action lacking exact authorization and recovery boundaries;
- unexpected corruption outside the authorized repair target, suspected user-data loss, uncertain provenance, or corruption requiring destructive rollback;
- any blocker that cannot be resolved safely inside the original goal.

A terminal stop ends the run. The foreground runner authors the blocked final report directly and persists a recovery packet only if user files were modified, an external effect occurred or was attempted, or the user or workflow requested one.

```text
QUICK FLOW SAFETY STOP [S<n>] — <blocked decision>
kind=<resumable|terminal>; reason=<short evidence-based reason>; options=<bounded options>; next=<wait for one answer|current run ends>
```

## Zero-Question Path

When no decision remains, continue directly. Do not send a decision-skipped status or maintain a separate decision record.
