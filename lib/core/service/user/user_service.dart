import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class UserService {
  Future<bool> update({
    String? displayName,
    String? photoUrl,
    FieldValue? rates,
  });
  Future<String?> uploadPhoto(File file);
  Future<bool> addRate(String id);
  Future<bool> removeRate(String id);
}
