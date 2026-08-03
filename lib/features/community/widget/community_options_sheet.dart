import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

enum CommunityOptionAction { delete }

final class CommunityOptionsSheet extends StatelessWidget {
  const CommunityOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const EmptyBox.smallHeight(),
          _CommunityOptionTile(
            icon: AppIcons.delete,
            label: LocaleKeys.community_deleteOption.tr(),
            color: context.general.colorScheme.error,
            onTap: () =>
                Navigator.of(context).pop(CommunityOptionAction.delete),
          ),
          const EmptyBox.smallHeight(),
        ],
      ),
    );
  }
}

final class _CommunityOptionTile extends StatelessWidget {
  const _CommunityOptionTile({
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
