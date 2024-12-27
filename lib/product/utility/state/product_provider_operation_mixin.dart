import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/product/feature/cache/cache_manager.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/app_cache_model.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/store_model_cache.dart';
import 'package:lifeclient/product/init/firebase_custom_service.dart';
import 'package:lifeclient/product/model/regional_city_model.dart';
import 'package:lifeclient/product/utility/state/items/product_provider_state.dart';

mixin ProductProviderOperationMixin on StateNotifier<ProductProviderState> {
  late CacheOperation<StoreModelCache> storeModelCache;
  late CacheOperation<AppCacheModel> appModelCache;

  List<RegionalCityModel> _regionalCities = [];
  late RegionalCityModel _selectedCity;

  List<RegionalCityModel> get regionalCities => _regionalCities;
  RegionalCityModel get selectedCity => _selectedCity;

  final _firebaseService = FirebaseCustomService();

  /// save selected city
  /// [city] is selected city
  void saveSelectedCity(RegionalCityModel city) {
    _selectedCity = city;
    state = state.copyWith(selectedCity: city);
  }

  Future<void> initWhenApplicationStart() async {
    final productCache = ProjectDependencyItems.productCache;
    await Future.wait([
      fetchDistrictAndSaveSession(),
      fetchDevelopersAndAgency(),
      fetchCategories(),
      fetchRegionalCities(),
      productCache.init(),
    ]);

    storeModelCache = productCache.storeModelCache;
    appModelCache = productCache.appModelCache;
    state = state.copyWith(
      favoritePlaces:
          storeModelCache.getAll().map((e) => e.storeModel).toList(),
    );
  }

  Future<void> fetchDistrictAndSaveSession() async {
    final items = await _firebaseService.getList<TownModel>(
      model: TownModel(),
      path: CollectionPaths.towns,
    );
    state = state.copyWith(townItems: items);
  }

  Future<void> fetchDevelopersAndAgency() async {
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

  Future<void> fetchCategories() async {
    final items = await _firebaseService.getList(
      model: const CategoryModel.empty(),
      path: CollectionPaths.categories,
    );
    items.sort((a, b) => a.value > b.value ? 1 : -1);
    state = state.copyWith(categoryItems: items);
  }

  Future<void> fetchRegionalCities() async {
    final items = await _firebaseService.getList(
      model: const RegionalCityModel.empty(),
      path: CollectionPaths.regionalCities,
    );
    _selectedCity = items.firstWhere((element) => element.initial == true);
    _regionalCities = items;
    state = state.copyWith(
      regionalCityItems: items,
      selectedCity: _selectedCity,
    );
  }
}
