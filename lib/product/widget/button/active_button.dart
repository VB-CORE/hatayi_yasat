import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/decorations/app_colors.dart';

class ActiveButton extends StatelessWidget {
  const ActiveButton({required this.label, required this.onPressed, super.key});
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const PagePadding.generalAllNormal(),
        backgroundColor: AppColors.navy,
      ),
      child: Text(
        label,
        style: context.general.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: onPressed == null
              ? AppColors.navy.withOpacity(0.5)
              : Colors.white,
        ),
      ),
    );
  }
}
