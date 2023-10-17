import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/generated/assets.gen.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';

class SuccessScholarshipPostedDialog extends StatelessWidget {
  const SuccessScholarshipPostedDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const SuccessScholarshipPostedDialog();
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
          const Text(
            LocaleKeys.dialog_completeScholarshipRequest,
            textAlign: TextAlign.center,
          ).tr(),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(LocaleKeys.button_close).tr(),
          ),
        ],
      ),
    );
  }
}
