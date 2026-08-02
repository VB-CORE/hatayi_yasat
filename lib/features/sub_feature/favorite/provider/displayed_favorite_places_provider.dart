import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/features/sub_feature/favorite/provider/favorite_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'displayed_favorite_places_provider.g.dart';

@riverpod
List<StoreModel> displayedFavoritePlaces(Ref ref) {
  final favoritePlaces = ref.watch(
    ProjectDependencyItems.productProviderState.select(
      (state) => state.favoritePlaces,
    ),
  );
  final searchWord = ref.watch(
    favoriteViewModelProvider.select((state) => state.searchWord),
  );

  if (searchWord.isEmpty) return favoritePlaces;

  return favoritePlaces
      .where((place) => _findByNameOrCompanyName(place, searchWord))
      .toList();
}

bool _findByNameOrCompanyName(StoreModel model, String value) {
  return model.owner.toLowerCase().contains(value.toLowerCase()) ||
      model.name.toLowerCase().contains(value.toLowerCase());
}
