import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:lifeclient/product/utility/decorations/app_colors.dart';

class ButtonNormalText extends StatelessWidget {
  const ButtonNormalText({
    required this.title,
    super.key,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: getValueForScreenType<TextStyle?>(
        context: context,
        mobile: context.general.textTheme.titleMedium,
        tablet: context.general.textTheme.titleMedium,
        desktop: context.general.textTheme.titleLarge,
      )?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.navy,
      ),
    );
  }
}
