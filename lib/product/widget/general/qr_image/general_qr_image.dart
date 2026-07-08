import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/widget/general/qr_image/qr_image_constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

@immutable
final class GeneralQrImage extends StatelessWidget {
  const GeneralQrImage({required this.data, super.key});

  final String data;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final qrSize = context.sized.dynamicWidth(QrImageConstants.sizeFactor);
    final embeddedSize = qrSize * QrImageConstants.embeddedSizeRatio;

    return Container(
      padding: const PagePadding.all(),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: CustomRadius.large,
      ),
      child: ClipRRect(
        borderRadius: CustomRadius.large,
        child: QrImageView(
          data: data,
          size: qrSize,
          embeddedImage: QrImageConstants.embeddedImageProvider,
          embeddedImageStyle: QrEmbeddedImageStyle(
            size: Size(embeddedSize, embeddedSize),
          ),
          errorCorrectionLevel: QrImageConstants.errorCorrectionLevel,
          eyeStyle: QrEyeStyle(
            color: colorScheme.primary,
            eyeShape: QrImageConstants.eyeShape,
          ),
          dataModuleStyle: QrDataModuleStyle(
            color: colorScheme.primary,
            dataModuleShape: QrImageConstants.dataModuleShape,
          ),
          backgroundColor: colorScheme.surface,
        ),
      ),
    );
  }
}
