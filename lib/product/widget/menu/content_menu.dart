import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_shadows.dart';
import 'package:lifeclient/product/widget/menu/content_menu_item.dart';

export 'package:lifeclient/product/widget/menu/content_menu_item.dart';

final class ContentMenu extends StatelessWidget {
  const ContentMenu({
    required this.items,
    this.iconColor = AppColors.coral500,
    this.iconBackgroundColor = AppColors.coral50,
    super.key,
  });

  final List<ContentMenuItem> items;
  final Color iconColor;
  final Color iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.navy50),
        boxShadow: AppShadows.card,
      ),
      padding: const PagePadding.allLow(),
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            if (index > 0) const Divider(color: AppColors.navy50),
            ContentMenuItemTile(
              item: items[index],
              iconColor: iconColor,
              iconBackgroundColor: iconBackgroundColor,
            ),
          ],
        ],
      ),
    );
  }
}
