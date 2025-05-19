import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/product/feature/cache/cache_manager.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/app_cache_model.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/store_model_cache.dart';
import 'package:lifeclient/product/init/firebase_custom_service.dart';
import 'package:lifeclient/product/utility/state/items/product_provider_state.dart';

mixin ProductProviderOperationMixin on StateNotifier<ProductProviderState> {
  late CacheOperation<StoreModelCache> storeModelCache;
  late CacheOperation<AppCacheModel> appModelCache;

  List<RegionalCityModel> get regionalCities => state.regionalCityItems;
  List<RegionalTownSubItem> get regionalTowns {
    final selectedCity = state.selectedCity;
    final selectedCityRegionalTown = state.regionalTownItems
        .firstWhere((element) => element.cityId == selectedCity.documentId);
    return selectedCityRegionalTown.towns;
  }

  RegionalCityModel get selectedCity => state.selectedCity;

  final _firebaseService = FirebaseCustomService();

  /// save selected city
  /// [city] is selected city
  void saveSelectedCity(RegionalCityModel city) {
    state = state.copyWith(selectedCity: city);
  }

  Future<void> initWhenApplicationStart() async {
    final productCache = ProjectDependencyItems.productCache;
    await Future.wait([
      _fetchDevelopersAndAgency(),
      _fetchCategories(),
      _fetchRegionalCities(),
      _fetchRegionalTowns(),
      productCache.init(),
    ]);

    storeModelCache = productCache.storeModelCache;
    appModelCache = productCache.appModelCache;
    state = state.copyWith(
      favoritePlaces:
          storeModelCache.getAll().map((e) => e.storeModel).toList(),
    );
  }

  Future<void> _fetchDevelopersAndAgency() async {
    final devItems = await _firebaseService.getList(
      model: DeveloperModel(),
      path: CollectionPaths.developers,
    );
    final agencyItems = await _firebaseService.getList(
      model: SpecialAgencyModel(),
      path: CollectionPaths.specialAgency,
    );
    state = state.copyWith(
      developerItems: devItems,
      agencyItems: agencyItems,
    );
  }

  Future<void> _fetchCategories() async {
    final items = await _firebaseService.getList(
      model: const CategoryModel.empty(),
      path: CollectionPaths.categories,
    );
    items.sort((a, b) => a.value > b.value ? 1 : -1);
    state = state.copyWith(categoryItems: items);
  }

  Future<void> _fetchRegionalCities() async {
    final items = await _firebaseService.getList(
      model: const RegionalCityModel.empty(),
      path: CollectionPaths.regionalCities,
    );

    state = state.copyWith(
      regionalCityItems: items,
      selectedCity: items.firstWhere((element) => element.initial),
    );
  }

  Future<void> _fetchRegionalTowns() async {
    final items = await _firebaseService.getList(
      model: const RegionalTownModel(),
      path: CollectionPaths.regionalTowns,
    );

    state = state.copyWith(
      regionalTownItems: items,
    );
  }
}
