import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_response_model.g.dart';

@JsonSerializable()
final class SearchResponse extends Equatable {
  const SearchResponse({required this.name, required this.id});

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  factory SearchResponse.fromMap(Map<dynamic, dynamic> map) {
    final nameFromMap = map['name']?.toString() ?? '';
    final idFromMap = map['id']?.toString() ?? '';

    return SearchResponse(name: nameFromMap, id: idFromMap);
  }

  final String name;
  final String id;

  @override
  List<Object> get props => [name, id];
}
