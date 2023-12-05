import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/widget/general/general_content_sub_title.dart';

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
      child: GeneralContentSubTitle(
        value: title.tr(),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
