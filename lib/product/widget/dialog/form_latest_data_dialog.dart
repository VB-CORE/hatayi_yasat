import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

class FormLatestDataDialog extends StatelessWidget {
  const FormLatestDataDialog({super.key});

  static Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const FormLatestDataDialog();
          },
        ) ??
        true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Icon(
        Icons.warning_amber_outlined,
        size: WidgetSizes.spacingXxl8,
      ),
      content: const Text(
        LocaleKeys.validation_loseAllData,
        textAlign: TextAlign.center,
      ).tr(),
      actions: [
        TextButton(
          onPressed: () {
            context.route.pop(false);
          },
          child: const Text(LocaleKeys.button_close).tr(),
        ),
        ElevatedButton(
          onPressed: () {
            context.route.pop(true);
          },
          child: const Text(LocaleKeys.button_ok).tr(),
        ),
      ],
    );
  }
}
