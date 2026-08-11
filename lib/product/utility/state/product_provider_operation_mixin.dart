import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/product/feature/cache/cache_manager.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/app_cache_model.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/store_model_cache.dart';
import 'package:lifeclient/product/utility/state/items/product_provider_state.dart';

mixin ProductProviderOperationMixin on Notifier<ProductProviderState> {
  late CacheOperation<StoreModelCache> storeModelCache;
  late CacheOperation<AppCacheModel> appModelCache;

  List<RegionalCityModel> get regionalCities => state.regionalCityItems;
  List<RegionalTownSubItem> get regionalTowns {
    final selectedCity = state.selectedCity;
    final selectedCityRegionalTown = state.regionalTownItems.firstWhereOrNull(
      (element) => element.cityId == selectedCity.documentId,
    );
    return selectedCityRegionalTown?.towns ?? const [];
  }

  RegionalCityModel get selectedCity => state.selectedCity;

  CustomFirestoreService get _firestoreService =>
      ProjectDependencyItems.firestoreService;

  /// save selected city
  /// [city] is selected city
  void saveSelectedCity(RegionalCityModel city) {
    state = state.copyWith(selectedCity: city);
  }

  Future<bool> initWhenApplicationStart() async {
    try {
      final productCache = ProjectDependencyItems.productCache;
      await Future.wait([
        _fetchDevelopersAndAgency(),
        _fetchCategories(),
        _fetchRegionalCities(),
        _fetchRegionalTowns(),
      ]);

      if (state.regionalCityItems.isEmpty) return false;

      storeModelCache = productCache.storeModelCache;
      appModelCache = productCache.appModelCache;
      state = state.copyWith(
        favoritePlaces: storeModelCache
            .getAll()
            .map((e) => e.storeModel)
            .toList(),
      );
      return true;
    } on Object catch (error) {
      CustomLogger.showError<void>(error);
      return false;
    }
  }

  Future<void> _fetchDevelopersAndAgency() async {
    final devResult = await _firestoreService.getList(
      model: DeveloperModel(),
      path: CollectionPaths.developers,
    );
    final agencyResult = await _firestoreService.getList(
      model: SpecialAgencyModel(),
      path: CollectionPaths.specialAgency,
    );
    state = state.copyWith(
      developerItems: devResult.dataOrNull ?? [],
      agencyItems: agencyResult.dataOrNull ?? [],
    );
  }

  Future<void> _fetchCategories() async {
    final result = await _firestoreService.getList<CategoryModel>(
      model: const CategoryModel.empty(),
      path: CollectionPaths.categories,
    );
    final items = (result.dataOrNull ?? <CategoryModel>[])
      ..sort((a, b) => a.value > b.value ? 1 : -1);
    state = state.copyWith(categoryItems: items);
  }

  Future<void> _fetchRegionalCities() async {
    final result = await _firestoreService.getList<RegionalCityModel>(
      model: const RegionalCityModel.empty(),
      path: CollectionPaths.regionalCities,
    );
    final items = result.dataOrNull ?? <RegionalCityModel>[];

    final selected =
        items.firstWhereOrNull((element) => element.initial) ??
        items.firstOrNull;
    state = state.copyWith(
      regionalCityItems: items,
      selectedCity: selected ?? state.selectedCity,
    );
  }

  Future<void> _fetchRegionalTowns() async {
    final result = await _firestoreService.getList<RegionalTownModel>(
      model: const RegionalTownModel(),
      path: CollectionPaths.regionalTowns,
    );

    state = state.copyWith(
      regionalTownItems: result.dataOrNull ?? [],
    );
  }
}
