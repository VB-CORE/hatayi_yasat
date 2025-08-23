import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/widget/button/model/multiple_select_item_model.dart';

part 'filter_selected_model.g.dart';

@JsonSerializable(explicitToJson: true)
final class FilterSelected {
  const FilterSelected({
    required this.selectedCategories,
    required this.selectedTowns,
  });

  factory FilterSelected.fromJson(Map<String, dynamic> json) =>
      _$FilterSelectedFromJson(json);

  final List<MultipleSelectItem> selectedCategories;
  final List<TownModel> selectedTowns;

  Map<String, dynamic> toJson() => _$FilterSelectedToJson(this);
}
