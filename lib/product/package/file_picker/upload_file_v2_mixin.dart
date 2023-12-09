import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/package/file_picker/default_file_extension.dart';
import 'package:vbaseproject/product/package/file_picker/file_picker_manager.dart';
import 'package:vbaseproject/product/package/file_picker/upload_file_section_v2.dart';
import 'package:vbaseproject/product/widget/dialog/pdf_preview_dialog_v2.dart';

/// UploadFileV2Mixin is a mixin used for
/// - picking a file using [FilePickerManager]
/// - notifying ui the picked file using [documentFileNotifier]
// TODO: REMOVE V2 AFTER ALL PROJECTS ARE UPDATED
mixin UploadFileV2Mixin on State<UploadFileSectionV2> {
  final ValueNotifier<File?> _documentFileNotifier = ValueNotifier<File?>(null);

  ValueNotifier<File?> get documentFileNotifier => _documentFileNotifier;

  bool isFilePicked(File? file) =>
      file != null && getNameOfFile(file).ext.isNotNullOrNoEmpty;

  Future<void> pickFile() async {
    final allowedExtension =
        widget.allowedExtension ?? DefaultFileExtension.documentExtensionList;
    final result =
        await FilePickerManager.pickFile(allowedExtensions: allowedExtension);
    if (result == null) return;
    updateFile(result);
    widget.onFilePicked(result);
  }

  void updateFile(File file) {
    _documentFileNotifier.value = file;
  }

  String? getNameOfFile(File file) {
    final fileName = file.path.split('/').lastOrNull;
    return fileName;
  }

  Future<void> showPdfFilePreview(File fileForPreview) async {
    await PdfPreviewDialogV2(file: fileForPreview).show(context);
  }
}
