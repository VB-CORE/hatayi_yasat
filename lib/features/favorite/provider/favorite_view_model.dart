import 'package:life_shared/life_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vbaseproject/core/dependency/project_dependency_mixin.dart';
import 'package:vbaseproject/features/favorite/provider/favorite_state.dart';
import 'package:vbaseproject/product/utility/mixin/store_model_mixin.dart';

part 'favorite_view_model.g.dart';

@riverpod
final class FavoriteViewModel extends _$FavoriteViewModel
    with ProjectDependencyMixin, StoreModelMixin {
  @override
  FavoriteState build() {
    return FavoriteState(
      favoritePlaces: _items,
    );
  }

  List<StoreModel> get _items {
    return productProvider.storeModelCache
        .getAll()
        .map((e) => e.storeModel)
        .toList();
  }

  void removeFavorite(StoreModel model) {
    productProvider.addOrRemoveFavoritePlace(model);

    state = state.copyWith(
      favoritePlaces: _items,
    );

    if (state.searchWord.isEmpty) return;
    searchFavorites(state.searchWord);
  }

  /// It removes all favorite places in Favorites view.
  void removeAllFavoritePlaces() {
    final isAllFavoritePlacesRemoved =
        productProvider.removeAllFavoritePlaces();
    if (isAllFavoritePlacesRemoved) {
      state = state.copyWith(favoritePlaces: _items);
    }
  }

  void searchFavorites(String value) {
    state = state.copyWith(
      searchWord: value,
      filteredPlaces: state.favoritePlaces
          .where(
            (element) => findByNameOrCompanyName(element, value),
          )
          .toList(),
    );
    print(state.filteredPlaces);
  }
}
