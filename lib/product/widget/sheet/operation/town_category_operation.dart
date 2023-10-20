import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/widget/sheet/town_category_sheet.dart';

class TownCategoryModel {
  TownCategoryModel({
    required this.town,
    required this.category,
  });

  final TownModel? town;
  final CategoryModel? category;
}

mixin TownCategoryOperation on ConsumerState<TownCategorySelectSheet> {
  TownModel? _selectedTown;
  CategoryModel? _selectedCategory;
  final ValueNotifier<bool> validationOperate = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _selectedTown = widget.initialItem?.town;
    _selectedCategory = widget.initialItem?.category;
    _checkValidate();
  }

  TownCategoryModel get selectedTownCategory => TownCategoryModel(
        town: _selectedTown,
        category: _selectedCategory,
      );

  final _emptyTownCategory = TownCategoryModel(
    town: null,
    category: null,
  );

  void clear() {
    _selectedTown = null;
    _selectedCategory = null;
    validationOperate.value = false;
    context.route.pop(_emptyTownCategory);
  }

  void updateCategory(CategoryModel category) {
    _selectedCategory = category;
    _checkValidate();
  }

  void updateTown(TownModel townModel) {
    _selectedTown = townModel;
    _checkValidate();
  }

  void _checkValidate() {
    final isValid = _selectedTown != null || _selectedCategory != null;
    if (isValid == validationOperate.value) return;

    validationOperate.value = isValid;
  }
}
