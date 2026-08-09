import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class DiscoverSectionAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const DiscoverSectionAppBar({
    required this.title,
    required this.subtitle,
    required this.accentColor,
    this.actions,
    super.key,
  });

  final String title;
  final String subtitle;

  final Color accentColor;
  final List<Widget>? actions;

  static const double _stripHeight = AppSpacing.xxs;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.appColors.surface,
      surfaceTintColor: context.appColors.surface,
      elevation: WidgetSizes.zero,
      leading: context.canPop()
          ? IconButton(
              onPressed: context.pop,
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              icon: Icon(AppIcons.backIos, color: context.appColors.navy),
            )
          : null,
      titleSpacing: WidgetSizes.zero,
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GeneralContentTitle(value: title.tr()),
          GeneralContentSmallTitle(value: subtitle),
        ],
      ),
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(_stripHeight),
        child: ColoredBox(
          color: accentColor,
          child: const SizedBox(
            height: _stripHeight,
            width: double.infinity,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + _stripHeight);
}
