---
name: ui-ux
description: Use when designing user interfaces, creating frontend components, selecting color palettes, typography, layout systems, or conducting UI/UX and accessibility reviews.
---

# UI/UX Design System and Interface Engineering

## Mission

Build professional, accessible, conversion-optimized, and aesthetically polished user interfaces on the first attempt. Translate product requirements into cohesive design tokens, responsive component hierarchies, and resilient interaction patterns without relying on generic placeholders or external generators.

---

## Activation

### Use when:
- Designing a new web application, mobile interface, landing page, or dashboard.
- Building, restyling, or refactoring UI components in React, Next.js, Vue, Svelte, HTML/CSS, or Tailwind.
- Selecting cohesive color palettes, typography pairings, or design tokens.
- Reviewing an existing interface for accessibility, responsive layout bugs, visual hierarchy, or UX anti-patterns.
- Establishing a project design system or theme configuration (`tailwind.config.js`, `tokens.css`).

### Do not use it:
- For backend-only architecture, database design, or API protocol choices (use `/arch-roast` or `/innovate`).
- To produce vague, generic advice without concrete tokens, CSS/Tailwind specs, or component markup.
- To guess arbitrary hex codes without checking WCAG AA contrast ratios.

---

## Operating Principles

1. **Self-Sufficiency:** Deliver concrete, copy-pasteable design tokens, Tailwind configs, and component code directly—never prompt the user to install unneeded external CLIs or Python design generators.
2. **Accessibility (a11y) is Non-Negotiable:** All text and critical UI elements must meet WCAG 2.1 AA standards (minimum 4.5:1 contrast for normal text, 3:1 for large text and interactive components).
3. **No Emoji Icons:** Never use emojis as functional UI icons (e.g., 🔍, ⚙️, ❌). Always specify standard SVG icons (Lucide, Heroicons, Phosphor, or SF Symbols).
4. **Motion with Purpose:** Transitions must be subtle (150ms–300ms) with `ease-out` or `ease-in-out`. Animate only `transform` and `opacity` to avoid layout thrashing. Always respect `prefers-reduced-motion`.
5. **Predictable Layout Hierarchy:** Every screen must have a clear visual hierarchy: one primary focal point (H1/Primary CTA), scannable groupings, and consistent vertical rhythm based on a 4px/8px grid.

---

## 1. Visual Style Archetypes

Select the archetype that matches the product category and audience:

| Style Archetype | Best For | Visual Recipe | Border & Radius | Shadows & Elevation |
| :--- | :--- | :--- | :--- | :--- |
| **Bento Grid** | SaaS dashboards, feature showcases, modern portfolios | Modular compartmentalized cards, varying aspect ratios, high scannability | `rounded-2xl` (16px), `border border-border/40` | `shadow-sm hover:shadow-md transition-shadow` |
| **Glassmorphism** | Modern dark-mode SaaS, web3, AI tools, overlays | Frosted translucent cards, background blur, subtle gradient borders | `rounded-xl`, `border border-white/10` | `backdrop-blur-md bg-white/5 shadow-2xl` |
| **Functional Minimal** | B2B software, developer tools, documentation, productivity | Clean monochrome base, tight typography, zero decorative distraction, high contrast | `rounded-md` (6px), `border border-zinc-200 dark:border-zinc-800` | Subtle 1px borders, minimal shadow (`shadow-xs`) |
| **Editorial / Luxury** | High-end fashion, luxury e-commerce, architecture, long-form content | High-contrast serif headlines, generous whitespace, warm muted neutrals, photography-forward | `rounded-none` or `rounded-sm`, hairline borders | Flat elevation, depth created through whitespace and scale |
| **Data-Dense / DevTools** | Analytics platforms, IDEs, trading terminals, admin panels | Compact padding, monospaced tabular figures, collapsible sidebars, muted borders | `rounded-sm` (4px), tight borders (`border-zinc-700/50`) | Zero shadows; depth through contrasting surface shades |
| **Soft UI (Modern)** | Healthcare, wellness, education, lifestyle mobile apps | Warm pastel tints, organic rounded corners, pill badges, friendly geometric sans | `rounded-3xl` (24px) or `rounded-full`, soft border | Soft diffused shadows (`0 10px 30px -10px rgba(0,0,0,0.05)`) |

---

## 2. Curated Typography Pairings

| Mood / Stack | Heading Font | Body Font | Google Fonts Import | Best For |
| :--- | :--- | :--- | :--- | :--- |
| **Modern Tech / Universal** | `Inter` (700) | `Inter` (400, 500) | `family=Inter:wght@400;500;600;700` | SaaS, general web apps, dashboards |
| **Punchy & Crisp** | `Plus Jakarta Sans` (700) | `Inter` or `Plus Jakarta Sans` | `family=Plus+Jakarta+Sans:wght@500;600;700;800` | Modern startups, mobile apps, fintech |
| **Technical / Developer** | `Space Grotesk` (600) | `JetBrains Mono` / `Inter` | `family=Space+Grotesk:wght@500;700&family=JetBrains+Mono:wght@400;500` | Developer tools, APIs, infrastructure, web3 |
| **Elegant / Luxury** | `Cormorant Garamond` (600) | `Montserrat` (400) | `family=Cormorant+Garamond:wght@600;700&family=Montserrat:wght@400;500` | Luxury e-commerce, hospitality, wellness |
| **Authoritative / Editorial** | `Newsreader` or `Playfair Display` | `Source Sans 3` | `family=Playfair+Display:wght@600;700&family=Source+Sans+3:wght@400;600` | Publishing, finance analysis, legal, essays |

---

## 3. Curated Industry Color Palettes

All palettes are verified for WCAG AA compliance (4.5:1 text contrast on surfaces):

| Industry | Primary | Secondary / Accent | CTA / Highlight | Background (Light / Dark) | Surface | Contrast Target |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **B2B SaaS / Enterprise** | `#2563EB` (Royal Blue) | `#4F46E5` (Indigo) | `#0284C7` (Sky) | `#F8FAFC` / `#0F172A` | `#FFFFFF` / `#1E293B` | `4.5:1+` |
| **Fintech / Banking** | `#0F172A` (Navy/Slate) | `#0D9488` (Teal) | `#059669` (Emerald) | `#F8FAFC` / `#0B0F19` | `#FFFFFF` / `#151E32` | `7:1+` (High trust) |
| **Healthcare / HealthTech** | `#0284C7` (Clean Blue) | `#14B8A6` (Mint Teal) | `#0369A1` (Deep Cerulean) | `#F0FDFA` / `#042F2E` | `#FFFFFF` / `#115E59` | `4.5:1+` (Calming) |
| **Developer Tools / Infra** | `#18181B` (Zinc Dark) | `#6366F1` (Indigo) | `#22C55E` (Terminal Green) | `#09090B` / `#09090B` | `#18181B` / `#27272A` | `5:1+` (Monokai-safe) |
| **Luxury / High-End** | `#1C1917` (Stone Black) | `#D97706` (Muted Gold) | `#78350F` (Amber Bronze) | `#FAF8F5` / `#1C1917` | `#FFFFFF` / `#292524` | `4.5:1+` |
| **Consumer / Social** | `#7C3AED` (Violet) | `#EC4899` (Pink) | `#F97316` (Warm Coral) | `#FAFAFA` / `#18181B` | `#FFFFFF` / `#27272A` | `4.5:1+` (Vibrant) |

---

## 4. Industry-Specific Anti-Patterns

| Industry | Critical Anti-Patterns to Avoid |
| :--- | :--- |
| **Fintech / Banking** | ❌ Neon colors or rainbow gradients (destroys trust). ❌ Rounded playful fonts. ❌ Gamified celebratory popups on serious money transactions. ❌ Missing clear currency formatting and decimal alignment. |
| **Healthcare / Medical** | ❌ Pure red as a primary brand or CTA color (signifies medical emergency/danger). ❌ Low-contrast light gray text on clinical data. ❌ Pure black dark mode on medical reading views. |
| **Developer Tools** | ❌ Excessively slow decorative animations (>300ms). ❌ Low-density whitespace that forces excessive scrolling. ❌ Non-monospace font for code, keys, hashes, or logs. ❌ Missing one-click copy buttons on code blocks. |
| **E-Commerce / Retail** | ❌ Cluttered multiple competing CTAs on product cards. ❌ Low-contrast pricing text. ❌ Unresponsive image aspect ratios causing layout shifts (CLS). |

---

## 5. Universal Pre-Delivery & Accessibility Checklist

Before delivering any UI component or page layout, verify against these gates:

### Accessibility (a11y)
- [ ] **Contrast:** Minimum 4.5:1 for body text; 3:1 for large headers and interactive icons against their background.
- [ ] **Interactive Elements:** `cursor: pointer` on all buttons, links, and clickable cards.
- [ ] **Icon Accessibility:** No emoji icons. Icon-only buttons must have `aria-label` or `sr-only` text.
- [ ] **Keyboard Navigation:** Visible focus ring on focus (`focus-visible:ring-2 focus-visible:ring-offset-2`).
- [ ] **Reduced Motion:** Wrap keyframe animations with `@media (prefers-reduced-motion: no-preference)` or use Tailwind `motion-safe:`.

### Responsiveness & Layout
- [ ] **Mobile Breakpoint (375px):** No horizontal overflow or cut-off text. Touch targets are at least 44x44px.
- [ ] **Tablet Breakpoint (768px):** Clean multi-column folding (e.g., 3-column to 1- or 2-column).
- [ ] **Desktop Breakpoint (1024px / 1280px):** Max container width bounded (`max-w-7xl mx-auto px-4 sm:px-6 lg:px-8`).

### States & Polish
- [ ] **Four Essential States Handled:** Loading (skeleton/spinner), Empty (friendly illustration/guidance), Error (actionable message), and Hover/Active (smooth 150-200ms transition).
- [ ] **Zero Layout Shift (CLS):** Images and avatars have explicit `width` and `height` or aspect-ratio boxes.

---

## 6. Rationalization Counters & Red Flags

| Rationalization (Excuse) | Reality & Counter |
| :--- | :--- |
| *"I'll use an emoji as the icon because it saves importing an SVG"* | **Red flag.** Emojis render inconsistently across Windows, macOS, Android, and iOS, break screen readers, and look unprofessional. Always specify clean SVGs (Lucide / Heroicons). |
| *"Contrast ratio of 3.2:1 is close enough to 4.5:1"* | **Red flag.** It fails WCAG AA automated compliance audits and causes eye strain. Darken the text or lighten the background until contrast exceeds 4.5:1. |
| *"I'll use trendy purple/pink AI gradients on this finance dashboard"* | **Red flag.** Neon AI gradients destroy financial credibility. Use slate, deep navy, or emerald. |
| *"I'll add heavy floating animations to make it look interactive"* | **Red flag.** Unnecessary motion slows users down, drains CPU, and triggers vestibular disorders. Animate only on direct user interaction. |

---

## Required Output Format

When generating or reviewing a UI design system or component, structure your output into these 4 sections:

### 1. Design Archetype & Strategy
- Selected Archetype (e.g., Bento Grid, Functional Minimal).
- Target audience & industry category.
- Primary visual decision rationale.

### 2. Design Tokens Spec
- **Color Palette:** Primary, Secondary, Accent, Background, Surface, Border, Text (with exact Hex values and contrast confirmation).
- **Typography:** Heading font, Body font, Google Fonts URL, font-family CSS stack.
- **Elevation & Radius:** Spacing scale, border radius, shadow definitions.

### 3. Implementation Code
- Self-contained, production-ready component code (React/Tailwind, Vue, or clean HTML/CSS).
- Includes hover, active, focus-visible, and responsive states.
- Clean semantic markup with SVG icons.

### 4. Pre-Delivery Audit
- **Accessibility verification:** Contrast ratio confirmation and aria labels.
- **Responsive verification:** Mobile (375px) vs Desktop behavior.
- **Industry anti-patterns explicitly avoided.**
