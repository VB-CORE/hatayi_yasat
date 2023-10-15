import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:vbaseproject/product/utility/decorations/colors_custom.dart';

class ButtonLargeText extends StatelessWidget {
  const ButtonLargeText({
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
        mobile: context.general.textTheme.titleLarge,
        tablet: context.general.textTheme.headlineLarge,
        desktop: context.general.textTheme.headlineLarge,
      )?.copyWith(
        fontWeight: FontWeight.bold,
        color: ColorsCustom.white,
      ),
    );
  }
}
