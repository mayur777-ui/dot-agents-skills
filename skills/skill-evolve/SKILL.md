---
name: skill-evolve
description: Conduct an evidence-based engineering retrospective and propose focused improvements to existing agent skills and the learning log. Use after a significant feature, debugging session, review, or periodic engineering retrospective.
---

# Skill Evolve — Engineering Learning and Skill Improvement

## Mission

Turn real engineering experience into durable, reusable knowledge. Identify what the engineer has demonstrated, where they struggled, and what process or skill instruction would prevent repeated mistakes.

Do not turn every session into documentation work. Optimize for useful learning, not volume.

## Activation

Use when:
- A significant feature or refactor has shipped.
- A difficult debugging session has exposed a recurring knowledge gap.
- A review found a meaningful pattern worth preventing in future work.
- The user requests a weekly or milestone retrospective.
- There is evidence that an existing skill is unclear, incomplete, or producing poor outcomes.

Do not use it:
- After every trivial edit or routine question.
- To infer mastery from a single correct answer.
- To invent work history, inspect Git history that is not available, or claim to have read files that were not provided.
- To rewrite skills merely to make them longer.
- To save secrets, credentials, private customer data, or unnecessary personal information in learning documents.

## Evidence rules

Use only available evidence, such as:
- Current conversation and explicit user explanations.
- Actual code changes or Git diff, if accessible.
- Test results and debugging traces actually observed.
- Findings from `/arch-roast` or `/prod-gate`, if present.
- Existing `.agents/skills/*/SKILL.md` and `.agents/LEARNING_LOG.md`, if accessible.

Clearly label:
- **Observed:** directly demonstrated by evidence.
- **Inferred:** a reasonable interpretation, with uncertainty.
- **Unknown:** insufficient evidence.

Do not describe a concept as mastered merely because AI produced correct code. Look for the engineer's own explanation, decisions, debugging, or independent application.

## Workflow

### 1. Reconstruct the work

Summarize:
- Problem and intended outcome.
- Important engineering decisions.
- Implementation and debugging steps.
- Tests and verification.
- Review findings and production risks.
- What changed after feedback.

If Git diff or project files are unavailable, say so and base the retrospective only on the available conversation.

### 2. Assess learning

Identify:
- **Demonstrated strengths:** concepts or practices the engineer independently applied or explained.
- **Developing areas:** concepts applied with guidance or partial understanding.
- **Recurring friction:** repeated confusion, debugging detours, incorrect assumptions, or missed checks.
- **Unverified areas:** topics not tested by the work.

Use specific examples. Avoid generic labels such as "needs better problem-solving."

### 3. Extract reusable lessons

For each worthwhile lesson, state:
- Situation or trigger.
- Incorrect or fragile approach.
- Better principle or procedure.
- A concrete example.
- When the lesson should be applied again.

Prioritize lessons that are reusable across projects, reduce meaningful risk, or address a demonstrated recurring gap.

### 4. Decide where the lesson belongs

Choose the smallest appropriate destination:
- Existing skill: update only if the lesson improves activation, workflow, constraints, or output quality.
- Reference file: use for detailed domain guidance that would make the main skill too long.
- `.agents/LEARNING_LOG.md`: record personal learning, evidence, and follow-up practice.
- No update: if the lesson is one-off, obvious, already documented, or unsupported.

Do not create a new skill unless the user explicitly wants one and there is a distinct recurring capability that warrants it.

### 5. Propose minimal edits

For each proposed change:
- Identify the exact file and section.
- Explain why the change is needed.
- Provide a focused Markdown patch or replacement section.
- Avoid duplicating rules already present.
- Preserve existing structure and useful content.
- Do not overwrite files or claim updates were made unless the user authorized the change and the tool actually performed it.

### 6. Recommend deliberate practice

Suggest one to three targeted exercises or future tasks that test the identified learning area. Define what successful independent performance looks like.

Avoid generic study plans and unnecessary homework.

## Suggested learning-log format

Use or adapt this structure in `.agents/LEARNING_LOG.md`:

```markdown
## YYYY-MM-DD — [Feature / debugging topic]

### Context
[What was being built or investigated.]

### Demonstrated
- [Evidence-backed strength.]

### Developing
- [Area that required guidance, with example.]

### Reusable lessons
- [Trigger] → [Principle / better procedure].

### Follow-up practice
- [Specific exercise and success criterion.]

### Skill updates
- [File and proposed change, or "None needed."]
```

## Required output

1. **Session summary**
2. **Evidence reviewed and limitations**
3. **Demonstrated strengths**
4. **Developing areas and recurring friction**
5. **Reusable lessons**
6. **Proposed skill / learning-log edits** (minimal, with exact paths)
7. **Targeted practice**

## Quality bar

A successful retrospective changes future behavior. It may conclude that no skill update is needed.

Prefer one precise, evidence-backed improvement over a large collection of generic advice.
