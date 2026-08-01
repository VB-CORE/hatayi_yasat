import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';

final class MosaicCollapsingHeaderStyle {
  const MosaicCollapsingHeaderStyle({
    this.heightFactor = .20,
    this.gradient,
    this.padding = const PagePadding.generalAllLow(),
  });

  final double heightFactor;
  final Gradient? gradient;
  final EdgeInsetsGeometry padding;
}
