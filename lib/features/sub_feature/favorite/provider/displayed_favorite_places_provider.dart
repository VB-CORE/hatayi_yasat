import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/features/sub_feature/favorite/provider/favorite_view_model.dart';
import 'package:lifeclient/product/utility/mixin/store_model_mixin.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'displayed_favorite_places_provider.g.dart';

@riverpod
List<StoreModel> displayedFavoritePlaces(Ref ref) {
  final favoritePlaces = ref
      .watch(ProjectDependencyItems.productProviderState)
      .favoritePlaces;
  final searchWord = ref.watch(
    favoriteViewModelProvider.select((state) => state.searchWord),
  );

  if (searchWord.isEmpty) return favoritePlaces;

  return favoritePlaces
      .where((place) => findByNameOrCompanyName(place, searchWord))
      .toList();
}
