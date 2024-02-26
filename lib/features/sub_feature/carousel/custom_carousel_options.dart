import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/utility/constants/duration_constant.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

final class CustomCarouselOptions extends CarouselOptions {
  ///Advertisement slider options
  ///
  /// * height: optional (Default 64)
  /// * duration: 1 seconds
  /// * curve: easeOut
  /// * autoPlay: true
  CustomCarouselOptions.advertisement({double? height})
      : super(
          height: height ?? WidgetSizes.spacingXxl8 + WidgetSizes.spacingXxs,
          autoPlayAnimationDuration: DurationConstant.durationNormal,
          autoPlayCurve: Curves.easeOut,
          autoPlay: true,
        );
}
