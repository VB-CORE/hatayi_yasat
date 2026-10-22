import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';

/// Drag handle shown at the top of bottom sheets.
final class SheetHandle extends StatelessWidget {
  const SheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: WidgetSizes.spacingXxl3,
      height: WidgetSizes.spacingXxs,
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.ink200,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
    );
  }
}
