import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/generated/assets.gen.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/package/checker/network_checker.dart';

class NotConnectedToInternetDialog extends StatelessWidget {
  const NotConnectedToInternetDialog({super.key});

  static Future<bool?> show(BuildContext context) async {
    return showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const NotConnectedToInternetDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Assets.lottie.connectionLost.lottie(),
      content: Text(
        LocaleKeys.networkCheck_message,
        style: context.general.textTheme.bodyLarge?.copyWith(
          color: ColorCommon(context).whiteAndBlackForTheme,
        ),
      ).tr(),
      actions: [
        TextButton(
          onPressed: () async {
            final result = await NetworkChecker.checkConnection();
            if (!result) return;
            if (!context.mounted) return;
            await context.route.pop(true);
          },
          child: Text(
            LocaleKeys.networkCheck_button,
            style: context.general.textTheme.labelLarge?.copyWith(
              color: ColorCommon(context).whiteAndBlackForTheme,
            ),
          ).tr(),
        ),
      ],
    );
  }
}
