import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/approve_dialog_type.dart';
import 'package:lifeclient/product/model/enum/platform_exception_enum.dart';
import 'package:lifeclient/product/package/settings/custom_app_settings.dart';
import 'package:lifeclient/product/widget/dialog/approve_dialog.dart';

enum PhotoPickType {
  gallery,
  camera,
}

final class PhotoPickerManager {
  PhotoPickerManager({required this.context});

  final ImagePicker _picker = ImagePicker();
  final BuildContext context;

  Future<File?> pickPhoto({required PhotoPickType type}) async {
    XFile? mediaFile;
    try {
      switch (type) {
        case PhotoPickType.gallery:
          mediaFile = await _picker.pickImage(source: ImageSource.gallery);
        case PhotoPickType.camera:
          mediaFile = await _picker.pickImage(source: ImageSource.camera);
      }
    } on PlatformException catch (e) {
      await _handlePickerError(e.code);
    }
    if (mediaFile == null) return null;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: mediaFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio4x3,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: LocaleKeys.component_picker_cropperTitle.tr(),
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: LocaleKeys.component_picker_cropperTitle.tr(),
        ),
      ],
    );
    if (croppedFile == null) return null;
    final latestFile = File(croppedFile.path);
    final latestFileCompress =
        await FileCompress(await latestFile.readAsBytes()).compressByteFile();
    if (latestFileCompress == null) return null;
    await latestFile.writeAsBytes(latestFileCompress);
    return latestFile;
  }

  Future<File> createFile(String path) async {
    final file = File(path);
    if ((file.existsSync()) == false) {
      await file.create(recursive: true);
    }
    return file;
  }

  Future<void> _handlePickerError(String message) async {
    final type = PlatformExceptionEnum.fromValue(message);

    if (type == null) return;

    /// now only support access denied
    final response = await ApproveDialog.showWithKey(
      context: context,
      type: ApproveDialogType.cameraPermission,
    );

    if (!response) return;
    CustomAppSettings.open(type: CustomAppSettingsType.library_permission);
  }
}
