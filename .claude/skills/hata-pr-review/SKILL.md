---
name: hata-pr-review
description: Review a life_client change set (working diff, a branch vs main, or a GitHub PR) against the project's CLAUDE.md conventions, then produce one severity-ranked review with file:line findings and concrete fixes. Combines a static-analysis pass, a styling/token pass, and an architecture-conformance pass delegated to the hata-architecture-reviewer agent. Use when the user asks to review changes/a diff/a PR before merge, e.g. "bu PR'ı incele", "şu diff'i projeye göre review et", "pr review yap", "merge'e hazır mı", "review my changes against conventions".
---

# life_client PR Review

Single entry point for reviewing a change set in this repo against
[CLAUDE.md](../../../CLAUDE.md). It **reviews, it does not fix** — only apply fixes
if the user explicitly asks afterward (then route through `hata-feature`).

Repo: `VB-CORE/life_client`. Default branch: `main`.

## When to invoke
- "Review this PR / diff / branch", "merge'e hazır mı".
- Trigger (TR/EN): "bu PR'ı incele", "şu diff'i review et", "pr review yap", "review my changes against conventions", "code review this branch".

## When NOT to invoke
- Building/scaffolding a feature → `hata-feature`.
- Working a GitHub issue end-to-end → `hata-issue`.
- Auditing whole-codebase structure (not a diff) → `hata-architecture-review`.

## Inputs (resolve the review target first, in order)
1. **Explicit PR** — number or `github.com/VB-CORE/life_client/pull/<n>` → `gh pr diff <n>` (+ `gh pr view <n>` for context/description).
2. **Branch** — user names a branch → `git diff main...<branch>`.
3. **Default** — no target → working set: `git diff` + `git diff --staged`, falling back to `git diff main...HEAD` if the tree is clean.

Review **only changed lines + the files they touch**. Never audit the whole repo. If the diff is empty, say so and stop. Prereq for PR mode: `gh auth status`.

## Passes (merge into one ranked list)

### Pass A — Static analysis (run first, in parallel)
```bash
dart analyze <changed dirs>
dart format --output=none --set-exit-if-changed <changed .dart files>
```
Surface every analyzer error/warning + format drift. Non-negotiable.

### Pass B — Architecture conformance (delegate)
Hand the changed file list + the diff to the
[hata-architecture-reviewer](../../agents/hata-architecture-reviewer.md) agent so
it reviews changed lines (not the whole tree): `@riverpod`+Notifier, `state =
copyWith`, Equatable `props`/`copyWith`, DI mixins, `GetIt.I`-in-view, no-Freezed,
view conventions, typed routes, structure.

### Pass C — Styling & token rules (grep the diff, confirm in context)
| Anti-pattern | Required fix |
|---|---|
| `EdgeInsets.all/symmetric/only(` | `PagePadding.*` |
| hardcoded pixel in `SizedBox` / `BorderRadius.circular(<int>)` | `EmptyBox`/`VerticalSpace` / `CustomRadius.*` |
| `Color(0x..)` / `Colors.<name>` / `Theme.of(context)` (in a view) | `context.general.colorScheme.*` / `ColorsCustom` |
| raw `Text(...,style: TextStyle(...))` | semantic title widget |
| hardcoded UI string | `LocaleKeys.*.tr()` |
| `GetIt.I` in a view | `ProjectDependencyMixin` / `AppProviderMixin` |
| `@freezed` / `with _$X` | Equatable + manual `copyWith` |
| `extends StatefulWidget` (not Consumer) | `ConsumerStatefulWidget` |

Fast first sweep:
```bash
git diff main...HEAD -- '*.dart' | grep -nE \
  'EdgeInsets\.(all|symmetric|only)|Colors\.|Color\(0x|Theme\.of\(context\)|BorderRadius\.circular\(|GetIt\.I|@freezed|extends StatefulWidget' \
  || echo "no obvious token violations"
```
Grep is a smell test — a `Color(0x..)` inside a theme/`ColorsCustom` file is allowed; inside a view it is a blocker.

## Severity rubric
- **error (blocker)** — analyzer error, or a CLAUDE.md rule break (hardcoded color/EdgeInsets in view, `GetIt.I` in view, Freezed, direct VM mutation, plain `StatefulWidget`, field missing from `props`/`copyWith`, `mounted` not checked after an `await` touching context).
- **warning** — convention deviation worth fixing now (logic in view, 50+ line widget not decomposed, missing `copyWith`, hardcoded string).
- **info** — nits (naming, redundant import, missing `const`, double quotes).

## Output contract (one consolidated review, no preamble)
```
## PR review: <target> — <N blocker, N warning, N info>

### 🔴 Blockers
- [<file>:<line>](<file>#L<line>) — <what & which rule>. Fix: <concrete fix>.

### 🟡 Warnings
- [<file>:<line>](<file>#L<line>) — <issue>. Fix: <concrete fix>.

### 🔵 Suggestions
- [<file>:<line>](<file>#L<line>) — <nit>.

### ✅ Looks good
- <1–3 things done right, so the author keeps them>.

### Verdict
**<APPROVE | CHANGES REQUESTED>** — <one sentence>. <blocker count> must-fix.
```
Rules: every finding cites a real `file:line` (no line → not a finding); concrete fixes (name the replacement); `CHANGES REQUESTED` if ≥1 blocker else `APPROVE`; de-dup across passes (report once at highest severity); omit empty sections but keep **Verdict**; never modify files unless asked.

## Posting back (only if the user asks)
`gh pr review <n> --comment --body-file <tmp>` (or `--request-changes` when there are blockers). Never post without being asked.
