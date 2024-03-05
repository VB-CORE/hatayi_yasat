import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/common/color_common.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';

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
      content: Text(
        LocaleKeys.validation_loseAllData,
        textAlign: TextAlign.center,
        style: context.general.textTheme.bodyLarge?.copyWith(
          color: ColorCommon(context).whiteAndBlackForTheme,
        ),
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
