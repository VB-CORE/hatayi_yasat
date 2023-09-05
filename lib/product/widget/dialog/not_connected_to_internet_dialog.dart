import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/splash/splash_view.dart';
import 'package:vbaseproject/product/generated/assets.gen.dart';

import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/checker/network_checker.dart';
import 'package:vbaseproject/product/utility/navigation/project_navigation.dart';

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
      content: const Text(LocaleKeys.networkCheck_message).tr(),
      actions: [
        TextButton(
          onPressed: () async {
            final result = await NetworkChecker.checkConnection();
            if (!result) return;
            if (!context.mounted) return;
            await context.route.pop(true);
          },
          child: const Text(LocaleKeys.networkCheck_button).tr(),
        ),
      ],
    );
  }
}
