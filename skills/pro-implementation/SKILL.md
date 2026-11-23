---
name: pro-implementation
description: Implement a defined feature, API, UI workflow, integration, or refactor end to end with minimal, maintainable production-quality code and meaningful verification. Use when requirements are sufficiently clear and the user wants code delivered.
---

# Pro Implementation — Production-Quality Feature Delivery

## Mission

Turn agreed requirements into a correct, secure, reliable, testable implementation that fits the existing codebase. Favor the smallest coherent change, explicit invariants, and verifiable outcomes over abstraction, code volume, or novelty.

## Activation

Use when:
- The primary intent is to deliver a concrete feature, module, endpoint, UI flow, integration, or refactor, rather than a teaching-first walkthrough.
- Acceptance criteria are available or can be reasonably inferred and explicitly stated.
- There is existing code to extend, or the user has selected the stack for new work.

Do not use when:
- A current bug needs root-cause investigation or a directly causal fix (use `/debug-error` through diagnosis, minimal repair, and regression verification).
- Requirements or product behavior have not been decided; clarify only the blocking decision.
- The task is primarily evaluating architecture alternatives (use `/innovate`).
- The primary intent is first-principles learning, including implementation explicitly requested as a teaching exercise (use `/code-why` Mode A).
- A separate post-implementation review or release gate is needed (use `/arch-roast` or `/prod-gate`).

**Routing and handoff:** `/pro-implementation` owns normal production feature delivery, even when a concise rationale is requested. Explicit teaching-first implementations belong to `/code-why` Mode A. When investigation reveals a narrowly scoped fix, `/debug-error` keeps ownership through the fix and regression tests; switch here only for a separate, agreed feature or broader refactor. Do not bounce between skills for one causal fix.

## Operating Principles

1. **Inspect before editing.** Read relevant code, conventions, package versions, contracts, callers, tests, and configuration. Do not invent APIs, file paths, framework behavior, or dependencies.
2. **Define correctness explicitly.** Name expected behavior, authorization boundaries, inputs/outputs, state transitions, and critical invariants before implementation.
3. **Smallest coherent patch.** Reuse existing primitives and patterns; avoid speculative abstractions, new infrastructure, or unrelated rewrites.
4. **Full execution path, not only happy path.** Handle validation, permission checks, error propagation, partial failure, resource cleanup, and user-visible states appropriate to the change.
5. **Proportional engineering.** Consider performance, concurrency, idempotency, transactions, observability, and scalability where the actual requirements justify them. Do not create complexity for hypothetical scale.
6. **Tests are evidence.** Add focused coverage for business rules, boundaries, negative paths, and regressions. Run available checks and report exact outcomes; never claim a test passed when it was not executed.
7. **Secure by default.** Validate untrusted input at boundaries, enforce server-side authorization, avoid leaking secrets, use safe DB queries, and protect tenant/resource isolation.
8. **Keep contracts compatible.** Consider existing API consumers, schema migrations, rolling deployments, and rollback/forward recovery when relevant.
9. **Do not silently broaden scope.** State material assumptions, avoid unrelated changes, and ask a targeted question only when ambiguity would make the implementation unsafe or incorrect.
10. **Respect write boundaries.** Do not commit, push, deploy, modify production data, or invoke irreversible operations without explicit authorization.

## Implementation Workflow

### 1. Establish task and repository context

Identify:
- Intended user outcome and acceptance criteria.
- Relevant files, modules, entry points, types, and existing tests.
- Stack versions and available commands.
- Existing behavior and compatibility constraints.
- Trust boundaries, data ownership, and downstream dependencies.
- Unknowns that materially affect correctness.

For complex tasks, summarize a short plan. For trivial changes, proceed directly.

### 2. Design the minimal solution

- Sketch request/data flow from entry point to side effects to response.
- Define key invariants and failure semantics.
- Reuse proven codebase conventions and identify precise files to touch.
- Compare one materially viable alternative when the choice is non-obvious.
- Use `/innovate` for genuinely broad competing designs; do not turn ordinary feature work into an architecture exercise.

### 3. Implement in coherent slices

Prefer vertical slices that can be reasoned about and tested independently:
- Data model and migrations, if needed.
- Domain/business logic with validation and explicit errors.
- Persistence and external integration boundaries.
- API contracts and server-side authorization.
- UI interactions with loading, empty, error, and success states, where relevant.
- Observability and configuration appropriate to the feature.

Keep behavior consistent across layers. Avoid duplicate business rules, brittle assumptions, catch-and-ignore error handling, and premature optimization.

### 4. Handle failure and operational edges

Check relevant cases rather than blindly applying every item:
- Missing, invalid, stale, or unauthorized input.
- Concurrent requests, races, retries, and duplicate effects.
- Transaction boundaries, partial commits, and idempotency where needed.
- Timeouts, cancellation, resource lifecycle, and bounded retries.
- Pagination/volume limits, query costs, and indexing grounded in real usage.
- Secrets, logging sensitivity, cross-user or cross-tenant access.
- Backward compatibility and deployment order of schema/config changes.

### 5. Validate incrementally

- Add focused unit tests for core rules and boundary cases.
- Add integration/contract tests for significant database, queue, or external API behavior when practical.
- Add UI interaction/accessibility checks or E2E coverage for critical flows when relevant.
- Run targeted tests first, then applicable lint, type-check, build, and broader tests.
- Inspect the diff for accidental changes; remove debugging artifacts.
- Report exact commands/results and explicitly identify checks not run.

If the environment lacks dependencies, credentials, or test infrastructure, stop short of claiming verification. Provide the commands and expected evidence needed.

### 6. Final delivery

Provide:
- What changed and where.
- How the feature executes end to end.
- Key design decisions and rejected complexity.
- Tests run with actual outcomes.
- Remaining limitations, migrations, rollout concerns, and follow-up work.
- Any decision or approval needed from the user.

If requested, call `/arch-roast` for independent architectural scrutiny and `/prod-gate` for release assessment. Implementation completion alone does **not** imply production approval.

## Required Output

Scale detail to task complexity. For substantial work, use:

1. **Goal and acceptance criteria**
2. **Existing design and implementation plan**
3. **Changes made** (files and meaningful behavior)
4. **Execution/data flow and key trade-offs**
5. **Verification performed** (commands and results)
6. **Unverified cases, risks, and rollout notes**

For a small fix, a concise summary, focused diff, and verification are enough.

## Quality Bar

A feature is complete only to the extent that its behavior and relevant failure cases are implemented and verified. If the code was drafted but not run, label it **implemented, not verified** rather than **production-ready**.
