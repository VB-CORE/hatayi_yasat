import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/widget/dialog/force_update_dialog.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';

final class PhotoViewDialog extends StatelessWidget with CustomDialog {
  const PhotoViewDialog({required this.imageUrl, super.key});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: const PagePadding.allVeryLow(),
      title: InteractiveViewer(
        maxScale: 3,
        minScale: 1,
        child: CustomNetworkImage(
          imageUrl: imageUrl,
        ),
      ),
      titlePadding: EdgeInsets.zero +
          const PagePadding.horizontal16Symmetric() +
          const PagePadding.onlyTopNormalMedium(),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.zero,
      actions: [
        GeneralDialogButton(
          onPressed: () {
            context.pop();
          },
          title: LocaleKeys.button_close,
        ),
      ],
    );
  }

  @override
  Future<void> show(BuildContext context) {
    return showNormalDialog(context, barrierDismissible: true);
  }
}
