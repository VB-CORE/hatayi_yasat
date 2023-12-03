import 'package:flutter/material.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/widget/size/index.dart';

/// SizedBox height 0 for vertical space
final class GeneralSpaceVertical extends SizedBox {
  const GeneralSpaceVertical({
    super.key,
  }) : super(height: kZero);

  /// 8px
  const GeneralSpaceVertical.small({
    super.key,
  }) : super(height: WidgetSizes.spacingXs);

  /// 16px
  const GeneralSpaceVertical.medium({
    super.key,
  }) : super(height: WidgetSizes.spacingM);
}
