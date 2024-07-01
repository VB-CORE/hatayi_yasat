import 'package:flutter/material.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/widget/shadow/general_shadow.dart';

class BoxDecorations extends BoxDecoration {
  ///Circular border radius. Value = 16
  BoxDecorations.circularMedium({required Color borderColor, super.color})
      : super(
          borderRadius: CustomRadius.large,
          border: Border.all(color: borderColor),
        );

  BoxDecorations.tourismPlaceCard({
    Color color = Colors.white,
    double radius = 24,
  }) : super(
          color: color,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: const [
            GeneralShadow.tourismPlaceCard(),
          ],
        );
}
