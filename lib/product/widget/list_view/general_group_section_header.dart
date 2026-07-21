import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/widget/general/title/general_content_small_title.dart';

final class GeneralGroupSectionHeader extends StatelessWidget {
  const GeneralGroupSectionHeader({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.ink50,
      child: Padding(
        padding:
            const PagePadding.verticalLowSymmetric() +
            const PagePadding.horizontalNormalSymmetric(),
        child: GeneralContentSmallTitle(
          value: label,
          fontWeight: FontWeight.w600,
          color: AppColors.navy400,
        ),
      ),
    );
  }
}
