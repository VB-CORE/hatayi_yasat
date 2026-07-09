import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/widget/general/qr_image/qr_image_constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

final class QrImageExporter {
  const QrImageExporter._();

  static Future<Uint8List?> toImageBytes(
    String data, {
    double exportSize = QrImageConstants.defaultExportSize,
  }) async {
    try {
      final embeddedImage = await _loadEmbeddedImage();
      if (embeddedImage == null) return null;

      final embeddedSize = exportSize * QrImageConstants.embeddedSizeRatio;

      final painter = QrPainter(
        data: data,
        version: QrVersions.auto,
        gapless: true,
        errorCorrectionLevel: QrImageConstants.errorCorrectionLevel,
        embeddedImage: embeddedImage,
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size(embeddedSize, embeddedSize),
        ),
        eyeStyle: const QrEyeStyle(
          color: QrImageConstants.moduleColor,
          eyeShape: QrImageConstants.eyeShape,
        ),
        dataModuleStyle: const QrDataModuleStyle(
          color: QrImageConstants.moduleColor,
          dataModuleShape: QrImageConstants.dataModuleShape,
        ),
      );

      final byteData = await painter.toImageData(exportSize);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      CustomLogger.showError<dynamic>(e);
      return null;
    }
  }

  static Future<ui.Image?> _loadEmbeddedImage() async {
    try {
      final stream = QrImageConstants.embeddedImageProvider.resolve(
        ImageConfiguration.empty,
      );
      final completer = Completer<ui.Image?>();

      late ImageStreamListener listener;
      listener = ImageStreamListener(
        (info, _) {
          stream.removeListener(listener);
          completer.complete(info.image);
        },
        onError: (error, stackTrace) {
          stream.removeListener(listener);
          CustomLogger.showError<dynamic>(error);
          completer.complete(null);
        },
      );

      stream.addListener(listener);
      return completer.future;
    } catch (e) {
      CustomLogger.showError<dynamic>(e);
      return null;
    }
  }
}
