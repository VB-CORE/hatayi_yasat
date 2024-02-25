import 'package:flutter/material.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';

class BoxDecorations extends BoxDecoration {
  ///Circular border radius. Value = 16
  BoxDecorations.circularMedium({required Color borderColor, super.color})
      : super(
          borderRadius: CustomRadius.large,
          border: Border.all(color: borderColor),
        );
}
