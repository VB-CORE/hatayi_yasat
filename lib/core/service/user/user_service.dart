import 'dart:io';

abstract interface class UserService {
  Future<bool> update({required String displayName, String? photoUrl});
  Future<String?> uploadPhoto(File file);
  Future<bool> addRate(String id);
  Future<bool> removeRate(String id);
}
