import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifeclient/product/model/auth/user/avatar_type.dart';

abstract interface class UserService {
  Future<bool> update({
    String? displayName,
    AvatarType? avatarType,
    FieldValue? rates,
  });
  Future<bool> addRate(String id);
  Future<bool> removeRate(String id);
}
