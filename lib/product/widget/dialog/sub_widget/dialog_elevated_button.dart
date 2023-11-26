import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';
import 'package:vbaseproject/product/utility/decorations/custom_radius.dart';

final class DialogElevatedButton extends StatelessWidget {
  const DialogElevatedButton({
    required this.onPressed,
    required this.title,
    super.key,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: AppConstants.kZero.toDouble(),
        shape: RoundedRectangleBorder(
          borderRadius: CustomRadius.small,
          side: BorderSide(
            color: context.general.colorScheme.primary,
            width: AppConstants.kOne.toDouble(),
          ),
        ),
      ),
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
