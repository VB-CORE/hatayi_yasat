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
    final isEnabled = onTap != null;
    return Padding(
      padding: const PagePadding.onlyLeft(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: CircleAvatar(
          radius: AppIconSizes.medium,
          backgroundColor: isEnabled ? AppColors.coral : AppColors.ink100,
          child: Icon(
            AppIcons.send,
            size: AppIconSizes.xMedium,
            color: isEnabled ? AppColors.white : AppColors.ink400,
          ),
        ),
      ),
    );
  }
}
