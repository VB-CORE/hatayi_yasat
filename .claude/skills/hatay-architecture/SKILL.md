---
name: hatay-architecture
description: Hatayı Yaşat (lifeclient) Flutter app architecture, theming, and clean-code conventions. Use when adding/refactoring features, creating views, view-models, states, models, product-level widgets, or any UI work — enforces feature-folder layout, Riverpod codegen pattern, `part of` widget composition, Equatable state, and the V2 mozaik theme rules (all colors come from `Theme`/`ColorScheme`, never hardcoded).
---

# Hatayı Yaşat — Project Architecture & Style Skill

Architectural rules and clean-code conventions for the `lifeclient` Flutter
codebase. Apply these whenever you create, move, or refactor Dart files
inside `lib/`.

## When to Use

Trigger on:
- "yeni feature ekle", "add a new screen/view/feature"
- "view model oluştur", "create a provider/state"
- "widget'ı ayır", "split this widget", "refactor view"
- "model ekle", "create a model class"
- "renk", "tema", "color", "theme", "dark mode" — anything style-related
- Adding routes, mixins, or product-level shared widgets
- Anything that touches `lib/features/`, `lib/product/`, `lib/sub_feature/`, `lib/core/`

## Top-level Directory Map

```
lib/
├── core/                  # App-wide bootstrapping & DI (no UI here)
│   ├── dependency/        # ProjectDependencyItems + ProjectDependencyMixin
│   ├── init/              # Localization init, etc.
│   └── service/           # Permission/location/etc. services
├── features/              # User-facing feature modules
│   └── <feature>/
│       ├── view/
│       │   ├── <feature>_view.dart       (entry widget — declares `part`s)
│       │   ├── widget/<piece>.dart       (private `part of` sub-widgets)
│       │   └── mixin/<feature>_view_mixin.dart
│       └── provider/
│           ├── <feature>_view_model.dart
│           ├── <feature>_view_model.g.dart
│           └── <feature>_state.dart
├── sub_feature/           # Cross-cutting flows (search, notifications, etc.)
├── product/               # Reusable shared layer (no business logic per feature)
│   ├── feature/           # Cache, repository wrappers
│   ├── init/              # ApplicationTheme, V2Typography, firebase init, locale
│   ├── model/             # Product-level models, enums, search models
│   ├── navigation/        # GoRouter routes
│   ├── package/           # Package wrappers (firebase, etc.)
│   ├── utility/           # constants, decorations (ColorsCustom, PagePadding…)
│   └── widget/            # Shared widgets (button, card, sheet, sliver, ...)
└── main.dart              # entrypoint
```

**Layering Rules:**
- A `features/<feature>/` folder must NOT import from another feature directly. Cross-feature use goes through `product/` or `sub_feature/`.
- `product/` layer must NOT import from `features/`.
- `core/` must NOT import from `features/` or `product/widget/`.

## The `part of` Composition Pattern (core convention)

Views are split into private sub-widgets via Dart's `part`/`part of` directives.
This keeps imports in one place, lets sub-widgets use private (`_Foo`) names,
and groups visual building blocks with their parent view.

### Rules

1. The **entry view file** owns every import and declares each `part`:
   ```dart
   // lib/features/main/home/view/home_view.dart
   import 'package:flutter/material.dart';
   import 'package:flutter_riverpod/flutter_riverpod.dart';
   // ...all imports live here

   part 'widget/home_categories_area.dart';
   part 'widget/home_place_area.dart';
   part 'widget/home_sort_grid_view.dart';

   final class HomeView extends ConsumerStatefulWidget { ... }
   ```

2. Each **sub-widget file** has a single `part of` line — no imports allowed:
   ```dart
   // lib/features/main/home/view/widget/home_categories_area.dart
   part of '../home_view.dart';

   final class _HomeCategoryCards extends ConsumerWidget { ... }
   final class _CategoryCard extends StatelessWidget { ... }
   ```

3. Sub-widgets used **only by one view** are `_Private` and live under
   `view/widget/` as `part of` files.

4. Sub-widgets reused across features are public, live under
   `lib/product/widget/<group>/`, and use **regular imports**, not `part`.

5. The same `part` mechanism is also used for **codegen siblings**:
   - `xxx_view_model.dart` → `part 'xxx_view_model.g.dart';`
   - `xxx_model.dart` → `part 'xxx_model.g.dart';`

### Anti-patterns

- Adding `import` lines inside a `part of` file (forbidden by Dart).
- Making every sub-widget a public top-level class — use `_Private` + `part of`.
- Putting business logic / Firebase calls inside a `part of` widget; that
  belongs in the ViewModel.

## Feature Module Template

When adding a new feature `foo`:

```
lib/features/<area>/foo/
├── view/
│   ├── foo_view.dart
│   ├── widget/
│   │   └── foo_header.dart      # part of '../foo_view.dart'
│   └── mixin/
│       └── foo_view_mixin.dart  # optional, for lifecycle/listener glue
└── provider/
    ├── foo_view_model.dart
    ├── foo_view_model.g.dart    # generated
    └── foo_state.dart
```

### `foo_state.dart`

- `final class FooState extends Equatable`
- All fields are `final`.
- `const` constructor with sensible defaults.
- `copyWith({...})` returning a new instance.
- Override `props` with every field.

```dart
final class FooState extends Equatable {
  const FooState({
    this.items = const [],
    this.isLoading = false,
  });

  final List<FooItem> items;
  final bool isLoading;

  @override
  List<Object?> get props => [items, isLoading];

  FooState copyWith({List<FooItem>? items, bool? isLoading}) {
    return FooState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
```

### `foo_view_model.dart`

- Riverpod codegen: `@riverpod` annotation, `part 'foo_view_model.g.dart';`
- `final class FooViewModel extends _$FooViewModel with ProjectDependencyMixin`
- Mutate state via `state = state.copyWith(...)`.
- Use `firebaseService`, `appProvider`, `productProviderState`, etc. from the mixin — never instantiate Firebase directly.
- Pure data/query methods return `Query<...>` / `CollectionReference<...>` to be consumed by `firestore_grid_view`-style builders.

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'foo_state.dart';

part 'foo_view_model.g.dart';

@riverpod
final class FooViewModel extends _$FooViewModel with ProjectDependencyMixin {
  @override
  FooState build() => const FooState();

  Future<void> load() async {
    state = state.copyWith(isLoading: true);
    // ...firebaseService usage
    state = state.copyWith(isLoading: false);
  }
}
```

After editing a `*_view_model.dart` annotated with `@riverpod`, regenerate:
```
dart run build_runner build --delete-conflicting-outputs
```

### `foo_view.dart`

- `final class FooView extends ConsumerStatefulWidget`
- State class: `class _FooViewState extends ConsumerState<FooView>` mixing in
  any feature mixins (`FooViewMixin`, `AppProviderMixin<FooView>`, etc.).
- Wrap body in `GeneralScaffold` from `product/widget/general/`.
- Read state with `ref.watch(fooViewModelProvider)`; call methods with
  `ref.read(fooViewModelProvider.notifier).xxx()`.
- Use `LocaleKeys.<section>_<key>.tr()` for every user-visible string.
- All colors and text styles come from `context.general.colorScheme.*` /
  `context.general.textTheme.*` (kartal extension on top of `Theme.of`).
- Use `PagePadding.*`, `CustomRadius.*`, `WidgetSizes.*`, `EmptyBox.*` instead
  of literal numbers.
- Tag interactive/scrollable widgets with stable `Key('fooXxx')` values for
  test stability.

## Widget Layering Rules

| Layer                              | Visibility | Imported via       | Notes                                   |
| ---------------------------------- | ---------- | ------------------ | --------------------------------------- |
| `features/.../view/widget/*.dart`  | `_Private` | `part of` parent   | Single-feature use only                 |
| `product/widget/<group>/*.dart`    | Public     | regular `import`   | Reused across ≥ 2 features              |
| `product/widget/<group>/index.dart`| Barrel     | regular `import`   | Re-exports the group; prefer for callers|

Promote a `_Private` widget to `product/widget/...` only when a second feature
needs it — not "just in case".

## Models

Two flavours coexist:

1. **Domain models** live in the `life_shared` package (e.g. `StoreModel`,
   `NewsModel`, `CampaignModel`) — do not duplicate them.
2. **Product/UI-only models** live under `lib/product/model/`:
   - `final class` extending `Equatable`.
   - `@JsonSerializable(createToJson: false)` when only deserialised.
   - `part 'xxx.g.dart';` for `_$XxxFromJson`.
   - `factory Xxx.fromJson(Map<String, dynamic> json) => _$XxxFromJson(json);`
   - Override `props`.

Adapters for `life_shared` models go in `lib/product/model/.../<model>_display.dart`
as **extensions** (not wrappers) when only display-side getters are needed —
e.g. `StoreModelDisplay on StoreModel` exposing `isOpenNow`, `displayAccent`.

Enums sit in `lib/product/model/enum/` and are re-exported via `enum/index.dart`.

## Dependency Injection

- All shared services (`FirebaseCustomService`, `AppProvider`, `ProductCache`,
  global Riverpod providers) are exposed through `ProjectDependencyItems`
  (singleton holder) and consumed via `ProjectDependencyMixin`.
- ViewModels and (rarely) widgets `with ProjectDependencyMixin` to grab them.
- Do NOT call `FirebaseFirestore.instance` or instantiate services directly
  inside a feature.

## Navigation

- Routes declared in `lib/product/navigation/app_router.dart` with GoRouter
  codegen (`@TypedGoRoute<...>`).
- Push with `XxxRoute(...).go(context)` / `.push(context)` — never use raw
  `Navigator.push` with magic strings.

## Localization

- All strings sourced from `assets/translations/{tr,en}.json`.
- Access via the generated `LocaleKeys` map (`LocaleKeys.feed_emptyTitle.tr()`).
- After editing JSON, regenerate keys:
  ```
  dart run easy_localization:generate -S assets/translations -O lib/product/init/language -o locale_keys.g.dart -f keys
  ```
- Default tone: informal Turkish ("sen" form).

---

## Style Guide — Theme is the Single Source of Truth

The V2 mozaik design lives in a few well-defined files; nothing else may
define its own colors, fonts, or radii:

| File                                                       | Owns                                          |
| ---------------------------------------------------------- | --------------------------------------------- |
| `product/utility/decorations/colors_custom.dart`           | Raw palette tokens (`ColorsCustom.navy`, etc.)|
| `product/init/application_theme.dart`                      | `ColorScheme` + `ThemeData` for light & dark  |
| `product/init/application_theme.dart` → `V2Typography`     | DM Serif Display & eyebrow helpers            |
| `product/utility/decorations/custom_radius.dart`           | `CustomRadius.*` corner tokens                |
| `product/utility/decorations/empty_box.dart` + `WidgetSizes` | Spacing tokens                              |

### The Hard Rule

**Never hardcode a color, font family, or text style at the call site. Always
read it from the active theme via `context.general.*` (kartal extension).**

That means:

- **Colors** → `context.general.colorScheme.<role>` (or `Theme.of(context).colorScheme.<role>`).
  Do NOT write `ColorsCustom.navy` / `Color(0xFF…)` / `Colors.red` directly in
  a widget. Raw `ColorsCustom.*` tokens belong **only** inside
  `ApplicationTheme` (and one or two narrow brand widgets like the splash
  logo).
- **Text styles** → `context.general.textTheme.<style>.copyWith(color: colorScheme.onSurface)`.
  Don't instantiate `TextStyle(fontFamily: …)` ad hoc; the editorial
  DM Serif headline goes through `V2Typography.display(...)`, the uppercase
  signature label through `V2Typography.eyebrow(...)`.
- **Radii** → `CustomRadius.small | medium | large | extraLarge`, never
  `BorderRadius.circular(12)` inline.
- **Spacing** → `PagePadding.*`, `EmptyBox.*`, `WidgetSizes.*`, never bare
  `EdgeInsets.all(16)` or `SizedBox(height: 24)`.

Why: dark mode flips ~15 `colorScheme` slots in
`ApplicationTheme._buildColorScheme`. A widget that reads `colorScheme.surface`
adapts automatically; a widget that reads `ColorsCustom.white` does not, and
its background will stay white in dark mode.

### Color Role Cheat Sheet

Read these from `context.general.colorScheme.<role>`. Choose by **role**, not
by the brand name behind the role.

| Role                       | What it represents in this app                                       | Light value          | Dark value            |
| -------------------------- | -------------------------------------------------------------------- | -------------------- | --------------------- |
| `primary`                  | Brand foreground (navy in light, soft teal in dark)                  | `navy`               | soft teal `#8FD4DF`   |
| `onPrimary`                | Text/icons sitting on `primary`                                      | white                | navy                  |
| `secondary`                | Card / sheet / dialog background                                     | white                | elevated navy `#0B2138`|
| `surface`                  | Scaffold background                                                  | white                | deep navy `#08182A`   |
| `onSurface`                | Default body text & icon color                                       | `ink900`             | near-white `#F7F9FB`  |
| `onPrimaryFixed`           | Tinted neutral fill (search field, chip background)                  | `bgCool`             | elevated navy         |
| `onPrimaryContainer`       | Subtle border / divider                                              | `ink100`             | navy border `#2E4D70` |
| `onSecondaryFixed`         | Muted helper / placeholder text                                      | `ink400`             | muted navy `#94A4B9`  |
| `onPrimaryFixedVariant`    | Strong secondary text                                                | `ink600`             | near-white            |
| `primaryContainer`         | Success / open status fill (olive)                                   | `olive`              | dark olive            |
| `onTertiaryContainer`      | Success text on success fill                                         | `olive300`           | `#BDDF92`             |
| `onSecondaryContainer`     | Info / teal accent                                                   | `teal`               | soft teal             |
| `onTertiaryFixedVariant`   | Coral accent (CTA / closed status)                                   | `coral`              | `#EE7263`             |
| `error`                    | Destructive / error                                                  | `coral`              | `coral`               |

Use the role you mean, e.g.:

```dart
// 👍 Reads from theme — adapts to dark mode
Container(
  decoration: BoxDecoration(
    color: context.general.colorScheme.secondary,
    borderRadius: CustomRadius.medium,
    border: Border.all(color: context.general.colorScheme.onPrimaryContainer),
  ),
  child: Text(
    LocaleKeys.feed_emptyTitle.tr(),
    style: context.general.textTheme.titleMedium?.copyWith(
      color: context.general.colorScheme.onSurface,
    ),
  ),
);
```

```dart
// ❌ Hardcoded — will look wrong in dark mode
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: ColorsCustom.ink100),
  ),
  child: Text(
    'Henüz gönderi yok',
    style: TextStyle(fontSize: 16, color: ColorsCustom.ink900),
  ),
);
```

### When You Genuinely Need a Brand Token

Some surfaces are intentionally locked to a brand color regardless of theme
(e.g. the coral FAB, the gold memorial accent, the splash logo). In those
narrow cases:

1. Prefer the matching `colorScheme` role first (`error` for destructive
   coral, `onTertiaryFixedVariant` for accent coral, `primaryContainer` for
   olive success). Reach for `ColorsCustom.*` only when no role fits.
2. If a brand token must appear inline, isolate it in a small named widget
   under `product/widget/brand/` so the deviation is visible in code review.
3. Never add a new raw `Color(0xFF…)` literal at the call site — extend
   `ColorsCustom` and `_buildColorScheme` instead, then consume the role.

### Typography Rules

- Body text comes from the theme (`Plus Jakarta Sans`, applied in
  `ApplicationTheme._buildTheme`). Read with `context.general.textTheme.<style>`.
- Editorial display (DM Serif Display) is **only** via `V2Typography.display(...)`.
- The small uppercase eyebrow label is **only** via `V2Typography.eyebrow(...)`.
- No `GoogleFonts.xxx(...)` calls inside features — extend `V2Typography` if
  you need a new editorial style.

### Dark Mode Smoke Test

Before reporting a UI task as done:

1. Run the app, switch system theme to Dark.
2. Open the screens you touched and confirm:
   - No pure-white backgrounds where a card/sheet should be elevated navy.
   - All text reads against its background (no `ink900` on `_darkSurface`).
   - Borders/dividers are visible but not white.
3. If anything looks wrong, the cause is almost always a hardcoded color —
   replace it with the matching `colorScheme` role.

---

## Coding Style

- Default class modifier is `final class`. Use `sealed`/`base` only with reason.
- Private types and helpers prefer the `_LeadingUnderscore` form.
- Widgets that don't hold state are `StatelessWidget` (or `ConsumerWidget` if
  they need `ref`); avoid `StatefulWidget` unless you actually keep state.
- Each `ConsumerStatefulWidget` State should mix in only what it uses —
  feature mixin, `AppProviderMixin`, `NotificationTypeMixin`,
  `AutomaticKeepAliveClientMixin`, etc.
- No `print` — use logging/notifier utilities from `product/utility/`.
- Avoid magic numbers in UI — pull into `WidgetSizes` / `PagePadding` / local
  `static const`.
- Comments only when the **why** is non-obvious; let names do the talking.

## Verification Checklist (run before finishing a task)

1. `flutter analyze` — must report zero new errors/warnings.
2. If you touched generated sources or annotations:
   `dart run build_runner build --delete-conflicting-outputs`
3. If you touched translations: regenerate `locale_keys.g.dart` (see above).
4. `dart format lib/`.
5. Quick grep sanity:
   - New `part of` matches exactly one `part 'xxx.dart'` declaration.
   - No `Theme.of(context)` where `context.general.*` would do.
   - No `Color(0xFF…)`, `Colors.<name>`, or `ColorsCustom.<token>` literals
     inside `lib/features/` — they should read from `colorScheme`.
   - No `BorderRadius.circular(...)` outside `CustomRadius`.
   - No hard-coded user-facing strings.
6. Dark-mode smoke test on every screen you touched.

## Quick Decision Tree

| You want to…                                       | Do this                                                              |
| -------------------------------------------------- | -------------------------------------------------------------------- |
| Add a new top-level screen                         | Create `features/<area>/<name>/{view,provider}/` + register a Route  |
| Split a long widget tree                           | Extract `_Private` widget under `view/widget/`, `part of` the view   |
| Reuse a widget in another feature                  | Move it to `product/widget/<group>/`, export via `index.dart`        |
| Need Firebase / app state in a VM                  | `with ProjectDependencyMixin`, use `firebaseService` / `appProvider` |
| Need a derived field on a `life_shared` model      | Add an `extension XxxDisplay on Xxx` under `product/model/...`       |
| Need lifecycle / listener glue inside a view       | Create `<feature>_view_mixin.dart` under `view/mixin/`               |
| Add a new user-facing string                       | Edit both `tr.json` & `en.json`, regenerate `locale_keys.g.dart`     |
| Need a new color                                   | Add token to `ColorsCustom`, wire a role in `_buildColorScheme`, consume via `colorScheme` |
| Need an editorial headline                         | Use `V2Typography.display(...)`, never inline `GoogleFonts.*`        |
