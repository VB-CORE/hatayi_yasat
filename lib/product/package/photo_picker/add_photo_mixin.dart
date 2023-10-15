import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vbaseproject/product/package/photo_picker/dotted_add_photo_button.dart';
import 'package:vbaseproject/product/package/photo_picker/photo_picker_manager.dart';
import 'package:vbaseproject/product/widget/sheet/media_photo_sheet.dart';

mixin AddPhotoMixin on State<DottedAddPhotoButton> {
  File? photoFile;
  Future<File?> _pickImage() async {
    final response = await MediaOrPhoto.openSheet(context);
    if (response == null) return null;
    if (!mounted) return null;
    final file =
        await PhotoPickerManager(context: context).pickPhoto(type: response);
    if (file == null) return null;
    return file;
  }

  Future<void> fetchAndAddNewImage() async {
    final file = await _pickImage();
    if (file == null) return;
    setState(() {
      photoFile = file;
    });
    widget.onSelected(file);
  }
}
