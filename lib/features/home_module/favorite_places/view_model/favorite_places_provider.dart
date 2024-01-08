import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/core/dependency/project_dependency_mixin.dart';
import 'package:vbaseproject/features/home_module/favorite_places/view_model/favorite_places_state.dart';

class FavoritePlacesProvider extends StateNotifier<FavoritePlacesState>
    with ProjectDependencyMixin {
  FavoritePlacesProvider()
      : super(
          FavoritePlacesState.initial(),
        );

  Future<void> initAndGetFavoritePlaces() async {
    state = state.copyWith(isLoading: true);
    getFavoritePlaces();
  }

  void getFavoritePlaces() {
    state = state.copyWith(
      isLoading: false,
      // favoritePlaces: favorites,
    );
  }
}
