import 'dart:io';
import 'dart:typed_data';

import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vbaseproject/product/feature/path_operation/custom_path_manager.dart';
import 'package:vbaseproject/product/model/firebase/store_model.dart';
import 'package:vbaseproject/product/widget/package/file_compress/file_compress.dart';
import 'package:vbaseproject/product/widget/package/image_manipulation/image_manipulation.dart';

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
      '${model.name}-${model.id}.png',
    );
    if (file == null) return null;
    final compressFile =
        await FileCompress(file).compressAndGetFile(Qualities.low);
    final imageWithWatermark =
        await ImageManipulation.instance.addWatermark(file: compressFile);
    return imageWithWatermark;
  }

  Future<void> capture() async {
    final response = await screenshotController.capture();
    if (response == null) return;
    _screenShot = await _makeFile(response, storeModel);
  }

  Future<void> share() async {
    if (_screenShot == null) return;
    await Share.shareXFiles(
      [XFile(_screenShot!.path)],
      subject: '${storeModel.name}${storeModel.description}',
    );
  }
}
