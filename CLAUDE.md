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
│   ├── <feature>_view_model.g.dart    # üretilen (commit edilir)
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
[place_detail_view_model.dart](lib/features/details/view_model/place_detail_view_model.dart).

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
`app_router.g.dart` (commit edilir). Referans: [app_router.dart](lib/product/navigation/app_router.dart).

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
- Responsive: `context.sized.dynamicHeight/Width(...)` (mevcut kullanım).

### Radius
- `CustomRadius.*` ([custom_radius.dart](lib/product/utility/decorations/custom_radius.dart)):
  `small`(8) / `medium`(12) / `large`(16) / `extraLarge`(24) / `xxLarge`(32). Ham `BorderRadius.circular(<int>)` yerine bunlar.

### Tipografi
- Roboto, `GoogleFonts.robotoTextTheme` tema üstünden ([application_theme.dart](lib/product/init/application_theme.dart)).
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
  `prefer_const_constructors`, `avoid_print`. Üretilen dosyalar exclude.
- `final class` tercih edilir; `const` mümkün olan her yerde; trailing comma çok satırlı literallerde.
- **Yorum politikası**: narration/bölüm-ayracı yorum yok. Sadece public API'de `///`, ve yalnızca aşikar
  olmayan mantıkta satır içi yorum. Kod isimlendirmeyle kendini anlatır.
- Codegen: `flutter pub run build_runner build --delete-conflicting-outputs`
  (veya pubspec script'leri: `dartBuild`, `watch`, `general`). l10n: `lang` script'i.

---

## 9. Skill'ler

İş tipine göre `.claude/skills/`:

| İş | Skill |
|---|---|
| Yeni feature / sayfa (viewmodel+state+view) | `hata-feature` |
| Tema/renk/font/spacing — UI tasarım sistemi | `hata-style-guide` |
| Genel mimari uygunluk kontrolü | `hata-architecture-review` |
| PR / diff / branch review | `hata-pr-review` |
| GitHub issue → plan → çözüm | `hata-issue` |

Derin mimari/konvansiyon denetimi `hata-architecture-reviewer` subagent'ına devredilir.
