import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';
import 'package:lifeclient/product/widget/general/title/general_body_title.dart';

/// This widget was prepared using success lottie for successful situations.
/// You can use it by simply sending a title or description.
/// Font size is set to 'titleMedium'.
final class GeneralFormSuccessDialog extends StatelessWidget {
  const GeneralFormSuccessDialog({required this.value, super.key});

  final String value;

  /// Display the dialog on the screen.
  static Future<void> show(
    BuildContext context,
    String value,
  ) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return GeneralFormSuccessDialog(
          value: value,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Assets.lottie.success.lottie(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GeneralBodyTitle(
            value.tr(),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        GeneralDialogButton(
          onPressed: () {
            Navigator.pop(context);
          },
          title: LocaleKeys.button_close,
        ),
      ],
    );
  }
}
