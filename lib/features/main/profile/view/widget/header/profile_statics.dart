import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/product/widget/bounceable/bounceable.dart';

final class ProfileStatics extends StatelessWidget {
  const ProfileStatics({
    required this.count,
    required this.label,
    required this.onTap,
    super.key,
  });

  final int count;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomBounceable(
        onTap: onTap,
        child: Padding(
          padding:
              const PagePadding.horizontalVeryLowSymmetric() +
              const PagePadding.verticalVeryLowSymmetric(),
          child: Column(
            spacing: AppSpacing.xxs / 2,
            crossAxisAlignment: .start,
            children: [
              Text(
                '$count',
                style: AppText.displaySm.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                label,
                style: AppText.body.copyWith(color: context.appColors.navy300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
