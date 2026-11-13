---
name: arch-roast
description: Critically review an existing implementation for concrete architectural, correctness, reliability, performance, and maintainability risks. Use after meaningful code has been drafted or changed, before finalizing a PR.
---

# Arch Roast — Evidence-Based Engineering Review

## Mission

Find real weaknesses in the implementation and explain how they can fail in production. Be direct, technically rigorous, and evidence-driven. The goal is to improve the system, not to criticize style or produce an impressive list of hypothetical risks.

## Activation

Use when:
- A feature or refactor has a meaningful implementation to review.
- A pull request or diff needs architectural scrutiny.
- The user asks for a reliability, scalability, or maintainability review.

Do not use it:
- Before there is code or a concrete design to inspect.
- As a substitute for requirements discovery.
- To perform the final security/release checklist (use `/prod-gate`).
- To rewrite code automatically without first presenting findings and agreeing on scope.

## Evidence rules

1. Inspect the actual diff and relevant surrounding code. If the diff is unavailable, state the review scope and inspect the relevant files.
2. Every finding must point to a concrete file, symbol, line, query, request flow, or execution path when available.
3. Explain a plausible trigger and consequence. A risk without a credible failure path is not a finding.
4. Separate confirmed defects from conditional risks and questions.
5. Never invent line numbers, traffic levels, production incidents, benchmarks, or dependency behavior.
6. Do not report a theoretical issue as a vulnerability or bug without explaining the required conditions.
7. Avoid style-only feedback unless it materially affects correctness, readability, or maintainability.
8. Do not recommend distributed systems, caching, queues, microservices, or abstractions without a demonstrated need.

## Review workflow

### 1. Establish scope

Record:
- What changed.
- Intended behavior and key invariants.
- Files and flows inspected.
- What could not be inspected or executed.

Read adjacent code where needed. A diff alone may hide assumptions in callers, schemas, middleware, or shared utilities.

### 2. Trace critical paths

Follow the implementation end to end:
- Entry points and trust boundaries.
- Validation and authorization.
- State transitions and persistence.
- External calls and side effects.
- Retries, timeouts, and error handling.
- Cleanup and resource lifecycle.
- Response and user-visible behavior.

### 3. Review relevant risk areas

Select areas based on the actual code; do not mechanically produce findings for every category.

**Correctness and state**
- Broken invariants and invalid state transitions.
- Null/undefined handling and boundary conditions.
- Partial writes and inconsistent state.
- Incorrect assumptions about ordering or delivery.

**Concurrency and distributed behavior**
- Race conditions and lost updates.
- Duplicate requests, retries, and idempotency.
- Lock scope, deadlocks, and stale reads.
- Queue acknowledgement and delivery semantics.
- Cache invalidation and cross-instance consistency.

**Data and database**
- N+1 queries and unbounded reads.
- Missing indexes only when query patterns support the concern.
- Transaction boundaries and isolation assumptions.
- Unsafe migrations and schema/application incompatibility.
- Pagination correctness and data growth.

**Performance and resources**
- Unnecessary work on hot paths.
- Unbounded memory, subscriptions, listeners, or connections.
- Missing cleanup and lifecycle leaks.
- Blocking operations and avoidable serialization.
- Inefficient rendering or repeated network requests.

**Architecture and maintainability**
- Wrong module boundaries or circular dependencies.
- Leaky abstractions and duplicated business rules.
- Unnecessary indirection or premature generalization.
- Tight coupling to infrastructure.
- Unclear ownership of state and side effects.

**Security**
- Trusting client-controlled identity or permissions.
- Missing server-side authorization.
- Sensitive data exposure.
- Injection or unsafe deserialization.
- Secrets or unsafe logging.

Do not duplicate the full `/prod-gate` checklist. Flag security issues discovered in the code and leave release certification to that skill.

### 4. Validate findings

For each potential issue:
- Trace the exact execution path.
- Identify the preconditions.
- Check whether existing code already prevents it.
- Inspect tests or constraints that may invalidate the concern.
- Downgrade or remove unsupported findings.

### 5. Prioritize and recommend

Use severity:
- **Critical:** likely severe security/data-loss/system-wide impact; immediate action required.
- **High:** credible major correctness, security, or availability failure.
- **Medium:** meaningful defect or operational/performance risk with narrower impact.
- **Low:** limited risk or maintainability concern.

Severity must reflect impact and likelihood, not how easy the issue is to describe.

## Required output

Start with a short verdict: `No material findings`, `Findings need attention`, or `Review blocked by missing evidence`.

For each finding provide:
- Severity.
- Evidence: file, symbol, and line range if verified.
- Trigger: exact sequence or conditions.
- Impact: what breaks and for whom.
- Why current safeguards are insufficient.
- Recommended fix.
- Regression test that would prove the fix.

Then include:
- Positive design choices worth preserving.
- Areas not verified.
- A prioritized remediation order.

If there are no findings, do not manufacture them. State what was inspected and the limits of the review.
