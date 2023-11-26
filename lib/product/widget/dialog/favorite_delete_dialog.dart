import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/widget/dialog/sub_widget/dialog_elevated_button.dart';
import 'package:vbaseproject/product/widget/dialog/sub_widget/dialog_text_button.dart';

final class FavoriteDeleteDialog extends StatelessWidget {
  const FavoriteDeleteDialog({super.key});

  static Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return const FavoriteDeleteDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.general.colorScheme.secondary,
      content: Text(
        LocaleKeys.favorite_deleteDialog_content.tr(),
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
