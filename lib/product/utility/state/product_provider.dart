import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/core/dependency/project_dependency_items.dart';
import 'package:vbaseproject/product/feature/cache/hive_v2/hive_opeartion_manager.dart';
import 'package:vbaseproject/product/feature/cache/hive_v2/model/store_model_cache.dart';
import 'package:vbaseproject/product/init/firebase_custom_service.dart';
import 'package:vbaseproject/product/utility/state/items/product_provider_state.dart';

final class ProductProvider extends StateNotifier<ProductProviderState> {
  ProductProvider() : super(const ProductProviderState());

  final _firebaseService = FirebaseCustomService();

  late HiveOperationManager<StoreModelCache> storeModelCache;

  Future<void> initWhenApplicationStart() async {
    final productCache = ProjectDependencyItems.productCache;
    await Future.wait([
      fetchDistrictAndSaveSession(),
      fetchDevelopersAndAgency(),
      fetchCategories(),
      productCache.init(),
    ]);

    storeModelCache = productCache.storeModelCache;
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
}
