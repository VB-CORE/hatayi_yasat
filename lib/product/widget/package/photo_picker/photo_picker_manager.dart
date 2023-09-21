import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';

import 'package:vbaseproject/product/widget/package/file_compress/file_compress.dart';

enum PhotoPickType {
  gallery,
  camera,
}

final class PhotoPickerManager {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickPhoto({required PhotoPickType type}) async {
    XFile? mediaFile;

    switch (type) {
      case PhotoPickType.gallery:
        mediaFile = await _picker.pickImage(source: ImageSource.gallery);
      case PhotoPickType.camera:
        mediaFile = await _picker.pickImage(source: ImageSource.camera);
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
    if ((await file.exists()) == false) {
      await file.create(recursive: true);
    }
    return file;
  }
}
