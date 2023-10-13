import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' hide FileType;

enum FileExtension { pdf, doc, docx }

@immutable
final class FilePickerManager {
  static Future<File?> pickFile(List<FileExtension> allowedExtensions) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions.map((e) => e.name).toList(),
    );
    if (result == null) return null;
    if (result.files.isEmpty) return null;
    if (result.files.single.path.ext.isNullOrEmpty) return null;
    return File(result.files.single.path!);
  }
}
