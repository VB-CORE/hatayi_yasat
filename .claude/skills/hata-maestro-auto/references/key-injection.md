# Selector boşluğu prosedürü — life_client

Bu skill **varsayılan olarak `lib/` altına yazmaz.** Aşağıdaki adım 1–3 her koşuda yapılır
(tespit + rapor). Adım 4+ **yalnızca kullanıcı açıkça onay verirse** uygulanır.

## Neden `Key` yetmiyor
`Semantics(identifier: 'foo')` native erişilebilirlik id'sine map'lenir — iOS
`accessibilityIdentifier`, Android `resource-id` — Maestro bunu `id: "foo"` ile eşler.
Flutter `Key`/`ValueKey` native id ÜRETMEZ; widget testleri içindir, Maestro'ya görünmez.
Bu yüzden `home_view.dart`'taki `Key('homeSearchField')` gibi tanımlar Maestro açısından yoktur.

## 1–3: Tespit ve rapor (her zaman)
1. **Boşluğu canlı kanıtla.** `inspect_view_hierarchy` çıktısında hedef kontrolde
   `resource-id` yok ve benzersiz metin de yok. (Sabit metin VARSA id ekleme — metni kullan.)
2. **Widget'ı bul.** `lib/` içinde yakın etiketi, ikon adını ya da callback'i grep'le.
3. **Raporla.** `references/screen-map.md` "Needs-id" sütununa + koşu raporuna yaz:
   kontrol · dosya:satır · önerilen enum girdisi. Flow'u metin/`point:` selector'la bırak,
   haritada işaretli tut. **Burada dur.**

## 4+: Uygulama (sadece onay sonrası)

Proje konvansiyonu: ham `Semantics(...)` yazılmaz, `GeneralSemantic` kullanılır.

4. **Registry'ye ekle** — `lib/product/widget/general/semantics/general_semantic_keys.dart`:
   ```dart
   enum GeneralSemanticKeys {
     // …
     homeFilterButton('homeFilterButton'),
   ```
   İsimlendirme: `lowerCamelCase` enum adı, değeri **aynı string**, alan öneki ile
   (`home*`, `placeDetail*`, `settings*`).

5. **Kontrolü sar** — dokunulabilir en küçük widget'ı:
   ```dart
   GeneralSemantic(
     semanticKey: GeneralSemanticKeys.homeFilterButton,
     child: ElevatedButton(…),
   )
   ```
   - `part` dosyasındaysan import'lar ana dosyada (`home_view.dart`) olmalı:
     `general_semantic.dart` + `general_semantic_keys.dart`.
   - Var olan `Key(...)` tanımını **silme gerekmiyorsa dokunma**; widget testleri kullanıyor olabilir.

6. **Sliver uyarısı.** `Semantics` bir **box** widget'ıdır; `SliverAppBar`, `SliverPadding`,
   `SliverList` gibi sliver'ları doğrudan saramazsın — derleme/runtime hatası verir.
   Sliver'ın box çocuğunu sar (ör. `SliverAppBar`'ın `title:`'ı, `SliverPadding`'in içindeki
   `SizedBox`), ya da `.ext.sliver` dönüşümünden **önce** sar.

7. **Statik doğrula.** `dart format <dosyalar>` + `dart analyze <dosyalar>` — temiz olmalı.

8. **Rebuild + reinstall.** Yeni id widget ağacına derlenir; eklendiği anda görünmez.
   `flutter build ios --simulator --debug` → `xcrun simctl install Booted …`. Sonra
   `launch_app` + `inspect_view_hierarchy` ile id'nin gerçekten `resource-id` olarak
   çıktığını doğrula.

9. **Flow'u çevir.** Selector'ı `id:`'ye geçir, yeniden yeşile boya.

## Sınırlar
- Test geçsin diye **mantık, layout ya da metin değiştirilmez.** Tek izinli değişiklik
  erişilebilirlik id'si eklemektir. Gerçek bir bug flow'u bloke ediyorsa DUR ve raporla.
- Sadece smoke suite'in **gerçekten kullandığı** kontrollere id ekle.
- Widget'ı güvenle bulup değiştiremiyorsan zorlama: haritada "needs-id" bırak, devam et.
