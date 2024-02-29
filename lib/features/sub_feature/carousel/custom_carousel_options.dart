import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/product/utility/constants/duration_constant.dart';

@immutable
final class CustomCarouselOptions extends CarouselOptions {
  ///Advertisement slider options
  ///
  /// * height: optional (Default 64)
  /// * duration: 1 seconds
  /// * curve: easeOut
  /// * autoPlay: true
  CustomCarouselOptions.advertisement()
      : super(
          autoPlayAnimationDuration: DurationConstant.durationNormal,
          autoPlayCurve: Curves.easeOut,
          autoPlay: true,
          viewportFraction: .85,
          padEnds: false,
        );
}
