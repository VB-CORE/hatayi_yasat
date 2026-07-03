---
name: hata-issue
description: Take a GitHub issue from VB-CORE/life_client, fetch it with gh, split it into atomic tasks, locate the right code under lib/features, build a per-task plan, and drive the fix using project conventions (delegates real scaffolding to hata-feature, deep checks to hata-architecture-review). Use when the user gives an issue number or github.com/VB-CORE/life_client/issues/<n> URL and asks to work it, e.g. "şu issue'yu al ve çöz", "bu issue'daki bug'ları düzelt", "issue 42'yi gh ile çek planını çıkar", "fix the bugs in this issue", "issue'yu projeye göre çöz".
---

# life_client Issue → Plan → Fix

Turns a GitHub issue into a worked solution **the life_client way**: fetch with
`gh`, break the body into atomic tasks, point each at the real code, then drive each
fix under [CLAUDE.md](../../../CLAUDE.md) conventions. This skill **plans and
routes**; it does not invent conventions.

Repo: `VB-CORE/life_client`. Default branch: `main`. Uses plain `gh`/`git` (no
helper scripts). Prereq: `gh auth status`.

## When to invoke
- User gives an issue number/URL and asks to work / fix / plan it.
- Trigger (TR/EN): "şu issue'yu al", "issue'daki bug'ları çöz", "issue N'i gh ile çek", "fix this issue", "plan the issue", "issue'yu projeye göre çöz".

## When NOT to invoke
- Greenfield feature with no issue → `hata-feature` directly.
- Reviewing a PR/diff → `hata-pr-review`.
- Whole-codebase structure audit → `hata-architecture-review`.

## Step 1 — Fetch + decompose the issue
```bash
gh issue view <n> --repo VB-CORE/life_client --json title,body,labels,comments
# a pasted URL also works:
gh issue view https://github.com/VB-CORE/life_client/issues/<n> --json title,body,labels
```
Split the body into **atomic tasks**:
- If the body has `- [ ]` / `- [x]` checkboxes, each is a task (note done state).
- Otherwise split on numbered/bulleted items; if it is one paragraph, treat it as a single task.
- For each task record: a one-line summary, any attachment URLs (usually bug screen-recordings — you **cannot** view these; flag them), and the keywords/nouns to grep.

Present a short task table to the user before touching code.

## Step 2 — Locate the real code
For the chosen task:
1. Grep `lib/features/` (and `lib/product/`) for the symptom — a label, a button text, a viewmodel/state name.
2. **TR UI strings are rarely hardcoded** — search the locale keys (`assets/translations/{tr,en}.json`, `locale_keys.g.dart`) for the Turkish phrase, then grep the resulting key in widgets. Mind smart quotes (`"` `"`) and Turkish chars.
3. Confirm the exact file (view / viewmodel / state / model) before editing. Most issue tasks are bugs in **one** existing file, not new features.

## Step 3 — Plan per task (before editing)
- The task (one line) + the file(s) it touches.
- Root-cause hypothesis (e.g. "button enables at 9 digits because the validator checks `>= 9` not `== 10`").
- The fix in project terms (which viewmodel/state/widget changes, which CLAUDE.md rule applies).
- Whether it's a one-liner (edit directly) or needs scaffolding (route through `hata-feature`).

## Step 4 — Drive the fix
- **Bug in an existing file** (the common case): edit directly, honoring CLAUDE.md (`state = copyWith`, tokens, no `GetIt.I` in view, `LocaleKeys.tr`). Do **not** scaffold a new feature.
- **Needs new viewmodel/state/view/service**: hand off to [hata-feature](../hata-feature/SKILL.md) and follow its 5-phase plan.
- Keep unrelated tasks as **separate commits** — one issue is often a batch of unrelated bugs.

## Step 5 — Quality gate
```bash
dart analyze lib/features/<touched-feature>
dart format lib/features/<touched-feature>
flutter pub run build_runner build --delete-conflicting-outputs   # only if a generated file changed
```
Optionally self-review the diff with `hata-pr-review` before handing back.

## Step 6 — Report back (ask before pushing to GitHub)
```bash
gh issue view <n> --repo VB-CORE/life_client          # re-read current state
gh issue comment <n> --repo VB-CORE/life_client --body "Task N fixed in <branch>"
```

## Output contract
- A task table at the start.
- Per task worked: file(s) touched (clickable links) + one-line root cause.
- What still needs manual verification (the bug videos can't be watched here).
- Branch suggestion: `feature/#<n>` (or `fix/#<n>`).

## Gotchas
- **Attachment videos can't be viewed** — plan from text + code only; tell the user which tasks hinge on a video you couldn't see.
- **One issue ≠ one fix** — a batch issue is many unrelated bugs; work them as separate tasks/commits, don't try to "solve the issue" in one edit.
- **TR text + smart quotes** — search locale keys, not the literal Turkish phrase in widgets.
- **No `- [ ]` checkboxes** → read the whole body and treat it as one (or a few) task(s).

## Troubleshooting
| Symptom | Fix |
|---|---|
| `gh ... HTTP 404` | Wrong repo or not authed. `gh auth status`; pass `--repo VB-CORE/life_client`. |
| Can't find the code for a task | Grep the summary nouns under `lib/features/`; for UI text, go via `assets/translations` keys. |
