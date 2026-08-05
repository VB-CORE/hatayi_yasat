import 'dart:async';

import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_event.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/provider/filter_search_state.dart';
import 'package:lifeclient/product/widget/button/model/multiple_select_item_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_search_provider.g.dart';

@riverpod
final class FilterWithSearch extends _$FilterWithSearch
    with ProjectDependencyMixin {
  @override
  FilterSearchState build() => const FilterSearchState();

  void logFilterApplied() {
    unawaited(
      analyticsService.logEvent(
        AnalyticsEvent.filterApply,
        parameters: {
          AnalyticsParameter.categoryCount: state.selectedCategories.length,
          AnalyticsParameter.townCount: state.selectedTowns.length,
        },
      ),
    );
  }

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
