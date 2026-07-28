# Ekran haritası — life_client (Hatay'ı Yaşat)

> **Durum: STATİK TASLAK.** Aşağıdaki tablo `lib/` okunarak çıkarıldı, henüz canlı cihazda
> doğrulanmadı. Faz 1 (keşif) çalıştığında bu dosya **canlı gözleme göre yeniden üretilir**:
> her satır `inspect_view_hierarchy` ile doğrulanır, screenshot yolu eklenir, "Needs-id"
> sütunu gerçek boşluklarla doldurulur.

## Yapılandırma
- appId: `com.hatayiyasat.app`
- cihaz / platform: `<Faz 0'da list_devices ile doldur>` · locale: `tr-TR`
- build: `flutter build ios --simulator --debug`
- install: `xcrun simctl install Booted build/ios/iphonesimulator/Runner.app`
- login: **yok**
- açılış interstitial'ları: onboarding (`id: onboardButton`, sadece ilk kurulum) ·
  "Yenilikler" sheet'i (`id: whatsNewSheet`, sürüm değişiminde)

## Ekranlar

| Ekran | Route | Nav yolu (Anasayfa'dan) | Anchor (sabit) | goto subflow | Needs-id? |
|---|---|---|---|---|---|
| Splash | `/` | açılış | `id: splashView` | — | — |
| Onboarding | `/onboard` | ilk kurulum | `id: onboardButton` | — | — |
| Ana kabuk | `/main` | — | `id: mainTabView` | — | — |
| **Anasayfa** | tab 0 | `id: homeTab` | `Mekanlar` | `goto-home` | arama alanı, filtre butonu, kategori şeridi — `Key()` ile bağlı, id CANLI DEĞİL |
| Arama (delegate) | — | arama alanına dokun | `Son Aramalar` | — | arama alanının id'si yok |
| Filtre | `/main/filter` | filtre butonu (ikon-only) | `İlçeler` | `goto-filter` | **filtre butonu ikon-only + id yok → `point:` gerekebilir** |
| Filtre sonucu | `/main/filterResult` | Filtre → `Sonucu göster` | `Filtreleme sonucu` | — | — |
| Mekan detayı | `/main/placeDetail/:id` | listeden kart | `İşletme Açıklaması` | — | kart seçimi dinamik (`place_grid_card_<ad>`, sadece grid mod) |
| **Topluluk** | tab 1 | `id: communityTab` | `Haberler` | `goto-community` | alt sekmeler (Haberler/İş İlanı/Etkinlikler) id'siz |
| Haber detayı | `/main/newsJobs/detail` | Haberler → kart | `<canlı doğrula>` | — | `<canlı doğrula>` |
| **Hatıralar** | tab 2 | `id: memoriesTab` | `Hatıralarımız Bizimle Yaşıyor` | `goto-memories` | — |
| **Favoriler** | tab 3 | `id: favoriteTab` | `Favorinizi arayın` | `goto-favorite` | — |
| Bildirimler | `/main/notifications` | AppBar zil ikonu | `Bildirimler` | — | **ikon-only, id yok** |
| Ayarlar | `/main/settings` | AppBar dişli ikonu | `Ayarlar` | `goto-settings` | **ikon-only, id yok** |
| Geliştiriciler | `/main/settings/developers` | Ayarlar → `Geliştiriciler` | `<canlı doğrula>` | — | — |
| Özel Kurumlar | `/main/specialAgency` | AppBar ⋮ → `Özel Kurumlar` | `Özel Kurumlar` | — | **⋮ menüsü ikon-only** |
| Konteyner Çarşılar | `/main/chain_stores` | AppBar ⋮ → `Konteyner Çarşılar` | `Konteyner Çarşılar` | — | ⋮ menüsü |
| Turistik Yerler | `/main/turism` | AppBar ⋮ → `Turistik Yerler` | `Turistik Yerler` | — | ⋮ menüsü + harita render'ı yavaş |
| Faydalı Linkler | `/main/useful_links` | AppBar ⋮ → `Faydalı Linkler` | `Faydalı Linkler` | — | ⋮ menüsü |
| Şehir seçimi | sheet | AppBar başlığı | `<canlı doğrula>` | — | seçim ana sayfa sorgusunu değiştirir — smoke'ta değiştirme |
| İşletme talebi | `/main/placeRequestForm` | FAB → `Yeni İşletme Talebi` | `Yeni İşletme Talebi` | — | **FAB ikon-only** · form GÖNDERME |
| Proje talebi | `/main/projectRequestForm` | FAB → `Yeni Proje Talebi` | `Yeni Proje Talebi` | — | FAB · GÖNDERME |
| Burs talebi | `/main/scholarShipRequestForm` | FAB → `Yeni Burs Talebi` | `Yeni Burs Talebi` | — | FAB · GÖNDERME |
| Etkinlikler | `/main/event` | Topluluk → `Etkinlikler` | `<canlı doğrula>` | — | — |

## Veriye bağlı alanlar (asla değere assert etme)
- Anasayfa mekan listesi, Topluluk haber/ilan/etkinlik listeleri, Favoriler, Hatıralar —
  hepsi canlı Firestore. Boş dönebilir. Sabit etiket veya boş-durum yokluğu üzerinden assert et.
- `whatsNew.title` sürüm numarası içerir → sadece `id: whatsNewSheet`.
- AppBar başlığı seçili şehirdir → sabit metin değildir.

## Selector notları
- Çift metin: `Favoriler` (tab + sayfa), `Ara` (anasayfa arama + mekan detayı çağrı),
  `Kategoriler` (anasayfa + filtre) → id ya da `index:`.
- iOS tab metni çok satırlı olabilir → tek tırnak + `[\s\S]*`.
- `GeneralSemanticKeys` enum'undaki 7 `home*` girdisi **canlı değil** (Flutter `Key` ile
  bağlanmış). Detay: `selectors.md`.

## Bilinen bulgular (mevcut suite)
- `flows/regression/basic_test.yaml` → `"Mekanlar!"` bekliyor; gerçek metin `Mekanlar`. Patlar.
- `flows/regression/smoke_tests.yaml` → `${output.home.*}` ve `${timeouts.network}` referansları
  tanımsız (`elements/common.js` sadece `output.common.*` tanımlar). Koşamaz.
- `run_tests.sh` → var olmayan flow'lara referans veriyor (`core/navigation.yaml`,
  `features/*.yaml`, `regression/full_app_test.yaml`).
