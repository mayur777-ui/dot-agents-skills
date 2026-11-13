---
name: prod-gate
description: Perform a pre-merge or pre-deployment production-readiness and security assessment of a feature or service. Use when implementation is substantially complete and the team needs a release decision.
---

# Prod Gate — Production Readiness and Security

## Mission

Determine whether the change is sufficiently safe to merge or deploy, based on evidence. Identify release blockers, required fixes, operational gaps, and explicitly accepted risks.

This is a release assessment, not a substitute for implementation review or a formal penetration test.

## Activation

Use when:
- A feature is ready for PR finalization, merge, staging, or production.
- A migration or infrastructure change is about to be deployed.
- The user explicitly requests a production-readiness or security gate.

Do not use it:
- To gather initial requirements.
- To replace `/arch-roast` during design or implementation review.
- To claim formal compliance, certification, or exhaustive security assurance.
- To approve deployment when required evidence is unavailable.

## Operating principles

1. Verify the actual code, configuration, tests, and deployment artifacts available. Do not infer that a control exists because it is mentioned in documentation.
2. Treat all client input and client identity claims as untrusted.
3. Authorization must be enforced server-side at the resource/action boundary.
4. Prefer deny-by-default access and least privilege.
5. Protect data integrity across retries, concurrency, partial failures, and migrations.
6. Never expose secrets, tokens, personal data, or sensitive payloads in logs.
7. Do not claim a test, scan, migration rehearsal, or deployment check was run unless it was.
8. Adapt the checklist to the stack and risk. Mark irrelevant checks as not applicable with a reason.
9. A checklist is evidence of review, not proof that a system is secure.

## Gate workflow

### 1. Define the release scope

Identify:
- Change and affected services.
- Data and user groups affected.
- Environments and deployment method.
- Dependencies and external integrations.
- Migration or configuration changes.
- Rollback or recovery mechanism.

If release scope or evidence is missing, state what is needed before approval.

### 2. Identity, authentication, and authorization

Verify:
- Authentication is enforced on protected server endpoints.
- Authorization and RBAC/ABAC checks are server-side, not only in the UI.
- Object-level access prevents IDOR and cross-tenant access.
- Roles and permissions fail closed.
- Service-to-service credentials use least privilege.
- Session/token validation, expiration, revocation, and refresh behavior are appropriate.
- Sensitive administrative actions are protected and auditable.

Check negative cases: unauthenticated, wrong role, wrong tenant, guessed resource ID, expired/revoked credential.

### 3. Input, application, and data security

Verify where applicable:
- Schema validation at trust boundaries.
- Output encoding and safe rendering.
- Parameterized database queries and safe ORM usage.
- Upload limits, file type/content validation, and storage isolation.
- Rate limiting and abuse controls for sensitive or expensive endpoints.
- CSRF/CORS protections appropriate to the authentication model.
- SSRF, path traversal, command injection, and unsafe deserialization risks.
- Secrets are not committed, exposed to clients, or logged.
- Sensitive data is minimized, encrypted where appropriate, and access-controlled.

### 4. Database integrity and migrations

Verify:
- Transactions cover operations that must succeed or fail together.
- Isolation and locking assumptions are understood for concurrent updates.
- Unique constraints and foreign keys enforce critical invariants where appropriate.
- Retry behavior cannot create duplicate or inconsistent effects.
- Migrations are compatible with the deployed application version during rollout.
- Destructive changes use a safe expand/migrate/contract sequence where needed.
- Backfills are restartable, observable, and bounded.
- Index changes and long-running migrations have an operational plan.
- Backup/restore or recovery expectations are understood for risky data changes.

A rollback plan must be realistic. Some schema/data migrations are not safely reversible; document forward-recovery instead of pretending a down migration restores lost data.

### 5. Reliability and failure handling

Verify:
- Timeouts exist for network and external dependency calls.
- Retries are bounded, use appropriate backoff, and only apply to safe operations.
- Idempotency is handled for duplicate requests or message delivery where needed.
- Queue acknowledgement, dead-lettering, and redelivery behavior are understood.
- Partial failures do not silently corrupt state.
- Resource cleanup occurs for connections, streams, subscriptions, and temporary files.
- Health/readiness checks reflect actual ability to serve traffic.
- Capacity assumptions and rate limits are reasonable for the expected release.

### 6. Testing and verification

Review evidence for:
- Unit tests for critical business rules.
- Integration tests for database and external boundaries.
- API/contract tests where interfaces are affected.
- E2E tests for critical user journeys where appropriate.
- Negative authorization and validation tests.
- Migration tests or rehearsal evidence for risky schema changes.
- Regression tests for bugs fixed by this change.

Run available checks only when tools and environment permit. Record exact commands and results. If checks cannot be run, list them as outstanding.

### 7. Observability and operations

Verify:
- Structured logs include useful correlation/request identifiers.
- Logs avoid secrets and sensitive payloads.
- Important failures and business events are observable.
- Metrics cover latency, error rates, saturation, and relevant domain outcomes.
- Alerts exist for actionable failure modes where appropriate.
- Dashboards or runbooks identify how to diagnose the service.
- Deployment, rollback/forward-fix, and owner/on-call expectations are clear.

### 8. Release decision

Classify each item:
- **Blocker:** must be fixed before release.
- **Required before rollout:** must be completed before the affected traffic/data is exposed.
- **Accepted risk:** explicitly understood, owned, and accepted by the responsible person.
- **Not applicable:** explain why.
- **Not verified:** evidence unavailable; never treat as a pass.

## Required output

1. **Release scope**
2. **Gate result:** `BLOCK`, `CONDITIONAL`, or `PASS`
3. **Blockers** with evidence, impact, and required action
4. **Required before rollout**
5. **Accepted risks / owner needed**
6. **Checks passed**, including actual evidence
7. **Not verified / not applicable**
8. **Deployment and recovery checklist**

Only use `PASS` when no release-blocking checks remain and the required evidence has been verified. Use `CONDITIONAL` when outstanding items have explicit owners and must be completed before the relevant release step. Use `BLOCK` for unresolved critical/high-risk issues or missing essential evidence.
