import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';

class NotConnectedToInternetDialog extends StatelessWidget {
  const NotConnectedToInternetDialog({super.key});

  static Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return const NotConnectedToInternetDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(LocaleKeys.networkCheck_title).tr(),
      content: const Text(LocaleKeys.networkCheck_message).tr(),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: const Text(LocaleKeys.networkCheck_button).tr(),
        ),
      ],
    );
  }
}
