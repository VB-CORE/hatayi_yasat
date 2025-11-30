// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    SearchResponse(
      name: json['name'] as String,
      id: json['id'] as String,
      image: json['image'] as String? ?? '',
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );
