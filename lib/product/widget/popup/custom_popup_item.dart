part of '../appbar/custom_app_bar.dart';

final class _CustomPopupMenuItem extends PopupMenuItem {
  _CustomPopupMenuItem({
    required BuildContext context,
    required String itemLabel,
    required Widget destination,
  }) : super(
          child: Text(itemLabel).tr(),
          onTap: () => context.route.navigateToPage(destination),
        );
}
