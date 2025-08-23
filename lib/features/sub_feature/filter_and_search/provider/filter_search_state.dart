import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/widget/button/model/multiple_select_item_model.dart';

final class FilterSearchState extends Equatable {
  const FilterSearchState({
    this.selectedCategories = const [],
    this.selectedTowns = const [],
  });

  @override
  List<Object> get props => [
        selectedCategories,
        selectedTowns,
      ];

  int get selectedItemsCount =>
      selectedCategories.length + selectedTowns.length;

  final List<MultipleSelectItem> selectedCategories;
  final List<TownModel> selectedTowns;

  bool get isSelectedItems =>
      selectedCategories.isNotEmpty || selectedTowns.isNotEmpty;

  FilterSearchState copyWith({
    List<MultipleSelectItem>? selectedCategories,
    List<TownModel>? selectedTowns,
  }) {
    return FilterSearchState(
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedTowns: selectedTowns ?? this.selectedTowns,
    );
  }
}
