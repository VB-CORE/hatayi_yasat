import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/app_cache_model.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/store_model_cache.dart';
import 'package:lifeclient/product/model/constant/project_general_constant.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/state/items/product_provider_state.dart';
import 'package:lifeclient/product/utility/state/product_provider_operation_mixin.dart';

final class ProductProvider extends StateNotifier<ProductProviderState>
    with ProductProviderOperationMixin {
  ProductProvider() : super(const ProductProviderState());

  bool get isHomeViewGrid =>
      appModelCache.get(AppCacheModel.appModelId)?.isHomeViewGrid ?? true;
  List<String> get lastSearchItems =>
      appModelCache.get(AppCacheModel.appModelId)?.lastSearchItems ?? [];

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

  String fetchTownFromCode(int? code) {
    if (code == null) return '';
    return regionalTowns
            .firstWhereOrNull(
              (element) => element.code == code,
            )
            ?.name ??
        '';
  }

  void saveLatestGridViewType({required bool isSelected}) {
    appModelCache.add(AppCacheModel(isHomeViewGrid: isSelected));
  }

  void saveCampaigns(List<CampaignModel> campaignItems) {
    state = state.copyWith(campaignItems: campaignItems);
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
