import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/title/general_content_small_title.dart';

@immutable
final class GeneralStatusBadge extends StatelessWidget {
  const GeneralStatusBadge({
    required this.label,
    required this.color,
    this.icon,
    super.key,
  });

  final String label;
  final Color color;
  final IconData? icon;

  static const double _backgroundOpacity = 0.12;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: _backgroundOpacity),
        borderRadius: CustomRadius.xxLarge,
      ),
      child: Padding(
        padding: const PagePadding.horizontalLowVerticalVeryLowSymmetric(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: AppIconSizes.smallX, color: color),
              const EmptyBox(width: WidgetSizes.spacingXxs),
            ],
            GeneralContentSmallTitle(
              value: label,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
