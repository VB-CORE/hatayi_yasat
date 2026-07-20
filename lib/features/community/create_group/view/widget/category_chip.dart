import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

@immutable
final class CategoryChip extends StatelessWidget {
  const CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
    super.key,
  });

  final String label;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final appColors = context.appColors;
    final color = isSelected ? colorScheme.onTertiary : appColors.navy400;
    return InkWell(
      onTap: onTap,
      borderRadius: CustomRadius.xxLarge,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.tertiary : appColors.surface,
          borderRadius: CustomRadius.xxLarge,
          border: Border.all(
            color: isSelected ? colorScheme.tertiary : appColors.ink200,
          ),
        ),
        child: Padding(
          padding:
              const PagePadding.horizontal16Symmetric() +
              const PagePadding.vertical8Symmetric(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: AppIconSizes.medium, color: color),
                const EmptyBox.smallWidth(),
              ],
              GeneralContentSubTitle(
                value: label,
                color: color,
                fontWeight: .bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
