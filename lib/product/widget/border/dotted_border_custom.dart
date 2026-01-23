import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/common/color_common.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';

class DottedBorderCustom extends StatelessWidget {
  const DottedBorderCustom({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: ColorCommon(context).whiteAndBlackForTheme,
        radius: context.border.normalRadius,
        dashPattern: const [3, 6],
        strokeCap: StrokeCap.square,
      ),
      child: ClipRRect(
        borderRadius: CustomRadius.medium,
        child: child,
      ),
    );
  }
}
