# Web build boyutu ve cache politikası (WEB-06, #495)

Ölçüm tarihi: 2026-09-23 · Flutter 3.44.9 · `flutter build web --release` (dart2js, CanvasKit) · commit `056d603f`

Bu değerler Maps, FCM ve iframe gibi Web özellikleri eklenmeden **önceki baseline**'dır.

## 1. Disk boyutu ile ilk yükleme boyutu farklı şeyler

`build/web` klasörü diskte **83 MB** tutuyor, ama tarayıcı bunun çoğunu hiç indirmiyor:

| Klasör | Disk | İlk yüklemede indiriliyor mu? |
|---|---|---|
| `canvaskit/` | 37 MB | **Hayır.** CanvasKit `www.gstatic.com/flutter-canvaskit/<engine>/` CDN'inden geliyor. Klasörde birden fazla renderer varyantı ve `.symbols` dosyaları var. |
| `assets/` | 39 MB | Kısmen. Fontların hepsi indiriliyor, görseller sadece kullanıldığında. |
| `main.dart.js` | 7,3 MB | Evet |
| `icons/` | 680 KB | Sadece PWA / sekme ikonu |

## 2. İlk yükleme (same-origin, gzip, cache kapalı)

Ölçüm yöntemi: Firebase Hosting emulator + Chrome, `performance.getEntriesByType('resource')`, açılışa kadar geçen 12 sn.

| | Transferred | Açılmış hali |
|---|---|---|
| **Toplam (bizim origin)** | **18,9 MB** | 44,0 MB |
| `MaterialSymbolsRounded.ttf` | 6,6 MB | 15,1 MB |
| `MaterialSymbolsOutlined.ttf` | 4,8 MB | 10,6 MB |
| `MaterialSymbolsSharp.ttf` | 4,3 MB | 8,8 MB |
| `main.dart.js` | 2,1 MB | 7,7 MB |
| `ic_app_transparent.png` | 358 KB | 358 KB |
| `Font-Awesome-7-Free-Solid-900.otf` | 171 KB | 415 KB |

CDN'den gelenler bu toplama dahil değil: CanvasKit `chromium/canvaskit.wasm` (açılmış hali 5,5 MB), Firebase JS SDK ve Google Fonts Roboto. Cross-origin oldukları için tarayıcı transfer boyutlarını raporlamıyor.

### Bulgu: ilk yüklemenin %83'ü kullanılmayan bir paketten geliyor
- `material_symbols_icons` `pubspec.yaml`'da tanımlı, ama `lib/` altında **hiç import edilmiyor** (0 kullanım).
- Flutter Web, `FontManifest.json`'daki bütün fontları açılışta indiriyor. Bu paketin üç variable fontu tree-shake edilmediği için **15,7 MB'ın tamamı** indiriliyor.
- Paket kaldırılırsa ilk yükleme yaklaşık 18,9 MB'tan **yaklaşık 3,2 MB**'a düşer.
- Mobil uygulama boyutu da küçülür, çünkü aynı fontlar mobil bundle'da da var.

## 3. Kullanılmayan asset'ler

`assets.gen.dart` getter'ları ve dosya adları `lib/` altında aranarak bulundu (generated dosyalar hariç). Dinamik kullanımlar kontrol edildi: `Assets.avatars.values` ve `assets/translations` yolu.

| Asset | Boyut | Not |
|---|---|---|
| `packages/material_symbols_icons` (3 font) | 32 MB disk / 15,7 MB transfer | Paket hiç kullanılmıyor |
| `assets/images/img_welcome.png` | 1,1 MB | Referans yok |
| `assets/icons/ic_car_help.png` | 16 KB | Referans yok |
| `assets/icons/ic_map_help.png` | 16 KB | Referans yok |

Notlar:
- `assets/app/` (1,4 MB) pubspec `assets:` listesinde değil, sadece `native_splash.yaml` kullanıyor. Web bundle'ına zaten girmiyor.
- PlusJakartaSans'ın 5 ağırlığının hepsi kullanılıyor (w400–w800).
- `DMSerifDisplay-Italic.ttf` ilk raporda kullanılmıyor diye listelenmişti, bu yanlıştı. `login_hero_text.dart` `displayLarge` (DMSerifDisplay) üstünde `fontStyle: .italic` kullanıyor. Arama `FontStyle.italic` ile yapıldığı için dot-shorthand yazımı kaçmıştı. Font kalıyor.

Tablodaki paket ve üç görsel kaldırıldı.

## 4. Cache politikası (`firebase.json` → `hosting[0].headers`)

**Flutter 3.44.9 dosya adlarına içerik hash'i eklemiyor.** `build/web` içinde adında hash olan dosya sayısı 0. `main.dart.js`, `flutter_bootstrap.js` ve `assets/...` her deploy'da aynı isimle geliyor.

Bu yüzden `max-age=31536000, immutable` güvenle uygulanabilecek **bir dosya yok**. Sabit isimli bir dosyaya bu header verilirse, deploy'dan sonra kullanıcılar bir yıl boyunca eski `main.dart.js`'te kalır. Versiyonlu tek içerik gstatic'teki CanvasKit; onun URL'inde engine revision var ve cache'ini Google yönetiyor.

Uygulanan politika:

| Kaynak | `Cache-Control` | Gerekçe |
|---|---|---|
| `**` (varsayılan) | `no-cache` | Tarayıcı dosyayı saklar ama her kullanımda ETag ile doğrular. Değişmemişse 304 alır, gövde tekrar inmez. Deploy anında yeni sürüm gelir, `main.dart.js` ile asset'ler birbirinden ayrışmaz. |
| `/icons/**`, `/favicon.png` | `public, max-age=86400` | Bir gün eski kalmaları uygulamayı bozmaz. |

Firebase Hosting'de aynı header'a birden fazla kural eşleşirse **sonraki kural kazanır**. Emulator'da doğrulandı: `**` önce, özel kurallar sonra geliyor.

Kabul kriterindeki `immutable` maddesi, Flutter dosya adlarına hash eklemeye başladığında ya da build'e bir fingerprint adımı eklendiğinde (örn. `main.<hash>.dart.js` + `flutter_bootstrap.js` güncellemesi) tekrar ele alınmalı.

## 5. Nasıl yeniden ölçülür

```bash
flutter build web --release
firebase emulators:start --only hosting   # target "app" .firebaserc'te tanımlı olmalı
curl -sI http://localhost:5000/main.dart.js | grep -i cache-control
```

Chrome DevTools → Network → "Disable cache" açık → sert yenileme → alt satırdaki "transferred" değeri.
