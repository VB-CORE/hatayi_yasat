import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class UserService {
  Future<bool> update({
    String? displayName,
    int? avatarType,
    FieldValue? rates,
  });
  Future<bool> addRate(String id);
  Future<bool> removeRate(String id);
}
