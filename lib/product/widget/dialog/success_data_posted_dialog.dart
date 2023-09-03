import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/generated/assets.gen.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';

class SuccessDataPostedDialog extends StatelessWidget {
  const SuccessDataPostedDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const SuccessDataPostedDialog();
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
            LocaleKeys.requestCompany_complete,
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
