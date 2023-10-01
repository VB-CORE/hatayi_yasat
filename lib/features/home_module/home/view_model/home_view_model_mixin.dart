import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/home_module/home/view_model/home_state.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/widget/sheet/operation/town_category_operation.dart';

mixin HomeViewModelMixin on StateNotifier<HomeState> {
  List<StoreModel> filterWithResult(
    TownCategoryModel value,
    List<StoreModel> allItems,
  ) {
    if (value.town == null && value.category == null) return allItems;

    return allItems.where((element) {
      if (value.town == null) return true;
      if (value.town?.code == kErrorNumber.toInt()) return true;
      return element.townCode == value.town?.code;
    }).where((element) {
      if (value.category == null) return true;
      if (value.category?.value == kErrorNumber.toInt()) return true;
      return element.category?.value == value.category?.value;
    }).toList();
  }
}
