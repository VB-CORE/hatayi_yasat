import 'package:flutter/material.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';

final class GeneralShadow extends BoxShadow {
  GeneralShadow.sampleGrayShadow()
      : super(
          color: Colors.grey.withValues(alpha: .5),
          spreadRadius: AppConstants.kOne.toDouble(),
          blurRadius: AppConstants.kFour.toDouble(),
          offset: Offset(
            kZero,
            AppConstants.kThree.toDouble(),
          ),
        );

  const GeneralShadow.tourismPlaceCard()
      : super(
          color: Colors.black12,
          blurRadius: 10,
          spreadRadius: 2,
          offset: const Offset(0, 3),
        );
}
