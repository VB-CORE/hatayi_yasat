import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

final class DialogTextButton extends StatelessWidget {
  const DialogTextButton({
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
      child: Text(
        title,
        style: context.general.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ).tr(),
    );
  }
}
