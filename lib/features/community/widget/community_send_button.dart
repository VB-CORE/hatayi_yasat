import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

@immutable
final class CommunitySendButton extends StatelessWidget {
  const CommunitySendButton({required this.onTap, super.key});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyLeft(),
      child: IconButton.filled(
        onPressed: onTap,
        style: IconButton.styleFrom(
          backgroundColor: AppColors.coral,
          disabledBackgroundColor: AppColors.ink100,
          foregroundColor: AppColors.white,
          disabledForegroundColor: AppColors.ink400,
        ),
        icon: const Icon(AppIcons.send, size: AppIconSizes.xMedium),
      ),
    );
  }
}
