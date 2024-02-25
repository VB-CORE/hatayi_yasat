import 'package:flutter/material.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';

final class GeneralShadow extends BoxShadow {
  GeneralShadow.sampleGrayShadow()
      : super(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: AppConstants.kOne.toDouble(),
          blurRadius: AppConstants.kFour.toDouble(),
          offset: Offset(
            kZero,
            AppConstants.kThree.toDouble(),
          ), // changes position of shado
        );
}
