import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vbaseproject/product/utility/package/file_picker/file_picker_manager.dart';
import 'package:vbaseproject/product/utility/package/file_picker/upload_file_section_widget.dart';
import 'package:vbaseproject/product/widget/dialog/pdf_preview_dialog.dart';

mixin UploadFileMixin on State<UploadFileSectionWidget> {
  File? file;

  bool get isFileNull => file == null;
  bool get isFileNameNull => getNameOfFile() == null;

  Future<void> pickFile() async {
    final allowedExtension =
        widget.allowedExtension ?? FileExtension.defaultDocumentExtensions;
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
    final fileName = file!.path.split('/').lastOrNull;
    return fileName;
  }

  Future<void> showPdfFilePreview() async {
    await PdfPreviewDialog(file: file!).show(context);
  }
}
