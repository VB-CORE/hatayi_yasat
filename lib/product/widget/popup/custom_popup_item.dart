part of '../appbar/custom_popup_menu_app_bar.dart';

final class _CustomPopupMenuItem extends PopupMenuItem {
  _CustomPopupMenuItem({
    required BuildContext context,
    required String itemLabel,
    required Widget destination,
  }) : super(
          child: GeneralContentSubTitle(
            value: itemLabel.tr(),
            fontWeight: FontWeight.bold,
          ),
          onTap: () => context.route.navigateToPage(destination),
        );
}
