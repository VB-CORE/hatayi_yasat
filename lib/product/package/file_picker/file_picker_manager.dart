import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' hide FileType;
import 'package:lifeclient/product/package/file_picker/default_file_extension.dart';
import 'package:lifeclient/product/package/file_picker/file_extension_enum.dart';

@immutable
final class FilePickerManager {
  const FilePickerManager._();
  static Future<File?> pickFile({
    List<FileExtensionEnum> allowedExtensions =
        DefaultFileExtension.documentExtensionList,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions.map((e) => e.name).toList(),
      );
      if (result == null) return null;
      if (result.files.isEmpty) return null;
      if (result.files.single.path.ext.isNullOrEmpty) return null;
      return File(result.files.single.path!);
    } catch (e) {
      return null;
    }
  }
}
