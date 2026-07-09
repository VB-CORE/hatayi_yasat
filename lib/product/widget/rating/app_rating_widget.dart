import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

final class AppRatingWidget extends StatelessWidget {
  const AppRatingWidget({
    required this.isReadOnly,
    this.onRatingUpdate,
    this.value = 0,
    this.itemSize = AppIconSizes.large,
    super.key,
  });
  final bool isReadOnly;
  final double value;
  final ValueChanged<double>? onRatingUpdate;
  final double itemSize;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: itemSize,
      initialRating: value,
      glow: false,
      ignoreGestures: isReadOnly,
      unratedColor: AppColors.ink200,
      itemPadding: const PagePadding.generalIconLowAll(),
      itemBuilder: (context, _) => const Icon(
        AppIcons.star,
        color: AppColors.gold300,
      ),
      onRatingUpdate: (value) => onRatingUpdate?.call(value),
    );
  }
}
