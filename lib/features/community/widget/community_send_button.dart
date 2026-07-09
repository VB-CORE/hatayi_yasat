import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

/// Composer'larda kullanılan dairesel coral gönder butonu.
@immutable
final class CommunitySendButton extends StatelessWidget {
  const CommunitySendButton({
    required this.onTap,
    this.isEnabled = true,
    super.key,
  });

  final VoidCallback? onTap;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyLeft(),
      child: InkWell(
        onTap: isEnabled ? onTap : null,
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
