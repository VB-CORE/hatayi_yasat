import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

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
    this.titleTrailing,
  });

  final String pageTitle;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final EdgeInsetsGeometry? actionsPadding;
  final Widget? leading;
  final Widget? titleTrailing;

  @override
  Widget build(BuildContext context) {
    final hasLeading =
        leading != null || (automaticallyImplyLeading && context.canPop());

    return AppBar(
      title: titleTrailing == null
          ? Text(pageTitle.tr())
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(pageTitle.tr()),
                const EmptyBox.smallWidth(),
                titleTrailing!,
              ],
            ),
      titleSpacing: hasLeading ? 0 : null,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      actions: actions,
      actionsPadding: actionsPadding,
      leading: leading,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(WidgetSizes.spacingXSs),
        child: Divider(height: AppConstants.kOne.toDouble()),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + WidgetSizes.spacingXSs);
}
