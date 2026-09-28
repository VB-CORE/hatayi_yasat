import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

final class CloseIconButton extends StatelessWidget {
  const CloseIconButton({this.onPressed, this.color, this.size, super.key});

  final VoidCallback? onPressed;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: LocaleKeys.button_close.tr(),
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
      icon: Icon(AppIcons.close, color: color, size: size),
    );
  }
}
