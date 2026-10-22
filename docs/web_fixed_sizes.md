# WEB-14 — Sabit piksel genişlik/yükseklik denetimi

> Issue: [#493](https://github.com/VB-CORE/hatayi_yasat/issues/493) · Bağımlılık: WEB-10 (#497, 768px `WebShell`) · Denetim tabanı: `main` @ `7f7a01ed`

## Yöntem

```bash
git grep -nE '(width|height): *[0-9]' -- 'lib/*.dart' | grep -v '\.g\.dart'
```

Sonuç **76 eşleşme**: 11'i `custom_border_side.dart` içindeki `///` doc yorumu, **65'i kod**.
Regex dışında kalan tek sabit boyut `app_bar_action.dart`'taki `Size(36, 36)` idi; o da ele alındı.

## Sonuç: web'i bozan kullanım yok

`WebShell` geniş pencerede uygulamayı 768px karta yerleştirir ve `MediaQuery.size`'ı karta daraltır.
Dar pencerede uygulama mobildeki gibi çizilir. Bulunan sabit boyutların hepsi 48px ve altındaki
kontrol/ikon boyutları ya da çizgi kalınlıkları; ikisinde de taşma veya ölçek sorunu üretmiyor.
Bu yüzden düzeltmeler **web hatası değil, token borcu** olarak yapıldı ve görsel değişiklik yok.

## Sınıflandırma (65 kod satırı)

| Grup | Adet | Karar |
|---|---|---|
| Token tanımları | 21 | Kalır |
| TextStyle satır yüksekliği | 18 | Kalır — oran, piksel değil |
| Kenarlık/çizgi kalınlığı | 6 | Kalır |
| `Divider` yüksekliği (0/1) | 5 | Kalır |
| Layout boyutu | 15 | **Token'a çevrildi** |

### Token'a çevrilenler

| Konum | Eski | Yeni |
|---|---|---|
| `lib/features/main/home/view/home_view.dart` `_FilterButton` | `width: 48` | `WidgetSizes.spacingXxl6` |
| `lib/features/main/home/view/widget/home_categories_area.dart` | `22×22` | `AppSpacing.iconBadge` |
| `lib/features/main/home/view/widget/home_sort_grid_view.dart` `_BoxedButton` | `38×38` | `AppSpacing.controlButton` |
| `lib/features/main/home/view/widget/place_filter_sheet.dart` `_TownCheckRow` | `22×22` | `AppSpacing.checkbox` |
| `lib/features/main/home/view/widget/place_filter_sheet.dart` `_CtaFooter` | `18×18` | `WidgetSizes.spacingMx` |
| `place_filter_sheet.dart` + `lib/product/widget/sheet/place_sort_sheet.dart` `_SheetHandle` (iki kopya) | `36×4` | Ortak `SheetHandle` ([sheet_handle.dart](../lib/product/widget/sheet/widget/sheet_handle.dart)): `spacingXxl3 × spacingXxs` |
| `lib/sub_feature/advertisement_board/views/advertisement_board_item.dart` `_HouseAdLogo` | `40×40` | `WidgetSizes.spacingXxl4` |
| `lib/product/widget/app_bar/app_bar_action.dart` | `Size(36, 36)` | `Size.square(WidgetSizes.spacingXxl3)` |

`WidgetSizes`'ta 22 ve 38 yok; CLAUDE.md §6 gereği ("eksik değer temaya eklenir")
[app_spacing.dart](../lib/core/theme/app_spacing.dart)'a `iconBadge`, `checkbox`, `controlButton` eklendi.

### Kalanlar (bilinçli)

- **Token tanımları (21):** `lib/product/utility/decorations/empty_box.dart` (11),
  `lib/product/utility/decorations/custom_border_side.dart` (10).
- **Satır yüksekliği (18):** `lib/core/theme/app_text.dart` (12),
  `news_detail_view.dart:72`, `advertisement_board_item.dart:64`, `monetization_card.dart:144`,
  `app_bar_action.dart:52`, `main_bottom_app_bar.dart:83,86`.
- **Çizgi kalınlığı (6):** `app_theme.dart:168,183`, `monetization_tab_bar.dart:39`,
  `upload_file_section_v2.dart:62`, `custom_button_style.dart:14`, `main_app_bar.dart:103`.
- **Divider (5):** `rate_comment_list_view.dart:207`, `place_filter_sheet.dart:171`,
  `web_sidebar.dart:91,169`, `town_select_sheet.dart:69`.

## Kalan borç

| Konu | Neden bu issue'da değil | Takip |
|---|---|---|
| `context.sized.dynamicHeight/Width` (64 kullanım) | Viewport oranı; masaüstü yüksekliğinde asıl web riski | WEB-12 [#489](https://github.com/VB-CORE/hatayi_yasat/issues/489) |
| `place_filter_sheet.dart` `MediaQuery.sizeOf(context).height * 0.92` ve diğer sheet/dialog yükseklikleri | Sheet'in kabuk içinde kalmasına bağlı | WEB-13 [#491](https://github.com/VB-CORE/hatayi_yasat/issues/491) |
| Sabit `fontSize` değerleri (17 kullanım, örn. `AppText.title.copyWith(fontSize: 18)`) | Tipografi token'ı, boyut değil | Takip issue'su açılacak |
| Sheet tutamacı (`SheetHandle`) web'de sürüklenemiyor | Mouse'ta anlamsız görsel öğe | Takip issue'su açılacak |
