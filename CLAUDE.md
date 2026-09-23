# CLAUDE.md — life_client Konvansiyonları

> Bu dosya, projede iş yapan herkes (ve Claude) için **tek doğru kaynaktır**.
> `.claude/skills/*` ve `.claude/agents/*` bu kurallara referans verir; kuralları
> tekrar etmez. Bir konvansiyon değişecekse önce burada değişir.

Proje: Hatay **life_client** — Flutter + Firebase mobil uygulaması.
Stack: Flutter, `flutter_riverpod` (v3, `@riverpod` codegen), `get_it`, `go_router` +
`go_router_builder`, Firebase (Firestore/Functions/Messaging), `hive_ce`,
`easy_localization`, `very_good_analysis`.

---

## 1. Mimari

**Feature-first + paylaşılan `product/` katmanı.**

```
lib/
├── core/            # DI (project_dependency*.dart), düşük seviye altyapı
├── features/        # ana feature'lar (her biri kendi viewmodel+view)
│   └── sub_feature/ # ikincil/modüler feature'lar
├── sub_feature/     # uygulama kabuğu (main_tab, onboard, ...)
├── product/         # paylaşılan: navigation, init, widget, utility, model
└── main.dart
```

Bir feature'ın iç yapısı:

```
lib/features/<feature>/
├── provider/                 # (veya view_model/) state mantığı
│   ├── <feature>_view_model.dart
│   ├── <feature>_view_model.g.dart    # üretilen (commit EDİLMEZ)
│   └── <feature>_state.dart
├── view/
│   ├── <feature>_view.dart
│   ├── mixin/                # initState/dispose/iş mantığı mixin'leri
│   └── widget/               # parçalanmış alt widget'lar
```

İsimlendirme: `*_view_model.dart`, `*_state.dart`, `*_view.dart`, mixin `*_mixin.dart`,
model `*_model.dart`. Sınıf isimleri `XViewModel`, `XState`, `XView`, `XModel`.

---

## 2. State Management — Riverpod `@riverpod` Notifier

**Freezed YOK.** State = `Equatable` + manuel `copyWith()`. Async için `AsyncValue`
yerine **açık `isLoading` / `isFetching` / `isError` flag'leri**.

### ViewModel

```dart
part 'home_view_model.g.dart';

@riverpod
final class HomeViewModel extends _$HomeViewModel with ProjectDependencyMixin {
  @override
  HomeState build() {
    final categories = ref.read(productProviderState).categoryItems;
    return HomeState(categories: categories);
  }

  void changeHomeViewCardType() {
    state = state.copyWith(isGridView: !state.isGridView);
  }

  Future<void> fetchStoreModel(String id) async {
    state = state.copyWith(isFetching: true);
    final result = await firestoreService.getSingleData<StoreModel>(/* ... */);
    state = switch (result) {
      FirebaseSuccess(:final data) =>
        state.copyWith(storeModel: data, isFetching: false, isError: data == null),
      FirebaseFailure() => state.copyWith(isFetching: false, isError: true),
    };
  }
}
```

- `@riverpod final class XViewModel extends _$XViewModel with ProjectDependencyMixin`.
- `build()` initial state'i kurar (provider/cache'ten okuyarak).
- Mutasyon **daima** `state = state.copyWith(...)` ile. Asla doğrudan alan ataması yok.
- İstisnayı yutma; hata flag'ine çevir (`isError: true`).

Referans: [home_view_model.dart](lib/features/main/home/provider/home_view_model.dart),
[place_detail_view_model.dart](lib/features/place_detail/view_model/place_detail_view_model.dart).

### State

```dart
final class HomeState extends Equatable {
  const HomeState({
    required this.categories,
    this.isGridView = false,
    this.isLoading = false,
  });

  final List<CategoryModel> categories;
  final bool isGridView;
  final bool isLoading;

  @override
  List<Object> get props => [categories, isGridView, isLoading];

  HomeState copyWith({
    List<CategoryModel>? categories,
    bool? isGridView,
    bool? isLoading,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      isGridView: isGridView ?? this.isGridView,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
```

- `final class XState extends Equatable`, tüm alanlar `final`, varsayılan değerli.
- `props` tüm alanları içerir. `copyWith` manuel.

Referans: [home_state.dart](lib/features/main/home/provider/home_state.dart).

---

## 3. Dependency Injection — GetIt + Riverpod hibrit

- Servisler/global provider'lar GetIt'te kurulur: [project_dependency.dart](lib/core/dependency/project_dependency.dart),
  `ApplicationInit.start()` içinde `ProjectDependency.setup()`.
- **ViewModel içinde** servise erişim → `ProjectDependencyMixin`
  ([project_dependency_mixin.dart](lib/core/dependency/project_dependency_mixin.dart)):
  `firestoreService`, `storageService`, `appProvider`, `productProvider`, `productCache`,
  `appProviderState`, `productProviderState`.

### Firebase servisleri (geçiş dönemi)

life_shared v5.4.17 ile Firebase erişimi ikiye ayrıldı; **iki servis bir süre yan yana yaşayacak**:

| | Yeni (kullan) | Eski (deprecated) |
|---|---|---|
| Firestore | `firestoreService` → `CustomFirestoreService` | `firebaseService` → `FirebaseCustomService` |
| Storage | `storageService` → `CustomStorageService` | `FirebaseStorageService()` (inline) |

- **Yeni yazılan her şey `firestoreService` / `storageService` kullanır.** Eski servis yalnızca
  henüz migrate edilmemiş çağrı yerleri için ayakta; yeni kodda kullanılırsa deprecation uyarısı verir.
- Yeni servisler `FirestoreResult<T>` / `StorageResult<T>` döner (`FirebaseSuccess` | `FirebaseFailure`).
  Hata artık yutulmuyor: timeout, permission, parse hataları `FirestoreError` / `StorageError`
  enum'ıyla geliyor. `switch` ile ayrıştır; `dataOrNull` sadece hatayı gerçekten önemsemediğin
  yerde kullanılır.
- Toplu migrasyon **yapılmıyor**; bir dosyaya zaten dokunuyorsan o dosyayı çevirmek serbest.

### Firestore rules ve index'ler bu repoda değil

`firestore.rules` ve `firestore.indexes.json` **life_admin** reposunda yaşar
(`firebase/` altında) ve oradan deploy edilir; iki uygulama aynı `savehatay`
projesini paylaştığı için tek kaynak olmak zorundalar. Bu repodaki kopyalar
bilerek silindi.

Client'ta yeni bir yazma yolu açan her değişiklik (yeni koleksiyon, soft-delete,
sayaç, alan) **aynı PR'da life_admin'deki rules'a taşınmalı**, `firebase/test/`
altına testi eklenmeli ve deploy edilmeli. Aksi halde kod prod'da
permission-denied alır.
- **Widget içinde** global state erişimi → `AppProviderMixin<T>` (ConsumerStatefulWidget) /
  `AppProviderStateMixin` (ConsumerWidget)
  ([app_provider_mixin.dart](lib/product/utility/mixin/app_provider_mixin.dart)):
  `appProvider`, `appState`, `productProvider`, `productState`, `productStateWatch`.
- **View dosyasında `GetIt.I` çağrısı YASAK.** Daima mixin üstünden.

---

## 4. View

- `ConsumerStatefulWidget` / `ConsumerWidget` (asla düz `StatefulWidget`).
- State sınıfı `AppProviderMixin<XView>` + feature mixin'leriyle karışır.
- State'i `ref.watch(xViewModelProvider)` ile izle, aksiyonu
  `ref.read(xViewModelProvider.notifier).method()` ile çağır.
- Koşullu render: `isError` → hata widget'ı, yükleniyor → shimmer, dolu → içerik.

```dart
final class _PlaceDetailViewState extends ConsumerState<PlaceDetailView>
    with AppProviderMixin<PlaceDetailView>, PlaceDetailViewMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(placeDetailViewModelProvider);
    if (state.isError) return Scaffold(body: GeneralNotFoundWidget(...));
    if (state.isFetching) return const Scaffold(body: PlaceShimmerList());
    return Scaffold(/* content */);
  }
}
```

---

## 5. Routing — go_router_builder (typed)

`@TypedGoRoute<XRoute>` + `final class XRoute extends GoRouteData with $XRoute`,
`build()` widget'ı döner. Karmaşık nesne geçişi `$extra` ile. Codegen sonrası
`app_router.g.dart` üretilir (commit edilmez). Referans: [app_router.dart](lib/product/navigation/app_router.dart).

### `go` vs `push` (sert kural)

- **Guard'lı (redirect'li) rotalara daima `go`.** `push` imperative'dir: declarative
  URI değişmez, `refreshListenable` tetiklendiğinde go_router yalnızca declarative
  location'ı yeniden değerlendirir — pushed sayfanın redirect'i bir daha çalışmaz.
  (Örnek bug: push ile açılan login, girişten sonra ekranda takılı kalır.)
- `push` yalnızca guard'sız, geçici overlay sayfalar için kullanılabilir.
- `go` stack'i route ağacından türettiği için geri tuşunun çalışması istenen rotalar
  parent'ın `routes:` listesinde alt-rota olarak tanımlanır (örn. `/groups/create-group`).
- Auth navigasyon politikası router'dadır (`AuthGuard` + route `redirect`'leri);
  view içinden auth amaçlı `context.go/push` yazılmaz. Login dönüş adresi resmi
  go_router deseniyle `from` query parametresi üzerinden taşınır.

---

## 6. Styling (sert kurallar — lint/review reddeder)

### Renk
- Daima `context.general.colorScheme.*` (primary/secondary/surface/onSurface/...).
- Sabit palet: `ColorsCustom` ([colors_custom.dart](lib/product/utility/decorations/colors_custom.dart)) —
  `sambacus`, `endless`, `brandeisBlue`, `lightGray`, `warmGrey`, `royalPeacock`, ...
- View içinde `Color(0x...)` / `Colors.<name>` / `Theme.of(context)` **yasak** (tema tanım dosyaları hariç).
- Eksik renk gerekiyorsa çağrı yerine değil, **temaya** ekle.

### Spacing & boyut
- Padding: `PagePadding.*` (örn. `PagePadding.defaultPadding()`, `vertical12Symmetric()`). Ham `EdgeInsets` yasak.
- Dikey boşluk: `EmptyBox.*` (`smallHeight`/`middleHeight`/`largeHeight`) veya `VerticalSpace.*`.
- Ölçek: `WidgetSizes.spacing*` (life_shared). Hardcoded piksel yasak.
- Responsive: `context.sized.dynamicHeight/Width(...)` (mevcut kullanım). Web'de bu
  API'lerin durumu kesinleşmedi, bkz. §9 Web → Layout (bekliyor WEB-12).

### Radius
- `CustomRadius.*` ([custom_radius.dart](lib/product/utility/decorations/custom_radius.dart)):
  `small`(8) / `medium`(12) / `large`(16) / `extraLarge`(24) / `xxLarge`(32). Ham `BorderRadius.circular(<int>)` yerine bunlar.

### Tipografi
- Bundle'lanmış aileler: gövde `PlusJakartaSans`, başlık `DMSerifDisplay` — tema üstünden
  ([app_theme.dart](lib/core/theme/app_theme.dart), [app_text.dart](lib/core/theme/app_text.dart)).
  `google_fonts` kullanılmıyor.
- Ham `Text` + manuel `TextStyle` yerine semantic widget'lar: `GeneralBodyTitle`,
  `GeneralContentTitle`, `GeneralContentSubTitle`, `GeneralContentSmallTitle`.

### Bileşenler
- Buton: `GeneralButtonV2.active()` / `.async()`. Input: `CustomTextFormField`.
- Önce [lib/product/widget/](lib/product/widget/) kataloğuna bak; yeniden implement etme.

### Tema
- light / dark / system → `AppProviderState.theme`. `MaterialApp.router` hem `theme` hem `darkTheme` alır.

---

## 7. Localization
- `LocaleKeys.*.tr()` (`easy_localization`). Hardcoded UI string **yasak**.
- Çeviriler `assets/translations/{tr,en}.json`; key üretimi `lang` script'i ile
  `lib/product/init/language/locale_keys.g.dart`.
- Not: TR bir metni kodda ararken literal yerine **locale key**'i ara.

---

## 8. Kod kalitesi & codegen

- Lint: `very_good_analysis` ([analysis_options.yaml](analysis_options.yaml)) —
  `prefer_single_quotes`, `sort_constructors_first`, `always_declare_return_types`,
  `prefer_const_constructors`, `avoid_print`. **Üretilen dosyalar exclude DEĞİL** — commit
  edilmedikleri için `flutter analyze` onların generator'ıyla uyumsuz kalmasını yakalayan
  tek kapı. Lint gürültüsü `--no-fatal-infos --no-fatal-warnings` ile CI'ı düşürmez.
- `final class` tercih edilir; `const` mümkün olan her yerde; trailing comma çok satırlı literallerde.
- **Yorum politikası**: narration/bölüm-ayracı yorum yok. Sadece public API'de `///`, ve yalnızca aşikar
  olmayan mantıkta satır içi yorum. Kod isimlendirmeyle kendini anlatır.
- Codegen: `flutter pub run build_runner build --delete-conflicting-outputs`
  (veya pubspec script'leri: `dartBuild`, `watch`, `general`). l10n: `lang` script'i.
- **Üretilen dosyalar commit edilmez** (`*.g.dart`, `*.gen.dart`, `*.freezed.dart`) — gitignore'da.
  Klonladıktan sonra codegen çalıştırmak zorunludur, aksi halde proje derlenmez.
  Otorite `pubspec.lock`'tur: o da commit edilir, böylece üretilen kod ile paket sürümü
  hiçbir makinede ayrışmaz.

---

## 9. Web

Flutter Web hedefi PR #522 ile eklendi. Mobil davranış web yüzünden
değişmez; fark yalnızca aşağıdaki katmanlarda ele alınır.

### Platform ayrımı (sert kural — yeni kod)

- **Yeni çağrı yerinde platform kontrolü yok**: yeni yazılan view, viewmodel ve
  feature servislerinde `kIsWeb`, `dart:io`, `Platform.isX`, `dart:html`
  kullanılmaz.
- Fark `lib/product/` (gerekirse `lib/core/`) altında bir sözleşme + aynı isimli
  `<isim>_io.dart` / `<isim>_web.dart` çiftiyle ayrılır. İki tarafta da sınıf adı
  aynıdır (`PlatformX`), çağrı yeri conditional import kullanır:
  ```dart
  import 'x_io.dart' if (dart.library.js_interop) 'x_web.dart';
  ```
  `dart:io`, `dart:isolate`, `dart:js_interop` ve `package:web` yeni kodda
  yalnızca bu `_io`/`_web` dosyalarında import edilir.
- **Mevcut istisnalar / bekliyor**: bu kural yeni koddan önce yazılmış dosyaları
  bağlamaz; §3'teki toplu migrasyon yapılmama politikası burada da geçerlidir —
  bir dosyaya zaten dokunuyorsan çevirmek serbest, taramaya çıkıp mevcut
  dosyaları toplu değiştirmek değil. `File` için `dart:io` import eden ~37
  mevcut dosya (view, viewmodel, model, widget ve yardımcılar; form, community, merchant, foto/dosya seçici
  akışları — örn. `merchant_application_view.dart`,
  `group_wall_view_model.dart`) bu kuraldan öncedir, **bekliyor (WEB-40, #513)**.
  Aynı kapsamda `photo_picker_manager.dart`'taki `Platform.isAndroid` ve
  `firebase_analytics_service.dart`'taki `kIsWeb` de mevcut istisnalardır.
  `google_sign_in_service.dart` ve `apple_sign_in_service.dart` `dart:io`
  import eder ama ihlal değildir: yalnızca `sign_in_strategy_io.dart` üzerinden
  erişilirler, io tarafının bir parçasıdırlar. `firebase_options.dart` üretilmiş
  dosyadır, kapsam dışıdır.
- Referans dosyalar: [app_check_initialize.dart](lib/product/init/app_check/app_check_initialize.dart),
  [error_handler_binder.dart](lib/product/init/error_handler/error_handler_binder.dart),
  [hive_home_path.dart](lib/product/feature/cache/hive_v2/home_path/hive_home_path.dart),
  [device_id_reader.dart](lib/product/utility/device/device_id_reader.dart),
  [sign_in_strategy.dart](lib/core/service/auth/sign_in_strategy/sign_in_strategy.dart).
- Yeni sözleşmeler varsayılan olarak en az 2 üyeyle yazılır. `app_check_initialize.dart`,
  `error_handler_binder.dart`, `hive_home_path.dart` ve `device_id_reader.dart` önceden
  var olan tek üyeli sözleşmelerdir; bunlardan yalnızca `app_check_initialize.dart`'ta
  `// ignore: one_member_abstracts` yorumu yoktur, diğer üçü bu yorumu zaten taşır.
  Tek üyeli bir sözleşme kaçınılmazsa bu örüntü izlenip
  `// ignore: one_member_abstracts` eklenir.
- Facade ifadesinin (io'ya özgü olmayıp yalnızca runtime'da web'de patlayan
  plugin'ler için tek noktadan kontrol) kesin şekli **bekliyor (WEB-42, #512)**.

### Web'de no-op / desteklenmeyen akışlar

| Akış | Web davranışı | Ticket |
|---|---|---|
| Crashlytics | Geçici no-op, hata raporlanmıyor | WEB-35 (bekliyor) |
| App Check | No-op, reCAPTCHA v3 anahtarı bekleniyor | ticket yok |
| FCM topic aboneliği | Desteklenmiyor | WEB-26 (bekliyor) |
| InAppWebView | Kısıtlı, iframe tabanlı (`web/index.html`'e eklenen `web_support.js`) | WEB-27 (#499, bekliyor) |
| Google Maps | Desteklenmiyor | WEB-24 (bekliyor) |
| PDF görüntüleme (syncfusion) | Desteklenmiyor | ticket yok |
| Foto kırpma (image_cropper) | Web ayarları eksik | WEB-40 (bekliyor) |

### Routing

- Path URL stratejisi aktif (`usePathUrlStrategy`, [application_init.dart](lib/product/init/application_init.dart)).
- Guard'lı rotalara §5'teki kural gereği daima `go`; web'de önemi daha büyük çünkü
  tarayıcının adres çubuğu, geri/ileri tuşu ve yenilemesi yalnızca declarative
  location'ı görür.
- `push` ile açılan sayfalar URL'e yansımaz — bilinçli, henüz çözülmedi.
- Yenilemede (cold load) `product` init'i bitmemişse üst düzey `redirect`
  ([router_notifier.dart](lib/product/navigation/router_notifier.dart)) her rotayı
  `SplashRoute(from: <orijinal URL>)`'a yönlendirir; splash `_resume` önce auth
  `AuthInitial`'dan çıkmayı (en fazla 20 sn), sonra redirect tamamlanmasını
  (`completeRedirectSignIn()`, en fazla 20 sn) bekler — en kötü ihtimalle toplam
  ~40 sn ([splash_view_mixin.dart](lib/features/splash/splash_view_mixin.dart)),
  ardından `from` konumuna `Router.neglect` ile geri döner. Onboarding
  gerekiyorsa veya force-update tetiklenirse bu akış hiç çalışmaz, `from`
  düşer. Mobilde `from` hep null kalır, davranış değişmez.
- `$extra` ile taşınan zorunlu parametreli rotalar tarayıcı yenilemesinde açılamaz
  (`$extra` URL'de yok). Yeni rotalarda zorunlu id'ler path parametresine konur.

### Layout

- Web'de uygulama şu an pencerenin tam genişliğinde çizilir. Masaüstü için sabit
  genişlikli kabuk **bekliyor (WEB-10, #497)**; sheet/dialog/overlay'lerin kabuk
  içinde kalması buna bağlıdır, **bekliyor (WEB-13, #491)**.
- §6'daki `context.sized.dynamicHeight/Width(...)` önerisi için yeni bir yasak
  henüz kesinleşmedi — **bekliyor (WEB-12)**.

### Auth (web)

- Giriş `signInWithPopup` ile yapılır (Google'da `prompt=select_account`, Apple'da
  `email`+`name` scope'ları); buton tıklaması ile `signInWithPopup` çağrısı arasında
  `await` yoktur (Safari popup engelleyicisi).
- Yalnızca `popup-blocked` hata kodunda `signInWithRedirect`'e düşülür; 5 sn
  beklenip buton serbest bırakılır.
- Redirect sonucu yalnızca splash `_resume` içinde `completeRedirectSignIn()` ile
  tamamlanır (auth stream'iyle yarışmasın diye); hata state'e yazılmaz, tek seferlik
  snackbar gösterilir.
- Tarayıcıya özel hata kodları yalnızca [sign_in_strategy_web.dart](lib/core/service/auth/sign_in_strategy/sign_in_strategy_web.dart)
  içinde eşlenir (`unauthorized-domain` → `providerDisabled`, depolama/ortam
  hataları → `unsupported`); paylaşılan `SignInErrorMapper`'a dokunulmaz.
- `AuthService.supports(provider)` Apple butonunun görünürlüğünü servis üzerinden
  belirler; iOS'ta kural aynı kalır, web'de Apple butonu görünür.
- iOS/Android davranışı birebir aynı kalır: giriş sırası, hata eşlemeleri,
  analytics, çıkış.
- **Bekliyor (WEB-30, #502)**: Apple butonu web'de görünür ama Apple Web (Services ID,
  return URL) henüz doğrulanmadı. `authDomain` (`savehatay.firebaseapp.com`,
  [firebase_options.dart](lib/firebase_options.dart)) uygulamanın çalıştığı
  origin'den farklı olduğu için üçüncü taraf depolamayı bölen tarayıcılarda
  (Safari ITP, Firefox TCP) `signInWithRedirect` sonrası `getRedirectResult()`
  `null` dönebilir ve kullanıcı sessizce `/login`'e düşer; bu da doğrulanmadı.

### Geliştirme

- `flutter run -d chrome`. Sabit bir `--web-port` henüz yok — **bekliyor (WEB-30)**;
  port seçilince Google OAuth JS origin ve Storage CORS allowlist'lerine de
  eklenmesi gerekir.
- `main`'e açılan PR'larda CI ([analyze.yml](.github/workflows/analyze.yml))
  `flutter build web --release` çalıştırır; başka bir base branch'e açılan PR'larda
  bu adım tetiklenmez.
- Tarayıcı testleri `flutter test --platform chrome` ile koşulur.

---

## 10. Skill'ler

İş tipine göre `.claude/skills/`:

| İş | Skill |
|---|---|
| Yeni feature / sayfa (viewmodel+state+view) | `hata-feature` |
| Tema/renk/font/spacing — UI tasarım sistemi | `hata-style-guide` |
| Genel mimari uygunluk kontrolü | `hata-architecture-review` |
| PR / diff / branch review | `hata-pr-review` |
| GitHub issue → plan → çözüm | `hata-issue` |

Derin mimari/konvansiyon denetimi `hata-architecture-reviewer` subagent'ına devredilir.
