part of '../app_bar/custom_popup_menu_app_bar.dart';

final class _CustomPopupMenuItem extends PopupMenuItem<dynamic> {
  _CustomPopupMenuItem({
    required String itemLabel,
    required VoidCallback destination,
  }) : super(
          child: GeneralContentSubTitle(
            value: itemLabel.tr(),
            fontWeight: FontWeight.bold,
          ),
          onTap: () => destination,
        );
}
