// ignore_for_file: use_setters_to_change_properties

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/package/file_picker/default_file_extension.dart';
import 'package:vbaseproject/product/package/file_picker/file_picker_manager.dart';
import 'package:vbaseproject/product/package/file_picker/upload_file_section_widget.dart';
import 'package:vbaseproject/product/widget/dialog/pdf_preview_dialog.dart';

mixin UploadFileMixin on State<UploadFileSectionWidget> {
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
    await PdfPreviewDialog(file: fileForPreview).show(context);
  }
}
