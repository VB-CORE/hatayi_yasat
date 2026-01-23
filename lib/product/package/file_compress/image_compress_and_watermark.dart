import 'dart:io';
import 'dart:typed_data';

import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/feature/path_operation/custom_path_manager.dart';
import 'package:lifeclient/product/package/image_manipulation/image_manipulation.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

final class ImageCompressAndWaterMark {
  ImageCompressAndWaterMark(this.storeModel);

  final ScreenshotController _screenshotController = ScreenshotController();
  ScreenshotController get screenshotController => _screenshotController;
  File? _screenShot;

  final StoreModel storeModel;

  Future<File?> _makeFile(Uint8List response, StoreModel model) async {
    final customPathManager = CustomPathManager();
    final file = await customPathManager.writeByteToFile(
      response,
      '${model.name}-${model.documentId}.png',
    );
    if (file == null) return null;
    final bytes = await file.readAsBytes();
    final compressFile =
        await FileCompress(bytes).compressByteFile(quality: FileQualities.low);
    if (compressFile == null) return null;
    await file.writeAsBytes(compressFile);

    final imageWithWatermark =
        await ImageManipulation.instance.addWatermark(file: file);
    return imageWithWatermark;
  }

  Future<void> capture() async {
    final response = await screenshotController.capture();
    if (response == null) return;
    _screenShot = await _makeFile(response, storeModel);
  }

  Future<void> share() async {
    if (_screenShot == null) return;
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(_screenShot!.path)],
        subject: '${storeModel.name}${storeModel.description}',
      ),
    );
  }
}
