import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/widget/general/title/general_body_title.dart';

@immutable
final class GeneralSwitchTile extends StatelessWidget {
  const GeneralSwitchTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const PagePadding.horizontalNormalSymmetric() +
          const PagePadding.vertical12Symmetric(),
      child: Row(
        spacing: AppSpacing.sm,
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.appColors.coral50,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            padding: const PagePadding.allLow(),
            child: Icon(
              icon,
              size: AppIconSizes.medium,
              color: context.appColors.coral500,
            ),
          ),
          Expanded(
            child: GeneralBodyTitle(label, textAlign: TextAlign.start),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: context.general.colorScheme.tertiary,
          ),
        ],
      ),
    );
  }
}
