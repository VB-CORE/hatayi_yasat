import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

enum CommentOptionAction { edit, delete }

final class CommentOptionsSheet extends StatelessWidget {
  const CommentOptionsSheet({super.key});

  static Future<CommentOptionAction?> show(BuildContext context) {
    return showModalBottomSheet<CommentOptionAction>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: CustomRadius.large.topLeft),
      ),
      builder: (context) => const CommentOptionsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const EmptyBox.smallHeight(),
          _OptionTile(
            icon: AppIcons.edit,
            label: LocaleKeys.rate_editComment.tr(),
            onTap: () => Navigator.of(context).pop(CommentOptionAction.edit),
          ),
          const Divider(
            color: ColorsCustom.warmGrey,
          ),
          _OptionTile(
            icon: AppIcons.delete,
            label: LocaleKeys.rate_deleteComment.tr(),
            color: ColorsCustom.imperilRead,
            onTap: () => Navigator.of(context).pop(CommentOptionAction.delete),
          ),
          const EmptyBox.smallHeight(),
        ],
      ),
    );
  }
}

final class _OptionTile extends StatelessWidget {
  const _OptionTile({
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
