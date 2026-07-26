import 'dart:io';
import 'dart:typed_data';

import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:uuid/uuid.dart';

mixin CommunityImageUploadMixin on ProjectDependencyMixin {
  Future<StorageResult<String>> uploadImage(File file) async {
    final Uint8List bytes;
    try {
      bytes = await file.readAsBytes();
    } on FileSystemException catch (error) {
      return FirebaseFailure(StorageError.noFile, message: error.message);
    }
    return storageService.uploadImage(
      root: RootStorageName.groups,
      key: const Uuid().v4(),
      fileBytes: bytes,
    );
  }

  Future<void> discardImage(String? imageUrl) async {
    if (imageUrl == null) return;
    await storageService.deleteAssets(paths: [imageUrl]);
  }
}
