# Quick Flow Message Templates

This file defines the small set of plain-text messages the foreground runner sends directly in the active TUI conversation. Routine user decisions use the structured Ask UI, not a text template. There is no relay protocol, background status channel, transport waiter, exhaustive internal packet, decision record, or mandatory success audit.

## Minimal Messaging

Do not send routine authoring, inspection, implementation, validation, cleanup, decision-waiting, or pre-final phase messages. The structured Ask UI or safety stop is self-announcing. Send one long-operation notice only when needed, then the final report. Do not send periodic heartbeats, private reasoning, per-tool narration, or redundant progress messages.

## Long-Operation Status

Before an operation expected to block for more than 90 seconds, send once:

```text
QUICK FLOW — <observable long operation>; state=waiting; next=<result or blocker expected when control returns>.
```

Send this once; do not repeat it periodically.

## Routine Structured Decision

Use the structured Ask UI according to `references/grilling-intake.md`; there is no plain-text routine-decision template. Submit at most three related questions together, provide bounded options and concise tradeoffs, mark a recommended option when appropriate, and wait once for one reply. A run uses either this structured decision request or one resumable safety stop and never waits for a second user-decision reply.

## Safety Stop

```text
QUICK FLOW SAFETY STOP [S<n>] — <blocked decision>
kind=<resumable|terminal>; reason=<short evidence-based reason>; options=<bounded options>; next=<wait for one answer|current run ends>
```

A resumable stop is allowed only when no structured decision request has been submitted and receives one direct reply. A terminal stop ends the run and receives no answer.

## Compact Internal Action Checklist

The foreground runner keeps one internal checklist:

```text
1. files: <exact paths>
   change: <intended behavior>
   acceptance: <focused observable check>
```

There is no separate implementation packet, validation packet, decision record, handoff, or approval packet.

## Conditional Recovery Packet

Persist a packet only when:

1. the user or workflow explicitly requests an audit artifact;
2. an irreversible or external effect occurred or was attempted; or
3. the run ends failed or terminally blocked after modifying user files.

Use a unique path:

```text
local://quickflow/<workflow-stem>-<UTC-YYYYMMDDTHHMMSSZ>-recovery.md
```

If the path exists, append a numeric suffix. Include only:

- workflow title and final outcome;
- changed files;
- failed or blocked acceptance checks and concise evidence;
- external effects, if any;
- whether user files remain modified;
- recovery boundary and narrow next action.

Exclude private reasoning, secret values, source dumps, and unnecessary raw tool output. Verify the write and report the exact URI. If persistence fails, report `[PROCESS WARNING]` and the required recovery evidence inline.

When persistence is not required, create no packet and no placeholder URI.

## Final Report

Every run ends with a concise direct report beginning exactly with:

```text
════════════════════════════════
## Final Report
```

Then use a compact Markdown table:

```text
| Result | <task title> — <SUCCEEDED|FAILED|BLOCKED> |
|---|---|
| **Outcome** | accomplished, failed, or terminally blocked |
| **Files** | changed files; `none` when no files changed |
| **Validation** | focused checks and results |
| **Decisions** | only when the structured Ask UI or a bounded scope adjustment occurred |
| **Recovery** | only when files remain modified after failure or an external effect occurred |
| **Evidence** | exact recovery URI only when one was required and persisted |
```

Choose the result status that matches the outcome; never use `SUCCEEDED` for partial, failed, or blocked work. Omit optional rows rather than writing `none`. Keep success reports short. On failure or terminal blockage, add `## Problem` with where it stopped, likely cause, modified-file state, recovery boundary, and narrow next action. Include a rollback command only when the user explicitly approved that exact command.
