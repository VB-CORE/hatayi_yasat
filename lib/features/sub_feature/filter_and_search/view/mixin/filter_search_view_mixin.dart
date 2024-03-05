import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/provider/filter_search_provider.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/view/filter_search_view.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/button/multiple_select_button.dart';

mixin FilterSearchViewMixin
    on ConsumerState<FilterSearchView>, AppProviderMixin<FilterSearchView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedCategoryId = widget.selectedCategoryId;
      if (selectedCategoryId == null) return;

      final category = productState.categoryItems.firstWhereOrNull(
        (element) => element.documentId == selectedCategoryId,
      );

      if (category == null) return;

      ref.read(filterWithSearchProvider.notifier).updateSelectedCategory([
        MultipleSelectItem(title: category.displayName, id: selectedCategoryId),
      ]);
    });
  }
}
