import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/home_module/home_detail/models/favorite_place_model.dart';
import 'package:vbaseproject/product/feature/cache/cache_service_by_list.dart';
import 'package:vbaseproject/product/widget/button/favorite_button/favorite_place_state.dart';

class FavoritePlaceProvider extends StateNotifier<FavoritePlaceState> {
  FavoritePlaceProvider({required this.cacheService})
      : super(
          const FavoritePlaceState(isLoading: false, isFavorite: false),
        );

  final CacheServiceByList<FavoritePlaceModel> cacheService;

  Future<void> initAndCheckFavoritePlace(
    FavoritePlaceModel favoritePlace,
  ) async {
    state = state.copyWith(isLoading: true);
    await cacheService.init();
    checkFavoritePlace(favoritePlace);
  }

  Future<bool> onSaved(FavoritePlaceModel favoritePlace) async {
    if (state.isFavorite) {
      await _removeFavoritePlace(favoritePlace);
      return false;
    }
    await _setFavoritePlace(favoritePlace);
    return true;
  }

  void checkFavoritePlace(FavoritePlaceModel favoritePlace) {
    final place = cacheService.getItemFromList(
      (item) => item.name == favoritePlace.name,
    );

    state = state.copyWith(
      isFavorite: place != null,
      isLoading: false,
    );
  }

  Future<void> _setFavoritePlace(FavoritePlaceModel favoritePlace) async {
    state = state.copyWith(isLoading: true);
    final isAdded = await cacheService.addItemToList(favoritePlace);
    state = state.copyWith(isFavorite: isAdded, isLoading: false);
  }

  Future<void> _removeFavoritePlace(FavoritePlaceModel favoritePlace) async {
    state = state.copyWith(isLoading: true);
    final isRemoved = await cacheService.removeItemFromList(
      (item) => item.name == favoritePlace.name,
    );

    state = state.copyWith(isFavorite: !isRemoved, isLoading: false);
  }
}
