import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/product/widget/general/title/general_content_sub_title.dart';

final class GeneralGroupSectionHeader extends StatelessWidget {
  const GeneralGroupSectionHeader({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.appColors.ink25,
      child: Padding(
        padding:
            const PagePadding.verticalLowSymmetric() +
            const PagePadding.horizontalNormalSymmetric(),
        child: GeneralContentSubTitle(
          value: label,
          fontWeight: FontWeight.w700,
          color: context.appColors.ink500,
        ),
      ),
    );
  }
}
