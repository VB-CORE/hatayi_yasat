import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/package/custom_network_image.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/dialog/force_update_dialog.dart';

class PhoneZoomDialog extends StatelessWidget with CustomDialog {
  const PhoneZoomDialog({required this.imageUrl, super.key});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: const PagePadding.allLow(),
      title: InteractiveViewer(
        maxScale: 3,
        minScale: 1,
        child: CustomNetworkImage(
          imageUrl: imageUrl,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(LocaleKeys.button_close).tr(),
        ),
      ],
    );
  }

  @override
  Future<void> show(BuildContext context) {
    return showNormalDialog(context, barrierDismissible: true);
  }
}
