import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';

@immutable
final class AppBarAction extends StatelessWidget {
  const AppBarAction({
    required this.icon,
    required this.onPressed,
    this.title,
    this.backgroundColor = AppColors.coral,
    this.foregroundColor = AppColors.white,
    super.key,
  });

  final String? title;
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    final hasTitle = title != null && title!.isNotEmpty;
    final minimumSize = hasTitle ? Size.zero : const Size(36, 36);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: 0,
        padding: hasTitle
            ? const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              )
            : EdgeInsets.zero,
        minimumSize: minimumSize,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        textStyle: AppText.body.copyWith(
          color: foregroundColor,
          fontWeight: FontWeight.w600,
          height: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.xxs,
        children: [Icon(icon), if (hasTitle) Text(title!)],
      ),
    );
  }
}
