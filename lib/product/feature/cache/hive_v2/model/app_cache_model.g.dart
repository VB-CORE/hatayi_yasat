// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_cache_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppCacheModel _$AppCacheModelFromJson(Map<String, dynamic> json) =>
    AppCacheModel(
      isHomeViewGrid: json['isHomeViewGrid'] as bool? ?? false,
      lastSearchItems:
          (json['lastSearchItems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AppCacheModelToJson(AppCacheModel instance) =>
    <String, dynamic>{
      'isHomeViewGrid': instance.isHomeViewGrid,
      'lastSearchItems': instance.lastSearchItems,
    };
