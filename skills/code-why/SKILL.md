---
name: code-why
description: Use when implementing a module to understand its underlying mechanics, or when asking to learn/deep-dive into an unfamiliar framework primitive, language keyword, or technical capability (e.g., useCallback, std::atomic, IIFE, Proxy).
---

# Code Why — Technical Capability, Primitives, and First-Principles Learning

## Mission

Transform black-box coding into durable engineering mastery. Teach the exact mechanics, runtime behavior, and syntax-level capabilities of tools, languages, and frameworks—whether implementing real production code or demystifying advanced language primitives.

---

## Dual-Mode Activation

The skill operates in one of two modes based on your intent:

```mermaid
flowchart TD
    Prompt["Your Request with /code-why"] --> ModeDetect{"Are you writing project code\nor asking about a primitive?"}
    ModeDetect -- "Writing / Refactoring Code" --> ModeA["Mode A: Feature Implementation\n(Surgical patch + runtime flow + trade-offs)"]
    ModeDetect -- "Asking About a Feature / Tool\n(useCallback, atomic, IIFE, Proxy, etc.)" --> ModeB["Mode B: Primitive & Syntax Deep-Dive\n(Capability + Syntax Anatomy + Before/After + When to Avoid)"]
```

### When to use Mode A (Feature Implementation):
- Implementing a defined feature, module, query, hook, or abstraction.
- Reviewing a tricky refactor where invariants must be protected.

### When to use Mode B (Primitive & Syntax Deep-Dive):
- Asking about a language keyword, hook, concurrency primitive, or design pattern (`useCallback`, `std::atomic`, `IIFE`, `WeakMap`, `Proxy`, `generator`, `Mutex`, etc.).
- Needing to understand *why* a language feature exists, its exact syntax grammar, and when it is an anti-pattern.

### Do not use it:
- For initial product discovery or requirement brainstorming (use `/brainstorming`).
- For wide-scope architecture comparison across multiple technologies (use `/innovate`).
- For full repository security/release audits (use `/arch-roast` or `/prod-gate`).

---

## Operating Principles

1. **Surface the Hidden Machinery:** Proactively explain what the underlying engine (V8, React Fiber, JVM, OS thread scheduler, CPU cache lines) is actually doing behind the abstraction.
2. **Syntax-Level Precision:** Always provide exact, modern syntax annotations—including types, parameters, return values, and subtle side-effects.
3. **Before vs After Contrast:** Always show naive or broken code without the feature contrasted against correct code using it.
4. **Honest Caveats & Anti-Patterns:** Never praise a language feature uncritically. Disclose when using it is unnecessary, adds runtime overhead, or degrades readability.
5. **Smallest Coherent Change (Mode A):** Surgical patches only. Never rewrite 200 lines when 10 lines solve the problem.
6. **No Phantom Tools:** Never instruct the user to install unneeded external tools or guess unverified library APIs.

---

## Mode A Workflow: Feature Implementation

When writing or refactoring project code:

1. **Establish Implementation Context:** Inspect versions, dependencies, and invariants.
2. **Explain the Mental Model:** Break down the runtime data flow and underlying engine behavior before code.
3. **Implement Incrementally:** Deliver the smallest coherent, production-ready patch with inline comments on the *why*.
4. **Explain Trade-offs & Alternatives:**
   - **What:** What the code does.
   - **How:** Execution path.
   - **Why:** Invariant satisfied.
   - **Trade-off:** Performance or complexity cost.
   - **Alternative:** 1 viable alternative considered and why rejected.
5. **Behavioral Tests:** Write tests for happy path, boundary errors, and concurrency/race conditions.
6. **Teaching Checkpoint:** Ask 1 focused concept question testing understanding.

---

## Mode B Workflow: Language & Framework Primitive Deep-Dive

When explaining a specific technical capability, keyword, or framework hook:

### 1. The Core Capability (Why does it exist?)
- What physical problem does this solve in memory, thread execution, or reactivity?
- What happens if you try to build without it? (e.g., memory leak, race condition, extra re-render, namespace pollution).

### 2. Syntax Anatomy & Signatures
Provide the exact grammatical signature with annotations:
```typescript
// Detailed breakdown of parameters, return types, and memory lifecycle
const memoizedCallback = useCallback(
  fn,     // The function definition to preserve across renders
  [deps]  // Dependency array: cache invalidates ONLY when values in this array change by reference (Object.is)
);
```

### 3. Before vs. After Code Comparison
Provide a minimal, runnable comparison:
- **❌ Without it (Naive / Broken / Flawed):** Show the exact issue (e.g., function identity changing every render causing infinite loop or broken child memoization).
- **✅ With it (Idiomatic / Correct):** Show how the primitive resolves the issue cleanly.

### 4. When to Use vs. When It's an Anti-Pattern
Clear boundary rules:
- **Use when:** The exact threshold where the primitive pays for itself.
- **Do NOT use when:** Situations where applying it is cargo-culting, slows down performance, or complicates code unnecessarily.

### 5. Modern Status (2026 Standards)
Explain how the feature evolved:
- Is it still modern best practice?
- Has a newer language feature, compiler (e.g., React 19 compiler), or standard library addition superseded it?

### 6. Quick Concept Quiz
End with 1 practical question or scenario to test whether the concept was fully internalized.

---

## Required Output Contracts

### If in Mode A (Implementation):
1. **Mental Model & Framework Machinery**
2. **Execution & Data Flow**
3. **Surgical Implementation Code**
4. **Trade-offs & Alternatives**
5. **Behavioral Tests & Verification**
6. **Teaching Checkpoint**

### If in Mode B (Primitive Deep-Dive):
1. **The Technical Capability:** What it unlocks and why creators built it.
2. **Syntax Anatomy:** Exact parameters, signatures, and runtime behavior.
3. **Before vs. After Snippets:** Broken/Naive vs. Correct/Idiomatic.
4. **When to Use vs. Anti-Patterns:** Thresholds for when it helps vs. hurts.
5. **Modern Evolution (2026):** Current best practice status.
6. **Concept Checkpoint:** 1 scenario-based question to verify mastery.
