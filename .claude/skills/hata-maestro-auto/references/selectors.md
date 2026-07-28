# Selector kataloğu — life_client

İki kaynak vardır: **canlı `Semantics` id'leri** (tercih edilen) ve **TR metin anchor'ları**
(`assets/translations/tr.json`). Bu dosya statik analizden çıkarılmıştır — Faz 1'de `inspect`
ile doğrula, sapma bulursan burayı güncelle.

---

## 1. Semantics id'leri

Registry: `lib/product/widget/general/semantics/general_semantic_keys.dart`
Sarmalayıcı: `GeneralSemantic(semanticKey: GeneralSemanticKeys.x, child: …)` →
`Semantics(identifier: 'x')` → iOS `accessibilityIdentifier` / Android `resource-id`.

### Canlı (Maestro `id:` ile seçilebilir)

| id | Nerede | Kullanım |
|---|---|---|
| `splashView` | `features/splash/splash_view.dart` | splash'ın geçtiğini beklemek |
| `onboardButton` | `sub_feature/onboard/on_board_view.dart` | ilk açılış onboarding'ini kapatmak |
| `mainTabView` | `sub_feature/main_tab/main_tab_view.dart` | "ana kabuk yüklendi" anchor'ı |
| `mainTabBottomNavigation` | `main_tab_view.dart` | bottom bar'ın varlığı |
| `homeTab` | `main_tab/model/tab_model.dart` → `_TabBar` | Anasayfa sekmesi |
| `communityTab` | aynı | Topluluk sekmesi |
| `memoriesTab` | aynı | Hatıralar sekmesi |
| `favoriteTab` | aynı | Favoriler sekmesi |
| `whatsNewSheet` | `features/sub_feature/whats_new/whats_new_sheet.dart` | sürüm sheet'ini kapatmak |
| `placeDetailCallButton` | `details/view/widget/place_detail_sub_view.dart` | mekan detayı "Ara" |
| `placeDetailFindThePlaceButton` | aynı | mekan detayı "Yol Tarifi Al" |
| `place_grid_card_<mekanAdı>` | `home/view/widget/home_place_area.dart` | **dinamik**, sadece grid modda. Adı Firestore'dan gelir — asla sabit bir ada assert etme. |

### ⚠️ Enum'da tanımlı ama CANLI DEĞİL

`GeneralSemanticKeys` şunları da tanımlar, ancak `home_view.dart` / `home_categories_area.dart`
bunları **`Semantics` yerine Flutter `Key(...)` ile** bağlar. Flutter `Key` native
erişilebilirlik id'si ÜRETMEZ → Maestro bunları göremez. Bunlara `id:` ile erişmeye çalışma:

`homeView` · `homeScrollView` · `homeSliverAppBar` · `homeSearchFilterRow` ·
`homeSearchField` · `homeFilterButton` · `homeCategoriesSection`

→ Bu kontroller için aşağıdaki TR metin anchor'larını kullan; hepsi Faz 3 "needs-id" adayıdır.
Filtre butonu ikon-only olduğu için metinle de seçilemez — konumdan (`point:`) veya
komşusundan git, ve raporda işaretle.

---

## 2. TR metin anchor'ları (`assets/translations/tr.json`)

`assertVisible` / `tapOn` **tam regex**'tir; aşağıdaki değerleri birebir kullan.

### Kabuk ve sekmeler
| Anchor | Locale key | Not |
|---|---|---|
| `Anasayfa` | `navigationTabs.home` | tab; iOS'ta `'Anasayfa[\s\S]*'` gerekebilir |
| `Topluluk` | `navigationTabs.community` | tab |
| `Hatıralar` | `navigationTabs.memories` | tab |
| `Favoriler` | `navigationTabs.favorite` | tab — **sayfa başlığıyla çakışır**, `id: favoriteTab` tercih et |

### Anasayfa
| Anchor | Locale key |
|---|---|
| `Mekanlar` | `home.places` — ana ekranın birincil anchor'ı |
| `Mekan ara` | `search.place` — arama alanı placeholder'ı |
| `Kategoriler` | `home.categories` |
| `Sonuç Bulunamadı` | `message.emptySearch` |

> Mevcut `maestro/flows/regression/basic_test.yaml` `"Mekanlar!"` bekliyor — gerçek metinde
> ünlem YOK, bu assert her koşuda patlar. Doğrusu `Mekanlar`.

### Mekan detayı
`İşletme Açıklaması` (`placeDetailView.description`) · `Adres Bilgisi` (`.address`) ·
`Telefon Numarası` (`.phoneNumber`) · `Çalışma Saatleri` (`.workingHours`) ·
`Ara` (`.call`) · `Yol Tarifi Al` (`.find_the_place`)

> `Ara` metni `home.search` ile de çakışır — mekan detayında `id: placeDetailCallButton` kullan.

### Topluluk (news_jobs alt sekmeleri)
`Haberler` (`navigationTabs.news`) · `İş İlanı` (`navigationTabs.advertise`) ·
`Etkinlikler` (`navigationTabs.activities`) · boş durum: `Haberler henüz girilmemiş.` (`notFound.news`)

### Hatıralar
`Hatıralarımız Bizimle Yaşıyor` (`historyPage.welcomeTitle`) · `Favori Anılarım`
(`historyPage.favorites.title`) · boş: `Henüz hatıra bulunamadı.` (`notFound.memories`)

### Favoriler
`Favorinizi arayın` (`favorite.search`) — **sayfanın benzersiz anchor'ı, başlığı değil** ·
`Tümünü Temizle` (`favorite.clearAllButton`) · boş: `Favori listeniz boş` (`message.emptyFavorite`)

### Filtre
`İlçeler` (`component.filter.districts`) · `Kategoriler` (`component.filter.categories`) ·
`Sonucu göster` (`button.showResult`) · `Filtreleme sonucu` (`component.filter.filterResult`) ·
boş: `Seçtiğiniz filtreleme kriterlerine uygun sonuç bulunamadı.` (`component.filter.resultEmpty`)

### AppBar "üç nokta" menüsü
`Özel Kurumlar` (`specialAgency.title`) · `Konteyner Çarşılar` (`chain_stores.title`) ·
`Turistik Yerler` (`tourismView.title`) · `Faydalı Linkler` (`usefulLink.title`)

### FAB speed dial (form açar — GÖNDERME)
`Yeni İşletme Talebi` (`requestCompany.title`) · `Yeni Proje Talebi` (`projectRequest.title`) ·
`Yeni Burs Talebi` (`requestScholarship.title`)

### Ayarlar
`Ayarlar` (`settings.title`) · `Dil` (`settings.languageTitle`) ·
`Geliştiriciler` (`settings.developersTitle`) · `Uygulama hakkında` (`settings.aboutTitle`)

### Sürüm sheet'i
`Yenilikler v8.1.0 🎉` (`whatsNew.title`) — **sürüme bağlı, kullanma.**
Her zaman `id: whatsNewSheet`.

---

## 3. Yakalanan tuzaklar

- **Çift metin:** "Favoriler" (tab + sayfa), "Ara" (home arama + detay çağrı), "Kategoriler"
  (home + filtre ekranı). Id ya da `index:` ile ayır.
- **iOS tab erişilebilirlik metni** çok satırlı olabilir (`"Topluluk\nTab 2 of 4"`). Tek tırnak
  içinde `'Topluluk[\s\S]*'` yaz — çift tırnak ters bölü yüzünden bozulur.
- **Firestore verisi test verisi değil.** Mekan/haber/etkinlik adları her koşuda değişebilir,
  liste boş dönebilir. Yapısal assert kullan, isim assert'i kullanma.
- **Şehir seçimi** (`RegionalCitySheet`) ana sayfa sorgusunu değiştirir; keşifte şehri
  değiştirdiysen sonraki flow'lar farklı veri görür. Bootstrap'i şehir değiştirmeden bırak.
