import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/widget/dialog/force_update_dialog.dart';

final class PhotoViewDialog extends StatelessWidget with CustomDialog {
  const PhotoViewDialog({
    required this.imageUrl,
    super.key,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: const PagePadding.allVeryLow(),
      titlePadding: const EdgeInsets.all(AppSpacing.sm),
      actionsPadding: EdgeInsets.zero,
      actionsAlignment: MainAxisAlignment.center,

      title: InteractiveViewer(
        minScale: 1,
        maxScale: 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          child: CustomNetworkImage(
            imageUrl: imageUrl,
          ),
        ),
      ),
    );
  }

  @override
  Future<void> show(BuildContext context) {
    return showNormalDialog(context, barrierDismissible: true);
  }
}
