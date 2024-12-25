import 'package:json_annotation/json_annotation.dart';

part 'search_request_model.g.dart';

@JsonSerializable()
final class SearchRequestModel {
  const SearchRequestModel({
    required this.term,
    this.page = 1,
  });

  factory SearchRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SearchRequestModelFromJson(json);
  final String term;
  @JsonKey(defaultValue: 1)
  final int page;

  Map<String, dynamic> toJson() => _$SearchRequestModelToJson(this);
}
