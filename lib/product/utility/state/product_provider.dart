import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/hive_opeartion_manager.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/app_cache_model.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/store_model_cache.dart';
import 'package:lifeclient/product/init/firebase_custom_service.dart';
import 'package:lifeclient/product/model/constant/project_general_constant.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/state/items/product_provider_state.dart';

final class ProductProvider extends StateNotifier<ProductProviderState> {
  ProductProvider() : super(const ProductProviderState());

  final _firebaseService = FirebaseCustomService();

  late HiveOperationManager<StoreModelCache> storeModelCache;
  late HiveOperationManager<AppCacheModel> appModelCache;

  Future<void> initWhenApplicationStart() async {
    final productCache = ProjectDependencyItems.productCache;
    await Future.wait([
      fetchDistrictAndSaveSession(),
      fetchDevelopersAndAgency(),
      fetchCategories(),
      productCache.init(),
    ]);

    storeModelCache = productCache.storeModelCache;
    appModelCache = productCache.appModelCache;
    state = state.copyWith(
      favoritePlaces:
          storeModelCache.getAll().map((e) => e.storeModel).toList(),
    );
  }

  bool get isHomeViewGrid =>
      appModelCache.get(AppCacheModel.appModelId)?.isHomeViewGrid ?? true;

  void saveLatestGridViewType({required bool isSelected}) {
    appModelCache.add(AppCacheModel(isHomeViewGrid: isSelected));
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

  void saveCampaigns(List<CampaignModel> campaignItems) {
    state = state.copyWith(campaignItems: campaignItems);
  }

  String fetchTownFromCode(int? code) {
    if (code == null) return '';
    return state.townItems
            .firstWhereOrNull(
              (element) => element.code == code,
            )
            ?.name ??
        '';
  }

  void addOrRemoveFavoritePlace(StoreModel store) {
    if (state.favoritePlaces
        .any((element) => element.documentId == store.documentId)) {
      storeModelCache.delete(StoreModelCache(storeModel: store));
    } else {
      storeModelCache.add(StoreModelCache(storeModel: store));
    }

    state = state.copyWith(
      favoritePlaces:
          storeModelCache.getAll().map((e) => e.storeModel).toList(),
    );
  }

  /// It clears all favorite places from local storage
  ///
  /// And deselects favorite icon in GeneralPlaceCard
  bool removeAllFavoritePlaces() {
    final isAllFavoritePlacesRemoved = storeModelCache.removeAll();
    if (isAllFavoritePlacesRemoved) {
      state = state.copyWith(favoritePlaces: []);
    }

    return isAllFavoritePlacesRemoved;
  }

  List<String> get lastSearchItems =>
      appModelCache.get(AppCacheModel.appModelId)?.lastSearchItems ?? [];
  void saveLastSearch(String searchTerm) {
    final appCacheModel =
        appModelCache.get(AppCacheModel.appModelId) ?? const AppCacheModel();

    final currentItems = appCacheModel.lastSearchItems.toList();
    if (currentItems.contains(searchTerm)) return;

    if (currentItems.length >= ProjectGeneralConstant.maxLatestSearchCount) {
      currentItems.removeAt(kZero.toInt());
    }
    currentItems.add(searchTerm);
    appModelCache.add(AppCacheModel(lastSearchItems: currentItems));
  }

  void clearLastSearch() {
    final appCacheModel = appModelCache.get(AppCacheModel.appModelId);
    if (appCacheModel == null) return;
    appModelCache.removeAll();
  }
}
