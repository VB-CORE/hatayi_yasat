import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';

/// Gold star + rating value, with an optional grey `(reviewCount)`.
///
/// The value is passed in (currently placeholder data via `PlaceMetaMock`)
/// so this widget stays presentation-only.
final class PlaceRatingLabel extends StatelessWidget {
  const PlaceRatingLabel({
    required this.rating,
    this.reviewCount,
    this.iconSize = 15,
    super.key,
  });

  final String rating;
  final int? reviewCount;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star_rounded,
          size: iconSize,
          color: context.appColors.gold300,
        ),
        const SizedBox(width: AppSpacing.xxs),
        Text(
          rating,
          style: AppText.bodySm.copyWith(
            color: context.general.colorScheme.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (reviewCount != null) ...[
          const SizedBox(width: AppSpacing.xxs),
          Text(
            '($reviewCount)',
            style: AppText.caption.copyWith(
              color: context.general.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
