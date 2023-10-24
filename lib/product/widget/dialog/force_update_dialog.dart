import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/common/color_common.dart';
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
      title: Text(
        LocaleKeys.forceUpdate_title,
        style: context.general.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: ColorCommon(context).whiteAndBlackForTheme,
        ),
      ).tr(),
      content: Text(
        LocaleKeys.forceUpdate_message,
        style: context.general.textTheme.labelLarge?.copyWith(
          color: ColorCommon(context).whiteAndBlackForTheme,
        ),
      ).tr(),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: const Text(
            LocaleKeys.forceUpdate_updateButton,
          ).tr(),
        ),
      ],
    );
  }
}

mixin CustomDialog on Widget {
  Future<void> show(BuildContext context);

  Future<T?> showNormalDialog<T>(
    BuildContext context, {
    bool barrierDismissible = false,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return this;
      },
    );
  }
}
