# My Agent Skills 🚀

A curated, version-controlled collection of personal engineering and design skills for Antigravity / Gemini CLI agents.

This repository allows you to sync your custom skills, workflows, and guidelines across multiple machines with zero manual setup.

---

## 📦 Included Skills

| Skill | Trigger / When to Use | Description |
| :--- | :--- | :--- |
| **`ui-ux`** | `/ui-ux`, design interfaces, landing pages, styles, palettes | Professional UI/UX engineering, visual archetypes, font pairings, WCAG AA compliance, and design tokens. |
| **`arch-roast`** | `/arch-roast`, review architecture, diff check | Evidence-based engineering review for correctness, reliability, performance, and failure modes. |
| **`code-why`** | `/code-why`, explain logic, document decisions | Explains the underlying rationale, trade-offs, and invariants behind code choices. |
| **`innovate`** | Brainstorm alternatives, redesign, 10x ideas | Proposes high-leverage technical and product alternatives with risk/benefit analysis. |
| **`prod-gate`** | `/prod-gate`, pre-release checklist, launch prep | Pre-deployment gate checking reliability, monitoring, security, rollback, and data integrity. |
| **`skill-evolve`** | Retrospective, review learning, refine skills | Turns post-mortems and debugging sessions into durable, updated skill improvements. |
| **`debug-error`** | `/debug-error`, investigate failures, regressions, and incidents | Reproduces failures, tests hypotheses, traces root causes, and verifies minimal fixes. |
| **`pro-implementation`** | `/pro-implementation`, implement features or refactors | Delivers scoped, maintainable changes with security, failure handling, and test verification. |

---

## ⚡ 1-Step Setup on Any Machine

### Windows (PowerShell)
```powershell
git clone https://github.com/<your-username>/My_Agent_Skills.git
cd My_Agent_Skills
powershell -ExecutionPolicy Bypass -File .\scripts\sync.ps1
```

### Linux / macOS (Bash)
```bash
git clone https://github.com/<mayur777-ui>/My_Agent_Skills.git
cd My_Agent_Skills
chmod +x ./scripts/sync.sh
./scripts/sync.sh
```

The script automatically registers this folder in your global Antigravity config (`~/.gemini/config/skills.json`).

---

## 🛠️ How to Add or Customize Skills

1. Create a new folder under `skills/<skill-name>/`.
2. Add a `SKILL.md` with frontmatter:
   ```markdown
   ---
   name: my-skill
   description: When to trigger this skill and what it does.
   ---
   # My Skill Workflow
   ...
   ```
3. Commit and push:
   ```bash
   git add .
   git commit -m "Add my-skill"
   git push
   ```
4. On any other machine, run `git pull` and the new skill is immediately available!
