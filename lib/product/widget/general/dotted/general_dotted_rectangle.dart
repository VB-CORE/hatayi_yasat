import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/utility/decorations/custom_radius.dart';

/// Project dotted rectangle widget
final class GeneralDottedRectangle extends StatelessWidget {
  const GeneralDottedRectangle({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: context.general.colorScheme.primary,
      borderType: BorderType.RRect,
      radius: context.border.normalRadius,
      dashPattern: const [3, 6],
      strokeCap: StrokeCap.square,
      child: ClipRRect(
        borderRadius: CustomRadius.medium,
        child: child,
      ),
    );
  }
}
