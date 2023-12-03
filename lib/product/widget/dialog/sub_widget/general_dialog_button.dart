import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// This button is used only for dialog.
final class GeneralDialogButton extends StatelessWidget {
  const GeneralDialogButton({
    required this.onPressed,
    required this.title,
    super.key,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed.call,

      // TODO: Fix => PR birleşince GeneralContentSubTitle widget olarak değiştirilecek.
      child: Text(
        title,
        style: context.general.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ).tr(),
    );
  }
}
