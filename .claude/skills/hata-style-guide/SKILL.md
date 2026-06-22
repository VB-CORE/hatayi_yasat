---
name: hata-style-guide
description: Design-system reference for life_client UI — the project's colors (ColorsCustom + context.general.colorScheme), typography (Roboto + semantic title widgets), spacing/radius tokens (PagePadding, EmptyBox, VerticalSpace, CustomRadius, WidgetSizes), reusable widget catalog (GeneralButtonV2, cards, inputs, dialogs), light/dark/system theming and easy_localization. Use when building or adjusting any UI and you need the project's tokens/components, e.g. "renkleri/fontları projeye göre kullan", "bu butonu projeye göre yaz", "style guide", "tema token'ları", "make this UI match the design system".
---

# life_client Style Guide

Convention reference for building UI the life_client way. The authoritative rules
live in [CLAUDE.md §6–§7](../../../CLAUDE.md); this skill is the quick lookup +
checklist when writing widgets. **Enforce, don't invent** — if a token is missing,
add it to the theme/token file, not the call site.

## When to invoke
- Writing or restyling any screen/widget and you need the right token/component.
- "bu UI'ı tasarım sistemine uydur", "renkleri/fontları projeye göre kullan",
  "style guide", "hangi spacing/radius", "match the design system".

## When NOT to invoke
- Scaffolding a whole feature (viewmodel+state+view) → `hata-feature`.
- Reviewing a diff → `hata-pr-review`.

## Colors
- **Always** `context.general.colorScheme.*` — `primary`, `secondary`, `surface`, `onSurface`, `error`, `onTertiary`, ...
- Fixed palette: `ColorsCustom` ([colors_custom.dart](../../../lib/product/utility/decorations/colors_custom.dart)) — `sambacus` (0xFF101A2A), `endless` (red), `braziliante` (green), `brandeisBlue`, `royalPeacock`, `lightGray`, `warmGrey`, `darkGray`, `softGray`, `imperilRead`.
- Helpers: `ColorCommon` ([color_common.dart](../../../lib/product/common/color_common.dart)) — `whiteAndBlackForTheme`, `blackAndWhiteForTheme` for theme-aware fills.
- ❌ `Color(0x..)` / `Colors.<name>` / `Theme.of(context)` in a view. Need a new color? Add it to `ColorsCustom` or the theme.

## Typography
- Roboto via `GoogleFonts.robotoTextTheme` set on the theme ([application_theme.dart](../../../lib/product/init/application_theme.dart)).
- Use **semantic text widgets**, not raw `Text` + `TextStyle`:
  - `GeneralBodyTitle` — titleMedium w600 (headings)
  - `GeneralContentTitle` — titleLarge w500 (section titles)
  - `GeneralContentSubTitle` — bodyMedium w500 (descriptions)
  - `GeneralContentSmallTitle`, `GeneralSubTitle`, `GeneralBigTitle`
- Icons: `AppIcons` (Material) + `FontAwesomeIcons.*`; sizes via `AppIconsSizes` (xSmall..xLarge).

## Spacing & radius tokens
- Padding: `PagePadding.*` — `defaultPadding()`, `horizontalSymmetric()`, `vertical12Symmetric()`, ... ❌ raw `EdgeInsets`.
- Vertical gaps: `EmptyBox.*` (`xSmallHeight` 4, `smallHeight` 8, `middleHeight` 16, `largeHeight` 24) or `VerticalSpace.*`.
- Scale: `WidgetSizes.spacingXs … spacingXxl*` (life_shared). ❌ hardcoded pixels.
- Radius: `CustomRadius.*` ([custom_radius.dart](../../../lib/product/utility/decorations/custom_radius.dart)) — `small` 8 / `medium` 12 / `large` 16 / `extraLarge` 24 / `xxLarge` 32. ❌ `BorderRadius.circular(<int>)`.
- Durations: `DurationConstant` (`durationLow` 500ms, `durationNormal` 1s, `durationMedium` 2s).
- Shadows: `GeneralShadow.*`; box decorations in [box_decorations.dart](../../../lib/product/utility/decorations/box_decorations.dart).

## Reusable components (consume, don't re-implement)
Browse [lib/product/widget/](../../../lib/product/widget/) (each category has an `index.dart`):
- Buttons: `GeneralButtonV2.active()` / `.async()`, `IconTitleButton`, `AppbarIconButton`, `FavoritePlaceButton`, `SocialMediaButton`.
- Cards: `GeneralPlaceCard`, `AdvertisePlaceCard`, `NewsCard`, `DeveloperProfileCard`.
- Inputs: `CustomTextFormField`, `CustomTextFormSelectionField`, `PhoneTextFormField`, `ValidatorTextFormField`.
- Layout/feedback: `GeneralScaffold` (auto horizontal padding), `GeneralNotFoundWidget`, shimmer placeholders, `GeneralTextDialog`/`GeneralIconTextDialog`, `GeneralCheckBox`, `GeneralExpansionTile`.

## Theming
- light / dark / system driven by `AppProviderState.theme`; `MaterialApp.router` supplies both `theme` and `darkTheme`. Card theme: elevation 2, radius 12 (`CustomRadius.medium`); inputs filled, radius 12.
- New colors must read correctly in both modes — prefer `colorScheme` roles over fixed palette where the value should flip.

## Localization
- `LocaleKeys.*.tr()` ([locale_keys.g.dart](../../../lib/product/init/language/locale_keys.g.dart)); files under `assets/translations/{tr,en}.json`. ❌ hardcoded UI strings.

## New-screen checklist (every box must pass)
- [ ] Colors via `context.general.colorScheme.*` / `ColorsCustom` only.
- [ ] Padding `PagePadding.*`; gaps `EmptyBox`/`VerticalSpace`; no raw pixels/`EdgeInsets`.
- [ ] Radius `CustomRadius.*`.
- [ ] Text via semantic title widgets; Roboto theme.
- [ ] Buttons/inputs/cards reused from `product/widget/`.
- [ ] Strings via `LocaleKeys.*.tr()`.
- [ ] Readable in both light & dark.

## "Don't → Do" quick map
| Don't | Do |
|---|---|
| `Color(0xFF101A2A)` / `Colors.blue` | `context.general.colorScheme.*` / `ColorsCustom.*` |
| `EdgeInsets.all(16)` | `PagePadding.defaultPadding()` |
| `SizedBox(height: 16)` | `EmptyBox.middleHeight()` / `VerticalSpace.standard()` |
| `BorderRadius.circular(12)` | `CustomRadius.medium` |
| `Text('Kaydet', style: TextStyle(...))` | `GeneralBodyTitle(value: LocaleKeys.button_save.tr())` |
| `ElevatedButton(...)` | `GeneralButtonV2.active(...)` |
| hardcoded `'Yer bulunamadı'` | `LocaleKeys.notification_placeNotFound.tr()` |

This skill is a reference, not a builder. To actually scaffold UI + logic, use
`hata-feature`.
