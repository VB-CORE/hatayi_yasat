import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/core/dependency/project_dependency_mixin.dart';
import 'package:vbaseproject/product/feature/cache/hive_v2/hive_opeartion_manager.dart';
import 'package:vbaseproject/product/feature/cache/hive_v2/model/store_model_cache.dart';
import 'package:vbaseproject/product/widget/button/favorite_button/favorite_place_state.dart';

class FavoritePlaceProvider extends StateNotifier<FavoritePlaceState>
    with ProjectDependencyMixin {
  FavoritePlaceProvider({required this.cacheService})
      : super(
          const FavoritePlaceState(isLoading: false, isFavorite: false),
        );

  final HiveOperationManager<StoreModelCache> cacheService;

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
}
