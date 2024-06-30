import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_response_model.g.dart';

@JsonSerializable()
final class SearchResponse extends Equatable {
  const SearchResponse({
    required this.name,
    required this.id,
    required this.image,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return _$SearchResponseFromJson(json);
  }

  final String name;
  final String id;
  final String image;

  @override
  List<Object> get props => [name, id, image];
}
