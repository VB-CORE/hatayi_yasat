import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/extension/index.dart';
import 'package:lifeclient/product/widget/sheet/town_category_sheet.dart';

@immutable
final class TownCategoryModel {
  const TownCategoryModel({
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
    _selectedTown = _getInitialTownWithCodeControl();
    _selectedCategory = _getInitialCategoryWithValueControl();
    _checkValidate();
  }

  CategoryModel? _getInitialCategoryWithValueControl() {
    return widget.initialItem?.category?.value == kErrorNumber.toInt()
        ? null
        : widget.initialItem?.category;
  }

  TownModel? _getInitialTownWithCodeControl() {
    return widget.initialItem?.town?.code == kErrorNumber.toInt()
        ? null
        : widget.initialItem?.town;
  }

  TownCategoryModel get selectedTownCategory => TownCategoryModel(
        town: _selectedTown ?? CategoryExtension.emptyAllTown,
        category: _selectedCategory ?? CategoryExtension.emptyAll,
      );

  final _emptyTownCategory = const TownCategoryModel(
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
