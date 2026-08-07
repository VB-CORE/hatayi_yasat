import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/widget/general/index.dart';

@immutable
class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageAppBar({
    required this.pageTitle,
    super.key,
    this.actions,
    this.centerTitle = false,
    this.automaticallyImplyLeading = true,
    this.actionsPadding,
    this.leading,
    this.backgroundColor,
    this.showDivider = true,
  });

  final String pageTitle;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final EdgeInsetsGeometry? actionsPadding;
  final Widget? leading;
  final Color? backgroundColor;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final hasLeading =
        leading != null || (automaticallyImplyLeading && context.canPop());

    return AppBar(
      title: GeneralContentTitle(
        value: pageTitle.tr(),
        fontWeight: FontWeight.w500,
      ),
      titleSpacing: hasLeading ? 0 : null,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      actions: actions,
      actionsPadding: actionsPadding,
      leading: leading,
      backgroundColor: backgroundColor,
      bottom: showDivider
          ? PreferredSize(
              preferredSize: const Size.fromHeight(WidgetSizes.spacingXSs),
              child: Divider(height: AppConstants.kOne.toDouble()),
            )
          : null,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + WidgetSizes.spacingXSs);
}
