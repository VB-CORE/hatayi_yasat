import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/package/firebase/filter/category_code_filter.dart';
import 'package:lifeclient/product/package/firebase/filter/town_code_filter.dart';
import 'package:lifeclient/product/widget/button/model/multiple_select_item_model.dart';

final class GeneralCategoryTownFilter {
  GeneralCategoryTownFilter({
    required this.selectedCategories,
    required this.selectedTowns,
  });

  final List<MultipleSelectItem> selectedCategories;
  final List<TownModel> selectedTowns;

  Filter make({
    required List<CategoryModel> categoryItems,
  }) {
    if (selectedCategories.isEmpty && selectedTowns.isEmpty) {
      throw Exception('No filter selected');
    }
    final selectedTownValues = selectedTowns
        .map((e) => e.code)
        .where((element) => element != null)
        .cast<int>()
        .toList();

    final categoriesValue = categoryItems
        .where(
          (element) => selectedCategories.any(
            (selectedElement) => selectedElement.id == element.documentId,
          ),
        )
        .map((e) => e.value)
        .toList();

    if (selectedCategories.isNotEmpty && selectedTowns.isNotEmpty) {
      return Filter.and(
        TownCodeFilter(selectedTownValues),
        CategoryCodeFilter(categoriesValue),
      );
    }

    if (selectedCategories.isNotEmpty) {
      return CategoryCodeFilter(categoriesValue);
    }

    if (selectedTowns.isNotEmpty) return TownCodeFilter(selectedTownValues);

    throw Exception('No filter selected');
  }
}
