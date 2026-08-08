import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:shimmer/shimmer.dart';

final class NotificationsSkeletonList extends StatelessWidget {
  const NotificationsSkeletonList({super.key});

  static const int _itemCount = AppConstants.kFive;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.appColors.ink100,
      highlightColor: context.appColors.ink25,
      child: ListView.separated(
        padding:
            const PagePadding.horizontal16Symmetric() +
            const PagePadding.onlyTopMedium(),
        itemCount: _itemCount,
        separatorBuilder: (context, index) => const EmptyBox.middleHeight(),
        itemBuilder: (context, index) => const _SkeletonTile(),
      ),
    );
  }
}

final class _SkeletonTile extends StatelessWidget {
  const _SkeletonTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: context.sized.dynamicHeight(.05)),
      padding: const PagePadding.all(),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: CustomRadius.medium,
        border: Border.all(color: context.appColors.ink100),
      ),
      child: Row(
        spacing: AppSpacing.md,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SkeletonBlock(
            width: AppConstants.kForty,
            height: AppConstants.kForty,
            radius: CustomRadius.medium,
          ),
          Expanded(
            child: Column(
              spacing: AppSpacing.xs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SkeletonBlock(
                  width: double.infinity,
                  height: context.sized.dynamicHeight(.017),
                  radius: CustomRadius.small,
                ),
                _SkeletonBlock(
                  width: context.sized.dynamicWidth(.15),
                  height: context.sized.dynamicHeight(.012),
                  radius: CustomRadius.small,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _SkeletonBlock extends StatelessWidget {
  const _SkeletonBlock({
    required this.width,
    required this.height,
    required this.radius,
  });

  final double width;
  final double height;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.appColors.ink200,
        borderRadius: radius,
      ),
      child: SizedBox(width: width, height: height),
    );
  }
}
