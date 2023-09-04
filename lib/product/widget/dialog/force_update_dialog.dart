import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';

class ForceUpdateDialog extends StatelessWidget {
  const ForceUpdateDialog({super.key});

  static Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return const ForceUpdateDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(LocaleKeys.forceUpdate_title).tr(),
      content: const Text(LocaleKeys.forceUpdate_title).tr(),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: const Text(LocaleKeys.forceUpdate_updateButton).tr(),
        ),
      ],
    );
  }
}
