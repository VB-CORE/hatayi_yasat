import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

@immutable
final class CommunitySendButton extends StatelessWidget {
  const CommunitySendButton({required this.onTap, super.key});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Padding(
      padding: const PagePadding.onlyLeft(),
      child: IconButton.filled(
        onPressed: onTap,
        style: IconButton.styleFrom(
          backgroundColor: colorScheme.tertiary,
          disabledBackgroundColor: colorScheme.outline,
          foregroundColor: colorScheme.onTertiary,
          disabledForegroundColor: colorScheme.onSurfaceVariant,
        ),
        icon: const Icon(AppIcons.send, size: AppIconSizes.xMedium),
      ),
    );
  }
}
