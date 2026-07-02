# Hatay'ı Yaşat — Flutter Coding Standard & Design Tokens

> Bu doküman, mevcut V2 tasarım prototipinde **fiilen kullanılan** renk, tipografi, ölçü ve asset değerlerinden üretilmiştir. Flutter projesinde tek kaynak (single source of truth) olarak kullanın. Magic number / hardcoded hex YASAK — her şey buradaki token'lardan gelir.

---

## 0. Genel İlkeler

- **Feature-first klasör yapısı:** `lib/features/<feature>/{data,domain,presentation}` + `lib/core/{theme,widgets,utils}`.
- **Token zorunluluğu:** Renk, yazı tipi, boşluk, radius, gölge → daima `AppColors`, `AppText`, `AppSpacing`, `AppRadius`, `AppShadows`'tan. Widget içinde çıplak `Color(0x...)`, `EdgeInsets.all(13)`, `fontSize: 14` yazmak yasak.
- `**const` her yerde:** Mümkün olan her widget `const`. Linter: `prefer_const_constructors` açık.
- **İsimlendirme:** Dosya `snake_case.dart`, sınıf/Widget `PascalCase`, değişken/fonksiyon `camelCase`, sabitler `lowerCamelCase` (Effective Dart).
- **Widget < 150 satır:** Büyüyen `build` metodunu private `_Xxx` widget'larına böl. `Function` yerine ayrı `StatelessWidget`.
- **Emoji/SVG logo fallback YOK:** Marka her yerde `assets/hy_logo.png`.

---

## 1. Renkler (Colors)

Palet mozaik logodan türetilmiştir: **Lacivert (primary) · Mercan (accent) · Turkuaz (secondary) · Yeşil (success)** + cool nötrler + anma altını.

### Roller


| Rol                | Token     | Hex       |
| ------------------ | --------- | --------- |
| Primary            | `navy`    | `#0F2A47` |
| Accent             | `coral`   | `#E84B3C` |
| Secondary          | `teal`    | `#3CB6C9` |
| Success            | `olive`   | `#7FBE3F` |
| Anma / ödül        | `gold`    | `#A87D15` |
| Ana zemin          | `bg`      | `#F7F9FB` |
| Derin zemin        | `bgDeep`  | `#EEF2F6` |
| Kart / yüzey       | `surface` | `#FFFFFF` |
| Ana metin          | `ink900`  | `#0A1320` |
| İkincil metin      | `ink500`  | `#566270` |
| Soluk metin / ikon | `ink400`  | `#7A8593` |
| Ayraç / border     | `ink50`   | `#EEF2F6` |


### Tam tonlar — `lib/core/theme/app_colors.dart`

```dart
import 'package:flutter/material.dart';

/// Hatay'ı Yaşat renk paleti. Mozaik kimlikten türetilmiştir.
abstract final class AppColors {
  // ── PRIMARY · Lacivert (mozaik zemin) ──
  static const navy    = Color(0xFF0F2A47);
  static const navy50  = Color(0xFFEAEEF3);
  static const navy100 = Color(0xFFCBD4E0);
  static const navy200 = Color(0xFF94A4B9);
  static const navy300 = Color(0xFF5C7491);
  static const navy400 = Color(0xFF2E4D70);
  static const navy500 = Color(0xFF0F2A47);
  static const navy600 = Color(0xFF0B2138);
  static const navy700 = Color(0xFF08182A);
  static const navy800 = Color(0xFF050F1B);
  static const navy900 = Color(0xFF02060D);

  // ── ACCENT · Mercan ──
  static const coral    = Color(0xFFE84B3C);
  static const coral50  = Color(0xFFFDECEA);
  static const coral100 = Color(0xFFFACFCB);
  static const coral200 = Color(0xFFF4A097);
  static const coral300 = Color(0xFFEE7263);
  static const coral400 = Color(0xFFEA5B4D);
  static const coral500 = Color(0xFFE84B3C);
  static const coral600 = Color(0xFFCD3A2C);
  static const coral700 = Color(0xFFA12C20);
  static const coral800 = Color(0xFF751F17);
  static const coral900 = Color(0xFF4A130E);

  // ── SECONDARY · Turkuaz ──
  static const teal    = Color(0xFF3CB6C9);
  static const teal50  = Color(0xFFE5F5F8);
  static const teal100 = Color(0xFFBFE7EE);
  static const teal200 = Color(0xFF8FD4DF);
  static const teal300 = Color(0xFF5EC0CF);
  static const teal400 = Color(0xFF3CB6C9);
  static const teal500 = Color(0xFF2A9DAF);
  static const teal600 = Color(0xFF207E8C);
  static const teal700 = Color(0xFF185E68);
  static const teal800 = Color(0xFF103E45);

  // ── SUCCESS · Yeşil ──
  static const olive    = Color(0xFF7FBE3F);
  static const olive50  = Color(0xFFF2F9E8);
  static const olive100 = Color(0xFFDCEEC0);
  static const olive200 = Color(0xFFBDDF92);
  static const olive300 = Color(0xFF9DCF63);
  static const olive400 = Color(0xFF7FBE3F);
  static const olive500 = Color(0xFF67A030);
  static const olive600 = Color(0xFF4F7C25);
  static const olive700 = Color(0xFF385819);

  // ── NÖTR (cool / navy ile harmoni) ──
  static const white   = Color(0xFFFFFFFF);
  static const bg       = Color(0xFFF7F9FB); // ana zemin
  static const bgDeep   = Color(0xFFEEF2F6);
  static const surface  = Color(0xFFFFFFFF);
  static const ink25  = Color(0xFFF7F9FB);
  static const ink50  = Color(0xFFEEF2F6);
  static const ink100 = Color(0xFFE1E7EE);
  static const ink200 = Color(0xFFCBD3DC);
  static const ink300 = Color(0xFFA8B2BE);
  static const ink400 = Color(0xFF7A8593);
  static const ink500 = Color(0xFF566270);
  static const ink600 = Color(0xFF3A4452);
  static const ink700 = Color(0xFF26303D);
  static const ink800 = Color(0xFF16202C);
  static const ink900 = Color(0xFF0A1320);

  // ── Anma altını (yalnızca anma/ödül/yıldız) ──
  static const gold    = Color(0xFFA87D15);
  static const gold200 = Color(0xFFE9CE7E);
  static const gold300 = Color(0xFFDDB74B);
}
```

### Kullanım kuralları

- **Beyaz üstüne yüzey hiyerarşisi:** `bg` (ekran) → `surface` (kart) → kart `border: 1px ink50`.
- **Vurgu (accent):** CTA, aktif sekme, rozet → `coral`. Hover/pressed → `coral600`.
- **Başarı/onaylı:** `olive` ailesi (rozet zemini `olive50`, metin `olive600`).
- **Başlık metni:** `navy`. Gövde `ink700`, ikincil `ink500`, soluk `ink400`.
- **Yıldız/puan:** `gold300` (dolu). Anma içeriği dışında `gold` kullanma.
- **Doygunluk sınırı:** Yeni beyaz/siyah üretirken chroma < 0.02 (nötrler hep cool/navy tonlu).

---

## 2. Tipografi (Typography)

### Aileler


| Kullanım         | Aile                          | Ağırlıklar                          |
| ---------------- | ----------------------------- | ----------------------------------- |
| Başlık / display | **DM Serif Display**          | 400, 400-italic                     |
| Gövde / UI       | **Plus Jakarta Sans**         | 400, 500, 600, 700, 800             |
| İkon             | **Material Symbols Outlined** | — (`material_symbols_icons` paketi) |


`pubspec.yaml`:

```yaml
flutter:
  fonts:
    - family: PlusJakartaSans
      fonts:
        - asset: assets/fonts/PlusJakartaSans-Regular.ttf
        - { asset: assets/fonts/PlusJakartaSans-Medium.ttf,   weight: 500 }
        - { asset: assets/fonts/PlusJakartaSans-SemiBold.ttf, weight: 600 }
        - { asset: assets/fonts/PlusJakartaSans-Bold.ttf,     weight: 700 }
        - { asset: assets/fonts/PlusJakartaSans-ExtraBold.ttf,weight: 800 }
    - family: DMSerifDisplay
      fonts:
        - asset: assets/fonts/DMSerifDisplay-Regular.ttf
        - { asset: assets/fonts/DMSerifDisplay-Italic.ttf, style: italic }
```

### Tip skalası — `lib/core/theme/app_text.dart`

Projede gözlemlenen boyutlardan türetilmiş semantik ölçek (logical px ≈ Flutter `fontSize`):

```dart
import 'package:flutter/widgets.dart';
import 'app_colors.dart';

abstract final class AppText {
  static const _serif = 'DMSerifDisplay';
  static const _sans  = 'PlusJakartaSans';

  // ── DISPLAY (DM Serif) — başlıklar ──
  static const displayXl = TextStyle(fontFamily: _serif, fontSize: 42, height: 1.06, letterSpacing: -0.8, color: AppColors.navy); // login hero
  static const displayLg = TextStyle(fontFamily: _serif, fontSize: 30, height: 1.12, letterSpacing: -0.3, color: AppColors.navy);
  static const displayMd = TextStyle(fontFamily: _serif, fontSize: 26, height: 1.10, letterSpacing: -0.3, color: AppColors.navy); // ekran başlığı
  static const displaySm = TextStyle(fontFamily: _serif, fontSize: 21, height: 1.10, letterSpacing: -0.2, color: AppColors.navy); // sheet/section
  static const titleLg   = TextStyle(fontFamily: _serif, fontSize: 19, height: 1.15, letterSpacing: -0.2, color: AppColors.navy); // appbar
  static const title     = TextStyle(fontFamily: _serif, fontSize: 17, height: 1.15, letterSpacing: -0.2, color: AppColors.navy);

  // ── GÖVDE (Plus Jakarta Sans) ──
  static const bodyLg   = TextStyle(fontFamily: _sans, fontSize: 14.5, height: 1.5,  fontWeight: FontWeight.w600, color: AppColors.ink900);
  static const body     = TextStyle(fontFamily: _sans, fontSize: 13,   height: 1.5,  fontWeight: FontWeight.w500, color: AppColors.ink700);
  static const bodySm   = TextStyle(fontFamily: _sans, fontSize: 12,   height: 1.45, fontWeight: FontWeight.w500, color: AppColors.ink600);
  static const label    = TextStyle(fontFamily: _sans, fontSize: 13.5, height: 1.2,  fontWeight: FontWeight.w800, color: AppColors.ink900); // kart başlığı
  static const caption  = TextStyle(fontFamily: _sans, fontSize: 11.5, height: 1.4,  fontWeight: FontWeight.w600, color: AppColors.ink500);
  static const micro    = TextStyle(fontFamily: _sans, fontSize: 10.5, height: 1.3,  fontWeight: FontWeight.w700, color: AppColors.ink400);

  // ── EYEBROW (imza) — üstbaşlık ──
  static const eyebrow = TextStyle(
    fontFamily: _sans, fontSize: 11, fontWeight: FontWeight.w800,
    letterSpacing: 1.8, color: AppColors.coral, // ≈ 0.16em
  ); // kullanım: Text('KEŞFET', style: AppText.eyebrow) — uppercase metin verilir
}
```

### Kurallar

- **Başlık = serif, UI = sans.** Karıştırma. Buton/etiket/gövde daima Plus Jakarta Sans.
- **Ağırlık dili:** 800 = vurgulu başlık/CTA, 700 = ikincil başlık, 600 = etiket/gövde-vurgu, 500/400 = gövde.
- **Eyebrow** her zaman uppercase + `letterSpacing 0.16em` + `coral`. Bölüm/section girişlerinde kullan.
- **letterSpacing:** Serif başlıklarda negatif (-0.2 … -0.8). Eyebrow/rozetlerde pozitif (1.2–2.0).
- **Min boyut:** UI metninde 10 altına inme; gövde okunur metinde 12 taban.

---

## 3. Boşluk (Spacing) — `lib/core/theme/app_spacing.dart`

4'ün katları taban; projede ara değerler de (13, 18, 22) yoğun kullanılıyor.

```dart
abstract final class AppSpacing {
  static const xxs = 4.0;
  static const xs  = 8.0;
  static const sm  = 12.0;   // kart içi dikey ritim
  static const md  = 14.0;   // kart padding (varsayılan)
  static const lg  = 16.0;   // ekran yatay kenar boşluğu
  static const xl  = 20.0;
  static const xxl = 24.0;
  static const xxxl = 28.0;

  // Ekran kenarı varsayılanı
  static const screenH = EdgeInsets.symmetric(horizontal: 16);
  static const cardPad = EdgeInsets.all(14);
  static const listGap = 11.0; // kartlar arası dikey gap
}
```

- **Ekran yatay padding:** 16 (liste/kart ekranları), 20–24 (onboarding/odak ekranlar).
- **Kart iç padding:** 13–14. **Kartlar arası dikey boşluk:** 10–12.
- `**Row`/`Column` aralıkları `gap` mantığıyla:** `SizedBox` veya `Gap` paketi; magic `Padding` zincirleri yok.

---

## 4. Köşe Yarıçapı (Radius) — `lib/core/theme/app_radius.dart`

```dart
import 'package:flutter/widgets.dart';

abstract final class AppRadius {
  static const sm   = 10.0; // küçük chip/iç öğe
  static const md   = 12.0; // input, küçük kart
  static const lg   = 14.0; // standart kart (varsayılan)
  static const xl   = 16.0; // büyük kart / sheet içi
  static const xxl  = 22.0; // bottom sheet üst köşeleri
  static const hero = 26.0; // logo kutusu / büyük hero
  static const pill = 999.0; // rozet, buton-pill, avatar

  static BorderRadius get card => BorderRadius.circular(lg);
  static BorderRadius get sheet => const BorderRadius.vertical(top: Radius.circular(xxl));
}
```

- **Kart varsayılanı:** 14–16. **Pill/rozet/avatar/FAB:** 999. **Bottom sheet:** üst 22.
- **İkon konteyneri (renkli kare):** 8–12 radius, ikon ortalı.

---

## 5. Gölge / Elevation — `lib/core/theme/app_shadows.dart`

Tüm gölgeler navy (15,42,71) tabanlı; nötr siyah gölge kullanma.

```dart
import 'package:flutter/material.dart';

abstract final class AppShadows {
  static const _navy = Color(0xFF0F2A47);

  /// Kart — çok hafif
  static List<BoxShadow> card = [
    BoxShadow(color: _navy.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2)),
  ];
  /// Yükseltilmiş (buton/logo/floating)
  static List<BoxShadow> raised = [
    BoxShadow(color: _navy.withOpacity(0.10), blurRadius: 30, offset: const Offset(0, 10)),
  ];
  /// Hero / büyük float
  static List<BoxShadow> hero = [
    BoxShadow(color: _navy.withOpacity(0.12), blurRadius: 40, offset: const Offset(0, 16)),
  ];
  /// Popover / menü
  static List<BoxShadow> popover = [
    BoxShadow(color: _navy.withOpacity(0.18), blurRadius: 30, offset: const Offset(0, 12)),
  ];
  /// Toast (navy zemin üstünde koyu)
  static List<BoxShadow> toast = [
    BoxShadow(color: _navy.withOpacity(0.35), blurRadius: 40, offset: const Offset(0, 16)),
  ];
}
```

- Kartlar çoğunlukla **gölge yerine `1px ink50 border`** kullanır — gölgeyi yalnızca yüzen öğelerde (FAB, sheet, popover, toast, logo) kullan.

---

## 6. İkonlar (Icons)

- **Set:** Material Symbols Outlined. Paket: `material_symbols_icons`.
- **Fill:** Aktif/seçili durumda `fill: 1` (dolu), pasifte `fill: 0` (outline). Weight aktifte 600.
- **Boyut ölçeği:** inline 13–16 · standart **18–20** · bottom nav **22** · hero/durum ikonu 26–44.
- **Renk:** ikon rengi her zaman bir token (`ink400` pasif, `coral`/`navy` aktif). Renkli kare konteyner içinde ikon `white`.

```dart
// Aktif/pasif örnek
Icon(Symbols.storefront, size: 20, fill: isActive ? 1 : 0,
     weight: isActive ? 600 : 400, color: isActive ? AppColors.coral : AppColors.ink400);
```

---

## 7. Asset'ler

```yaml
# pubspec.yaml
flutter:
  assets:
    - assets/hy_logo.png
```


| Asset        | Yol                  | Not                                                                                                     |
| ------------ | -------------------- | ------------------------------------------------------------------------------------------------------- |
| Marka logosu | `assets/hy_logo.png` | Mozaik tesselation logo. **Tek marka işareti.** Emoji/SVG fallback YASAK. `HyLogo` widget'ı ile kullan. |


### Kod-üretimli motifler (asset değil → `CustomPainter`)

Bunlar dosya değil, kodla çizilir; Flutter'da `CustomPaint` ile uygula:

- **MosaicTesserae** — renkli kare doku (login/hero/fotoğrafsız thumbnail zemini). Palet: `[navy, coral, teal, olive, navy400]`, opacity **0.18–0.45**. İsteğe bağlı merkezden dışa sönümleme (falloff).
- **MosaicGrid** — navy zeminlerde 8–14px ince grid overlay, opacity ~0.16.
- **Fotoğraf placeholder'ları** — `VitrinPhoto`: indeksli lineer gradient (mozaik renklerinden) + opsiyonel doku. Gerçek görsel gelene kadar kullanılır.

> Gerçek içerik görselleri (mekan foto, kapak) backend/Storage'dan gelir; statik asset olarak gömülmez.

---

## 8. Bileşen Ölçüleri (Component Sizing)


| Bileşen                          | Ölçü                                                                                      |
| -------------------------------- | ----------------------------------------------------------------------------------------- |
| **Tasarım referans canvas**      | 360 × 740 (logical) — telefon mockup tabanı                                               |
| **Min dokunma hedefi**           | 44 × 44                                                                                   |
| **Birincil buton yüksekliği**    | ~50 (dikey padding 14–15), radius 14, `coral`/`navy` zemin                                |
| **İkincil buton**                | radius 14, `surface` + `1px ink100` border                                                |
| **Pill buton / chip**            | padding `7×13`, radius 999                                                                |
| **Bottom nav**                   | ikon 22, etiket 10.5/w700, aktif renk `coral`                                             |
| **AppBar / header**              | padding `14×16`, başlık `titleLg` (serif 19), geri ikon 22                                |
| **Avatar**                       | xs 34 · sm 36/38 · md 40 · lg 52 · xl 68; radius 999 (kullanıcı), 11 (mekan/kurum karesi) |
| **İkon konteyner (renkli kare)** | 30–48, radius 8–12                                                                        |
| **Kart**                         | radius 14–16, `1px ink50` border, padding 13–14                                           |
| **Bottom sheet**                 | üst radius 22, tutamak 36×4 `ink100/200`, alt güvenli boşluk ~22                          |
| **Rozet (badge)**                | fontSize 9.5–10.5/w800, padding `3–4 × 8–10`, radius 999                                  |
| **Input**                        | yükseklik ~46 (padding 13×14), radius 12, `1px ink100`, focus border `coral`/`navy`       |
| **FAB**                          | 56 önerilir; mevcut "gönder" yuvarlak 42, radius 999                                      |


```dart
abstract final class AppSize {
  static const designWidth = 360.0;
  static const designHeight = 740.0;
  static const minTouch = 44.0;
  static const buttonHeight = 50.0;
  static const navIcon = 22.0;
  static const iconStd = 20.0;
  static const avatarSm = 36.0, avatarMd = 40.0, avatarLg = 52.0, avatarXl = 68.0;
}
```

---

## 9. ThemeData kökü — `lib/core/theme/app_theme.dart`

```dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.navy,
    primary: AppColors.navy,
    secondary: AppColors.teal,
    error: AppColors.coral,
    surface: AppColors.surface,
    brightness: Brightness.light, // uygulama yalnızca LIGHT mod
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.bg,
    fontFamily: 'PlusJakartaSans',
    splashFactory: InkRipple.splashFactory,
    dividerColor: AppColors.ink50,
  );
}
```

> **Tema:** Uygulama yalnızca **light mod**. Dark mode tanımlanmaz (`themeMode: ThemeMode.light`).

---

## 10. Hızlı Kontrol Listesi (PR review)

- [ ] Hardcoded renk/boyut/radius yok — hepsi token.
- [ ] Başlık DM Serif, gövde/UI Plus Jakarta Sans.
- [ ] Eyebrow uppercase + coral + 0.16em.
- [ ] Kartta gölge yerine `1px ink50` border (yüzen öğe değilse).
- [ ] İkonlar Material Symbols; aktif `fill:1`.
- [ ] Logo `assets/hy_logo.png` (fallback yok).
- [ ] Dokunma hedefi ≥ 44.
- [ ] `const` kullanıldı; widget < 150 satır.
- [ ] Light mode varsayımı korundu.

```

```

