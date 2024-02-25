import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';

class AppRatingWidget extends StatelessWidget {
  const AppRatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: IconSize.smallX.value,
      initialRating: AppConstants.kFive.toDouble(),
      minRating: AppConstants.kFive.toDouble(),
      glow: false,
      itemPadding: const PagePadding.generalIconLowAll(),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        size: IconSize.xSmall.value,
        color: context.general.colorScheme.primary,
      ),
      onRatingUpdate: (value) {},
    );
  }
}
