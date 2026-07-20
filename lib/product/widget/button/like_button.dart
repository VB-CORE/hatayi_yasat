import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:like_button/like_button.dart';

final class CustomAnimatedLikeButton extends StatelessWidget {
  const CustomAnimatedLikeButton({
    required this.isLiked,
    this.size = 24,
    this.likeBuilder,
    this.onTap,
    super.key,
  });

  final bool isLiked;
  final double size;
  final Widget Function(bool isLiked)? likeBuilder;
  final Future<bool?> Function(bool isLiked)? onTap;

  Color get fromColor => AppColors.coral400;
  Color get toColor => AppColors.coral600;

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: size,
      circleColor: CircleColor(start: fromColor, end: toColor),
      isLiked: isLiked,
      likeCountPadding: EdgeInsets.zero,
      animationDuration: const Duration(milliseconds: 800),
      bubblesColor: BubblesColor(
        dotPrimaryColor: fromColor,
        dotSecondaryColor: toColor,
      ),
      likeBuilder: likeBuilder,
      onTap: onTap,
    );
  }
}
