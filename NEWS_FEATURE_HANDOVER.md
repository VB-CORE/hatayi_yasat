# News Feature — Teknik Özet & Handover (PR #427: feat/news-detail-bookmark)

> Bu doküman, `feat/news-detail-bookmark` branch'inde haberler modülü üzerinde
> yapılan tüm teknik değişiklikleri kod ve git geçmişi üzerinden analiz ederek
> özetler. Amaç: PR açıklaması + ekip handover referansı.

---

## 1. Feature başlangıç durumu

Bookmark çalışmasından önce (`73a28d64` commit'inin parent'ı, `main`
üzerinde) haberler modülü şöyle çalışıyordu:

- **Model:** `NewsModel` (eski, `firebaseService`/`FirebaseCustomService`
  ekseninde) — alanlar: `documentId`, `title`, `content`, `image`,
  `createdAt`, `updatedAt`. Yazar/kategori bilgisi yoktu.
- **Data akışı:** `NewsJobsProvider.fetchNewsCollectionReference()` eski
  `firebaseService.collectionReference(CollectionPaths.news, NewsModel())`
  üzerinden okuyordu (deprecated servis).
- **Liste ekranı:** `TabNewsView` → `GeneralFirestoreListView` → `NewsCard`
  (image + gradient overlay + avatar/başlık, tam ekran tıklamayla detaya
  gidiyordu).
- **Detay ekranı:** `NewsDetailView` — üstte tam genişlik resim
  (`CustomImageWithViewDialog`, alt köşeleri yuvarlak), altında başlık,
  `_DateIconAndText` (takvim ikonu + `DateFormat.yMMMEd`), statik
  `UserSpecialCard`, içerik metni. Sadece paylaşım aksiyonu vardı
  (`shareNews`, `IconButton(AppIcons.share)`).
- **Routing:** `NewsJobsRoute` path `newsJobs`, `NewsDetailRoute` path
  `detail` (statik, id parametresi yok), `$extra: NewsModelCopy`.
- **Bookmark/Saved News:** Yoktu. Profile menüsünde ilgili giriş yoktu.
- **Kullanılan hazır component'ler:** `GeneralFirestoreListView` (life_shared),
  `CustomNetworkImage`, `CustomImageWithViewDialog`, `IconWithText`,
  `UserSpecialCard`, `PagePadding`/`CustomRadius` token'ları.

---

## 2. News liste ekranı geliştirmeleri

**Dosya:** [lib/features/main/news_jobs/view/sub_view/tab_news_view.dart](lib/features/main/news_jobs/view/sub_view/tab_news_view.dart)

- Query kaynağı `NewsJobsProvider.fetchNewsCollectionReference()` üzerinden
  değişmedi; sadece model tipi `NewsModel` → `NewsFeedModel`'e taşındı ve
  servis `firebaseService` → `firestoreService`'e geçti
  ([news_jobs_provider.dart](lib/features/main/news_jobs/provider/news_jobs_provider.dart)).
- `NewsJobsProvider`'a bookmark/saved-news ihtiyacı için yeni bir metod
  eklendi: `fetchNewsByIds(List<String> ids)` — `whereIn` sorgusu (Firestore
  limiti nedeniyle ≤30 id ile `assert`), `SavedNewsViewModel` tarafından
  kullanılıyor.
- Listeleme/pagination/refresh mekanizması **değişmedi**: hâlâ
  `GeneralFirestoreListView` (life_shared, `FirestoreListView` sarmalayıcı,
  kendi sayfalama/loading/empty state'i var) + `RefreshIndicator` +
  `KeyedSubtree(key: ValueKey(_refreshKey))` ile manuel yeniden mount ederek
  refresh.
- PR #427 review turunda: gereksiz `_refresh()` wrapper metodu kaldırıldı,
  `RefreshIndicator.onRefresh` doğrudan `() async => _retry()` ile `_retry`'yi
  çağırıyor (`_retry` `void` döndüğü için `Future<void> Function()`
  imzasına inline sarmalandı).
- UI redesign turunda: build çıktısı `Column` + üstte sabit
  `NewsSectionHeader` + `Expanded` içinde eskisiyle birebir aynı
  `RefreshIndicator`/`GeneralFirestoreListView` yapısına dönüştürüldü — liste
  davranışı korunarak sadece üstüne statik bir başlık eklendi.
- Kartın üstünde kullanılan widget: `NewsCard` ([lib/product/widget/card/index.dart](lib/product/widget/card/index.dart)
  barrel'ından import ediliyor; detaya geçiş `NewsDetailRoute(...).push<void>(context)`
  ile yapılıyor (review turunda `push<NewsDetailRoute>` → `push<void>`
  düzeltildi, çünkü route bir değer döndürmüyor).

---

## 3. News detail geliştirmeleri

**Dosyalar:** [lib/features/details/view/news_detail_view.dart](lib/features/details/view/news_detail_view.dart),
[lib/features/details/view/widget/news_detail_sub_view.dart](lib/features/details/view/widget/news_detail_sub_view.dart),
[lib/features/details/mixin/news_detail_view_mixin.dart](lib/features/details/mixin/news_detail_view_mixin.dart)

- **Layout tamamen değişti:** eski "üstte tam genişlik resim → başlık →
  tarih → statik UserSpecialCard → içerik" akışı yerine; "başlık →
  yazar+tarih meta satırı (`_NewsMetaRow`) → Hero resim → içerik" akışına
  geçildi. `UserSpecialCard` kaldırıldı (statik, gerçek veriyle ilgisi
  yoktu).
- **Hero animasyonu:** liste kartındaki görsel (`NewsCard`/`_NewsImage`) ile
  detay sayfasındaki görsel aynı `Hero(tag: ValueKey(item.documentId))`
  etiketini paylaşıyor — kart→detay geçişinde shared-element transition.
- **Routing:** `NewsDetailRoute` artık zorunlu `id` parametresi alıyor
  (`path: ':id'`, önceden statik `path: 'detail'`), `$extra` hâlâ
  `NewsModelCopy` taşıyor ama `toNewsFeedModel()` çağırıyor (önceden
  `toNewsModel()`).
- **Bookmark aksiyonu eklendi:** `AppBar.actions`'a
  `newsBookmarkViewModelProvider(news.documentId)` izleyen bir `IconButton`
  eklendi (`AppIcons.bookmark`/`bookmarkBorder` toggle).
- **Share davranışı:** `NewsDetailViewMixin.shareNews()` — `news.body` (eski
  `news.content`) + başlığı birleştirip `kartal` paketinin
  `.ext.share()` extension'ı ile paylaşıyor. Mantık değişmedi, sadece
  `NewsModel.content` → `NewsFeedModel.body` alan adı değişikliğine
  uyarlandı.
- **Tarih formatlama:**
  - İlk commit'te (`73a28d64`): `_DateIconAndText` (ikon+tarih) →
    `_NewsMetaRow`'a dönüştü, hâlâ `DateFormat.yMMMEd(context.locale.toLanguageTag())`
    kullanıyordu.
  - PR #427 review turunda: bu manuel `DateFormat` çağrısı kaldırılıp,
    projede zaten var olan
    [lib/product/utility/extension/date_time_extension.dart](lib/product/utility/extension/date_time_extension.dart)
    extension'ındaki `DateTime.shortDate` getter'ı kullanılmaya başlandı
    (`merchant_showcase_card.dart`, `group_details_info_rows.dart` gibi
    yerlerle aynı pattern). Yeni extension dosyası **oluşturulmadı**, mevcut
    olan tüketildi.
- **Yazar gösterimi:** `NewsAuthorModel` (`name`, `handle`, `avatarUrl`)
  `CustomUserAvatar` ile birlikte meta satırında gösteriliyor.

---

## 4. Bookmark / Saved News sistemi

### Neden eklendi
Kullanıcıların haberleri daha sonra okumak üzere işaretleyip, ayrı bir
"Kaydedilen Haberler" listesinden erişebilmesi için (PR #427'nin ana
konusu).

### Hive cache yapısı
**Model:** [lib/product/feature/cache/hive_v2/model/news_bookmark_cache.dart](lib/product/feature/cache/hive_v2/model/news_bookmark_cache.dart)
— `NewsBookmarkCache` (`with CacheModel, EquatableMixin`), tek alan:
`newsId` (`String`), `id` getter'ı da `newsId`'ye eşleniyor (Hive key =
haber documentId'si).

**Adapter kaydı:** [lib/product/feature/cache/hive_v2/hive_adapters.dart](lib/product/feature/cache/hive_v2/hive_adapters.dart)
`@GenerateAdapters([...])` listesine `AdapterSpec<NewsBookmarkCache>()`
eklendi → `hive_adapters.g.dart`/`hive_adapters.g.yaml`/`hive_registrar.g.dart`
generated dosyaları buna göre yeniden üretildi (build_runner).

### ProductCache entegrasyonu
[lib/product/feature/cache/product_cache.dart](lib/product/feature/cache/product_cache.dart):
```dart
late final CacheOperation<NewsBookmarkCache> newsBookmarkCache =
    HiveOperationManager<NewsBookmarkCache>(boxName: 'NewsBookmarkCache_v2');
```
(`boxName` parametresi sonradan eklendi — bkz. Bölüm 8, Hive crash fix).
`ProductCache.init()` içindeki başlangıç listesine `const NewsBookmarkCache.empty()`
eklendi.

### Bookmark toggle akışı
[lib/features/main/news_jobs/provider/news_bookmark_view_model.dart](lib/features/main/news_jobs/provider/news_bookmark_view_model.dart)
— `@riverpod` family provider, `build(String newsId)`:
- `_isSaved` getter: `productCache.newsBookmarkCache.get(newsId) != null`.
- `toggle()`: optimistic state güncellemesi (`state.copyWith(isSaved: willSave, isProcessing: true)`)
  → `add()`/`delete()` Hive işlemi → başarıyla `newsBookmarkCountViewModelProvider`'ı
  invalidate ediyor; hata durumunda state eski haline dönüyor (`on Object`
  catch).
- State şekli: [news_bookmark_state.dart](lib/features/main/news_jobs/provider/news_bookmark_state.dart)
  — `NewsBookmarkState(isSaved, isProcessing)`, standart `Equatable`+`copyWith`.
- Sayaç: [news_bookmark_count_view_model.dart](lib/features/main/news_jobs/provider/news_bookmark_count_view_model.dart)
  — `productCache.newsBookmarkCache.getAll().length` döner, profile menü
  badge'inde kullanılıyor.

### SavedNewsView nasıl çalışıyor
[lib/features/sub_feature/saved_news/provider/saved_news_view_model.dart](lib/features/sub_feature/saved_news/provider/saved_news_view_model.dart):
- `_bookmarkedIds` getter: Hive cache'teki tüm `NewsBookmarkCache`
  kayıtlarının `newsId`'lerini listeler.
- `build()`: id listesi boşsa doğrudan `const SavedNewsState()` (fetch
  başlatmadan) döner; id varsa `unawaited(_resolve(ids))` ile arka planda
  çözümleme başlatıp `isFetching: true` ile başlar (PR review turunda
  eklenen early-return optimizasyonu — Bölüm 8'de detaylı).
- `_resolve()`: id'leri 30'luk parçalara bölüp (`_whereInChunkSize = 30`)
  `NewsJobsProvider.fetchNewsByIds()` ile Firestore'dan çekiyor, sonucu
  orijinal bookmark sırasına göre diziyor, `state`'i güncelliyor. Hata
  `on Object` ile yakalanıp `isError: true`'ya çevriliyor (yutulmuyor).
- `retry()`: aynı akışı tekrar tetikliyor.
- **View:** [lib/features/sub_feature/saved_news/view/saved_news_view.dart](lib/features/sub_feature/saved_news/view/saved_news_view.dart)
  — `isFetching` → shimmer, `isError` → `GeneralNotFoundWidget` + retry,
  liste boşsa boş state, doluysa `SliverList.builder` ile `NewsCard`'lar
  (`TabNewsView`'daki ile **aynı** `NewsCard` component'i, ayrı bir kart
  yok).

### Profile menüsüne eklenen bağlantı
[lib/features/main/profile/view/widget/profile_menu_card.dart](lib/features/main/profile/view/widget/profile_menu_card.dart)
— "Kaydedilen Haberler" girişi: `AppIcons.bookmark` ikonu,
`LocaleKeys.profile_menu_savedNews`, `trailing` olarak
`newsBookmarkCountViewModelProvider` badge'i, `onTap: () => const SavedNewsRoute().push<void>(context)`.
Route: [lib/product/navigation/app_router.dart](lib/product/navigation/app_router.dart)
içinde yeni top-level `SavedNewsRoute` (`path: 'savedNews'`).

> Mimari not: bu menü girişi ilk commit'te eski `_ProfileMenuRow`+`Divider`
> yapısıyla eklenmişti; `origin/main` merge'ü ile gelen `ContentMenu`/
> `ContentMenuItem` refactor'ü ile birleştirildi (Bölüm 7).

### Hive typeId conflict problemi ve çözümü
Bkz. **Bölüm 7** (merge conflict) ve **Bölüm 8** (crash bug) — özet: ilk
commit'te `NewsBookmarkCache` typeId **14** idi; `origin/main` merge'ünde
`UserRole` da bağımsız olarak typeId **14**'ü almıştı (aynı `nextTypeId: 14`
taban değerinden ikisi de bağımsız türetilmiş). Çakışma, `UserRole`'ü 14'te
sabit tutup `NewsBookmarkCache`'i **15**'e taşıyarak (`nextTypeId: 16`)
çözüldü. Bu çözüm kod seviyesinde doğruydu ama geliştirme sırasında zaten
diskte typeId 14 ile yazılmış lokal bookmark verisi olan cihazlarda
crash'e yol açtı — bu da box adının `NewsBookmarkCache_v2` olarak
versiyonlanmasıyla (eski box'ı "orphan" bırakarak) giderildi.

---

## 5. UI redesign çalışmaları

**Ana dosya:** [lib/product/widget/card/news_card.dart](lib/product/widget/card/news_card.dart)
(hem `TabNewsView` hem `SavedNewsView` tarafından paylaşılan tek
component).

### Eski tasarım vs yeni tasarım
- **Eski:** Tam ekran görsel (`Stack` + `Positioned.fill`), üzerinde
  yukarıdan aşağı koyulaşan navy `LinearGradient` overlay, alt köşede
  şeffaf `Card` içinde avatar+yazar adı ve başlık (`context.general.textTheme`,
  beyaz metin). Kategori/tarih/açıklama/aksiyon yok. `StatelessWidget`.
- **Yeni:** Görsel üstte sabit yükseklikte (`context.sized.dynamicHeight(0.2)`),
  altında beyaz gövde (`AppColors.surface` + `CustomRadius.large`) —
  `merchant_showcase_card.dart` ile aynı "görsel üstte, kart gövdesi altta"
  pattern'i. Kart artık `ConsumerWidget` (bookmark provider'ını tüketmek
  için) ve dış sarmalayıcı `InkWell` yerine projede zaten kullanılan
  `CustomBounceable` (bounce animasyonlu tıklama, bkz.
  `general_place_card.dart` örneği).

### Eklenen kategori chip
[lib/product/widget/card/news/news_category_chip.dart](lib/product/widget/card/news/news_category_chip.dart)
— `NewsCategoryBadgeRow`: her zaman sabit "HABER" rozeti
(`AppIcons.calendarFilled`, koyu navy zemin) + `NewsFeedModel.type` doluysa
ikinci dinamik kategori rozeti. Renk/etiket türetimi
[lib/product/widget/card/news/news_category_style.dart](lib/product/widget/card/news/news_category_style.dart)
extension'ında (`String?` üzerinde `newsCategoryLabel`/`newsCategoryColor`) —
`type` serbest metin olduğu ve sabit bir enum/taxonomy olmadığı için basit,
deterministik bir hash tabanlı renk paleti (`teal`/`olive600`/`coral600`/`gold`)
kullanılıyor. **Model'e yeni alan eklenmedi**, sadece var olan `type: String?`
UI'da yorumlandı.

### Kaynak/timeAgo satırı
`_NewsMetaCaption` (kart içi private widget) — `CustomUserAvatar` + yazar
adı + `item.date?.timeAgo` (mevcut `date_time_extension.dart`'taki `timeAgo`
getter'ı, "2 saat önce" gibi göreceli süre), `AppText.caption` stiliyle.

### Description
`item.body` doluysa 2 satır (`AppConstants.kTwo`), `TextOverflow.ellipsis`,
`AppText.bodySm` — Dart pattern matching ile: `if (item.body case final body? when body.isNotEmpty)`.

### Action row
`_NewsActionRow` (private `ConsumerWidget`, kart içinde):
- **Kaydet:** `newsBookmarkViewModelProvider(item.documentId)` izleniyor,
  ikon `bookmark`/`bookmarkBorder` arasında toggle, aktifken
  `AppColors.coral` renginde. Tıklama, detay sayfasıyla **birebir aynı**
  provider/`toggle()` çağrısını kullanıyor — yeni state/provider yok.
- **Paylaş:** `NewsDetailViewMixin.shareNews()`'teki mantığın kart
  seviyesinde tekrarı (başlık+body birleştirip `.ext.share()`); yeni bir
  paylaşım servisi/provider'ı yok.
- **Devamı:** [lib/product/widget/card/news/news_read_more_button.dart](lib/product/widget/card/news/news_read_more_button.dart)
  — "Devamı →" pill butonu, kartın zaten var olan `onTap` callback'ini
  (detay sayfasına navigasyon) tetikliyor.

### Section header
[lib/features/main/news_jobs/view/widget/news_section_header.dart](lib/features/main/news_jobs/view/widget/news_section_header.dart)
— "RESMÎ KAYNAKLARDAN" (eyebrow) + "Hatay haberleri" (başlık),
`home_view.dart`'taki eyebrow+title pattern'i birebir örnek alındı
(`AppText.eyebrow` + `AppText.displayMd`).

### Yeni oluşturulan widget dosyaları (bu redesign turunda)
- `lib/product/widget/card/news/news_category_chip.dart`
- `lib/product/widget/card/news/news_category_style.dart`
- `lib/product/widget/card/news/news_read_more_button.dart`
- `lib/features/main/news_jobs/view/widget/news_section_header.dart`

### Yeni çeviri anahtarları
`assets/translations/{tr,en}.json` → `newsFeed.officialSources`,
`newsFeed.title`, `newsFeed.badge`, `newsFeed.readMore`. Kaydet/Paylaş için
zaten var olan `button.save`/`button.share` yeniden kullanıldı (yeni key
açılmadı). `locale_keys.g.dart` `lang` script'i ile (elle değil) yeniden
üretildi.

---

## 6. Architecture kararları

**Bilinçli dokunulmayan katmanlar (UI redesign turu boyunca):**
- `news_bookmark_view_model.dart`, `news_bookmark_state.dart`,
  `news_bookmark_count_view_model.dart` — provider katmanı, sadece
  view'lardan `ref.watch`/`ref.read(...).notifier` ile tüketildi.
- `saved_news_view_model.dart`, `saved_news_state.dart` — aynı şekilde.
- `news_jobs_provider.dart`, `news_feed_model.dart`, `news_author_model.dart`
  (redesign turunda) — model/veri katmanına yeni alan eklenmedi.
- Routing (`app_router.dart`, `NewsDetailRoute`/`SavedNewsRoute`), hive/cache
  katmanı (redesign turunda), repository/servis katmanı.

**Neden:** Görev kapsamı açıkça "sadece presentation/view/widget katmanı"
olarak sınırlandırıldı; bookmark/saved-news akışının davranışını bozma
riskini sıfırlamak için CLAUDE.md'deki Riverpod `@riverpod` Notifier +
`Equatable`/`copyWith` state kuralına dokunulmadı, var olan provider'lar
sadece **tüketildi**.

**Mevcut pattern'lere uyum:**
- Kart tasarımı için sıfırdan bir sistem kurmak yerine repo'da zaten var
  olan `merchant_showcase_card.dart` (görsel-üstte-kart-altta + chip) ve
  `general_place_card.dart` (`CustomBounceable` dış sarmalayıcı + iç nested
  buton) pattern'leri birebir örnek alındı.
- Renk/spacing/radius için `AppColors`/`AppText`/`AppSpacing`/`AppRadius`
  (merchant panel'in kullandığı newer token seti) ve `CustomRadius`/
  `PagePadding` (CLAUDE.md'nin andığı token seti) bir arada kullanıldı —
  bu, `news_card.dart`'ın zaten orijinalinden beri iki sistemi birlikte
  kullanan bir dosya olmasından kaynaklanıyor, redesign bu mevcut karışımı
  bozmadı.
- Kategori mapping bilinçli olarak bir **UI extension**'ı olarak tutuldu
  (`news_category_style.dart`), model/enum katmanına taşınmadı — çünkü
  `NewsFeedModel.type` sabit bir taxonomy olmayan serbest bir Firestore
  string alanı.

---

## 7. Merge ve conflict sonrası yapılanlar

`origin/main`, `feat/news-detail-bookmark`'tan ayrıldığı noktadan
(`eeae36b9`) sonra önemli refactor'lar geçirmişti (ör.
`ContentMenu`/`ContentMenuItem` mimarisi, `UserRole`/`UserModel` yeniden
yapılandırması, merchant panel, monetization redeem akışı). Bu branch'i
`origin/main`'e merge ederken 7 dosyada conflict çıktı, hepsi çözülüp stage
edildi (commit edilmedi):

| Dosya | Conflict | Çözüm |
|---|---|---|
| `assets/translations/en.json` / `tr.json` | Her iki taraf da dosya sonuna farklı yeni bölüm eklemişti (`savedNews` vs `merchantPanel`/`banned`) | İkisi de korundu, sırayla eklendi |
| `lib/features/main/profile/view/profile_view.dart` | Import çakışması (`news_bookmark_count_view_model` vs `auth_state`/`auth_view_model`) | İkisi de tutuldu |
| `lib/features/main/profile/view/widget/profile_menu_card.dart` | Eski `_ProfileMenuRow`+`Divider` mimarisi vs main'in yeni `ContentMenu`/`ContentMenuItem` mimarisi | main'in `ContentMenu` mimarisi esas alındı, "Kaydedilen Haberler" `ContentMenuItem` olarak Favoriler ile Ayarlar arasına eklendi |
| `lib/product/init/language/locale_keys.g.dart` | Her iki taraf farklı yeni key blokları üretmişti | İkisi de korundu (generated dosya, üretilen anahtarlar birleştirildi) |
| `lib/product/feature/cache/hive_v2/hive_adapters.g.dart` / `.g.yaml` | **`NewsBookmarkCache` (bu branch) ve `UserRole` (main) her ikisi de typeId 14'ü almıştı** | `UserRole` 14'te sabit tutuldu, `NewsBookmarkCache` 15'e taşındı, `nextTypeId: 16` yapıldı |

**Generated dosyalarla ilgili işlemler:** Merge sonrası ve PR review
turlarında iki kez `flutter pub run build_runner build --delete-conflicting-outputs`
çalıştırıldı (ör. `news_author_model.g.dart`'ın `color` alanı silindikten
sonra yeniden üretmek için — bu dosya projenin `.gitignore` kuralı gereği
zaten commit edilmiyor, sadece lokal). `locale_keys.g.dart` için ise proje
script'i `flutter pub run easy_localization:generate -O lib/product/init/language -f keys -o locale_keys.g.dart --source-dir assets/translations`
kullanıldı — hiçbir generated dosyaya elle müdahale edilmedi.

---

## 8. Buglar ve çözümleri

### Bug 1 — Haber detayına girince Hive crash
**Hata:** `ProviderException: type 'UserRole' is not a subtype of type
'NewsBookmarkCache' in type cast`, stack: `HiveOperationManager.get` →
`NewsBookmarkViewModel.build`.

**Root cause:** Yukarıdaki merge çözümü (`NewsBookmarkCache` 14→15) kod
seviyesinde doğruydu, ama geliştirme sırasında bu branch'in eski haliyle
(typeId 14) zaten çalıştırılmış bir simulator/cihazda `newsBookmarkCache`
kutusuna (`Box<NewsBookmarkCache>`, varsayılan ad `"NewsBookmarkCache"`)
typeId-tag'i 14 olan kayıtlar yazılmıştı. Merge sonrası typeId 14,
registrar'da artık `UserRoleAdapter`'a bağlı olduğundan, Hive o eski kaydı
okurken bir `UserRole` üretiyor, ama box `Box<NewsBookmarkCache>` tipiyle
açıldığı için cast patlıyordu.

**Çözüm:** [lib/product/feature/cache/product_cache.dart](lib/product/feature/cache/product_cache.dart)'ta
`newsBookmarkCache` için `boxName: 'NewsBookmarkCache_v2'` explicit box adı
verildi — tıpkı projenin `userCache` için zaten kullandığı
`boxName: 'UserModel_v6'` pattern'i gibi (`HiveOperationManager`'ın kendi
doc-comment'inde de tarif edilen: "model'in saklanan şekli değiştiğinde box
adını versiyonla, eski adapter'la yazılmış kayıtlar orphan kalsın"). Bu
değişiklik yeni/boş bir box açtığı için manuel simulator/uygulama verisi
temizliğine gerek kalmadan sorunu giderdi.

### Bug 2 — Riverpod generated code hatası (**news ile ilgisiz**)
`flutter run` denemesinde ~36 farklı `*_view_model.g.dart` dosyasında
(`auth_view_model.g.dart`, `merchant_panel_view_model.g.dart`,
`place_detail_view_model.g.dart`, `monetization_view_model.g.dart` vb. —
**hiçbiri news modülüne ait değil**) aynı derleme hatası:
```
Error: The return type of the method '_$X.runBuild' is 'void', which does not
match the return type, 'void Function(void Function())?', of the overridden
method, 'AnyNotifier.runBuild'.
```
**Root cause:** `pubspec.lock`'ta `riverpod`/`flutter_riverpod` (3.3.2) ile
`riverpod_annotation`/`riverpod_generator` (4.0.x) arası sürüm uyuşmazlığı —
merge'den kalma, bu branch'in news çalışmasından bağımsız, projenin genel
dependency çözümlemesiyle ilgili bir sorun. Bilinçli olarak
**düzeltilmedi** (kapsam dışı: provider/generated kod katmanına dokunmama
kuralı), ekip handover'ında ayrıca ele alınması gereken bir madde olarak
not düşüldü.

---

## 9. Güncel dosya değişiklik listesi

(`73a28d64` commit'i + üzerine binen merge + review fix'leri + Hive fix'i +
UI redesign — henüz commit edilmemiş, `git status`/`git diff HEAD` bazlı)

### Yeni oluşturulan dosyalar
- `lib/features/main/news_jobs/model/news_author_model.dart` (+`.g.dart`)
- `lib/features/main/news_jobs/model/news_feed_model.dart` (+`.g.dart`)
- `lib/features/main/news_jobs/provider/news_bookmark_view_model.dart` (+`.g.dart`)
- `lib/features/main/news_jobs/provider/news_bookmark_state.dart`
- `lib/features/main/news_jobs/provider/news_bookmark_count_view_model.dart` (+`.g.dart`)
- `lib/features/sub_feature/saved_news/provider/saved_news_state.dart`
- `lib/features/sub_feature/saved_news/provider/saved_news_view_model.dart` (+`.g.dart`)
- `lib/features/sub_feature/saved_news/view/saved_news_view.dart`
- `lib/product/feature/cache/hive_v2/model/news_bookmark_cache.dart`
- `lib/product/widget/card/news/news_category_chip.dart`
- `lib/product/widget/card/news/news_category_style.dart`
- `lib/product/widget/card/news/news_read_more_button.dart`
- `lib/features/main/news_jobs/view/widget/news_section_header.dart`

### Değiştirilen dosyalar
- `lib/features/main/news_jobs/view/sub_view/tab_news_view.dart`
- `lib/features/main/news_jobs/provider/news_jobs_provider.dart` (+`.g.dart`)
- `lib/features/details/view/news_detail_view.dart`
- `lib/features/details/view/widget/news_detail_sub_view.dart`
- `lib/features/details/mixin/news_detail_view_mixin.dart`
- `lib/features/main/profile/view/profile_view.dart`
- `lib/features/main/profile/view/widget/profile_menu_card.dart`
- `lib/product/widget/card/news_card.dart`
- `lib/product/model/news_model_copy.dart`
- `lib/product/navigation/app_router.dart` (+`.g.dart`)
- `lib/product/package/firebase/messaging_navigate.dart`
- `lib/product/utility/constants/app_icons.dart`
- `lib/product/feature/cache/hive_v2/hive_adapters.dart` (+`.g.dart`, `.g.yaml`)
- `lib/product/feature/cache/hive_v2/hive_registrar.g.dart`
- `lib/product/feature/cache/hive_v2/hive_opeartion_manager.dart`
- `lib/product/feature/cache/product_cache.dart`
- `assets/translations/en.json`, `assets/translations/tr.json`
- `lib/product/init/language/locale_keys.g.dart` (generated)

### Silinen / not
- Haberler modülü kapsamında bu branch'in kendi diff'inde **silinen dosya
  yok**. Eski `NewsModel` kullanımı `NewsFeedModel`'e taşındı, ama
  `NewsModel`'in kendi dosyası bu branch'in diff'inde görünmüyor —
  referansları güncellendi, dosyanın kendisi bu değişikliğin parçası
  değildi.
