import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/enum/approve_dialog_type.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/size/widget_size.dart';

final class ApproveDialog extends StatelessWidget {
  const ApproveDialog({required this.title, super.key});
  final String title;

  static Future<bool?> show({
    required BuildContext context,
    required String title,
  }) async {
    return showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return ApproveDialog(
          title: title,
        );
      },
    );
  }

  static Future<bool> showWithKey({
    required BuildContext context,
    required ApproveDialogType type,
  }) async =>
      await show(context: context, title: type.key) ?? false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      content: Row(
        children: [
          SizedBox.square(
            dimension: WidgetSizes.spacingL,
            child: CircularProgressIndicator(
              color: context.general.colorScheme.primary.withOpacity(.2),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const PagePadding.onlyLeft(),
              child: Text(
                title,
                textAlign: TextAlign.left,
              ).tr(),
            ),
          ),
        ],
      ),
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
