// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_selected_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterSelected _$FilterSelectedFromJson(Map<String, dynamic> json) =>
    FilterSelected(
      selectedCategories: (json['selectedCategories'] as List<dynamic>)
          .map((e) => MultipleSelectItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      selectedTowns: (json['selectedTowns'] as List<dynamic>)
          .map((e) => TownModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FilterSelectedToJson(FilterSelected instance) =>
    <String, dynamic>{
      'selectedCategories': instance.selectedCategories
          .map((e) => e.toJson())
          .toList(),
      'selectedTowns': instance.selectedTowns.map((e) => e.toJson()).toList(),
    };
