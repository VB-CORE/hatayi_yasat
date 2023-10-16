import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/home_module/home_detail/models/favorite_place_model.dart';
import 'package:vbaseproject/product/feature/cache/shared_cache.dart';
import 'package:vbaseproject/product/widget/button/favorite_button/favorite_place_state.dart';

class FavoritePlaceProvider extends StateNotifier<FavoritePlaceState> {
  FavoritePlaceProvider()
      : super(
          const FavoritePlaceState(isLoading: false, isFavorite: false),
        );

  Future<void> onPressed(FavoritePlaceModel favoritePlace) async {
    await (state.isFavorite
        ? _removeFavoritePlace(favoritePlace)
        : _setFavoritePlace(favoritePlace));
  }

  void checkFavoritePlaceByName(String name) {
    state = state.copyWith(
      isFavorite: SharedCache.instance.isFavoritePlace(name),
    );
  }

  Future<void> _setFavoritePlace(FavoritePlaceModel favoritePlace) async {
    state = state.copyWith(isLoading: true);
    final isAdded = await SharedCache.instance.setFavoritePlace(favoritePlace);
    state = state.copyWith(isFavorite: isAdded, isLoading: false);
  }

  Future<void> _removeFavoritePlace(FavoritePlaceModel favoritePlace) async {
    state = state.copyWith(isLoading: true);
    final isRemoved = await SharedCache.instance.removeFromFavorites(
      favoritePlace,
    );

    state = state.copyWith(isFavorite: !isRemoved, isLoading: false);
  }
}
