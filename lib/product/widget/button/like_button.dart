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

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: size,
      circleColor: const CircleColor(
        start: AppColors.coral400,
        end: AppColors.coral600,
      ),
      isLiked: isLiked,
      likeCountPadding: EdgeInsets.zero,
      animationDuration: const Duration(milliseconds: 800),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: AppColors.coral400,
        dotSecondaryColor: AppColors.coral600,
      ),
      likeBuilder: likeBuilder,
      onTap: onTap,
    );
  }
}
