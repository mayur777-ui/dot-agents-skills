---
name: innovate
description: Explore and challenge technical approaches before implementation. Use when requirements are already understood and a feature, refactor, integration, or system needs an engineering approach. Do not use for initial product discovery or requirements gathering.
---

# Innovate — Engineering Options and Trade-offs

## Mission

Find the simplest sound technical approach that satisfies the agreed requirements. Challenge assumptions without introducing novelty for its own sake.

This skill is an exploration and decision-support process. It does not own product discovery, requirement gathering, or final decision-making.

## Activation

Use this skill when:
- Requirements and acceptance criteria have already been established.
- There are meaningful architectural or implementation choices.
- The proposed approach may introduce infrastructure, dependencies, abstractions, or operational costs.
- The user explicitly asks to explore alternatives or challenge a design.

Do not use it:
- To invent or expand product requirements.
- For trivial changes with an obvious, low-risk implementation.
- To recommend a new library merely to appear modern.
- To reopen a settled decision without new evidence or a changed constraint.

## Operating principles

1. Start from the agreed requirements and constraints. Do not silently change them.
2. Separate facts, assumptions, and unknowns.
3. Prefer boring, well-understood technology unless a different approach has a concrete advantage.
4. Evaluate total cost: implementation, operations, debugging, security, team familiarity, migration, and long-term maintenance.
5. Distinguish a genuine paradigm shift from a renamed version of the same design.
6. Do not claim a library or API is current, maintained, compatible, or superior without evidence. If external research is unavailable, say so.
7. Avoid premature scale. Design for known requirements and preserve reasonable extension points without building speculative infrastructure.

## Workflow

### 1. Restate the decision

Briefly state:
- The technical decision to make.
- The requirements it must satisfy.
- Relevant constraints (stack, deployment, data, latency, security, team knowledge).
- Any assumptions that could materially change the recommendation.

Do not repeat the entire product brief.

### 2. Challenge the default

Ask:
- What assumption is driving the current approach?
- Is that assumption required by the problem or inherited from habit?
- What is the simplest alternative?
- What complexity, dependency, or operational burden can be removed?
- What failure mode does each approach create?

Challenge the design respectfully and specifically. Do not manufacture disagreement.

### 3. Explore three solution levels

Present these when they are meaningfully different:

**A. Conventional approach**
The straightforward, familiar solution. Explain why it may be sufficient.

**B. Alternative / paradigm shift**
A materially different way to model or solve the problem. Explain what changes and what new costs it introduces. If no meaningful paradigm shift exists, state that plainly.

**C. 80/20 approach**
The smallest implementation that delivers the core agreed value with the fewest moving parts. State what it intentionally leaves out.

Also identify one modern library, framework feature, or native API only when it removes real boilerplate or solves a concrete limitation. Explain why the built-in or existing stack is not enough.

### 4. Compare trade-offs

Use a compact comparison covering:
- Requirement fit.
- Complexity and amount of code.
- Runtime and operational dependencies.
- Reliability and failure handling.
- Security implications.
- Performance characteristics where relevant.
- Testability and maintainability.
- Migration or adoption cost.

Do not invent numeric scores or performance claims.

### 5. Recommend a decision

Give:
- Recommended approach.
- Why it wins for these requirements.
- What we are deliberately not building.
- Risks and mitigations.
- Conditions that would make us revisit the decision.

The user owns the decision. Do not present a recommendation as an approved architecture until the user accepts it.

## Required output

1. **Decision to make**
2. **Assumptions and constraints**
3. **Default approach challenged**
4. **Options** (conventional, alternative, 80/20; omit genuinely irrelevant options with explanation)
5. **Trade-off comparison**
6. **Recommendation**
7. **Open questions / decision needed**

## Quality bar

A good result reduces uncertainty and helps the engineer make a decision. It does not maximize novelty, library count, abstraction, or document length.

If all options lead to the same practical solution, say so and recommend the simplest one.
