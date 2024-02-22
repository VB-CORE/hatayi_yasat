import 'package:life_shared/life_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vbaseproject/features/sub_feature/filter_and_search/provider/filter_search_state.dart';
import 'package:vbaseproject/product/widget/button/index.dart';

part 'filter_search_provider.g.dart';

@riverpod
final class FilterWithSearch extends _$FilterWithSearch {
  @override
  FilterSearchState build() => const FilterSearchState();

  void updateSelectedCategory(List<MultipleSelectItem> items) {
    state = state.copyWith(
      selectedCategories: items,
    );
  }

  void updateSelectedDistrict(TownModel item) {
    final currentItems = state.selectedTowns.toList();

    currentItems.contains(item)
        ? currentItems.remove(item)
        : currentItems.add(item);

    state = state.copyWith(
      selectedTowns: currentItems,
    );
  }

  void clearAllSelection() {
    state = const FilterSearchState();
  }
}
