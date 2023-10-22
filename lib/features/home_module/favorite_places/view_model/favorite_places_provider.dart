import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/home_module/favorite_places/view_model/favorite_places_state.dart';
import 'package:vbaseproject/features/home_module/home_detail/models/favorite_place_model.dart';
import 'package:vbaseproject/product/feature/cache/cache_service_by_list.dart';

class FavoritePlacesProvider extends StateNotifier<FavoritePlacesState> {
  FavoritePlacesProvider({required this.cacheService})
      : super(
          FavoritePlacesState.initial(),
        );

  final CacheServiceByList<FavoritePlaceModel> cacheService;

  Future<void> initAndGetFavoritePlaces() async {
    state = state.copyWith(isLoading: true);
    await cacheService.init();
    getFavoritePlaces();
  }

  void getFavoritePlaces() {
    final favorites = cacheService.getValue();
    state = state.copyWith(
      isLoading: false,
      favoritePlaces: favorites,
    );
  }
}
