import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/product/feature/cache/cache_manager.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/store_model_cache.dart';
import 'package:lifeclient/product/widget/button/favorite_button/favorite_place_state.dart';

class FavoritePlaceProvider extends Notifier<FavoritePlaceState>
    with ProjectDependencyMixin {
  FavoritePlaceProvider({
    required this.cacheService,
    required StoreModel storeModel,
  }) {
    store = storeModel;
  }
  late final StoreModel store;

  final CacheOperation<StoreModelCache> cacheService;


  void initAndCheckFavoritePlace(
    StoreModel favoritePlace,
  ) {
    state = state.copyWith(isLoading: true);
    checkFavoritePlace(favoritePlace);
  }

  Future<bool> onSaved(StoreModel favoritePlace) async {
    productProvider.addOrRemoveFavoritePlace(favoritePlace);

    return true;
  }

  void checkFavoritePlace(StoreModel favoritePlace) {
    final place = cacheService.get(favoritePlace.documentId);

    state = state.copyWith(
      isFavorite: place != null,
      isLoading: false,
    );
  }

  @override
  FavoritePlaceState build() {
    final isFavorite = ref
        .watch(ProjectDependencyItems.productProviderState)
        .favoritePlaces
        .any(
          (element) => element.documentId == store.documentId,
        );

    return FavoritePlaceState(
      isLoading: false,
      isFavorite: isFavorite,
    );
  }
}
