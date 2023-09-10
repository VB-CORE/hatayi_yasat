import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:vbaseproject/product/generated/assets.gen.dart';

@immutable
final class ImageManipulation {
  const ImageManipulation._init();
  static ImageManipulation? _instance;
  static ImageManipulation get instance =>
      _instance ??= const ImageManipulation._init();

  /// Adds a watermark to the image.
  Future<File?> addWatermark({required File file}) async {
    final image = img.decodeImage(file.readAsBytesSync());
    // final image = await compute<Uint8List, img.Image?>(img.decodeImage, bytes);
    final watermark = await _getWatermarkImage(image);
    if (image == null || watermark == null) return null;

    /// (target, watermark, center)
    img.compositeImage(image, watermark, center: true);
    final tempDir = Directory.systemTemp;
    final tempImagePath = tempDir.path.withEmptyWaterMark;

    // await compute<MapEntry<String, img.Image>, bool>(
    //   (message) => img.encodePngFile(message.key, message.value),
    //   MapEntry(tempImagePath, image),
    // );
    // await img.encodePngFile(tempImagePath, image);
    File(tempImagePath).writeAsBytesSync(img.encodePng(image));
    return File(tempImagePath);
  }

  /// We resize our watermark image according to the image size to be merged.
  Future<img.Image?> _getWatermarkImage(img.Image? image) async {
    if (image == null) return null;
    final wmFile = await _createFileFromAsset(Assets.icons.icWatermark.path);
    final watermark = await img.decodeImageFile(wmFile.path);
    if (watermark == null) return null;
    final result = img.copyResize(watermark, width: image.width);
    return result;
  }

  /// To read the file from assets and convert it into an image
  Future<File> _createFileFromAsset(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    final tempFile = File('$tempPath/${assetPath.split('/').last}');
    tempFile.writeAsBytesSync(bytes);
    final result = File(tempFile.path);
    return result;
  }
}

extension _StringExt on String {
  String get withEmptyWaterMark {
    return '$this/watermark_result_image.png';
  }
}
