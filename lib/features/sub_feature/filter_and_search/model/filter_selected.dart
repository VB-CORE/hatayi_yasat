import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/widget/button/multiple_select_button.dart';

final class FilterSelected {
  FilterSelected({
    required this.selectedCategories,
    required this.selectedTowns,
  });

  final List<MultipleSelectItem> selectedCategories;
  final List<TownModel> selectedTowns;
}
