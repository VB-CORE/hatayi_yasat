import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:lifeclient/product/generated/assets.gen.dart';

@immutable
final class ImageManipulation {
  const ImageManipulation._init();
  static const ImageManipulation _instance = ImageManipulation._init();
  static ImageManipulation get instance => _instance;

  /// Adds a watermark to the image.
  Future<File?> addWatermark({required File file}) async {
    final image = img.decodeImage(file.readAsBytesSync());
    final watermark = await _getWatermarkImage(image);
    if (image == null || watermark == null) return null;
    img.compositeImage(image, watermark, center: true);
    final tempDir = Directory.systemTemp;
    final tempImagePath = tempDir.path.withEmptyWaterMark;
    File(tempImagePath).writeAsBytesSync(img.encodePng(image));
    return File(tempImagePath);
  }

  /// We resize our watermark image according to the image size to be merged.
  Future<img.Image?> _getWatermarkImage(img.Image? image) async {
    if (image == null) return null;
    final vmFile2 = img
        .decodeImage(await _createFileFromBytes(Assets.icons.icWatermark.path));
    if (vmFile2 == null) return null;
    final result = img.copyResize(vmFile2, width: image.width);
    return result;
  }

  Future<Uint8List> _createFileFromBytes(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();
    return bytes;
  }
}

extension _StringExt on String {
  String get withEmptyWaterMark {
    return '$this/watermark_result_image.png';
  }
}
