---
name: hata-maestro-auto
description: >
  life_client (Hatay'ı Yaşat) uygulamasını Maestro MCP üzerinden CANLI sürerek keşfeden ve
  ana akışlar için çalışır bir smoke suite üreten otonom UI-test skill'i. MCP'ye bağlanır,
  iOS simulator'ü hazırlar, uygulamayı adım adım gezer, her ekranın screenshot'ını alır,
  `references/screen-map.md` ekran haritasını YENİDEN üretir ve `maestro/flows/smoke/*.yaml`
  akışlarını yazıp yeşile boyar. Dart test YAZMAZ; sadece YAML flow üretir. Kaynak koda
  (lib/) DOKUNMAZ — bir kontrolün stabil selector'ı yoksa "needs-id" olarak rapor eder,
  düzeltmeyi kullanıcıya sorar. Şu ifadelerde tetiklenir: "maestro autopilot", "otonom smoke kur",
  "explore edip smoke test yaz", "ekranlarıma göre smoke testi yaz", "maestro ile test üret",
  "keşfet ve test üret", "/hata-maestro-auto". Tek bir ekrana hedefli E2E test eklemek için
  `maestro-add` skill'ini kullan; bu skill tüm ana akışları keşfedip suite kurar.
invocation: /hata-maestro-auto, /maestro-auto
---

# hata-maestro-auto — life_client smoke autopilot

Canlı uygulamayı **Maestro MCP** ile sürersin, gezersin, arkanda çalışır bir smoke suite
bırakırsın. Bildiğin her şeyi **canlı** öğrenirsin (`inspect` + `screenshot`), ezberden değil.
Bu dosya projeye özeldir — appId, akışlar, selector'lar ve klasör düzeni life_client'a göredir.

Başlamadan önce oku:
- `references/screen-map.md` — ekran haritası (Faz 1'de YENİDEN üretilir, kaynak-of-truth)
- `references/selectors.md` — canlı `Semantics` id'leri + TR metin anchor'ları tablosu
- `references/flow-templates.md` — bu projeye ait `bootstrap` / `goto-*` / smoke starter'ları
- `references/key-injection.md` — selector yoksa ne yapılır (kod DEĞİŞTİRMEZ, önerir)

---

## Proje gerçekleri (ezberleme, ama buradan başla)

| | |
|---|---|
| appId | `com.hatayiyasat.app` |
| Platform | iOS simulator (varsayılan). Android emulator opsiyonel. |
| Build | `flutter build ios --simulator --debug` → `build/ios/iphonesimulator/Runner.app` |
| Install | `xcrun simctl install Booted build/ios/iphonesimulator/Runner.app` |
| **Login** | **YOK.** Uygulamada auth ekranı yoktur — `.env`/credential akışı bu projede geçersizdir. |
| Locale | **TR.** Tüm metin selector'ları `assets/translations/tr.json` içindeki değerlerden alınır. |
| Backend | Canlı Firestore. Veri değişkendir — asla belirli bir mekan/haber adına assert etme. |
| Flow klasörü | Repoda zaten var: `maestro/` (`.maestro/` AÇMA, mevcut olanı kullan) |
| Id registry | `lib/product/widget/general/semantics/general_semantic_keys.dart` (`GeneralSemanticKeys` enum) + `GeneralSemantic` sarmalayıcı widget |

Açılış akışı: `launchApp` → **SplashView** (`splashView`) → ilk kurulumsa **OnBoarView**
(`onboardButton`) → **MainTabView** (`mainTabView`) → sürüm değiştiyse **WhatsNewSheet**
(`whatsNewSheet`) post-frame açılır. Bootstrap bu üçünü de `when:`-guard ile geçmelidir.

---

## Değişmez kurallar

1. **MCP + canlı UI.** Her şey Maestro MCP araçlarıyla: `list_devices`, `start_device`,
   `launch_app`, `inspect_view_hierarchy`, `take_screenshot`, `tap_on`, `input_text`,
   `run_flow`, `run_flow_files`, `check_flow_syntax`, `back`, `stop_app`. Sözdiziminden emin
   değilsen `cheat_sheet` / `query_docs` çağır.
2. **Inspect etmeden selector yazma.** `inspect` → gerçek ağacı oku → seç. Her
   navigasyondan SONRA yeniden inspect et; bayat ağaç yanlış eşleşme üretir.
3. **Selector önceliği:** (a) `GeneralSemanticKeys`'te tanımlı ve **canlı** id → `id:`;
   (b) `tr.json`'dan gelen sabit TR metin; (c) son çare `point:` — ve o kontrol otomatik
   "needs-id" adayıdır (Faz 3).
4. **Kaynak koda dokunma.** Bu skill `lib/` altında hiçbir dosyayı DEĞİŞTİRMEZ. Bir kontrol
   seçilemiyorsa haritaya "needs-id" yazar ve kullanıcıya sorar. Onay gelirse
   `references/key-injection.md` prosedürü uygulanır — ondan önce değil.
5. **Değişken veriye assert etme.** Firestore'dan gelen mekan/haber/etkinlik adları, sayılar,
   tarihler test verisi değildir. Sabit UI etiketlerine assert et ("Mekanlar", "Kategoriler").
   Liste doluluğunu kanıtlaman gerekiyorsa "en az bir kart var" tarzı yapısal assert kullan.
6. **Metin eşleşmesi:** YAML `assertVisible`/`tapOn: "…"` TAM regex'tir — `"Mekanlar"`,
   `"Mekanlar!"` ile eşleşmez. MCP `tap_on` aracı varsayılan olarak fuzzy eşler;
   kesinlik gerektiğinde `use_fuzzy_matching:false` geç. Çok satırlı erişilebilirlik metni
   (iOS tab'larında sık: `"Favoriler\nTab 4 of 4"`) → **tek tırnak** içinde `[\s\S]*` kuyruğu.
   Tekrar eden metin (tab "Favoriler" vs sayfa başlığı "Favoriler") → `index:` ile ayır,
   ya da id kullan.
7. **Sürüme bağlı metin yok.** `whatsNew.title` = `Yenilikler v8.1.0 🎉` — sürümle değişir.
   Bu sheet'i **her zaman** `id: whatsNewSheet` ile yakala, metinle değil.
8. **Hata protokolü (daima açık):** flow patlarsa ya da uygulama takılırsa (sonsuz shimmer,
   ekran gelmiyor) **DUR** — körlemesine retry etme, etrafından dolaşma.
   `take_screenshot` → `maestro/reports/errors/NN-<adım>.png`, patlayan adımı + ekranda ne
   olduğunu + log satırını raporla, bekle. Takılan ekran başlı başına bir bulgudur.
9. **Yeni id gerekirse rebuild şart.** `Semantics(identifier:)` widget ağacına derlenir;
   eklendiği anda görünmez. Kullanıcı onay verirse rebuild + reinstall'u işe dahil et.
10. **Flutter `Key` ≠ erişilebilirlik id'si.** `Key('homeSearchField')` Maestro'ya GÖRÜNMEZ.
    Sadece `Semantics(identifier:)` (yani `GeneralSemantic`) native id üretir. Enum'da adı
    geçen her key canlı değildir — `references/selectors.md`'deki "canlı mı" sütununa bak.

---

## Faz 0 — Bağlan ve hazırla

1. **MCP bağlı mı?** Maestro araçlarından biri (`list_devices`) çağrılabiliyorsa hazırsın.
   Değilse: repo kökündeki `.mcp.json` maestro sunucusunu tanımlar (`maestro mcp`); Claude
   Code'un yeniden başlatılması gerekir. Kullanıcıya bunu söyle, uydurma araç çağırma.
2. **Cihaz:** `list_devices` → booted bir iOS simulator varsa onu kullan, yoksa `start_device`.
3. **Kurulum:** `build/ios/iphonesimulator/Runner.app` güncel mi? Değilse
   `maestro/run.sh --build` ile build + install et (veya komutları elle sür). Kurulum
   yoksa `launch_app` sessizce eski binary'yi açar — önce bunu doğrula.
4. **Bootstrap'i kanıtla:** `maestro/flows/core/bootstrap.yaml`'ı **arka arkaya iki kez**
   yeşile boya. Biri `clearState` ile (onboarding + whats-new yolu), biri onsuz (sıcak açılış).
   Bu ikisi geçmeden Faz 1'e geçme.

---

## Faz 1 — Otonom keşif (her state'in screenshot'ı)

Kullanıcı bir hedef verir ("ekranlarıma göre smoke yaz" / "sadece haritayı çıkar"); sen canlı
sürersin, adım adım tap sormazsın.

1. `bootstrap` → home. Tüm koşu boyunca geçerli direktif: **her majör state'ten sonra
   `take_screenshot`** → `maestro/reports/explore-<alan>/NN-<etiket>.png`, storyboard gibi
   okunacak şekilde numaralı.
2. Döngü, tek seferde tek aksiyon, daima canlı ağaçtan: `inspect` → ekranda GERÇEKTEN olandan
   sıradaki tek aksiyonu seç (`tap_on`/`input_text`/`swipe`/`scrollUntilVisible`/`back`) →
   uygula → screenshot → yeniden inspect. Asla ezberden batch yapma.
3. **Gezilecek ana akışlar** (life_client'ın kritik yüzeyi):
   - **Bottom nav 4 sekme:** Anasayfa → Topluluk → Hatıralar → Favoriler
   - **Anasayfa:** kategori chip'leri, arama alanı (`showSearch` delegate'i açılır),
     filtre butonu → Filtre ekranı → Sonucu göster → Filtre sonucu
   - **Mekan detayı:** listeden bir karta gir → "Ara" / "Yol Tarifi Al" (bu ikisinin canlı
     id'si var), açıklama/adres alanları → geri
   - **Topluluk:** Haberler / İş İlanı / Etkinlikler alt sekmeleri, bir habere gir
   - **AppBar:** şehir seçim sheet'i, bildirimler, ayarlar, "üç nokta" menüsü
     (Özel Kurumlar / Konteyner Çarşılar / Turistik Yerler / Faydalı Linkler)
   - **FAB speed dial:** Yeni İşletme Talebi / Yeni Proje Talebi / Yeni Burs Talebi
     (formu AÇ ve geri dön — **gönderme**, canlı Firestore'a yazma)
   - **Ayarlar:** dil, tema, geliştiriciler
4. Geçerken boş/bozuk/beklenmedik olan her şeyi bulgu olarak işaretle (muhtemel bug repro'su).
5. **`references/screen-map.md`'yi yeniden üret** — gezdiğin haliyle: her ekran için giriş
   route'u, nav yolu, dayanıklı anchor, kullanılacak selector'lar, "needs-id" işaretleri.
   Bu dosyayı her koşuda güncel tut; eskimiş harita yanlış flow yazdırır.
6. State sırasını screenshot yollarıyla + bulgularla raporla.

---

## Faz 2 — Smoke suite'i yaz

1. **Kritik yol** (kırılmaması gereken): launch → splash/onboard/whats-new geçişi → ana sayfa
   yüklendi → 4 sekme dolaşımı → arama açılıyor → filtre → mekan detayı → geri.
   İnsanın release öncesi elle bakacağı kadarını kapsa, fazlasını değil.
2. Flow'lar `maestro/flows/smoke/` altına; her biri `- runFlow: ../core/bootstrap.yaml` ile
   başlar ve varsa `goto-<ekran>.yaml` alt akışını yeniden kullanır. Sadece **sabit anchor**'a
   assert et. Her flow için `check_flow_syntax` → sonra `run_flow_files` ile canlı yeşile boya.
   Her UI adımından sonra yeniden inspect et.
3. Gerçek bir uygulama hatasına çarparsan kural 8: DUR, `maestro/flows/bugs/` altına repro
   bırak, raporla — üstünü örtme.
4. Tekrar tekrar yeşil kalan flow'ları `maestro/flows/regression/` altına terfi ettir
   (`tags: [regression, <alan>]`). Regression seti sadece büyür.
5. `references/screen-map.md` + kısa bir `maestro/reports/<koşu>.md` yaz.

---

## Faz 3 — Selector boşlukları (kod DEĞİŞTİRMEDEN)

Bir kontrolün stabil selector'ı yoksa (ikon-only, metinsiz, çift metin, `point:` ile
tapladın):

1. Boşluğu canlı kanıtla: `inspect` çıktısında `resource-id` yok ve benzersiz metin yok.
2. Widget'ı `lib/` içinde bul (yakın etiketi, ikon adını, callback'i grep'le).
3. **Kod yazma.** `references/screen-map.md`'nin "Needs-id" sütununa ve koşu raporuna yaz:
   hangi kontrol, hangi dosya, önerilen `GeneralSemanticKeys` girdisi.
4. Kullanıcıya tek soruda sor: "şu N kontrole `GeneralSemantic` ekleyeyim mi?" Onay gelirse
   `references/key-injection.md` prosedürünü uygula (registry'ye enum girdisi + `GeneralSemantic`
   sarmalama + `dart format`/`dart analyze` + rebuild + reinstall + `id:`'ye geçiş).
   Onay gelmezse flow'u metin/point selector'la bırak ve haritada işaretli tut.

---

## Klasör sözleşmesi (mevcut `maestro/` düzeni)

```
maestro/
├── config.yaml              appId + flow glob'ları
├── elements/                page-object: common.js (GeneralSemanticKeys aynası) + loadElements.yaml
├── flows/
│   ├── core/                bootstrap, handle_onboarding, handle_splash, dismiss_whats_new, goto-*
│   ├── smoke/       [smoke]       kritik yol — daima yeşil
│   ├── regression/  [regression]  terfi etmiş, stabil — sadece büyür
│   └── bugs/        [bug]         repro'lar (fix öncesi)
├── reports/                 screenshot / koşu notları (gitignore)
│   └── errors/              hata anı screenshot'ları
└── run.sh                   simulator boot + build + install + flow koşumu
```

## Her koşunun çıktısı

Kısa bir `maestro/reports/<koşu>.md` + sohbet özeti:
**Gezilen** (ekranlar + screenshot yolları) · **Suite** (eklenen/terfi eden flow'lar, tag'ler) ·
**Needs-id** (selector'ı olmayan kontroller + önerilen enum girdisi, ya da "yok") ·
**Sonuç** (✅/❌/⚠️ flow bazında) · **Bloke** (patlayan adım, ekran durumu, log). Kısa ve taranabilir.
