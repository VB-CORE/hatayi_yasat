import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vbaseproject/product/utility/package/file_picker/file_picker_manager.dart';
import 'package:vbaseproject/product/utility/package/file_picker/upload_file_section_widget.dart';
import 'package:vbaseproject/product/widget/dialog/pdf_preview_dialog.dart';

mixin UploadFileMixin on State<UploadFileSectionWidget> {
  final ValueNotifier<File?> documentFile = ValueNotifier<File?>(null);

  bool isFileNull(File? file) => file == null;
  bool isFileNameNull(File file) => getNameOfFile(file) == null;

  Future<void> pickFile() async {
    final allowedExtension =
        widget.allowedExtension ?? FileExtension.defaultDocumentExtensions;
    final result = await FilePickerManager.pickFile(allowedExtension);
    if (result == null) return;
    updateFile(result);
    widget.onFilePicked(result);
  }

  void updateFile(File file) {
    documentFile.value = file;
  }

  String? getNameOfFile(File file) {
    if (isFileNull(file)) return null;
    final fileName = file.path.split('/').lastOrNull;
    return fileName;
  }

  Future<void> showPdfFilePreview(File fileForPreview) async {
    await PdfPreviewDialog(file: fileForPreview).show(context);
  }
}
