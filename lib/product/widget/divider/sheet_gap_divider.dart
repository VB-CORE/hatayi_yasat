import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

class SheetGapDivider extends StatelessWidget {
  const SheetGapDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: context.sized.dynamicWidth(.4),
      endIndent: context.sized.dynamicWidth(.4),
      thickness: WidgetSizes.spacingXxs,
    );
  }
}
