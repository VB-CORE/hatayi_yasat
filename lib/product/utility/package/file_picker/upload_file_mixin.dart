import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vbaseproject/product/utility/package/file_picker/file_picker_manager.dart';
import 'package:vbaseproject/product/utility/package/file_picker/upload_file_section_widget.dart';

mixin UploadFileMixin on State<UploadFileSectionWidget> {
  File? file;

  Future<void> pickFile() async {
    final allowedExtension = [
      FileExtension.doc,
      FileExtension.docx,
      FileExtension.pdf,
    ];

    final result = await FilePickerManager.pickFile(allowedExtension);
    if (result == null) return;
    updateFile(result);
    widget.onFilePicked(result);
  }

  void updateFile(File file) {
    this.file = file;
    setState(() {});
  }

  String? getNameOfFile() {
    if (file == null) return null;
    final fileName = file!.path.split('/').last;
    return fileName;
  }
}
