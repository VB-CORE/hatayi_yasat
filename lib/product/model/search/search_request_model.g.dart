// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRequestModel _$SearchRequestModelFromJson(Map<String, dynamic> json) =>
    SearchRequestModel(
      term: json['term'] as String,
      page: (json['page'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$SearchRequestModelToJson(SearchRequestModel instance) =>
    <String, dynamic>{'term': instance.term, 'page': instance.page};
