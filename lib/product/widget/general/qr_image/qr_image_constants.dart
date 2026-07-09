import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:qr_flutter/qr_flutter.dart';

abstract final class QrImageConstants {
  const QrImageConstants._();

  static const sizeFactor = 0.70;
  static const embeddedSizeRatio = 0.25;
  static const defaultExportSize = 512.0;
  static const int errorCorrectionLevel = QrErrorCorrectLevel.M;
  static const QrEyeShape eyeShape = QrEyeShape.circle;
  static const QrDataModuleShape dataModuleShape = QrDataModuleShape.circle;
  static const ui.Color moduleColor = AppColors.navy;

  static ImageProvider get embeddedImageProvider =>
      Assets.icons.icApp.provider();
}
