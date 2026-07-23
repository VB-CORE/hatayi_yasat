import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

enum RateCommentOptionAction { edit, delete }

final class RateCommentOptionsSheet extends StatelessWidget {
  const RateCommentOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const EmptyBox.smallHeight(),
          _RateOptionTile(
            icon: AppIcons.edit,
            label: LocaleKeys.rate_editComment.tr(),
            onTap: () =>
                Navigator.of(context).pop(RateCommentOptionAction.edit),
          ),
          const Divider(),
          _RateOptionTile(
            icon: AppIcons.delete,
            label: LocaleKeys.rate_deleteComment.tr(),
            color: context.general.colorScheme.error,
            onTap: () =>
                Navigator.of(context).pop(RateCommentOptionAction.delete),
          ),
          const EmptyBox.smallHeight(),
        ],
      ),
    );
  }
}

final class _RateOptionTile extends StatelessWidget {
  const _RateOptionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color),
      title: GeneralContentSubTitle(value: label, color: color),
    );
  }
}
