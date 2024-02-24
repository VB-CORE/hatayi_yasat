import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vbaseproject/product/feature/cache/hive_v2/cache_manager.dart';

part 'app_cache_model.g.dart';

@JsonSerializable()
final class AppCacheModel with CacheModel, EquatableMixin {
  const AppCacheModel({
    this.isHomeViewGrid = false,
  });

  factory AppCacheModel.fromJson(Map<String, dynamic> json) {
    return _$AppCacheModelFromJson(json);
  }

  static const String appModelId = 'app_model_cache';

  final bool isHomeViewGrid;

  @override
  List<Object> get props => [id];

  @override
  CacheModel fromDynamicJson(json) {
    if (json is! Map<String, dynamic>) throw Exception('Invalid json type');
    return AppCacheModel.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$AppCacheModelToJson(this);

  @override
  String get id => appModelId;
}
