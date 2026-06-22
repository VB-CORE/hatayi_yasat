---
name: hata-architecture-review
description: Audit the overall architecture & convention health of the life_client codebase (the whole repo or a given feature/folder) against CLAUDE.md — Riverpod @riverpod ViewModel pattern, Equatable+copyWith state, DI via mixins, view conventions, go_router typed routes, styling tokens, structure/naming. Runs static analysis, delegates a deep pass to the hata-architecture-reviewer agent, and produces one severity-ranked report. Use when the user asks to check the architecture, e.g. "mimariyi kontrol et", "proje konvansiyonlarına uyuyor mu", "şu feature mimariye uygun mu", "architecture review".
---

# life_client Architecture Review

Audits a **part of the codebase for conformance to project conventions**
([CLAUDE.md](../../../CLAUDE.md)). Unlike `hata-pr-review` (which reviews a *diff*),
this reviews **structure** — an existing feature or the whole `lib/` tree. It
**reports**, it does not fix.

## When to invoke
- "Mimariyi kontrol et", "proje konvansiyonlarına uyuyor mu", "şu feature uygun mu", "architecture review", "tech-debt audit".

## When NOT to invoke
- Reviewing a PR/diff before merge → `hata-pr-review`.
- Building a feature → `hata-feature`.
- UI token lookup → `hata-style-guide`.

## Inputs (resolve the scope first)
1. **Feature/folder named** → review just that (e.g. `lib/features/main/home`).
2. **No scope given** → ask whether to audit a specific feature or the whole `lib/` (whole-repo is large; prefer scoping). Default to the feature(s) most relevant to the user's recent work.

## Passes (merge into one ranked list)

### Pass A — Static analysis (run first, in parallel)
```bash
dart analyze <scope>
dart format --output=none --set-exit-if-changed <scope>
```
Surface every analyzer error/warning as a finding (non-negotiable).

### Pass B — Deep conformance (delegate)
Hand the file list (and, for a feature, its full contents) to the
[hata-architecture-reviewer](../../agents/hata-architecture-reviewer.md) agent. It
checks the `@riverpod`+Notifier pattern, `state = copyWith` mutation, Equatable
`props`/`copyWith` completeness, `ProjectDependencyMixin`/`AppProviderMixin` DI,
`GetIt.I`-in-view, no-Freezed, view conventions, typed routes, folder/naming, and
returns severity-ranked findings.

### Pass C — Token/style sweep (grep, confirm in context)
```bash
grep -rnE 'EdgeInsets\.(all|symmetric|only)|Colors\.|Color\(0x|Theme\.of\(context\)|BorderRadius\.circular\(|GetIt\.I|@freezed|extends StatefulWidget' <scope> --include='*.dart' \
  | grep -vE '\.g\.dart|\.freezed\.dart' || echo "no obvious violations"
```
A hit is a smell, not proof — a `Color(0x..)` in a theme/`ColorsCustom` file is allowed; in a view it is a blocker. Also flag hardcoded UI strings that should be `LocaleKeys.*.tr()`.

## Severity rubric
Same as the reviewer agent: **error** (CLAUDE.md rule break — `GetIt.I` in view, Freezed, direct VM mutation, hardcoded color/EdgeInsets in view, plain `StatefulWidget`, field missing from `props`/`copyWith`), **warning** (logic in view, no decomposition, raw `Text`+`TextStyle`, hardcoded string, wrong structure), **info** (nits).

## Output contract
```
## Architecture review: <scope> — <N blocker, N warning, N info>

### 🔴 Blockers
- [<file>:<line>](<file>#L<line>) — <what & CLAUDE.md section>. Fix: <concrete fix>.

### 🟡 Warnings
- [<file>:<line>](<file>#L<line>) — <issue>. Fix: <concrete fix>.

### 🔵 Suggestions
- [<file>:<line>](<file>#L<line>) — <nit>.

### ✅ Conforms
- <what the code already does right>.

### Verdict
**<HEALTHY | NEEDS WORK>** — <one sentence>. <blocker count> must-fix.
```
Rules: every finding cites a real `file:line`; concrete fixes; de-dup across passes (report once at highest severity); omit empty sections but keep **Verdict**. Do not edit files unless the user explicitly asks afterward (then route fixes through `hata-feature`).
