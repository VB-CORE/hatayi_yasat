import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

/// Bir görseli Hero animasyonuyla tam ekran açar; zoom destekler.
///
/// Kaynak widget aynı [heroTag] ile bir [Hero] içine sarılmalıdır.
/// [imageFile] verilirse yerel dosya, verilmezse [imageUrl] gösterilir.
@immutable
final class HeroPhotoViewPage extends StatelessWidget {
  const HeroPhotoViewPage({
    required this.heroTag,
    this.imageUrl,
    this.imageFile,
    super.key,
  });

  final Object heroTag;
  final String? imageUrl;
  final File? imageFile;

  static const double _maxScale = 3;
  static const double _minScale = 1;
  static const double _barrierOpacity = 0.9;

  static Future<void> show(
    BuildContext context, {
    required Object heroTag,
    String? imageUrl,
    File? imageFile,
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder<void>(
        opaque: false,
        barrierColor: AppColors.navy900.withValues(alpha: _barrierOpacity),
        pageBuilder: (context, animation, secondaryAnimation) =>
            HeroPhotoViewPage(
              heroTag: heroTag,
              imageUrl: imageUrl,
              imageFile: imageFile,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Center(
                child: Hero(
                  tag: heroTag,
                  child: InteractiveViewer(
                    maxScale: _maxScale,
                    minScale: _minScale,
                    child: imageFile != null
                        ? Image.file(imageFile!)
                        : CustomNetworkImage(imageUrl: imageUrl),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(AppIcons.close, color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
