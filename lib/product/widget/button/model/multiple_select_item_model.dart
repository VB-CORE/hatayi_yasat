import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'multiple_select_item_model.g.dart';

@JsonSerializable()
final class MultipleSelectItem extends Equatable {
  const MultipleSelectItem({required this.title, required this.id});

  factory MultipleSelectItem.fromJson(Map<String, dynamic> json) =>
      _$MultipleSelectItemFromJson(json);

  final String title;
  final String id;

  @override
  List<Object?> get props => [title, id];

  Map<String, dynamic> toJson() => _$MultipleSelectItemToJson(this);
}
