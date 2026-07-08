import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/widget/general/title/general_body_small_title.dart';

@immutable
final class RequiredLabel extends StatelessWidget {
  const RequiredLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GeneralBodySmallTitle(label),
        const GeneralBodySmallTitle(' *', color: AppColors.coral),
      ],
    );
  }
}
