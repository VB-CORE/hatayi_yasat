import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lifeclient/product/feature/cache/cache_manager.dart';
import 'package:lifeclient/product/model/auth/app_user_model.dart';

part 'user_doc_cache_model.g.dart';

@JsonSerializable()
final class UserDocCacheModel with CacheModel, EquatableMixin {
  const UserDocCacheModel({
    required this.uid,
    this.roleType = 0,
    this.permissions = const [],
  });

  factory UserDocCacheModel.fromJson(Map<String, dynamic> json) {
    return _$UserDocCacheModelFromJson(json);
  }

  factory UserDocCacheModel.fromAppUser(AppUser user) {
    return UserDocCacheModel(
      uid: user.uid,
      roleType: user.roleType.code,
      permissions: user.permissions
          .map((permission) => permission.code)
          .toList(),
    );
  }

  final String uid;
  final int roleType;
  final List<int> permissions;

  @override
  List<Object> get props => [uid, roleType, permissions];

  @override
  UserDocCacheModel fromDynamicJson(dynamic json) {
    if (json is! Map<String, dynamic>) throw Exception('Invalid json type');
    return UserDocCacheModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserDocCacheModelToJson(this);
  }

  @override
  String get id => uid;
}
