---
name: hata-feature
description: End-to-end scaffold for a new life_client Flutter feature following project conventions from CLAUDE.md — Riverpod @riverpod ViewModel + Equatable state (no Freezed), ConsumerStatefulWidget view + mixin, ProjectDependencyMixin/AppProviderMixin DI, go_router typed routes, and the styling token rules (PagePadding, EmptyBox, CustomRadius, ColorsCustom, context.general.colorScheme, GeneralButtonV2, LocaleKeys.tr). Use when the user asks to add or refactor a feature, e.g. "yeni feature ekleyelim", "şu sayfayı projeye göre yaz", "viewmodel + state + view kur", "scaffold a new feature under lib/features".
---

# life_client Feature Scaffold

Single workflow for building a feature in this repo, enforcing the conventions in
[CLAUDE.md](../../../CLAUDE.md). This skill is **convention-enforcing**, not
exploratory — if the user asks "what is X", point them to CLAUDE.md. Only run when
there is real scaffolding/refactoring to do.

> All rules (architecture, state, DI, styling, l10n) live in CLAUDE.md and are not
> repeated here. Every generated file must satisfy them or the lints reject it.

## When to invoke
- Add a new feature under `lib/features/<feature>/` (or `lib/features/sub_feature/<feature>/`).
- Refactor an existing feature to match conventions.
- "scaffold viewmodel + state + view + (service) for X".
- Trigger (TR/EN): "yeni feature ekleyelim", "şu sayfayı projeye göre yaz",
  "viewmodel + state + view kur", "feature iskeleti çıkar", "scaffold a feature".

## When NOT to invoke
- Pure UI/token question → `hata-style-guide`.
- Reviewing changes → `hata-pr-review` / `hata-architecture-review`.
- Working a GitHub issue end-to-end → `hata-issue`.
- A one-line bug fix in an existing file → just edit it; don't scaffold.

## Inputs (ask once, up front, if missing)
1. **Feature name** (snake_case, e.g. `chain_store`, `withdraw`).
2. **Parent group** — top-level `lib/features/<name>/` or `lib/features/sub_feature/<name>/`. Default: top-level.
3. **Backend?** — does it read/write Firestore? If yes we add model + queries via `firebaseService`; if no, omit.
4. **Responsive?** — any per-size variants. Default: standard.

If the user already answered in prose, do not re-ask.

## Execution plan (5 phases, stop after each)

### Phase 1 — Plan
1. Confirm the 4 inputs.
2. Lay out the directory:
   ```
   lib/features/<feature>/
   ├── provider/
   │   ├── <feature>_view_model.dart
   │   ├── <feature>_view_model.g.dart   # generated
   │   └── <feature>_state.dart
   └── view/
       ├── <feature>_view.dart
       ├── mixin/ <feature>_view_mixin.dart   # if initState/dispose logic needed
       └── widget/                            # if 3+ private widgets
   ```
3. Identify reusable widgets in [lib/product/widget/](../../../lib/product/widget/) to consume instead of re-implementing (buttons, cards, shimmer, inputs, titles).
4. Output the plan before writing code.

### Phase 2 — Data layer (skip if no backend)
- Model: `*_model.dart` with `json_serializable` (or reuse a `life_shared` model). For non-trivial JSON delegate to the `flutter-network-generator` / `flutter-implement` skill if available.
- Reads/writes go through `firebaseService` (from `ProjectDependencyMixin`) — build `Query`/`CollectionReference` in the ViewModel, as in [home_view_model.dart](../../../lib/features/main/home/provider/home_view_model.dart).
- Run codegen (Phase 5).

### Phase 3 — State + ViewModel
1. **State** (`<feature>_state.dart`): `final class XState extends Equatable`, all fields `final` with defaults, full `props`, manual `copyWith`. Include explicit `isFetching`/`isError` flags for async. Pattern: [home_state.dart](../../../lib/features/main/home/provider/home_state.dart).
2. **ViewModel** (`<feature>_view_model.dart`): `@riverpod final class XViewModel extends _$XViewModel with ProjectDependencyMixin`, `build()` returns initial state, methods mutate via `state = state.copyWith(...)`. Pattern: [place_detail_view_model.dart](../../../lib/features/details/view_model/place_detail_view_model.dart).
3. Never swallow exceptions — set `isError: true`. Never assign VM fields directly.

### Phase 4 — Presentation
1. **View** (`<feature>_view.dart`): `ConsumerStatefulWidget`; state mixes `AppProviderMixin<XView>` + feature mixin. `ref.watch(xViewModelProvider)`; conditional render error → shimmer → content.
2. **Mixin**: owns `initState`/`dispose`/side effects.
3. **Styling**: `context.general.colorScheme.*`, `PagePadding.*`, `EmptyBox.*`/`VerticalSpace.*`, `CustomRadius.*`, `GeneralButtonV2`, semantic title widgets — never raw `EdgeInsets`/hex/`Text`+`TextStyle`. All strings via `LocaleKeys.*.tr()`.
4. **Routing**: if a route is needed, add a `@TypedGoRoute` entry in [app_router.dart](../../../lib/product/navigation/app_router.dart) and run codegen.

### Phase 5 — Quality gate (run in parallel)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
dart analyze lib/features/<feature>
dart format lib/features/<feature>
```
If translations were added, run the `lang` script. Add unit/widget tests for non-trivial logic if the project has a test setup.

## Anti-patterns (auto-reject — fix before output)
- `@freezed` / `with _$X` / `.freezed.dart` — this repo uses Equatable + copyWith.
- Direct VM field mutation or `setState` for VM state instead of `state = state.copyWith(...)`.
- `GetIt.I` inside a view file (use the mixins).
- Plain `StatefulWidget` instead of `ConsumerStatefulWidget`.
- `Color(0x..)` / `Colors.<name>` / `Theme.of(context)` in a view.
- Raw `EdgeInsets.*` / hardcoded pixels / `BorderRadius.circular(<int>)`.
- Hardcoded UI strings (use `LocaleKeys.*.tr()`).
- Field missing from `props` or `copyWith`.
- Narration / section-divider comments.

## Output contract
- One sentence per file created/modified, with clickable links: `[x_view_model.dart](lib/features/<feature>/provider/x_view_model.dart)`.
- One line on the next manual step (run codegen, register route, add translations).
- One line on tests still needed, if any. Nothing else.
