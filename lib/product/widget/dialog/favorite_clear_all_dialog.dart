import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/widget/dialog/sub_widget/dialog_elevated_button.dart';
import 'package:vbaseproject/product/widget/dialog/sub_widget/dialog_text_button.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

final class FavoriteClearAllDialog extends StatelessWidget {
  const FavoriteClearAllDialog({super.key});

  static Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return const FavoriteClearAllDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.general.colorScheme.secondary,
      title: const Icon(
        Icons.warning_amber_outlined,
        size: WidgetSizes.spacingXxl8,
      ),
      content: Text(
        LocaleKeys.favorite_clearAllDialog_content.tr(),
        style: context.general.textTheme.labelLarge,
      ),
      actions: [
        DialogTextButton(
          onPressed: () {
            context.route.pop(false);
          },
          title: LocaleKeys.button_close,
        ),
        DialogElevatedButton(
          onPressed: () {
            context.route.pop(true);
          },
          title: LocaleKeys.button_iAmSure,
        ),
      ],
    );
  }
}
