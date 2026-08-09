import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/widget/general/title/index.dart';

/// Centred icon + title + description shown when a list has no content.
///
/// [action] hangs an optional call-to-action below the description.
final class EmptyStateView extends StatelessWidget {
  const EmptyStateView({
    required this.icon,
    required this.title,
    required this.description,
    required this.iconBackgroundColor,
    required this.iconColor,
    this.action,
    super.key,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color iconBackgroundColor;
  final Color iconColor;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppSpacing.sm,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const PagePadding.allNormal(),
              child: Icon(
                icon,
                size: AppIconSizes.large,
                color: iconColor,
              ),
            ),
          ),
          GeneralContentTitle(value: title),
          GeneralContentSubTitle(
            value: description,
            textAlign: TextAlign.center,
          ),
          ?action,
        ],
      ),
    );
  }
}
