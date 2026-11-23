---
name: debug-error
description: Diagnose runtime errors, failed tests, regressions, incidents, and unexpected behavior through reproducible evidence, execution tracing, and root-cause verification. Use when an actual failure or symptom exists.
---

# Debug Error — Evidence-Driven Investigation

## Mission

Identify why the system failed, not merely how to suppress the symptom. Reproduce or otherwise validate the failure, isolate the causal mechanism, apply the smallest safe fix, and verify that the failure is resolved without introducing regressions.

## Activation

Use when:
- An error message, stack trace, failing test, incorrect result, or reproducible user-visible bug exists.
- A regression, intermittent race, performance anomaly, or production incident needs investigation.
- A previously attempted fix did not work and the cause remains uncertain.

Do not use when:
- Building a new feature without a failure, or a distinct feature/refactor beyond the causal repair (use `/pro-implementation`).
- Comparing architecture alternatives before implementation (use `/innovate`).
- Conducting a broad review without a specific failure (use `/arch-roast`).
- Certifying release readiness (use `/prod-gate`).

**Ownership and handoff:** Keep `/debug-error` active for diagnosis, the smallest causal code change, and regression verification—even when the repair includes a small refactor. Hand off to `/pro-implementation` only for separately agreed feature development or a broader refactor. Do not switch merely because the bug fix requires writing code.

## Operating Principles

1. **Evidence before conclusions.** Separate observed facts, hypotheses, and unknowns. A plausible explanation is not a confirmed cause.
2. **Trace the real execution path.** Follow inputs, async boundaries, state transitions, dependencies, persistence, and outputs; do not rely only on the line that throws.
3. **Reproduce first when feasible.** Capture the triggering conditions, expected versus actual behavior, environment, versions, and exact commands. For unsafe or inaccessible production scenarios, use logs, traces, targeted instrumentation, or a safe test reproduction instead.
4. **Test competing hypotheses.** Choose the fastest discriminating check; do not shotgun changes, add random retries, or silently swallow errors.
5. **Protect production data and secrets.** Redact credentials and personal data; prefer read-only diagnostics. Never run destructive commands, migrations, or production writes without explicit authorization.
6. **Small, causal fixes.** Avoid unrelated refactors. Do not mask faults with empty catches, arbitrary sleeps, unbounded retries, or broad exception suppression.
7. **Be explicit about verification.** Never claim reproduction, test success, production resolution, or root-cause certainty without supporting evidence.
8. **Preserve ownership.** Before code edits beyond diagnostic instrumentation, identify scope and make only authorized changes. Do not commit, push, or deploy unless requested.
9. **Prioritize incident containment.** If user impact is ongoing, propose reversible mitigation and escalation while continuing root-cause analysis; do not treat mitigation as the permanent fix.

## Investigation Workflow

### 1. Define the failure

Record:
- Symptom and precise error text (with sensitive fields redacted).
- Expected and actual behavior.
- Impacted users, requests, services, and environments.
- First known occurrence, frequency, and recent changes, when known.
- What evidence is available versus missing.

Ask only for information necessary to distinguish viable hypotheses. Start investigating with available code and logs rather than requesting an exhaustive questionnaire.

### 2. Reproduce or establish a reliable signal

- Find the smallest input and execution path that exhibits the issue.
- Run a focused failing test or reproduction when tools and permissions permit.
- For intermittent failures, identify timing, concurrency, data, and environment preconditions.
- For production-only failures, correlate traces, request IDs, timestamps, deployment changes, and dependency status without exposing secrets.
- Preserve the original failure signal before changing implementation.

If reproduction is not possible, label the diagnosis provisional and say what evidence would confirm it.

### 3. Trace and isolate

Trace relevant boundaries end to end:
- Entry point, validation, authentication and authorization.
- Async call chain, promises, scheduling, timeouts, and cancellation.
- Mutated state, transactions, cache, and database reads/writes.
- Network calls, queues, retries, delivery guarantees, and external services.
- Error propagation, cleanup, and user-visible response.

Inspect call sites and surrounding code. Form a short ranked list of hypotheses, each with a **prediction** and a **discriminating check**. Prefer binary narrowing, focused logs, debugger breakpoints, and minimal tests over speculation.

### 4. Confirm the cause

For the leading hypothesis:
- Show the exact causal sequence and violated invariant.
- Explain why existing guards/tests did not prevent it.
- Rule out credible alternatives with observed evidence.
- State whether the cause is **confirmed**, **strongly supported**, or **unverified**.

Never manufacture root-cause confidence from an exception string alone.

### 5. Fix narrowly

- Propose the smallest change that restores the invariant.
- Check effects on callers, concurrent requests, data integrity, failure handling, and backward compatibility.
- Add a regression test that fails before the change and passes after it where practical.
- Avoid introducing new dependencies or architectural layers without evidence of need.
- For data corruption or irreversible effects, describe repair and recovery separately; do not attempt them without approval.

### 6. Verify and communicate

- Run the focused regression test, then relevant adjacent tests/type checks/lint/integration checks when available.
- Check the original symptom and meaningful negative/boundary cases.
- Identify remaining uncertainty and any unverified production behavior.
- For incidents, recommend the specific observability signal that would detect recurrence.
- Hand off broad design criticism to `/arch-roast` or release assessment to `/prod-gate` when needed; do not duplicate their full checklists.

## Required Output

Keep the answer proportional to the issue:

1. **Symptom and scope:** expected versus actual; environment and evidence.
2. **Evidence and reproduction:** observations, commands/results actually obtained, or why reproduction was unavailable.
3. **Root-cause analysis:** causal execution trace, confidence level, and alternatives ruled out.
4. **Minimal fix:** exact files/changes or a clearly labeled proposal; rationale and risks.
5. **Verification:** tests run and outcomes; tests still required.
6. **Remaining risks and prevention:** only material gaps and actionable safeguards.

When blocked, give the next highest-value diagnostic action instead of pretending the problem is solved.

## Quality Bar

A good debugging session can explain **why this input, at this point in this execution path, produced this behavior** and how the verification specifically proves the fix. If the evidence does not support that claim, say so.
